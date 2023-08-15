Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612DE77C754
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjHOGC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbjHOGBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:01:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE74120
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:01:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b962535808so76927591fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692079307; x=1692684107;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pn6tXLFu/SE3Te48UGSux4r1tu5dbugdmKZavy0w+oI=;
        b=ZC8v18cg7kShGdfAOI6/q65g1GmB5xbNdiVHh/WvEeUfYcbUuUhZ1ZYeHWnavSD3BL
         p/I2M2jYrZMVjPfpg0segfcc3DHCi3LTSBkTnbfx5ErUOe62QjkGrTQackQXb0cAfMZ8
         hgJdJVvtWNlvzL9NRPJDjhcluPe+c6eQqmdfeyk046NvMqK9Q8iuSN4cd7hTLMvMa9W2
         AP73RYObpfcneWh3E8cU8P0ktjDZ3tFdeOvTXv5Ja8wwNxBWLV7gIPXCYVrq0ufyC99T
         W73o2xp+LGNsjBcY5FKbUWtjv8y203kBOFpiMSo9ZmdsWeiohEoPFvZt2RnjiGMrVM1Z
         6axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079307; x=1692684107;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pn6tXLFu/SE3Te48UGSux4r1tu5dbugdmKZavy0w+oI=;
        b=EP1Il6wh+jxatQalGZHv9Ik8jtH2zhCuaTdozVl+1cmd/tm4toywR4SqL8qE7Pb+Kc
         sWj86KCo46oMoa8RHR0AtTLfXhKey+OLLblEXZixldiBd+8xGfc/4sHqT4Rx4JPJSfcH
         0Xw3JGs61Dgp6ynJ5cu751qMYP9+34IpzLnDGlizHgEhXRVdRJPuwqAWj5j9qiXAdUgb
         Q3cDHuCyViK5qgHVAO6rBN82pGaDTcShbklww1JLLkdKHNuav+ABUs0z/Onzl0OKPXLH
         SnsYkwZVrhwLJsfEwyY4bYLK+ddl21DS8hjVB99c9RR8+kUKUeilvRU5M8xEcXzC4cZd
         r1hA==
X-Gm-Message-State: AOJu0YwcF96T6o2OmXoBMqtnML7aSQCA7jr/wAhDu3hP/67XI6XmkA6x
        +QS2i0ortzzDpDUiJzuWUA370hZhnI8b4VY6XiLxl6KJkVwKwRNdFkM=
X-Google-Smtp-Source: AGHT+IFs5+YX+GXS7hTCTpQPs4AcBKFE2DIWvnvdcOreT/fA8SeuTOcbNdIL6u17UBY2xw/I6WFYO7ys7jrV3O+Sm6w=
X-Received: by 2002:a05:651c:10e:b0:2b9:3523:6f20 with SMTP id
 a14-20020a05651c010e00b002b935236f20mr7844387ljb.51.1692079306464; Mon, 14
 Aug 2023 23:01:46 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Tue, 15 Aug 2023 14:01:34 +0800
Message-ID: <CALcu4rZbrym9ZbAMBzc=-JRjJr++jmSptiEOUJpE2udYu3nw8A@mail.gmail.com>
Subject: WARNING in input_mt_init_slots
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Latest Linux-6.5-rc6,  the following crash
was triggered.

