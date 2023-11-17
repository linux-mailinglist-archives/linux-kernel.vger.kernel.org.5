Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C47EF432
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjKQONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKQONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:13:33 -0500
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF283C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:13:29 -0800 (PST)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-5c19a0a2fbfso2178933a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230409; x=1700835209;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id8Fz3G/Zm4lzbM/X46CDzifF9NowSj0qz7by1PyinI=;
        b=pBxLgt7fiCSka6JuFIw3Y+75QfDj+gfwGNd2dvjBni6ZK2NVurTyjgtQnyKFbczqFA
         L63jb2nEj7coi4bxLBhWqdPZT5Veue1+FjqT/pq1qVhYw5rTpYV//MiVU+SJYAlThJMy
         6vDFGWGxpgIFS2Ah9rvn3MRY5bIvpMhj3xsr4wSZiA1ZZG15RYDtu9wPGoD4b6Ex0lBT
         G8TYatD1PhumLT0t/H2m9SyQWHGqOueTi+69NK7nNWhZOp1gzFrkz5lJjxZEqV0HMgor
         QzUF/8BBGIkVVJqR0grQJVbjznJGSdDqpvYveAEEonAM7RqbDw2xRZM44BAmC4LrLwf4
         m6dA==
X-Gm-Message-State: AOJu0Ywqv1Cqi6N0lSf0Rx0PHlZLISiToR3DY1BxAHlgEeFqigeDxUsH
        3txf6rp/LYQPCcPVEelQ4FIGCxPHAeCrhMc70eK6ZhyaBB8b
X-Google-Smtp-Source: AGHT+IH7V01Y03GYwEfxqtNBa1B9TlRi9Yd22mmsza7ADbGLUO9DZ7fwnAPEvPtlh3vYb7tokLcT7vdOMG5soIESheDJ9m6Ar/sD
MIME-Version: 1.0
X-Received: by 2002:a65:64d0:0:b0:5bd:d60f:231d with SMTP id
 t16-20020a6564d0000000b005bdd60f231dmr1169630pgv.3.1700230409328; Fri, 17 Nov
 2023 06:13:29 -0800 (PST)
Date:   Fri, 17 Nov 2023 06:13:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095a67c060a59bdce@google.com>
Subject: [syzbot] [kernel?] possible deadlock in alarm_handle_timer
From:   syzbot <syzbot+f2c4e7bfcca6c6d6324c@syzkaller.appspotmail.com>
To:     jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eff99d8edbed Add linux-next specific files for 20231117
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134b7d84e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61991b2630c19677
dashboard link: https://syzkaller.appspot.com/bug?extid=f2c4e7bfcca6c6d6324c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/727bd99b8512/disk-eff99d8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a535e264e50/vmlinux-eff99d8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23c31e53f4d8/bzImage-eff99d8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2c4e7bfcca6c6d6324c@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.7.0-rc1-next-20231117-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor.0/11087 just changed the state of lock:
ffff88801aba41b0 (&new_timer->it_lock){-...}-{2:2}, at: alarm_handle_timer+0x2d/0x2e0 kernel/time/alarmtimer.c:579
but this lock took another, HARDIRQ-unsafe lock in the past:
 (&sighand->siglock){+.+.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->siglock);
                               local_irq_disable();
                               lock(&new_timer->it_lock);
                               lock(&sighand->siglock);
  <Interrupt>
    lock(&new_timer->it_lock);

 *** DEADLOCK ***

no locks held by syz-executor.0/11087.

the shortest dependencies between 2nd lock and 1st lock:
 -> (&sighand->siglock){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire kernel/locking/lockdep.c:5753 [inline]
                      lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                      __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                      _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                      spin_lock include/linux/spinlock.h:351 [inline]
                      class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                      ptrace_set_stopped kernel/ptrace.c:391 [inline]
                      ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                      __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                      do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                      entry_SYSCALL_64_after_hwframe+0x62/0x6a
    SOFTIRQ-ON-W at:
                      lock_acquire kernel/locking/lockdep.c:5753 [inline]
                      lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                      __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                      _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                      spin_lock include/linux/spinlock.h:351 [inline]
                      class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                      ptrace_set_stopped kernel/ptrace.c:391 [inline]
                      ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                      __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                      do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                      entry_SYSCALL_64_after_hwframe+0x62/0x6a
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5753 [inline]
                     lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                     _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                     spin_lock_irq include/linux/spinlock.h:376 [inline]
                     calculate_sigpending+0x44/0xa0 kernel/signal.c:197
                     ret_from_fork+0x23/0x80 arch/x86/kernel/process.c:143
                     ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
  }
  ... key      at: [<ffffffff90b4af80>] __key.341+0x0/0x40
  ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   __do_sys_timer_delete kernel/time/posix-timers.c:1023 [inline]
   __se_sys_timer_delete kernel/time/posix-timers.c:1006 [inline]
   __x64_sys_timer_delete+0x16a/0x3e0 kernel/time/posix-timers.c:1006
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a

