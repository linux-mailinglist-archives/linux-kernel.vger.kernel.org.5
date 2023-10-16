Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77047CB5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjJPVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjJPVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:55:53 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E0A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:55:50 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1e9d9455085so5232620fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697493349; x=1698098149;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nN/DKyXNfV9UOZtfCJ4t2w1Lgc+Hy86uW31kjn5dY3o=;
        b=it5RF6W6gy8HW42vczWTbBlEo8fCeuQRj9M+1R0UxDKWM/D+uI0Uq3YGEPEj3M00qg
         0GDVbadsCOUQtPX4ZignMACf2t7E9VuEOS02a6KVTsj4YP894O7Ng6+nKeQLCidNKhh2
         ulDAs7QtDba9EwjW8kCTZiT3FqMpRVfe3YsJbCyFJ0Mx8JwNhJUiOZChYHAAaIprlcTO
         +id7Z21m1YOB02JcrqqeGsmMrHRDTvaMPv+1/peo6pkpwoH2k1JbF04fzlJcjzTkyRl6
         E6yJcfxFoTKejUGs3wvax+nW/tEPuo4ri9+BOncCH6gQ/644iCezawvdA9n+MJI/yu6J
         LKfA==
X-Gm-Message-State: AOJu0YyxRCnzjlZDTHVpUmLopuWCMGCvnG7DZkwFKV/PxdAnM/f7HzGD
        sMcCbta3F9sowzr4U3BHxFzRpiXFH/xu62LCZ8zwtkl9oXFu
X-Google-Smtp-Source: AGHT+IEViz9fGeFW0Hnjg2Bp6JP0Ewzt3j6QpH0gG+qVBvd5NNPQHpCF5RpwhTAdQY5MiVLlpFlEVb0X/Pcjbbmpd7ntfVim6++9
MIME-Version: 1.0
X-Received: by 2002:a05:6870:158d:b0:1e9:9e47:9555 with SMTP id
 j13-20020a056870158d00b001e99e479555mr152232oab.11.1697493349610; Mon, 16 Oct
 2023 14:55:49 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:55:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001cb8910607dc78da@google.com>
Subject: [syzbot] [block?] possible deadlock in blkdev_put (4)
From:   syzbot <syzbot+0c538bd7f64c3c6e9a3c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    401644852d0b Merge tag 'fs_for_v6.6-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1516d9c1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1531f6ad09decf37
dashboard link: https://syzkaller.appspot.com/bug?extid=0c538bd7f64c3c6e9a3c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f214cbf53142/disk-40164485.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c07186eb3504/vmlinux-40164485.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3b8af11497b6/bzImage-40164485.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c538bd7f64c3c6e9a3c@syzkaller.appspotmail.com

EXT4-fs (loop4): external journal device major/minor numbers have changed
EXT4-fs (loop4): external journal has bad superblock
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc5-syzkaller-00072-g401644852d0b #0 Not tainted
------------------------------------------------------
syz-executor.4/13442 is trying to acquire lock:
ffff88801c9eb4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xb0/0x8e0 block/bdev.c:884

