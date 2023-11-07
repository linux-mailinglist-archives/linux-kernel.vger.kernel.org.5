Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88F07E35EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjKGH3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGH32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:29:28 -0500
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614C120
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:29:24 -0800 (PST)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1e98eca4206so6598189fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699342164; x=1699946964;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HeECuXLy1/FZ3TqugxSjzkKsMd+c/4X0kfQ+/Wm88O0=;
        b=RX8X2nein7P4Nan4GYXEZO7t3mH6Xu1VhfvEvZeNB3pFYBcypJtN2OnbyNJTGtZ38k
         dHbq73xR53Jjr/hLOdYlVRY2LxRYpmAzpsThRb3S3h7kQh4sVfYOyymSGHsAb85xBvH3
         wGz0gyzHhq//batxGsxbiZ8RVFSCpKYwc/9fbwX1hQXAQTeloxIqI7O3Bxl7oIc8z+oF
         gYA39SUsAmtxmJ0vzSkQRqdJVdvsXXrdqTKsNbKTssI38enRcB3oGinKNMyBa1EpgfJR
         R7jROgEaYV9Hxu245mC9N0HgeCgo04erW0SYgDmzY6sUyItYDezHKMdNHrVk1becY41N
         96Pw==
X-Gm-Message-State: AOJu0YyW1Ldg4Kz5uX9so+M9A+4h86/W0u3o1pWa/pwvX5fWI61dd4co
        qc+quzR6/csSfa5v7O11l9gM/vOWr6Tlpg+sFIyjfGcGYkba
X-Google-Smtp-Source: AGHT+IGFGrtsZMT80JbUEI9e9oKjhDqDVPNgmyiTKNdWuwyrgji4fT40PECRjphM9bWrUqVnH+dbayYerBIOuOFd2hGPCqurXkn9
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6c17:b0:1ef:afd3:813f with SMTP id
 na23-20020a0568706c1700b001efafd3813fmr857739oab.5.1699342164320; Mon, 06 Nov
 2023 23:29:24 -0800 (PST)
Date:   Mon, 06 Nov 2023 23:29:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e6aac06098aee0c@google.com>
Subject: [syzbot] [block?] WARNING in blk_mq_start_request
From:   syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117a6ebb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5316ad879647e3c5
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc47ba2476570cbbeb0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13489af3680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145c7d07680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4652b8e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c5be65b1bc8/vmlinux-4652b8e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8799a4da0be5/bzImage-4652b8e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffff489c59c
R13: 00007ffff489c5b0 R14: 00007ffff489c5f0 R15: 0000000000000003
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 3 PID: 5178 at block/blk-mq.c:1258 blk_mq_start_request+0x643/0x780 block/blk-mq.c:1258
Modules linked in:
CPU: 3 PID: 5178 Comm: syz-executor268 Not tainted 6.6.0-syzkaller-10396-g4652b8e4f3ff #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:blk_mq_start_request+0x643/0x780 block/blk-mq.c:1258
Code: 00 00 fc ff df 48 8d 7d 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2f 01 00 00 48 89 df ff 55 10 e9 64 fc ff ff e8 1d 9c 44 fd <0f> 0b e9 f6 fa ff ff e8 11 9c 44 fd 0f 0b e9 06 fa ff ff e8 05 9c
RSP: 0018:ffffc900035ef298 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888018539e00 RCX: ffffffff8442db37
RDX: ffff888030114f00 RSI: ffffffff8442e043 RDI: 0000000000000005
RBP: ffff888018539e94 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888106a33350
R13: 0000000000000001 R14: ffff888018539f1d R15: ffff888018539f20
FS:  0000555555f00480(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555f00788 CR3: 000000002238a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 null_queue_rq+0x2e2/0x7a0 drivers/block/null_blk/main.c:1727
 __blk_mq_issue_directly+0xe3/0x270 block/blk-mq.c:2578
 blk_mq_request_issue_directly+0x120/0x190 block/blk-mq.c:2663
 blk_mq_plug_issue_direct+0x19e/0x670 block/blk-mq.c:2684
 blk_mq_flush_plug_list.part.0+0x16b6/0x1e90 block/blk-mq.c:2793
 blk_mq_flush_plug_list+0x62/0x80 block/blk-mq.c:2770
 __blk_flush_plug+0x2c0/0x430 block/blk-core.c:1142
 blk_finish_plug block/blk-core.c:1166 [inline]
 blk_finish_plug+0x54/0xa0 block/blk-core.c:1163
 read_pages+0x69b/0xdb0 mm/readahead.c:183
 page_cache_ra_unbounded+0x457/0x5e0 mm/readahead.c:269
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0x72b/0xa80 mm/readahead.c:546
 ondemand_readahead+0x493/0x1130 mm/readahead.c:668
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:695
 page_cache_sync_readahead.constprop.0+0xb2/0xf0 include/linux/pagemap.h:1293
 cramfs_blkdev_read fs/cramfs/inode.c:218 [inline]
 cramfs_read+0x33f/0xae0 fs/cramfs/inode.c:278
 cramfs_read_super+0xbd/0x9b0 fs/cramfs/inode.c:522
 cramfs_blkdev_fill_super+0x116/0x2f0 fs/cramfs/inode.c:622
 get_tree_bdev+0x3b5/0x650 fs/super.c:1595
 cramfs_get_tree fs/cramfs/inode.c:958 [inline]
 cramfs_get_tree+0x40/0x50 fs/cramfs/inode.c:948
 vfs_get_tree+0x8c/0x370 fs/super.c:1768
 do_new_mount fs/namespace.c:3337 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount fs/namespace.c:3863 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7feca35df9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff489c548 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffff489c550 RCX: 00007feca35df9f9
RDX: 0000000020000040 RSI: 00000000200000c0 RDI: 0000000020000000
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000003134
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffff489c59c
R13: 00007ffff489c5b0 R14: 00007ffff489c5f0 R15: 0000000000000003
 </TASK>


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
