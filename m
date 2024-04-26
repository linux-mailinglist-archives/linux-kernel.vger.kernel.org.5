Return-Path: <linux-kernel+bounces-159418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A23A8B2E61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A634FB21846
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5433E1860;
	Fri, 26 Apr 2024 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2j7qadx"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C8EBB;
	Fri, 26 Apr 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714095757; cv=none; b=ph7383hJzITYeyZ+nB0ZR5iEV5oJcnAT5SO6H6i/MRtX5pq/UC/ConAHzRQ1fzaGFHF/MEup3zZOwE7oe64O7hnw11hI3cGZWoiF6xirWLhy/Y7Yr3TtQKUsvTmi+0gOCxPIybwyS17GwzjTk6Dgftpz3p3RwU5CaxaTF26gaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714095757; c=relaxed/simple;
	bh=PIxJSimy8O3ep3aN3r4eMxDk8FfqaOofl0bf6g9FHxk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oQ8XGA5hTv0/rMf/SxgFOpajFI1BKS61jgqQ86JRUT8eGIte/rpYBXfWbyrKbYQ61RzesUv+X2mEkbQUvGeR4711vV6YVmz31H1G8EQwSC9M4X+vKoO9CIYOJ+y55IbSeWJ5bQxnhauoOcOahP8QYHVAUf0c76TRYOrSVrdiNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2j7qadx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so1204496a91.0;
        Thu, 25 Apr 2024 18:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714095755; x=1714700555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XPVbpFUgykpXukVgH5RPq+94XG4ziHc5dIXEKcV3NXM=;
        b=D2j7qadxzy7trVV9lVHpIAd16jgFJWlFoAj88ay69a8dGQQVRoKaixMIX3l986+ZK4
         OfWCEBOK6+w/5fXYRY5ly2yCNXwXLdRYDDzJrZhMcZJeNk8vqu0ql64HaM4M/1KwTNj2
         vBQQX8x/PjqYF/pjbuyt9lR3X5aThdIPtrnhuueSdV3gdzpgkxEhxukgvfEe9rv6JlW2
         N1bSTvOCYbzesAcPINO1G4jiKQw6BU2zNV2/puU/J6kjokNWPGU18iGP93UVW7rx+/Bw
         onouEB4OtgXgyl8KMJK5vp4/tYHPlFETsydqj0llOM58gO/au5xxBIuAEp9F8b23yawb
         LPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714095755; x=1714700555;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPVbpFUgykpXukVgH5RPq+94XG4ziHc5dIXEKcV3NXM=;
        b=Y7OugSvXSMwJichD8I04hmxOlJZ7T2SxkUSPHqo4+CmVSx6KI8D9S8m+GFsXF/LEie
         euHAuPqSCOLW+P2ckmMZ5TodH32J6XScYCIipW4i31J72MVXPb1vd/yWZ8vGIL40I6/l
         RLGnTDGCxwMAbEGMUTOzjmw1LepQX34eekRLn5DN00CmAJTMtvgYR6Z0iI6Kfa0DGyUv
         Sa020MHWhkw7rd/9/kWy9zXlT6eNdLRxg53lR3+jFRuNBy1sH1LzoL5Ip0vezFQPbjw1
         eEXbYcfjc+ok+28sKHPIhBU0dQXecJPL8gKkjZkJEiVPavCqy/q2RynM19/7jytulQxE
         rJoA==
X-Forwarded-Encrypted: i=1; AJvYcCWjbg2hKiT8UWbxG4YnB1XQNTvhfj2de8ZGDM0LklVDl2k0MyklZELhT9BPkNNKRAp6wktC1Y4+RqsWmCveTmkbNKR8zC04sKzgUctFxanvGFFdVjESzKsf7WQ8YVM85Uwy9sMkrXTG5PrZTEeyeYbRsdZ0mdZIr/nHwXDstnGo4ckgAW99gA==
X-Gm-Message-State: AOJu0YztML3Czgbk84QmbRJVFauE8C7jzBXbcrV+gTceSzYJdFceh5T+
	b5Cakx/kDKqD9I7M9nSAboT/rDjUkyAphCU9/UuX9q8kVXsfuO6KFgF2ClcFLXmOMlAd0kUIlvf
	8NrmiQqU627DPSfE3WxPuGxOqQg4=
