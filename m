Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02F87F972A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjK0B3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0B3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:29:41 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1811A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:29:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so2065058a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701048587; x=1701653387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h+9umOnfRVrB7cu78GrH5RBYS/lEbhMQhXJGbtHt7YM=;
        b=eBWamVCFK5HDQqCN8BlY4dB08fwkPIEa/tQbtkLk52kb98WrO6VDiYeE5tkxfYdjv3
         Fc1f0OJipmlF8nZF3z2qrQRpw5krkJj3vwM04NQqMDXGMzAuJMbUBpawn00n9ACA6FhG
         1SBvNN/202KNfAnUecz8EP7zCtYYfbxhgZO9sVPl3e9pgTpD6ceejErwrCOux0oy5Ty0
         ciz6b0MgxR43qrM+rjNj6Cb1knG5VMdHKRcJG0wSVOOFQ8QnkbRBuqKC3AtUhPYp9ZbU
         2QBdMrCXnrzda33S5mElLTDU+wgik6luzwv+AZ4WwINnQEYhiMDcdhaXy622zWISlB1j
         Nkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701048587; x=1701653387;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+9umOnfRVrB7cu78GrH5RBYS/lEbhMQhXJGbtHt7YM=;
        b=XShtieWnDT/9ww9ERnTsc5Bq+NzvRTprXOEyWbiEkmqqAU+Q7pXTWq4ukXPUkLev7g
         SzTHZsQh4DeG9tXM3yP4D/Cx5ZBYrgCyya5FqRwsMAJzmGb2Xtu5FaFplQFlPsvtqBqd
         sVNLcCRkIE9uy5Zy/mGqk2dZfKV4sztq0SQkS1svI/EdaE4bzHmQWuGKDXbmIloKiJ6i
         cvT+ShFkJX8HlzmmfBKdyI3vKmf3zoRVFMEnUwL6rGHSVwEQwfgglRUsw9NshxQtVWhq
         k8SJf3RV8rc74hQcxdu+lwwhJUIq1zFSuyB8u+xnKZ15/J1Oqd5GANC/w0TO7RVj8uDK
         eANw==
X-Gm-Message-State: AOJu0YzBPF5zfZX6X486WKMjr1UtSe3Lc75ObYMCaR98fwDXiP52OskA
        3j/rnBe6v7oX+7H96ZoKW/B8BQSb/qx+MhPIHPk=
X-Google-Smtp-Source: AGHT+IHSvuY+pwh3WpaY/eUErb7YHig0S78tX7iB5SfnN+I/8f5fxtLzp4MPcMmkbW8kTQtquqBbShOUh5N7RBG8CC8=
X-Received: by 2002:a05:6a20:6a0e:b0:18a:7498:de11 with SMTP id
 p14-20020a056a206a0e00b0018a7498de11mr11545298pzk.4.1701048586603; Sun, 26
 Nov 2023 17:29:46 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Mon, 27 Nov 2023 09:29:35 +0800
Message-ID: <CABOYnLx1V-xtRzPv=sP5=MyVUN0uyw0W_gH1Mi76wsEp3=dNJg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in stack_depot_put
To:     syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: multipart/mixed; boundary="000000000000c02b1e060b183cac"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c02b1e060b183cac
Content-Type: text/plain; charset="UTF-8"

Hi, I reproduce this bug with repro.c and repro.txt and confirmed the crash.

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

--000000000000c02b1e060b183cac
Content-Type: text/plain; charset="US-ASCII"; name="repro.txt"
Content-Disposition: attachment; filename="repro.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lpg8ede71>
X-Attachment-Id: f_lpg8ede71

