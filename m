Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7AE7E93F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjKMBOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKMBOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:14:22 -0500
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781EFD1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:14:19 -0800 (PST)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-280152bfd40so3754766a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699838059; x=1700442859;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd10nkgmd63gaoVjAkX/kCfNkLvSSczE+a3R7H9sMus=;
        b=PYhdr3hWqcZEZHcJxdXgtD5h0iWuZ9WbQrZHoOQWfIg1U0pyFjNmOuJRkD134B+xiX
         R0JSaE1t+fcR5JryYtSN6UhvYJOHV8sFHdNRdjnPpXBVXqU0FuQ4MhW6AwSOrMdtbfFQ
         B4FZzrkINuFj4n1kO7i20ILT902WlNiqagh2SWuOdOMidg12rQIC5uXAnjKpSHgIVVH8
         hanuTvSMhfKn4uYzxZ4L1EbrqDHqjT9b98PAEOYN2akWqNeJE/jqOCu1uJcrPE/a1Ki7
         +L3p9IY6HjrBhIDl9zKqTkfOjwOt9ddTxuyQ/+UYMs1En8XA3At1LnhMae/YGCviUfS8
         KV8A==
X-Gm-Message-State: AOJu0YzVQQpvnZnsoiZbjuGY3sTvc5ptYOdoPjXowSjy/kHjz/b6ysDi
        sM/zi2ixBPZWdhFrVuMK4hGQrIoBqlOINMxkjpD5G4LOxTj4
X-Google-Smtp-Source: AGHT+IF+tU1i4I3rkCwiJK/Qe9aCFV7cxBhNXqsPLbf2UexrTZSWrGKyfy1p1MTCjUkeq4PQiPa5O0SZAkGPPSQj8Kxl1EGfP0kb
MIME-Version: 1.0
X-Received: by 2002:a17:90b:4ccf:b0:280:fcba:bee2 with SMTP id
 nd15-20020a17090b4ccf00b00280fcbabee2mr1473215pjb.6.1699838058935; Sun, 12
 Nov 2023 17:14:18 -0800 (PST)
Date:   Sun, 12 Nov 2023 17:14:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adc8200609fe63a4@google.com>
Subject: [syzbot] [bluetooth?] INFO: trying to register non-static key in
 sco_sock_timeout (2)
From:   syzbot <syzbot+702262f0d6464cc55bd2@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1189277b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ffa1cec3b40f3ce
dashboard link: https://syzkaller.appspot.com/bug?extid=702262f0d6464cc55bd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5572da256a4e/disk-30523014.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51b2eac17a7c/vmlinux-30523014.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84c61292173b/bzImage-30523014.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+702262f0d6464cc55bd2@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 24213 Comm: kworker/0:7 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events sco_sock_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:976 [inline]
 register_lock_class+0xd6f/0x1320 kernel/locking/lockdep.c:1289
 __lock_acquire+0x13c/0x5de0 kernel/locking/lockdep.c:5013
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3519
 lock_sock include/net/sock.h:1720 [inline]
 sco_sock_timeout+0xd6/0x2b0 net/bluetooth/sco.c:96
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
================================================================================
UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.c:131:9
index 16382 is out of range for type 'long unsigned int [8]'
CPU: 0 PID: 24213 Comm: kworker/0:7 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events sco_sock_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 __pv_queued_spin_lock_slowpath+0xb37/0xc70 kernel/locking/qspinlock.c:471
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:586 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x20e/0x2b0 kernel/locking/spinlock_debug.c:115
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 lock_sock_nested+0x5f/0xf0 net/core/sock.c:3522
 lock_sock include/net/sock.h:1720 [inline]
 sco_sock_timeout+0xd6/0x2b0 net/bluetooth/sco.c:96
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
================================================================================


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