X-Google-Smtp-Source: AGHT+IF58aLHIDR4qSLnTb8yshqq5gvV1RdUXVE9ijfp6qxPGovExU5vDJXBKvxXVf5fJyFpUfb1gMpq+BveBnvQ1oo=
X-Received: by 2002:a17:90a:e2cd:b0:2ac:8198:848b with SMTP id
 fr13-20020a17090ae2cd00b002ac8198848bmr1604970pjb.18.1714095754860; Thu, 25
 Apr 2024 18:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Fri, 26 Apr 2024 09:42:23 +0800
Message-ID: <CABOYnLyTrBQdqWyrQRTJKt-ZzoGSVe7o2qQ0cC3KgX8KoQasUQ@mail.gmail.com>
Subject: Re: [syzbot] [perf?] BUG: using __this_cpu_add() in preemptible code
 in graph_lock
To: syzbot+60761fc6ef65e4f00974@syzkaller.appspotmail.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

I use the same kernel as syzbot instance:
https://syzkaller.appspot.com/bug?extid=60761fc6ef65e4f00974
Kernel Commit: bpf 443574b033876c85a35de4c65c14f7fe092222b2
Kernel Config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=6fb1be60a193d440

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
   *(uint32_t*)0x200009c0 = 0x12;
   *(uint32_t*)0x200009c4 = 4;
   *(uint32_t*)0x200009c8 = 8;
   *(uint32_t*)0x200009cc = 8;
   *(uint32_t*)0x200009d0 = 0;
   *(uint32_t*)0x200009d4 = -1;
   *(uint32_t*)0x200009d8 = 0;
   memset((void*)0x200009dc, 0, 16);
   *(uint32_t*)0x200009ec = 0;
   *(uint32_t*)0x200009f0 = -1;
   *(uint32_t*)0x200009f4 = 0;
   *(uint32_t*)0x200009f8 = 0;
   *(uint32_t*)0x200009fc = 0;
   *(uint64_t*)0x20000a00 = 0;
   res = syscall(__NR_bpf, /*cmd=*/0ul, /*arg=*/0x200009c0ul, /*size=*/0x48ul);
   if (res != -1)
       r[0] = res;
   *(uint32_t*)0x200000c0 = 0;
   *(uint32_t*)0x200000c4 = 0xc;
   *(uint64_t*)0x200000c8 = 0x20000440;
   memcpy((void*)0x20000440,

"\x18\x00\x00\x00\xa9\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x18"
                "\x11\x00\x00",
                20);
   *(uint32_t*)0x20000454 = r[0];
   memcpy((void*)0x20000458,

"\x00\x00\x00\x00\x00\x00\x00\x00\xb7\x08\x00\x00\x00\x00\x00\x00\x7b"

"\x8a\xf8\xff\x00\x00\x00\x00\xbf\xa2\x00\x00\x00\x00\x00\x00\x07\x02"

"\x00\x00\xf8\xff\xff\xff\xb7\x03\x00\x00\x08\x00\x00\x00\xb7\x04\x00"
                "\x00\x00\x00\x00\x00\x85\x00\x00\x00\x03\x00\x00\x00\x95",
                65);
   *(uint64_t*)0x200000d0 = 0;
   *(uint32_t*)0x200000d8 = 0;
   *(uint32_t*)0x200000dc = 0;
   *(uint64_t*)0x200000e0 = 0;
   *(uint32_t*)0x200000e8 = 0;
   *(uint32_t*)0x200000ec = 0;
   memset((void*)0x200000f0, 0, 16);
   *(uint32_t*)0x20000100 = 0;
   *(uint32_t*)0x20000104 = 0;
   *(uint32_t*)0x20000108 = -1;
   *(uint32_t*)0x2000010c = 0;
   *(uint64_t*)0x20000110 = 0;
   *(uint32_t*)0x20000118 = 0;
   *(uint32_t*)0x2000011c = 0;
   *(uint64_t*)0x20000120 = 0;
   *(uint32_t*)0x20000128 = 0;
   *(uint32_t*)0x2000012c = 0;
   *(uint32_t*)0x20000130 = 0;
   *(uint32_t*)0x20000134 = 0;
   *(uint64_t*)0x20000138 = 0;
   *(uint64_t*)0x20000140 = 0;
   *(uint32_t*)0x20000148 = 0;
   *(uint32_t*)0x2000014c = 0;
   syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200000c0ul, /*size=*/0x90ul);
   *(uint32_t*)0x200000c0 = 0x11;
   *(uint32_t*)0x200000c4 = 0xc;
   *(uint64_t*)0x200000c8 = 0x20000440;
   *(uint64_t*)0x200000d0 = 0x20000240;
   memcpy((void*)0x20000240, "GPL\000", 4);
   *(uint32_t*)0x200000d8 = 0;
   *(uint32_t*)0x200000dc = 0;
   *(uint64_t*)0x200000e0 = 0;
   *(uint32_t*)0x200000e8 = 0;
   *(uint32_t*)0x200000ec = 0;
   memset((void*)0x200000f0, 0, 16);
   *(uint32_t*)0x20000100 = 0;
   *(uint32_t*)0x20000104 = 0;
   *(uint32_t*)0x20000108 = -1;
   *(uint32_t*)0x2000010c = 0;
   *(uint64_t*)0x20000110 = 0;
   *(uint32_t*)0x20000118 = 0;
   *(uint32_t*)0x2000011c = 0;
   *(uint64_t*)0x20000120 = 0;
   *(uint32_t*)0x20000128 = 0;
   *(uint32_t*)0x2000012c = 0;
   *(uint32_t*)0x20000130 = 0;
   *(uint32_t*)0x20000134 = 0;
   *(uint64_t*)0x20000138 = 0;
   *(uint64_t*)0x20000140 = 0;
   *(uint32_t*)0x20000148 = 0;
   *(uint32_t*)0x2000014c = 0;
   res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200000c0ul, /*size=*/0x90ul);
   if (res != -1)
       r[1] = res;
   *(uint64_t*)0x20000180 = 0x20000080;
   memcpy((void*)0x20000080, "contention_end\000", 15);
   *(uint32_t*)0x20000188 = r[1];
   syscall(__NR_bpf, /*cmd=*/0x11ul, /*arg=*/0x20000180ul, /*size=*/0x10ul);
}
int main(void) {
   syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
                   /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/
0x32ul, /*fd=*/-1,
                   /*offset=*/0ul);
   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
                   /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
                   /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/
