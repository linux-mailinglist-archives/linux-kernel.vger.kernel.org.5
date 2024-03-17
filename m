Return-Path: <linux-kernel+bounces-105389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334787DD3B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D3C1C2092D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6F11BC57;
	Sun, 17 Mar 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSk7u4VI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD01BC30
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710680235; cv=none; b=B8a/NxjHzQXUrpKnVlQ0c+Z6tjvXqkEq4wsms3vVPZ2rZ04USzRnvbdENPf8ewXqzt7T4mT/GkyAAWTkD3CvBIeShGcejkqGleFnTnkIJPG+CPGc0GdKGbEyBAEwEsdHavjg1M7BI6doqLrSUWbE9Jprt60b0h4ptlhw5LafTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710680235; c=relaxed/simple;
	bh=lc36DdAxn0rHBZyiltihGVeZ46jLuBlOH5NHV0k+tYU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NQwcZG4pJAYl832GAvjQd43hJG9MGLaTbrBPK4JNAhgsZALG+YSVult+c7/Sth2YJZ7rpEdVEOq4hJEmJd2um1GmdQE3s1IAo7DlgP1nQchVd5Z7HDvm4gQGy42hzvJjWwBl0yhHMkF3wzb5GNQukm0otu4l8114KZSRkUPqph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSk7u4VI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568aa3096e9so3744637a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710680231; x=1711285031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eVoGTBJUp3BbV6NfDLt15vJ1FZo8CfrjmTE1ytSRGTQ=;
        b=kSk7u4VIby8cbdJxwKyYzm7MMPYYLwHJb9ID+nN2SGkwPElEg2M6w+FxVes12GqV0z
         E4FEVT0q7o0WaYcblpZN4GVsa+TUel8QeqvcVgswtLuAECZ8/x/XXKjisqN5a1f3ye+4
         FvY5BdXrP3eb8Bk4SfYNxIGaakxhYUhBqsYpLz8F4o4UxhPEPjt7Bx5DXqJusFHYNUrS
         uCoZRyFrvdzigKtGK0Od0KajhcxnKjcO4QRwJEC+pjtR2fPcpcAQhtOI+IBtfRPIX4j5
         KtAhC/Ke09heiMaFph0qMKXas3j3N1YBdKqzaN/mb5GmbMjT/mP6D8AgYoIo0xlOXPP9
         dVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710680231; x=1711285031;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVoGTBJUp3BbV6NfDLt15vJ1FZo8CfrjmTE1ytSRGTQ=;
        b=cqMeo88HZ8FKm5hnNlqa9WPblp/psLxm9oveYpGxkM3uRcMuxa30wQ35NcaHD//yhC
         dG+RrGcyaj0GTwYESWBJIKhxaFtG66dkJWVbbsTkDJh2RtrfC1TCltpw5rMYBDDRpZ6H
         8QPNHGGKxHKRH2aQxbP3VkCDGBijl7l+jbJa/MDcohnbC76B3sinNQRbIm3+n+NoXjvs
         jZHFsdvWYWxjdxzTF1y4DvqiKrIE6duh5Sx4QL5Z9IBwyjIR894S6I0bWisidP69WurM
         OA8iUuuVneJFo7HBRN+FKqJEjK56GgpNXKMqZ1c1L/V7kfmpWhZd+ELTw2v+aSMVJqx0
         pvNA==
X-Forwarded-Encrypted: i=1; AJvYcCXxZcenOmDnHE0NwPJPuuUHCxF5Jol1a2Z6t/XIuCC4OEOmQ+uYW6A4Ka/xTmbwKCriVabGViy9d/uzlX4NpJbRD1vMNfqwVuEHJQo4
X-Gm-Message-State: AOJu0YwE0mFAgPTPWWWTXnLZaRzJFMuvA2/u8MOkEsyuGsxgZ+xYR0no
	VmpkjClcue6kLTIy0ql9AenIkEAIm1FSzbhMQ6+2imavHEIblQ6MoW1H2zj+qs9EQLHGSoW2mxd
	zOS2HuSxf1J2V8zaMpa1bAFzpb8s=
X-Google-Smtp-Source: AGHT+IFR5d1ViO/fD+SzvfulrBCAJbLzhAHF+tiIG+WaaeO1jrmmSJtz4ZJPaKKUGiSoESB0jGnePZZQVPoQDZ54vXE=
X-Received: by 2002:a17:906:2a58:b0:a46:9f12:ca2a with SMTP id
 k24-20020a1709062a5800b00a469f12ca2amr3578745eje.22.1710680231144; Sun, 17
 Mar 2024 05:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Sun, 17 Mar 2024 20:56:59 +0800
Message-ID: <CAKHoSAt10iG-GD_4GAjRRsRenBAf5UzhjqVaF+XaAtfWb0bTHQ@mail.gmail.com>
Subject: INFO: rcu detected stall in sys_openat
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)

