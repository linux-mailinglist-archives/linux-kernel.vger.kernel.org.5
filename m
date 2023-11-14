Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29F7EA878
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjKNBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjKNBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:55:26 -0500
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D3D44
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:55:22 -0800 (PST)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-5b7dfda133dso4733703a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699926922; x=1700531722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnK5eNAzdUcMmb6ZyP1sRVK+FFB+y9VrSx9PxjOTBZc=;
        b=F7aJu5TqIjjT+FeUsjqHEA+cKUY0Oslc3HYnWBTMJbZbb/zgVaxAxMqRSjmkK4lwE0
         /nwj8obXuGZSIDokyi9toz53ti7Wxzvf2FGyER17EEGqF2NM/xf6ULsHrYEPqw8Fwo2i
         VArF5YfZtIf42R6UBOcRam8aAMCQFrbjmHKLhQZfhJKJu1R5IrH7zYfftS2Mk3e3kIL1
         QnMNZUzXLX0GosTgyJi3yCZrJFG33VF0kcFyV/daOQml0jNTOsmoX0ksQgEBUOP3GHYi
         XApSnIW50KxmJZkAxhM3Ch7j3iMRh74cqu/aYr6Ksr5OZQXlUVsn5qWwXWKZSnyAf7dz
         eYcg==
X-Gm-Message-State: AOJu0YyBGrjx1iFZW7w0+NX3W+s2k7LREaHM+F+aJdyPbMYBM/Qwc3RT
        7xlGKjJYRq8Ye0RGmf/QMZI156m78V3grugEgxYyCdwNiy3H
X-Google-Smtp-Source: AGHT+IHCW80q7CPSDxGmCOQICicNoCyr2DEjx/+Jq1KtEOMhswG65VcHCHVXVOxXLdTpHW4qg8gFSEn/vg/YCA7LA85DifZF3TDG
MIME-Version: 1.0
X-Received: by 2002:a63:1047:0:b0:5bd:3313:7545 with SMTP id
 7-20020a631047000000b005bd33137545mr197810pgq.9.1699926921987; Mon, 13 Nov
 2023 17:55:21 -0800 (PST)
Date:   Mon, 13 Nov 2023 17:55:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000544c4b060a13147a@google.com>
Subject: [syzbot] [overlayfs?] WARNING in ovl_workdir_create (2)
From:   syzbot <syzbot+0abcc185100dc8ec6541@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103c14a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=0abcc185100dc8ec6541
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e84be2b8c53/disk-4bbdb725.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee6cfe1eb699/vmlinux-4bbdb725.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86d1021e070d/bzImage-4bbdb725.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0abcc185100dc8ec6541@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888043a7c590, owner = 0x0, curr 0xffff88801f6b8000, list empty
WARNING: CPU: 1 PID: 5298 at kernel/locking/rwsem.c:1370 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 1 PID: 5298 at kernel/locking/rwsem.c:1370 up_write+0x4f4/0x580 kernel/locking/rwsem.c:1632
Modules linked in:
CPU: 1 PID: 5298 Comm: syz-executor.3 Not tainted 6.6.0-syzkaller-15601-g4bbdb725a36b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1632
Code: 48 c7 c7 40 a3 6a 8b 48 c7 c6 80 a5 6a 8b 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 53 e8 b0 db e7 ff 48 83 c4 08 <0f> 0b e9 75 fd ff ff 48 c7 c1 00 00 01 8f 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9000535f500 EFLAGS: 00010296
RAX: 512c164c8d25da00 RBX: ffffffff8b6aa420 RCX: 0000000000040000
RDX: ffffc9000bd1f000 RSI: 000000000001d66e RDI: 000000000001d66f
RBP: ffffc9000535f5d0 R08: ffffffff81547c82 R09: 1ffff92000a6be40
R10: dffffc0000000000 R11: fffff52000a6be41 R12: 0000000000000000
R13: ffff888043a7c590 R14: 1ffff92000a6bea8 R15: dffffc0000000000
FS:  00007fa12d7f86c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3202a000 CR3: 000000001ed61000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:807 [inline]
 ovl_workdir_create+0x8e1/0x970 fs/overlayfs/super.c:367
 ovl_make_workdir fs/overlayfs/super.c:662 [inline]
 ovl_get_workdir+0x2fb/0x1a10 fs/overlayfs/super.c:820
 ovl_fill_super+0x12cb/0x35c0 fs/overlayfs/super.c:1376
 vfs_get_super fs/super.c:1338 [inline]
 get_tree_nodev+0xb4/0x140 fs/super.c:1357
 vfs_get_tree+0x8c/0x280 fs/super.c:1771
 do_new_mount+0x28f/0xae0 fs/namespace.c:3337
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa12ca7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa12d7f80c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fa12cb9c050 RCX: 00007fa12ca7cae9
RDX: 0000000020000340 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 00007fa12cac847a R08: 0000000020000080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fa12cb9c050 R15: 00007fff601bc678
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