cjAgPSBzb2NrZXQkYWxnKDB4MjYsIDB4NSwgMHgwKQpiaW5kJGFsZyhyMCwgJigweDdmMDAwMDAw
MDQ0MCk9ezB4MjYsICdza2NpcGhlclx4MDAnLCAweDAsIDB4MCwgJ2VjYi1jaXBoZXJfbnVsbFx4
MDAnfSwgMHg1OCkKcjEgPSBhY2NlcHQkYWxnKHIwLCAweDAsIDB4MCkKcjIgPSBkdXAocjEpCm9w
ZW4oJigweDdmMDAwMDAwMDE0MCk9Jy4vZmlsZTFceDAwJywgMHgxMGYwYzIsIDB4MCkKcjMgPSBk
dXAocjEpCm1vdW50JDlwX2ZkKDB4MCwgJigweDdmMDAwMDAwMDAwMCk9Jy4vZmlsZTFceDAwJywg
JigweDdmMDAwMDAwMDA0MCksIDB4MCwgJigweDdmMDAwMDAwMGE0MCk9QU5ZPVtAQU5ZQkxPQj0n
dHJhbnM9ZmQscmZkbm89JywgQEFOWVJFU0hFWD1yMywgQEFOWUJMT0I9Jyx3ZmRubz0nLCBAQU5Z
UkVTSEVYPXIyXSk=
--000000000000c02b1e060b183cac
Content-Type: application/octet-stream; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lpg8eddz0>
X-Attachment-Id: f_lpg8eddz0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGRpcmVudC5oPgojaW5j
bHVkZSA8ZW5kaWFuLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2lu
Y2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkYXJnLmg+CiNpbmNsdWRlIDxzdGRib29sLmg+
CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIu
aD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL3ByY3RsLmg+CiNpbmNsdWRlIDxz
eXMvc3RhdC5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5o
PgojaW5jbHVkZSA8c3lzL3dhaXQuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPHVuaXN0
ZC5oPgoKc3RhdGljIHZvaWQgc2xlZXBfbXModWludDY0X3QgbXMpCnsKCXVzbGVlcChtcyAqIDEw
MDApOwp9CgpzdGF0aWMgdWludDY0X3QgY3VycmVudF90aW1lX21zKHZvaWQpCnsKCXN0cnVjdCB0
aW1lc3BlYyB0czsKCWlmIChjbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzKSkKCQll
eGl0KDEpOwoJcmV0dXJuICh1aW50NjRfdCl0cy50dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRz
LnR2X25zZWMgLyAxMDAwMDAwOwp9CgpzdGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0IGNoYXIq
IGZpbGUsIGNvbnN0IGNoYXIqIHdoYXQsIC4uLikKewoJY2hhciBidWZbMTAyNF07Cgl2YV9saXN0
IGFyZ3M7Cgl2YV9zdGFydChhcmdzLCB3aGF0KTsKCXZzbnByaW50ZihidWYsIHNpemVvZihidWYp
LCB3aGF0LCBhcmdzKTsKCXZhX2VuZChhcmdzKTsKCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsK
CWludCBsZW4gPSBzdHJsZW4oYnVmKTsKCWludCBmZCA9IG9wZW4oZmlsZSwgT19XUk9OTFkgfCBP
X0NMT0VYRUMpOwoJaWYgKGZkID09IC0xKQoJCXJldHVybiBmYWxzZTsKCWlmICh3cml0ZShmZCwg
YnVmLCBsZW4pICE9IGxlbikgewoJCWludCBlcnIgPSBlcnJubzsKCQljbG9zZShmZCk7CgkJZXJy
bm8gPSBlcnI7CgkJcmV0dXJuIGZhbHNlOwoJfQoJY2xvc2UoZmQpOwoJcmV0dXJuIHRydWU7Cn0K
CnN0YXRpYyB2b2lkIGtpbGxfYW5kX3dhaXQoaW50IHBpZCwgaW50KiBzdGF0dXMpCnsKCWtpbGwo
LXBpZCwgU0lHS0lMTCk7CglraWxsKHBpZCwgU0lHS0lMTCk7Cglmb3IgKGludCBpID0gMDsgaSA8
IDEwMDsgaSsrKSB7CgkJaWYgKHdhaXRwaWQoLTEsIHN0YXR1cywgV05PSEFORyB8IF9fV0FMTCkg
PT0gcGlkKQoJCQlyZXR1cm47CgkJdXNsZWVwKDEwMDApOwoJfQoJRElSKiBkaXIgPSBvcGVuZGly
KCIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMiKTsKCWlmIChkaXIpIHsKCQlmb3IgKDs7KSB7CgkJ
CXN0cnVjdCBkaXJlbnQqIGVudCA9IHJlYWRkaXIoZGlyKTsKCQkJaWYgKCFlbnQpCgkJCQlicmVh
azsKCQkJaWYgKHN0cmNtcChlbnQtPmRfbmFtZSwgIi4iKSA9PSAwIHx8IHN0cmNtcChlbnQtPmRf
bmFtZSwgIi4uIikgPT0gMCkKCQkJCWNvbnRpbnVlOwoJCQljaGFyIGFib3J0WzMwMF07CgkJCXNu
cHJpbnRmKGFib3J0LCBzaXplb2YoYWJvcnQpLCAiL3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25zLyVz
L2Fib3J0IiwgZW50LT5kX25hbWUpOwoJCQlpbnQgZmQgPSBvcGVuKGFib3J0LCBPX1dST05MWSk7
CgkJCWlmIChmZCA9PSAtMSkgewoJCQkJY29udGludWU7CgkJCX0KCQkJaWYgKHdyaXRlKGZkLCBh
Ym9ydCwgMSkgPCAwKSB7CgkJCX0KCQkJY2xvc2UoZmQpOwoJCX0KCQljbG9zZWRpcihkaXIpOwoJ
fSBlbHNlIHsKCX0KCXdoaWxlICh3YWl0cGlkKC0xLCBzdGF0dXMsIF9fV0FMTCkgIT0gcGlkKSB7
Cgl9Cn0KCnN0YXRpYyB2b2lkIHNldHVwX3Rlc3QoKQp7CglwcmN0bChQUl9TRVRfUERFQVRIU0lH
LCBTSUdLSUxMLCAwLCAwLCAwKTsKCXNldHBncnAoKTsKCXdyaXRlX2ZpbGUoIi9wcm9jL3NlbGYv
b29tX3Njb3JlX2FkaiIsICIxMDAwIik7Cn0KCnN0YXRpYyB2b2lkIGV4ZWN1dGVfb25lKHZvaWQp
OwoKI2RlZmluZSBXQUlUX0ZMQUdTIF9fV0FMTAoKc3RhdGljIHZvaWQgbG9vcCh2b2lkKQp7Cglp
bnQgaXRlciA9IDA7Cglmb3IgKDs7IGl0ZXIrKykgewoJCWludCBwaWQgPSBmb3JrKCk7CgkJaWYg
KHBpZCA8IDApCgkJCWV4aXQoMSk7CgkJaWYgKHBpZCA9PSAwKSB7CgkJCXNldHVwX3Rlc3QoKTsK
CQkJZXhlY3V0ZV9vbmUoKTsKCQkJZXhpdCgwKTsKCQl9CgkJaW50IHN0YXR1cyA9IDA7CgkJdWlu
dDY0X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMoKTsKCQlmb3IgKDs7KSB7CgkJCWlmICh3YWl0
cGlkKC0xLCAmc3RhdHVzLCBXTk9IQU5HIHwgV0FJVF9GTEFHUykgPT0gcGlkKQoJCQkJYnJlYWs7
CgkJCXNsZWVwX21zKDEpOwoJCQlpZiAoY3VycmVudF90aW1lX21zKCkgLSBzdGFydCA8IDUwMDAp
CgkJCQljb250aW51ZTsKCQkJa2lsbF9hbmRfd2FpdChwaWQsICZzdGF0dXMpOwoJCQlicmVhazsK
CQl9Cgl9Cn0KCnVpbnQ2NF90IHJbNF0gPSB7MHhmZmZmZmZmZmZmZmZmZmZmLCAweGZmZmZmZmZm
ZmZmZmZmZmYsIDB4ZmZmZmZmZmZmZmZmZmZmZiwgMHhmZmZmZmZmZmZmZmZmZmZmfTsKCnZvaWQg
ZXhlY3V0ZV9vbmUodm9pZCkKewoJaW50cHRyX3QgcmVzID0gMDsKCXJlcyA9IHN5c2NhbGwoX19O
Ul9zb2NrZXQsIC8qZG9tYWluPSovMHgyNnVsLCAvKnR5cGU9Ki81dWwsIC8qcHJvdG89Ki8wKTsK
CWlmIChyZXMgIT0gLTEpCgkJclswXSA9IHJlczsKCSoodWludDE2X3QqKTB4MjAwMDA0NDAgPSAw
eDI2OwoJbWVtY3B5KCh2b2lkKikweDIwMDAwNDQyLCAic2tjaXBoZXJcMDAwXDAwMFwwMDBcMDAw
XDAwMFwwMDAiLCAxNCk7CgkqKHVpbnQzMl90KikweDIwMDAwNDUwID0gMDsKCSoodWludDMyX3Qq
KTB4MjAwMDA0NTQgPSAwOwoJbWVtY3B5KCh2b2lkKikweDIwMDAwNDU4LCAiZWNiLWNpcGhlcl9u
dWxsXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFww
MDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAw
MFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAw
XDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMCIsIDY0KTsKCXN5c2NhbGwoX19OUl9iaW5kLCAv
KmZkPSovclswXSwgLyphZGRyPSovMHgyMDAwMDQ0MHVsLCAvKmFkZHJsZW49Ki8weDU4dWwpOwoJ
cmVzID0gc3lzY2FsbChfX05SX2FjY2VwdCwgLypmZD0qL3JbMF0sIC8qcGVlcj0qLzB1bCwgLypw
ZWVybGVuPSovMHVsKTsKCWlmIChyZXMgIT0gLTEpCgkJclsxXSA9IHJlczsKCXJlcyA9IHN5c2Nh
bGwoX19OUl9kdXAsIC8qb2xkZmQ9Ki9yWzFdKTsKCWlmIChyZXMgIT0gLTEpCgkJclsyXSA9IHJl
czsKCW1lbWNweSgodm9pZCopMHgyMDAwMDE0MCwgIi4vZmlsZTFcMDAwIiwgOCk7CglzeXNjYWxs
KF9fTlJfb3BlbiwgLypmaWxlPSovMHgyMDAwMDE0MHVsLCAvKmZsYWdzPSovMHgxMGYwYzJ1bCwg
Lyptb2RlPSovMHVsKTsKCXJlcyA9IHN5c2NhbGwoX19OUl9kdXAsIC8qb2xkZmQ9Ki9yWzFdKTsK
CWlmIChyZXMgIT0gLTEpCgkJclszXSA9IHJlczsKCW1lbWNweSgodm9pZCopMHgyMDAwMDAwMCwg
Ii4vZmlsZTFcMDAwIiwgOCk7CgltZW1jcHkoKHZvaWQqKTB4MjAwMDAwNDAsICI5cFwwMDAiLCAz
KTsKCW1lbWNweSgodm9pZCopMHgyMDAwMGE0MCwgInRyYW5zPWZkLHJmZG5vPSIsIDE1KTsKCXNw
cmludGYoKGNoYXIqKTB4MjAwMDBhNGYsICIweCUwMTZsbHgiLCAobG9uZyBsb25nKXJbM10pOwoJ
bWVtY3B5KCh2b2lkKikweDIwMDAwYTYxLCAiLHdmZG5vPSIsIDcpOwoJc3ByaW50ZigoY2hhciop
MHgyMDAwMGE2OCwgIjB4JTAxNmxseCIsIChsb25nIGxvbmcpclsyXSk7CglzeXNjYWxsKF9fTlJf
bW91bnQsIC8qc3JjPSovMHVsLCAvKmRzdD0qLzB4MjAwMDAwMDB1bCwgLyp0eXBlPSovMHgyMDAw
MDA0MHVsLCAvKmZsYWdzPSovMHVsLCAvKm9wdHM9Ki8weDIwMDAwYTQwdWwpOwoKfQppbnQgbWFp
bih2b2lkKQp7CglzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgxZmZmZjAwMHVsLCAvKmxl
bj0qLzB4MTAwMHVsLCAvKnByb3Q9Ki8wdWwsIC8qZmxhZ3M9Ki8weDMydWwsIC8qZmQ9Ki8tMSwg
LypvZmZzZXQ9Ki8wdWwpOwoJc3lzY2FsbChfX05SX21tYXAsIC8qYWRkcj0qLzB4MjAwMDAwMDB1
bCwgLypsZW49Ki8weDEwMDAwMDB1bCwgLypwcm90PSovN3VsLCAvKmZsYWdzPSovMHgzMnVsLCAv
KmZkPSovLTEsIC8qb2Zmc2V0PSovMHVsKTsKCXN5c2NhbGwoX19OUl9tbWFwLCAvKmFkZHI9Ki8w
eDIxMDAwMDAwdWwsIC8qbGVuPSovMHgxMDAwdWwsIC8qcHJvdD0qLzB1bCwgLypmbGFncz0qLzB4
MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNldD0qLzB1bCk7Cglsb29wKCk7CglyZXR1cm4gMDsKfQo=
--000000000000c02b1e060b183cac--
