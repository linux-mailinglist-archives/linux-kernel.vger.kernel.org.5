Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5B7D36C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjJWMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjJWMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:34:58 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EFD68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:34:55 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b2ecaf68dbso5957841b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064494; x=1698669294;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaSzd+gkbrCM7vGgdBMSRARMqGm+PCQWkfvF4VBNU/A=;
        b=jQgKsZBuz36VwEoGKuvbKZrby9XVmmPsf1lH+TFuAETbSBROB5G6L+iK0MMy6I0UwL
         DdZe3U2VEjpgSVd8r6GikiBH0Hhtf1oTty48VZ/Cln9rmsduuiaJfcMY1C+ENXXf/9ag
         imx5GRZ2OCLnqpH6X9iavg5HkWQ0XZwoAPs+FPfG4qwmgL91yUWzXzq3wDKSlgTAh60C
         7n2sCPNVJdides48LMauCiUNf5ewNfXghMY9pVx6OGj+5WUUB1ROReD/BwBVZkT6AEIv
         PR1mmitUnL+kFi6sIwoqUUqbYWHQMg29MRDBZpI4ijCsBOc2TQOe/hV3zKet9BehxtG8
         nX/A==
X-Gm-Message-State: AOJu0YzmiajW5yrd66+jjRFwft7sK93orK9BSc5wKpFGo1dVSpJgLHge
        wmKIadEHRgVnIw1IU8rr2o4m1Tg3EuSgksM1xvgrbjgmcIjhGlExIw==
X-Google-Smtp-Source: AGHT+IFvppQwU00ucRjxbSJLrBNaCTrfp+Me/5264fl4UoBcdOHXKeYyeJjFogEE73vJ5c+BUPT8d+NQy/ZEJpZpl8n+0eMLPrpf
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198a:b0:3b2:ec65:399e with SMTP id
 bj10-20020a056808198a00b003b2ec65399emr3653503oib.3.1698064494477; Mon, 23
 Oct 2023 05:34:54 -0700 (PDT)
Date:   Mon, 23 Oct 2023 05:34:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffc87a06086172a0@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From:   syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10dd834d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/disk-2dac7569.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmlinux-2dac7569.xz
kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d/bzImage-2dac7569.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x41eb/0x5dc0 kernel/locking/lockdep.c:5004
Read of size 8 at addr ffff888058af5020 by task syz-executor.4/30114

CPU: 0 PID: 30114 Comm: syz-executor.4 Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 __lock_acquire+0x41eb/0x5dc0 kernel/locking/lockdep.c:5004
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b2/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 ptp_release+0xb2/0x2b0 drivers/ptp/ptp_chardev.c:146
 ptp_read+0xf6/0x830 drivers/ptp/ptp_chardev.c:589
 posix_clock_read+0x138/0x1b0 kernel/time/posix-clock.c:51
 vfs_read+0x1ce/0x8f0 fs/read_write.c:468
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5b40c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5b41a770c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f5b40d9c050 RCX: 00007f5b40c7cae9
RDX: 000000000000008a RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00007f5b40cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5b40d9c050 R15: 00007fffd3982cb8
 </TASK>

Allocated by task 30113:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 ptp_open+0xe3/0x4f0 drivers/ptp/ptp_chardev.c:112
 posix_clock_open+0x17e/0x240 kernel/time/posix-clock.c:134
 chrdev_open+0x26d/0x6e0 fs/char_dev.c:414
 do_dentry_open+0x8d4/0x18d0 fs/open.c:948
 do_open fs/namei.c:3621 [inline]
 path_openat+0x1d3b/0x2ce0 fs/namei.c:3778
 do_filp_open+0x1de/0x430 fs/namei.c:3808
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 30113:
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
 ptp_release+0x204/0x2b0 drivers/ptp/ptp_chardev.c:150
 ptp_read+0xf6/0x830 drivers/ptp/ptp_chardev.c:589
 posix_clock_read+0x138/0x1b0 kernel/time/posix-clock.c:51
 vfs_read+0x1ce/0x8f0 fs/read_write.c:468
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff888058af4000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4128 bytes inside of
 freed 8192-byte region [ffff888058af4000, ffff888058af6000)

The buggy address belongs to the physical page:
page:ffffea000162bc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58af0
head:ffffea000162bc00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42280 ffffea000066c400 dead000000000006
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5072, tgid 5072 (syz-executor.0), ts 99807679464, free_ts 30263208265
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xa16/0x3680 mm/page_alloc.c:3348
 __alloc_pages+0x1d0/0x4c0 mm/page_alloc.c:4604
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
 __kmalloc_node+0x56/0x130 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0x6f/0x1a0 mm/util.c:607
 kvmalloc include/linux/slab.h:738 [inline]
 kvmalloc_array include/linux/slab.h:756 [inline]
 __ptr_ring_init_queue_alloc include/linux/ptr_ring.h:471 [inline]
 ptr_ring_init include/linux/ptr_ring.h:489 [inline]
 skb_array_init include/linux/skb_array.h:182 [inline]
 pfifo_fast_init+0x125/0x3a0 net/sched/sch_generic.c:858
 qdisc_create_dflt+0x101/0x3f0 net/sched/sch_generic.c:1004
 attach_one_default_qdisc net/sched/sch_generic.c:1160 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2511 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1178 [inline]
 dev_activate+0x66c/0x1310 net/sched/sch_generic.c:1237
 __dev_open+0x383/0x4d0 net/core/dev.c:1459
 __dev_change_flags+0x56a/0x730 net/core/dev.c:8608
 dev_change_flags+0x9a/0x170 net/core/dev.c:8680
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2523
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6569
 destroy_args+0x7c9/0xa10 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d50/0x40e0 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x128/0x670 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888058af4f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888058af4f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888058af5000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888058af5080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888058af5100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
