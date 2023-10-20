Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC8B7D08DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376356AbjJTGx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376298AbjJTGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:53:58 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E466A98
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:53:55 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b2e7b41beaso1821415b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784835; x=1698389635;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhkbCqryU0gDuaG9uVdFvq1DwO8fV1D2bEgdX/nCrWI=;
        b=bnHkgucyNz4OF+TFuh22S6Jsmpp1fAsSyqrbZDYwBwDyVJYnouII+kBNf5HgSc/5CH
         8b5Sh6Bl5V4RVTxL4Ax01Fcpup2wDQkL1hPmuRp64d5QVuJF4mrA/I2cVkHoJemDOrW5
         iHsBc26THEdRBqXdxsmA2AeduIgL/guID5uY1d8PLOf9QGy+K/+ZKLrmvbbBn1+HyMlQ
         bwdyoYHTYwRyNqEfCWLkCyudsxdPm2p1Eh5FNgy52b8OdJAk2WLBMJilKdyrGqGQKiuo
         yFgXVg8tCZBJBdk02HFLHj2a6fn6PB6ufAsip2cuztjbrrC6zatPZ7Fqvmoq+caMzYLq
         XjuQ==
X-Gm-Message-State: AOJu0YzfXqSp0UpapOBOfWXG+ykP0KZFYWoWOh/2wY9j26yHe/FkZ59N
        OhmDHGKONA7lRsR/OI32DLd73CFw2bAvEMbuKU7CCWRrY84Q
X-Google-Smtp-Source: AGHT+IE8tAy5Ct01pTHWjwcUtiKoW5XIDqOZ45C5bRejZC/fb/MGkEhcW3eQ7f6LqHdCx4jCA5h+UUAwWVpopy7kZHZTpCAH4XTC
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1801:b0:3b2:e7b3:5fc5 with SMTP id
 bh1-20020a056808180100b003b2e7b35fc5mr254312oib.3.1697784834919; Thu, 19 Oct
 2023 23:53:54 -0700 (PDT)
Date:   Thu, 19 Oct 2023 23:53:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd9639060820551b@google.com>
Subject: [syzbot] [kernel?] upstream test error: KASAN: slab-use-after-free
 Read in reweight_entity
From:   syzbot <syzbot+7147c5c87b744de4654c@syzkaller.appspotmail.com>
To:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7cf4bea77ab6 Merge tag 'for-6.6-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1550f7bd680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d236817624b4822c
dashboard link: https://syzkaller.appspot.com/bug?extid=7147c5c87b744de4654c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-7cf4bea7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60c2785d5bbf/vmlinux-7cf4bea7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0283814b9e4/zImage-7cf4bea7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7147c5c87b744de4654c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __update_min_deadline kernel/sched/fair.c:805 [inline]
BUG: KASAN: slab-use-after-free in min_deadline_update kernel/sched/fair.c:819 [inline]
BUG: KASAN: slab-use-after-free in min_deadline_cb_propagate kernel/sched/fair.c:825 [inline]
BUG: KASAN: slab-use-after-free in reweight_entity+0x720/0x888 kernel/sched/fair.c:3660
Read of size 8 at addr ffff00000acc3830 by task syz-fuzzer/3099

CPU: 1 PID: 3099 Comm: syz-fuzzer Not tainted 6.6.0-rc6-syzkaller-00045-g7cf4bea77ab6 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x9c/0x11c arch/arm64/kernel/stacktrace.c:233
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x74/0xd4 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xd8/0x598 mm/kasan/report.c:475
 kasan_report+0xc8/0x108 mm/kasan/report.c:588
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 __update_min_deadline kernel/sched/fair.c:805 [inline]
 min_deadline_update kernel/sched/fair.c:819 [inline]
 min_deadline_cb_propagate kernel/sched/fair.c:825 [inline]
 reweight_entity+0x720/0x888 kernel/sched/fair.c:3660
 update_cfs_group+0x144/0x214 kernel/sched/fair.c:3826
 entity_tick kernel/sched/fair.c:5317 [inline]
 task_tick_fair+0xd8/0x8e0 kernel/sched/fair.c:12392
 scheduler_tick+0x218/0x4f8 kernel/sched/core.c:5657
 update_process_times+0x180/0x1f8 kernel/time/timer.c:2076
 tick_sched_handle+0x68/0x12c kernel/time/tick-sched.c:254
 tick_sched_timer+0x74/0x120 kernel/time/tick-sched.c:1492
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x580/0xb14 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x2a4/0x768 kernel/time/hrtimer.c:1814
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_phys+0x40/0x6c drivers/clocksource/arm_arch_timer.c:692
 handle_percpu_devid_irq+0x19c/0x30c kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:672 [inline]
 generic_handle_domain_irq+0x78/0xa4 kernel/irq/irqdesc.c:728
 gic_handle_irq+0x54/0x188 drivers/irqchip/irq-gic.c:373
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:886
 do_interrupt_handler+0x12c/0x150 arch/arm64/kernel/entry-common.c:276
 el0_interrupt+0x68/0x1cc arch/arm64/kernel/entry-common.c:760
 __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:768
 el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:773
 el0t_64_irq+0x190/0x194 arch/arm64/kernel/entry.S:596

