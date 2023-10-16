Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0EA7CB0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjJPRF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjJPRFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:05:13 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A91105
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:01:18 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6c0f174540cso6780790a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475678; x=1698080478;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AguIrS8FyQRIl/SV4QTd/CLsLIDTCPdYBXZP6uUmFLc=;
        b=ZeMXLroRsHjjwg5DIhDWcL3TOt9BYKp8lfZZNCoTzUIy5qjnPu6GDQuvSYz70QTuZr
         G/K/yg06DmgZeNlPAT+GNqnudMve8b2mqt8I5YZmCBV/U5pQeUI8yLyTTLJSL4wyljvT
         TXAbjRKrGs2Ecu8qIRLI9FQapcEdeBiQYDdzZeyteT34ECHdCEhE5RSV95ZUljycNm7z
         4EmYVIzIJsQZ9+OTZGrw6rRcOquZ0hT2ImgJ6vxQoU4oiGv6Q0BKP7+rysFPs9D3z6ih
         qp9eLmRwB5cOuJ+Mi9wOA0I9DJjYGc6Hsakem3flsY+atQGvTib0ufJlwn0dLCB4aYRO
         CrxQ==
X-Gm-Message-State: AOJu0YwKa4uGqem/QDsPcO771kVDa2EnR35wluaYQtbLabhehAH+4iE0
        t5Jexi7m8xz2ajdubJfagRN/iesTR67+HHn2bzVcz3s4Oa65
X-Google-Smtp-Source: AGHT+IGtY86A9Xv6zUryal+okMN00ia8K4jA+UWmDt3j6OvjnXQxaUQe5Xhj/du7JH0L6SyaGtqS1qV2zcdm3pRW3gUQitIeOcEY
MIME-Version: 1.0
X-Received: by 2002:a9d:6656:0:b0:6bc:e2b0:7446 with SMTP id
 q22-20020a9d6656000000b006bce2b07446mr10041434otm.1.1697475678381; Mon, 16
 Oct 2023 10:01:18 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:01:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d330500607d85a5f@google.com>
Subject: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
From:   syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    ad7f1baed071 Merge tag 'acpi-6.6-rc6' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1056d5c5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32d0b9b42ceb8b10
dashboard link: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1081f1e5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c7bc4d680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3074ad3ff92/disk-ad7f1bae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94b298a1e285/vmlinux-ad7f1bae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ad5cd9c2a48/bzImage-ad7f1bae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com

usb 1-1: string descriptor 0 read error: -22
usb 1-1: New USB device found, idVendor=080e, idProduct=4eb9, bcdDevice=d7.f6
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
================================================================================
UBSAN: array-index-out-of-bounds in drivers/hid/usbhid/hid-core.c:1024:18
index 1 is out of range for type 'hid_class_descriptor [1]'
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.0-rc5-syzkaller-00227-gad7f1baed071 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 usbhid_parse+0x94a/0xa20 drivers/hid/usbhid/hid-core.c:1024
 hid_add_device+0x189/0xa60 drivers/hid/hid-core.c:2783
 usbhid_probe+0xd0a/0x1360 drivers/hid/usbhid/hid-core.c:1429
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
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2daf/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
