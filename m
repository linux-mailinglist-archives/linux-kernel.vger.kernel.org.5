Return-Path: <linux-kernel+bounces-109701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8B881C92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98311C21251
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B254D9F2;
	Thu, 21 Mar 2024 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhIUqYQ3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029E4AEF8;
	Thu, 21 Mar 2024 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003303; cv=none; b=paPFfu9j7jNlbZUdkax6kNfmK7uuJEJOP5Ch6HTcDpWbvUinK0lC2k/Bnykq5xw+XL82nMVEpJV36wyjcRwbehPgvTskqxDNMdVLot31BEbkJpV6Q3MbtzCMmecIAwd12zmwTppKC4mgAEyYwXUvhGiigyEvQCU7NSmfBIuLAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003303; c=relaxed/simple;
	bh=iW3POSR2hYUe91spHlHcymuF7ESzBbZR+kQIZOJotqQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fq1l1t/tAGTldqnR/RTo43cdBCBz1/Te8X1Cpt1nJMBmz2nDCmLmT8OIQ7rvK/annAPbjxrNgigc/z1juLl1merLJ0o0Jv/eET2kHbGs4UjX10TO/+seBpu8oZkhyQlyMWd+rG7UGLfZX2Wu2hXTbcdrEDCTZhz9MxxEJPUqHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhIUqYQ3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29f6f8614c8so538850a91.0;
        Wed, 20 Mar 2024 23:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711003301; x=1711608101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2NMmGZZnEYAcFSYj9boFZsEMWHP9NK+4KSB97sq/fUo=;
        b=DhIUqYQ3S8sPj87xtr25JEZuLpFcwbFsAjT/d7YsssNWtLa1CtJoJSvAe2lcswncw4
         GRPTm890huZGw04tU/DAEKi+bhbDDPAY+1m95TsKn3YKlprAhRwbwaE+Lu4xXZQcj9Iv
         EOYsSiIblTDfoJWHHwQOr5UTn6jy4Z+9NDprPrbhpRkevDsYoctdM/2hJuQOWSpBbxzD
         B792Tw3n+wG0HTGMjJBI+/PBkkfmT5NcWkVOBrR70brH6JoIkK0GIKeqJ/wSTxSElsgQ
         mvRWEEKsW13O2C7lFZR8OkgpqdtJ5JLsVUkSmt1Bu6KYbibcukvi+ByJTSeMBIjEt1GP
         IDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003301; x=1711608101;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NMmGZZnEYAcFSYj9boFZsEMWHP9NK+4KSB97sq/fUo=;
        b=vTFh9NT7icV9nlcOdPmJHs3or8YeQY2DVpTN/zUjkKHIE8o0wvQVqAWhIjewDiMNPA
         04GesgQt9Ma4R8qJX8O5zOHzs2XQodlZ+buhx8Zd6pyZW1K2w5Cr4lcvlBIn10oyHrnf
         XuT1VKNJxwvotQiHOvEFd2igkFajk6Sr0wRWoT+c6Fbfi4piUMyD1pbpTLkf4tHgrCtM
         G6aX9dSTQ+LsJoCJTKJHrxAJm/wG0NKA/Q7WrG51bAZ0x74UfovptkDpVYv7BnmkzIQL
         zjLPDleT++5u0pNzV6HqltPRvqoIcE97d2FuFajrIZf1IOUI0vNHd28SYMtBbtBfjzAj
         Rdiw==
X-Forwarded-Encrypted: i=1; AJvYcCUV3ilLfEMCOSam2X//0qatRb5VWNbh53gdoMdbkwgBSUJMGMF/Y39ojmJqpQbM390l97zX2d0c/DuZxy8Hpp4AY2gispClJKNMrrnKpfCNh0SGC6eUVERGogwaG4VCBT+N
X-Gm-Message-State: AOJu0YxlLvx4X54svUkONqWD9Os/iJWJyVERXpB99t8lpkkPtsEQpj4u
	7sWmKYs281M6ncQTXFqxnkQVA31aTGFEzKfVXnODeCzLAOtU/r32sMHE3cQeG9e6HUf76oN63ob
	cKfTEBbipazdayeu5k85iGVNXFSs=
