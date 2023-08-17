Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF09C77F336
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbjHQJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbjHQJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:25:48 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49948271B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:47 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bde50b4dc5so50974715ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264347; x=1692869147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rrk+eYUGNljG6zokDwKDDtqmgTCz4euMXcneW3GvU1k=;
        b=Y0G8If5jC8eeF8KXflhWKKQdEc6DRJLRoK9dYXZtxhvz4sa/HeSLzLfp4L+zThtmPy
         pm7GskyIMYNStWHbbQVAy6dGgfOZZ98lJAuDMng6PeJwq+cxS5Tf4n80dO7gwejvHtf5
         RdyTNzYAL+LVqhvvHgmUhL7/xCGtT+s1jsU7WOgiFXkcZuom7+RA7Jk2U4kOJvWuMEtb
         iQ7YeN3Z+uKY08GvmjmGTDuVd2tw0v8ZfsQxKFItJB7F9oro187BzpEUw0yvdnwJAwaF
         M/HL+Oz4l49f5SPKO3pcjuaTkSD16xmMO7gD/8TK81Z35mIzjB0aRRoKwc9V+DrSRlYY
         Dnvg==
X-Gm-Message-State: AOJu0YxaZ5zwsm7LYK43bU/TF1B5HzGqkrSYCzw69/GWHbIPEbwN1NiC
        /MCdeOoT6yG9GEYSou++OpB0y6aVq9OGCrqeBw1qYbQBGXGcIXhFLw==
X-Google-Smtp-Source: AGHT+IGxojj8qee/eZuvphKSTlSD0kEO4ak2zSyeX/8z/SUDeGDD0a3AFNvMoWuMB2kETQgVS0PjF279mSiepJR12ktGrlVzVszW
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4d0:b0:1bf:cc5:7b57 with SMTP id
 o16-20020a170902d4d000b001bf0cc57b57mr1030087plg.3.1692264346912; Thu, 17 Aug
 2023 02:25:46 -0700 (PDT)
Date:   Thu, 17 Aug 2023 02:25:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000438c4a06031aff8b@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in schedule (6)
From:   syzbot <syzbot+77195ae75047f1438785@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    a785fd28d31f Merge tag 'for-6.5-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167d8e17a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=77195ae75047f1438785
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec36ada80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f025e375131a/disk-a785fd28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d38bc269b3fb/vmlinux-a785fd28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5eb32eee65b8/bzImage-a785fd28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77195ae75047f1438785@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (1 GPs behind) idle=816c/1/0x4000000000000000 softirq=8838/8840 fqs=5242
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:    29521      22957            0   ==> 52480(ms)
rcu: 	(t=10500 jiffies g=5877 q=1892 ncpus=2)
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.5.0-rc5-syzkaller-00362-ga785fd28d31f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:write_comp_data+0x7/0x90 kernel/kcov.c:230
Code: 81 e2 00 01 ff 00 75 10 65 48 8b 04 25 80 b9 03 00 48 8b 80 f8 15 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 65 8b 05 c1 b6 7d 7e <49> 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25
RSP: 0018:ffffc90000007d58 EFLAGS: 00000293
RAX: 0000000000000102 RBX: ffff8880638b6394 RCX: ffffffff88595887
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000004
RBP: 0000000000000008 R08: 0000000000000004 R09: 0000000000000008
R10: 0000000000000010 R11: 0000000000000000 R12: 0000000000000010
R13: ffff88807ce5ab60 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 000000000c776000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 taprio_dequeue_tc_priority+0x247/0x4b0 net/sched/sch_taprio.c:808
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
RIP: 0010:finish_task_switch.isra.0+0x220/0xc90 kernel/sched/core.c:5253
Code: 0a 00 00 44 8b 0d c0 01 52 0d 45 85 c9 0f 85 c0 01 00 00 48 89 df e8 ff f8 ff ff e8 9a dd 32 00 fb 65 48 8b 1c 25 80 b9 03 00 <48> 8d bb e0 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc90000147c88 EFLAGS: 00000202
RAX: 000000000006247f RBX: ffff888015e5bb80 RCX: 1ffffffff1d56e19
RDX: 0000000000000000 RSI: ffffffff8a6c80a0 RDI: ffffffff8ac811c0
RBP: ffffc90000147cd0 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8eaba257 R11: 0000000000000000 R12: ffff8880b983d118
R13: ffff88802bd49dc0 R14: 0000000000000000 R15: ffff8880b983c3c0
 context_switch kernel/sched/core.c:5384 [inline]
 __schedule+0xee9/0x59f0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 smpboot_thread_fn+0x2ee/0xa00 kernel/smpboot.c:160
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
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
