CREATE
DATABASE snippetbox CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE snippetbox;

create table snippets
(
    id      INTEGER      NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title   VARCHAR(100) NOT NULL,
    content TEXT         NOT NULL,
    created DATETIME     NOT NULL,
    expires DATETIME     NOT NULL
);

create index idx_snippets_created ON snippets (created);

INSERT INTO snippets (title, content, created, expires)
VALUES ('An old silent pond',
        'An old silent pond...\nA frog jumps into the pond,\nsplash! Silence again.\n\n– Matsuo Basho',
        UTC_TIMESTAMP(),
        DATE_ADD(UTC_TIMESTAMP(), INTERVAL 365 DAY));


INSERT INTO snippets (title, content, created, expires)
VALUES ('Over the wintry forest',
        'Over the wintry\nforest, winds howl in rage\nwith no leaves to blow.\n\n– Natsume Soseki',
        UTC_TIMESTAMP(),
        DATE_ADD(UTC_TIMESTAMP(), INTERVAL 365 DAY));

INSERT INTO snippets (title, content, created, expires)
VALUES ('First autumn morning',
        'First autumn morning\nthe mirror I stare into\nshows my father''s face.\n\n– Murakami Kijo',
        UTC_TIMESTAMP(),
        DATE_ADD(UTC_TIMESTAMP(), INTERVAL 7 DAY));

CREATE user web identified by 'pass';

Grant select, insert, update, delete on snippetbox.* to web;

Select * from snippets;

CREATE table sessions (
        token CHAR(43) PRIMARY KEY,
        data BLOB NOT NULL,
        expiry TIMESTAMP(6) NOT NULL
);

CREATE INDEX sessions_expiry_idx ON sessions(expiry);


create table users (
        id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        hashed_password CHAR(60) NOT NULL,
        created DATETIME NOT NULL
);

ALTER TABLE users ADD CONSTRAINT users_uc_email UNIQUE (email);