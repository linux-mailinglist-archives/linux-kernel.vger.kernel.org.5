Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B37EBCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjKOFjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjKOFje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:39:34 -0500
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE90BEB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:39:30 -0800 (PST)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-6bdd2f09939so6411913b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700026770; x=1700631570;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQNab41l7889th/YAdJJK4a1KLlYZxXCziDehjTBEDc=;
        b=SGc54As9bqPjL0QVQ2PpB5PwDvXeEF38EMGb6sEh6EuAf2S2AkoLn2mNlaAECwZrt+
         PjAKV21PkSI4csin2eeI/mhYwL9XTRBCWiFRGR7wXexKk7RFYMt6MYz6YHA09xA/RegL
         l64hSdygGCwxW9D93D0ydsk/1YYG1kXy55H4CFo2Q/7KV6/h/PQAsns+RnhP6OWlcxKB
         6Vjn9WIwcg7QnvIqEykb++NJUakMsN/0l3JZbmUqv6wntV93MNkt9s1XywOH3tzNHNBI
         jpOLFt52LgQVIT9uLqAe+9/BoW0HCO8nT2Nwkgh5+fW65ciBJMf+BxPw/HguPqlUSOTw
         s5Fg==
X-Gm-Message-State: AOJu0YyXeZwgqu67HbinjUXaDpuhzMFhy6DH8XYRtHyoUZcvpmLo3tUB
        NAGc7rVg7aoJ0B/lEFFsFpkSaTMBGUv09DPkgdRmx8Q1mB1u
X-Google-Smtp-Source: AGHT+IEG44GhKCalAtbiPppkfVpRtanGf41uYnphSI8fH+eqJTo69uT3Bzn9xPFJ/ZzxOT5CGek0wBmYygxZIlOu7xH8fjHNWUKN
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:8a89:b0:6be:208:4bbb with SMTP id
 id9-20020a056a008a8900b006be02084bbbmr3061184pfb.3.1700026770435; Tue, 14 Nov
 2023 21:39:30 -0800 (PST)
Date:   Tue, 14 Nov 2023 21:39:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2b9a5060a2a5339@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect
From:   syzbot <syzbot+c23a22651335aa864a7a@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    be3ca57cfb77 Merge tag 'media/v6.7-1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1256c787680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ffa1cec3b40f3ce
dashboard link: https://syzkaller.appspot.com/bug?extid=c23a22651335aa864a7a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09ea6e07e1d4/disk-be3ca57c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/acd288df0801/vmlinux-be3ca57c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40e81640103b/bzImage-be3ca57c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c23a22651335aa864a7a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_connect+0x10a5/0x1280 net/bluetooth/l2cap_core.c:4145
Read of size 8 at addr ffff88802a57b800 by task kworker/u5:7/5111

CPU: 0 PID: 5111 Comm: kworker/u5:7 Not tainted 6.6.0-syzkaller-15029-gbe3ca57cfb77 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci5 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 l2cap_connect+0x10a5/0x1280 net/bluetooth/l2cap_core.c:4145
 l2cap_connect_req net/bluetooth/l2cap_core.c:4287 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:5738 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:6523 [inline]
 l2cap_recv_frame+0x3074/0x9440 net/bluetooth/l2cap_core.c:7802
 l2cap_recv_acldata+0xa3d/0xbf0 net/bluetooth/l2cap_core.c:8520
 hci_acldata_packet net/bluetooth/hci_core.c:3875 [inline]
 hci_rx_work+0xaa7/0x1610 net/bluetooth/hci_core.c:4110
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 50:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 l2cap_conn_add.part.0+0x60/0xdf0 net/bluetooth/l2cap_core.c:7845
 l2cap_conn_add net/bluetooth/l2cap_core.c:71 [inline]
 l2cap_connect_cfm+0x424/0xfb0 net/bluetooth/l2cap_core.c:8242
 hci_connect_cfm include/net/bluetooth/hci_core.h:1959 [inline]
 hci_remote_features_evt+0x565/0xa70 net/bluetooth/hci_event.c:3765
 hci_event_func net/bluetooth/hci_event.c:7677 [inline]
 hci_event_packet+0x9d3/0x1160 net/bluetooth/hci_event.c:7729
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4105
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Freed by task 50:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xc0/0x180 mm/slub.c:3822
 l2cap_conn_free net/bluetooth/l2cap_core.c:1949 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1961 [inline]
 l2cap_conn_del+0x592/0x740 net/bluetooth/l2cap_core.c:1941
 l2cap_connect_cfm+0xa10/0xfb0 net/bluetooth/l2cap_core.c:8238
 hci_connect_cfm include/net/bluetooth/hci_core.h:1959 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1283
 hci_abort_conn_sync+0x758/0xb50 net/bluetooth/hci_sync.c:5424
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2957
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 insert_work+0x38/0x230 kernel/workqueue.c:1647
 __queue_work+0x5d0/0x1050 kernel/workqueue.c:1799
 call_timer_fn+0x193/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1746 [inline]
 __run_timers+0x585/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x21a/0x968 kernel/softirq.c:553

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 insert_work+0x38/0x230 kernel/workqueue.c:1647
 __queue_work+0xb77/0x1050 kernel/workqueue.c:1803
 queue_work_on+0xed/0x110 kernel/workqueue.c:1834
 queue_work include/linux/workqueue.h:562 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1779 [inline]
 l2cap_connect_cfm+0x9f3/0xfb0 net/bluetooth/l2cap_core.c:8283
 hci_connect_cfm include/net/bluetooth/hci_core.h:1959 [inline]
 hci_remote_features_evt+0x565/0xa70 net/bluetooth/hci_event.c:3765
 hci_event_func net/bluetooth/hci_event.c:7677 [inline]
 hci_event_packet+0x9d3/0x1160 net/bluetooth/hci_event.c:7729
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4105
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff88802a57b800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88802a57b800, ffff88802a57bc00)

The buggy address belongs to the physical page:
page:ffffea0000a95e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a578
head:ffffea0000a95e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041dc0 ffffea00006f5200 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 29439741396, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xa25/0x36c0 mm/page_alloc.c:3312
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4568
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1027
 __do_krealloc mm/slab_common.c:1395 [inline]
 krealloc+0x5d/0x100 mm/slab_common.c:1428
 add_sysfs_param+0xca/0x960 kernel/params.c:652
 kernel_add_sysfs_param kernel/params.c:813 [inline]
 param_sysfs_builtin kernel/params.c:852 [inline]
 param_sysfs_builtin_init+0x2ca/0x450 kernel/params.c:986
 do_one_initcall+0x11c/0x640 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802a57b700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a57b780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802a57b800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802a57b880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a57b900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
