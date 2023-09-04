Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A6C791E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbjIDUSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbjIDUSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:18:13 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD427187
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:18:08 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-573c84224easo731345a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 13:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693858688; x=1694463488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKTSRqe5vEAAweK90RC29TYKol7WNXWy0cVJPsEYh1Y=;
        b=QVv9VGkFCwi4wObx7yi0XQGd22jo0FkCmxCP/Wt71a8M2lqWzZBw/MGCNZuQHKyLM6
         m4sW/graDZBdXyCHuP1mnISVQk2emABWrkJWMS1GxhcT90tZ4DUnjSajJe+Wqv0LWX6V
         l42KNl0SQIvBC1wbCQEZUgTvc86l4ynEodEmSfyRrJ7jYnyqFNdLKzg5kBDS6n6kcv8h
         DK2+nQob0paT/sHSpOTBcymjxZ+bX7PCGIMIsp/+p8RaD51KdlYA+2nDXmVkbkix8nC6
         /iCCEegy59oXeYE9BP7Ldlh9y8RWSM2WGn+6rQr2TPfS1Ge7tDMYdzPUTipj6jpvjtwG
         3mJA==
X-Gm-Message-State: AOJu0YyzgG+8yr1pUWJCQAv5K56RU9PY+SZ32FJOarWdam1t6z93DY5y
        LKO0WhbRDOTw3KQfEuoIXlOJNm2aA+6USpl6lLiB1AYjLpc0
X-Google-Smtp-Source: AGHT+IGYcdTdNiU4vNGnWrzvNF0/XFSSD92cZu6IRSyvRdgXv0e602y/bjkC+L7Qid3c2fo86AKFKGcxurBPh4oLEcDaF6hlsJuv
MIME-Version: 1.0
X-Received: by 2002:a63:8c16:0:b0:56f:8338:ebb3 with SMTP id
 m22-20020a638c16000000b0056f8338ebb3mr2404636pgd.11.1693858688381; Mon, 04
 Sep 2023 13:18:08 -0700 (PDT)
Date:   Mon, 04 Sep 2023 13:18:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bc3d106048e35da@google.com>
Subject: [syzbot] [block?] WARNING in floppy_queue_rq (2)
From:   syzbot <syzbot+0958c189aec84815fdf2@syzkaller.appspotmail.com>
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

HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174657e0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=763a90eee2968442
dashboard link: https://syzkaller.appspot.com/bug?extid=0958c189aec84815fdf2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b97d64c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45e3d1c1d5e8/vmlinux-b97d64c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9587ba4915c/bzImage-b97d64c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0958c189aec84815fdf2@syzkaller.appspotmail.com

WARNING: CPU: 3 PID: 122 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 3 PID: 122 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 3 PID: 122 at drivers/block/floppy.c:999 floppy_queue_rq+0x344/0x3b0 drivers/block/floppy.c:2879
Modules linked in:
CPU: 3 PID: 122 Comm: kworker/3:1H Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:floppy_queue_rq+0x344/0x3b0 drivers/block/floppy.c:2879
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 5e 48 8b 56 30 48 c7 c7 e0 fc f2 8a e8 25 09 12 fc 0f 0b eb 8d e8 dc bd 4b fc <0f> 0b e9 d5 fe ff ff 48 89 df e8 cd a5 a0 fc e9 d9 fc ff ff 48 89
RSP: 0018:ffffc900027bf988 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880186ac340 RSI: ffffffff853a8134 RDI: 0000000000000001
RBP: ffffffff8d6edc80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888020a42408
R13: ffff888020a423c0 R14: dffffc0000000000 R15: ffffc900027bfc00
FS:  0000000000000000(0000) GS:ffff88806b900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f97b40fbd58 CR3: 000000000c776000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 blk_mq_dispatch_rq_list+0x694/0x22d0 block/blk-mq.c:2049
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xd30/0x1740 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0x104/0x180 block/blk-mq-sched.c:333
 blk_mq_run_work_fn+0x1fe/0x390 block/blk-mq.c:2434
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
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
