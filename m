Return-Path: <linux-kernel+bounces-105386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9487DD30
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B4B281564
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440EB1B947;
	Sun, 17 Mar 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR3mKEo+"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AEB171A4;
	Sun, 17 Mar 2024 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710679261; cv=none; b=rcTak+lThC8P7ntLe8DTtTRBocqWWCCdR3BN1hrChabJdixWmxZbb1N0MxifMbVXfQFdcoIejjDi0aHljRocrzQWU8bXzNo1mAhKXQ7vLfxBYahy1Kj2FdJkaIaOrWwXJo1+1/XB5jt9jNnthccq1x2/9cN9MNJOjsOzOU5Xorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710679261; c=relaxed/simple;
	bh=WUK5XR4EZLBhVUMYUoC1c/RK7DRyS8/5DmYTJI7bqcE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aqrGy5csBE/YJdo8J0scYzhN9z28UvANfUVlYdhm3eOval0Rnjef1jYMqsZYPvHkKMlOrgW0xlTV6sZhC/V7SQBbTf9B9RIidX3bNXnICCZBIoDKBx8rPSxedS4HeYvpR0/77dZHh7BVZZGjIf7+HgrRTsJr8EafeIH7k4MblhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR3mKEo+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56a0c0a7ebcso54897a12.1;
        Sun, 17 Mar 2024 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710679258; x=1711284058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDzui+Q39h2/h7pGYFkrB6LyGe5RnKuDPwufhX4zo/o=;
        b=GR3mKEo+3XGOtn19mSL+PxEKkIhQ/mSObCQTIwx4rnzE3DeNWigAqI0oN/n3lslKSJ
         xKfuyl0MX+f5mKrcvIU4iVbsQMFxbtZTOcMW/gV2k/T2crgYl33KsVCVVHBxD987yepy
         C5Sj5kjAars7JosdvKLtV4Mj3eaMWxhceDzcMY0iQV6I+jExdsxvys+8i04dAtqlnxT6
         8BPbAw2grmQuHzN4khuOzgWpyuw4QBfqRK93wtTiSEV4tRjbfw1Wa9rMH24me4HjYfa9
         PruJH1tWJ/LBV/ZACxB5m59mAJ2jBTk1vIGr3GsPBbkCEkhPn1yqkVgri8Q9bzdtoyZ7
         422Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710679258; x=1711284058;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDzui+Q39h2/h7pGYFkrB6LyGe5RnKuDPwufhX4zo/o=;
        b=S1u8SFkYd6SdfuLz+uMfFyvp41FH91dFg9p/lAqbGYycul3s5hwTOhqNY7BGHbgKqE
         ZUj/5lsqF0UB7a6DZAqDXIZehJNKNfJb4YxnEoBpdUOlMiYOgtPfiMHNsOzLUXW0wUlw
         jbltQud0IOB/jTqzpOS7GGgl1yzh9IEgknU7FK9udrAbZApRiI68AeauW7BkAjXYvfb5
         6JhuibMzJDQNYGCwOKa9HVAvIpzmzuQE7wbUQKMpzquvM+e0PUvOzR8hwMBNxyhBfEFV
         ddVWAoTFvo2vhrsVoDC1dynwPxPd6OHWOuO5v9vV6wvmIegi48s1IovE0N3vxGw3rs2L
         BAxA==
X-Forwarded-Encrypted: i=1; AJvYcCUosG/oLxvXg3rIV+A2Ds+/+4USDzOCbYuSh7wy5SgBC9A17/N2LgCidhvahGyAW4FUHuqOB/CqPgWpVw/juVxsJbw4ZjnfJbi19coXkprGVicPnEozag35nctTO4sWZKBJ3Lti5hfTkjqVC8T+mg==
X-Gm-Message-State: AOJu0YySiiPwZ65npcd544bw4iIwRTREleaNMvzMMqa2T0boiBIqMX6R
	wQ8cMXxs7UpiDNnQUjnsRNsWBudPj3qoPDDIZ1mbIKUdlMZHhxhudUuXw8Vuis5/KShi0FffrXT
	N8Ogqdqf2fhkcWypDBkKikhmOcAw=
