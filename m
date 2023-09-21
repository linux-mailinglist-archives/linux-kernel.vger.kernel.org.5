Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EB7A98B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjIURvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIURv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:27 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6D5FDC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:56 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-576925c8921so1646238eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316135; x=1695920935;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBTbCCK23ODKsIROOVAuxu7lADPea0bbaj6W+1h1pg0=;
        b=kumGP15tvsYWjjGrHUl6HOH/bGk5D0o4aC/ugZvSxvCbbx8buKeMDGwRs19GXALJUc
         mh8C5hp//31Tgo/ZqzIOom2lqyxaajwEn3heJ2+fUhtnz8llBIX2l/XsIERU/oyT6tlc
         etjp2L6gEAPHUv2KufT7HB/DomR2RzF6vuL4dz8MIhfkc361NH3PlcOuPZ+BvQbjX9eB
         7cT/vAiYTQITq92R4E68KadRgHZu86GiEGvcsC7kqb7tgiFHd2NXqznIXsPWocd6iT2h
         sTCyQHbtPnfZMlC+GFsSIT0fNYOoCJUDO6WEJz8iEDEmPPI1se0AXBb/IiQYBoNY/NHg
         arRQ==
X-Gm-Message-State: AOJu0YzFQhvjIy7yk+EyyTQnB0YeVPScGzfGpmldEWw0i5oHIM3Wb4f4
        zIpO1TcieGG42KWKng5fHFubhT8rGl6lMloyWsQWqIjc3ZPy
X-Google-Smtp-Source: AGHT+IH9/YOwwus2PQk6H0A3+EXOiW+YXJ4GLHmuquA0iu5a7r9iknsptxlZMUWhYrKQugAOTPlb7Hh89iknaet9/D60aMaTqRdY
MIME-Version: 1.0
X-Received: by 2002:a05:6871:418c:b0:1dc:6d26:9ff with SMTP id
 lc12-20020a056871418c00b001dc6d2609ffmr1177522oab.6.1695316135480; Thu, 21
 Sep 2023 10:08:55 -0700 (PDT)
