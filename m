Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A81782ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjHUQyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjHUQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:54:08 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC7FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:54:05 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-68a3cae6d3aso1757651b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636845; x=1693241645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIXjl6SZJ57SZ0hs/YFG4VmhduB/c8EW7xFI8zLQ3+M=;
        b=Pk5tPy2qd5+nXq8wgn4G/2LxKfJopG+Mxp+HmCtMnhuahZCyZnYhud4gtpr2GyTGXv
         hDs+q/BaC/kyLHkO21SDBOajKVFJ7SG+2fPcQnmsgdwj7y4SG+6PZjQTS/cp1/sdLed5
         uS/hsdP9hJBM4op+qhP7s63d7LPcolyVszhLEivkRibLZkmgeN8bNitVHguP8T/Xg6Ir
         X4gV70ablzMkRfVQvzB+mulg46zTMeOHmLg261JCkb1vn9JFr7cFYUaNi2LnoOwD4vKH
         D0/quc7lgRPsYrX7aU+tpVFrbbaQYInnnycI5UPFkBjdLq4JAWmxWaCrzxlJC+Yse/FR
         4DOQ==
X-Gm-Message-State: AOJu0YwlzWfCn3FZ+T1Zr/pPyNIziwDRe9vohD8AAnR52vODDhfYv04r
        VhXCGRXqOOK0RAlfG/8i+SzugWi3oyxii2j+rllBY5yh/x1Q
X-Google-Smtp-Source: AGHT+IEQcNB93qMf7Ohn56WWTNWU/HKzBFBzkK+srrkc5CgtP/NosnIuOIdsEeMcc3IbypzkANqpg/DZgXn9Y8zR/bXCRWzc/d2t
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2354:b0:68a:5aca:9858 with SMTP id
 j20-20020a056a00235400b0068a5aca9858mr939526pfj.4.1692636845275; Mon, 21 Aug
 2023 09:54:05 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:54:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e58567060371b9dd@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in __usb_hcd_giveback_urb
From:   syzbot <syzbot+c112bdc84725cc12e9d7@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    12e6ccedb311 Merge tag 'for-6.5-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a473c3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=c112bdc84725cc12e9d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98b787651bf9/disk-12e6cced.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77bae22a06a8/vmlinux-12e6cced.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c557fef4b74/bzImage-12e6cced.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c112bdc84725cc12e9d7@syzkaller.appspotmail.com

xpad 4-1:179.65: xpad_irq_in - usb_submit_urb failed with result -19
xpad 4-1:179.65: xpad_irq_out - usb_submit_urb failed with result -19
==================================================================
BUG: KASAN: slab-use-after-free in register_lock_class+0x8ec/0x990 kernel/locking/lockdep.c:1341
Read of size 1 at addr ffff88807e3f8891 by task udevd/4469

CPU: 1 PID: 4469 Comm: udevd Not tainted 6.5.0-rc6-syzkaller-00243-g12e6ccedb311 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 register_lock_class+0x8ec/0x990 kernel/locking/lockdep.c:1341
 __lock_acquire+0x190/0x7f70 kernel/locking/lockdep.c:5021
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock kernel/sched/wait.c:137 [inline]
 __wake_up+0x101/0x1d0 kernel/sched/wait.c:160
 __usb_hcd_giveback_urb+0x3a8/0x530 drivers/usb/core/hcd.c:1674
 dummy_timer+0x8aa/0x3210 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x178/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x64f/0x860 kernel/time/timer.c:2022
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2035
 __do_softirq+0x2ab/0x908 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu+0xf1/0x1b0 kernel/softirq.c:632
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__do_kmalloc_node mm/slab_common.c:979 [inline]
RIP: 0010:__kmalloc+0x4b/0x230 mm/slab_common.c:998
Code: 20 00 00 0f 83 dc 00 00 00 49 81 fc c0 00 00 00 77 1a 4d 85 e4 0f 84 b2 00 00 00 41 8d 44 24 ff c1 e8 03 0f b6 80 d0 b4 c8 8c <eb> 15 41 8d 44 24 ff 89 44 24 04 b8 ff ff ff ff 0f bd 44 24 04 ff
RSP: 0018:ffffc90005a6f8f0 EFLAGS: 00000206
RAX: 0000000000000006 RBX: dffffc0000000000 RCX: 0000000000000001
RDX: ffff88807d3d3b80 RSI: 0000000000000d40 RDI: 0000000000000034
RBP: ffff88802d052fd5 R08: ffffffff83f876b5 R09: 1ffffffff1d30ee5
R10: dffffc0000000000 R11: fffffbfff1d30ee6 R12: 0000000000000034
R13: 0000000000000d40 R14: ffffffff83f876ef R15: ffff88802d052fd5
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x530 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x598/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x28d/0x700 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2114
 vfs_getattr fs/stat.c:167 [inline]
 vfs_statx+0x18f/0x480 fs/stat.c:242
 vfs_fstatat fs/stat.c:276 [inline]
 __do_sys_newfstatat fs/stat.c:446 [inline]
 __se_sys_newfstatat fs/stat.c:440 [inline]
 __x64_sys_newfstatat+0x14f/0x1d0 fs/stat.c:440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5afc5165f4
