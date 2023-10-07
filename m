Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867277BC9C1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344162AbjJGUZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:25:50 -0400
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEEBC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 13:25:48 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1e132944da9so5497823fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 13:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696710348; x=1697315148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxkCjiKMjdIWmNo9IqKZgQSrRyic8id9IP7auj1drTY=;
        b=T3MlNRGKyCadFRM99qdkpocz7JqLNVwqGZRUaLszj9oONKhCr13aMr3wD99nwvp176
         Znwo8VEIreACc3Od/qkJjRRkoF8wPBZzmlmwSPXnPDytk59JHlwDOXroNZ7HJyPjY6gd
         2YTWOSkgVhiQwshUHz5DMD0n8DygG+Ic9hWf04i7AiaB//WpXl4YL9T9iyZ+yhTkokum
         2TLFRJ12kVqvGJueHzYRBzqyZ+aQ4AdQktVkVzFLeqXOnpCr33avKKn8xiGz/YocAmlW
         sxK3aY3BGgG8ZLe4bvpX4jFwNWtJUNXs4jCJaG/3jnPhppdHmlwZ6H+ygMdxq2PkLb1r
         ZnGg==
X-Gm-Message-State: AOJu0YxATitBqMY90382qJEH3n+OhreEos44QpPe6XAlhG+r5S73aYpC
        OeK6FGzIJZFv/+jgjNAkfcZZ3seBqCgHBMr9E2+KhplpNsflKqiF5A==
X-Google-Smtp-Source: AGHT+IFRArRU7gsNS9WCPeGePur+RRWeir0CrVfKPPjxjFOwQPSmUzMuBXy4zDCZT3sKz6dMfrtr6FeTmDwm5Vkm8bVMZx0/9bn1
MIME-Version: 1.0
X-Received: by 2002:a05:6870:bf0b:b0:1e5:78de:89b4 with SMTP id
 qh11-20020a056870bf0b00b001e578de89b4mr2646504oab.0.1696710348219; Sat, 07
 Oct 2023 13:25:48 -0700 (PDT)
Date:   Sat, 07 Oct 2023 13:25:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097ac5c060726290a@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in clock_adjtime (2)
From:   syzbot <syzbot+628d3507228ad7472be1@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    82714078aee4 Merge tag 'pm-6.6-rc5' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14f69da1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9246be233cb6c74a
dashboard link: https://syzkaller.appspot.com/bug?extid=628d3507228ad7472be1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11369379680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f69da1680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9cbe1db1ea42/disk-82714078.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1d80bc80d7d/vmlinux-82714078.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5d39852943e/bzImage-82714078.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+628d3507228ad7472be1@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-...D } 2636 jiffies s: 581 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5044 Comm: syz-executor955 Not tainted 6.6.0-rc4-syzkaller-00229-g82714078aee4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:__rcu_read_unlock+0x0/0x570 kernel/rcu/tree_plugin.h:419
Code: 24 10 e9 85 f8 ff ff 48 8b 7c 24 28 e8 89 25 6b 00 e9 5b fa ff ff 48 8b 7c 24 30 e8 da 24 6b 00 e9 2b fa ff ff 0f 1f 44 00 00 <f3> 0f 1e fa 41 56 41 55 41 54 55 65 48 8b 2c 25 00 bd 03 00 53 48
RSP: 0018:ffffc900003f8d88 EFLAGS: 00000046
RAX: 0000000080010001 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888028a6a0c0 RSI: ffffffff8864df71 RDI: 0000000000000001
RBP: ffff88807cd21410 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: dffffc0000000000 R12: 0000000000000002
R13: ffff88807cd21400 R14: ffff88807680b340 R15: ffff88807cd21000
FS:  0000555555a5f380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 0000000027216000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 rcu_read_unlock include/linux/rcupdate.h:781 [inline]
 advance_sched+0x6c6/0xc60 net/sched/sch_taprio.c:998
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 56 e5 24 f7 48 89 df e8 4e 64 25 f7 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 55 ce 16 f7 65 8b 05 66 22 c1 75 85 c0 74 12 5b
RSP: 0018:ffffc9000350fa78 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff8880b982b940 RCX: 1ffffffff233c916
RDX: 0000000000000000 RSI: ffffffff8a8c9ba0 RDI: ffffffff8ae90b60
RBP: 0000000000000282 R08: 0000000000000001 R09: fffffbfff233c7d0
R10: ffffffff919e3e87 R11: 0000000000000002 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
 clock_was_set+0x592/0x850 kernel/time/hrtimer.c:972
 timekeeping_inject_offset+0x4d1/0x640 kernel/time/timekeeping.c:1395
 do_adjtimex+0x373/0xaa0 kernel/time/timekeeping.c:2444
 do_clock_adjtime kernel/time/posix-timers.c:1159 [inline]
 __do_sys_clock_adjtime+0x173/0x280 kernel/time/posix-timers.c:1171
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe9265c4ee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff514af48 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe9265c4ee9
RDX: 00007fe9265c4ee9 RSI: 0000000020000280 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffff514afa0
R13: 0000000000000001 R14: 00007ffff514afa0 R15: 0000000000000003
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.940 msecs


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
