Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35E7ECAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjKOS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjKOS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:56:27 -0500
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD0CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:56:23 -0800 (PST)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5b8d4a559ddso8648138a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700074583; x=1700679383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMg6hRCirJOmba9CH8qrsXceC0Z0WgJjEmrr79m3KxA=;
        b=GTDCRNfG/35pN2JR6Qu+BuGI+syWMv7wiXchII7M+MFj6fY9Kl2QP174GzyVJ3FjCJ
         nU5Gq1dtlnIOGz+DGc7SxYTG5yfsqaWZwAq9R7FwUGsNrJhUChu3N0zj4FzgyeIj3PY7
         lTvzRetWJW3MWPaR+wCQFhHQPni478BokCwA75l4J0FIPODIMn0m/rRWNWwRKwu8osNk
         SVFOD2c4MPY1tXCfjXTz/R+867RhFfKiQKqzqBdVjHxW4+kcnje+EsE0u6CLkoTAaabj
         EIvIJ8fHneMGIa0B31941hb26890HAInKEOl5xyfW31oHvP/Mdf17OkG0ZqLydMAUtf2
         g8hA==
X-Gm-Message-State: AOJu0YzcZegk5meQHWPUZ16hEXGkfkuwQOnMQvkSDj0I2cnOzlg05rfO
        7G3FMJN91YwzLEFGWsuwC7++7UI7NtiJIHhRWgprX0UTdrKM
X-Google-Smtp-Source: AGHT+IHYmZ+z8yUSNbrT6h00zNrQvSIysCGOKR2Gx06Rhdag/e+DorVJ2tDHMcGAuu2hGJH/U7/FjCU+1m9rohi2Q3NJoIJzwJEQ
MIME-Version: 1.0
X-Received: by 2002:a63:1d53:0:b0:5be:1908:8f61 with SMTP id
 d19-20020a631d53000000b005be19088f61mr1542055pgm.0.1700074583045; Wed, 15 Nov
 2023 10:56:23 -0800 (PST)
Date:   Wed, 15 Nov 2023 10:56:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d3fa2060a3575ad@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in hci_error_reset
From:   syzbot <syzbot+47d22a47f6bd21399c93@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1753c55b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=47d22a47f6bd21399c93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47d22a47f6bd21399c93@syzkaller.appspotmail.com

Bluetooth: hci5: hardware error 0x00
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc7-syzkaller-g8de1e7afcc1c #0 Not tainted
------------------------------------------------------
kworker/u5:3/6132 is trying to acquire lock:
ffff0000d5a40dc0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at: __flush_work+0xd0/0x1c0 kernel/workqueue.c:3403

but task is already holding lock:
ffff0000d5a410b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:552 [inline]
ffff0000d5a410b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_error_reset+0xec/0x248 net/bluetooth/hci_core.c:1059

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&hdev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       hci_dev_do_close net/bluetooth/hci_core.c:552 [inline]
       hci_rfkill_set_block+0xe8/0x20c net/bluetooth/hci_core.c:956
       rfkill_set_block+0x18c/0x37c net/rfkill/core.c:346
       rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1305
       vfs_write+0x2a0/0x93c fs/read_write.c:582
       ksys_write+0x15c/0x26c fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       __se_sys_write fs/read_write.c:646 [inline]
       __arm64_sys_write+0x7c/0x90 fs/read_write.c:646
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #2 (rfkill_global_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       rfkill_register+0x44/0x7d4 net/rfkill/core.c:1075
       hci_register_dev+0x3e0/0x954 net/bluetooth/hci_core.c:2656
       __vhci_create_device drivers/bluetooth/hci_vhci.c:437 [inline]
       vhci_create_device+0x358/0x6c4 drivers/bluetooth/hci_vhci.c:478
       vhci_get_user drivers/bluetooth/hci_vhci.c:535 [inline]
       vhci_write+0x318/0x3b8 drivers/bluetooth/hci_vhci.c:615
       call_write_iter include/linux/fs.h:1956 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x628/0x93c fs/read_write.c:584
       ksys_write+0x15c/0x26c fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       __se_sys_write fs/read_write.c:646 [inline]
       __arm64_sys_write+0x7c/0x90 fs/read_write.c:646
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #1 (&data->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       vhci_send_frame+0x8c/0x10c drivers/bluetooth/hci_vhci.c:78
       hci_send_frame+0x1c4/0x35c net/bluetooth/hci_core.c:3039
       hci_sched_acl_pkt net/bluetooth/hci_core.c:3651 [inline]
       hci_sched_acl net/bluetooth/hci_core.c:3736 [inline]
       hci_tx_work+0xba0/0x18e4 net/bluetooth/hci_core.c:3835
       process_one_work+0x694/0x1204 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x938/0xef4 kernel/workqueue.c:2784
       kthread+0x288/0x310 kernel/kthread.c:388
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

-> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
       __flush_work+0xf8/0x1c0 kernel/workqueue.c:3403
       flush_work+0x24/0x38 kernel/workqueue.c:3428
       hci_dev_close_sync+0x1c8/0xf2c net/bluetooth/hci_sync.c:4982
       hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
       hci_error_reset+0xf4/0x248 net/bluetooth/hci_core.c:1059
       process_one_work+0x694/0x1204 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x938/0xef4 kernel/workqueue.c:2784
       kthread+0x288/0x310 kernel/kthread.c:388
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

other info that might help us debug this:

Chain exists of:
  (work_completion)(&hdev->tx_work) --> rfkill_global_mutex --> &hdev->req_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock(rfkill_global_mutex);
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->tx_work));

 *** DEADLOCK ***

3 locks held by kworker/u5:3/6132:
 #0: ffff0000d425d938 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x560/0x1204 kernel/workqueue.c:2603
 #1: ffff800096f07c20 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_one_work+0x5a0/0x1204 kernel/workqueue.c:2605
 #2: ffff0000d5a410b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:552 [inline]
 #2: ffff0000d5a410b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_error_reset+0xec/0x248 net/bluetooth/hci_core.c:1059

stack backtrace:
CPU: 1 PID: 6132 Comm: kworker/u5:3 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci5 hci_error_reset
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __flush_work+0xf8/0x1c0 kernel/workqueue.c:3403
 flush_work+0x24/0x38 kernel/workqueue.c:3428
 hci_dev_close_sync+0x1c8/0xf2c net/bluetooth/hci_sync.c:4982
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_error_reset+0xf4/0x248 net/bluetooth/hci_core.c:1059
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
Bluetooth: hci5: Opcode 0x c03 failed: -110


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