Code: 64 c7 00 09 00 00 00 83 c8 ff c3 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 00 00 00 00 41 89 ca b8 06 01 00 00 0f 05 <45> 31 c0 3d 00 f0 ff ff 76 10 48 8b 15 03 a8 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffe54728548 EFLAGS: 00000202 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 0000559a69f9e550 RCX: 00007f5afc5165f4
RDX: 00007ffe54728560 RSI: 00007f5afc5b3130 RDI: 000000000000000d
RBP: 0000559a69fb6410 R08: 0000000000090800 R09: 0000559a69f87540
R10: 0000000000001000 R11: 0000000000000202 R12: 00007ffe54728560
R13: 00000000000000ff R14: 0000559a694341c4 R15: 0000000000000000
 </TASK>

Allocated by task 22871:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 xpad_probe+0x3c8/0x1b90 drivers/input/joystick/xpad.c:1975
 usb_probe_interface+0x5c4/0xb00 drivers/usb/core/driver.c:396
 really_probe+0x294/0xc30 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:798
 driver_probe_device+0x50/0x420 drivers/base/dd.c:828
 __device_attach_driver+0x2d3/0x520 drivers/base/dd.c:956
 bus_for_each_drv+0x24a/0x2d0 drivers/base/bus.c:457
 __device_attach+0x32f/0x510 drivers/base/dd.c:1028
 bus_probe_device+0x185/0x260 drivers/base/bus.c:532
 device_add+0xb75/0xf60 drivers/base/core.c:3625
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:238
 usb_probe_device+0x134/0x270 drivers/usb/core/driver.c:293
 really_probe+0x294/0xc30 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:798
 driver_probe_device+0x50/0x420 drivers/base/dd.c:828
 __device_attach_driver+0x2d3/0x520 drivers/base/dd.c:956
 bus_for_each_drv+0x24a/0x2d0 drivers/base/bus.c:457
 __device_attach+0x32f/0x510 drivers/base/dd.c:1028
 bus_probe_device+0x185/0x260 drivers/base/bus.c:532
 device_add+0xb75/0xf60 drivers/base/core.c:3625
 usb_new_device+0xb7e/0x18d0 drivers/usb/core/hub.c:2590
 hub_port_connect drivers/usb/core/hub.c:5422 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 port_event drivers/usb/core/hub.c:5726 [inline]
 hub_event+0x2e9e/0x52c0 drivers/usb/core/hub.c:5808
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Freed by task 27585:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3814
 xpad_disconnect+0x359/0x490 drivers/input/joystick/xpad.c:2156
 usb_unbind_interface+0x1d1/0x840 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x4f9/0x7a0 drivers/base/dd.c:1293
 bus_remove_device+0x341/0x410 drivers/base/bus.c:574
 device_del+0x538/0x9c0 drivers/base/core.c:3814
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1420
 usb_disconnect+0x340/0x8d0 drivers/usb/core/hub.c:2253
 hub_port_connect drivers/usb/core/hub.c:5261 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 port_event drivers/usb/core/hub.c:5726 [inline]
 hub_event+0x1f25/0x52c0 drivers/usb/core/hub.c:5808
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 insert_work+0x54/0x3d0 kernel/workqueue.c:1556
 __queue_work+0xb37/0xf10 kernel/workqueue.c:1717
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1747
 ops_exit_list net/core/net_namespace.c:170 [inline]
 setup_net+0x8c8/0xbb0 net/core/net_namespace.c:362
 copy_net_ns+0x4e3/0x7a0 net/core/net_namespace.c:491
 create_new_namespaces+0x425/0x7a0 kernel/nsproxy.c:110
 copy_namespaces+0x399/0x410 kernel/nsproxy.c:179
 copy_process+0x1af8/0x4290 kernel/fork.c:2507
 kernel_clone+0x222/0x800 kernel/fork.c:2912
 __do_sys_clone kernel/fork.c:3055 [inline]
 __se_sys_clone kernel/fork.c:3039 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:3039
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807e3f8800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 145 bytes inside of
 freed 1024-byte region [ffff88807e3f8800, ffff88807e3f8c00)

