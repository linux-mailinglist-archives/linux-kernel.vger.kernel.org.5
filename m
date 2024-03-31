Return-Path: <linux-kernel+bounces-126359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FD8935A1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B252831F5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E21474B5;
	Sun, 31 Mar 2024 19:40:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F35146D65
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711914025; cv=none; b=eXJjSvgoUpHO98vGoI+8p1+ITdK4Uc1G1SqXGA5ux4WTo9EbnEZL1KEX8BPTtR/gxI2ySrriy+sQbuuIyGT3g9xG8SSUhl1UsBMOVnyqsO/EnUZOPBHzXsq05v9+qPOy38Lxbs66oO+P+RVu4nvjXP5Hdo5o3H1BeiJ9FwTEkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711914025; c=relaxed/simple;
	bh=WtZO//oTkMb7qEM3wH6ldO8WMWnV6J+6osYZIZpSGdo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ibxbuT1SkRcmY1cRnkjvXAPVgptGolOvfTC8Hr3HsKDju7GqaJJ71JY+YkWDr0ApYMZjRcIXuRW9q+y2qAG4H/2cn6xv0Gov6dR9Clx0wcQE2VP86J1GigohASsPt6cnDCiE6TpTN3xvD+CYrBls7nVt/5jcVE2W6xnDFfwQvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36860170307so34111435ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 12:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711914023; x=1712518823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCMoD4Z1Eh6UfTpI37yPqo7ZeYs68XPjsHXktP/hjLE=;
        b=O2zapG0AIVdLl3OEiFO5fo7LBGdOcFfhf2H8LTVSe2+WuyqVKJCPvzY1QSyhx7HVul
         G9iS8n2VKxI+iVurUeHcrve24+/afGU70eHpDYkoX671Odts049v9mjLQ4Huau77L4Da
         AbyKCvwk3LR40MjHqZWmsSRRbgjqVHYwR53apVSvoVDqdstKbJTf+VFnzeD2dgwvNv0Q
         nA+eKur+lLS3SYdQSO+hpFqg2guAJJb3KB3vcRkpJWCFqcJR8pI7WcaEDKbpuXaHKMTz
         i+2LH17BDuXZdiKFlhYodMuv61shcNB5mh2DDrcosrOtmnjcdY3EVE0pNhMbkI65UdgV
         YfNg==
X-Forwarded-Encrypted: i=1; AJvYcCU9RLsF1lle9Kw9/eZ4bGm0qOo0kDSvt69vNRa90++MU2Yv26sdcGUXp4bWDVaHoMHSBnPj/g0DxzASM1uDMrHO4iZsWb2milpLw0RM
X-Gm-Message-State: AOJu0Yz460Ppn/tEh0GZnd+SpvwibYOD2157tHnnRxvDxPTcK2N5EOD6
	T15AFP10dwjyRnebQ6ROmV7RZvi91SE9bfON7YQCDOUWe+HgHaOqx4KrE4PqMzoIMXS2BYZNolX
	qxMxuFRPBwhtH3uGgfff2k+Gay20iMoKOWuGEjASDb9LCeTj4yUBzm6U=
X-Google-Smtp-Source: AGHT+IGw9xvAfNAjjZRAbSTeDLrQTK4qbwK+ybTVf+mksi9+a6VfEVqZXSgWev61/BWI9M4ckQWWUTOkfI1pW1vX4K80iqSNjMZc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:350d:b0:366:9539:84dc with SMTP id
 bu13-20020a056e02350d00b00366953984dcmr545551ilb.0.1711914023041; Sun, 31 Mar
 2024 12:40:23 -0700 (PDT)
