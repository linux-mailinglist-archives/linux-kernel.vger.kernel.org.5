Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D087F059D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:27:23 -0500
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D00F9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 03:27:18 -0800 (PST)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so5475837a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 03:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700393238; x=1700998038;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt69CUjGl3apCloiHMcXyTW+kC9z4DvpekmWwYK97Pk=;
        b=bL3pSTXE94Vtqrwbo8O8hVQ0zOTqYC79zWmOO/cpwAyW4rg2YH6FTtrl1vzWY1ODlI
         vf3sOAHbBTKAsTlKszYFBmv+6C3uGK6qlBdmRP0X7/eQH+eD0/lRpEhE+PyXyFQBjPqB
         /OAnNE/0qEFmLzPy7tMlVabOJDy8yB+9oT3E603qDM4qVaFRHf79P1hJopCtmFIW13Tb
         ET0nxzr0VnRyyeItcMZjuCthliOe2vDk4YMFHMHlsV0T/nafNEU7dvuhkZ+OCso3FGRx
         17ZYdMKfo2K+DBSrsT2hnK31m20DBDkhwitCEoBjHH80+B4tKxXfIT75BD0pss56Bhzm
         UJhA==
X-Gm-Message-State: AOJu0YzS6m6Ve8mb1jib3xBDqf6+JRA2OivKrI4pA0dorwfL8egM88rK
        kNFSIw6601ULoc9ZoMr70vG+IicM/iu72GbyLJhPIm/miRws
X-Google-Smtp-Source: AGHT+IEKx5ISHE4Qq6ls01G7Mie8unBDBQpl1RKn9ndvWj6gQ+HaGV957QGK6B9YDDS48ZjCZVFmizRyAluMSjqrjyNhwrGWXhcG
MIME-Version: 1.0
X-Received: by 2002:a63:1450:0:b0:5bd:d44c:ca5f with SMTP id
 16-20020a631450000000b005bdd44cca5fmr943612pgu.11.1700393237949; Sun, 19 Nov
 2023 03:27:17 -0800 (PST)
Date:   Sun, 19 Nov 2023 03:27:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed34c9060a7fa65a@google.com>
Subject: [syzbot] [fs?] INFO: task hung in user_get_super (2)
From:   syzbot <syzbot+ba09f4a317431df6cddf@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3d658e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138c6fb7680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170665f4e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d57f36bc56de/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba09f4a317431df6cddf@syzkaller.appspotmail.com

INFO: task syz-executor214:6157 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor214 state:D stack:0     pid:6157  ppid:6136   flags:0x00000005
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x57c/0xe58 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xa0/0x2fc kernel/locking/rwsem.c:1522
 __super_lock fs/super.c:58 [inline]
 super_lock+0x160/0x328 fs/super.c:117
 user_get_super+0xe8/0x1a0 fs/super.c:1059
 quotactl_block fs/quota/quota.c:890 [inline]
 __do_sys_quotactl fs/quota/quota.c:955 [inline]
 __se_sys_quotactl fs/quota/quota.c:917 [inline]
 __arm64_sys_quotactl+0x508/0xca0 fs/quota/quota.c:917
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffff80008e513840 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:302
2 locks held by getty/5843:
 #0: ffff0000d76ba0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800094c002f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x414/0x1214 drivers/tty/n_tty.c:2206
1 lock held by syz-executor214/6156:
1 lock held by syz-executor214/6157:
 #0: ffff0000d83500e0 (&type->s_umount_key#44){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000d83500e0 (&type->s_umount_key#44){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117

=============================================



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