The buggy address belongs to the physical page:
page:ffffea0001f8fe00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e3f8
head:ffffea0001f8fe00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012841dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5057, tgid 5057 (syz-executor.3), ts 190975681186, free_ts 153970641166
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
 alloc_slab_page+0x6a/0x160 mm/slub.c:1862
 allocate_slab mm/slub.c:2009 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2062
 ___slab_alloc+0xade/0x1100 mm/slub.c:3215
 __slab_alloc mm/slub.c:3314 [inline]
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node_track_caller+0xa5/0x230 mm/slab_common.c:1005
 kmalloc_reserve+0xfe/0x240 net/core/skbuff.c:575
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1289 [inline]
 nlmsg_new include/net/netlink.h:1003 [inline]
 inet6_rt_notify+0xe0/0x290 net/ipv6/route.c:6171
 fib6_add_rt2node net/ipv6/ip6_fib.c:1251 [inline]
 fib6_add+0x1dc4/0x3d40 net/ipv6/ip6_fib.c:1477
 __ip6_ins_rt net/ipv6/route.c:1301 [inline]
 ip6_ins_rt+0x106/0x170 net/ipv6/route.c:1311
 __ipv6_ifa_notify+0x5c0/0x11d0 net/ipv6/addrconf.c:6168
 ipv6_ifa_notify net/ipv6/addrconf.c:6207 [inline]
 add_addr+0x2ce/0x480 net/ipv6/addrconf.c:3113
 add_v4_addrs+0x8d3/0x1180 net/ipv6/addrconf.c:3172
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2443
 __slab_free+0x2f6/0x390 mm/slub.c:3707
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x6c/0x3b0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x123/0x300 mm/slub.c:3494
 mt_alloc_one lib/maple_tree.c:159 [inline]
 mas_alloc_nodes+0x276/0x800 lib/maple_tree.c:1282
 mas_node_count_gfp lib/maple_tree.c:1362 [inline]
 mas_preallocate+0x131/0x350 lib/maple_tree.c:5547
 vma_iter_prealloc mm/internal.h:1032 [inline]
 vma_expand+0x3b9/0x610 mm/mmap.c:666
 mmap_region+0xaed/0x2310 mm/mmap.c:2716
 do_mmap+0x8cf/0xf80 mm/mmap.c:1363
 vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807e3f8780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e3f8800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807e3f8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807e3f8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e3f8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	20 00                	and    %al,(%rax)
   2:	00 0f                	add    %cl,(%rdi)
   4:	83 dc 00             	sbb    $0x0,%esp
   7:	00 00                	add    %al,(%rax)
   9:	49 81 fc c0 00 00 00 	cmp    $0xc0,%r12
  10:	77 1a                	ja     0x2c
  12:	4d 85 e4             	test   %r12,%r12
  15:	0f 84 b2 00 00 00    	je     0xcd
  1b:	41 8d 44 24 ff       	lea    -0x1(%r12),%eax
  20:	c1 e8 03             	shr    $0x3,%eax
  23:	0f b6 80 d0 b4 c8 8c 	movzbl -0x73374b30(%rax),%eax
* 2a:	eb 15                	jmp    0x41 <-- trapping instruction
  2c:	41 8d 44 24 ff       	lea    -0x1(%r12),%eax
  31:	89 44 24 04          	mov    %eax,0x4(%rsp)
  35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  3a:	0f bd 44 24 04       	bsr    0x4(%rsp),%eax
  3f:	ff                   	.byte 0xff


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