git tree: upstream

console output: https://pastebin.com/raw/U8LEMxbT

kernel config: https://pastebin.com/raw/4m4ax5gq

C reproducer: https://pastebin.com/raw/VBcKSXKD

Syzlang reproducer: https://pastebin.com/raw/cWT05xCx

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 1-...!: (1 GPs behind) idle=7a44/1/0x4000000000000000
softirq=29512/29515 fqs=0
workqueue: Failed to create a rescuer kthread for wq
"ext4-rsv-conversion": -EINTR
rcu: 4-...!: (1 GPs behind) idle=321c/1/0x4000000000000000
softirq=29628/29631 fqs=0
EXT4-fs: failed to create workqueue
rcu: Tasks blocked on level-0 rcu_node (CPUs 0-4): P151/1:b..l P121/1:b..l
rcu: (detected by 4, t=23144 jiffies, g=52361, q=1156 ncpus=5)
Sending NMI from CPU 4 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 104 Comm: systemd-journal Not tainted 6.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:deref_stack_reg arch/x86/kernel/unwind_orc.c:403 [inline]
RIP: 0010:unwind_next_frame+0xd02/0x2600 arch/x86/kernel/unwind_orc.c:585
Code: 74 e5 33 00 4d 8d 75 f8 ba 08 00 00 00 48 89 df 4c 89 f6 e8 80
f0 ff ff 31 ff 89 c6 88 44 24 28 e8 13 de 33 00 0f b6 44 24 28 <4c> 8d
43 40 84 c0 0f 84 65 f6 ff ff e8 3d e5 33 00 4c 89 f7 e8 15
RSP: 0018:ffff88811af09a10 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffff88811af09a90 RCX: ffffffff90927fdd
RDX: ffff8881043c0000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffffff957d2d14 R08: ffff88811af09ad0 R09: ffff88811af09a90
R10: 0000000000000001 R11: 1ffff110235e715c R12: 0000000000000002
R13: ffff8881043cf1a8 R14: ffff8881043cf1a0 R15: ffffffff957d2d18
FS:  00007faf0ef5f900(0000) GS:ffff88811af00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faf0dfabba0 CR3: 000000010b09c003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 arch_stack_walk+0xe6/0x160 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x90/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:589
 poison_slab_object mm/kasan/common.c:240 [inline]
 poison_slab_object mm/kasan/common.c:211 [inline]
 __kasan_slab_free+0x106/0x190 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x97/0x220 mm/slub.c:4363
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x5f1/0x19d0 kernel/rcu/tree.c:2465
 __do_softirq+0x18a/0x575 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0x7e/0xb0 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x75/0x80 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:get_current arch/x86/include/asm/current.h:42 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:206
Code: 48 8b 33 b9 03 00 00 00 eb 85 0f 1f 84 00 00 00 00 00 90 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 0c 24 <65> 48
8b 14 25 00 75 03 00 65 8b 05 c0 0f 3d 6f a9 00 01 ff 00 74
RSP: 0018:ffff8881043cf258 EFLAGS: 00000286
RAX: 0000000000000000 RBX: ffff8881043cf2e0 RCX: ffffffff90927475
RDX: ffff8881043c0000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffff8881043cf320 R09: ffff8881043cf2e0
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff90fdc428 R14: ffff8881043cf321 R15: ffff8881043cf380
 orc_find arch/x86/kernel/unwind_orc.c:202 [inline]
 unwind_next_frame+0x195/0x2600 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0xe6/0x160 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x90/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x59/0x70 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_lru+0xde/0x250 mm/slub.c:3879
 __d_alloc+0x31/0x8b0 fs/dcache.c:1624
 d_alloc+0x44/0x1e0 fs/dcache.c:1704
 d_alloc_parallel+0xe6/0xb00 fs/dcache.c:2462
 __lookup_slow+0x10b/0x3e0 fs/namei.c:1678
 lookup_slow fs/namei.c:1710 [inline]
 walk_component+0x346/0x5b0 fs/namei.c:2005
 link_path_walk.part.0.constprop.0+0x788/0xce0 fs/namei.c:2332
 link_path_walk fs/namei.c:2257 [inline]
 path_openat+0x274/0x36f0 fs/namei.c:3798
 do_filp_open+0x1c9/0x420 fs/namei.c:3829
 do_sys_openat2+0x164/0x1d0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x140/0x1f0 fs/open.c:1430
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7faf0f8141a4
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 58 f9 ff 44 8b 54 24 0c
44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 58 f9 ff 8b 44
RSP: 002b:00007ffd17d44e80 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000560a53366d60 RCX: 00007faf0f8141a4
RDX: 0000000000080802 RSI: 0000560a533a3070 RDI: 00000000ffffff9c
RBP: 0000560a533a3070 R08: 0000000000000000 R09: ffffffffffffff01
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080802
R13: 00000000fffffffa R14: 0000560a533a0a40 R15: 0000000000000002
 </TASK>
