Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CDA7573D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGRGNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjGRGNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:13:05 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E531171A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:12:31 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-56588fc5431so7051573eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660726; x=1692252726;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klQfg1q2x7FKLdp4k8G6yJXHOdyuse3X+dO0idanylk=;
        b=AxVAkrFuH5XXRrW128tT1+Kg0Yu2fsJAQ7fpvypWu+7W9WnoD+6c5ujYAyhCH90M0p
         uGGVgTvCfh1MYc6JJA5zcuq5/ADXoQdqb3VjlYAelav4oko+tGUDM5SmzfIuUv8renyw
         gylhgnEI0ri4G56OCtrC+mhLE6j+wrs1DJVk7MzKJvlRGWlmYpf+EZzCiLO+I0eNIKGs
         ti+LsmaIKQRQ1UHSYxCfG06H7WXI4pOaMp830AcLuVnBr3pANauJbOxlLG2nAoD1tC9Q
         +RTcGg6TUyYJ8bpLfDih1hlRIsCIY0zJAXl+C44OyaEaUlrHC43xrI1WcIgQBxCEJfOb
         GCAQ==
X-Gm-Message-State: ABy/qLYr4heAPcu9KrgA4vm0KeYGtnGo6/lO+tUkqTqVh9E0VSDATO0D
        Xnko3O3Px9cAMwaH3zoJmLcti1WOzbKjAlT22jjyZuWeqhqV
X-Google-Smtp-Source: APBJJlEfkj+5ZQvMstcILncdzHqqjP40yh8HD5CGQTDuiZZZv4099tEYlCfZMP/+zPLd0FoTDkoVAFTivmcxovP+yR6tbWhggZaS
MIME-Version: 1.0
X-Received: by 2002:a4a:5213:0:b0:55e:38ef:109b with SMTP id
 d19-20020a4a5213000000b0055e38ef109bmr5918865oob.1.1689660726478; Mon, 17 Jul
 2023 23:12:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 23:12:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000648bb80600bccb40@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in wait4 (4)
From:   syzbot <syzbot+8ee0140c3f5eab8a8d4f@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9d23aac8a85f Merge branch 'net-sched-fixes-for-sch_qfq'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14a26574a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a211c03cef60366
dashboard link: https://syzkaller.appspot.com/bug?extid=8ee0140c3f5eab8a8d4f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014d574a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173e5deca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b3053e81622d/disk-9d23aac8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2671c186de22/vmlinux-9d23aac8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31bf9058ec77/bzImage-9d23aac8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ee0140c3f5eab8a8d4f@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10499 ticks this GP) idle=1484/1/0x4000000000000000 softirq=10575/10575 fqs=11
rcu: 	(t=10500 jiffies g=11401 q=739 ncpus=2)
rcu: rcu_preempt kthread starved for 10473 jiffies! g11401 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28352 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xecb/0x59d0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 schedule_timeout+0x148/0x2b0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ba/0xa00 kernel/rcu/tree.c:1609
 rcu_gp_kthread+0x249/0x370 kernel/rcu/tree.c:1808
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5055 Comm: syz-executor387 Not tainted 6.4.0-syzkaller-12079-g9d23aac8a85f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data+0x2c/0x90 kernel/kcov.c:236
Code: 05 b1 0c 7e 7e 49 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 a9 00 01 ff 00 74 0e 85 f6 74 59 <8b> 82 04 16 00 00 85 c0 74 4f 8b 82 e0 15 00 00 83 f8 03 75 44 48
RSP: 0018:ffffc900001e0c50 EFLAGS: 00000206
RAX: 0000000000000102 RBX: 0000000002af31dc RCX: ffffffff884eed1d
RDX: ffff88807d4fbb80 RSI: 0000000000000100 RDI: 0000000000000005
RBP: 000000a7c5ac471b R08: 0000000000000005 R09: 00000000000f4240
R10: 00000000000186a0 R11: 0000000000000000 R12: 00000000000186a0
R13: 0000000000000003 R14: 000000000044b82f R15: 0000000000000000
FS:  0000555555ad9380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000007bda1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 pie_calculate_probability+0x2ad/0x850 net/sched/sch_pie.c:345
 fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers.part.0+0x6a6/0xa30 kernel/time/timer.c:2022
 __run_timers kernel/time/timer.c:2000 [inline]
 run_timer_softirq+0xba/0x1d0 kernel/time/timer.c:2035
 __do_softirq+0x1d8/0x8fd kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 96 8b 3d f7 48 89 df e8 fe 03 3e f7 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 45 bc 2f f7 65 8b 05 f6 55 da 75 85 c0 74 12 5b
