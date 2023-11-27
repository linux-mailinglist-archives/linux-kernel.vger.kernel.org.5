Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D87F9754
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0B4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0B4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:56:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF128B5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:56:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2272306a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701050173; x=1701654973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HrpW/mblbGR2zQK+f0lTXDIxL2r3yJ0KWZHVyIahz68=;
        b=OqMsPhZZk1+if8UIVbmfU3Ixk+CTv+r9+N6NDxeKYwxR8e518NxP5J1o8kT380ScPh
         YFsyXcEU21DUsVw46w63wWBMf53tlSC6D5iRzdmskPc35RLyiiXg0QWCVMuJ5+9O17uf
         a0qAjlPHiNTilvdGA9CIywdrIzsGOZDUwWDebON+Rtcu9j7/421OybUFGIsjcNnV8mKC
         ffwBhskLlcL+JJ/EZMs9N8zJsVz7vV8QYjDReQbknvNZGfZr5vbbDP8BphMUBh/2dhLh
         LwGkql3BeZftKdBrj6kfRIBzkHB+RZCkVHSFUoMvDKnTcGWgw+a84W7Xg+ZDJpATRdG5
         ooTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701050173; x=1701654973;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrpW/mblbGR2zQK+f0lTXDIxL2r3yJ0KWZHVyIahz68=;
        b=eF/d/3F/PXt1TK+yu/sUDbdeGyWblL1aitYZixrfjdUgZeoYo9gtiQQO4oBH+SZfbA
         O71miurS4XvXxsLclIG7BeAHkYenxxASo/fAgOtJ8o6gcq9rGD/ZhrvHNtIG/YOon4Zn
         vyKjg6mZTfEHttCzdXPRkcADBT00eLCFB0bN+U7MnGOdYNlwH3U5F2+I/4EjPpiKBXcK
         LxNBc3VQzkMg87vLPrqD97kyzUEy3R3a64kdZwLlUKayzPFEC/X1p7gLiPQtwD9/sfTy
         XFQDepRUAm4YdXrw94V2TsG07LriKo3ptlsF951l5N1yb86rl6Dpde+EzqJzKaIlAHHa
         24Gw==
X-Gm-Message-State: AOJu0YwmK5YE67w5K4tRwUX4wPerLbr4KP0yV8lxyjcSlr7U4bo6RE5b
        N6hKfSfIPmm8WSeJyKLFu8JWV5fuunHa6L/gzVE=
X-Google-Smtp-Source: AGHT+IEk6sJdDgU6g1f/Ck/0lU0GQOvzP07U9F9fYjYzbAIe+E2hDk+CHfC3QmPvYQ5bgONzgjHPUZ3/jT/kh24OIsY=
X-Received: by 2002:a17:90b:4a45:b0:285:9d40:192e with SMTP id
 lb5-20020a17090b4a4500b002859d40192emr5611260pjb.6.1701050172992; Sun, 26 Nov
 2023 17:56:12 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Mon, 27 Nov 2023 09:56:02 +0800
Message-ID: <CABOYnLz3Keyn-bvwRcng_z3_-9zj3zXUAU7e7Vz3V4xACsqSVA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in stack_depot_put
To:     syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for containing HTML subpart, I'll repeat this mail.
Hi, I reproduce this bug with repro.c and repro.txt and confirmed crash.

repro.txt
r0 = socket$alg(0x26, 0x5, 0x0)
bind$alg(r0, &(0x7f0000000440)={0x26, 'skcipher\x00', 0x0, 0x0,
'ecb-cipher_null\x00'}, 0x58)
r1 = accept$alg(r0, 0x0, 0x0)
r2 = dup(r1)
open(&(0x7f0000000140)='./file1\x00', 0x10f0c2, 0x0)
r3 = dup(r1)
mount$9p_fd(0x0, &(0x7f0000000000)='./file1\x00', &(0x7f0000000040),
0x0, &(0x7f0000000a40)=ANY=[@ANYBLOB='trans=fd,rfdno=', @ANYRESHEX=r3,
@ANYBLOB=',wfdno=', @ANYRESHEX=r2])

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
buf[sizeof(buf) - 1] = 0;
int len = strlen(buf);
int fd = open(file, O_WRONLY | O_CLOEXEC);
if (fd == -1)
return false;
if (write(fd, buf, len) != len) {
int err = errno;
close(fd);
errno = err;
return false;
}
close(fd);
return true;
}

static void kill_and_wait(int pid, int* status)
{
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
for (int i = 0; i < 100; i++) {
if (waitpid(-1, status, WNOHANG | __WALL) == pid)
return;
usleep(1000);
}
DIR* dir = opendir("/sys/fs/fuse/connections");
if (dir) {
for (;;) {
struct dirent* ent = readdir(dir);
if (!ent)
break;
if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
continue;
char abort[300];
snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
ent->d_name);
int fd = open(abort, O_WRONLY);
if (fd == -1) {
continue;
}
if (write(fd, abort, 1) < 0) {
}
close(fd);
}
closedir(dir);
} else {
}
while (waitpid(-1, status, __WALL) != pid) {
}
}

static void setup_test()
{
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
int iter = 0;
for (;; iter++) {
int pid = fork();
if (pid < 0)
exit(1);
if (pid == 0) {
setup_test();
execute_one();
exit(0);
}
int status = 0;
uint64_t start = current_time_ms();
for (;;) {
if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
break;
sleep_ms(1);
if (current_time_ms() - start < 5000)
continue;
kill_and_wait(pid, &status);
break;
}
}
}

uint64_t r[4] = {0xffffffffffffffff, 0xffffffffffffffff,
0xffffffffffffffff, 0xffffffffffffffff};

void execute_one(void)
{
intptr_t res = 0;
res = syscall(__NR_socket, /*domain=*/0x26ul, /*type=*/5ul, /*proto=*/0);
if (res != -1)
r[0] = res;
*(uint16_t*)0x20000440 = 0x26;
memcpy((void*)0x20000442, "skcipher\000\000\000\000\000\000", 14);
*(uint32_t*)0x20000450 = 0;
*(uint32_t*)0x20000454 = 0;
memcpy((void*)0x20000458,
"ecb-cipher_null\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
64);
syscall(__NR_bind, /*fd=*/r[0], /*addr=*/0x20000440ul, /*addrlen=*/0x58ul);
res = syscall(__NR_accept, /*fd=*/r[0], /*peer=*/0ul, /*peerlen=*/0ul);
if (res != -1)
r[1] = res;
res = syscall(__NR_dup, /*oldfd=*/r[1]);
if (res != -1)
r[2] = res;
memcpy((void*)0x20000140, "./file1\000", 8);
syscall(__NR_open, /*file=*/0x20000140ul, /*flags=*/0x10f0c2ul, /*mode=*/0ul);
res = syscall(__NR_dup, /*oldfd=*/r[1]);
if (res != -1)
r[3] = res;
memcpy((void*)0x20000000, "./file1\000", 8);
memcpy((void*)0x20000040, "9p\000", 3);
memcpy((void*)0x20000a40, "trans=fd,rfdno=", 15);
sprintf((char*)0x20000a4f, "0x%016llx", (long long)r[3]);
memcpy((void*)0x20000a61, ",wfdno=", 7);
sprintf((char*)0x20000a68, "0x%016llx", (long long)r[2]);
syscall(__NR_mount, /*src=*/0ul, /*dst=*/0x20000000ul,
/*type=*/0x20000040ul, /*flags=*/0ul, /*opts=*/0x20000a40ul);

}
int main(void)
{
syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
/*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
loop();
return 0;
}
