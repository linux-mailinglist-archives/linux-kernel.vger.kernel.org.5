Return-Path: <linux-kernel+bounces-13818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B288212E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C411C21A19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 03:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD7DA4F;
	Mon,  1 Jan 2024 03:07:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011C7F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fedd5e6beso69714435ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 19:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704078424; x=1704683224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw35tYwONLgZqbqw4wi1+dVSu/2XDy+iD7y4RKCqUS0=;
        b=pWneqJ8WFhiNbiOAKBG5ha0I0bdtqLqJoGG7AHHf7+bREWnsD8O8KAzgUWKNJErjkR
         sxsOVXm8FxzVk7ViVa9SVcGQHdkisiU0V7qmlTPOpR/01QCXKLWS/QDTzVngIfLDiSJL
         zn9z2DM/+dkB5fLg8PGNfO3FVW95Qk7Y2YIOg+MGV3tBcgCznd7CuJurBw0pTRiqIhFA
         GV5VksPqztb4hlzQPOiG5m2l6f0Z2uX4s5A9ViXX1Mo1ceY++ONM6A1OEqpgx25XG279
         Y9vY5wB/0pWWBY8Qyp4P+hTfm8km3AiG3w260W8IZZIccUHeqvfgP5Dae616IGj7K+Z5
         +4cw==
X-Gm-Message-State: AOJu0YztpRdW0T/LP5RmsiqzeQ75XbFJOnhPt7Qr/TKotaNv/2U1mjLH
	/YFa1jo9WN3yOhWU0ywQ6xSdAYcP91lXQMUrkgrtwpdAdF4b
X-Google-Smtp-Source: AGHT+IGrYYmuaweWz1RKz37Lzjw15vhx74NAAL9eIRFPRHp4E1+/+xhhnihd+99hcGkdjMEoxne3E+qUrMgKYRjoEWqFF1tZqs2l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:35f:eae9:3f26 with SMTP id
 y5-20020a056e02178500b0035feae93f26mr2001600ilu.1.1704078424661; Sun, 31 Dec
 2023 19:07:04 -0800 (PST)
Date: Sun, 31 Dec 2023 19:07:04 -0800
In-Reply-To: <tencent_1C4C8CE7D046CC52DC0664498C6ED52EDB06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002be800060dd9ad75@google.com>
Subject: Re: [syzbot] [dri?] [media?] memory leak in get_sg_table
From: syzbot <syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in get_sg_table

2024/01/01 02:58:28 executed programs: 1
BUG: memory leak
unreferenced object 0xffff88811b080600 (size 16):
  comm "syz-executor.0", pid 5492, jiffies 4294944266 (age 13.620s)
  hex dump (first 16 bytes):
    80 22 25 1b 81 88 ff ff 04 00 00 00 04 00 00 00  ."%.............
  backtrace:
    [<ffffffff816346ed>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816346ed>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816346ed>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816346ed>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157f315>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff82cfd82a>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82cfd82a>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82cfd82a>] get_sg_table.isra.0+0x2a/0xe0 drivers/dma-buf/udmabuf.c:93
    [<ffffffff82cfd986>] begin_cpu_udmabuf+0x76/0xb0 drivers/dma-buf/udmabuf.c:157
    [<ffffffff82cf114b>] dma_buf_begin_cpu_access+0x3b/0xc0 drivers/dma-buf/dma-buf.c:1405
    [<ffffffff82cf1bd4>] dma_buf_ioctl+0x394/0x690 drivers/dma-buf/dma-buf.c:477
    [<ffffffff816bf4a2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816bf4a2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816bf4a2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816bf4a2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b71e2f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88811b252280 (size 128):
  comm "syz-executor.0", pid 5492, jiffies 4294944266 (age 13.620s)
  hex dump (first 32 bytes):
    00 b1 52 04 00 ea ff ff 00 00 00 00 00 10 00 00  ..R.............
    00 40 ac 14 01 00 00 00 00 10 00 00 00 00 00 00  .@..............
  backtrace:
    [<ffffffff816346ed>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816346ed>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816346ed>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816346ed>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157f9bb>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157f9bb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1020
    [<ffffffff8251661f>] kmalloc_array include/linux/slab.h:637 [inline]
    [<ffffffff8251661f>] sg_kmalloc lib/scatterlist.c:167 [inline]
    [<ffffffff8251661f>] get_next_sg lib/scatterlist.c:402 [inline]
    [<ffffffff8251661f>] sg_alloc_append_table_from_pages+0x35f/0x770 lib/scatterlist.c:526
    [<ffffffff82516abc>] sg_alloc_table_from_pages_segment+0x8c/0x120 lib/scatterlist.c:586
    [<ffffffff82cfd85e>] sg_alloc_table_from_pages include/linux/scatterlist.h:477 [inline]
    [<ffffffff82cfd85e>] get_sg_table.isra.0+0x5e/0xe0 drivers/dma-buf/udmabuf.c:96
    [<ffffffff82cfd986>] begin_cpu_udmabuf+0x76/0xb0 drivers/dma-buf/udmabuf.c:157
    [<ffffffff82cf114b>] dma_buf_begin_cpu_access+0x3b/0xc0 drivers/dma-buf/dma-buf.c:1405
    [<ffffffff82cf1bd4>] dma_buf_ioctl+0x394/0x690 drivers/dma-buf/dma-buf.c:477
    [<ffffffff816bf4a2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816bf4a2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816bf4a2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816bf4a2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b71e2f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13cf2909e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81921f96ae24ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=9b4adfed366b14496e7e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14778665e80000


