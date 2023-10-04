Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DDE7B880A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbjJDSMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbjJDSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:12:07 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FBFEB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:11:55 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6c65c78d808so161237a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443114; x=1697047914;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugeGKcnKwIUFCxqvMbCBwAW5NtIGRkA7+AjNrkDnb4o=;
        b=sB3qWCCT725FN8U8jFp0k1U0F8xqNLw+UKWGpaSm0zVsn1M8CIesADdjQjWbAqsXRA
         QLjP+s9XGfFShm7ryKog4DvOYKwwXQ+UODWGnaT/Hk/BlatkPIBTGx2YoHm7RR3lCHYA
         HNCoHqw9+7cRAQ3ZOwlgzuQb/qhXQZM/+8KOLiFQbKF5f5x0fO1RowQWkMkIQ8dD6nX5
         4dGwud97wpJI0F21PXhg/dtz7SVFyEUp8CElwyW/S1eeKOWNl9GtE94/+9rF/k+p0+or
         xImewSH7TuRPLeQZx7PMmrP3TiEola16Z+bpAMS3U6Ae2f5xtCqTmsnYiMDP8F9fQqI1
         73Sg==
X-Gm-Message-State: AOJu0Yz/q5t3RXfFCXV2LmtM/N/jDTSm+XfMWGKLfLuh1ktiD6JGWRe2
        70vADPuFm9M0gxTtk8WOvcs6WiNTeNDwPgjBOjT/QVef+jC/
X-Google-Smtp-Source: AGHT+IEr+Fk7UaQn8hvT4rWIDrCEyNFoKf9Tcd8cUZtM9rFaCK5UWwyKcWjRSw8YP5bRsrgKDmaC8MPRFsT/T+g6IgRj9jrkNxL2
MIME-Version: 1.0
X-Received: by 2002:a05:6830:612:b0:6c0:e336:7b81 with SMTP id
 w18-20020a056830061200b006c0e3367b81mr890215oti.4.1696443114651; Wed, 04 Oct
 2023 11:11:54 -0700 (PDT)
Date:   Wed, 04 Oct 2023 11:11:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b14000606e7f15b@google.com>
Subject: [syzbot] [block?] WARNING in __floppy_read_block_0 (3)
From:   syzbot <syzbot+06ecd359d1a53c832788@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9f3ebbef746f Merge tag '6.6-rc3-ksmbd-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10791e92680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=06ecd359d1a53c832788
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9f3ebbef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8528a3384270/vmlinux-9f3ebbef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c33152bfb49a/bzImage-9f3ebbef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06ecd359d1a53c832788@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 11841 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 3 PID: 11841 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 3 PID: 11841 at drivers/block/floppy.c:999 __floppy_read_block_0.isra.0+0x2c2/0x360 drivers/block/floppy.c:4161
Modules linked in:

CPU: 3 PID: 11841 Comm: syz-executor.1 Not tainted 6.6.0-rc3-syzkaller-00146-g9f3ebbef746f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:__floppy_read_block_0.isra.0+0x2c2/0x360 drivers/block/floppy.c:4161
Code: c0 01 00 00 65 48 2b 04 25 28 00 00 00 0f 85 a1 00 00 00 48 81 c4 c8 01 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 8e 34 49 fc <0f> 0b e9 58 ff ff ff e8 c2 23 9e fc e9 88 fe ff ff e8 78 34 49 fc
RSP: 0018:ffffc9000d64fa60 EFLAGS: 00010293

RAX: 0000000000000000 RBX: 1ffff92001ac9f4d RCX: 0000000000000000
RDX: ffff88801b9f9600 RSI: ffffffff853d9082 RDI: 0000000000000001
RBP: ffffea0000b21480 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: 000000000000000c R14: ffffc9000d64fab8 R15: dffffc0000000000
FS:  00007f9a7f9576c0(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9a7ed980c0 CR3: 000000004b01c000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_revalidate.isra.0+0x886/0xca0 drivers/block/floppy.c:4207
 invalidate_drive+0xe8/0x110 drivers/block/floppy.c:3219
 fd_locked_ioctl+0xb9b/0x1a10 drivers/block/floppy.c:3508
 fd_ioctl+0x38/0x50 drivers/block/floppy.c:3576
 blkdev_ioctl+0x2f9/0x770 block/ioctl.c:630
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9a7ec7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9a7f9570c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9a7ed9bf80 RCX: 00007f9a7ec7cae9
RDX: 0000000000000000 RSI: 000000000000024b RDI: 0000000000000003
RBP: 00007f9a7ecc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9a7ed9bf80 R15: 00007fffc2236268
 </TASK>


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