HEAD commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421 (tag: v6.5-rc6=EF=BC=
=89
git tree: upstream

console output:
https://drive.google.com/file/d/1p6sC8jhTxlxT-anHvbhNJ-rihKofu0uy/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/1RP3sNB7CaYM2oxrf7v0Bp4j34XDt=
xHzZ/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1P3pPooAd9imQiZmFfpA3IpS40ppnC=
abP/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/1HzcnS72ho_yC8oh8Ax4nSRC6JfJ6hpaY/view?usp=
=3Ddrive_link


If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8390 at mm/page_alloc.c:4453
__alloc_pages+0x39e/0x490 mm/page_alloc.c:4453
Modules linked in:
CPU: 1 PID: 8390 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__alloc_pages+0x39e/0x490 mm/page_alloc.c:4453
Code: ff ff 00 0f 84 33 fe ff ff 80 ce 01 e9 2b fe ff ff 83 fe 0a 0f
86 3e fd ff ff 80 3d 39 b4 3a 0c 00 75 09 c6 05 30 b4 3a 0c 01 <0f> 0b
45 31 f6 e9 97 fe ff ff e8 43 59 a4 ff 84 c0 0f 85 8a fe ff
RSP: 0018:ffffc90004a1fbb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff92000943f77 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000014 RDI: 0000000000000000
RBP: 0000000000040dc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000002000001 R11: 0000000000000001 R12: 0000000000000014
R13: 0000000000000000 R14: 0000000000040dc0 R15: 0000000000000001
FS:  00007f0f55f7d640(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f54fc5b9c CR3: 000000010fc79000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x94/0x1d0 mm/slab_common.c:1126
 __do_kmalloc_node mm/slab_common.c:973 [inline]
 __kmalloc+0x100/0x190 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 input_mt_init_slots drivers/input/input-mt.c:50 [inline]
 input_mt_init_slots+0xd9/0x570 drivers/input/input-mt.c:39
 uinput_create_device drivers/input/misc/uinput.c:328 [inline]
 uinput_ioctl_handler.isra.0+0x16a2/0x1cf0 drivers/input/misc/uinput.c:904
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0f54e9442d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f55f7d048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0f54fcc0a0 RCX: 00007f0f54e9442d
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000006
RBP: 00007f0f54f014b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0f54f00b51
R13: 000000000000000b R14: 00007f0f54fcc0a0 R15: 00007f0f55f5d000
 </TASK>

Modules linked in:
CPU: 1 PID: 8390 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__alloc_pages+0x39e/0x490 mm/page_alloc.c:4453
Code: ff ff 00 0f 84 33 fe ff ff 80 ce 01 e9 2b fe ff ff 83 fe 0a 0f
86 3e fd ff ff 80 3d 39 b4 3a 0c 00 75 09 c6 05 30 b4 3a 0c 01 <0f> 0b
45 31 f6 e9 97 fe ff ff e8 43 59 a4 ff 84 c0 0f 85 8a fe ff
RSP: 0018:ffffc90004a1fbb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff92000943f77 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000014 RDI: 0000000000000000
RBP: 0000000000040dc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000002000001 R11: 0000000000000001 R12: 0000000000000014
R13: 0000000000000000 R14: 0000000000040dc0 R15: 0000000000000001
FS:  00007f0f55f7d640(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f54fc5b9c CR3: 000000010fc79000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x94/0x1d0 mm/slab_common.c:1126
 __do_kmalloc_node mm/slab_common.c:973 [inline]
 __kmalloc+0x100/0x190 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 input_mt_init_slots drivers/input/input-mt.c:50 [inline]
 input_mt_init_slots+0xd9/0x570 drivers/input/input-mt.c:39
 uinput_create_device drivers/input/misc/uinput.c:328 [inline]
 uinput_ioctl_handler.isra.0+0x16a2/0x1cf0 drivers/input/misc/uinput.c:904
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0f54e9442d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f55f7d048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0f54fcc0a0 RCX: 00007f0f54e9442d
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000006
RBP: 00007f0f54f014b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0f54f00b51
R13: 000000000000000b R14: 00007f0f54fcc0a0 R15: 00007f0f55f5d000
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 PID: 8390 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 panic+0x67e/0x730 kernel/panic.c:340
 check_panic_on_warn+0xad/0xb0 kernel/panic.c:236
 __warn+0xee/0x390 kernel/panic.c:673
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x2d9/0x500 lib/bug.c:219
 handle_bug+0x3c/0x70 arch/x86/kernel/traps.c:326
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:347
 asm_exc_invalid_op+0x16/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:__alloc_pages+0x39e/0x490 mm/page_alloc.c:4453
Code: ff ff 00 0f 84 33 fe ff ff 80 ce 01 e9 2b fe ff ff 83 fe 0a 0f
86 3e fd ff ff 80 3d 39 b4 3a 0c 00 75 09 c6 05 30 b4 3a 0c 01 <0f> 0b
45 31 f6 e9 97 fe ff ff e8 43 59 a4 ff 84 c0 0f 85 8a fe ff
RSP: 0018:ffffc90004a1fbb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff92000943f77 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000014 RDI: 0000000000000000
RBP: 0000000000040dc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000002000001 R11: 0000000000000001 R12: 0000000000000014
R13: 0000000000000000 R14: 0000000000040dc0 R15: 0000000000000001
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x94/0x1d0 mm/slab_common.c:1126
 __do_kmalloc_node mm/slab_common.c:973 [inline]
 __kmalloc+0x100/0x190 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 input_mt_init_slots drivers/input/input-mt.c:50 [inline]
 input_mt_init_slots+0xd9/0x570 drivers/input/input-mt.c:39
 uinput_create_device drivers/input/misc/uinput.c:328 [inline]
 uinput_ioctl_handler.isra.0+0x16a2/0x1cf0 drivers/input/misc/uinput.c:904
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x199/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0f54e9442d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f55f7d048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0f54fcc0a0 RCX: 00007f0f54e9442d
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000006
RBP: 00007f0f54f014b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0f54f00b51
R13: 000000000000000b R14: 00007f0f54fcc0a0 R15: 00007f0f55f5d000
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
