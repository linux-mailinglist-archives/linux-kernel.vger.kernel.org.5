Return-Path: <linux-kernel+bounces-72486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E285B418
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DB31C23A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA885A788;
	Tue, 20 Feb 2024 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+EyRnJy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936A3D69;
	Tue, 20 Feb 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414845; cv=none; b=oGgpU5ATT9M0WZAM8Clh+w7W0WFZz1kJOpP2brEE0IHBob9NeENbjVFotrEpZKCHw0biFjbvwVIpbGossoobJsE9Uy5I6wqQSGYtYWeLa8WAizKrhEtg7tjFMFrc429DMPBJ3g+AbWScdWVDMj8uqhEsoVRJKCL0px2GQKuUl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414845; c=relaxed/simple;
	bh=ZOVlHjoNWGZlrWpvQGlHW0DgOFLOdV9R3+rIuz3x6Ac=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OnWtIJYSpEK8rKB9GVrqMe8Nz4PFAIPy1N/m4RYb3uv/h/cUIsQZQFx2FxxKEtQOT3WPMzHzzfFPEUc3HfELp7NmmCwWGdLLnUugsAT1LTVUpZGHwprNF11R6KmFOrMXMdhqXAOvmPTmOx2TF2SbCHJApRyR+1ygRi5BmacyspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+EyRnJy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso6207596a12.0;
        Mon, 19 Feb 2024 23:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708414842; x=1709019642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZJgd1WSQQoJhizAktILS9A7ovWUPlZSPNmfBg2k610=;
        b=Y+EyRnJyLzM9SnH8AVREf+SlRb4F3D/+dyVUBaeuN46LLgZVs5QHC4OLXetjc6hbY0
         Zz+FOHJjTNOYNZBiFX5wfxv6OjpXaXpL8Nboulh3iHfXFYsJ46RjPC1y/ELR6kpskE1G
         2DaNSu8WwSZ8NCVxaOvbaaU1llSd4OoaAuWBy6CI1w7pqn+a/kRViTifJ3eBzL23PECb
         Dkg8mjabormWCIsqSAOMnFaDUMF6vANAZTC/PWvJe2qEsAKkzzCBSGz/3CsFKynpCCM0
         fMSM2aG8qX5Nk50R1y9kaAPvNrvebQVWLcFmd9NpW+eYkO5+COKq68MvFernQasBd0wf
         4eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414842; x=1709019642;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZJgd1WSQQoJhizAktILS9A7ovWUPlZSPNmfBg2k610=;
        b=Zwt+BtjJLHLCehPEv7j+EyFwY+PrwPak8euAhPz42A5qoRjf+Zug9DmqDC12KSVqiY
         +dHd2RUF81ScvkoKVUFJ37dazsIg8eXyHbbz/55llsVObqPl5cYkvrWlHXUAFSUP/IC5
         S6vyZ6+3RnQ9cLUVajeT7tHkxS5yswlLo6ECng/2U6BELBZrA2HLyYpa+n+8DN9C+6DV
         D04OlGJiV0dZR/nd/D59EjaCjNO9oQWhq7aGVh+fMOLaDBeGT0RPpGKCVFETYZpUgjkq
         sLjrCUJtRJ0FY3Z6kMGTXQYELgNNScnk9wrkIjMcEsTVFmkXbIclWwxdzVQ6KZbn4wDH
         wXKg==
X-Forwarded-Encrypted: i=1; AJvYcCW4yQNg2fh6f9XSjGfw1V6QGnZrrwDnwsm3CWLGKXnKxbEazZXSagu1PVtB6ZwvsNEFkd/V6GrZLVVeXh6sqEYv/AiDnfg4yPVoUVw04dBcpl/NlexKDRqy5I2uo9RVKTEtmXN2KnzG5lq0FiqywjU57c4a
X-Gm-Message-State: AOJu0Yy/ZU/0irc4lg7HQwKjyWxeghXC+NJImo7zMbS0z2DysMr3KE8o
	+dP0olx0kf2SbpSN7bIpto/rd38Ey2hnCyun6cqPBSSLadVnjZuHcIF7l1Nn2OieEf7SslT4y1p
	AQY3FBcMancbvv3CF3VW+X6wbWlHAA6DvQZQ=
X-Google-Smtp-Source: AGHT+IEepPEeUEa7clOqNuJZyoL/tloZDPrpO1QJk8DIdo/i3F0QNafQxHkMp/lCSlr0EZIgS6wPnO9c/qOM8NVvlRo=
X-Received: by 2002:a17:906:57ca:b0:a3f:ce6:bf00 with SMTP id
 u10-20020a17090657ca00b00a3f0ce6bf00mr267556ejr.15.1708414841724; Mon, 19 Feb
 2024 23:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 20 Feb 2024 08:40:30 +0100
