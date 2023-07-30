Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5346768742
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjG3S54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjG3S5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:57:54 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C54B19B1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:57:33 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6bc6a2650a5so7457323a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690743418; x=1691348218;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sn0zJw/bbZ65gP8AMpGCkSg/cxSTCQ8T0dWiqBVVyII=;
        b=ETJjzMLwwRs6iCYONdyNKJZccmyINKw++BxK+7LHHOFZTDOz4pONgai6l4F81+YuJV
         qT3H6FoEnFaQSDHNu3IQRB4GM+iTsUpecp/d8tHfVqRekrN7xhGWssgtN57y+DM5j+qv
         LBYsTEO9Mgv+X53NVwIeqV7Af4qvXCtTkPGD+0ks3ufzBESgtq3msEKrL8MKwcPl4t4G
         EYcJ861Q/M7apFB0pRwooCo52h/C7RfQwcDqKzsmPi82WwCgxDZLYtS7d+X9XLpVttCo
         nPyVfjIGLYaq0vym0TESR3r+jfhOHd5qoaqez6hlrvcrqUYUL2RVEKaLH+nERBE3nTk+
         VZ1w==
X-Gm-Message-State: ABy/qLaTGG09mp7gCeRR+4Xulfi8bv/mctkrfh02UKYKSL2ICZCgrQDO
        0gX/r9dxx0qL/PvkjKcrHDIbkp3iv87Zpyq32xIzR3vrSNVm
X-Google-Smtp-Source: APBJJlEDostvNQVls9I/PxnBBcxX+8y1S1gB8lPVgbx8ofgkKXWGpk6BIVtPr/hy07fX1RUcXFWFJfohya5BD63aZXPZwLMqVIim
MIME-Version: 1.0
X-Received: by 2002:a9d:66cb:0:b0:6b8:8894:e4ac with SMTP id
 t11-20020a9d66cb000000b006b88894e4acmr9576754otm.3.1690743418244; Sun, 30 Jul
 2023 11:56:58 -0700 (PDT)
Date:   Sun, 30 Jul 2023 11:56:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9d4560601b8e0d7@google.com>
Subject: [syzbot] [staging?] WARNING in netdev_open
From:   syzbot <syzbot+b08315e8cf5a78eed03c@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5f0bc0b042fc mm: suppress mm fault logging if fatal signal..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116ca2f6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7b1aac4a6659b6d
dashboard link: https://syzkaller.appspot.com/bug?extid=b08315e8cf5a78eed03c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0394a19e5a08/disk-5f0bc0b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86e5b158564d/vmlinux-5f0bc0b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/612fe43ee34a/bzImage-5f0bc0b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b08315e8cf5a78eed03c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 4694 at kernel/locking/mutex.c:582 __mutex_lock_common kernel/locking/mutex.c:582 [inline]
WARNING: CPU: 1 PID: 4694 at kernel/locking/mutex.c:582 __mutex_lock+0x912/0x1340 kernel/locking/mutex.c:747
Modules linked in:
CPU: 1 PID: 4694 Comm: dhcpcd Not tainted 6.5.0-rc3-syzkaller-00025-g5f0bc0b042fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:582 [inline]
RIP: 0010:__mutex_lock+0x912/0x1340 kernel/locking/mutex.c:747
Code: 08 84 d2 0f 85 d1 09 00 00 8b 05 35 2d 77 04 85 c0 0f 85 50 f8 ff ff 48 c7 c6 20 66 6c 8a 48 c7 c7 e0 63 6c 8a e8 8e b2 18 f7 <0f> 0b e9 36 f8 ff ff 48 8b 85 e0 fe ff ff 48 8d b8 30 09 00 00 48
RSP: 0018:ffffc900034cf730 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888020685940 RSI: ffffffff814d3c06 RDI: 0000000000000001
RBP: ffffc900034cf880 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88807adecd88 R15: ffffffff8b7133a0
FS:  00007fc8da519740(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557c7eb10131 CR3: 000000002951e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netdev_open+0x32/0x820 drivers/staging/rtl8712/os_intfs.c:391
 __dev_open+0x2c4/0x4d0 net/core/dev.c:1442
 __dev_change_flags+0x56f/0x730 net/core/dev.c:8530
 dev_change_flags+0x9a/0x170 net/core/dev.c:8602
 devinet_ioctl+0x13ef/0x1f00 net/ipv4/devinet.c:1150
 inet_ioctl+0x3a6/0x3f0 net/ipv4/af_inet.c:980
 sock_do_ioctl+0x115/0x290 net/socket.c:1190
 sock_ioctl+0x205/0x6e0 net/socket.c:1307
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc8da5e7d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fffdec67188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc8da5196c0 RCX: 00007fc8da5e7d49
RDX: 00007fffdec77378 RSI: 0000000000008914 RDI: 0000000000000018
RBP: 00007fffdec87538 R08: 00007fffdec77338 R09: 00007fffdec772e8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffdec77378 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