CPU: 4 PID: 9150 Comm: systemd-udevd Not tainted 6.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:finish_task_switch.isra.0+0x178/0x850 kernel/sched/core.c:5274
Code: 00 00 49 8b 9c 24 c8 09 00 00 48 85 db 0f 85 1d 04 00 00 e8 ea
7a 24 00 4c 89 e7 e8 c2 ac f5 02 fb 65 4c 8b 24 25 00 75 03 00 <49> 8d
bc 24 38 0a 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
RSP: 0018:ffff88801a4ef9d8 EFLAGS: 00000212
RAX: 0000000040000000 RBX: 0000000000000000 RCX: ffffffff90a1ea4e
RDX: ffff888102e0a200 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff88801a4efa20 R08: 0000000000000000 R09: fffffbfff2a119d2
R10: 0000000000000000 R11: 000000000000cc85 R12: ffff888102e0a200
R13: ffff8881029f1100 R14: ffff888102e0a200 R15: ffff888102e0a200
FS:  00007ff2754708c0(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffbd72bb910 CR3: 000000001e928004 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 context_switch kernel/sched/core.c:5403 [inline]
 __schedule+0xd3c/0x2460 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x90/0x250 kernel/sched/core.c:6817
 schedule_hrtimeout_range_clock+0x3a4/0x3e0 kernel/time/hrtimer.c:2295
 ep_poll fs/eventpoll.c:1920 [inline]
 do_epoll_wait+0xf92/0x14b0 fs/eventpoll.c:2317
 __do_sys_epoll_wait fs/eventpoll.c:2329 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2324 [inline]
 __x64_sys_epoll_wait+0x15a/0x260 fs/eventpoll.c:2324
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7ff27592cd16
Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41
89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 e8 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 18 48 89 74 24
RSP: 002b:00007ffdc170f468 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00005621013ef320 RCX: 00007ff27592cd16
RDX: 0000000000000002 RSI: 00005621013a40a0 RDI: 0000000000000003
RBP: ffffffffffffffff R08: 0000000000000002 R09: 0000000000000004
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000002 R14: 00005620ff6bd1e7 R15: 0000000000000000
 </TASK>
task:systemd-udevd   state:R  running task     stack:26640 pid:121
tgid:121   ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xd34/0x2460 kernel/sched/core.c:6727
 preempt_schedule_common kernel/sched/core.c:6904 [inline]
 preempt_schedule+0x7f/0xb0 kernel/sched/core.c:6928
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:45
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x80/0xa0 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock kernel/sched/wait.c:108 [inline]
 __wake_up_sync_key+0x50/0x60 kernel/sched/wait.c:173
 sock_def_readable+0x99/0x270 net/core/sock.c:3342
 __netlink_sendskb+0x12a/0x190 net/netlink/af_netlink.c:1288
 netlink_sendskb net/netlink/af_netlink.c:1294 [inline]
 netlink_unicast+0x7d5/0x920 net/netlink/af_netlink.c:1382
 netlink_sendmsg+0x887/0xd60 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xa0d/0xbd0 net/socket.c:2584
EXT4-fs (loop0): mount failed
 ___sys_sendmsg+0x11d/0x1c0 net/socket.c:2638
 __sys_sendmsg+0xfe/0x1d0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7ff275a17e13
RSP: 002b:00007ffdc170f428 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000056210139dbf0 RCX: 00007ff275a17e13
RDX: 0000000000000000 RSI: 00007ffdc170f450 RDI: 0000000000000004
RBP: 00005621013b5620 R08: 00005620ff6a5540 R09: 0000000000000012
R10: 00007ff2759ffb80 R11: 0000000000000246 R12: 0000000000000000
R13: 0000562100b323d0 R14: 00005621013a37e8 R15: 00007ffdc170f4e0
 </TASK>
loop0: detected capacity change from 0 to 512
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
nfs: Unknown parameter 'resuid'
EXT4-fs (loop0): encrypted files will use data=ordered instead of data
journaling mode
workqueue: Failed to create a rescuer kthread for wq
"ext4-rsv-conversion": -EINTR
EXT4-fs: failed to create workqueue
EXT4-fs (loop0): mount failed
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1
prio class 0
loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): encrypted files will use data=ordered instead of data
journaling mode
EXT4-fs error (device loop0): ext4_orphan_get:1394: inode #15: comm
syz-executor.0: iget: bad extended attribute block 327680
EXT4-fs error (device loop0): ext4_orphan_get:1397: comm
syz-executor.0: couldn't read orphan inode 15 (err -117)
EXT4-fs (loop0): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
writeback.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
9pnet: p9_errstr2errno: server reported unknown error
warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
netlink: 'syz-executor.0': attribute type 4 has an invalid length.