Date:   Thu, 21 Sep 2023 10:08:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000099f0d0605e18c69@google.com>
Subject: [syzbot] [mm?] possible deadlock in free_pcppages_bulk
From:   syzbot <syzbot+27f8c9169772defbdde9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dfa449a58323 Add linux-next specific files for 20230915
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110f76f8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e204dda2e58397ec
dashboard link: https://syzkaller.appspot.com/bug?extid=27f8c9169772defbdde9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34f9995871ed/disk-dfa449a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/95e2e1c3ab9e/vmlinux-dfa449a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfc6db9684d4/bzImage-dfa449a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27f8c9169772defbdde9@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc1-next-20230915-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/22192 is trying to acquire lock:
ffffffff8cb987d8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x12/0x70 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff88813fffacd8 (&zone->lock){-.-.}-{2:2}, at: free_pcppages_bulk+0x6a/0x610 mm/page_alloc.c:1202

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&zone->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       rmqueue_bulk mm/page_alloc.c:2203 [inline]
       __rmqueue_pcplist+0xcd3/0x1430 mm/page_alloc.c:2752
       rmqueue_pcplist mm/page_alloc.c:2794 [inline]
       rmqueue mm/page_alloc.c:2831 [inline]
       get_page_from_freelist+0x31c/0x2d10 mm/page_alloc.c:3221
       __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4480
       alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
       alloc_slab_page mm/slub.c:1870 [inline]
       allocate_slab+0x251/0x380 mm/slub.c:2017
       new_slab mm/slub.c:2070 [inline]
       ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
       __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
       __slab_alloc_node mm/slub.c:3375 [inline]
       slab_alloc_node mm/slub.c:3468 [inline]
       slab_alloc mm/slub.c:3486 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
       kmem_cache_alloc+0x38c/0x3b0 mm/slub.c:3502
       kmem_cache_zalloc include/linux/slab.h:710 [inline]
       fill_pool+0x271/0x5d0 lib/debugobjects.c:168
       debug_objects_fill_pool lib/debugobjects.c:615 [inline]
       debug_object_activate+0x149/0x490 lib/debugobjects.c:713
       debug_timer_activate kernel/time/timer.c:782 [inline]
       __mod_timer+0x820/0xea0 kernel/time/timer.c:1119
       schedule_timeout+0x152/0x2c0 kernel/time/timer.c:2166
       do_wait_for_common kernel/sched/completion.c:95 [inline]
       __wait_for_common+0x3e0/0x5f0 kernel/sched/completion.c:116
       usb_start_wait_urb+0x148/0x4c0 drivers/usb/core/message.c:64
       usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
       usb_control_msg+0x327/0x4a0 drivers/usb/core/message.c:154
       get_port_status drivers/usb/core/hub.c:584 [inline]
       hub_ext_port_status+0x14e/0x670 drivers/usb/core/hub.c:601
       usb_hub_port_status drivers/usb/core/hub.c:646 [inline]
       hub_activate+0x6e3/0x1bf0 drivers/usb/core/hub.c:1156
       process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
       kthread+0x33c/0x440 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #3 (&base->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       lock_timer_base+0x5d/0x200 kernel/time/timer.c:999
       __mod_timer+0x420/0xea0 kernel/time/timer.c:1080
       add_timer+0x62/0x90 kernel/time/timer.c:1244
       __queue_delayed_work+0x19d/0x260 kernel/workqueue.c:1961
       queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1986
       psi_task_change+0x1b0/0x2e0 kernel/sched/psi.c:923
       psi_enqueue kernel/sched/stats.h:139 [inline]
       enqueue_task kernel/sched/core.c:2092 [inline]
       activate_task kernel/sched/core.c:2126 [inline]
       wake_up_new_task+0xbfc/0x1200 kernel/sched/core.c:4855
       kernel_clone+0x229/0x920 kernel/fork.c:2933
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2980
       rest_init+0x27/0x2b0 init/main.c:691
       arch_call_rest_init+0x13/0x30 init/main.c:823
       start_kernel+0x39f/0x480 init/main.c:1068
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
       rq_lock kernel/sched/sched.h:1686 [inline]
       task_fork_fair+0x70/0x240 kernel/sched/fair.c:12361
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4799
       copy_process+0x4580/0x74b0 kernel/fork.c:2604
       kernel_clone+0xfd/0x920 kernel/fork.c:2902
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2980
       rest_init+0x27/0x2b0 init/main.c:691
       arch_call_rest_init+0x13/0x30 init/main.c:823
       start_kernel+0x39f/0x480 init/main.c:1068
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
       try_to_wake_up+0xb0/0x15b0 kernel/sched/core.c:4213
       up+0x79/0xb0 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:346 [inline]
       __console_unlock kernel/printk/printk.c:2718 [inline]
       console_unlock+0x17a/0x260 kernel/printk/printk.c:3037
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2332
       printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
       show_trace_log_lvl+0x2ac/0x4f0 arch/x86/kernel/dumpstack.c:285
       __dump_stack lib/dump_stack.c:88 [inline]
       dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
       fail_dump lib/fault-inject.c:52 [inline]
       should_fail_ex+0x496/0x5b0 lib/fault-inject.c:153
       should_failslab+0x9/0x20 mm/slab_common.c:1509
       slab_pre_alloc_hook mm/slab.h:711 [inline]
       slab_alloc_node mm/slub.c:3460 [inline]
       __kmem_cache_alloc_node+0x2f7/0x340 mm/slub.c:3517
       kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
       kmalloc include/linux/slab.h:599 [inline]
       kzalloc include/linux/slab.h:720 [inline]
       device_private_init drivers/base/core.c:3469 [inline]
       device_add+0xd02/0x1aa0 drivers/base/core.c:3520
       netdev_register_kobject+0x183/0x3f0 net/core/net-sysfs.c:2044
       register_netdevice+0xbcb/0x1490 net/core/dev.c:10136
       gtp_newlink+0x4cd/0xc10 drivers/net/gtp.c:1088
       rtnl_newlink_create net/core/rtnetlink.c:3485 [inline]
       __rtnl_newlink+0x1177/0x1940 net/core/rtnetlink.c:3705
       rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3718
       rtnetlink_rcv_msg+0x3c4/0xdf0 net/core/rtnetlink.c:6444
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
       netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
       netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
       netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
       sock_sendmsg_nosec net/socket.c:730 [inline]
       sock_sendmsg+0xd9/0x180 net/socket.c:753
       ____sys_sendmsg+0x6ac/0x940 net/socket.c:2541
       ___sys_sendmsg+0x135/0x1d0 net/socket.c:2595
       __sys_sendmsg+0x117/0x1e0 net/socket.c:2624
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:329
       console_trylock+0x73/0x130 kernel/printk/printk.c:2671
       console_trylock_spinning kernel/printk/printk.c:1927 [inline]
       vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2306
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2332
       __warn_printk+0x158/0x350 kernel/panic.c:720
       del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
       __free_one_page+0x3eb/0xa50 mm/page_alloc.c:830
       free_pcppages_bulk+0x2f3/0x610 mm/page_alloc.c:1233
       free_unref_page+0x69b/0xd70 mm/page_alloc.c:2483
       qlink_free mm/kasan/quarantine.c:166 [inline]
       qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
       kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
       __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:306
       kasan_slab_alloc include/linux/kasan.h:188 [inline]
       slab_post_alloc_hook mm/slab.h:762 [inline]
       slab_alloc_node mm/slub.c:3478 [inline]
       slab_alloc mm/slub.c:3486 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
       kmem_cache_alloc+0x16c/0x3b0 mm/slub.c:3502
       kmem_cache_zalloc include/linux/slab.h:710 [inline]
       jbd2_alloc_handle include/linux/jbd2.h:1592 [inline]
       new_handle fs/jbd2/transaction.c:476 [inline]
       jbd2__journal_start+0x190/0x690 fs/jbd2/transaction.c:503
       __ext4_journal_start_sb+0x40f/0x5c0 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_handle_inode_extension+0x228/0x860 fs/ext4/file.c:350
       ext4_dio_write_iter fs/ext4/file.c:611 [inline]
       ext4_file_write_iter+0x148e/0x1860 fs/ext4/file.c:715
       call_write_iter include/linux/fs.h:1986 [inline]
       do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
       do_iter_write+0x17f/0x830 fs/read_write.c:860
       vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
       iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
       do_splice_from fs/splice.c:933 [inline]
       direct_splice_actor+0x118/0x180 fs/splice.c:1142
       splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
       do_splice_direct+0x1af/0x280 fs/splice.c:1194
       do_sendfile+0xb88/0x1390 fs/read_write.c:1254
       __do_sys_sendfile64 fs/read_write.c:1322 [inline]
       __se_sys_sendfile64 fs/read_write.c:1308 [inline]
       __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &base->lock --> &zone->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&zone->lock);
                               lock(&base->lock);
                               lock(&zone->lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

5 locks held by syz-executor.5/22192:
 #0: ffff88802ab76410 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 #0: ffff88802ab76410 (sb_writers#4){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 #0: ffff88802ab76410 (sb_writers#4){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 #1: ffff888079cd6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff888079cd6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_dio_write_iter fs/ext4/file.c:560 [inline]
 #1: ffff888079cd6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_file_write_iter+0xc73/0x1860 fs/ext4/file.c:715
 #2: ffffffff8cd3d430 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #2: ffffffff8cd3d430 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #2: ffffffff8cd3d430 (remove_cache_srcu){.+.+}-{0:0}, at: kasan_quarantine_reduce+0x81/0x1d0 mm/kasan/quarantine.c:265
 #3: ffff8880b99425d8 (&pcp->lock){+.+.}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #3: ffff8880b99425d8 (&pcp->lock){+.+.}-{2:2}, at: free_unref_page+0x35f/0xd70 mm/page_alloc.c:2481
 #4: ffff88813fffacd8 (&zone->lock){-.-.}-{2:2}, at: free_pcppages_bulk+0x6a/0x610 mm/page_alloc.c:1202

stack backtrace:
CPU: 1 PID: 22192 Comm: syz-executor.5 Not tainted 6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
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
 down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:329
 console_trylock+0x73/0x130 kernel/printk/printk.c:2671
 console_trylock_spinning kernel/printk/printk.c:1927 [inline]
 vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2306
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 __warn_printk+0x158/0x350 kernel/panic.c:720
 del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
 __free_one_page+0x3eb/0xa50 mm/page_alloc.c:830
 free_pcppages_bulk+0x2f3/0x610 mm/page_alloc.c:1233
 free_unref_page+0x69b/0xd70 mm/page_alloc.c:2483
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:306
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x16c/0x3b0 mm/slub.c:3502
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 jbd2_alloc_handle include/linux/jbd2.h:1592 [inline]
 new_handle fs/jbd2/transaction.c:476 [inline]
 jbd2__journal_start+0x190/0x690 fs/jbd2/transaction.c:503
 __ext4_journal_start_sb+0x40f/0x5c0 fs/ext4/ext4_jbd2.c:112
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_handle_inode_extension+0x228/0x860 fs/ext4/file.c:350
 ext4_dio_write_iter fs/ext4/file.c:611 [inline]
 ext4_file_write_iter+0x148e/0x1860 fs/ext4/file.c:715
 call_write_iter include/linux/fs.h:1986 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8c4187cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c4250f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f8c4199c120 RCX: 00007f8c4187cae9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000006
RBP: 00007f8c418c847a R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000ef85 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f8c4199c120 R15: 00007ffde2bfa0a8
 </TASK>
page type is 0, passed migratetype is 1 (nr=512)
WARNING: CPU: 1 PID: 22192 at mm/page_alloc.c:699 del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
Modules linked in:
CPU: 1 PID: 22192 Comm: syz-executor.5 Not tainted 6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
Code: 89 ef be 07 00 00 00 e8 e0 f6 ff ff 44 89 e1 44 89 f2 48 c7 c7 20 b6 99 8a 48 89 c6 b8 01 00 00 00 d3 e0 89 c1 e8 d2 3b 7c ff <0f> 0b e9 d2 fc ff ff 48 c7 c6 80 b7 99 8a 48 89 df e8 9c 46 f4 ff
RSP: 0018:ffffc9000b2372e8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffea0001aa8000 RCX: ffffc9000c7a3000
RDX: 0000000000040000 RSI: ffffffff814e0396 RDI: 0000000000000001
RBP: 000000000006aa00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000002b9b0 R12: 0000000000000009
R13: ffff88813fffa700 R14: 0000000000000001 R15: ffffea0001aa8000
FS:  00007f8c4250f6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020114000 CR3: 0000000070189000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 __free_one_page+0x3eb/0xa50 mm/page_alloc.c:830
 free_pcppages_bulk+0x2f3/0x610 mm/page_alloc.c:1233
 free_unref_page+0x69b/0xd70 mm/page_alloc.c:2483
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:306
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x16c/0x3b0 mm/slub.c:3502
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 jbd2_alloc_handle include/linux/jbd2.h:1592 [inline]
 new_handle fs/jbd2/transaction.c:476 [inline]
 jbd2__journal_start+0x190/0x690 fs/jbd2/transaction.c:503
 __ext4_journal_start_sb+0x40f/0x5c0 fs/ext4/ext4_jbd2.c:112
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_handle_inode_extension+0x228/0x860 fs/ext4/file.c:350
 ext4_dio_write_iter fs/ext4/file.c:611 [inline]
 ext4_file_write_iter+0x148e/0x1860 fs/ext4/file.c:715
 call_write_iter include/linux/fs.h:1986 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8c4187cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c4250f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f8c4199c120 RCX: 00007f8c4187cae9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000006
RBP: 00007f8c418c847a R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000ef85 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f8c4199c120 R15: 00007ffde2bfa0a8
 </TASK>


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
