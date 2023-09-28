Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BA47B28A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjI1XE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:04:28 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6319D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 16:04:25 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6c4deb5c9e3so100992a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 16:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695942265; x=1696547065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYVVwGnE6OPcQXW03l4khaOQttTM3qhI1jmlcZKWyoQ=;
        b=dsnu3f55PsswC+7hRNJaXfmrcwSt8WpCPuyxz20UN+iTRv7I9eEblaM/q8fan8SWfc
         9rKc6yJmAEvH3mTVJfLZoSOS/en5fJUq790Hu8vbvWm1sgoZ3gyrei1u8TUoOL+iTFAC
         kmEKJaVCI/JQhxmDKtQJ7u9YDQULFjavtDNO2Thin6nJhLnYNZCSKJFbfsQkuzSAaNmC
         uYPANxB1Jhn8+bX+6T+0d2YtpZLkWaRXtXRiFPHZuOEZKlevFJzFEbItdmRK/THs4sS7
         Z9eaPunk3DTiSM5tLWUTwdGB+MQmvKuTZ8TiEzd8rOVWyKWXtY/zGgf+QRQQAfJ8DcXK
         +vdw==
X-Gm-Message-State: AOJu0Yxt9nJHmn5c2scxCnpYsIDbdM0Uv+Y89Nt38Mf+YTXjTGt83s8q
        Gzt6HJhhA7rfunHn2Duko24j0KGPmYu8dkA5V9qmXFY0IWEV
X-Google-Smtp-Source: AGHT+IE43VubC1rcbjPn94s2f6h7KBdiLEmKdkWzMURapibBforfO+pyngERA+u2+geoAAcbY0GUEDyK0WX3fCylws5aJncOx3Go
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4617:b0:6c6:2b19:7270 with SMTP id
 ba23-20020a056830461700b006c62b197270mr769742otb.1.1695942265332; Thu, 28 Sep
 2023 16:04:25 -0700 (PDT)
Date:   Thu, 28 Sep 2023 16:04:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048eddc06067354b1@google.com>
Subject: [syzbot] [block?] possible deadlock in bd_prepare_to_claim
From:   syzbot <syzbot+034076c3f2924132d327@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
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

HEAD commit:    8a511e7efc5a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e16eb6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=034076c3f2924132d327
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab9ab551228e/disk-8a511e7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e58e50b20cc/vmlinux-8a511e7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9945a56f5461/bzImage-8a511e7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+034076c3f2924132d327@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc2-syzkaller-00414-g8a511e7efc5a #0 Not tainted
------------------------------------------------------
syz-executor.4/483 is trying to acquire lock:
ffffffff8d0648e8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1b0/0x4c0 block/bdev.c:508

but task is already holding lock:
ffff8881489f2040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:847 [inline]
ffff8881489f2040 (mapping.invalidate_lock#2){++++}-{3:3}, at: blk_ioctl_zeroout block/ioctl.c:184 [inline]
ffff8881489f2040 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_common_ioctl+0x1711/0x2860 block/ioctl.c:510

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (mapping.invalidate_lock#2){++++}-{3:3}:
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1520
       filemap_invalidate_lock_shared include/linux/fs.h:857 [inline]
       filemap_fault+0x658/0x1710 mm/filemap.c:3283
       __do_fault+0x133/0x4e0 mm/memory.c:4204
       do_shared_fault mm/memory.c:4635 [inline]
       do_fault mm/memory.c:4709 [inline]
       do_pte_missing mm/memory.c:3669 [inline]
       handle_pte_fault mm/memory.c:4978 [inline]
       __handle_mm_fault mm/memory.c:5119 [inline]
       handle_mm_fault+0x21d9/0x62b0 mm/memory.c:5284
       do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x2ac/0x860 arch/x86/mm/fault.c:1561
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #3 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0xc1/0x120 mm/memory.c:5896
       _copy_from_user+0x2a/0xe0 lib/usercopy.c:14
       copy_from_user include/linux/uaccess.h:183 [inline]
       quota_setinfo+0xb2/0x4f0 fs/quota/quota.c:152
       __do_sys_quotactl_fd fs/quota/quota.c:1002 [inline]
       __se_sys_quotactl_fd+0x29d/0x440 fs/quota/quota.c:973
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&type->s_umount_key#30){++++}-{3:3}:
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1520
       __super_lock fs/super.c:58 [inline]
       super_lock+0x176/0x390 fs/super.c:117
       super_lock_shared fs/super.c:146 [inline]
       super_lock_shared_active fs/super.c:1431 [inline]
       fs_bdev_sync+0xa5/0x170 fs/super.c:1466
       blkdev_flushbuf block/ioctl.c:372 [inline]
       blkdev_common_ioctl+0x889/0x2860 block/ioctl.c:502
       blkdev_ioctl+0x520/0x730 block/ioctl.c:624
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&bdev->bd_holder_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       bd_finish_claiming+0x231/0x3f0 block/bdev.c:566
       blkdev_get_by_dev+0x481/0x620 block/bdev.c:799
       setup_bdev_super+0x5d/0x600 fs/super.c:1484
       mount_bdev+0x1e0/0x300 fs/super.c:1626
       legacy_get_tree+0xef/0x190 fs/fs_context.c:638
       vfs_get_tree+0x8c/0x280 fs/super.c:1750
       do_new_mount+0x28f/0xae0 fs/namespace.c:3335
       init_mount+0xd4/0x130 fs/init.c:25
       do_mount_root+0x98/0x230 init/do_mounts.c:166
       mount_root_generic+0x193/0x3b0 init/do_mounts.c:205
       prepare_namespace+0xc2/0x100 init/do_mounts.c:489
       kernel_init_freeable+0x46a/0x5c0 init/main.c:1560
       kernel_init+0x1d/0x2a0 init/main.c:1437
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #0 (bdev_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5136
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       bd_prepare_to_claim+0x1b0/0x4c0 block/bdev.c:508
       truncate_bdev_range+0x4e/0x260 block/bdev.c:105
       blk_ioctl_zeroout block/ioctl.c:185 [inline]
       blkdev_common_ioctl+0x1723/0x2860 block/ioctl.c:510
       blkdev_ioctl+0x520/0x730 block/ioctl.c:624
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  bdev_lock --> &mm->mmap_lock --> mapping.invalidate_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock#2);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock#2);
  lock(bdev_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.4/483:
 #0: ffff8881489f2040 (mapping.invalidate_lock#2){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:847 [inline]
 #0: ffff8881489f2040 (mapping.invalidate_lock#2){++++}-{3:3}, at: blk_ioctl_zeroout block/ioctl.c:184 [inline]
 #0: ffff8881489f2040 (mapping.invalidate_lock#2){++++}-{3:3}, at: blkdev_common_ioctl+0x1711/0x2860 block/ioctl.c:510

stack backtrace:
CPU: 0 PID: 483 Comm: syz-executor.4 Not tainted 6.6.0-rc2-syzkaller-00414-g8a511e7efc5a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5136
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
 bd_prepare_to_claim+0x1b0/0x4c0 block/bdev.c:508
 truncate_bdev_range+0x4e/0x260 block/bdev.c:105
 blk_ioctl_zeroout block/ioctl.c:185 [inline]
 blkdev_common_ioctl+0x1723/0x2860 block/ioctl.c:510
 blkdev_ioctl+0x520/0x730 block/ioctl.c:624
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faae827cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faae8f980c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faae839c050 RCX: 00007faae827cae9
RDX: 0000000020000080 RSI: 000000000000127f RDI: 0000000000000005
RBP: 00007faae82c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007faae839c050 R15: 00007ffef2852be8
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
