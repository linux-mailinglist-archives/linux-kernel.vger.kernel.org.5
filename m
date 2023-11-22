Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9C7F4533
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbjKVL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjKVL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:56:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A51A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:56:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-280200949c3so4551699a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700654162; x=1701258962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiNcTvNTiP7VbwUFL5XzEOZ9BBiJvHuVsV8cpSMamnM=;
        b=I20OlXpQ8AXt1A1gxByEvynkkzMv3HjcAwmhsHjMiHP+8EvrSTEHIiucomtRJAjzn2
         yzmtypDPZZ+/z1+IJv2q9c9Wirt0gHYVZ3JWI6esbb3HN8kImBt9vioI+7GgyXD+dCi3
         FjY6RBrppJozlJs7EJ1f/J6VfvmKgVAAdgN4mbJT74MC6je+9SXe3xUU39zVEdz0J8QJ
         01wmrQRUI1oukXHpuNJju3JRq7mQNIQZm2fMNa+TixTKjyu+91Z/KgkBf7+ciHeAfPuC
         b1qsExEh6gO6In3QumM7pzY7lieiuwgj30n3IqvLRJ3gn8iDEH5gDZDaKNXkL+0l43My
         381w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700654162; x=1701258962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiNcTvNTiP7VbwUFL5XzEOZ9BBiJvHuVsV8cpSMamnM=;
        b=vXLYhMysjeWJQ2USTfeJEkk2S6tWhk+N9MauCELIyajE5YIN9I3eSCcntZLE2aZNnt
         KuO4UsVLwVk4qz0BPeuU8rJYoFZq+8RR1jsGnEOFZYZTh1DajPXY98rBOIOTjqhCxHzC
         liUnrlCDFiWQ73+SZIHTt/ExoiaGpZ1z97L42tu+f/AeRfHV/4GTszo7ZLs/s4FBlH8U
         I1kJ2p9PFeC8GEXgwWGZVypnUUFss0apAEmzEgcu32e+cBxmlzHaWi///c+qxlS5+m+o
         PQbpxNTdzglW74ox5BLHLNLv1wsBQkRDM1iOmPG6FROutJ8UeTRu2bMFKKXpEIBqkuBt
         bIaw==
X-Gm-Message-State: AOJu0YxWD/+nBER7tbLt6vD6vVqjlGpITsm6Q2uR2+v0q58YRbxTDYXq
        fLlAKirOdXZm19R7ihFrchT07U09H2POIatt46k=
X-Google-Smtp-Source: AGHT+IHBnET7z4Y8NACRjYOd4f0oaRGvFIygIIguIJwQZpq0vGN9I9tfVbc5KH8obpdBh0m+WmNtJzSGEwXIscLpxgs=
X-Received: by 2002:a17:90b:17ca:b0:280:1df1:cbc7 with SMTP id
 me10-20020a17090b17ca00b002801df1cbc7mr2085974pjb.19.1700654161937; Wed, 22
 Nov 2023 03:56:01 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Wed, 22 Nov 2023 19:55:50 +0800
Message-ID: <CABOYnLyCRyK4qpS2X8ssA6yxCDtEWR3dSsee2Lm6VCQUyD07VQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] general protection fault in joydev_connect
To:     "syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com" 
        <syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have reproduced this bug with repro.txt and repro.c below:

repro.txt
r0 =3D openat$uinput(0xffffffffffffff9c, &(0x7f0000000500), 0x802, 0x0)
ioctl$UI_DEV_SETUP(r0, 0x405c5503, &(0x7f0000000080)=3D{{0x0, 0xffff,
0x3}, 'syz0\x00'})
ioctl$UI_DEV_CREATE(r0, 0x5501) (fail_nth: 51)

repro.c
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms)
{
usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts))
exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
char buf[1024];
va_list args;
va_start(args, what);
vsnprintf(buf, sizeof(buf), what, args);
va_end(args);
buf[sizeof(buf) - 1] =3D 0;
int len =3D strlen(buf);
int fd =3D open(file, O_WRONLY | O_CLOEXEC);
if (fd =3D=3D -1)
return false;
if (write(fd, buf, len) !=3D len) {
int err =3D errno;
close(fd);
errno =3D err;
return false;
}
close(fd);
return true;
}

static int inject_fault(int nth)
{
int fd;
fd =3D open("/proc/thread-self/fail-nth", O_RDWR);
if (fd =3D=3D -1)
exit(1);
char buf[16];
sprintf(buf, "%d", nth);
if (write(fd, buf, strlen(buf)) !=3D (ssize_t)strlen(buf))
exit(1);
return fd;
}

static void kill_and_wait(int pid, int* status)
{
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
for (int i =3D 0; i < 100; i++) {
if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
return;
usleep(1000);
}
DIR* dir =3D opendir("/sys/fs/fuse/connections");
if (dir) {
for (;;) {
struct dirent* ent =3D readdir(dir);
if (!ent)
break;
if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=3D 0=
)
continue;
char abort[300];
snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
ent->d_name);
int fd =3D open(abort, O_WRONLY);
if (fd =3D=3D -1) {
continue;
}
if (write(fd, abort, 1) < 0) {
}
close(fd);
}
closedir(dir);
} else {
}
while (waitpid(-1, status, __WALL) !=3D pid) {
}
}

static void setup_test()
{
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
write_file("/proc/self/oom_score_adj", "1000");
}

static void setup_fault()
{
static struct {
const char* file;
const char* val;
bool fatal;
} files[] =3D {
    {"/sys/kernel/debug/failslab/ignore-gfp-wait", "N", true},
    {"/sys/kernel/debug/fail_futex/ignore-private", "N", false},
    {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem", "N", false},
    {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait", "N", false},
    {"/sys/kernel/debug/fail_page_alloc/min-order", "0", false},
};
unsigned i;
for (i =3D 0; i < sizeof(files) / sizeof(files[0]); i++) {
if (!write_file(files[i].file, files[i].val)) {
if (files[i].fatal)
exit(1);
}
}
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
int iter =3D 0;
for (;; iter++) {
int pid =3D fork();
if (pid < 0)
exit(1);
if (pid =3D=3D 0) {
setup_test();
execute_one();
exit(0);
}
int status =3D 0;
uint64_t start =3D current_time_ms();
for (;;) {
if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
break;
sleep_ms(1);
if (current_time_ms() - start < 5000)
continue;
kill_and_wait(pid, &status);
break;
}
}
}

uint64_t r[1] =3D {0xffffffffffffffff};

void execute_one(void)
{
intptr_t res =3D 0;
memcpy((void*)0x20000500, "/dev/uinput\000", 12);
res =3D syscall(__NR_openat, /*fd=3D*/0xffffffffffffff9cul,
/*file=3D*/0x20000500ul, /*flags=3D*/0x802ul, /*mode=3D*/0ul);
if (res !=3D -1)
r[0] =3D res;
*(uint16_t*)0x20000080 =3D 0;
*(uint16_t*)0x20000082 =3D -1;
*(uint16_t*)0x20000084 =3D 3;
*(uint16_t*)0x20000086 =3D 0;
memcpy((void*)0x20000088,
"syz0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000",
80);
*(uint32_t*)0x200000d8 =3D 0;
syscall(__NR_ioctl, /*fd=3D*/r[0], /*cmd=3D*/0x405c5503, /*arg=3D*/0x200000=
80ul);
inject_fault(51);
syscall(__NR_ioctl, /*fd=3D*/r[0], /*cmd=3D*/0x5501, 0);

}
int main(void)
{
syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
/*prot=3D*/7ul, /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
setup_fault();
loop();
return 0;
}
