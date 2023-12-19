Return-Path: <linux-kernel+bounces-4641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7F818034
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3011C229F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66076BE6C;
	Tue, 19 Dec 2023 03:25:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8DBE56
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35facd4238bso31281815ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 19:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702956303; x=1703561103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eezWY16kFsZ4oJ2/bgGH9pxhHuNsAV4H1Nk2q4+68r4=;
        b=quYSCsDDnTamOxTx0zi6Tu5LevEJJcEHK6n/UGZXUFXbCWnmXLm1jYqXtKr9EH9gFX
         bs18nYQlCK9s6V6JmFcmmi12Fn2S4yNLcANNNc69RdqeU4FAJMLqA4+31IfyLnst3w/V
         SFdAJPZy9roDE9YJmJJJ1sTGZrfrlBFJnqFkhB4f36M3N38KvgtUiUF3KVkRLXHv+BQV
         pKsc9XBinKO3tg452BhWZCaqAUC8f9BvqFGYFe0pbCrKHEr9dwfSNw6Ze2vhVWm9WeMp
         Fat9RSqRkE3UDtV9DW8plH5dTYkIICtS4QvWM1QZxGicE9T3YkE3d2EdC8jSjPM+FEC/
         vc3A==
X-Gm-Message-State: AOJu0YyzR4pwjmAqznIHeMlM46TTWPZVh9fYOAGGiBUOLE59aXLBfHbt
	6QhhJCvKwONWI8inzw1rarrZZ6btZvHq4P6oJOliKxfT8+Gt
X-Google-Smtp-Source: AGHT+IGtXExUlC6Fd0ZVlxQwIwiHqQqyJ/ANnIsPdp0Yb8+JehbpTu+EQYJCuszidgXp/GwLK0XirJ/DvbgHPJMDFHL/2jbBKABd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338d:b0:35f:b2f8:6ca3 with SMTP id
 bn13-20020a056e02338d00b0035fb2f86ca3mr359146ilb.2.1702956303677; Mon, 18 Dec
 2023 19:25:03 -0800 (PST)
Date: Mon, 18 Dec 2023 19:25:03 -0800
In-Reply-To: <tencent_806DC02C6D6C049594E9A2ECAACE187B920A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c8118060cd4699e@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in getname_kernel

BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
==================================================================
BUG: KASAN: slab-out-of-bounds in strlen+0x58/0x70 lib/string.c:418
Read of size 1 at addr ffff88814b62aa28 by task syz-executor.0/5482

CPU: 0 PID: 5482 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 strlen+0x58/0x70 lib/string.c:418
 getname_kernel+0x1d/0x2e0 fs/namei.c:226
 kern_path+0x1d/0x50 fs/namei.c:2609
 lookup_bdev block/bdev.c:979 [inline]
 bdev_open_by_path+0xd1/0x540 block/bdev.c:901
 btrfs_init_dev_replace_tgtdev fs/btrfs/dev-replace.c:260 [inline]
 btrfs_dev_replace_start fs/btrfs/dev-replace.c:638 [inline]
 btrfs_dev_replace_by_ioctl+0x41b/0x2010 fs/btrfs/dev-replace.c:748
 btrfs_ioctl_dev_replace+0x2c9/0x390 fs/btrfs/ioctl.c:3299
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f617807cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6178dd40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f617819bf80 RCX: 00007f617807cba9
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007f61780c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f617819bf80 R15: 00007ffcbe283518
 </TASK>

Allocated by task 5482:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc_node_track_caller+0xb1/0x190 mm/slab_common.c:1027
 memdup_user+0x2b/0xc0 mm/util.c:197
 btrfs_ioctl_dev_replace+0xb8/0x390 fs/btrfs/ioctl.c:3286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88814b62a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes to the right of
 allocated 2600-byte region [ffff88814b62a000, ffff88814b62aa28)

The buggy address belongs to the physical page:
page:ffffea00052d8a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14b628
head:ffffea00052d8a00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000840(slab|head|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000840 ffff888012c42140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 12558368773, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 alloc_slab_page+0x6a/0x170 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc8a/0x1330 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x21d/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0xa0/0x190 mm/slab_common.c:1027
 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 ctrl_build_mcgrp_msg net/netlink/genetlink.c:1264 [inline]
 genl_ctrl_event+0x18e/0xc80 net/netlink/genetlink.c:1350
 genl_register_family+0x13df/0x17a0 net/netlink/genetlink.c:694
 handshake_init+0x2b/0xc0 net/handshake/netlink.c:255
 do_one_initcall+0x234/0x810 init/main.c:1236
 do_initcall_level+0x157/0x210 init/main.c:1298
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88814b62a900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88814b62a980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88814b62aa00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff88814b62aa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88814b62ab00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=123685aee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131d1876e80000