X-Google-Smtp-Source: AGHT+IHBSP5M44I/Qo+vRR+S40dOVoUACGa8zK5i2i+nXm6X7p+rsQZUEApOHpCfSeHXBQIJ2rPzMtmvGtd1hYMAD9I=
X-Received: by 2002:a17:90a:2ec2:b0:29b:4a20:18b7 with SMTP id
 h2-20020a17090a2ec200b0029b4a2018b7mr7353285pjs.8.1711003300771; Wed, 20 Mar
 2024 23:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Thu, 21 Mar 2024 14:41:29 +0800
Message-ID: <CABOYnLxfFXYV5mJfNrTKEdohF6_AUFxb3fPHEF=eaCEio3dv9w@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull
To: syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug and comfired in the latest net tree.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

kernel version: net.git 32fa4366cc4da1c97b725a0066adf43c6b298f37
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=5c1d7ee7e74661a8
with KMSAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

root@syzkaller:~# ./6be
=====================================================
BUG: KMSAN: uninit-value in __bpf_strtoull+0x292/0x690 kernel/bpf/helpers.c:465
__bpf_strtoull+0x292/0x690 kernel/bpf/helpers.c:465
__bpf_strtoll kernel/bpf/helpers.c:504 [inline]
____bpf_strtol kernel/bpf/helpers.c:525 [inline]
bpf_strtol+0x87/0x2c0 kernel/bpf/helpers.c:519
___bpf_prog_run+0x14de/0xec60 kernel/bpf/core.c:1997
__bpf_prog_run96+0xc0/0xf0 kernel/bpf/core.c:2236
bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
__bpf_prog_run include/linux/filter.h:657 [inline]
bpf_prog_run_xdp include/net/xdp.h:514 [inline]
bpf_test_run+0x464/0xcc0 net/bpf/test_run.c:423
bpf_prog_test_run_xdp+0x101c/0x1c70 net/bpf/test_run.c:1269
bpf_prog_test_run+0x754/0xba0 kernel/bpf/syscall.c:4240
__sys_bpf+0x7a6/0x1010 kernel/bpf/syscall.c:5649
__do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
__x64_sys_bpf+0xa9/0xf0 kernel/bpf/syscall.c:5736
do_syscall_64+0xd5/0x1f0
entry_SYSCALL_64_after_hwframe+0x6d/0x75
Local variable stack created at:
__bpf_prog_run96+0x50/0xf0 kernel/bpf/core.c:2236
bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
__bpf_prog_run include/linux/filter.h:657 [inline]
bpf_prog_run_xdp include/net/xdp.h:514 [inline]
bpf_test_run+0x464/0xcc0 net/bpf/test_run.c:423
CPU: 2 PID: 8031 Comm: 6be Not tainted 6.8.0-05242-g32fa4366cc4d #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
=====================================================


