Return-Path: <linux-kernel+bounces-101059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED487A1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB201282AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7996ECA4A;
	Wed, 13 Mar 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNgvDw+W"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15CC122
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710298410; cv=none; b=QZOAkdVPBdrN453pFwPJ7u//WOd8AMkxkLfRYj/jGynhZ1LuujlYXcv8TyNjhGnNY9/WjLMd5OB1csEk1o3aVkMhUM8WnIDxcTDpy1l4bToXNhh3zG9IDkuAtZv+26EKEnKqZTUNUZoEyIYv1X0Zx0O3/mQF5mjiBjGgYJmmJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710298410; c=relaxed/simple;
	bh=mfxUoHcNMF2gk2gmpTCyNw/571AIksLqulcTMRkIn0U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kPyvhipcyrUVkSAQBkctj9Ywr3pyI7B7VRjcpysYpk2yR+pYNO+S6nQM8yHsw2kDkTLpPfpwhK3xQG4qGUxbfv/zxnc/dO+uO37Pm0e7uB4eD5nNu2fukfUTGB8QINYe1LemZqX8TfpgjuDD7f5WJ8OVlu9lHTz0E/fK6pIF46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNgvDw+W; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5683093ffbbso7262996a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710298407; x=1710903207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wNq1j2TllPPXhyK+5cXK8U8CFe2aAywzojzjA3Xpjyk=;
        b=HNgvDw+WAZ+E1/CBBHLXavzHgsGcTmckLVO+C+F5LoKlk2GTB/WlteH1s+Hgst4i0q
         XVjMfE+TLXSJWmHrbs7Z75AcoQtEgyTQBTUIO4S+aLIlQ9Zi1KtiiNOdL7W2it05A4WP
         E97EW1E7dFsk0SybbiMIEqZaoAk7gtMGBvMTF1KuHWfp5oGd3ZKp8Ugr/JLYNGDfgRlp
         XeohykxZ1+PNZnmCWTOkL4bofLesx6EinSIK4fsaY4s6rAvmGAnN2Qv+XG/kslgjLDV4
         UAxZQLREPisKfE1ib1sWfpQoEqgo4s6ee9IxGhA0qDGeATQg+S50mXGo04ftTHcVFwMu
         5HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710298407; x=1710903207;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNq1j2TllPPXhyK+5cXK8U8CFe2aAywzojzjA3Xpjyk=;
        b=YR02Se2Xr5XQU3/zN1VqStXW1ncIc7C7g3Zh9yaB8Q12JkPQK6ll9Gqengui30luF6
         GraJ1cUgu8d7bpPl/z1xilrTXHAOCbyepM6HVkktUI1dNgSwSQGpSjVTISYoV7FwU/EP
         Hk4iQP6rSBEK+AQe+IdN3lxQWsifX2vKMUZqtmk1gCJPc+FsgCb9m5HHa4fVn+ma0upS
         Ggfr5f5VAx+ErqRPTwIXzcUn8D/4WEqUMCYNQVpK+P0Pf/rasmM5U3vI6SGx+N4gCP6n
         gQl0ZL4ydeWSjHh9O9OAb+oHX4F7oChKtIvPHjqqtdbMmcnqyfatoWWE+dYL5O1/9854
         OS2g==
X-Forwarded-Encrypted: i=1; AJvYcCUGipHdKW8EgzaVhPE52ZKvNYgJHbqrTs1iUAUSuOkguE3So/WCm0CNyQATO4jV+S7NyuRxcrhU0LSAnxshCApPvBza0EYAiE/XxzX7
X-Gm-Message-State: AOJu0YyNoNJrpaWXKzyZJlCjQOFbigibA6sc0q9iEsWj5GFQcJbxBseE
	uLiTno8fYkiOj8jLDaqCIqnnGzkSsxwhWvFFYqU/n1gmOULWdRpbJ3PcsEsPJdHfOhTjoAtUVky
	Huaauz9N9eAgClC1xxvolJ6YfRtg=
X-Google-Smtp-Source: AGHT+IHS5oqmlrV+olpSzmdNtHnZV9zk2lEeYrHyJTrf6VcMYEyA2fUgoRS6eTUYBCU05zt/o9R3Ff6u/PYAocx4aR0=
X-Received: by 2002:a17:906:eb53:b0:a46:300c:626e with SMTP id
 mc19-20020a170906eb5300b00a46300c626emr4701822ejb.46.1710298407015; Tue, 12
 Mar 2024 19:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Wed, 13 Mar 2024 10:53:15 +0800
Message-ID: <CAKHoSAuWKO0b3bK-DdT_CDVHrpaB_iUP2pwJujtTAs4JGy-1bA@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in arch_adjust_kprobe_addr
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jinghao Jia <jinghao7@illinois.edu>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)

git tree: upstream

console output: https://pastebin.com/raw/iw2bFsWa

