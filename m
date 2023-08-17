Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2480477F337
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbjHQJ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349586AbjHQJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:25:48 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E462919A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:46 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-565e78b8b31so2750760a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264346; x=1692869146;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/QTG9rBebWkSUB0o+1A3VY+Afd61SWU2EDF69zgYl0=;
        b=cULPeTDgsyXc/KVG/u56xKrfMT1+BuxE/aIlyhy++gc5GEr2oSIrjQhI6D5jb1vNOy
         5nndm4TJFSGOLjeFHPlvwfdu5+nk6OKbVk8ecgxbrCai51gi3CxJOLoBhkckjiVoozSJ
         z+TI5Pnvkv4p3dJLmRqT+dvrRWP3K29cTacnZom4I0moC5eCVYwWOKccXg0VJBQ7sPmr
         vRzxBG/Cj3RNx/Nazv63bQvyUgx0VCsC1Q2xXxunKOR+L00kGSv7TNMM6UovxOYGbD6v
         pWaFt952a6b1ks3xFmHvjygf/Lg51yjsSG3SLV0p74RM68Og8JXXK/5maLRwWdtI0PZm
         p3Hg==
X-Gm-Message-State: AOJu0YyE5kqr3LC1+6WQOONm7u6KrzLHKmpHgUl5UcNOA1BFtIT01aZT
        AHq6YXgBh5sh2+EFKMPpR/syw0hPk6GmzV+kK0qhDSKKQXGHe0Z42Q==
X-Google-Smtp-Source: AGHT+IHehNiDmord6bORf3UTeBDgrbitxACjIGugIHoVVE0BtViMqPDrKHlRALqkd0E9vIiD+5UBp71RyekrHAR0jBMrSacJiZt3
MIME-Version: 1.0
X-Received: by 2002:a63:3543:0:b0:565:f23d:8330 with SMTP id
 c64-20020a633543000000b00565f23d8330mr945205pga.3.1692264346532; Thu, 17 Aug
 2023 02:25:46 -0700 (PDT)
Date:   Thu, 17 Aug 2023 02:25:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dcc9306031affdd@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in sys_clock_nanosleep (5)
From:   syzbot <syzbot+43cc00d616820666f675@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    c1a515d3c027 Merge tag 'perf-tools-fixes-for-v6.5-2-2023-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16296a6da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=43cc00d616820666f675
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148c4025a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d9410ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eba2fdb6a695/disk-c1a515d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48bf83ada6f4/vmlinux-c1a515d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53b3f7776067/bzImage-c1a515d3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43cc00d616820666f675@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10499 ticks this GP) idle=c37c/1/0x4000000000000000 softirq=8510/8511 fqs=5247
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        2          0            0
rcu: 	cputime:    29992      22496           71   ==> 52520(ms)
rcu: 	(t=10503 jiffies g=5517 q=636 ncpus=2)
CPU: 1 PID: 5044 Comm: syz-executor388 Not tainted 6.5.0-rc4-syzkaller-00174-gc1a515d3c027 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:taprio_dequeue_from_txq+0x120/0x8d0 net/sched/sch_taprio.c:731
Code: 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 5f 06 00 00 8b ab d0 02 00 00 <4d> 8d 7c 24 18 48 ba 00 00 00 00 00 fc ff df 4c 89 f9 48 c1 e9 03
RSP: 0018:ffffc900001e0d00 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8880671f3000 RCX: 0000000000000100
RDX: 1ffff1100ce3e65a RSI: ffffffff88594162 RDI: ffff8880671f32d0
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000009
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807f540000
R13: ffff88802bf54000 R14: ffff888028b02000 R15: 0000000000000001
FS:  000055555610d480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faf300544e3 CR3: 0000000076896000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 taprio_dequeue_tc_priority+0x289/0x4b0 net/sched/sch_taprio.c:798
 taprio_dequeue+0x12e/0x5f0 net/sched/sch_taprio.c:868
 dequeue_skb net/sched/sch_generic.c:292 [inline]
 qdisc_restart net/sched/sch_generic.c:397 [inline]
 __qdisc_run+0x1c4/0x19d0 net/sched/sch_generic.c:415
 qdisc_run include/net/pkt_sched.h:125 [inline]
 qdisc_run include/net/pkt_sched.h:122 [inline]
 net_tx_action+0x71e/0xc80 net/core/dev.c:5049
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 d6 7b 31 f7 48 89 df e8 ae fa 31 f7 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 55 9d 23 f7 65 8b 05 a6 2b ce 75 85 c0 74 12 5b
RSP: 0018:ffffc90003cffc68 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff8880b992b880 RCX: 1ffffffff1d56b59
RDX: 0000000000000000 RSI: ffffffff8a6c7480 RDI: ffffffff8ac80560
RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8eab8c57 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90003cffdd0 R14: 00000000000f4240 R15: ffff888028c53b98
 hrtimer_start_expires include/linux/hrtimer.h:432 [inline]
 hrtimer_sleeper_start_expires kernel/time/hrtimer.c:1968 [inline]
 do_nanosleep+0x1f2/0x500 kernel/time/hrtimer.c:2044
 hrtimer_nanosleep+0x1ae/0x440 kernel/time/hrtimer.c:2100
 common_nsleep+0xa1/0xc0 kernel/time/posix-timers.c:1350
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1373 [inline]
 __x64_sys_clock_nanosleep+0x344/0x490 kernel/time/posix-timers.c:1373
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faf300385b3
Code: 00 00 00 00 0f 1f 00 83 ff 03 74 7b 83 ff 02 b8 fa ff ff ff 49 89 ca 0f 44 f8 80 3d ee ca 04 00 00 74 14 b8 e6 00 00 00 0f 05 <f7> d8 c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec 28 48 89 54 24 10
RSP: 002b:00007ffea76f6af8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007faf300385b3
RDX: 00007ffea76f6b10 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 00000000000000d3 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffea76f6bf0
R13: 0000000000033bc3 R14: 00007ffea76f6be4 R15: 0000000000000003
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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
