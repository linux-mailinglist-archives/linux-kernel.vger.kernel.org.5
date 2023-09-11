Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA379A487
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjIKHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjIKHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:31:33 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68719CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:31:25 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5709b5ba7c9so4459167a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694417485; x=1695022285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDi80wPjvY3WLdXNBd8MVO4aCUP2Ev+1NV5i1w7rhJQ=;
        b=XtpAAamJftX+wFUKB3gCC9Ysr5fzwjMezShgllll2L0wehdVjUCOACelfLdH48HukL
         +XOoGCvUMVIdVGxtzPfef3s902zrGYn2bfeNXDcXGiuRoN7B8TOEeZo84n+18mQC/Scd
         0hfF+D33tW9VFcVu/0ecZiK/gIzmyy1mGP0rl9csblHsn0cejafpT3HL+CuLBIRLIi35
         JTN/fS1EG7A7hyEOpdvArOZPE5MIPI42RtiMRnrOt5k77Mu7FHY4OrFuxozspZgz4+cE
         4f6Cg9LTa8ttBbmtliJCQkIptJ7PmV71nmGWuu0ei2AJ6Lh1xA9738wKDh76FfHJEQa0
         KjMQ==
X-Gm-Message-State: AOJu0Yw5dY/oB8RtoebuGSvGC4s9+PtsVPqXE5WNATNsleBUC9jjvmvg
        BrPUpsYXrUq8NtL/Ixc0x5TpXSGGx6RypWEUglI1WP3WPLsA
X-Google-Smtp-Source: AGHT+IGYqQbyc8KyxwBeR046vk/BIPNja11+nvIlv+UsXFgfDUy9cXMT6qskkvMwlcVu7RheoPmWQyCtXLB40EPRWjL/Hi6JATgX
MIME-Version: 1.0
X-Received: by 2002:a63:3d43:0:b0:56a:164b:c6ec with SMTP id
 k64-20020a633d43000000b0056a164bc6ecmr2021317pga.7.1694417484971; Mon, 11 Sep
 2023 00:31:24 -0700 (PDT)
Date:   Mon, 11 Sep 2023 00:31:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b06a9060510505d@google.com>
Subject: [syzbot] [block?] WARNING in floppy_check_events (2)
From:   syzbot <syzbot+2302c7d7bfcdb6baae34@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    744a759492b5 Merge tag 'input-for-v6.6-rc0' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13608e90680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf0b75ea0da0ab1b
dashboard link: https://syzkaller.appspot.com/bug?extid=2302c7d7bfcdb6baae34
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-744a7594.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7ccfd4fc8e9/vmlinux-744a7594.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b040ddea4665/bzImage-744a7594.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2302c7d7bfcdb6baae34@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 29456 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 2 PID: 29456 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 2 PID: 29456 at drivers/block/floppy.c:999 floppy_check_events+0x497/0x6f0 drivers/block/floppy.c:4100
Modules linked in:
CPU: 2 PID: 29456 Comm: syz-executor.3 Not tainted 6.5.0-syzkaller-12053-g744a759492b5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:floppy_check_events+0x497/0x6f0 drivers/block/floppy.c:4100
Code: ff 48 c1 e0 04 8b 98 34 af 56 92 c1 fb 02 83 e3 1f 89 de e8 0b 72 4a fc 85 db 0f 94 c3 0f b6 db e9 d2 fe ff ff e8 89 76 4a fc <0f> 0b e9 55 ff ff ff e8 7d 73 9f fc e9 c7 fb ff ff 48 89 ef e8 70
RSP: 0018:ffffc900289b77e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888065b90480 RSI: ffffffff853c2bf7 RDI: 0000000000000001
RBP: ffffffff9256af50 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: 1ffff92005136efc R14: 0000000000000001 R15: 0000000000000000
FS:  00007fdc25bdd6c0(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f75d9df6c98 CR3: 000000010b58f000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 disk_check_events+0xbc/0x400 block/disk-events.c:193
 disk_clear_events block/disk-events.c:248 [inline]
 disk_check_media_change+0x101/0x2b0 block/disk-events.c:279
 floppy_open+0x8ef/0xe00 drivers/block/floppy.c:4058
 blkdev_get_whole+0x93/0x2c0 block/bdev.c:640
 blkdev_get_by_dev.part.0+0x211/0xb20 block/bdev.c:795
 blkdev_get_by_dev+0x75/0x80 block/bdev.c:829
 blkdev_open+0x112/0x380 block/fops.c:589
 do_dentry_open+0x88b/0x1730 fs/open.c:929
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdc2707b6e0
Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 09 82 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 5c 82 02 00 8b 44
RSP: 002b:00007fdc25bdcc00 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdc2707b6e0
RDX: 0000000000000000 RSI: 00007fdc25bdcca0 RDI: 00000000ffffff9c
RBP: 00007fdc25bdcca0 R08: 0000000000000000 R09: 002364662f766564
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdc2719c120 R15: 00007ffd07db9d08
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