-> (&new_timer->it_lock){-...}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
                    alarm_handle_timer+0x2d/0x2e0 kernel/time/alarmtimer.c:579
                    alarmtimer_fired+0x132/0x550 kernel/time/alarmtimer.c:209
                    __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
                    __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1752
                    hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
                    __sysvec_apic_timer_interrupt+0x10c/0x410 arch/x86/kernel/apic/apic.c:1082
                    sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                    _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                    unlock_timer kernel/time/posix-timers.c:128 [inline]
                    do_timer_settime+0x260/0x2f0 kernel/time/posix-timers.c:934
                    __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
                    __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
                    __x64_sys_timer_settime+0x266/0x2c0 kernel/time/posix-timers.c:940
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
                   __lock_timer+0x20d/0x4c0 kernel/time/posix-timers.c:595
                   __do_sys_timer_delete kernel/time/posix-timers.c:1011 [inline]
                   __se_sys_timer_delete kernel/time/posix-timers.c:1006 [inline]
                   __x64_sys_timer_delete+0x9e/0x3e0 kernel/time/posix-timers.c:1006
                   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                   entry_SYSCALL_64_after_hwframe+0x62/0x6a
 }
 ... key      at: [<ffffffff9280bea0>] __key.0+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4563 [inline]
   __lock_acquire+0x1347/0x3b10 kernel/locking/lockdep.c:5090
   lock_acquire kernel/locking/lockdep.c:5753 [inline]
   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
   alarm_handle_timer+0x2d/0x2e0 kernel/time/alarmtimer.c:579
   alarmtimer_fired+0x132/0x550 kernel/time/alarmtimer.c:209
   __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
   __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1752
   hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
   __sysvec_apic_timer_interrupt+0x10c/0x410 arch/x86/kernel/apic/apic.c:1082
   sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
   _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
   spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
   unlock_timer kernel/time/posix-timers.c:128 [inline]
   do_timer_settime+0x260/0x2f0 kernel/time/posix-timers.c:934
   __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
   __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
   __x64_sys_timer_settime+0x266/0x2c0 kernel/time/posix-timers.c:940
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a


stack backtrace:
CPU: 1 PID: 11087 Comm: syz-executor.0 Not tainted 6.7.0-rc1-next-20231117-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_irq_inversion_bug.part.0+0x3e1/0x590 kernel/locking/lockdep.c:4079
 print_irq_inversion_bug kernel/locking/lockdep.c:4032 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4110 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4242 [inline]
 mark_lock+0x570/0xc50 kernel/locking/lockdep.c:4677
 mark_usage kernel/locking/lockdep.c:4563 [inline]
 __lock_acquire+0x1347/0x3b10 kernel/locking/lockdep.c:5090
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 alarm_handle_timer+0x2d/0x2e0 kernel/time/alarmtimer.c:579
 alarmtimer_fired+0x132/0x550 kernel/time/alarmtimer.c:209
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x10c/0x410 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 16 c8 e3 f6 48 89 df e8 ce 3f e4 f6 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 85 ed d5 f6 65 8b 05 a6 18 7f 75 85 c0 74 12 5b
RSP: 0018:ffffc900037cfd70 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff88801aba4198 RCX: 1ffffffff1e31619
RDX: 0000000000000000 RSI: ffffffff8accbfe0 RDI: ffffffff8b2f1520
RBP: 0000000000000287 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f18e357 R11: 0000000000000001 R12: 0000000000000000
R13: 1ffff920006f9fb3 R14: ffffffff81789850 R15: dffffc0000000000
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 unlock_timer kernel/time/posix-timers.c:128 [inline]
 do_timer_settime+0x260/0x2f0 kernel/time/posix-timers.c:934
 __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
 __x64_sys_timer_settime+0x266/0x2c0 kernel/time/posix-timers.c:940
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fac7f47cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fac8025f0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 00007fac7f59c050 RCX: 00007fac7f47cae9
RDX: 000000002006b000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fac7f4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fac7f59c050 R15: 00007ffd40edc0c8
 </TASK>
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 16 c8 e3 f6       	call   0xf6e3c829
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 ce 3f e4 f6       	call   0xf6e43fe9
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 1f                	jne    0x42
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 2f                	jne    0x59
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 85 ed d5 f6       	call   0xf6d5edb9
  34:	65 8b 05 a6 18 7f 75 	mov    %gs:0x757f18a6(%rip),%eax        # 0x757f18e1
  3b:	85 c0                	test   %eax,%eax
  3d:	74 12                	je     0x51
  3f:	5b                   	pop    %rbx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
