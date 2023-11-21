Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062EE7F30FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjKUOdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjKUOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:33:30 -0500
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021EFBA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:33:26 -0800 (PST)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-28004d4462dso8171906a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577205; x=1701182005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmmIgk78Idq0/HaK8KHLZ4DcWU3pGworgnkoBkXYWOc=;
        b=e/EnBDaVu7cceSu+orJRGUm/0tqupI34DwKvto6xx5I1ID5xBcKRyKHoRNA7SAAr3l
         dYEiosnxY7FAVrxnaURoJj3Ua4jN0MuvBI6VNXCOvrScNsqyyaKAlqcAze5dRaETf4Dh
         Y6tURZi20/er1cobep7TqUIsPa7jBypRKDkQJgjLbiYY/RVrNRcqbXjXapRVl1EhSeHG
         aBlEqQIhavDnCexeclxJLshEizzChcpEB2KDMa5JCSafOYmIBBOAoF/tbkXL9y18SCAw
         wKXbS58ioBE+ay6K8/mGhZjrGZ85p5FNYX185KeVi6jz2YspHJVhewtj6LmGTWqzu9z7
         5h3A==
X-Gm-Message-State: AOJu0Yw0zPQ71eDKY+beAXBJwH22B9+Esk1aFSn09UH7794TTpqOjMOW
        2O/uHzT6yI8IVYRIyB2A6ExlO34R0BoPW9X+/UrmEsVsqK+kMU818w==
X-Google-Smtp-Source: AGHT+IGy2icGl0xQ+/zvsYf3H6CsXbTIMhmOqxTO9UscU0h9MSBsXk4rT/7jynJ2/Ocy/WVxK+030L4sUHtb67sFTXStfgHs58RQ
MIME-Version: 1.0
X-Received: by 2002:a17:90a:6346:b0:283:9a52:1e73 with SMTP id
 v6-20020a17090a634600b002839a521e73mr2586730pjs.6.1700577205482; Tue, 21 Nov
 2023 06:33:25 -0800 (PST)
Date:   Tue, 21 Nov 2023 06:33:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003efb26060aaa7c63@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in kill_orphaned_pgrp
From:   syzbot <syzbot+50ef815ba3bcce06d409@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139b08d8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=50ef815ba3bcce06d409
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eeb0cac260c7/disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3c360110254/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/22b81065ba5f/bzImage-0bb80ecc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50ef815ba3bcce06d409@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in task_pgrp include/linux/sched/signal.h:694 [inline]
BUG: KASAN: slab-use-after-free in kill_orphaned_pgrp+0x2e1/0x340 kernel/exit.c:376
Read of size 8 at addr ffff88802d78a6b8 by task vhost-16506/16518

CPU: 0 PID: 16518 Comm: vhost-16506 Not tainted 6.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 task_pgrp include/linux/sched/signal.h:694 [inline]
 kill_orphaned_pgrp+0x2e1/0x340 kernel/exit.c:376
 exit_notify kernel/exit.c:737 [inline]
 do_exit+0x1cb5/0x2a20 kernel/exit.c:894
 vhost_task_fn+0x2e6/0x370 kernel/vhost_task.c:61
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5090:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x185/0x3f0 mm/slub.c:3523
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x41c/0x7400 kernel/fork.c:2327
 kernel_clone+0xfd/0x930 kernel/fork.c:2909
 __do_sys_clone+0xba/0x100 kernel/fork.c:3052
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 42:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0xf0/0x480 mm/slub.c:3831
 put_task_struct include/linux/sched/task.h:136 [inline]
 put_task_struct include/linux/sched/task.h:123 [inline]
 delayed_put_task_struct+0x246/0x2c0 kernel/exit.c:226
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x7fb/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user kernel/exit.c:232 [inline]
 put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:229
 release_task+0xf0a/0x1b90 kernel/exit.c:282
 de_thread fs/exec.c:1158 [inline]
 begin_new_exec+0x226c/0x3110 fs/exec.c:1264
 load_elf_binary+0x8ec/0x5c40 fs/binfmt_elf.c:1001
 search_binary_handler fs/exec.c:1739 [inline]
 exec_binprm fs/exec.c:1781 [inline]
 bprm_execve fs/exec.c:1856 [inline]
 bprm_execve+0x80a/0x1a50 fs/exec.c:1812
 do_execveat_common.isra.0+0x5d3/0x740 fs/exec.c:1964
 do_execve fs/exec.c:2038 [inline]
 __do_sys_execve fs/exec.c:2114 [inline]
 __se_sys_execve fs/exec.c:2109 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2109
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user kernel/exit.c:232 [inline]
 put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:229
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0xee9/0x59f0 kernel/sched/core.c:6695
 preempt_schedule_irq+0x52/0x90 kernel/sched/core.c:7007
 irqentry_exit+0x35/0x80 kernel/entry/common.c:432
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645

The buggy address belongs to the object at ffff88802d789dc0
 which belongs to the cache task_struct of size 7360
The buggy address is located 2296 bytes inside of
 freed 7360-byte region [ffff88802d789dc0, ffff88802d78ba80)

The buggy address belongs to the physical page:
page:ffffea0000b5e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d788
head:ffffea0000b5e200 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888075f26101
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014e49500 ffffea0001e00e00 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff888075f26101
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5278, tgid 5278 (syz-executor.3), ts 190312746205, free_ts 190291479937
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 kmem_cache_alloc_node+0x137/0x3f0 mm/slub.c:3523
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x41c/0x7400 kernel/fork.c:2327
 kernel_clone+0xfd/0x930 kernel/fork.c:2909
 __do_sys_clone3+0x1f1/0x260 kernel/fork.c:3210
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 __folio_put+0xeb/0x110 mm/swap.c:127
 folio_put include/linux/mm.h:1475 [inline]
 put_page include/linux/mm.h:1544 [inline]
 do_exit+0x2332/0x2a20 kernel/exit.c:913
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23d1/0x27b0 kernel/signal.c:2892
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802d78a580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802d78a600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802d78a680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88802d78a700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802d78a780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