RSP: 0018:ffffc90003c1fc60 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff8880223b1460 RCX: 1ffffffff1d56939
RDX: 0000000000000000 RSI: ffffffff8a6c7720 RDI: ffffffff8ac7fc80
RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8eab7b57 R11: 0000000000000000 R12: dffffc0000000000
R13: 00007ffd053a85ec R14: 0000000000000000 R15: 0000000000000004
 do_wait+0x173/0xc70 kernel/exit.c:1593
 kernel_wait4+0x153/0x260 kernel/exit.c:1780
 __do_sys_wait4+0x147/0x160 kernel/exit.c:1808
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb07f2d5093
Code: fe ff e9 41 ff ff ff 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 80 3d 11 10 08 00 00 49 89 ca 74 14 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5d c3 0f 1f 40 00 48 83 ec 28 89 54 24 14 48
RSP: 002b:00007ffd053a85c8 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00000000000424f8 RCX: 00007fb07f2d5093
RDX: 0000000040000001 RSI: 00007ffd053a85ec RDI: 00000000ffffffff
RBP: 000000000000002c R08: 000000000000010f R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd053a85ec
R13: 00007ffd053a8600 R14: 00007ffd053a8640 R15: 000000000000002a
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.668 msecs
CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.4.0-syzkaller-12079-g9d23aac8a85f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events_power_efficient wg_ratelimiter_gc_entries
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data+0xf/0x90 kernel/kcov.c:236
Code: 65 48 8b 04 25 80 b9 03 00 48 8b 80 f8 15 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 65 8b 05 b1 0c 7e 7e 49 89 f1 89 c6 49 89 d2 <81> e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 a9 00 01 ff
RSP: 0018:ffffc90000007c50 EFLAGS: 00000246
RAX: 0000000000000102 RBX: ffffc900105f6350 RCX: ffffffff884eeaed
RDX: 0000000000000000 RSI: 0000000000000102 RDI: 0000000000000001
RBP: ffff88814bba3b00 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000000 R11: 000000007095a603 R12: 0000000000000000
R13: 0000000000000007 R14: ffffed102977475a R15: 000000000000f99d
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000007beaa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 pie_calculate_probability+0x7d/0x850 net/sched/sch_pie.c:308
 fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers.part.0+0x6a6/0xa30 kernel/time/timer.c:2022
 __run_timers kernel/time/timer.c:2000 [inline]
 run_timer_softirq+0xba/0x1d0 kernel/time/timer.c:2035
 __do_softirq+0x1d8/0x8fd kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:lock_release+0x3b0/0x670 kernel/locking/lockdep.c:5769
Code: 7e 83 f8 01 0f 85 dd 01 00 00 9c 58 f6 c4 02 0f 85 c8 01 00 00 48 f7 04 24 00 02 00 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c5 48 c7 45 00 00 00 00 00 c7 45 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc900000c7be0 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 46a4b79061c141b2 RCX: ffffc900000c7c30
RDX: 1ffff11002a4d8c7 RSI: ffffffff8a6c7a20 RDI: ffffffff8ac7fc80
RBP: 1ffff92000018f7e R08: 0000000000000000 R09: fffffbfff1d56f6a
R10: ffffffff8eab7b57 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000003 R14: ffff88801526c640 R15: ffff88801526bb80
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 wg_ratelimiter_gc_entries+0x2b0/0x520 drivers/net/wireguard/ratelimiter.c:76
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
