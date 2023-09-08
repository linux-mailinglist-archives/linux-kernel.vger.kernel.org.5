Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44F579869D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbjIHLzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbjIHLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:55:07 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E41BC1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 04:55:03 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68ca6c214f9so2501967b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 04:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694174103; x=1694778903;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpID/NCresXBqkoJiwT7k8kW4bhvmuOUSE5piT+zJ24=;
        b=FAYRKKCFDk9jO4VckNTk82YD1zh2H9Oz59VnIXDqoXdEeoqkH/OsG6TsAOkT5X8pCb
         T9xWxr/BjBThTzaTJXu0GpdTs9mZ24vbWE09hGLGidUIbcXXZQgweL47WDs4HLUSJGeA
         nFgLemTE9eHEMLztDMWWza2P/AqbfJioSly0MUJfbiyvnuOrbQm8xIo7G0mTzgf4gKKA
         WANgNTjEdBdKr7tmN06n83l2DoaWkPbrJIIVZ3pZDQPwm7XiwyWXuDG59jlzMWljHQma
         EaohU7uEGd3Sq0qsJfBghVUuA1nh+cepaAn+i+QG01pN5gvF+SZIVoBLm3mM6AUmLDUU
         3HKg==
X-Gm-Message-State: AOJu0YwVO2t30I1rsJIYL8tesgJ66bDbEw4ncjsf4TTsoxMftma8roDd
        N/tf7k5cm0HH0mFG8DjLStga7F7GuNVW5yRSUNMi3VbsI/tK
X-Google-Smtp-Source: AGHT+IFrnJxo5hVxE67zNWYwuOgzQLvb2WzNk+jodw+i6pTBsZ1USWQiKcu762ADAAM8MoUkxi/830WHW4DJDzDD+1mCz4xsS/sf
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:150b:b0:68a:2c24:57ce with SMTP id
 q11-20020a056a00150b00b0068a2c2457cemr850686pfu.5.1694174103177; Fri, 08 Sep
 2023 04:55:03 -0700 (PDT)
Date:   Fri, 08 Sep 2023 04:55:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b92c10604d7a5e9@google.com>
Subject: [syzbot] [block?] WARNING in blk_rq_map_user_iov
From:   syzbot <syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dan.j.williams@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    708283abf896 Merge tag 'dmaengine-6.6-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14142f38680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dc3cb855cd74c2
dashboard link: https://syzkaller.appspot.com/bug?extid=a532b03fdfee2c137666
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115bfbf4680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13896ed0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1bd71e72bfd8/disk-708283ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1cd0be2dff5/vmlinux-708283ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff76c3f9ca24/bzImage-708283ab.xz

The issue was bisected to:

commit a41dad905e5a388f88435a517de102e9b2c8e43d
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Sep 16 00:11:15 2022 +0000

    iov_iter: saner checks for attempt to copy to/from iterator

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127483b8680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=117483b8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=167483b8680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com
Fixes: a41dad905e5a ("iov_iter: saner checks for attempt to copy to/from iterator")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5033 at lib/iov_iter.c:385 _copy_from_iter+0x2c2/0x1270 lib/iov_iter.c:385
Modules linked in:
CPU: 1 PID: 5033 Comm: syz-executor399 Not tainted 6.5.0-syzkaller-11329-g708283abf896 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:_copy_from_iter+0x2c2/0x1270 lib/iov_iter.c:385
Code: 5d 41 5c 41 5d 41 5e 41 5f c3 e8 f9 8c 65 fd be 85 01 00 00 48 c7 c7 a0 94 e8 8a e8 d8 37 a5 fd e9 48 fe ff ff e8 de 8c 65 fd <0f> 0b 45 31 ff eb 88 e8 d2 8c 65 fd 31 ff 89 ee e8 f9 87 65 fd 40
RSP: 0018:ffffc900043c7480 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888014b03b80 RSI: ffffffff84220fb2 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8a60008b R12: 0000000000000001
R13: ffffc900043c76c8 R14: 0000000000000001 R15: 0000160000000000
FS:  0000555555a41380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c8 CR3: 000000007ebb3000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 copy_page_from_iter lib/iov_iter.c:542 [inline]
 copy_page_from_iter+0xa5/0x120 lib/iov_iter.c:531
 bio_copy_from_iter block/blk-map.c:56 [inline]
 bio_copy_user_iov block/blk-map.c:211 [inline]
 blk_rq_map_user_iov+0x9d5/0x1860 block/blk-map.c:662
 blk_rq_map_user_io.part.0+0x276/0x2c0 block/blk-map.c:720
 blk_rq_map_user_io+0xe6/0x230 block/blk-map.c:701
 sg_start_req drivers/scsi/sg.c:1818 [inline]
 sg_common_write.constprop.0+0xd61/0x1c90 drivers/scsi/sg.c:803
 sg_new_write.isra.0+0x546/0xaa0 drivers/scsi/sg.c:770
 sg_ioctl_common drivers/scsi/sg.c:935 [inline]
 sg_ioctl+0x1814/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4cd02c0229
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2da41248 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff2da41418 RCX: 00007f4cd02c0229
RDX: 0000000020000300 RSI: 0000000000002285 RDI: 0000000000000003
RBP: 00007f4cd0333610 R08: 00007fff2da41418 R09: 00007fff2da41418
R10: 002367732f766564 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff2da41408 R14: 0000000000000001 R15: 0000000000000001
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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
