Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58F67A8FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjITXEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjITXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:03:59 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DECB7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:03:52 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1d66d948417so448590fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695251032; x=1695855832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oO0eTIehJ1nO4l0iT8zyk7N+9L71kWtfUX3Abpeyoo0=;
        b=B8/sD+TbPuTSOmeWZyxkI9GpPPBqe7MmmdctDfq8UHwWmR9LXBhJfwr6zLvmw41cNI
         NDQDMXG95WXYMuTgWH5fNOJDJEA5+DReUChX/uSUFcP2Z2ZrzmRHoGvZ8iuwboF/rwLo
         KvJ/DXnbGFz/j9Qx4nDCYWc97fMuMQZle1FsrV/FYdziCxGzQ/5vuZfR2WXL36MsHBBx
         1jCiYccYsvCU+5B/zeUfOm2uo/OmLpwi4A6hslHbtUWrVloB0IG/MwP9L9y65HPBuZ/V
         c9GP3areiS3xAOSrDmukhW4QWnlIc0y6wZMg8JbMUZGiCEX1Aqt+pjiXCYuacIZziiXu
         Dn0g==
X-Gm-Message-State: AOJu0YzxDjjXOWhmTkmYyMCan+oqiUs0IAP67P1Q9Iy3Ip8cHlYwW0Nv
        /ibFk+n0oWbZIRykWOMZ0CsAEL2Ohyl6KDigBaIyyno2nZyu
X-Google-Smtp-Source: AGHT+IHJ3FTjDHl4K+/SYLL/69WPAUHQSoJ+2W67HnFqIFENZTAfF6w1PR9zh166ItXWL0uXCAv3s9qBY5By9+TB8eu7QjifCO/2
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c797:b0:1db:d697:45e5 with SMTP id
 dy23-20020a056870c79700b001dbd69745e5mr1468090oab.10.1695251032202; Wed, 20
 Sep 2023 16:03:52 -0700 (PDT)
Date:   Wed, 20 Sep 2023 16:03:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009463840605d2633c@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in l2cap_sock_suspend_cb
From:   syzbot <syzbot+df5cbce32ac8cdb9c7fa@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    23f108dc9ed2 Merge tag 'tpmdd-v6.6-rc2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177aa344680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72
dashboard link: https://syzkaller.appspot.com/bug?extid=df5cbce32ac8cdb9c7fa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-23f108dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e159271e5620/vmlinux-23f108dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7aa0e7830b31/bzImage-23f108dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df5cbce32ac8cdb9c7fa@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_suspend_cb+0x43/0x90 net/bluetooth/l2cap_sock.c:1698
Write of size 8 at addr 0000000000000528 by task kworker/3:4/5228

CPU: 3 PID: 5228 Comm: kworker/3:4 Not tainted 6.6.0-rc1-syzkaller-00070-g23f108dc9ed2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events l2cap_info_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 l2cap_sock_suspend_cb+0x43/0x90 net/bluetooth/l2cap_sock.c:1698
 l2cap_chan_ready.part.0+0x1bc/0x230 net/bluetooth/l2cap_core.c:1376
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1365 [inline]
 l2cap_conn_start+0x15c/0xa40 net/bluetooth/l2cap_core.c:1640
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
==================================================================
Kernel panic - not syncing: KASAN: panic_on_warn set ...
CPU: 3 PID: 5228 Comm: kworker/3:4 Not tainted 6.6.0-rc1-syzkaller-00070-g23f108dc9ed2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events l2cap_info_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 panic+0x6a6/0x750 kernel/panic.c:340
 check_panic_on_warn+0xab/0xb0 kernel/panic.c:236
 end_report+0x108/0x150 mm/kasan/report.c:225
 kasan_report+0xea/0x110 mm/kasan/report.c:590
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 l2cap_sock_suspend_cb+0x43/0x90 net/bluetooth/l2cap_sock.c:1698
 l2cap_chan_ready.part.0+0x1bc/0x230 net/bluetooth/l2cap_core.c:1376
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1365 [inline]
 l2cap_conn_start+0x15c/0xa40 net/bluetooth/l2cap_core.c:1640
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Kernel Offset: disabled


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
