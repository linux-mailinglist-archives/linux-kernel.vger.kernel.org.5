Return-Path: <linux-kernel+bounces-108402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9C880A06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4518C284B23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8712E4A;
	Wed, 20 Mar 2024 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsgMWJtE"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1E125CE;
	Wed, 20 Mar 2024 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710903489; cv=none; b=De5hWmFCAaMUW1cQMUD7E3aGJEJZxbBXOkX47w7FnuBHE4/mcSacVrG8F1cCJNAIpgj8sCrfcYBvXHlSNPiZHrFYrM86w6w07FNB3IgPfNnVmrogc+DhfbTCex8TKTlH9HQB9Ilsukts4JlPSrjjWVVnnIM69obZGTjgDYJvUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710903489; c=relaxed/simple;
	bh=y5McYz92/dYSqFuneRQ133fc4vz1ZAYsNNSag/LrbtA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ufOzYqy7VlJkXTFIS1yDbQWn8S4ZIttBz+vSlOvcV/hqZ88SkJuinLOs/Zriwr/0yRuoK4bKtAZg6+km7HxZ7QBm7K5Es7KaMKbqucy6Wx6IRisFCm2y/ptkPxxGY9LJJhqSEUw1LZktawoufta8PMYO7ATVXKh5guZqPkOlP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsgMWJtE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c396fec63aso551432b6e.0;
        Tue, 19 Mar 2024 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710903487; x=1711508287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ISSGcUlaf1DV7cbQ9p9F3X2z/M69GiJkRNSoooM6Ai4=;
        b=TsgMWJtEqidJbof+Fjnlvr1b456JGpEptZE/A3CWlqz63XD9Ige4rbTl2eVq0YXIT5
         9ZEVnDKMsDBVCOHjW3lShHgwwFuOsnVmTP0U7glOJLPj/h7Ekp+GiL1164TNNMEIgs8G
         kTgtreg7dE7Hu014ESRTXgxvkWi4l+wrOfx6m6nr/yEbv/vf7VN2ntVTf+kjUBOkt12F
         kXb4PMqCQKnBul5QwgS+21n+/Dmo8foavnpjGrCNsP5I9hTvGjjDYFIzuGgfiqn4GvKj
         QyIFPnDPokxOEPwsb7SxoekNRtYS2DW/UQZK5MY8HDOM7veHk3l0xPLHS8X7g7H6YlW1
         BBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710903487; x=1711508287;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISSGcUlaf1DV7cbQ9p9F3X2z/M69GiJkRNSoooM6Ai4=;
        b=fVRkTQZFp8GIXQfJQAkuD5FDF9u9LYZmg886LtU+T3VS2I/aM+ALItQZlEqDlc2CX9
         +ICre6KhiouQnu2+r7Igro0poSXJJ9jur6oWnUjaIp3tjDyJZ9RVX29K5GkN9bmryKsV
         8IDkak9ZBmcwtEASWoMi2JNY8+ygzWJ/3TQFsCj9cz+lpYkf6uehKLmK9b1jAJOXHlu7
         MKRTZikPkXu2IXt47IH9oPmt3opn6QMaRHMtjRNPnbnVzFc/LY9uBGue58LTacl4ZlvZ
         A/XhTFHTObbxhSo0RjpvAt86wYnBDQ/XyY8wZ5/PwEfYUHJRQ4LgcILbuEuIxKpI+R2N
         TEWw==
X-Forwarded-Encrypted: i=1; AJvYcCXkeYwHKg0yi2j+gC/X7Ua+ie5CJVdS2hkVlQ7N/neJosORj7Ujr0+ZkMd8zWbRE0vdEWJE0zAHlYDKdsoeA+U8s1dUz+kqbZuwluF8
X-Gm-Message-State: AOJu0YzJehORsi5rm8vFSnamvgFOFwRYGVKLWVfZv/QF+El0ELE2ZQIA
	ox1bF8rb3ybfNu5T2B4/q+qRCLxwsx2P/VZNH4RjCo2ayuQXYAvjHkGjgOGLXW2/ubQbFof+6f9
	nF4okkNzrcCvY6Rbx4c7NVt9/IVRcpruV3iU=
X-Google-Smtp-Source: AGHT+IG6ndj718DS4hkj3dKRRsVK64bwSAC7yvQpsVsV+W8zwtg96Cu8doXxL3IEYweb+P4m5LuYTE/1bFOjtKJ80yg=
X-Received: by 2002:a05:6808:bcd:b0:3c3:9e28:3053 with SMTP id
 o13-20020a0568080bcd00b003c39e283053mr2247375oik.20.1710903487032; Tue, 19
 Mar 2024 19:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Wed, 20 Mar 2024 10:57:53 +0800
Message-ID: <CABOYnLzjayx369ygmr0PsGYGeRpnBnaH1XPqfbispL5nAeOJ9w@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in crypto_sha3_update
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello I found a bug titled "BUG: unable to handle kernel paging
request in crypto_sha3_update", and maybe is related with net/crypto.
I also confirmed in the latest upstream and latest net tree.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

