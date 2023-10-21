Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299867D1B54
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjJUGdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 02:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUGdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 02:33:03 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE409F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 23:32:57 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1ea1bc5d50dso2001478fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 23:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697869977; x=1698474777;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkW/la3MNkqAK76T4FXoe2l8YKRJu+wHh+BtgtvaPjA=;
        b=EjZnuX1p9IUnhD1WHtaynicYLIZG63GKQis7Vuy9XPuHUKs0g1LasN6/08Pf3G3FJP
         5GAUKEuKh5v3CCiKTCbuZLwrQ6Wa+4p8CsWe0NvrdOWTl0mWAA8U9QwVlVfhkF4G2q2F
         pS7P81flRk43xtVu/ZIhM5ngdb37goEP+uUWccPMacnCfBdcUdt8GQ1HW5mwzbjT1+bH
         TILM7Yj81cigULcGrsZfIrAQgkrrj5od8ZvbkDU6e2s/7YPZ7vl/ip+rzbJryqgiSjO0
         t2dqYXmkZvRUtghaTxuBdtTLQPbzIj1QTaV/l4Kq/ZQPKbc1okygRzUM4J4voW949mNF
         92qA==
X-Gm-Message-State: AOJu0YzHk1wuJOR6wL3nocqUA9aC3Gn2JmzgVD4gew0HyItofweetOMr
        NNBTVZCkjiY5rhy/9kTfU4x4t66rlIhci1xKi+MkW9xHNXwE
X-Google-Smtp-Source: AGHT+IFOaSAtVO2JWJNVqPZAKSM/060ynFIF6jGHT4dlqqe4LN3Y99GwTaAlkSLzaxBj/LEEhV/hJ7V+uyuF03KDt2V4X1XGiOdD
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3042:b0:1e9:6ade:af41 with SMTP id
 u2-20020a056870304200b001e96adeaf41mr1820944oau.5.1697869977112; Fri, 20 Oct
 2023 23:32:57 -0700 (PDT)
Date:   Fri, 20 Oct 2023 23:32:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc5c0b06083428d3@google.com>
Subject: [syzbot] [input?] WARNING in cm109_input_open/usb_submit_urb (2)
From:   syzbot <syzbot+2e305789579d76b5c253@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
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

HEAD commit:    213f891525c2 Merge tag 'probes-fixes-v6.6-rc6' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1645d5c5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2b0838e2a16cba
dashboard link: https://syzkaller.appspot.com/bug?extid=2e305789579d76b5c253
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b408820be5ac/disk-213f8915.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d1614ab03cf/vmlinux-213f8915.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0405348b5203/bzImage-213f8915.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e305789579d76b5c253@syzkaller.appspotmail.com

usb 5-1: New USB device found, idVendor=0d8c, idProduct=000e, bcdDevice=8e.8f
usb 5-1: New USB device strings: Mfr=0, Product=24, SerialNumber=3
usb 5-1: Product: syz
usb 5-1: SerialNumber: syz
usb 5-1: config 0 descriptor??
cm109 5-1:0.8: invalid payload size 0, expected 4
input: CM109 USB driver as /devices/platform/dummy_hcd.4/usb5/5-1/5-1:0.8/input/input7
------------[ cut here ]------------
URB ffff88814239df00 submitted while active
WARNING: CPU: 1 PID: 5140 at drivers/usb/core/urb.c:379 usb_submit_urb+0x14cb/0x1720 drivers/usb/core/urb.c:379
Modules linked in:
CPU: 1 PID: 5140 Comm: kworker/1:4 Not tainted 6.6.0-rc6-syzkaller-00029-g213f891525c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x14cb/0x1720 drivers/usb/core/urb.c:379
Code: bf 0e fe eb cb bb fe ff ff ff e9 ca f3 ff ff e8 3b 43 42 fb 48 89 de 48 c7 c7 40 5e 40 8b c6 05 ae e5 72 08 01 e8 05 68 08 fb <0f> 0b e9 ba fe ff ff bb f8 ff ff ff e9 9e f3 ff ff 48 89 ef e8 3c
RSP: 0018:ffffc900043eef30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88814239df00 RCX: ffffc90013d1f000
RDX: 0000000000040000 RSI: ffffffff814df0c6 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0a65766974636120 R12: ffff88801d85b810
R13: ffff88801d85b8a0 R14: ffff88801d85b850 R15: ffff88802f7af2e8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f691b620d58 CR3: 000000002b3be000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cm109_input_open+0x271/0x460 drivers/input/misc/cm109.c:572
 input_open_device+0x1c9/0x310 drivers/input/input.c:654
 kbd_connect+0xff/0x150 drivers/tty/vt/keyboard.c:1593
 input_attach_handler.isra.0+0x17c/0x250 drivers/input/input.c:1064
 input_register_device+0xb1e/0x1130 drivers/input/input.c:2396
 cm109_usb_probe+0x1225/0x17b0 drivers/input/misc/cm109.c:806
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2597
 hub_port_connect drivers/usb/core/hub.c:5459 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5599 [inline]
 port_event drivers/usb/core/hub.c:5759 [inline]
 hub_event+0x2dac/0x4e10 drivers/usb/core/hub.c:5841
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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
