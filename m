Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0E7AA1CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjIUVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjIUVFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:17 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF197681C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:33:39 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-79aa0d3a9acso79735739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317483; x=1695922283;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YrhnJC/cSplJzZtaZw0p+nIP0XNIjJSQ6rqE9uTd1Y=;
        b=Sqc2HsP2HcoBv521T7MTn2PMMia8k1qEBQ1WQJtsxTb+jR2P6bCdUbr8cbY5FjR0p/
         g5OvObKarJxmhfubjZZ1hqRQsSQC2lkyT8mITvlGOyOPBO6raaFaZ0VGUYfGvLG9n4uy
         CChZo7isWdpEy8dFeUvyXQU2mZxMIe0xN2N6Y0ZsA9SLg6c1QVmNi2r4VXWF7kUQs0by
         l6Ei2yZpK+1qJET/kRafi3grvWhmEZ6WpnTVN3KeD7kMYP7w/okMDAMNF3JRvk8X5yrY
         m87TQAdzIUEeItj17RfHsTNPIR6nRy4/qW1CLrFUYzBbYYdpnqTcUf1UeeR2OQDnUB0j
         f8cA==
X-Gm-Message-State: AOJu0Yyoxpdmm0ykTDaBoO/IsL/9cWlXE2k9qc1WVRDeNKGW7hFZ9whA
        pyI24V2eribUXeYvmDJb79192sJwFunaq4x1EDuRVj1wduy8
X-Google-Smtp-Source: AGHT+IF10wS8I4K1l46S26kSa9Akrco9uSlnNZvm0RImsdKt9gvfnKc4ZKwhTCyLY/VadYV7T9EJjiKv12E15jfwa5hxGufBwj8R
MIME-Version: 1.0
X-Received: by 2002:a05:6808:208d:b0:3ac:ab4f:ef3 with SMTP id
 s13-20020a056808208d00b003acab4f0ef3mr2252332oiw.6.1695273237536; Wed, 20 Sep
 2023 22:13:57 -0700 (PDT)
