Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3984680ED9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbjLLNb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbjLLNb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:31:27 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBFAF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:32 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d9fb7402d6so3486343a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387891; x=1702992691;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSGDZEWTgdWKW8bU16gxzUuZI6p71C2F9ES7PF52wuQ=;
        b=Vvlr28rIaFLPLl39yTP8fMSfGRO8SewvZDQLhcvk8/bD7J9AbKn66+osTPOuNUu3VV
         zR1n7MWrmhJ+5yGvtVdhxrhqHgQjXpkYTOGU4lpad8stAbgrtjyuLHf+bHkMya1QGsrC
         n1dFm/hhP40vBOme7Ht2gN+TRmLVLsD++aXOqumcpqE3MNpo+cuR/HqkRyYAGu5Ww1O+
         Lx0a376x8sx8ePkRt2d10ha44pFK4w1NPX0eAt0OB+QBbGb+UCFtqY6azvFLHdqX9ATI
         odlElog0m+NoUipAQSrVI7L3pTEtgoTqMyat8yfm+6366hdY9bNtGKbzqNvQmfCBA/Ei
         EWRQ==
X-Gm-Message-State: AOJu0YxNE7sixW84DMRc/zFQy5ZN+rgWs0hAd24FvNqp9hCfrqemshSu
        sWFABS55whYKTqSenT49AAxVdhWcAarTU+HT2LTgd/lPT62V
X-Google-Smtp-Source: AGHT+IEtLFT/5pTNgXyNPBuCvorTcXlt6L2a4nXbt78DHq3Dk44P3pbZSY/IoDi4XlSs0dsTao+8swekJJn+GxbuhNrq+2N2Qzge
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4089:b0:6d9:d8fb:6a87 with SMTP id
 x9-20020a056830408900b006d9d8fb6a87mr2030860ott.0.1702387891663; Tue, 12 Dec
 2023 05:31:31 -0800 (PST)
Date:   Tue, 12 Dec 2023 05:31:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d76f3060c5011b9@google.com>
Subject: [syzbot] [net?] net-next test error: INFO: rcu detected stall in corrupted
From:   syzbot <syzbot+018508de386acb3db791@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    18c5c0a845b3 nfp: support UDP segmentation offload
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1193f02ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b9f7eef8021c3a
dashboard link: https://syzkaller.appspot.com/bug?extid=018508de386acb3db791
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0e6af27a24f/disk-18c5c0a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e07826060ecb/vmlinux-18c5c0a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2e5f8236344/bzImage-18c5c0a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+018508de386acb3db791@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=0984/1/0x4000000000000000 softirq=5654/5658 fqs=2
rcu: 	(detected by 1, t=10502 jiffies, g=6801, q=19 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.7.0-rc4-syzkaller-00854-g18c5c0a845b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events linkwatch_event
RIP: 0010:write_comp_data+0x0/0x80 kernel/kcov.c:230
Code: 65 8b 15 fb 2c 7c 7e 81 e2 00 01 ff 00 75 10 65 48 8b 04 25 c0 bc 03 00 48 8b 80 f0 15 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 <49> 89 d2 49 89 f8 49 89 f1 65 48 8b 14 25 c0 bc 03 00 65 8b 05 bf
RSP: 0018:ffffc90000bf7c48 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff888019b706a8 RCX: ffffffff8876e316
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000005
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: 00000000000000bd
R13: 0000000000000001 R14: ffff888019b70000 R15: ffff888019b706b0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562e3da92000 CR3: 000000006c097000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __linkwatch_run_queue+0xc6/0x460 net/core/link_watch.c:223
 linkwatch_event+0x8f/0xc0 net/core/link_watch.c:273
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
rcu: rcu_preempt kthread starved for 10498 jiffies! g6801 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28752 pid:17    tgid:17    ppid:2      flags:0x00004000
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
CPU: 1 PID: 48 Comm: kworker/u4:3 Not tainted 6.7.0-rc4-syzkaller-00854-g18c5c0a845b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x4e4/0x1550 kernel/smp.c:855
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 ae c0 0b 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 24 0e 00 00 8b 43 08 31
RSP: 0018:ffffc90000b8f930 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b98441a0 RCX: ffffffff817bd538
RDX: ffff888016e99dc0 RSI: ffffffff817bd512 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffffed1017308835
R13: 0000000000000001 R14: ffff8880b98441a8 R15: ffff8880b993d8c0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0c25cc35c0 CR3: 000000000cd77000 CR4: 00000000003506f0
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
