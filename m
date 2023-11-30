Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9AE7FF323
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjK3PCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346028AbjK3PCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:02:30 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7B5D50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:02:34 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2856433d5e6so1337905a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356554; x=1701961354;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJHMFIyYjAL7AEL+dr1tttga0DRsMqWEt4uvthy3kgc=;
        b=EDYBYfx3Pwrz37R9Ai1UwZUiijM/5gXH3m53fHx3dMwY8729d0hCWrZVNFNEi3m1tn
         /Rve9Ew4KHIttuve4DAWrjyIdO6+t4vd+YukcE7h0V9sD1TqJau3ppGuH7oi7/OiioK6
         z/XgfbYpuqA3prwuYAQLwyMckDY60GDMBmkY3sO/0hRfbdVNJO7PWVrEpE+ziIQAg+6r
         uVsb8Jwug9urTSPgfPNlGLK4RvXRtTw7CqB+Wrva2cDeiebzFU8WYwVdXBlIf7htJht7
         Y/343sb+UrWo/Wajfc13Fumaka3qFuBJKjeBSyEBryhCkFTpppwR/ra3wZZWsoOo47Go
         2Hww==
X-Gm-Message-State: AOJu0YyJH5tr8qaoM3Bq/KvjWhq6o4/PpKfuToHImiOWj1tQv4JUKb0g
        QiMZ46VQgWuvMtu8uunT1VpZfApXI/hzeE2uimOq6hgY88/M
X-Google-Smtp-Source: AGHT+IGvw7xZCq6NXj7DK4v8/J1xvB8xotxdNkMEnzouXzBGfsF6dRAHfnRP0foE7R3X+joDwGlTt1gf01QygVP5Agqxu93AVO3u
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d710:b0:285:db18:2400 with SMTP id
 y16-20020a17090ad71000b00285db182400mr2301448pju.2.1701356553994; Thu, 30 Nov
 2023 07:02:33 -0800 (PST)
Date:   Thu, 30 Nov 2023 07:02:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000098af2060b5ff161@google.com>
Subject: [syzbot] [block?] INFO: task hung in bdev_release
From:   syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14c8a334e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119809d0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13930542e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com

INFO: task syz-executor136:5067 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor136 state:D stack:26736 pid:5067  tgid:5066  ppid:5064   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 bdev_release+0xcd/0xa90 block/bdev.c:967
 blkdev_release+0x37/0x50 block/fops.c:616
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14c/0x240 kernel/task_work.c:180
 ptrace_notify+0x10a/0x130 kernel/signal.c:2390
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare+0x122/0x230 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xe/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f7015ea8479
RSP: 002b:00007f7015e66218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f7015f2f328 RCX: 00007f7015ea8479
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007f7015f2f320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7015f2f32c
R13: 00007f7015efc18c R14: 64626e2f7665642f R15: 00000000ffffff43
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by getty/4817:
 #0: ffff88802ae300a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5057:
 #0: ffff888143bbf4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open_by_dev+0x27c/0xed0 block/bdev.c:857
1 lock held by syz-executor136/5067:
 #0: ffff888143bbf4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0xcd/0xa90 block/bdev.c:967

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf86/0x1210 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 59 Comm: kworker/u4:4 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
RIP: 0010:static_key_false include/linux/jump_label.h:207 [inline]
RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:147 [inline]
RIP: 0010:wrmsrl arch/x86/include/asm/msr.h:262 [inline]
RIP: 0010:native_x2apic_icr_write arch/x86/include/asm/apic.h:216 [inline]
RIP: 0010:__x2apic_send_IPI_dest arch/x86/kernel/apic/x2apic_phys.c:113 [inline]
RIP: 0010:x2apic_send_IPI+0x96/0xe0 arch/x86/kernel/apic/x2apic_phys.c:50
Code: 8b 13 0f ae f0 0f ae e8 b9 00 04 00 00 41 83 fc 02 44 89 e0 48 0f 44 c1 48 c1 e2 20 b9 30 08 00 00 48 09 d0 48 c1 ea 20 0f 30 <66> 90 5b 5d 41 5c c3 5b 31 d2 48 89 c6 bf 30 08 00 00 5d 41 5c e9
RSP: 0018:ffffc900015a7900 EFLAGS: 00000202
RAX: 00000001000000fb RBX: ffff8880b9921a2c RCX: 0000000000000830
RDX: 0000000000000001 RSI: 00000000000000fb RDI: ffffffff8ca75a68
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: 00000000000000fb
R13: 000000000003bccc R14: 0000000000000001 R15: ffff8880b983d8c0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055750a5bb680 CR3: 000000000cd78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_send_call_function_single_ipi arch/x86/include/asm/smp.h:101 [inline]
 send_call_function_single_ipi kernel/smp.c:117 [inline]
 smp_call_function_many_cond+0x12ef/0x1570 kernel/smp.c:837
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2008 [inline]
 text_poke_bp_batch+0x655/0x750 arch/x86/kernel/alternative.c:2218
 text_poke_flush arch/x86/kernel/alternative.c:2409 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2406 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2416
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:830 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:822
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.905 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