X-Google-Smtp-Source: AGHT+IH5aAjGSnHi8qSLxIOwiGgkyQcMhZStQfBV/zL5cK7h+AMS2ZRFQfpKnLBf8frPDExeISyrmioVcITHeBA9KK8=
X-Received: by 2002:a17:906:1194:b0:a45:c1a0:5c07 with SMTP id
 n20-20020a170906119400b00a45c1a05c07mr5488857eja.17.1710679257725; Sun, 17
 Mar 2024 05:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Sun, 17 Mar 2024 20:40:46 +0800
Message-ID: <CAKHoSAsF+k-nf9CtHfrB9HODEj_iVmNbgtTCMTtx9epcJTmwKw@mail.gmail.com>
Subject: WARNING in intel_pmu_lbr_counters_reorder
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72  (tag: v6.8-rc7)

git tree: upstream

console output: https://pastebin.com/raw/LcT7Dv8f

kernel config: https://pastebin.com/raw/aKPdyw3m

C reproducer: https://pastebin.com/raw/twMjJuni

Syzlang reproducer: https://pastebin.com/raw/Yx0zjYTg

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>


-----------------------------------------------------------------------------


WARNING: CPU: 0 PID: 314 at arch/x86/events/intel/lbr.c:956
intel_pmu_lbr_counters_reorder.isra.0+0xe6/0x4e0
arch/x86/events/intel/lbr.c:956
Modules linked in:
CPU: 0 PID: 314 Comm: syz-executor323 Not tainted 6.8.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:intel_pmu_lbr_counters_reorder.isra.0+0xe6/0x4e0
arch/x86/events/intel/lbr.c:956
Code: 0f 85 ff 03 00 00 4c 8b a5 90 00 00 00 48 85 db 0f 85 c5 01 00
00 e8 09 09 5a 00 49 39 ec 0f 84 30 03 00 00 e8 fb 08 5a 00 90 <0f> 0b
90 c7 44 24 14 00 00 00 00 e8 ea 08 5a 00 48 8b 44 24 08 48
RSP: 0000:fffffe06d8a4b8f0 EFLAGS: 00010046
RAX: ffff8881110eaf80 RBX: ffff8881114d8000 RCX: ffffffff8f642ba5
RDX: 0000000080110003 RSI: ffff8881114d8000 RDI: ffff8881114d84a8
RBP: ffff8881114d8000 R08: fffffbfff29954b8 R09: ffffed102229b0d1
R10: ffffed102229b0d0 R11: ffff8881114d8687 R12: dffffc0000000000
R13: ffff8881c0022ec8 R14: ffff8881c0022bb8 R15: fffffe06d8a4bbc0
FS:  0000555555ab4880(0000) GS:ffff8881c0000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007eff2fe39010 CR3: 0000000105540001 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <NMI>
 intel_pmu_lbr_save_brstack+0x1af/0x350 arch/x86/events/intel/lbr.c:975
 handle_pmi_common+0x5aa/0x9a0 arch/x86/events/intel/core.c:3058
 intel_pmu_handle_irq+0x205/0xc70 arch/x86/events/intel/core.c:3121
 perf_event_nmi_handler arch/x86/events/core.c:1743 [inline]
 perf_event_nmi_handler+0x42/0x70 arch/x86/events/core.c:1729
 nmi_handle+0xaf/0x2e0 arch/x86/kernel/nmi.c:150
 default_do_nmi+0x54/0x160 arch/x86/kernel/nmi.c:350
 exc_nmi+0x132/0x170 arch/x86/kernel/nmi.c:544
 end_repeat_nmi+0xf/0x60
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
RIP: 0010:static_key_false include/linux/jump_label.h:207 [inline]
RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:147 [inline]
RIP: 0010:wrmsrl arch/x86/include/asm/msr.h:262 [inline]
RIP: 0010:__intel_pmu_enable_all.constprop.0+0xf9/0x350
arch/x86/events/intel/core.c:2248
Code: ea 03 80 3c 02 00 0f 85 f1 01 00 00 4c 8b a3 d0 0d 00 00 b9 8f
03 00 00 49 f7 d4 4d 21 f4 4c 89 e2 44 89 e0 48 c1 ea 20 0f 30 <0f> 1f
44 00 00 e8 2d 69 5b 00 48 8d ab 00 02 00 00 be 08 00 00 00
RSP: 0018:ffff888111bd7980 EFLAGS: 00000002
RAX: 000000000000000f RBX: ffff8881c0022220 RCX: 000000000000038f
RDX: 0000000000000007 RSI: 0000000000000008 RDI: ffff8881c0022ff0
RBP: ffff8881c0022ba8 R08: 0000000000000021 R09: ffffed10380045ff
R10: ffffed10380045fe R11: ffff8881c0022ff7 R12: 000000070000000f
R13: 00000000000000b0 R14: 000000070000000f R15: 0000000000000021
 </NMI>
 <TASK>
 x86_pmu_enable+0x349/0xb20 arch/x86/events/core.c:1356
 perf_pmu_enable kernel/events/core.c:1153 [inline]
 perf_ctx_enable+0xed/0x170 kernel/events/core.c:706
 ctx_resched+0xa0/0xe0 kernel/events/core.c:2740
 __perf_install_in_context+0x2f1/0x820 kernel/events/core.c:2807
 remote_function kernel/events/core.c:92 [inline]
 remote_function+0x111/0x1a0 kernel/events/core.c:72
 csd_do_func kernel/smp.c:133 [inline]
 generic_exec_single kernel/smp.c:404 [inline]
 generic_exec_single+0x14f/0x390 kernel/smp.c:390
 smp_call_function_single+0x2bb/0x3a0 kernel/smp.c:647
 task_function_call+0xce/0x150 kernel/events/core.c:120
 perf_install_in_context+0x23e/0x480 kernel/events/core.c:2909
 __do_sys_perf_event_open+0x10a2/0x1d50 kernel/events/core.c:12768
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb4/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7eff2fdbebed
Code: c3 e8 37 2a 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcbbb21e48 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 000000000000bd9b RCX: 00007eff2fdbebed
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000002fd77c40
R10: 0000000000000003 R11: 0000000000000246 R12: 00007ffcbbb21e54
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
---[ end trace 0000000000000000 ]---
INFO: NMI handler (perf_event_nmi_handler) took too long to run: 2.678 msecs
perf: interrupt took too long (20898 > 2500), lowering
kernel.perf_event_max_sample_rate to 9000
perf: interrupt took too long (26124 > 26122), lowering
kernel.perf_event_max_sample_rate to 7000
perf: interrupt took too long (32789 > 32655), lowering
kernel.perf_event_max_sample_rate to 6000
perf: interrupt took too long (41339 > 40986), lowering
kernel.perf_event_max_sample_rate to 4000
perf: interrupt took too long (51743 > 51673), lowering
kernel.perf_event_max_sample_rate to 3000
perf: interrupt took too long (64806 > 64678), lowering
kernel.perf_event_max_sample_rate to 3000
perf: interrupt took too long (81009 > 81007), lowering
kernel.perf_event_max_sample_rate to 2000
perf: interrupt took too long (101467 > 101261), lowering
kernel.perf_event_max_sample_rate to 1000
----------------
Code disassembly (best guess), 2 bytes skipped:
   0: 80 3c 02 00           cmpb   $0x0,(%rdx,%rax,1)
   4: 0f 85 f1 01 00 00     jne    0x1fb
   a: 4c 8b a3 d0 0d 00 00 mov    0xdd0(%rbx),%r12
  11: b9 8f 03 00 00       mov    $0x38f,%ecx
  16: 49 f7 d4             not    %r12
  19: 4d 21 f4             and    %r14,%r12
  1c: 4c 89 e2             mov    %r12,%rdx
  1f: 44 89 e0             mov    %r12d,%eax
  22: 48 c1 ea 20           shr    $0x20,%rdx
  26: 0f 30                 wrmsr
* 28: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1) <-- trapping instruction
  2d: e8 2d 69 5b 00       callq  0x5b695f
  32: 48 8d ab 00 02 00 00 lea    0x200(%rbx),%rbp
  39: be 08 00 00 00       mov    $0x8,%esi

