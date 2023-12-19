Return-Path: <linux-kernel+bounces-4688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6058781809F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784BC1C21B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86B882F;
	Tue, 19 Dec 2023 04:38:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0967881E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b738d08e3bso431686639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702960685; x=1703565485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHSx+aJ98uAkcc90IomzPQ5ggxHkvuwl8ycMLNClsMc=;
        b=if/oymksuOSozUL8w8n53qgldNnZpjnqG+4I3hXq5rU4bK4KFAnlmbiWnvl7vvccyz
         AFVX7XYuSW8n+uEz0Pd5fdkn6f0NiwL/kQ7V65mwUQprMlo4AMUWTmC73nTIDdyFiKDe
         tnhuFD9gwksPY0P1MUFiX9HDv8ElSwwOj09EqKpdxu444g0JDoaPBPnaYclNUWpzniQ0
         qnsCt7FFkmiok1CHsyQYO3BaYXm6RstR9jp3ZqSZb8qxuB34ZUDcb7wPS+qzGjALmlTV
         ONf+pYTwuo/EBY9UY0rX+Nm1bVtpyzXY48h6ist4oSNqIkF59VcrOZbWOevpqjFSPfOp
         7r1g==
X-Gm-Message-State: AOJu0YwhKFO+r0gCOFb0uyFNCgfG6zdhhYslRR0P+SLPEH9dbTkgvPob
	4zKr7RGrO3buoWkr516Va18JiJgMiOdcMCinHEa/vXRtwPl6
X-Google-Smtp-Source: AGHT+IFKDEAzHI/DhDw7QPolIfBTHwmQHLJzOp76NlPdm/Pdrtkg4ArImUDmhjWNFKUXg0NAsGCLFipHsNZtBIGAM8CRPUtEij+w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:35f:94cf:477e with SMTP id
 i18-20020a056e021d1200b0035f94cf477emr1008993ila.6.1702960684935; Mon, 18 Dec
 2023 20:38:04 -0800 (PST)
Date: Mon, 18 Dec 2023 20:38:04 -0800
In-Reply-To: <tencent_E536EA4ACA75D3778366B23C3D37A696CE09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b13057060cd56e7d@google.com>
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
Read of size 1 at addr ffff88807f73ea28 by task syz-executor.0/5483

CPU: 0 PID: 5483 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
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
RIP: 0033:0x7efc28c7cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc299370c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007efc28d9bf80 RCX: 00007efc28c7cba9
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007efc28cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efc28d9bf80 R15: 00007ffd45118af8
 </TASK>

Allocated by task 5483:
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

The buggy address belongs to the object at ffff88807f73e000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes to the right of
 allocated 2600-byte region [ffff88807f73e000, ffff88807f73ea28)

The buggy address belongs to the physical page:
page:ffffea0001fdce00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7f738
head:ffffea0001fdce00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5519, tgid 5519 (sed), ts 85994199611, free_ts 85914192085
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
 __kmalloc+0xa2/0x1a0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x730 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2153
 vfs_getattr+0x46/0x430 fs/stat.c:173
 vfs_fstat fs/stat.c:198 [inline]
 vfs_fstatat+0xd6/0x190 fs/stat.c:295
 __do_sys_newfstatat fs/stat.c:463 [inline]
 __se_sys_newfstatat fs/stat.c:457 [inline]
 __x64_sys_newfstatat+0x117/0x190 fs/stat.c:457
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x931/0xa60 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2116 [inline]
 __unfreeze_partials+0x1e0/0x220 mm/slub.c:2655
 put_cpu_partial+0x17b/0x250 mm/slub.c:2731
 __slab_free+0x2b6/0x390 mm/slub.c:3679
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x6c/0x3c0 mm/slab.h:763
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x1d0/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0xa2/0x1a0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x730 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2153
 vfs_getattr+0x46/0x430 fs/stat.c:173
 vfs_fstat fs/stat.c:198 [inline]
 vfs_fstatat+0xd6/0x190 fs/stat.c:295

Memory state around the buggy address:
 ffff88807f73e900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807f73e980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807f73ea00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff88807f73ea80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807f73eb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10530592e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145803e1e80000