Allocated by task 3099:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:45
 kasan_set_track+0x2c/0x40 mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x34 mm/kasan/generic.c:511
 __kasan_slab_alloc+0x8c/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x168/0x2d4 mm/slub.c:3523
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x360/0x5520 kernel/fork.c:2327
 kernel_clone+0x140/0x7e8 kernel/fork.c:2909
 __do_sys_clone+0xb8/0xfc kernel/fork.c:3052
 __se_sys_clone kernel/fork.c:3020 [inline]
 __arm64_sys_clone+0xa4/0xfc kernel/fork.c:3020
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Freed by task 3099:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:45
 kasan_set_track+0x2c/0x40 mm/kasan/common.c:52
 kasan_save_free_info+0x38/0x5c mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x120/0x1b8 mm/kasan/common.c:200
 __kasan_slab_free+0x18/0x24 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0x14c/0x4e8 mm/slub.c:3831
 free_task_struct kernel/fork.c:178 [inline]
 free_task+0xd4/0x11c kernel/fork.c:627
 __put_task_struct+0x1e4/0x27c kernel/fork.c:981
 put_task_struct include/linux/sched/task.h:136 [inline]
 put_task_struct include/linux/sched/task.h:123 [inline]
 delayed_put_task_struct+0x138/0x314 kernel/exit.c:226
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x950/0x1c3c kernel/rcu/tree.c:2403
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2420
 __do_softirq+0x2e4/0xe1c kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb4/0xe4 mm/kasan/generic.c:492
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:502
 __call_rcu_common.constprop.0+0x9c/0x8c0 kernel/rcu/tree.c:2653
 call_rcu+0x10/0x1c kernel/rcu/tree.c:2767
 put_task_struct_rcu_user kernel/exit.c:232 [inline]
 put_task_struct_rcu_user kernel/exit.c:229 [inline]
 release_task+0xbc8/0x1520 kernel/exit.c:282
 wait_task_zombie kernel/exit.c:1210 [inline]
 wait_consider_task+0xf14/0x2a5c kernel/exit.c:1437
 do_wait_pid kernel/exit.c:1568 [inline]
 do_wait+0x490/0x994 kernel/exit.c:1610
 kernel_wait4+0xec/0x258 kernel/exit.c:1780
 __do_sys_wait4+0xac/0x1e8 kernel/exit.c:1808
 __se_sys_wait4 kernel/exit.c:1804 [inline]
 __arm64_sys_wait4+0x88/0xc8 kernel/exit.c:1804
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Second to last potentially related work creation:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb4/0xe4 mm/kasan/generic.c:492
 kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:497
 task_work_add+0x94/0x298 kernel/task_work.c:48
 task_tick_mm_cid+0xfc/0x14c kernel/sched/core.c:12023
 scheduler_tick+0x22c/0x4f8 kernel/sched/core.c:5662
 update_process_times+0x180/0x1f8 kernel/time/timer.c:2076
 tick_sched_handle+0x68/0x12c kernel/time/tick-sched.c:254
 tick_sched_timer+0x74/0x120 kernel/time/tick-sched.c:1492
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x580/0xb14 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x2a4/0x768 kernel/time/hrtimer.c:1814
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_phys+0x40/0x6c drivers/clocksource/arm_arch_timer.c:692
 handle_percpu_devid_irq+0x19c/0x30c kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:672 [inline]
 generic_handle_domain_irq+0x78/0xa4 kernel/irq/irqdesc.c:728
 gic_handle_irq+0x54/0x188 drivers/irqchip/irq-gic.c:373

The buggy address belongs to the object at ffff00000acc3780
 which belongs to the cache task_struct of size 6848
The buggy address is located 176 bytes inside of
 freed 6848-byte region [ffff00000acc3780, ffff00000acc5240)

The buggy address belongs to the physical page:
page:000000007280b60d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4acc0
head:000000007280b60d order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x1ffc00000000840(slab|head|node=0|zone=0|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 01ffc00000000840 ffff000009c80dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00000acc3700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff00000acc3780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff00000acc3800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff00000acc3880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff00000acc3900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