Date: Sun, 31 Mar 2024 12:40:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ad27a0614fa0b99@google.com>
Subject: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
From: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>
To: frederic@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f5005e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=1dab15008502531a13d2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14437c21180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15217b9e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor164/5064 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffff8880b943e698 (&rq->__lock){?.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
{IN-HARDIRQ-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
  raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
  raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
  rq_lock kernel/sched/sched.h:1699 [inline]
  scheduler_tick+0xa2/0x650 kernel/sched/core.c:5679
  update_process_times+0x199/0x220 kernel/time/timer.c:2481
  tick_periodic+0x7e/0x230 kernel/time/tick-common.c:100
  tick_handle_periodic+0x45/0x120 kernel/time/tick-common.c:112
  timer_interrupt+0x4e/0x80 arch/x86/kernel/time.c:57
  __handle_irq_event_percpu+0x22c/0x750 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
  handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0xe1/0x250 arch/x86/kernel/irq.c:257
  common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  console_flush_all+0xa19/0xd70 kernel/printk/printk.c:2979
  console_unlock+0xae/0x290 kernel/printk/printk.c:3042
  vprintk_emit kernel/printk/printk.c:2342 [inline]
  vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
  _printk+0xc8/0x100 kernel/printk/printk.c:2367
  cpu_detect_tlb arch/x86/kernel/cpu/common.c:860 [inline]
  identify_boot_cpu arch/x86/kernel/cpu/common.c:1934 [inline]
  arch_cpu_finalize_init+0x7b/0x170 arch/x86/kernel/cpu/common.c:2310
  start_kernel+0x32b/0x490 init/main.c:1043
  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
  common_startup_64+0x13e/0x148
irq event stamp: 4834
hardirqs last  enabled at (4831): [<ffffffff8ad60263>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (4831): [<ffffffff8ad60263>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
hardirqs last disabled at (4832): [<ffffffff8ad48b14>] __schedule+0x2644/0x5c70 kernel/sched/core.c:6634
softirqs last  enabled at (4834): [<ffffffff88cb2754>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (4834): [<ffffffff88cb2754>] sock_hash_delete_elem+0x1f4/0x260 net/core/sock_map.c:947
softirqs last disabled at (4833): [<ffffffff88cb262b>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (4833): [<ffffffff88cb262b>] sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rq->__lock
);
  <Interrupt>
    lock(&rq->__lock
);

 *** DEADLOCK ***

2 locks held by syz-executor164/5064:
 #0: ffff8880b943e698
 (&rq->__lock
){?.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffffffff8d7b08e0
 (rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 5064 Comm: syz-executor164 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x923/0xc60 kernel/locking/lockdep.c:4678
 mark_held_locks+0x9f/0xe0 kernel/locking/lockdep.c:4274
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4292 [inline]
 lockdep_hardirqs_on_prepare+0x137/0x420 kernel/locking/lockdep.c:4359
 trace_hardirqs_on+0x36/0x40 kernel/trace/trace_preemptirq.c:61
 __local_bh_enable_ip+0xa4/0x120 kernel/softirq.c:387
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x1f4/0x260 net/core/sock_map.c:947
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
 __bpf_trace_sched_switch+0x13e/0x190 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2266/0x5c70 kernel/sched/core.c:6733
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6828
 ptrace_stop.part.0+0x440/0x940 kernel/signal.c:2358
 ptrace_stop kernel/signal.c:2260 [inline]
 ptrace_do_notify+0x222/0x2d0 kernel/signal.c:2395
 ptrace_notify+0xc5/0x130 kernel/signal.c:2407
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_entry include/linux/ptrace.h:452 [inline]
 syscall_trace_enter+0xb5/0x210 kernel/entry/common.c:45
 syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
 do_syscall_64+0x1f6/0x260 arch/x86/entry/common.c:79
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f122969f6b3
Code: 00 00 00 00 0f 1f 00 83 ff 03 74 7b 83 ff 02 b8 fa ff ff ff 49 89 ca 0f 44 f8 80 3d ce e9 03 00 00 74 14 b8 e6 00 00 00 0f 05 <f7> d8 c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec 28 48 89 54 24 10
RSP: 002b:00007ffd4d89e018 EFLAGS: 00000202
 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00000000000013c9 RCX: 00007f122969f6b3
RDX: 00007ffd4d89e030 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000012939 R08: 000000000000004c R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd4d89e06c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

