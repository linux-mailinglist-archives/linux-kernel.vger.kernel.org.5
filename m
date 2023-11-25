Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01367F8B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjKYNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjKYNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:21:22 -0500
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:21:28 -0800 (PST)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1cf8c1aaafcso22335605ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700918487; x=1701523287;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSYiGfAAMAcRis1TVQ3Zrz9Kz4BF0k5UJY3eSxQoyKI=;
        b=Fmqx3M5UMjkoGNMIqO2dsl7WwTdO2krukK0EVEMLYD/+qcMqJJQ9QDtAQRhSiHYbnU
         Rmt2VLcIBwYo98XuwiCHFoDes5G79s4DYc+iYGaDdKp7LF6vhFcKwyOivkkf4Zva7Hnq
         uyI3yrs0MzAzPEpxyIeVxPM6SE2Ys2r40Rdlddqnbv0G79akTitsVZzzr2PLfiEv1m9e
         BKXuQI5xP19X3kKdO6Nxb1aEAHICFndN2+otwkse6BbugQdYa2C/wlRhregCkoFG11h1
         UNqLaojVNwVvjZz4mhtKUTLtqMtUyybLz/1u7iFGPIre4/ERV79w/YbVcErfJ8wG9Nco
         8fLw==
X-Gm-Message-State: AOJu0Yy+NhC5He5PnEhilS/U9bf1wIwnXKP4Q/BTg9amPiNyk76s2ge2
        FFDwqpT70UnhnBAzdo2BVm0R+JdXzMjBAgcq8tLiNGEnnogT
X-Google-Smtp-Source: AGHT+IGqp3Y75FgghXsxU/FPfMOoM9MT5kJ+jGpKKk2gh5/Lj1pIzRkeGSpeyOWlDoVcqt5pX1Vju38kom1BdTJz8ul2rZi9aKkP
MIME-Version: 1.0
X-Received: by 2002:a17:902:e0ca:b0:1cc:2c44:58f4 with SMTP id
 e10-20020a170902e0ca00b001cc2c4458f4mr1575340pla.1.1700918487510; Sat, 25 Nov
 2023 05:21:27 -0800 (PST)
Date:   Sat, 25 Nov 2023 05:21:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d77e6060af9f233@google.com>
Subject: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        olivia@selenic.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e89e10e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=c52ab18308964d248092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174f0bd4e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b83b84e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/39c6cdad13fc/disk-98b1cc82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a77b5daef9b/vmlinux-98b1cc82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e09ae712e0d/bzImage-98b1cc82.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com

INFO: task hwrng:749 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:hwrng           state:D stack:29040 pid:749   tgid:749   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:747
 hwrng_fillfn+0x145/0x430 drivers/char/hw_random/core.c:504
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by kswapd0/86:
1 lock held by hwrng/749:
 #0: ffffffff8dbafee8 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x145/0x430 drivers/char/hw_random/core.c:504
2 locks held by getty/4824:
 #0: ffff888025fa10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
2 locks held by syz-executor391/5105:
2 locks held by syz-executor391/5106:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5105 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__lock_acquire+0x30/0x3b10 kernel/locking/lockdep.c:4992
Code: f6 41 55 41 54 49 89 fc 55 89 d5 53 44 89 cb 48 81 ec f0 00 00 00 48 8b 84 24 28 01 00 00 48 c7 84 24 90 00 00 00 b3 8a b5 41 <44> 89 44 24 08 44 8b ac 24 48 01 00 00 48 c7 84 24 98 00 00 00 1b
RSP: 0018:ffffc900044271d8 EFLAGS: 00000086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8cfabce0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8f1934d7 R11: 0000000000000002 R12: ffffffff8cfabce0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f3c785f96c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005565d7bb9be7 CR3: 000000001af30000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5718
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 get_mem_cgroup_from_mm+0x4b/0x4c0 mm/memcontrol.c:1081
 __mem_cgroup_charge+0x1c/0x140 mm/memcontrol.c:7224
 mem_cgroup_charge include/linux/memcontrol.h:684 [inline]
 __filemap_add_folio+0x88c/0xed0 mm/filemap.c:854
 filemap_add_folio+0xb1/0x1e0 mm/filemap.c:937
 page_cache_ra_unbounded+0x1d0/0x5f0 mm/readahead.c:250
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0x72b/0xa80 mm/readahead.c:546
 do_sync_mmap_readahead mm/filemap.c:3141 [inline]
 filemap_fault+0x16a8/0x3570 mm/filemap.c:3233
 __do_fault+0x107/0x600 mm/memory.c:4265
 do_cow_fault mm/memory.c:4662 [inline]
 do_fault mm/memory.c:4764 [inline]
 do_pte_missing mm/memory.c:3730 [inline]
 handle_pte_fault mm/memory.c:5038 [inline]
 __handle_mm_fault+0x3a8d/0x3d70 mm/memory.c:5179
 handle_mm_fault+0x47a/0xa10 mm/memory.c:5344
 do_user_addr_fault+0x3d1/0x1000 arch/x86/mm/fault.c:1413
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x5d/0xc0 arch/x86/mm/fault.c:1561
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_movs_alternative+0x57/0x70 arch/x86/lib/copy_user_64.S:80
Code: 00 66 90 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb c9 eb 01 c3 48 89 c8 48 c1 e9 03 83 e0 07 <f3> 48 a5 89 c1 85 c9 75 b3 c3 48 8d 0c c8 eb ac 66 0f 1f 84 00 00
RSP: 0018:ffffc90004427bb0 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000008
RDX: ffffed1028a4ab48 RSI: ffff888145255a00 RDI: 0000000020019980
RBP: 0000000020019980 R08: 0000000000000000 R09: ffffed1028a4ab47
R10: ffff888145255a3f R11: 0000000000000001 R12: ffff888145255a00
R13: 00000000200199c0 R14: 0000000000000000 R15: dffffc0000000000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
 _copy_to_user lib/usercopy.c:41 [inline]
 _copy_to_user+0xa8/0xb0 lib/usercopy.c:34
 copy_to_user include/linux/uaccess.h:191 [inline]
 rng_dev_read+0x184/0x580 drivers/char/hw_random/core.c:255
 do_loop_readv_writev fs/read_write.c:755 [inline]
 do_loop_readv_writev fs/read_write.c:743 [inline]
 do_iter_read+0x567/0x830 fs/read_write.c:797
 vfs_readv+0x12d/0x1a0 fs/read_write.c:915
 do_preadv fs/read_write.c:1007 [inline]
 __do_sys_preadv fs/read_write.c:1057 [inline]
 __se_sys_preadv fs/read_write.c:1052 [inline]
 __x64_sys_preadv+0x228/0x300 fs/read_write.c:1052
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f3c78638b29
Code: Unable to access opcode bytes at 0x7f3c78638aff.
RSP: 002b:00007f3c785f9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f3c786c2328 RCX: 00007f3c78638b29
RDX: 0000000000000001 RSI: 0000000020001880 RDI: 0000000000000003
RBP: 00007f3c786c2320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3c786c232c
R13: 0000000000000000 R14: 00007ffc8a220310 R15: 00007ffc8a2203f8
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.464 msecs


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
