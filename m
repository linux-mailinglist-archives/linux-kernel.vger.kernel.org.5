Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2FA7C0399
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjJJSlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjJJSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:40:58 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8764EB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:40:48 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3ae65ecb25aso10320538b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963248; x=1697568048;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+Rb3NAOf8xtp8boNvz8NHWfpy3af/HUb99cLz0/CDI=;
        b=sGsHVa03skJnJ7VPo5m3okhQWgqnunJJYb5bh26dnPhTSaWdUG2t+0LwsfEo/j8KP/
         nRbLaUq3RYJQgRyAJflF20FufC2Tf/EYmj+v5e83Y2Gf6tutYqgwAUMXq8MMpdorWr7A
         xiGzPY92Wi5ZBaOvTpAms48roJgjpJ7uC0yMnM4CfzgVIGqCKCnYXg3q06BOLOz6J6h4
         yEDgfsv6W/co/xoYkWRX7bUWZ1q2m/kZVElo6GWgfBvMuJ8REEOswpWnB2suhXCX6RzI
         s7AkPsJOS6i+l67lqs+VYtk8SULHHLsYCQoiYz1P42fruvbHmPxoR/qCj72AHavNDyqP
         lF7A==
X-Gm-Message-State: AOJu0YyjSX1hGynz6iDej8ehJ9N8OwE2/huJIgREUhdXhd1F7j88dqSM
        YArl56G88tVSlfD8gXffcPxH0irMarA6sCvYALDdUKnvWC/U
X-Google-Smtp-Source: AGHT+IGAKxYPb6cEKFfSgrES/YmYeeZ01iAyqh4qa1ts92SQeW76f3BDmKlbAcfkgtddoaFr5b+8HfeglZ814Ryo5fZt7ZQ765Hi
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0a:b0:3ae:24b3:8f7d with SMTP id
 m10-20020a0568080f0a00b003ae24b38f7dmr9894181oiw.11.1696963248019; Tue, 10
 Oct 2023 11:40:48 -0700 (PDT)
Date:   Tue, 10 Oct 2023 11:40:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000985ef90607610b0a@google.com>
Subject: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (3)
From:   syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12454061680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
dashboard link: https://syzkaller.appspot.com/bug?extid=79fcba037b6df73756d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.6.0-rc4-next-20231005-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor.0/5183.

stack backtrace:
CPU: 0 PID: 5183 Comm: syz-executor.0 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6711
 mas_root lib/maple_tree.c:856 [inline]
 mas_root lib/maple_tree.c:854 [inline]
 mas_start lib/maple_tree.c:1385 [inline]
 mas_state_walk lib/maple_tree.c:3705 [inline]
 mas_walk+0x4d1/0x7d0 lib/maple_tree.c:4888
 mas_find_setup lib/maple_tree.c:5948 [inline]
 mas_find+0x1e6/0x400 lib/maple_tree.c:5989
 vma_find include/linux/mm.h:941 [inline]
 do_mbind+0xc91/0x1010 mm/mempolicy.c:1348
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1506
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdde627cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdde6f050c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fdde639bf80 RCX: 00007fdde627cae9
RDX: 0000000000008000 RSI: 0000000000003000 RDI: 0000000020004000
RBP: 00007fdde62c847a R08: 0000000000000008 R09: 0000000000000003
R10: 0000000020000840 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdde639bf80 R15: 00007fff0c0d4408
 </TASK>

=============================
WARNING: suspicious RCU usage
6.6.0-rc4-next-20231005-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:812 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by syz-executor.0/5183:
 #0: ffffffff8cb989a0 (
console_lock){+.+.}-{0:0}
, at: console_trylock_spinning kernel/printk/printk.c:1924 [inline]
, at: vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2303
 #1: ffffffff8cb98a10 (console_srcu
){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
){....}-{0:0}, at: console_flush_all+0x12a/0xd50 kernel/printk/printk.c:2952
 #2: ffffffff8cab8560
 (console_owner){....}-{0:0}
, at: console_lock_spinning_enable kernel/printk/printk.c:1855 [inline]
, at: console_emit_next_record kernel/printk/printk.c:2888 [inline]
, at: console_flush_all+0x49a/0xd50 kernel/printk/printk.c:2960
 #3: ffffffff9257d418 (&port_lock_key
){-.-.}-{2:2}
, at: uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
, at: serial8250_console_write+0xa7c/0x1060 drivers/tty/serial/8250/8250_port.c:3410

