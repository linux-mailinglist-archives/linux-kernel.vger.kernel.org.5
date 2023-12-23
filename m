Return-Path: <linux-kernel+bounces-10582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFA281D678
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CE41F21B20
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA215EB7;
	Sat, 23 Dec 2023 20:29:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BF15E93
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fcbe27a7fso30786265ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 12:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703363347; x=1703968147;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8m1vRq9zfD8BvfvvHcYl2day4DWKjP9aPut3yCM5eE=;
        b=BDj+zOstHimsMmnOyljUud20ZTSYs1b0a8hu6o3xbEstTevAjb040WBeKYIXVtFZRv
         zASlrJ+5G+4vCp49SKENUFUT4DXMRCMaAWCpXlAUUBr8AO4cJ2qN/TFIOVNS2onLd0j2
         MiCP71mP2Ep9u+RxpQfUH4wBnJ+yaMTid/gPTVNEE/axDSxCXaUZL371CfzRJ21Xm2RL
         SB3ntNNmmMyfRUZBph5FcPXYIupUGH1de2Tc8cYdem+8Ntbj/L9rJyYOVz6+9LGZjhlm
         JOkvMnwqXYmJ9bshJqS/fg3Op5eyBMIa8VQmdylJ9+/rmmfIY2ohngDCdUY8KYQ7PWzO
         szLw==
X-Gm-Message-State: AOJu0Yw8pMzfeR/zM8uybKJ94Sa0sShNnRL6O0pACvu7hzcu0tuZYU58
	4aN8oMUirjwRCGjuz5Z5IaUwiqnetAub1yA8m+AmCrTTJNhg
X-Google-Smtp-Source: AGHT+IFq/wn8YULdyVr0z44+UUFTH2BCwK/4fmygLdrjwRJ3WfJnfPlHvhxtiBg9p49XwCCG7PT4sVs2JMaCZfXUj85GMejFqf8J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d18:b0:35f:f01e:bb32 with SMTP id
 i24-20020a056e021d1800b0035ff01ebb32mr105094ila.4.1703363347258; Sat, 23 Dec
 2023 12:29:07 -0800 (PST)
Date: Sat, 23 Dec 2023 12:29:07 -0800
In-Reply-To: <20231223195641.29000-1-tintinm2017@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ca6b6060d332f49@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
From: syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
To: jikos@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in usbhid_parse

usb 1-1: string descriptor 0 read error: -22
usb 1-1: New USB device found, idVendor=080e, idProduct=4eb9, bcdDevice=d7.f6
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
================================================================================
UBSAN: array-index-out-of-bounds in drivers/hid/usbhid/hid-core.c:1026:18
index 1 is out of range for type 'hid_class_descriptor [1]'
CPU: 0 PID: 5070 Comm: kworker/0:5 Not tainted 6.7.0-rc6-syzkaller-00248-g5254c0cbc92d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 usbhid_parse+0x99d/0xa10 drivers/hid/usbhid/hid-core.c:1026
 hid_add_device+0x189/0xa60 drivers/hid/hid-core.c:2790
 usbhid_probe+0xd0a/0x1360 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
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
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_new_device+0xd80/0x19f0 drivers/usb/core/hub.c:2576
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2dac/0x4e10 drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
================================================================================


Tested on:

commit:         5254c0cb Merge tag 'block-6.7-2023-12-22' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14446681e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c68d9298a873f9e
dashboard link: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13af6e26e80000


