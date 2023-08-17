Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9477F308
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349471AbjHQJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349526AbjHQJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:15:29 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0213590
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:15:08 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-68927d7a832so1121717b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263708; x=1692868508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrSKJ1hMfYc0HJvnlnLqMezwfrEauUWTfXgiLXcGByc=;
        b=F6xG5ZKNgN5OQcO4z47Na4K+WLgJ3nq6Wom+3WYFo6Jn+M8CaF7xasMiaC4y3T3gyp
         7/X6YsoLPo0lIZ3YxLXnXeUOUcodwuqyE2uhmBrUWWtjTNe7VPWTQ3JdJAnElgWj+SfC
         c0iiDa0UDNykhnu8tmqFEmk9fdaTk7hE2sUTP5PwSWbSTgYnNQ0JBzSnr8IRvH8GoLfj
         t4aT2vbsg+VHcGjvfxM3tzhLDL2gyvoI7jBTs/hHzn/ko4s/psDVSK2jlDMvLmUzrxvC
         hLXbgLAkN/DeI8xl9CAGaFCqsGqhjEhINGmWXbXq2kgofT4gn+JGgkvb2WM5YAkj1Mxf
         or2Q==
X-Gm-Message-State: AOJu0YyyxzdBu4qrX9ZAjMAoMUGWysMAqu5mmrlsgSD+RkVLHgPBghxb
        eeP9XZCWjDg25QvVfymSfcO6drkiUWznihvuIT6DLs4T4j/z
X-Google-Smtp-Source: AGHT+IHqXpyHbJPh5Ae1pyS5MZn7lR3OpDEZK/Pon+cryEb+qGQm1RmndB9TAtLoBF2d0V4AXRLZd2p7KbXXV/R4qCh003ED9HIi
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:18a9:b0:687:322c:b72e with SMTP id
 x41-20020a056a0018a900b00687322cb72emr2271124pfh.5.1692263708137; Thu, 17 Aug
 2023 02:15:08 -0700 (PDT)
Date:   Thu, 17 Aug 2023 02:15:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000309fd406031ad936@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in mld_ifc_work
From:   syzbot <syzbot+ab792e883bcbdd272d1d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    46670259519f Merge tag 'for-6.5-rc2-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121f3a52a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27e33fd2346a54b
dashboard link: https://syzkaller.appspot.com/bug?extid=ab792e883bcbdd272d1d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc182e825ac4/disk-46670259.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4ddbdd1e588/vmlinux-46670259.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4858edcc7423/bzImage-46670259.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab792e883bcbdd272d1d@syzkaller.appspotmail.com

RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
watchdog: BUG: soft lockup - CPU#1 stuck for 246s! [kworker/1:10:6105]
Modules linked in:
irq event stamp: 148865
hardirqs last  enabled at (148864): [<ffffffff8a40140a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
hardirqs last disabled at (148865): [<ffffffff8a32024e>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1109
softirqs last  enabled at (97838): [<ffffffff8901226a>] xt_write_recseq_end include/linux/netfilter/x_tables.h:397 [inline]
softirqs last  enabled at (97838): [<ffffffff8901226a>] ip6t_do_table+0xcfa/0x1d20 net/ipv6/netfilter/ip6_tables.c:374
softirqs last disabled at (97846): [<ffffffff882841c3>] __dev_queue_xmit+0x253/0x3f20 net/core/dev.c:4120
CPU: 1 PID: 6105 Comm: kworker/1:10 Not tainted 6.5.0-rc2-syzkaller-00066-g46670259519f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Workqueue: mld mld_ifc_work
RIP: 0010:find_entry_to_transmit+0xc/0x9f0 net/sched/sch_taprio.c:324
Code: ff ff 48 89 ef e8 f4 d1 80 f9 e9 1b ff ff ff 48 89 ef e8 87 d2 80 f9 e9 35 ff ff ff 66 90 41 57 49 89 d7 41 56 41 55 41 54 55 <48> 89 f5 53 48 89 fb 48 81 ec a0 00 00 00 0f b6 84 24 e0 00 00 00
RSP: 0018:ffffc900159c7398 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 561aeeb872888f2d RCX: 0000000000000000
RDX: ffff88807ba51c00 RSI: ffff88804cbe4000 RDI: ffff88804c4d0280
RBP: 561aeeb872888f01 R08: 561aeeb872888f2d R09: ffffc900159c7488
R10: 561aeeb872888ec0 R11: 000000000000004e R12: 561aeeb8f2888ec1
R13: ffff88804cbe4000 R14: ffff88807ba53400 R15: ffff88807ba51c00
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000079510000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 get_packet_txtime net/sched/sch_taprio.c:508 [inline]
 taprio_enqueue_one+0x881/0x1640 net/sched/sch_taprio.c:577
 taprio_enqueue+0x239/0x7e0 net/sched/sch_taprio.c:658
 dev_qdisc_enqueue+0x3f/0x230 net/core/dev.c:3732
 __dev_xmit_skb net/core/dev.c:3821 [inline]
 __dev_queue_xmit+0x2202/0x3f20 net/core/dev.c:4169
 dev_queue_xmit include/linux/netdevice.h:3088 [inline]
 neigh_hh_output include/net/neighbour.h:528 [inline]
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0x1083/0x1b20 net/ipv6/ip6_output.c:135
 __ip6_finish_output net/ipv6/ip6_output.c:196 [inline]
 ip6_finish_output+0x485/0x11d0 net/ipv6/ip6_output.c:207
 NF_HOOK_COND include/linux/netfilter.h:292 [inline]
 ip6_output+0x243/0x890 net/ipv6/ip6_output.c:228
 dst_output include/net/dst.h:458 [inline]
 NF_HOOK.constprop.0+0xfd/0x540 include/linux/netfilter.h:303
 mld_sendpack+0x715/0xd60 net/ipv6/mcast.c:1820
 mld_send_cr net/ipv6/mcast.c:2121 [inline]
 mld_ifc_work+0x756/0xcd0 net/ipv6/mcast.c:2653
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:112


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
