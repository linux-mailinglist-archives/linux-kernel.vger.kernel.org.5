Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91A797B30
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbjIGSIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjIGSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:07:41 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FE0CC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:07:21 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68bec4f6a64so1561850b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110018; x=1694714818;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqIHP5Atx4E10XOKrkLhp5j/znUfTqtEUAaZEP+CeQw=;
        b=TyMHFXMBd6KCn3Z71op6Qs+KIM8JLPBbV2oSDQqHEdAprgN1t5htoDN5Lu6WvUhmeA
         TbRbmD6FEzWMjfi3NCvrDGFMdpByB4asrI2n8d0j+jXVnWs8Ifwi0b3QLdfncKTfsJSY
         xXmPAj/9N0Be5A1/TZqVwDucKOnbn4t6dzi5jmvMFQQTDPQYyTS+7CtDildCQIbuq2j+
         I47fRHh8xSsR17wCJc0wD9VpquMhFbrOqU8EfZauvUA74/WIp3A7eysgPv+W8MzAk4XX
         MGSIkA6I1GgvQydWQ10iO5wLbtUl1TWWX5RXKg9Hc+rLDKBesaG/Zqq5SJhPl73NKil8
         DItQ==
X-Gm-Message-State: AOJu0YzROwoCDolVaXslcuahe5qHf7xrlt506O//K6VLljQlLoEnmLbn
        8NnNqxubV56KBUrctKurI+ZAt6G9swybVMEVUMaN4CFScaIh
X-Google-Smtp-Source: AGHT+IFjPvYdL6yJ0T9RSw8wXgbzzm4aQgq4yAZjXwtG6lh8tmWk/dSQvsey2Cq+JzMdkY6lBH1o5i38YWcZcU9ohInMvFejN3az
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1989:b0:68b:a137:3738 with SMTP id
 d9-20020a056a00198900b0068ba1373738mr33354pfl.5.1694110018575; Thu, 07 Sep
 2023 11:06:58 -0700 (PDT)
Date:   Thu, 07 Sep 2023 11:06:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de219d0604c8b9b0@google.com>
Subject: [syzbot] [usb?] WARNING in wdm_rxwork/usb_submit_urb
From:   syzbot <syzbot+44a9ac69913e0758fbc1@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0468be89b3fa Merge tag 'iommu-updates-v6.6' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=161a0924680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89dc1df75beb4d84
dashboard link: https://syzkaller.appspot.com/bug?extid=44a9ac69913e0758fbc1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1079f65481a7/disk-0468be89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7eb3c6765fda/vmlinux-0468be89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92e68aa81913/bzImage-0468be89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44a9ac69913e0758fbc1@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 5266 at drivers/usb/core/urb.c:379 usb_submit_urb+0x14cb/0x1720 drivers/usb/core/urb.c:379
Modules linked in:
CPU: 1 PID: 5266 Comm: kworker/1:4 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events wdm_rxwork
RIP: 0010:usb_submit_urb+0x14cb/0x1720 drivers/usb/core/urb.c:379
Code: 27 4b fe eb cb bb fe ff ff ff e9 ca f3 ff ff e8 4b f6 4b fd 48 89 de 48 c7 c7 e0 f1 ee 86 c6 05 45 85 25 05 01 e8 95 af 15 fd <0f> 0b e9 ba fe ff ff bb f8 ff ff ff e9 9e f3 ff ff 48 89 ef e8 6c
RSP: 0018:ffffc90001f57c40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88810efe6b00 RCX: 0000000000000000
RDX: ffff88811e413a00 RSI: ffffffff811725a6 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 205d363632355420 R12: 0000000000000293
R13: ffff8881013c7090 R14: ffff8881013c7050 R15: ffff8881f673acc0
FS:  0000000000000000(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f89395c0c98 CR3: 00000001405e6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wdm_rxwork+0xf3/0x200 drivers/usb/class/cdc-wdm.c:989
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
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
