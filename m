Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA827D6F79
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbjJYOkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344490AbjJYNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:11:07 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86251187
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:11:01 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-581f31b7327so984839eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239461; x=1698844261;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgxRn+yhvWU6sY3kGVpnRu89PHD4eeLWcN1AkLJYYbU=;
        b=WzdjC/2ZMM/qxK0ArXk+Vlxx/9VIqVPDmqvygBU0eCnL+BFWajgdffOkT9ZQVtsyYd
         pIeYvk4cVAOdjktNLI4NMnEnkcy42N4QJ60V0E5/Y6QOcMxt+28RBOVGCEUS3gJcMxDl
         oC6prR3V8XVbAqE5wHJyRxLoIz+kMBtfsO1KbgvfM8izP0JFjCxnJk9a/EfG02dE09Xj
         swBurovqdHr3ePd2XUALmLEmQfJec7WpxBeoZQRi8rP1EzmSl5bm7gC4k/VOnPJ0YWrk
         DMWARLpT1Ud/lVu9fYZ30JOkLFmEGLz8wtdii/TAbkUl6eaB/A+Xlg2Ab2ps64uu9efq
         AWyw==
X-Gm-Message-State: AOJu0YyUdlNnj3j5NrQDVt+PXjt6sLeSNpyu+pTXHjoblT/Fdr5PmHvH
        s3bA4F8qjLG9PPpEAolyUa1Z1o8FLdWaLfoypgMQfwX5HBXG
X-Google-Smtp-Source: AGHT+IF3gu/PA6FjgltrnUGlGRfO7voS1HFCPHJLmnUb5bko702hzHkDzHbeBArdYOFZiDzdd7CkK3rqA787mYYqjCEJmnGhkXs+
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c985:b0:1dd:69a:665d with SMTP id
 hi5-20020a056870c98500b001dd069a665dmr8087380oab.3.1698239460814; Wed, 25 Oct
 2023 06:11:00 -0700 (PDT)
Date:   Wed, 25 Oct 2023 06:11:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce35f206088a2f37@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in release_sock
From:   syzbot <syzbot+7e8507f89cd879bc6a29@syzkaller.appspotmail.com>
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

HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bf1871680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3bef7f900b4b3bd
dashboard link: https://syzkaller.appspot.com/bug?extid=7e8507f89cd879bc6a29
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9906b7e8449a/disk-c3200081.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e1922797b1c/vmlinux-c3200081.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25f7f1c023d2/bzImage-c3200081.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e8507f89cd879bc6a29@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inline]
BUG: KASAN: slab-use-after-free in waitqueue_active include/linux/wait.h:129 [inline]
BUG: KASAN: slab-use-after-free in release_sock+0x193/0x1b0 net/core/sock.c:3529
Read of size 8 at addr ffff888047d5b120 by task kworker/u5:0/10553

CPU: 0 PID: 10553 Comm: kworker/u5:0 Not tainted 6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 list_empty include/linux/list.h:373 [inline]
 waitqueue_active include/linux/wait.h:129 [inline]
 release_sock+0x193/0x1b0 net/core/sock.c:3529
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x1ac/0xb70 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x340 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 11594:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2090
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1720
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11594:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2218
 sk_destruct+0xc2/0xf0 net/core/sock.c:2233
 __sk_free+0xc4/0x3a0 net/core/sock.c:2244
 sk_free+0x7c/0xa0 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff888047d5b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 288 bytes inside of
 freed 2048-byte region [ffff888047d5b000, ffff888047d5b800)

The buggy address belongs to the physical page:
page:ffffea00011f5600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47d58
head:ffffea00011f5600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5066, tgid 5066 (syz-executor.4), ts 104812038932, free_ts 13078979756
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1033
 kmalloc_node include/linux/slab.h:619 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb3/0xa90 net/sched/sch_generic.c:938
 qdisc_create_dflt+0x73/0x3e0 net/sched/sch_generic.c:996
 attach_one_default_qdisc net/sched/sch_generic.c:1159 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2508 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1177 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1236
 __dev_open+0x383/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8626
 dev_change_flags+0x9a/0x170 net/core/dev.c:8698
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6342
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888047d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888047d5b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
Read of size 4 at addr ffff888047d5b09c by task kworker/u5:0/10553

