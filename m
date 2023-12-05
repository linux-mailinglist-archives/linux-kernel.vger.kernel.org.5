Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168580454B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbjLECrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjLECq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:46:58 -0500
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B037A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:47:05 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1f4ddfe6fe1so7004145fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744424; x=1702349224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa3ab1dj3+oAfny2wqNQdDo3DgFwOqs4ghofozf9Sz8=;
        b=aX36KwqJ39QMvRx1vt26+/b7qP/LgoR6OK5aPqBBZUSrwsQp5RA16U2hd2MJeMR61s
         4Hh1KGK8sjk/X4vCP+qh7w30PA0RmkNbvTkjQxTCba0r9jpyvrN0ykJToK3ib/VittaI
         xjGaRwtSDoiXS/NNudW9sx609K6EgWVOYb8xOOmV+viLNax8e/2fDGLufPvJQ3lFM3u0
         O7BPfzhVKlIGYPbZSTDLJ8ZlKU3guWlclLT1sFlsDoW608DyR9BRFD+H2Z+T4mSBeyeD
         U7wDeMaDxoPuky5e9jN56a2u33dL8QvjdSYDnHpGJN1Lrnd0obqMdL7GQu6muGrYHzmT
         t/XQ==
X-Gm-Message-State: AOJu0YzQNDzUK8VeH9OVBxOqqikGa7up2BG5Omq52Qa2oJ8b4RweHjvr
        GrBXYvw9S+KfwwgMjChQjlP5VbhSJaECUphpeJtsuQzj1UdC
X-Google-Smtp-Source: AGHT+IFHL7FIbis3U9QMiw4cLXuQEOS6//0NMF23COn8TtbEnxeb8hsP4r2OguGajYoKNetpHFmCkOYobhnf8op6Wgwu6TQIvMQl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:610d:b0:1fb:166c:e070 with SMTP id
 s13-20020a056870610d00b001fb166ce070mr3519594oae.1.1701744424481; Mon, 04 Dec
 2023 18:47:04 -0800 (PST)
Date:   Mon, 04 Dec 2023 18:47:04 -0800
In-Reply-To: <tencent_BBCFCCBEA7F006EC92C9C67209B76EFDAE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb7a4a060bba3f37@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in sys_socket (10)
From:   syzbot <syzbot+de8e83db70e8beedd556@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in validate_mm

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-...D } 2651 jiffies s: 2425 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5512 Comm: sed Not tainted 6.7.0-rc3-syzkaller-00024-g18d46e76d7c2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__lock_acquire+0xc89/0x3b20 kernel/locking/lockdep.c:5134
Code: e7 e8 eb 52 ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 40 48 89 f9 48 c1 e9 03 80 3c 11 00 0f 85 98 2b 00 00 48 83 78 40 00 <0f> 84 7c 13 00 00 0f b7 44 24 08 8b 5c 24 48 8b 4c 24 20 c1 e0 0d
RSP: 0018:ffffc900001f0b40 EFLAGS: 00000082
RAX: ffffffff91f8d970 RBX: 0000000000000000 RCX: 1ffffffff23f1b36
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff91f8d9b0
RBP: ffffffff91f1bca0 R08: 0000000000000000 R09: fffffbfff23e33f3
R10: ffffffff91f19f9f R11: 0000000000000002 R12: ffff888025676450
R13: ffff888025676449 R14: 00000000000008e1 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f588bec5ba8 CR3: 0000000029d0e000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xd5/0xc60 net/sched/sch_taprio.c:934
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:get_current arch/x86/include/asm/current.h:41 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x4/0x60 kernel/kcov.c:206
Code: 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa <65> 48 8b 14 25 c0 bc 03 00 65 8b 05 74 32 7c 7e a9 00 01 ff 00 48
RSP: 0018:ffffc90004cf7970 EFLAGS: 00000246
RAX: ffff88806a0f4c40 RBX: ffff888028217c00 RCX: ffffffff8a700d11
RDX: ffff888025675940 RSI: ffffffff8a700b05 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000005
R10: 000000000000000f R11: 0000000000000001 R12: 00007f588be4efff
R13: 0000000000000005 R14: 000055dc48e02000 R15: dffffc0000000000
 ma_slots lib/maple_tree.c:785 [inline]
 mas_get_slot lib/maple_tree.c:6673 [inline]
 mas_validate_gaps lib/maple_tree.c:6942 [inline]
 mt_validate+0x2771/0x3e90 lib/maple_tree.c:7217
 validate_mm+0x9a/0x4b0 mm/mmap.c:288
 mmap_region+0x15c8/0x2830 mm/mmap.c:2974
 do_mmap+0x893/0xef0 mm/mmap.c:1379
 vm_mmap_pgoff+0x1a8/0x3c0 mm/util.c:556
 ksys_mmap_pgoff+0x422/0x5b0 mm/mmap.c:1425
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f588c16cb74
Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
RSP: 002b:00007ffeec15f508 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffeec15f580 RCX: 00007f588c16cb74
RDX: 0000000000000001 RSI: 0000000000025000 RDI: 00007f588be7d000
RBP: 00007ffeec15f8a0 R08: 0000000000000003 R09: 000000000002e000
R10: 0000000000000812 R11: 0000000000000246 R12: 00007f588c150570
R13: 00007ffeec15f928 R14: 000000000002d9c6 R15: 0000000000000000
 </TASK>


Tested on:

commit:         18d46e76 Merge tag 'for-6.7-rc3-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c9bf2ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
dashboard link: https://syzkaller.appspot.com/bug?extid=de8e83db70e8beedd556
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1340351ce80000