kernel: net 32fa4366cc4da1c97b725a0066adf43c6b298f37
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=9f47e8dfa53b0b11
with KASAN enabled
compiler: gcc (Debian 12.2.0-14) 12.2.0

BUG: unable to handle page fault for address: ffff88802c583080
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 14a01067 P4D 14a01067 PUD 14a02067 PMD 26119063 PTE 800fffffd3a7c060
Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 8138 Comm: a0c Not tainted 6.8.0-05242-g32fa4366cc4d #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:get_unaligned_le64 include/asm-generic/unaligned.h:37 [inline]
RIP: 0010:crypto_sha3_update+0x233/0x4c0 crypto/sha3_generic.c:197
Code: c0 40 84 ff 40 0f 95 c7 41 84 f8 0f 85 eb 01 00 00 83 e1 07 40
38 ce 40 0f 9e c7 40 84 f6 0f 91
RSP: 0018:ffffc90012b7f8c8 EFLAGS: 00010246
RAX: ffff88802c583080 RBX: 0000000000000009 RCX: 0000000000000000
RDX: ffff888018b15bc0 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff88802fb10b00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000009 R11: 0000000000000001 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88802c583080 R15: ffff88802fb10b00
FS:  00000000334d4380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88802c583080 CR3: 000000014d8dc000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 shash_ahash_update+0x1ac/0x1f0 crypto/ahash.c:71
 crypto_ahash_update+0x7b/0x110 crypto/ahash.c:350
 hash_sendmsg+0x2a9/0xf30 crypto/algif_hash.c:149
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x432cb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c8
RSP: 002b:00007ffe88e07ef8 EFLAGS: 00000217 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffe88e08128 RCX: 0000000000432cb9
RDX: 47933e2b0522cf63 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007ffe88e07f10 R08: 00007ffe88e07f10 R09: 00007ffe88e07f10
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000000001
R13: 00007ffe88e08118 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

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

#ifndef __NR_memfd_secret
#define __NR_memfd_secret 447
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

uint64_t r[3] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};

void execute_one(void) {
  intptr_t res = 0;
  res = syscall(__NR_socket, /*domain=*/0x26ul, /*type=*/5ul, /*proto=*/0);
  if (res != -1)
    r[0] = res;
  *(uint16_t*)0x20000000 = 0x26;
  memcpy((void*)0x20000002, "hash\000\000\000\000\000\000\000\000\000\000", 14);
  *(uint32_t*)0x20000010 = 0;
  *(uint32_t*)0x20000014 = 0;
  memcpy((void*)0x20000018,
         "sha3-"
         "512\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
         "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
         "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
         "\000\000\000\000\000\000",
         64);
  syscall(__NR_bind, /*fd=*/r[0], /*addr=*/0x20000000ul, /*addrlen=*/0x58ul);
  res = syscall(__NR_accept, /*fd=*/r[0], /*peer=*/0ul, /*peerlen=*/0ul);
  if (res != -1)
    r[1] = res;
  res = syscall(__NR_memfd_secret, /*flags=*/0ul);
  if (res != -1)
    r[2] = res;
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0xb36000ul,
          /*prot=*/0x2000003ul, /*flags=*/0x28011ul, /*fd=*/r[2],
          /*offset=*/0ul);
  syscall(__NR_ftruncate, /*fd=*/r[2], /*len=*/0xde99ul);
  *(uint64_t*)0x20000180 = 0;
  *(uint32_t*)0x20000188 = 0;
  *(uint64_t*)0x20000190 = 0x20000140;
  *(uint64_t*)0x20000140 = 0x20000080;
  *(uint64_t*)0x20000148 = 0xb0;
  *(uint64_t*)0x20000198 = 1;
  *(uint64_t*)0x200001a0 = 0;
  *(uint64_t*)0x200001a8 = 0;
  *(uint32_t*)0x200001b0 = 0;
  syscall(__NR_sendmsg, /*fd=*/r[1], /*msg=*/0x20000180ul,
          /*f=*/0x47933e2b0522cf63ul);
}
int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  loop();
  return 0;
}


=* repro.txt =*
r0 = socket$alg(0x26, 0x5, 0x0)
bind$alg(r0, &(0x7f0000000000)={0x26, 'hash\x00', 0x0, 0x0,
'sha3-512\x00'}, 0x58)
r1 = accept(r0, 0x0, 0x0)
r2 = memfd_secret(0x0)
mmap(&(0x7f0000000000/0xb36000)=nil, 0xb36000, 0x2000003, 0x28011, r2, 0x0)
ftruncate(r2, 0xde99)
sendmsg$DEVLINK_CMD_RELOAD(r1, &(0x7f0000000180)={0x0, 0x0,
&(0x7f0000000140)={&(0x7f0000000080)=ANY=[], 0xb0}},
0x47933e2b0522cf63)


see aslo https://gist.github.com/xrivendell7/411acf9336ff0b6a70b9742702bbfb1a.

I hope it helps.
best regards.
xingwei Lee

