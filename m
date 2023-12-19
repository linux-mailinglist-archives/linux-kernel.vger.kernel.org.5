Return-Path: <linux-kernel+bounces-4964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77526818471
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40401B23ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE413ADB;
	Tue, 19 Dec 2023 09:31:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228314265
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b77e8eec3aso535963239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978282; x=1703583082;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnhULLaK7IK9y6KRIpk8ya8WI7AoVLTm74NJ6dDxbXU=;
        b=pBixwqPPIbJe7KdsuamMJl02fYBM4VY6ZjqdR3L1EiTqAvj6SfWpbtCQgaOv1NhOF1
         5uD601dU1IPNRpzMIb4+8kDJk+YO9xvPgRFHHhvQAdlejpUO3+PNKRNPbfGBb0E12vtx
         aDIkpBWO2T+FGVZ4X2U8yuBYP+PCnD0KDi8NpebmLvkyZgChfktluSj9jQpummR6nxB+
         BCFUMK+ACp7tuHpPCOT+fWQPejjniaDB260+WQnJcW3A1c44agjx8dw/9O4cLQryw1tq
         KETrZOJCx03T1bGdFFw+G80nz6B3m0HtOShAg5OInl/ZSH73WAcjGL8Iz7ywPcQTwGZN
         q/8A==
X-Gm-Message-State: AOJu0YzMIZg40rziQeWN1OQVBt3eDYLhEcCnUcVK6K2UFOAO2EyNSvFB
	e1p3jundJhAz4+X3+3dR1FAPo89OeQprwY79rLOozjtfYLCy
X-Google-Smtp-Source: AGHT+IEktIyeeHOKlKM0TPExIiOHQ5EvOx/si+oSKfBPfed5SbzgHJNIUXUGWhj18PNFRTKXy2l+SHRSgJre1QM8zhAzY5q0aR7l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b45:b0:35f:983a:7924 with SMTP id
 f5-20020a056e020b4500b0035f983a7924mr462859ilu.0.1702978282250; Tue, 19 Dec
 2023 01:31:22 -0800 (PST)
Date: Tue, 19 Dec 2023 01:31:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092ec15060cd987e2@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in sys_recvmmsg (3)
From: syzbot <syzbot+b079dc0aa6e992859e7c@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12534501e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=671af399e2dac0e3
dashboard link: https://syzkaller.appspot.com/bug?extid=b079dc0aa6e992859e7c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08b534ec982d/disk-2cf4f94d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8c44c6da6081/vmlinux-2cf4f94d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e291c0f9693/bzImage-2cf4f94d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b079dc0aa6e992859e7c@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=c844/1/0x4000000000000000 softirq=35391/35392 fqs=3
rcu: 	(detected by 1, t=10502 jiffies, g=60989, q=82 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 12878 Comm: syz-executor.1 Not tainted 6.7.0-rc6-syzkaller-00010-g2cf4f94d8e86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
RIP: 0010:rcu_is_watching+0x3d/0xb0 kernel/rcu/tree.c:700
Code: c7 c3 e8 6d 03 00 83 f8 07 89 c5 77 7a 48 8d 3c ed 60 da a6 8c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 <75> 54 48 03 1c ed 60 da a6 8c 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90000007c78 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 0000000000036de8 RCX: ffffffff8166f367
RDX: 1ffffffff194db4c RSI: ffffffff8b2ed360 RDI: ffffffff8ca6da60
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1e30d1a
R10: ffffffff8f1868d7 R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000000 R14: ffff88802be37300 R15: 0000000000000000
FS:  00007feb948206c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020230030 CR3: 000000001f8f7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x464/0x520 kernel/locking/lockdep.c:5725
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xd5/0xc60 net/sched/sch_taprio.c:935
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 86 37 e4 f6 48 89 df e8 ee ae e4 f6 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 25 68 d6 f6 65 8b 05 a6 10 81 75 85 c0 74 12 5b
RSP: 0018:ffffc90003b0f738 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff8880290ad9d0 RCX: 1ffffffff23ead8c
RDX: 0000000000000000 RSI: ffffffff8acc9f40 RDI: ffffffff8b2ed3e0
RBP: 0000000000000246 R08: 0000000000000001 R09: fffffbfff23e1fe5
R10: ffffffff91f0ff2f R11: 0000000000000001 R12: ffff8880290ad9b8
R13: ffff8880177bda80 R14: 0000000000000246 R15: ffffc90003b0f8d8
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __skb_try_recv_datagram+0x16f/0x4f0 net/core/datagram.c:266
 __unix_dgram_recvmsg+0x1d1/0xee0 net/unix/af_unix.c:2383
 unix_dgram_recvmsg+0xc3/0xf0 net/unix/af_unix.c:2485
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 ____sys_recvmsg+0x4ab/0x5c0 net/socket.c:2801
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2845
 do_recvmmsg+0x2af/0x740 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x235/0x290 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7feb93a7cbe9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feb948200c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007feb93b9c050 RCX: 00007feb93a7cbe9
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007feb93ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007feb93b9c050 R15: 00007ffcb6b30bd8
 </TASK>
rcu: rcu_preempt kthread starved for 10496 jiffies! g60989 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28024 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 schedule_timeout+0x137/0x290 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1631
 rcu_gp_kthread+0x24b/0x380 kernel/rcu/tree.c:1830
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.7.0-rc6-syzkaller-00010-g2cf4f94d8e86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x4e4/0x1550 kernel/smp.c:855
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 fe b6 0b 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 24 0e 00 00 8b 43 08 31
RSP: 0018:ffffc9000031f930 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b98414c0 RCX: ffffffff817aaaa8
RDX: ffff88801a66e080 RSI: ffffffff817aaa82 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffffed1017308299
R13: 0000000000000001 R14: ffff8880b98414c8 R15: ffff8880b993d900
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020015000 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2006 [inline]
 text_poke_bp_batch+0x22b/0x750 arch/x86/kernel/alternative.c:2216
 text_poke_flush arch/x86/kernel/alternative.c:2407 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2404 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2414
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:830 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:822
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


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

