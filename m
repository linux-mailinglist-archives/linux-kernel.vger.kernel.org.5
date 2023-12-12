Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD580ED9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbjLLNb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjLLNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:31:25 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A422AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:32 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-20307075bafso351099fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387891; x=1702992691;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtPNaa63pPbP35mOvk+m07ujnitLGqjs06clA4xZBik=;
        b=rHZOnnnr5Okozxu2KdjxWXX8z7lvM/JMuD5ie+r8C3sxaFajBWAKpe54Rer++4vfya
         GosD6hZPRHV3m1dyLkGrY/0vpTG58QGvZ7Kd0yVArthBs9YpW9b1xesCs7K3GkpKuzto
         G2OfQYmdpf9J4Q2H5PV1X2AtLq/5BckzEOpUULwmT4OCOnqSuTwv2w/k7I5p+dk8dJrN
         NZKZBgbo9Ztx4Kj+eM3b4eDcDANw0Aft/vspmbfnLRmDfKv8dbCx6U3Mt9AK3WTBGScs
         qwA7bBWMarsELGIDeXlJFz7XBztG8Q0SUCxSovD89DezSdspEMcnci3btYBonyiag/bx
         zRoA==
X-Gm-Message-State: AOJu0YxXPT5xafYGSfq/E+tch2H9O9Hp/rd1//Umujs8XGHn5eqKbiy3
        7PH0ITjbAe31h4lB3j7gqwTwkI5x+HUy02vTMfMnlf4JnxE5
X-Google-Smtp-Source: AGHT+IGnAc0yCRSZ6mf1XuYEkcqnsA/8FsH+0QhPTlytVS5KZRO97nTUmH7p/gfi8Iz7E67e2ezrocW8fn+2DlRl2O+tPi2Wz/Jl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e310:b0:1fa:edd5:cb79 with SMTP id
 z16-20020a056870e31000b001faedd5cb79mr5562455oad.4.1702387891303; Tue, 12 Dec
 2023 05:31:31 -0800 (PST)
Date:   Tue, 12 Dec 2023 05:31:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087fa8f060c501197@google.com>
Subject: [syzbot] [fs?] WARNING: proc registration bug in bcm_connect
From:   syzbot <syzbot+df49d48077305d17519a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    d46efae31672 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=123d805ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62dd67b72f86455
dashboard link: https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112e94fae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b971dae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1c7fab7b512/disk-d46efae3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44ed3d86d2c1/vmlinux-d46efae3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e0b5f52455a/Image-d46efae3.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df49d48077305d17519a@syzkaller.appspotmail.com

__nla_validate_parse: 1 callbacks suppressed
netlink: 4 bytes leftover after parsing attributes in process `syz-executor167'.
------------[ cut here ]------------
proc_dir_entry 'can-bcm/3005' already registered
WARNING: CPU: 0 PID: 6120 at fs/proc/generic.c:376 proc_register+0x2e8/0x464 fs/proc/generic.c:377
Modules linked in:
CPU: 0 PID: 6120 Comm: syz-executor167 Not tainted 6.7.0-rc4-syzkaller-gd46efae31672 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : proc_register+0x2e8/0x464 fs/proc/generic.c:377
lr : proc_register+0x2e0/0x464 fs/proc/generic.c:375
sp : ffff800096fa7a40
x29: ffff800096fa7a60 x28: dfff800000000000 x27: 0000000000000000
x26: 0000000000000004 x25: ffff0000d3567ab8 x24: ffff0000c92524a4
x23: ffff0000c9252498 x22: 1fffe0001924a48a x21: ffff0000c9252454
x20: ffff0000d3567ae4 x19: ffff0000c92523c0 x18: ffff800096fa6f20
x17: 0000000000000000 x16: ffff80008a82b29c x15: 0000000000000001
x14: 1fffe0003682623a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : 4358bb8e0c091100
x8 : 4358bb8e0c091100 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096fa7338 x4 : ffff80008e5d1ea0 x3 : ffff8000805af654
x2 : 0000000000000001 x1 : 0000000100000001 x0 : ffff80008e80d580
Call trace:
 proc_register+0x2e8/0x464 fs/proc/generic.c:377
 proc_create_net_single+0x140/0x198 fs/proc/proc_net.c:219
 bcm_connect+0x224/0x43c net/can/bcm.c:1631
 __sys_connect_file net/socket.c:2046 [inline]
 __sys_connect+0x268/0x290 net/socket.c:2063
 __do_sys_connect net/socket.c:2073 [inline]
 __se_sys_connect net/socket.c:2070 [inline]
 __arm64_sys_connect+0x7c/0x94 net/socket.c:2070
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 2368
hardirqs last  enabled at (2367): [<ffff80008035a900>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (2367): [<ffff80008035a900>] __console_unlock kernel/printk/printk.c:2706 [inline]
hardirqs last  enabled at (2367): [<ffff80008035a900>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3038
hardirqs last disabled at (2368): [<ffff80008a826dc0>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (2338): [<ffff8000889a2938>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (2336): [<ffff8000889a2904>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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
