Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78B27BCE46
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 14:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjJHL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:58:55 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BACB6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:58:53 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3af5b5d7ecbso6142403b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696766333; x=1697371133;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RprEX1ixu6u5Jx+NExPvlRafwbMpRzy1zYFg1qW8o0=;
        b=M4zcquubWBJvAJkAhBSNMwD6kXSIgL6M7wH+4mzD0IQ8VJaVyhqMFbkTzSFwY9EBnK
         sN0VnITkuvnxTq9YWmNUBCPPj62oNkwnCGvaKKnur4NZvEH9hcZSiWTyLEs6x+yQ3J4l
         kJjp365Rd11RY9kjk1/v8oxjMmyGsJX+J6KBMO9h4Eoxw02xpO3hkedmUDYdX/YHUhTn
         vCJE5ZxpGKF0dsbAZiphxLp30JjIoMQIWD0an3GSezXdc8IHPp0nbjMxW65HNoVEgfrT
         nnO3YEZN7Fd4IQSQ3kFRHVbFD4yE1Gh12LN00YA5RLLWSCc4vKqqdDCoxlH72bZgR4vZ
         uKYw==
X-Gm-Message-State: AOJu0Yyf0dBDw965IyqAYANtAn1SM85iPOopNvt1hnlYB6VGJMg8HiU2
        UDzLSNkE7tbnC7avp2srYlL6e0esP5gVJP5ZM4sTQMzO75YLFYAqvA==
X-Google-Smtp-Source: AGHT+IH379ZAYxcqiTdBOpbrbHPA6BP8Vf6jUy0A+2nCyZZDxNbC/J+qMTtUCkXngh9H6UVo6gO6MOLBA9LTZrhpQ66NJLMyLg1a
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f05:b0:3a7:5f99:9fe1 with SMTP id
 m5-20020a0568080f0500b003a75f999fe1mr7018210oiw.2.1696766333135; Sun, 08 Oct
 2023 04:58:53 -0700 (PDT)
Date:   Sun, 08 Oct 2023 04:58:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008db61e0607333294@google.com>
Subject: [syzbot] [kernel?] possible deadlock in try_to_wake_up (3)
From:   syzbot <syzbot+6b8ea5bb987ec6fe0fd1@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f02fa1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
dashboard link: https://syzkaller.appspot.com/bug?extid=6b8ea5bb987ec6fe0fd1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b8ea5bb987ec6fe0fd1@syzkaller.appspotmail.com

batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: The newly added mac address (aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc4-next-20231005-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/5091 is trying to acquire lock:
ffff88801d41e338 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
ffff88801d41e338 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x15d0 kernel/sched/core.c:4213

but task is already holding lock:
ffffffff8cb98e18 ((console_sem).lock){-...}-{2:2}, at: up+0x16/0xb0 kernel/locking/semaphore.c:187

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((console_sem).lock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:323
       console_trylock+0x73/0x130 kernel/printk/printk.c:2652
       console_trylock_spinning kernel/printk/printk.c:1924 [inline]
       vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2303
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2329
       pick_eevdf kernel/sched/fair.c:963 [inline]
       pick_next_entity kernel/sched/fair.c:5247 [inline]
       pick_next_task_fair+0x1c5/0x1280 kernel/sched/fair.c:8205
       __pick_next_task kernel/sched/core.c:5986 [inline]
       pick_next_task kernel/sched/core.c:6061 [inline]
       __schedule+0x493/0x5a00 kernel/sched/core.c:6640
       preempt_schedule_irq+0x52/0x90 kernel/sched/core.c:6998
       irqentry_exit+0x35/0x80 kernel/entry/common.c:432
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
       kernel_text_address+0x0/0xf0 kernel/extable.c:71
       __kernel_text_address+0xd/0x30 kernel/extable.c:79
       unwind_get_return_address+0x78/0xe0 arch/x86/kernel/unwind_orc.c:369
       arch_stack_walk+0xbe/0x170 arch/x86/kernel/stacktrace.c:26
       stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
       save_stack+0x160/0x1f0 mm/page_owner.c:128
       __reset_page_owner+0x5a/0x190 mm/page_owner.c:149
       reset_page_owner include/linux/page_owner.h:24 [inline]
       free_pages_prepare mm/page_alloc.c:1134 [inline]
       free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2383
       free_unref_page+0x33/0x3b0 mm/page_alloc.c:2518
       qlink_free mm/kasan/quarantine.c:166 [inline]
       qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
       kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
       __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
       kasan_slab_alloc include/linux/kasan.h:188 [inline]
       slab_post_alloc_hook mm/slab.h:758 [inline]
       slab_alloc_node mm/slub.c:3478 [inline]
       slab_alloc mm/slub.c:3486 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
       kmem_cache_alloc+0x15d/0x380 mm/slub.c:3502
       kmem_cache_zalloc include/linux/slab.h:711 [inline]
       alloc_empty_file+0x73/0x1d0 fs/file_table.c:223
       path_openat+0xdd/0x2ce0 fs/namei.c:3763
       do_filp_open+0x1de/0x430 fs/namei.c:3807
       do_sys_openat2+0x176/0x1e0 fs/open.c:1422
       do_sys_open fs/open.c:1437 [inline]
       __do_sys_openat fs/open.c:1453 [inline]
       __se_sys_openat fs/open.c:1448 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1448
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1357 [inline]
       rq_lock kernel/sched/sched.h:1671 [inline]
       task_fork_fair+0x70/0x240 kernel/sched/fair.c:12399
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4799
       copy_process+0x4580/0x74b0 kernel/fork.c:2609
       kernel_clone+0xfd/0x920 kernel/fork.c:2907
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2985
       rest_init+0x27/0x2b0 init/main.c:691
       arch_call_rest_init+0x13/0x30 init/main.c:823
       start_kernel+0x39f/0x480 init/main.c:1068
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #0 (&p->pi_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
       try_to_wake_up+0xb0/0x15d0 kernel/sched/core.c:4213
       up+0x79/0xb0 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:340 [inline]
       __console_unlock kernel/printk/printk.c:2699 [inline]
       console_unlock+0x1cf/0x260 kernel/printk/printk.c:3031
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2304
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2329
       batadv_check_known_mac_addr+0x21f/0x440 net/batman-adv/hard-interface.c:526
       batadv_hard_if_event+0x1048/0x1660 net/batman-adv/hard-interface.c:998
       notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
       call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
       call_netdevice_notifiers net/core/dev.c:2022 [inline]
       dev_set_mac_address+0x36f/0x4a0 net/core/dev.c:8860
       dev_set_mac_address_user+0x30/0x50 net/core/dev.c:8874
       do_setlink+0x6e9/0x3fa0 net/core/rtnetlink.c:2864
       __rtnl_newlink+0xc1d/0x1940 net/core/rtnetlink.c:3707
       rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3754
       rtnetlink_rcv_msg+0x3c4/0xdf0 net/core/rtnetlink.c:6480
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
       netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
       netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
       netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0xd5/0x180 net/socket.c:745
       __sys_sendto+0x255/0x340 net/socket.c:2194
       __do_sys_sendto net/socket.c:2206 [inline]
       __se_sys_sendto net/socket.c:2202 [inline]
       __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2202
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &p->pi_lock --> &rq->__lock --> (console_sem).lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((console_sem).lock);
                               lock(&rq->__lock);
                               lock((console_sem).lock);
  lock(&p->pi_lock);

 *** DEADLOCK ***

4 locks held by syz-executor.5/5091:
 #0: ffffffff8e60db28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8e60db28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x36f/0xdf0 net/core/rtnetlink.c:6477
 #1: ffffffff8e6001b0 (dev_addr_sem){++++}-{3:3}, at: dev_set_mac_address_user+0x22/0x50 net/core/dev.c:8873
 #2: ffffffff8cbab220 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
 #2: ffffffff8cbab220 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:749 [inline]
 #2: ffffffff8cbab220 (rcu_read_lock){....}-{1:2}, at: batadv_check_known_mac_addr+0x38/0x440 net/batman-adv/hard-interface.c:513
 #3: ffffffff8cb98e18 ((console_sem).lock){-...}-{2:2}, at: up+0x16/0xb0 kernel/locking/semaphore.c:187

stack backtrace:
CPU: 0 PID: 5091 Comm: syz-executor.5 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
 try_to_wake_up+0xb0/0x15d0 kernel/sched/core.c:4213
 up+0x79/0xb0 kernel/locking/semaphore.c:191
 __up_console_sem kernel/printk/printk.c:340 [inline]
 __console_unlock kernel/printk/printk.c:2699 [inline]
 console_unlock+0x1cf/0x260 kernel/printk/printk.c:3031
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2304
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2329
 batadv_check_known_mac_addr+0x21f/0x440 net/batman-adv/hard-interface.c:526
 batadv_hard_if_event+0x1048/0x1660 net/batman-adv/hard-interface.c:998
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 dev_set_mac_address+0x36f/0x4a0 net/core/dev.c:8860
 dev_set_mac_address_user+0x30/0x50 net/core/dev.c:8874
 do_setlink+0x6e9/0x3fa0 net/core/rtnetlink.c:2864
 __rtnl_newlink+0xc1d/0x1940 net/core/rtnetlink.c:3707
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3754
 rtnetlink_rcv_msg+0x3c4/0xdf0 net/core/rtnetlink.c:6480
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 __sys_sendto+0x255/0x340 net/socket.c:2194
 __do_sys_sendto net/socket.c:2206 [inline]
 __se_sys_sendto net/socket.c:2202 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2202
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f75f027e7dc
Code: 1a 51 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 60 51 02 00 48 8b
RSP: 002b:00007ffece75e400 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f75f0ec4620 RCX: 00007f75f027e7dc
RDX: 000000000000002c RSI: 00007f75f0ec4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffece75e454 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f75f0ec4670 R15: 0000000000000000
 </TASK>
batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: The newly added mac address (aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: The newly added mac address (aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: batadv0: Interface activated: batadv_slave_1
netdevsim netdevsim5 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim5 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim5 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim5 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
ieee80211 phy11: Selected rate control algorithm 'minstrel_ht'
ieee80211 phy14: Selected rate control algorithm 'minstrel_ht'


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