=* repro.c =*
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

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static void sleep_ms(uint64_t ms) {
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
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

static void kill_and_wait(int pid, int* status) {
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

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
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

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

void execute_one(void) {
 intptr_t res = 0;
 *(uint32_t*)0x20000340 = 2;
 *(uint32_t*)0x20000344 = 4;
 *(uint32_t*)0x20000348 = 8;
 *(uint32_t*)0x2000034c = 1;
 *(uint32_t*)0x20000350 = 0x80;
 *(uint32_t*)0x20000354 = 0;
 *(uint32_t*)0x20000358 = 0;
 memset((void*)0x2000035c, 0, 16);
 *(uint32_t*)0x2000036c = 0;
 *(uint32_t*)0x20000370 = 0;
 *(uint32_t*)0x20000374 = 0;
 *(uint32_t*)0x20000378 = 0;
 *(uint32_t*)0x2000037c = 0;
 *(uint64_t*)0x20000380 = 0;
 res = syscall(__NR_bpf, /*cmd=*/0ul, /*arg=*/0x20000340ul, /*size=*/0x48ul);
 if (res != -1)
   r[0] = res;
 *(uint32_t*)0x200004c0 = 6;
 *(uint32_t*)0x200004c4 = 0x10;
 *(uint64_t*)0x200004c8 = 0x20000000;
 memcpy((void*)0x20000000,
        "\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb7"
        "\x08\x00\x00\x00\x00\x00\x00\x7b\x8a\xb8\xff\x00\x00\x00\x00\xb7\x08"
        "\x00\x00\x00\x00\x00\x00\x7b\x8a\xf0\xff\x00\x00\x00\x00\xbf\xa1\x00"
        "\x00\x00\x00\x00\x00\x07\x01\x00\x00\xf8\xff\xff\xff\xbf\xa4\x00\x00"
        "\x00\x00\x00\x00\x07\x04\x00\x00\xf0\xff\xff\xff\xb7\x02\x00\x00\x08"
        "\x00\x00\x00\x18\x23\x00\x00",
        92);
 *(uint32_t*)0x2000005c = r[0];
 memcpy((void*)0x20000060,
        "\x00\x00\x00\x00\x00\x00\x00\x00\xb7\x03\x00\x00\x00\x00\x00\x00\x85"
        "\x00\x00\x00\x69\x00\x00\x00\x95",
        25);
 *(uint64_t*)0x200004d0 = 0x20000600;
 memcpy((void*)0x20000600, "GPL\000", 4);
 *(uint32_t*)0x200004d8 = 0;
 *(uint32_t*)0x200004dc = 0;
 *(uint64_t*)0x200004e0 = 0;
 *(uint32_t*)0x200004e8 = 0;
 *(uint32_t*)0x200004ec = 0;
 memset((void*)0x200004f0, 0, 16);
 *(uint32_t*)0x20000500 = 0;
 *(uint32_t*)0x20000504 = 0;
 *(uint32_t*)0x20000508 = 0;
 *(uint32_t*)0x2000050c = 0;
 *(uint64_t*)0x20000510 = 0;
 *(uint32_t*)0x20000518 = 0;
 *(uint32_t*)0x2000051c = 0;
 *(uint64_t*)0x20000520 = 0;
 *(uint32_t*)0x20000528 = 0;
 *(uint32_t*)0x2000052c = 0;
 *(uint32_t*)0x20000530 = 0;
 *(uint32_t*)0x20000534 = 0;
 *(uint64_t*)0x20000538 = 0;
 *(uint64_t*)0x20000540 = 0;
 *(uint32_t*)0x20000548 = 0;
 *(uint32_t*)0x2000054c = 0;
 res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200004c0ul, /*size=*/0x90ul);
 if (res != -1)
   r[1] = res;
 *(uint32_t*)0x20000640 = r[1];
 *(uint32_t*)0x20000644 = 5;
 *(uint32_t*)0x20000648 = 0;
 *(uint32_t*)0x2000064c = 0;
 *(uint64_t*)0x20000650 = 0;
 *(uint64_t*)0x20000658 = 0;
 *(uint32_t*)0x20000660 = 0;
 *(uint32_t*)0x20000664 = 0;
 *(uint32_t*)0x20000668 = 0;
 *(uint32_t*)0x2000066c = 0;
 *(uint64_t*)0x20000670 = 0;
 *(uint64_t*)0x20000678 = 0;
 *(uint32_t*)0x20000680 = 0;
 *(uint32_t*)0x20000684 = 0;
 *(uint32_t*)0x20000688 = 0;
 syscall(__NR_bpf, /*cmd=*/0xaul, /*arg=*/0x20000640ul, /*size=*/0x50ul);
}
int main(void) {
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
         /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 loop();
 return 0;
}

=* repro.txt =*
r0 = bpf$MAP_CREATE_CONST_STR(0x0, &(0x7f0000000340)={0x2, 0x4, 0x8,
0x1, 0x80, 0x0, 0x0, '\x00', 0x0, 0x0}, 0x48)
r1 = bpf$PROG_LOAD(0x5, &(0x7f00000004c0)={0x6, 0x10,
&(0x7f0000000000)=ANY=[@ANYBLOB="18000000000000000000000000000000b7080000000000007b8ab8ff00000000b7080000000000007b8af0ff00000000bfa100000000000007010000f8ffffffbfa400000000000007040000f0ffffffb70200000800000018230000",
@ANYRES32=r0, @ANYBLOB="0000000000000000b703000000000000850000006900000095"],
&(0x7f0000000600)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
0x90)
bpf$BPF_PROG_TEST_RUN(0xa, &(0x7f0000000640)={r1, 0x5, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, 0x50)


and see also in
https://gist.github.com/xrivendell7/37b74ecaeccd48127ed6137127a6b134

I hope it helps.
Best regards
xingwei Lee