Date:   Wed, 20 Sep 2023 22:13:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ee6770605d78fe1@google.com>
Subject: [syzbot] [mm?] possible deadlock in console_flush_all
From:   syzbot <syzbot+1196a75f5d71352645a4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dfa449a58323 Add linux-next specific files for 20230915
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=149f71c2680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e204dda2e58397ec
dashboard link: https://syzkaller.appspot.com/bug?extid=1196a75f5d71352645a4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34f9995871ed/disk-dfa449a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/95e2e1c3ab9e/vmlinux-dfa449a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfc6db9684d4/bzImage-dfa449a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1196a75f5d71352645a4@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc1-next-20230915-syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/80 is trying to acquire lock:
ffffffff8cab7f20 (console_owner){-.-.}-{0:0}, at: console_lock_spinning_enable kernel/printk/printk.c:1858 [inline]
ffffffff8cab7f20 (console_owner){-.-.}-{0:0}, at: console_emit_next_record kernel/printk/printk.c:2904 [inline]
ffffffff8cab7f20 (console_owner){-.-.}-{0:0}, at: console_flush_all+0x4ac/0xfb0 kernel/printk/printk.c:2966

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
       alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2131
       alloc_pages+0x22a/0x270 mm/mempolicy.c:2293
       stack_depot_save_flags+0x28d/0x750 lib/stackdepot.c:516
       save_stack+0x16d/0x1f0 mm/page_owner.c:129
       __set_page_owner+0x1f/0x60 mm/page_owner.c:192
       set_page_owner include/linux/page_owner.h:31 [inline]
       post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1535
       prep_new_page mm/page_alloc.c:1542 [inline]
       get_page_from_freelist+0xdcd/0x2d10 mm/page_alloc.c:3224
       __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4480
       alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2131
       alloc_pages+0x22a/0x270 mm/mempolicy.c:2293
       stack_depot_save_flags+0x28d/0x750 lib/stackdepot.c:516
       kasan_save_stack+0x42/0x50 mm/kasan/common.c:47
       kasan_set_track+0x25/0x30 mm/kasan/common.c:53
       __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:329
       kasan_slab_alloc include/linux/kasan.h:188 [inline]
       slab_post_alloc_hook mm/slab.h:762 [inline]
       slab_alloc_node mm/slub.c:3478 [inline]
       slab_alloc mm/slub.c:3486 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
       kmem_cache_alloc+0x16c/0x3b0 mm/slub.c:3502
       kmem_cache_zalloc include/linux/slab.h:710 [inline]
       fill_pool+0x271/0x5d0 lib/debugobjects.c:168
       debug_objects_fill_pool lib/debugobjects.c:615 [inline]
       debug_object_activate+0x149/0x490 lib/debugobjects.c:713
       debug_work_activate kernel/workqueue.c:572 [inline]
       insert_work+0x30/0x230 kernel/workqueue.c:1644
       __queue_work+0x5d0/0x1050 kernel/workqueue.c:1799
       queue_work_on+0xed/0x110 kernel/workqueue.c:1834
       queue_work include/linux/workqueue.h:554 [inline]
       call_usermodehelper_exec+0x1d2/0x4c0 kernel/umh.c:434
       kobject_uevent_env+0xf6d/0x1800 lib/kobject_uevent.c:618
       kset_register+0x1b6/0x2a0 lib/kobject.c:873
       class_register+0x1cb/0x330 drivers/base/class.c:205
       iscsi_transport_init+0x1f9/0x2e0 drivers/scsi/scsi_transport_iscsi.c:4995
       do_one_initcall+0x117/0x630 init/main.c:1232
       do_initcall_level init/main.c:1294 [inline]
       do_initcalls init/main.c:1310 [inline]
       do_basic_setup init/main.c:1329 [inline]
       kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
       kernel_init+0x1c/0x2a0 init/main.c:1437
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #3 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x399/0x1050 kernel/workqueue.c:1763
       queue_work_on+0xed/0x110 kernel/workqueue.c:1834
       queue_work include/linux/workqueue.h:554 [inline]
       rpm_suspend+0x1219/0x16f0 drivers/base/power/runtime.c:660
       rpm_idle+0x574/0x6e0 drivers/base/power/runtime.c:534
       __pm_runtime_idle+0xbe/0x160 drivers/base/power/runtime.c:1102
       pm_runtime_put include/linux/pm_runtime.h:460 [inline]
       __device_attach+0x382/0x4b0 drivers/base/dd.c:1048
       bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
       device_add+0x117e/0x1aa0 drivers/base/core.c:3624
       serial_base_port_add+0x353/0x4b0 drivers/tty/serial/serial_base_bus.c:178
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3310 [inline]
       serial_core_register_port+0x137/0x1b00 drivers/tty/serial/serial_core.c:3351
       serial8250_register_8250_port+0x140d/0x2080 drivers/tty/serial/8250/8250_core.c:1139
       serial_pnp_probe+0x47d/0x880 drivers/tty/serial/8250/8250_pnp.c:478
       pnp_device_probe+0x2a3/0x4c0 drivers/pnp/driver.c:111
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x234/0xc90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
       __driver_attach+0x274/0x570 drivers/base/dd.c:1216
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
       bus_add_driver+0x2e9/0x630 drivers/base/bus.c:673
       driver_register+0x15c/0x4a0 drivers/base/driver.c:246
       serial8250_init+0xba/0x4b0 drivers/tty/serial/8250/8250_core.c:1240
       do_one_initcall+0x117/0x630 init/main.c:1232
       do_initcall_level init/main.c:1294 [inline]
       do_initcalls init/main.c:1310 [inline]
       do_basic_setup init/main.c:1329 [inline]
       kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
       kernel_init+0x1c/0x2a0 init/main.c:1437
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #2 (&dev->power.lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0xab/0x170 drivers/base/power/runtime.c:1169
       pm_runtime_get include/linux/pm_runtime.h:408 [inline]
       __uart_start+0x1b0/0x420 drivers/tty/serial/serial_core.c:148
       uart_write+0x2ff/0x5b0 drivers/tty/serial/serial_core.c:618
       process_output_block drivers/tty/n_tty.c:579 [inline]
       n_tty_write+0x422/0x1130 drivers/tty/n_tty.c:2384
       iterate_tty_write drivers/tty/tty_io.c:1017 [inline]
       file_tty_write.constprop.0+0x519/0x9b0 drivers/tty/tty_io.c:1088
       tty_write drivers/tty/tty_io.c:1109 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1132 [inline]
       redirected_tty_write+0xa6/0xc0 drivers/tty/tty_io.c:1112
       call_write_iter include/linux/fs.h:1986 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x650/0xe40 fs/read_write.c:584
       ksys_write+0x12f/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       serial8250_console_write+0x57e/0x1060 drivers/tty/serial/8250/8250_port.c:3408
       console_emit_next_record kernel/printk/printk.c:2910 [inline]
       console_flush_all+0x4eb/0xfb0 kernel/printk/printk.c:2966
       console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2332
       register_console+0xa67/0x10d0 kernel/printk/printk.c:3524
       univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0xba/0x5c0 kernel/printk/printk.c:3667
       start_kernel+0x25a/0x480 init/main.c:1004
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #0 (console_owner){-.-.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       console_lock_spinning_enable kernel/printk/printk.c:1858 [inline]
       console_emit_next_record kernel/printk/printk.c:2904 [inline]
       console_flush_all+0x4c1/0xfb0 kernel/printk/printk.c:2966
       console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2332
       __warn_printk+0x158/0x350 kernel/panic.c:720
       del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
       __free_one_page+0x3eb/0xa50 mm/page_alloc.c:830
       free_pcppages_bulk+0x2f3/0x610 mm/page_alloc.c:1233
       free_unref_page_list+0x859/0x1050 mm/page_alloc.c:2568
       shrink_folio_list+0x2815/0x3f00 mm/vmscan.c:1500
       evict_folios+0x6bf/0x1940 mm/vmscan.c:4519
       try_to_shrink_lruvec+0x769/0xb00 mm/vmscan.c:4695
       shrink_one+0x45f/0x700 mm/vmscan.c:4739
       shrink_many mm/vmscan.c:4793 [inline]
       lru_gen_shrink_node mm/vmscan.c:4910 [inline]
       shrink_node+0x215f/0x3850 mm/vmscan.c:5850
       kswapd_shrink_node mm/vmscan.c:6655 [inline]
       balance_pgdat+0xa32/0x1b80 mm/vmscan.c:6845
       kswapd+0x5be/0xbf0 mm/vmscan.c:7105
       kthread+0x33c/0x440 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

