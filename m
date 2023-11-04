Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC60F7E0E4D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjKDIHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:07:10 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF7CA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 01:07:08 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3f893e38aso4240845b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 01:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699085227; x=1699690027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=om+HePaQbxZa4c+Z18eG9gMoz0Wfaw7HHyr6KUw+My4=;
        b=RI4iOpbUnOxZLhbOlrLOSGtha1+cOgWPUlnhQhZZJpHPv6qIvhLi4rQTyLEkXW/kmR
         5P8TOVsw0k3fKLAs+bsxKpeV/J2O0+v6Lf9LXlodWe3l1BIdVMd8UnLcwMH6IY1Jqnt+
         D9hAoFA5Qbvpw0ga1dEeh9RjMZiYwVo9M4VdPBBqi9shT8qzXDSNcNU1bcaQ1YpvpOj8
         nlXog+mDIGVzZKlgbVtkkC/8eNX1Y0uIyPv61j7fj2GJxSKZDg3pwMJL1uY+qOlufpJe
         +SHUT8zG0s7rbUQFAeB/MmmYkLhzF3VixwGTtW5LAlWI6YawHLZ7tst+i+5hEU8INsnz
         0NNw==
X-Gm-Message-State: AOJu0YwDa6Uu5QUbO1QopRsm4nFxRmK2Y2aBJxpNJG51DcS6MVrGhFE3
        8j1vRqutStuGMR0ciYBe6w9V9wUF5Ri8iWxCDo3Rzqmx96hJ
X-Google-Smtp-Source: AGHT+IHcVkimi36kP6RLucTQpJvNwCn4d5Vw73QS/YlRbMjs7YuBtLH5aUsawko7sFW9H3sU8fWgA9DXx+Y/hsQ62p4gfewR542z
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1898:b0:3ad:f6ad:b9c8 with SMTP id
 bi24-20020a056808189800b003adf6adb9c8mr8742299oib.9.1699085227522; Sat, 04
 Nov 2023 01:07:07 -0700 (PDT)
Date:   Sat, 04 Nov 2023 01:07:07 -0700
In-Reply-To: <20231104074445.1237-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e018d06094f1ba1@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
From:   syzbot <syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: KASAN: panic_on_warn set ...

>ffff888020985500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888020985580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888020985600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
Kernel panic - not syncing: KASAN: panic_on_warn set ...
CPU: 0 PID: 2911 Comm: kworker/u4:13 Not tainted 6.6.0-syzkaller-14142-g90b0c2b2edd1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: usbip_event event_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 panic+0x349/0x850 kernel/panic.c:344
 check_panic_on_warn+0x82/0xa0 kernel/panic.c:237
 end_report+0x6e/0x130 mm/kasan/report.c:225
 kasan_report+0x153/0x170 mm/kasan/report.c:590
 pickup_urb_and_free_priv+0x282/0x370 drivers/usb/usbip/vhci_rx.c:24
 vhci_cleanup_unlink_list+0x12d/0x490 drivers/usb/usbip/vhci_hcd.c:966
 vhci_device_unlink_cleanup drivers/usb/usbip/vhci_hcd.c:1000 [inline]
 vhci_shutdown_connection+0x203/0x4a0 drivers/usb/usbip/vhci_hcd.c:1037
 event_handler+0x24e/0x4b0 drivers/usb/usbip/usbip_event.c:79
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         90b0c2b2 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11d567f3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c49eeb680000

