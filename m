Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68631792A02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355146AbjIEQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354569AbjIEMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:42:56 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B561A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:42:53 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1b88decb2a9so34978805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 05:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693917771; x=1694522571;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+A22TUng3ehfxKNM9eOPCzIy7tpRELO/RihFdMxcoOw=;
        b=CpoMcORfPrND60Sr+4+IsKJgfm+qhCnYoqdSbn7tdDN0hDlfAt4ejvWT+eNBuCCXFh
         r6XHf1gGQ9syScNQtYsxOjQzpH3gZlLqU9aeMl9OLeoRsdPMfXqJfJtJlFkVSnTWtUwx
         FJRKdJpeTaq4S0mNyFe8CImnuXqy7syqLRbM2uNLeMtDewyNC6Q+xUHPHR4gwIFZ1NLC
         Y15TEEEq0mEfm6hD+QANuzjdyP8ZFRPaIITCfvT0Vflh9e5KfWf9nYbm0FZgmmZIbD+q
         IBamuVpYwX3tmgLENdgtfXrh3OGs33o/7mkSLIyaPh0CKKz0YwJCPFJd6t2/sBoyrHj8
         9AMg==
X-Gm-Message-State: AOJu0YwlbtpHCEsYCeda7pRQmk0js6kL60D2zGz/1evppyDBKXueuRPe
        2zoeSHQs2V+cy3O41HvZqf5Zy2nu21ErT1KuK2msyNbXYYFH
X-Google-Smtp-Source: AGHT+IHekrccDvZh3yL6oOrsD0OJeiraoLHOiYi6pobMI/N+w1SGXocvD4awgQmGYdOUDTsREl1+E1Ma+dIIH8wj4aUyPFgsN0iK
MIME-Version: 1.0
X-Received: by 2002:a17:902:fb06:b0:1bb:cdea:d959 with SMTP id
 le6-20020a170902fb0600b001bbcdead959mr2555938plb.0.1693917771735; Tue, 05 Sep
 2023 05:42:51 -0700 (PDT)
Date:   Tue, 05 Sep 2023 05:42:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001027a206049bf7da@google.com>
Subject: [syzbot] [bluetooth?] KASAN: use-after-free Read in hci_conn_security
From:   syzbot <syzbot+b1b9423479233352b99e@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ea35288c83b skbuff: skb_segment, Call zero copy functions..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17f46d87a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=b1b9423479233352b99e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d8d28ba7b968/disk-2ea35288.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12a9f785a85b/vmlinux-2ea35288.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d71c4427c061/bzImage-2ea35288.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1b9423479233352b99e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: use-after-free in hci_conn_ssp_enabled include/net/bluetooth/hci_core.h:988 [inline]
BUG: KASAN: use-after-free in hci_conn_security+0x324/0x990 net/bluetooth/hci_conn.c:2409
Read of size 8 at addr ffff8880784dda70 by task kworker/1:11/12886

CPU: 1 PID: 12886 Comm: kworker/1:11 Not tainted 6.5.0-syzkaller-04006-g2ea35288c83b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events l2cap_info_timeout
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
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hci_conn_ssp_enabled include/net/bluetooth/hci_core.h:988 [inline]
 hci_conn_security+0x324/0x990 net/bluetooth/hci_conn.c:2409
 l2cap_chan_check_security+0x16f/0x320 net/bluetooth/l2cap_core.c:929
 l2cap_conn_start+0x59b/0xa40 net/bluetooth/l2cap_core.c:1646
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001e13740 refcount:0 mapcount:0 mapping:0000000000000000 index:0x4 pfn:0x784dd
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 ffffffff00000201 0000000000000000
raw: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140dc0(GFP_USER|__GFP_COMP|__GFP_ZERO), pid 9825, tgid 9825 (syz-executor.2), ts 251793148654, free_ts 864555377636
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x87/0x1c0 mm/slab_common.c:1126
 __do_kmalloc_node mm/slab_common.c:973 [inline]
 __kmalloc.cold+0xb/0xe0 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 hci_alloc_dev_priv+0x1d/0x2780 net/bluetooth/hci_core.c:2467
 hci_alloc_dev include/net/bluetooth/hci_core.h:1600 [inline]
 __vhci_create_device+0xf7/0x800 drivers/bluetooth/hci_vhci.c:402
 vhci_create_device drivers/bluetooth/hci_vhci.c:475 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:532 [inline]
 vhci_write+0x2c7/0x470 drivers/bluetooth/hci_vhci.c:612
 call_write_iter include/linux/fs.h:1985 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2443
 hci_release_dev+0x4da/0x600 net/bluetooth/hci_core.c:2792
 bt_host_release+0x6a/0xb0 net/bluetooth/hci_sysfs.c:93
 device_release+0xa1/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:713 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x5b0 lib/kobject.c:730
 put_device+0x1f/0x30 drivers/base/core.c:3733
 vhci_release+0x87/0x100 drivers/bluetooth/hci_vhci.c:670
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa99/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880784dd900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880784dd980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880784dda00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                             ^
 ffff8880784dda80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880784ddb00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