kernel config: https://pastebin.com/raw/Ta59KYzh

C reproducer: https://pastebin.com/raw/JDqeSxiK

Syzlang reproducer: https://pastebin.com/raw/Vjs199hz


If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------


BUG: unable to handle page fault for address: ffffffff95003e80
audit: type=1400 audit(1710291918.880:7): avc:  denied  { open } for
pid=298 comm="syz-executor372" scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:system_r:kernel_t:s0 tclass=perf_event permissive=1
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1c4a7067 P4D 1c4a7067 PUD 1c4a8063
audit: type=1400 audit(1710291918.880:8): avc:  denied  { kernel } for
 pid=298 comm="syz-executor372" scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:system_r:kernel_t:s0 tclass=perf_event permissive=1
PMD 800fffffe29ff062
Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 298 Comm: syz-executor372 Not tainted 6.7.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:arch_adjust_kprobe_addr+0x42/0x180 arch/x86/kernel/kprobes/core.c:338
Code: 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f b6 14 02
48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 09 01 00 00 <44> 8b
6d 00 41 81 fd 66 0f 1f 00 74 18 e8 3c e5 30 00 41 81 e5 ff
RSP: 0018:ffff888112af7a68 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff902cd938
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff95003e80
RBP: ffffffff95003e80 R08: ffff8881bec62da8 R09: ffffffff930000eb
R10: ffffffff906e4e58 R11: ffffffff92f009b3 R12: ffff888112af7b70
R13: ffff888107f5e258 R14: ffff88810124c6f0 R15: 0000000000000001
FS:  000055555555e880(0000) GS:ffff8881c0000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff95003e80 CR3: 00000001036da005 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 _kprobe_addr+0x10e/0x140 kernel/kprobes.c:1479
 register_kprobe+0xe0/0x15b0 kernel/kprobes.c:1622
 __register_trace_kprobe kernel/trace/trace_kprobe.c:510 [inline]
 __register_trace_kprobe+0x233/0x2a0 kernel/trace/trace_kprobe.c:478
 create_local_trace_kprobe+0x209/0x370 kernel/trace/trace_kprobe.c:1821
 perf_kprobe_init+0xed/0x1b0 kernel/trace/trace_event_perf.c:267
 perf_kprobe_event_init+0xcc/0x180 kernel/events/core.c:10334
 perf_try_init_event+0x10d/0x4e0 kernel/events/core.c:11650
 perf_init_event kernel/events/core.c:11720 [inline]
 perf_event_alloc kernel/events/core.c:12000 [inline]
 perf_event_alloc+0xded/0x3310 kernel/events/core.c:11866
 __do_sys_perf_event_open+0x328/0x1d50 kernel/events/core.c:12507
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x43/0xf0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f92060ecb4d
Code: 28 c3 e8 36 29 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2df5c268 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f92060ecb4d
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020001200
RBP: 00007f92060a6500 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007f92060a65a0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffffff95003e80
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_adjust_kprobe_addr+0x42/0x180 arch/x86/kernel/kprobes/core.c:338
Code: 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f b6 14 02
48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 09 01 00 00 <44> 8b
6d 00 41 81 fd 66 0f 1f 00 74 18 e8 3c e5 30 00 41 81 e5 ff
RSP: 0018:ffff888112af7a68 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff902cd938
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff95003e80
RBP: ffffffff95003e80 R08: ffff8881bec62da8 R09: ffffffff930000eb
R10: ffffffff906e4e58 R11: ffffffff92f009b3 R12: ffff888112af7b70
R13: ffff888107f5e258 R14: ffff88810124c6f0 R15: 0000000000000001
FS:  000055555555e880(0000) GS:ffff8881c0000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff95003e80 CR3: 00000001036da005 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
note: syz-executor372[298] exited with irqs disabled
----------------
Code disassembly (best guess):
   0: 48 89 ea             mov    %rbp,%rdx
   3: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
   a: fc ff df
   d: 48 c1 ea 03           shr    $0x3,%rdx
  11: 0f b6 14 02           movzbl (%rdx,%rax,1),%edx
  15: 48 89 e8             mov    %rbp,%rax
  18: 83 e0 07             and    $0x7,%eax
  1b: 83 c0 03             add    $0x3,%eax
  1e: 38 d0                 cmp    %dl,%al
  20: 7c 08                 jl     0x2a
  22: 84 d2                 test   %dl,%dl
  24: 0f 85 09 01 00 00     jne    0x133
* 2a: 44 8b 6d 00           mov    0x0(%rbp),%r13d <-- trapping instruction
  2e: 41 81 fd 66 0f 1f 00 cmp    $0x1f0f66,%r13d
  35: 74 18                 je     0x4f
  37: e8 3c e5 30 00       callq  0x30e578
  3c: 41                   rex.B
  3d: 81                   .byte 0x81
  3e: e5 ff                 in     $0xff,%eax