other info that might help us debug this:

Chain exists of:
  console_owner --> &pool->lock --> &zone->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&zone->lock);
                               lock(&pool->lock);
                               lock(&zone->lock);
  lock(console_owner);

 *** DEADLOCK ***

5 locks held by kswapd0/80:
 #0: ffffffff8cd159a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x1b4/0x1b80 mm/vmscan.c:6733
 #1: ffff8880b99425d8 (&pcp->lock){+.+.}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #1: ffff8880b99425d8 (&pcp->lock){+.+.}-{2:2}, at: free_unref_page_list+0xb16/0x1050 mm/page_alloc.c:2549
 #2: ffff88813fffacd8 (&zone->lock){-.-.}-{2:2}, at: free_pcppages_bulk+0x6a/0x610 mm/page_alloc.c:1202
 #3: ffffffff8cb98360 (console_lock){+.+.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1927 [inline]
 #3: ffffffff8cb98360 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2306
 #4: ffffffff8cb983d0 (console_srcu){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
 #4: ffffffff8cb983d0 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #4: ffffffff8cb983d0 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:292 [inline]
 #4: ffffffff8cb983d0 (console_srcu){....}-{0:0}, at: console_flush_all+0x12d/0xfb0 kernel/printk/printk.c:2958

stack backtrace:
CPU: 1 PID: 80 Comm: kswapd0 Not tainted 6.6.0-rc1-next-20230915-syzkaller #0
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
 console_lock_spinning_enable kernel/printk/printk.c:1858 [inline]
 console_emit_next_record kernel/printk/printk.c:2904 [inline]
 console_flush_all+0x4c1/0xfb0 kernel/printk/printk.c:2966
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 __warn_printk+0x158/0x350 kernel/panic.c:720
 del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
 __free_one_page+0x3eb/0xa50 mm/page_alloc.c:830
 free_pcppages_bulk+0x2f3/0x610 mm/page_alloc.c:1233
 free_unref_page_list+0x859/0x1050 mm/page_alloc.c:2568
 shrink_folio_list+0x2815/0x3f00 mm/vmscan.c:1500
 evict_folios+0x6bf/0x1940 mm/vmscan.c:4519
 try_to_shrink_lruvec+0x769/0xb00 mm/vmscan.c:4695
 shrink_one+0x45f/0x700 mm/vmscan.c:4739
 shrink_many mm/vmscan.c:4793 [inline]
 lru_gen_shrink_node mm/vmscan.c:4910 [inline]
 shrink_node+0x215f/0x3850 mm/vmscan.c:5850
 kswapd_shrink_node mm/vmscan.c:6655 [inline]
 balance_pgdat+0xa32/0x1b80 mm/vmscan.c:6845
 kswapd+0x5be/0xbf0 mm/vmscan.c:7105
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
page type is 0, passed migratetype is 1 (nr=512)
WARNING: CPU: 1 PID: 80 at mm/page_alloc.c:699 del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
Modules linked in:
CPU: 1 PID: 80 Comm: kswapd0 Not tainted 6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:del_page_from_free_list+0x36e/0x490 mm/page_alloc.c:699
Code: 89 ef be 07 00 00 00 e8 e0 f6 ff ff 44 89 e1 44 89 f2 48 c7 c7 20 b6 99 8a 48 89 c6 b8 01 00 00 00 d3 e0 89 c1 e8 d2 3b 7c ff <0f> 0b e9 d2 fc ff ff 48 c7 c6 80 b7 99 8a 48 89 df e8 9c 46 f4 ff
RSP: 0018:ffffc900020af1d0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffea0001bd8000 RCX: 0000000000000000
RDX: ffff888012d15940 RSI: ffffffff814e0396 RDI: 0000000000000001
RBP: 000000000006f600 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000009
R13: ffff88813fffa700 R14: 0000000000000001 R15: ffffea0001bd8000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555568a5938 CR3: 000000000c976000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __free_one_page+0x3eb/0xa50 mm/page_alloc.c:830
 free_pcppages_bulk+0x2f3/0x610 mm/page_alloc.c:1233
 free_unref_page_list+0x859/0x1050 mm/page_alloc.c:2568
 shrink_folio_list+0x2815/0x3f00 mm/vmscan.c:1500
 evict_folios+0x6bf/0x1940 mm/vmscan.c:4519
 try_to_shrink_lruvec+0x769/0xb00 mm/vmscan.c:4695
 shrink_one+0x45f/0x700 mm/vmscan.c:4739
 shrink_many mm/vmscan.c:4793 [inline]
 lru_gen_shrink_node mm/vmscan.c:4910 [inline]
 shrink_node+0x215f/0x3850 mm/vmscan.c:5850
 kswapd_shrink_node mm/vmscan.c:6655 [inline]
 balance_pgdat+0xa32/0x1b80 mm/vmscan.c:6845
 kswapd+0x5be/0xbf0 mm/vmscan.c:7105
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
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