but task is already holding lock:
ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_get_journal_blkdev fs/ext4/super.c:5861 [inline]
ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_open_dev_journal fs/ext4/super.c:5933 [inline]
ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_load_journal fs/ext4/super.c:5996 [inline]
ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_load_and_init_journal+0x949/0x28f0 fs/ext4/super.c:4906

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&type->s_umount_key#32){++++}-{3:3}:
       down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
       __super_lock fs/super.c:58 [inline]
       super_lock+0x23c/0x380 fs/super.c:117
       super_lock_shared fs/super.c:146 [inline]
       super_lock_shared_active fs/super.c:1431 [inline]
       fs_bdev_sync+0x94/0x1b0 fs/super.c:1466
       blkdev_flushbuf block/ioctl.c:372 [inline]
       blkdev_common_ioctl+0x1550/0x1ce0 block/ioctl.c:502
       blkdev_ioctl+0x249/0x770 block/ioctl.c:624
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&bdev->bd_holder_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       bdev_mark_dead+0x25/0x230 block/bdev.c:961
       disk_force_media_change+0x51/0x80 block/disk-events.c:302
       __loop_clr_fd+0x3ab/0x8f0 drivers/block/loop.c:1174
       lo_release+0x188/0x1c0 drivers/block/loop.c:1743
       blkdev_put_whole+0xa5/0xe0 block/bdev.c:663
       blkdev_put+0x40f/0x8e0 block/bdev.c:898
       kill_block_super+0x58/0x70 fs/super.c:1649
       exfat_kill_sb+0x3b/0xb0 fs/exfat/super.c:771
       deactivate_locked_super+0x9a/0x170 fs/super.c:481
       deactivate_super+0xde/0x100 fs/super.c:514
       cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
       task_work_run+0x14d/0x240 kernel/task_work.c:180
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
       exit_to_user_mode_prepare+0x215/0x240 kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
       do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&disk->open_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       blkdev_put+0xb0/0x8e0 block/bdev.c:884
       ext4_get_journal_blkdev fs/ext4/super.c:5920 [inline]
       ext4_open_dev_journal fs/ext4/super.c:5933 [inline]
       ext4_load_journal fs/ext4/super.c:5996 [inline]
       ext4_load_and_init_journal+0x1deb/0x28f0 fs/ext4/super.c:4906
       __ext4_fill_super fs/ext4/super.c:5374 [inline]
       ext4_fill_super+0x8c4b/0xad30 fs/ext4/super.c:5703
       get_tree_bdev+0x3b5/0x650 fs/super.c:1577
       vfs_get_tree+0x8c/0x370 fs/super.c:1750
       do_new_mount fs/namespace.c:3335 [inline]
       path_mount+0x1492/0x1ed0 fs/namespace.c:3662
       do_mount fs/namespace.c:3675 [inline]
       __do_sys_mount fs/namespace.c:3884 [inline]
       __se_sys_mount fs/namespace.c:3861 [inline]
       __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &disk->open_mutex --> &bdev->bd_holder_lock --> &type->s_umount_key#32

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->s_umount_key#32);
                               lock(&bdev->bd_holder_lock);
                               lock(&type->s_umount_key#32);
  lock(&disk->open_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.4/13442:
 #0: ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_get_journal_blkdev fs/ext4/super.c:5861 [inline]
 #0: ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_open_dev_journal fs/ext4/super.c:5933 [inline]
 #0: ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_load_journal fs/ext4/super.c:5996 [inline]
 #0: ffff88807adce0e0 (&type->s_umount_key#32){++++}-{3:3}, at: ext4_load_and_init_journal+0x949/0x28f0 fs/ext4/super.c:4906

stack backtrace:
CPU: 0 PID: 13442 Comm: syz-executor.4 Not tainted 6.6.0-rc5-syzkaller-00072-g401644852d0b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
 blkdev_put+0xb0/0x8e0 block/bdev.c:884
 ext4_get_journal_blkdev fs/ext4/super.c:5920 [inline]
 ext4_open_dev_journal fs/ext4/super.c:5933 [inline]
 ext4_load_journal fs/ext4/super.c:5996 [inline]
 ext4_load_and_init_journal+0x1deb/0x28f0 fs/ext4/super.c:4906
 __ext4_fill_super fs/ext4/super.c:5374 [inline]
 ext4_fill_super+0x8c4b/0xad30 fs/ext4/super.c:5703
 get_tree_bdev+0x3b5/0x650 fs/super.c:1577
 vfs_get_tree+0x8c/0x370 fs/super.c:1750
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fba0307e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fba03d12ee8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fba03d12f80 RCX: 00007fba0307e1ea
RDX: 0000000020000000 RSI: 0000000020000500 RDI: 00007fba03d12f40
RBP: 0000000020000000 R08: 00007fba03d12f80 R09: 0000000000004503
R10: 0000000000004503 R11: 0000000000000202 R12: 0000000020000500
R13: 00007fba03d12f40 R14: 00000000000004c1 R15: 000000000000002c
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