CPU: 0 PID: 10553 Comm: kworker/u5:0 Tainted: G    B              6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
 do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x1ac/0xb70 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x340 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 11594:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2090
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1720
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11594:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2218
 sk_destruct+0xc2/0xf0 net/core/sock.c:2233
 __sk_free+0xc4/0x3a0 net/core/sock.c:2244
 sk_free+0x7c/0xa0 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff888047d5b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 156 bytes inside of
 freed 2048-byte region [ffff888047d5b000, ffff888047d5b800)

The buggy address belongs to the physical page:
page:ffffea00011f5600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47d58
head:ffffea00011f5600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5066, tgid 5066 (syz-executor.4), ts 104812038932, free_ts 13078979756
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1033
 kmalloc_node include/linux/slab.h:619 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb3/0xa90 net/sched/sch_generic.c:938
 qdisc_create_dflt+0x73/0x3e0 net/sched/sch_generic.c:996
 attach_one_default_qdisc net/sched/sch_generic.c:1159 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2508 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1177 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1236
 __dev_open+0x383/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8626
 dev_change_flags+0x9a/0x170 net/core/dev.c:8698
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6342
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888047d5af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888047d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:100 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:140
Read of size 4 at addr ffff888047d5b098 by task kworker/u5:0/10553

CPU: 0 PID: 10553 Comm: kworker/u5:0 Tainted: G    B              6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
 debug_spin_unlock kernel/locking/spinlock_debug.c:100 [inline]
 do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x1ac/0xb70 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x340 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 11594:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2090
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1720
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11594:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2218
 sk_destruct+0xc2/0xf0 net/core/sock.c:2233
 __sk_free+0xc4/0x3a0 net/core/sock.c:2244
 sk_free+0x7c/0xa0 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff888047d5b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 152 bytes inside of
 freed 2048-byte region [ffff888047d5b000, ffff888047d5b800)

The buggy address belongs to the physical page:
page:ffffea00011f5600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47d58
head:ffffea00011f5600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5066, tgid 5066 (syz-executor.4), ts 104812038932, free_ts 13078979756
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1033
 kmalloc_node include/linux/slab.h:619 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb3/0xa90 net/sched/sch_generic.c:938
 qdisc_create_dflt+0x73/0x3e0 net/sched/sch_generic.c:996
 attach_one_default_qdisc net/sched/sch_generic.c:1159 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2508 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1177 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1236
 __dev_open+0x383/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8626
 dev_change_flags+0x9a/0x170 net/core/dev.c:8698
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6342
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888047d5af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888047d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
BUG: KASAN: slab-use-after-free in raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:444 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
BUG: KASAN: slab-use-after-free in queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:100 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x1ed/0x230 kernel/locking/spinlock_debug.c:140
Read of size 4 at addr ffff888047d5b098 by task kworker/u5:0/10553

CPU: 0 PID: 10553 Comm: kworker/u5:0 Tainted: G    B              6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
 raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:444 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
 queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
 debug_spin_unlock kernel/locking/spinlock_debug.c:100 [inline]
 do_raw_spin_unlock+0x1ed/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x1ac/0xb70 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x340 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 11594:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2090
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1720
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11594:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2218
 sk_destruct+0xc2/0xf0 net/core/sock.c:2233
 __sk_free+0xc4/0x3a0 net/core/sock.c:2244
 sk_free+0x7c/0xa0 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff888047d5b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 152 bytes inside of
 freed 2048-byte region [ffff888047d5b000, ffff888047d5b800)

The buggy address belongs to the physical page:
page:ffffea00011f5600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47d58
head:ffffea00011f5600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5066, tgid 5066 (syz-executor.4), ts 104812038932, free_ts 13078979756
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1033
 kmalloc_node include/linux/slab.h:619 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb3/0xa90 net/sched/sch_generic.c:938
 qdisc_create_dflt+0x73/0x3e0 net/sched/sch_generic.c:996
 attach_one_default_qdisc net/sched/sch_generic.c:1159 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2508 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1177 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1236
 __dev_open+0x383/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8626
 dev_change_flags+0x9a/0x170 net/core/dev.c:8698
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6342
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888047d5af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888047d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x211/0x230 kernel/locking/spinlock_debug.c:140
Read of size 8 at addr ffff888047d5b0a8 by task kworker/u5:0/10553