0x32ul, /*fd=*/-1,
                   /*offset=*/0ul);
   syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
                   /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/
0x32ul, /*fd=*/-1,
                   /*offset=*/0ul);
   loop();
   return 0;
}


=* repro.txt =*
r0 = bpf$MAP_CREATE(0x0, &(0x7f00000009c0)=@base={0x12, 0x4, 0x8, 0x8}, 0x48)
bpf$PROG_LOAD(0x5, &(0x7f00000000c0)={0x0, 0xc,
&(0x7f0000000440)=ANY=[@ANYBLOB="18000000a9000000000000000200000018110000",
@ANYRES32=r0, @ANYBLOB="0000000000000000b7080000000000007b8af8ff00000000bfa200000000000007020000f8ffffffb703000008000000b704000000000000850000000300000095"],
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x0, 0xffffffffffffffff,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, 0x90)
r1 = bpf$PROG_LOAD(0x5, &(0x7f00000000c0)={0x11, 0xc,
&(0x7f0000000440)=ANY=[], &(0x7f0000000240)='GPL\x00', 0x0, 0x0, 0x0,
0x0, 0x0, '\x00', 0x0, 0x0, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, 0x90)
bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f0000000180)={&(0x7f0000000080)='contention_end\x00', r1}, 0x10)

and see also in
https://gist.github.com/xrivendell7/db53a0e46672f13acc6797e8d99729d3

I hope it helps.
Best regards
xingwei lee