Message-ID: <CAKXUXMxBB21bp5QLPKnxthO36zAaLNHMUtc1q2HuV7hFGNsnHw@mail.gmail.com>
Subject: memory leak in smack since de93 e515 db30 ("Smack: Improve mount
 process memory use")
To: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Dear Casey,

For some experimentation, I have been running fuzzing campaigns and I
noticed a memory leak in sys_fsconfig.

As I have a C reproducer, I could manually bisect it being introduced with:

commit de93e515db306767549bb29a926f523ca2a601ab
Author: Casey Schaufler <casey@schaufler-ca.com>
Date:   Wed Apr 5 08:46:14 2023 -0700

    Smack: Improve mount process memory use

    The existing mount processing code in Smack makes many unnecessary
    copies of Smack labels. Because Smack labels never go away once
    imported it is safe to use pointers to them rather than copies.
    Replace the use of copies of label names to pointers to the global
    label list entries.

So, it was introduced with v6.4; it is still reproducible on v6.8-rc5.
I did not check linux-next, but I suspect it is still there, if you
did not do any major rework.

The C reproducer below is automatically generated by syzkaller; so, it
is a bit difficult to read and a bit lengthy, but I hope you can
extract the essence.

If I have more time next week, I might also give you a more readable C
program, and possibly already some analysis and a bug-fix.

As far as I see, a bug-fix would need to be included to the LTS v6.6.y.

If you need any further information, just let me know.

Lukas


Here are the details:

Crash report:

BUG: memory leak
unreferenced object 0xffff000004aa91b0 (size 16):
  comm "syz-executor276", pid 964, jiffies 4294943128 (age 9.790s)
  hex dump (first 16 bytes):
    2e 2d 7d 2e 27 5d 23 fe 00 00 00 00 00 00 00 00  .-}.']#.........
  backtrace:
    [<00000000cf09e3ce>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
    [<00000000cf09e3ce>] slab_post_alloc_hook mm/slab.h:765 [inline]
    [<00000000cf09e3ce>] slab_alloc_node mm/slub.c:3478 [inline]
    [<00000000cf09e3ce>] __kmem_cache_alloc_node+0x1a8/0x234 mm/slub.c:3517
    [<00000000643fc445>] __do_kmalloc_node mm/slab_common.c:1025 [inline]
    [<00000000643fc445>] __kmalloc_node_track_caller+0x48/0x74
mm/slab_common.c:1046
    [<00000000a19493b9>] memdup_user+0x44/0xf8 mm/util.c:197
    [<00000000684568ab>] strndup_user+0x8c/0xcc mm/util.c:256
    [<00000000b4cbc820>] __do_sys_fsconfig fs/fsopen.c:433 [inline]
    [<00000000b4cbc820>] __se_sys_fsconfig fs/fsopen.c:349 [inline]
    [<00000000b4cbc820>] __arm64_sys_fsconfig+0x728/0x7b0 fs/fsopen.c:349
    [<000000003ab31b26>] __invoke_syscall
arch/arm64/kernel/syscall.c:37 [inline]
    [<000000003ab31b26>] invoke_syscall.constprop.0+0x6c/0x134
arch/arm64/kernel/syscall.c:51
    [<00000000dbee991c>] el0_svc_common arch/arm64/kernel/syscall.c:136 [inline]
    [<00000000dbee991c>] do_el0_svc+0x78/0x158 arch/arm64/kernel/syscall.c:155
    [<000000009a39103d>] el0_svc+0x4c/0x158 arch/arm64/kernel/entry-common.c:678
    [<00000000c2657137>] el0t_64_sync_handler+0x100/0x12c
arch/arm64/kernel/entry-common.c:696
    [<00000000b52cd424>] el0t_64_sync+0x194/0x198 arch/arm64/kernel/entry.S:599

BUG: memory leak
unreferenced object 0xffff000004aa9a40 (size 16):
  comm "syz-executor276", pid 965, jiffies 4294943562 (age 5.450s)
  hex dump (first 16 bytes):
    2e 2d 7d 2e 27 5d 23 fe 00 00 00 00 00 00 00 00  .-}.']#.........
  backtrace:
    [<00000000cf09e3ce>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
    [<00000000cf09e3ce>] slab_post_alloc_hook mm/slab.h:765 [inline]
    [<00000000cf09e3ce>] slab_alloc_node mm/slub.c:3478 [inline]
    [<00000000cf09e3ce>] __kmem_cache_alloc_node+0x1a8/0x234 mm/slub.c:3517
    [<00000000643fc445>] __do_kmalloc_node mm/slab_common.c:1025 [inline]
    [<00000000643fc445>] __kmalloc_node_track_caller+0x48/0x74
mm/slab_common.c:1046
    [<00000000a19493b9>] memdup_user+0x44/0xf8 mm/util.c:197
    [<00000000684568ab>] strndup_user+0x8c/0xcc mm/util.c:256
    [<00000000b4cbc820>] __do_sys_fsconfig fs/fsopen.c:433 [inline]
    [<00000000b4cbc820>] __se_sys_fsconfig fs/fsopen.c:349 [inline]
    [<00000000b4cbc820>] __arm64_sys_fsconfig+0x728/0x7b0 fs/fsopen.c:349
    [<000000003ab31b26>] __invoke_syscall
arch/arm64/kernel/syscall.c:37 [inline]
    [<000000003ab31b26>] invoke_syscall.constprop.0+0x6c/0x134
arch/arm64/kernel/syscall.c:51
    [<00000000dbee991c>] el0_svc_common arch/arm64/kernel/syscall.c:136 [inline]
    [<00000000dbee991c>] do_el0_svc+0x78/0x158 arch/arm64/kernel/syscall.c:155
    [<000000009a39103d>] el0_svc+0x4c/0x158 arch/arm64/kernel/entry-common.c:678
    [<00000000c2657137>] el0t_64_sync_handler+0x100/0x12c
arch/arm64/kernel/entry-common.c:696
    [<00000000b52cd424>] el0t_64_sync+0x194/0x198 arch/arm64/kernel/entry.S:599

C reproducer:

// https://None.appspot.com/bug?id=322fa31c4d8d351912142d420387672b633b8f48
// autogenerated by syzkaller (https://github.com/google/syzkaller)

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

#ifndef __NR_fsconfig
#define __NR_fsconfig 431
#endif
#ifndef __NR_fsopen
#define __NR_fsopen 430
#endif
#ifndef __NR_mmap
#define __NR_mmap 222
#endif

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

#define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"

static void setup_leak()
{
  if (!write_file(KMEMLEAK_FILE, "scan"))
    exit(1);
  sleep(5);
  if (!write_file(KMEMLEAK_FILE, "scan"))
    exit(1);
  if (!write_file(KMEMLEAK_FILE, "clear"))
    exit(1);
}

static void check_leaks(void)
{
  int fd = open(KMEMLEAK_FILE, O_RDWR);
  if (fd == -1)
    exit(1);
  uint64_t start = current_time_ms();
  if (write(fd, "scan", 4) != 4)
    exit(1);
  sleep(1);
  while (current_time_ms() - start < 4 * 1000)
    sleep(1);
  if (write(fd, "scan", 4) != 4)
    exit(1);
  static char buf[128 << 10];
  ssize_t n = read(fd, buf, sizeof(buf) - 1);
  if (n < 0)
    exit(1);
  int nleaks = 0;
  if (n != 0) {
    sleep(1);
    if (write(fd, "scan", 4) != 4)
      exit(1);
    if (lseek(fd, 0, SEEK_SET) < 0)
      exit(1);
    n = read(fd, buf, sizeof(buf) - 1);
    if (n < 0)
      exit(1);
    buf[n] = 0;
    char* pos = buf;
    char* end = buf + n;
    while (pos < end) {
      char* next = strstr(pos + 1, "unreferenced object");
      if (!next)
        next = end;
      char prev = *next;
      *next = 0;
      fprintf(stderr, "BUG: memory leak\n%s\n", pos);
      *next = prev;
      pos = next;
      nleaks++;
    }
  }
  if (write(fd, "clear", 5) != 5)
    exit(1);
  close(fd);
  if (nleaks)
    exit(1);
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
    check_leaks();
  }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void)
{
  intptr_t res = 0;
  memcpy((void*)0x20000000, "sysfs\000", 6);
  res = syscall(__NR_fsopen, /*type=*/0x20000000ul, /*flags=*/0ul);
  if (res != -1)
    r[0] = res;
  memcpy((void*)0x20000640, "smackfstransmute", 16);
  memcpy((void*)0x20000680, ".-}.\']#\376\000", 9);
  syscall(__NR_fsconfig, /*fd=*/r[0], /*cmd=*/1ul, /*key=*/0x20000640ul,
          /*value=*/0x20000680ul, /*aux=*/0ul);
}
int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  setup_leak();
  loop();
  return 0;
}




Best regards,

Lukas

