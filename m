Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD57DCCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjJaMSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbjJaMSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:18:31 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C55EA1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:18:28 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1e98b1bad34so7369928fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698754707; x=1699359507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YKsBhoI1sio+KQS7arIHpaTsMDI5v5cWKzvR/mKBVA=;
        b=WTX77C1kMBgAAyrujwf9Jwk5jvlmH9amxZ5fi9sTZKQRg1dWF/e96ka5T7gT9MxRuZ
         6esqcEmkkJlQEhESlYayZY0DW1OoYgG04SoAY6oHKQw5faYIz+MYpHhM8aWvxidrJS85
         xHW9iC/Evagd4kfF9rJAkl3WwqWQsO7eO7us26YSe576rT6rWv0XE+lzxbDPGyrR7ukZ
         x13FAPFeJq3D2oijuwQhAlo5fPbkusFwljX072qBZLoW52w4SEUv//zZZjtaU77tQ4OI
         C6Q78wbe0DcajKoa/pGH31w2IZB5oaGXtJSnJNgD/F9pTysfG43GMLW6wchh1o7bJfbT
         2Mlw==
X-Gm-Message-State: AOJu0YyzoDZ1q+bgg/q0zESGOBfPFCasiA/44iPPggVtXVxzE5wZPNDf
        2EvTStkLBtyFmY+YPDZwyZdtl1YkjFO9nWYiid0bkkASCTRe
X-Google-Smtp-Source: AGHT+IGTJlyrEt7/3/S707b6OY2WXW1sKwaVgPDQ221dE+bINEaaL1B9a1Gq0YwBrtH/hiHA/iR8q/qHvl5OhI/4z0eUnUWdx6Go
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b523:b0:1dc:e729:66f7 with SMTP id
 v35-20020a056870b52300b001dce72966f7mr6461190oap.8.1698754707758; Tue, 31 Oct
 2023 05:18:27 -0700 (PDT)
Date:   Tue, 31 Oct 2023 05:18:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eaa62d0609022600@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sco_chan_del
From:   syzbot <syzbot+8e6467fa0a1a160c9bbb@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4f82870119a4 Merge tag 'mm-hotfixes-stable-2023-10-24-09-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b1b5a3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=8e6467fa0a1a160c9bbb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb40650f0163/disk-4f828701.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1249f360a01/vmlinux-4f828701.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9af85659ca91/bzImage-4f828701.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e6467fa0a1a160c9bbb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hci_core.h:1549 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hci_core.h:1519 [inline]
BUG: KASAN: slab-use-after-free in sco_chan_del+0x4bf/0x4f0 net/bluetooth/sco.c:171
Read of size 8 at addr ffff88807bd46a58 by task syz-executor.5/23800

CPU: 1 PID: 23800 Comm: syz-executor.5 Not tainted 6.6.0-rc7-syzkaller-00039-g4f82870119a4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 hci_conn_drop include/net/bluetooth/hci_core.h:1549 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1519 [inline]
 sco_chan_del+0x4bf/0x4f0 net/bluetooth/sco.c:171
 __sco_sock_close+0xf2/0x690 net/bluetooth/sco.c:454
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0x6f/0x2c0 net/bluetooth/sco.c:1246
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 get_signal+0x106f/0x2790 kernel/signal.c:2668
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f150d47cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f150e1ff0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f150d59c050 RCX: 00007f150d47cae9
RDX: 0000000000000008 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f150d4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f150d59c050 R15: 00007ffc409e1338
 </TASK>

Allocated by task 23800:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 hci_conn_add+0xc2/0x17c0 net/bluetooth/hci_conn.c:957
 hci_connect_sco+0x3a0/0xf80 net/bluetooth/hci_conn.c:1701
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x2c7/0xa80 net/bluetooth/sco.c:591
 __sys_connect_file+0x15b/0x1a0 net/socket.c:2050
 __sys_connect+0x145/0x170 net/socket.c:2067
 __do_sys_connect net/socket.c:2077 [inline]
 __se_sys_connect net/socket.c:2074 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 19887:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 device_release+0xa1/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1d0/0x440 lib/kobject.c:733
 put_device+0x1f/0x30 drivers/base/core.c:3732
 hci_conn_cleanup_child net/bluetooth/hci_conn.c:1065 [inline]
 hci_conn_unlink+0x71b/0x9e0 net/bluetooth/hci_conn.c:1092
 hci_conn_del+0x59/0xd80 net/bluetooth/hci_conn.c:1118
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff88807bd46000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2648 bytes inside of
 freed 4096-byte region [ffff88807bd46000, ffff88807bd47000)

The buggy address belongs to the physical page:
page:ffffea0001ef5000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bd40
head:ffffea0001ef5000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 21210, tgid 21210 (kworker/1:4), ts 1947372032238, free_ts 1947098144795
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2299
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1046
 kmalloc_reserve+0xef/0x260 net/core/skbuff.c:581
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x29e/0xc70 drivers/net/netdevsim/dev.c:850
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x195/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1039
 kmalloc_array include/linux/slab.h:636 [inline]
 kcalloc include/linux/slab.h:667 [inline]
 iter_file_splice_write+0x167/0xbf0 fs/splice.c:676
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1316 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x155/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807bd46900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807bd46980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807bd46a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88807bd46a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807bd46b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