CPU: 0 PID: 10553 Comm: kworker/u5:0 Tainted: G    B              6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
 do_raw_spin_unlock+0x211/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x1ac/0xb70 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x340 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 11594:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2090
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1720
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11594:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2218
 sk_destruct+0xc2/0xf0 net/core/sock.c:2233
 __sk_free+0xc4/0x3a0 net/core/sock.c:2244
 sk_free+0x7c/0xa0 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff888047d5b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 168 bytes inside of
 freed 2048-byte region [ffff888047d5b000, ffff888047d5b800)

The buggy address belongs to the physical page:
page:ffffea00011f5600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47d58
head:ffffea00011f5600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5066, tgid 5066 (syz-executor.4), ts 104812038932, free_ts 13078979756
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1033
 kmalloc_node include/linux/slab.h:619 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb3/0xa90 net/sched/sch_generic.c:938
 qdisc_create_dflt+0x73/0x3e0 net/sched/sch_generic.c:996
 attach_one_default_qdisc net/sched/sch_generic.c:1159 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2508 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1177 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1236
 __dev_open+0x383/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8626
 dev_change_flags+0x9a/0x170 net/core/dev.c:8698
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6342
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888047d5af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888047d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:102 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x1e0/0x230 kernel/locking/spinlock_debug.c:140
Read of size 4 at addr ffff888047d5b0a0 by task kworker/u5:0/10553

CPU: 0 PID: 10553 Comm: kworker/u5:0 Tainted: G    B              6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 debug_spin_unlock kernel/locking/spinlock_debug.c:102 [inline]
 do_raw_spin_unlock+0x1e0/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x1ac/0xb70 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x340 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 11594:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2090
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1720
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11594:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2218
 sk_destruct+0xc2/0xf0 net/core/sock.c:2233
 __sk_free+0xc4/0x3a0 net/core/sock.c:2244
 sk_free+0x7c/0xa0 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff888047d5b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 160 bytes inside of
 freed 2048-byte region [ffff888047d5b000, ffff888047d5b800)

The buggy address belongs to the physical page:
page:ffffea00011f5600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47d58
head:ffffea00011f5600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5066, tgid 5066 (syz-executor.4), ts 104812038932, free_ts 13078979756
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1033
 kmalloc_node include/linux/slab.h:619 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb3/0xa90 net/sched/sch_generic.c:938
 qdisc_create_dflt+0x73/0x3e0 net/sched/sch_generic.c:996
 attach_one_default_qdisc net/sched/sch_generic.c:1159 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2508 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1177 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1236
 __dev_open+0x383/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8626
 dev_change_flags+0x9a/0x170 net/core/dev.c:8698
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6342
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888047d5af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888047d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:104 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x204/0x230 kernel/locking/spinlock_debug.c:140
Write of size 8 at addr ffff888047d5b0a8 by task kworker/u5:0/10553

CPU: 0 PID: 10553 Comm: kworker/u5:0 Tainted: G    B              6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 debug_spin_unlock kernel/locking/spinlock_debug.c:104 [inline]
 do_raw_spin_unlock+0x204/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x1ac/0xb70 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x340 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x573/0xe10 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 11594:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2090
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1720
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11594:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2218
 sk_destruct+0xc2/0xf0 net/core/sock.c:2233
 __sk_free+0xc4/0x3a0 net/core/sock.c:2244
 sk_free+0x7c/0xa0 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff888047d5b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 168 bytes inside of
 freed 2048-byte region [ffff888047d5b000, ffff888047d5b800)

The buggy address belongs to the physical page:
page:ffffea00011f5600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47d58
head:ffffea00011f5600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5066, tgid 5066 (syz-executor.4), ts 104812038932, free_ts 13078979756
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1033
 kmalloc_node include/linux/slab.h:619 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb3/0xa90 net/sched/sch_generic.c:938
 qdisc_create_dflt+0x73/0x3e0 net/sched/sch_generic.c:996
 attach_one_default_qdisc net/sched/sch_generic.c:1159 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2508 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1177 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1236
 __dev_open+0x383/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8626
 dev_change_flags+0x9a/0x170 net/core/dev.c:8698
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6342
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888047d5af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888047d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888047d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047d5b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