stack backtrace:
CPU: 0 PID: 5183 Comm: syz-executor.0 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6711
 mt_slot lib/maple_tree.c:812 [inline]
 mt_slot lib/maple_tree.c:809 [inline]
 mtree_range_walk+0x6c5/0x9b0 lib/maple_tree.c:2827
 mas_state_walk lib/maple_tree.c:3712 [inline]
 mas_walk+0x374/0x7d0 lib/maple_tree.c:4888
 mas_find_setup lib/maple_tree.c:5948 [inline]
 mas_find+0x1e6/0x400 lib/maple_tree.c:5989
 vma_find include/linux/mm.h:941 [inline]
 do_mbind+0xc91/0x1010 mm/mempolicy.c:1348
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1506
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdde627cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdde6f050c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fdde639bf80 RCX: 00007fdde627cae9
RDX: 0000000000008000 RSI: 0000000000003000 RDI: 0000000020004000
RBP: 00007fdde62c847a R08: 0000000000000008 R09: 0000000000000003
R10: 0000000020000840 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdde639bf80 R15: 00007fff0c0d4408
 </TASK>
page:ffffea0001f50000 refcount:1 mapcount:0 mapping:ffff88814b444228 index:0x0 pfn:0x7d400
head:ffffea0001f50000 order:9 entire_mapcount:0 nr_pages_mapped:0 pincount:0
aops:hugetlbfs_aops ino:1 dentry name:"SYSV00000000"
flags: 0xfff00000000059(locked|uptodate|dirty|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000059 ffffc900048b7d90 ffffc900048b7d90 ffff88814b444228
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg)
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x346cca(GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_THISNODE), pid 1, tgid 1 (swapper/0), ts 37433162446, free_ts 36245715520
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x98f/0x32a0 mm/page_alloc.c:3333
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4589
 alloc_buddy_hugetlb_folio.isra.0+0xbd/0x380 mm/hugetlb.c:1984
 alloc_fresh_hugetlb_folio+0x3a1/0x7d0 mm/hugetlb.c:2041
 alloc_pool_huge_page+0x1bc/0x2d0 mm/hugetlb.c:2076
 set_max_huge_pages+0x56c/0x11c0 mm/hugetlb.c:3433
 __nr_hugepages_store_common mm/hugetlb.c:3669 [inline]
 hugetlb_sysctl_handler_common+0x279/0x320 mm/hugetlb.c:4511
 proc_sys_call_handler+0x4c6/0x6e0 fs/proc/proc_sysctl.c:600
 __kernel_write_iter+0x261/0x7e0 fs/read_write.c:517
 __kernel_write fs/read_write.c:537 [inline]
 kernel_write fs/read_write.c:558 [inline]
 kernel_write+0x1f8/0x6c0 fs/read_write.c:548
 process_sysctl_arg+0x22c/0x5f0 fs/proc/proc_sysctl.c:1668
 parse_one kernel/params.c:154 [inline]
 parse_args+0x587/0x8b0 kernel/params.c:189
 do_sysctl_args+0xc8/0x150 fs/proc/proc_sysctl.c:1700
 kernel_init+0x75/0x2a0 init/main.c:1460
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1134 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2518
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6553
 destroy_args+0x7c9/0xa10 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d79/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x11c/0x640 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5183 at mm/memcontrol.c:7552 mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
Modules linked in:
CPU: 0 PID: 5183 Comm: syz-executor.0 Not tainted 6.6.0-rc4-next-20231005-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
Code: f7 ff e9 36 ff ff ff 80 3d 84 b2 d1 0c 00 0f 85 54 ff ff ff 48 c7 c6 a0 9e 9b 8a 48 89 ef e8 0d 5c df ff c6 05 68 b2 d1 0c 01 <0f> 0b e9 37 ff ff ff 48 c7 c6 e0 9a 9b 8a 48 89 df e8 f0 5b df ff
RSP: 0018:ffffc900048b79d8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffea00012d0000 RCX: ffffc900054d9000
RDX: 0000000000040000 RSI: ffffffff81e76463 RDI: 0000000000000000
RBP: ffffea0001f50000 R08: 0000000000000000 R09: fffffbfff1d9db9a
R10: ffffffff8ecedcd7 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000200 R14: 0000000000000000 R15: ffffea0001f50018
FS:  00007fdde6f056c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a28000 CR3: 000000007c8ad000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hugetlbfs_migrate_folio fs/hugetlbfs/inode.c:1066 [inline]
 hugetlbfs_migrate_folio+0xd0/0x120 fs/hugetlbfs/inode.c:1049
 move_to_new_folio+0x183/0x690 mm/migrate.c:966
 unmap_and_move_huge_page mm/migrate.c:1428 [inline]
 migrate_hugetlbs mm/migrate.c:1546 [inline]
 migrate_pages+0x16ac/0x27c0 mm/migrate.c:1900
 do_mbind+0x685/0x1010 mm/mempolicy.c:1364
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1506
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdde627cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdde6f050c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fdde639bf80 RCX: 00007fdde627cae9
RDX: 0000000000008000 RSI: 0000000000003000 RDI: 0000000020004000
RBP: 00007fdde62c847a R08: 0000000000000008 R09: 0000000000000003
R10: 0000000020000840 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdde639bf80 R15: 00007fff0c0d4408
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
