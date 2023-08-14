Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2E77AF10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjHNAtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 20:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHNAst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 20:48:49 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372918E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 17:48:48 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1bc394829b8so45982445ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 17:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691974127; x=1692578927;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffSiHmXmKvWjGufuXWAkAV+GTFU4ol0O8toxVI2rWJk=;
        b=QmaNaZDe7TJ1UpXtn9Pgwo0A3D3W6h9NNlsuK7d2guw6fnEQMVaXao79FkA2qSWGZF
         o58z0DZlPDKs+p9hUwOLNPZHShMzjbziU/kuH8rSOhZAj6rK5tDAFxcU6cMEnz35Mf/6
         Ks/BUwna36EG6tViRXtHn7zx+J7XEhK+jYrjrOc+lqQbPOB1Y+9rlKZK9I3mfdumpmMT
         FdWR+2AptmM0nSmBZGtkG1iSoBVvxr/QYBpTgqXmiJ7mlPrphAB74AqG1vWkEjG42s5R
         C6M0718GjkZFGhiHi/M57/4VMQ44YMYMC5NA66Q9mnm6DFxBhIONGv0FRfpCLZ2wDfkg
         fQew==
X-Gm-Message-State: AOJu0Yza1+JoJk+wYgLVSZ7k9fd7N0qD9LHtFxsb1l43L2o5AiV/F1Ac
        J4hf+hcRmj4mvHVHFQFDQM5Ew7PYNq/Pdw0HlmfMuiAH2YPx
X-Google-Smtp-Source: AGHT+IGPgJJXdVh8mbvUoK5oesGeh9HjctSCCkMz4+0xqO4BQKMhfhx6Y1y1iuqFPeayyQFbPlzkZFTSzh8oVKrIKjkLtS9ZJD9H
MIME-Version: 1.0
X-Received: by 2002:a17:902:ce84:b0:1b2:436b:931d with SMTP id
 f4-20020a170902ce8400b001b2436b931dmr3390972plg.2.1691974127528; Sun, 13 Aug
 2023 17:48:47 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:48:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d730410602d76cf6@google.com>
Subject: [syzbot] [net?] [wireless?] INFO: rcu detected stall in cfg80211_wiphy_work
From:   syzbot <syzbot+b904439e05f11f81ac62@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jiri@nvidia.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cacc6e22932f tpm: Add a helper for checking hwrng enabled
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b0b5c7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=b904439e05f11f81ac62
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a49fcda80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136f8679a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c18b40f6d56d/disk-cacc6e22.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b270ef22b038/vmlinux-cacc6e22.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aae3a8e7d564/bzImage-cacc6e22.xz

The issue was bisected to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123267c3a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=113267c3a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=163267c3a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b904439e05f11f81ac62@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10490 ticks this GP) idle=5a24/1/0x4000000000000000 softirq=8393/8393 fqs=5242
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:    25922      26566          195   ==> 52500(ms)
rcu: 	(t=10502 jiffies g=5333 q=584 ncpus=2)
CPU: 1 PID: 5054 Comm: kworker/1:4 Not tainted 6.5.0-rc5-syzkaller-00056-gcacc6e22932f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events cfg80211_wiphy_work
RIP: 0010:taprio_dequeue_tc_priority+0x266/0x4b0 net/sched/sch_taprio.c:798
Code: 10 89 ef 44 89 f6 e8 39 b5 2c f9 44 39 f5 0f 84 40 ff ff ff e8 3b ba 2c f9 49 83 ff 0f 0f 87 e1 01 00 00 48 8b 04 24 0f b6 00 <38> 44 24 36 7c 08 84 c0 0f 85 bf 01 00 00 8b 33 8b 4c 24 30 48 8b
RSP: 0018:ffffc900001e0d60 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88802b8e7394 RCX: 0000000000000100
RDX: ffff888076ac0000 RSI: ffffffff88594e65 RDI: 0000000000000004
RBP: 0000000000000008 R08: 0000000000000004 R09: 0000000000000008
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000010
R13: ffff88807af8ab60 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 0000000022134000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
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
RIP: 0010:__ieee80211_link_release_channel+0x2/0x450 net/mac80211/chan.c:1778
Code: 89 f7 e8 81 1f 21 f8 e9 44 e0 ff ff 4c 89 f7 e8 74 1f 21 f8 e9 fe fb ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 57 <41> 56 41 55 41 54 55 53 48 89 fb e8 3e 15 cd f7 48 89 da 48 b8 00
RSP: 0018:ffffc90003cff768 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888076ac0000 RSI: ffffffff89b909f5 RDI: ffff8880677463a8
RBP: ffff8880677463a8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888067744c80
R13: ffffc90003cff890 R14: ffff888066980e20 R15: ffff888067746c82
 ieee80211_link_use_channel+0x2dd/0x750 net/mac80211/chan.c:1849
 __ieee80211_sta_join_ibss+0x5f3/0x17e0 net/mac80211/ibss.c:303
 ieee80211_sta_create_ibss+0x206/0x410 net/mac80211/ibss.c:1352
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1482 [inline]
 ieee80211_ibss_work+0xc19/0x15a0 net/mac80211/ibss.c:1709
 ieee80211_iface_work+0xbb8/0xd40 net/mac80211/iface.c:1680
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:435
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
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
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
