Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE98178FA6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348707AbjIAJGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjIAJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:06:14 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327E10DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:06:06 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1c09c1fd0abso19897125ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693559166; x=1694163966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47w2N3iWIFb4aRB54G6TP0u3uEDRptdaOjsgNJZVlLs=;
        b=e9VKhdWErfcerVUojCEfe87s6Jyt3t6HSeOyRiAgoOErVvAvJ17OhGgGD5vU/sZTTV
         HouLbzdxaPeLv/9MeOKpmSfM8GyR4gnzm6reTl6mtzNGoYZhbEuzil0BWp95cnOrBc3h
         GpGmD2DYCHO9PjnrkdGXpEv4jgpun+gXBkSMl/Ge+GoqA+AalKIIIL1FOAYBTqD0qw0r
         20a5WEqf4uIzsyhdGhEA0nWj2Z5NhcWfl0WaS2MWA0e/QyucXSB5GhaOL6vc2MIr/BWD
         7kEvWM5KcLm9EjaLBMg+TI2MrZEji44svBvzIl5yx8Kkmf2edf6UBdxsTmzqXgLIVf9s
         CWFw==
X-Gm-Message-State: AOJu0Yxm2jZ1RRseM56RcTjjAMAI2jfXUvQhyPA8iOUueDcCWqqMbeYc
        ZBinyEKWFxk/XHu+EYJ4Jus8MjZh16KCZnQeoHXoC/Wx+wfz
X-Google-Smtp-Source: AGHT+IHxa1z6o/FkpsLWptgkvmyZ2gN0aHKADySIiLhVq5qpLNRNEcjpq6inDM7bQbhd7/sxb4lSL7TdW3RX/er/g0c86p6nIStY
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68d:b0:1b8:8fe2:6627 with SMTP id
 l13-20020a170902f68d00b001b88fe26627mr745245plg.8.1693559166040; Fri, 01 Sep
 2023 02:06:06 -0700 (PDT)
Date:   Fri, 01 Sep 2023 02:06:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f826b06044878ed@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From:   syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6c1b980a7e79 Merge tag 'dma-mapping-6.6-2023-08-29' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1186462fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2212484c18930a61
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6e2281f5cb6b/disk-6c1b980a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fc2481dcded/vmlinux-6c1b980a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/283bb76567da/bzImage-6c1b980a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hci_core.h:1523 [inline]
BUG: KASAN: slab-use-after-free in __sco_sock_close+0x2bc/0x690 net/bluetooth/sco.c:444
Write of size 4 at addr ffff888019f84010 by task syz-executor.5/15739

CPU: 1 PID: 15739 Comm: syz-executor.5 Not tainted 6.5.0-syzkaller-04808-g6c1b980a7e79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1523 [inline]
 __sco_sock_close+0x2bc/0x690 net/bluetooth/sco.c:444
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0x6f/0x2c0 net/bluetooth/sco.c:1246
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1401
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fba94e7b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffcf2751f30 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fba94e7b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fba94f9d980 R08: 0000001b30360000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000061f62
R13: ffffffffffffffff R14: 00007fba94a00000 R15: 0000000000061c21
 </TASK>

Allocated by task 15740:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 hci_conn_add+0xc2/0x1770 net/bluetooth/hci_conn.c:957
 hci_connect_sco+0x3ac/0xf80 net/bluetooth/hci_conn.c:1692
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x2c7/0xa50 net/bluetooth/sco.c:591
 __sys_connect_file+0x15b/0x1a0 net/socket.c:2032
 __sys_connect+0x145/0x170 net/socket.c:2049
 __do_sys_connect net/socket.c:2059 [inline]
 __se_sys_connect net/socket.c:2056 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5069:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 device_release+0xa1/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:713 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x5b0 lib/kobject.c:730
 put_device+0x1f/0x30 drivers/base/core.c:3731
 hci_abort_conn_sync+0xacb/0xe20 net/bluetooth/hci_sync.c:5435
 abort_conn_sync+0x18e/0x3a0 net/bluetooth/hci_conn.c:2894
 hci_cmd_sync_work+0x1a4/0x3c0 net/bluetooth/hci_sync.c:306
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888019f84000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff888019f84000, ffff888019f85000)

The buggy address belongs to the physical page:
page:ffffea000067e000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x19f80
head:ffffea000067e000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012842140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 8581, tgid 8581 (udevd), ts 361782857719, free_ts 361723087478
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3183
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4439
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_realpath_from_path+0xb9/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2aa/0x3b0 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa8/0xd0 security/tomoyo/tomoyo.c:327
 security_file_open+0x6a/0xe0 security/security.c:2811
 do_dentry_open+0x538/0x1730 fs/open.c:916
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3502
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0x100/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888019f83f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888019f83f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888019f84000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888019f84080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888019f84100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
