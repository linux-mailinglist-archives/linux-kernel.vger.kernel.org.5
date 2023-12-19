Return-Path: <linux-kernel+bounces-4918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B128183D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4431C2399C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95919444;
	Tue, 19 Dec 2023 08:46:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7915AED
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7ce620dd9so348349939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975569; x=1703580369;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HP/HAeRSHRCyN+rzUH4bE5GcmZLApQK+3qc/EGCkhWc=;
        b=DBgD9k9fdyO0TnOqiBC2+Q344vhVTq691ncv3Zaa9q/ptKhlTajDMK11rma8jJxrjs
         J5RDuVlOODKB4xd8tru9w4scHvYT2+AD1JNc4gRR4sIGDvxO7iaLOWMk9S4XbbHH4E0X
         d/FmRGEeqFaQtUi8Ri8tzva9G1/vASFQNdnT88iJhLP1PKT95CsA0QZJ3eQUFA8d2C0J
         BI8vuyyonPfgxhBuJEyg9W8KcmymmfdBOcSEI4G7uKDozMcn9GwNxHuPpvTymlVnKR8I
         kGnzgJHaCiyWdT8NF6n0KKQzxZd+btdgphbDjKB+aykn0pNqLh+xkE3ITTATWCSaiLFA
         rIOg==
X-Gm-Message-State: AOJu0YwCIh4TjLX0Fv0ChoVims5ZLCl/xC+CxJV+Cs2pFsk4DUcVAkaj
	vewu97OlgZnHW0ekDx2rk3wQL++xcVnCE8S7K4GGICQ62Pjs
X-Google-Smtp-Source: AGHT+IHnEGM9QbF3dD69r5kaZy6QhE272B/RXS9JRyxqo9vpq1KQ3dBLrZNdB/kZsoXv0BLcdq4szO8j0GUuTYvD8q2GBcj3NwJJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56e:0:b0:35f:a839:9a6a with SMTP id
 b14-20020a92c56e000000b0035fa8399a6amr716566ilj.6.1702975569001; Tue, 19 Dec
 2023 00:46:09 -0800 (PST)
Date: Tue, 19 Dec 2023 00:46:08 -0800
In-Reply-To: <tencent_23960436F84A82754D76C767CE3C75373809@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da03bd060cd8e5ca@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in btrfs_dev_replace_by_ioctl

BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
==================================================================
BUG: KASAN: slab-out-of-bounds in btrfs_dev_replace_by_ioctl+0x1dc5/0x2010 fs/btrfs/dev-replace.c:744
Read of size 1 at addr ffff888021b2a421 by task syz-executor.0/5480

CPU: 1 PID: 5480 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 btrfs_dev_replace_by_ioctl+0x1dc5/0x2010 fs/btrfs/dev-replace.c:744
 btrfs_ioctl_dev_replace+0x2c9/0x390 fs/btrfs/ioctl.c:3299
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f695d67cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f695e45a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f695d79bf80 RCX: 00007f695d67cba9
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007f695d6c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f695d79bf80 R15: 00007ffe9e2e6458
 </TASK>

Allocated by task 5480:
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

The buggy address belongs to the object at ffff888021b2a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 15 bytes to the right of
 allocated 1042-byte region [ffff888021b2a000, ffff888021b2a412)

The buggy address belongs to the physical page:
page:ffffea000086ca00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21b28
head:ffffea000086ca00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4502, tgid 4502 (klogd), ts 85479727402, free_ts 85422702099
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
 kmalloc_trace+0x2a/0x60 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 syslog_print+0x121/0x9b0 kernel/printk/printk.c:1550
 do_syslog+0x505/0x890 kernel/printk/printk.c:1728
 __do_sys_syslog kernel/printk/printk.c:1820 [inline]
 __se_sys_syslog kernel/printk/printk.c:1818 [inline]
 __x64_sys_syslog+0x7c/0x90 kernel/printk/printk.c:1818
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
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
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x19e/0x2b0 mm/slub.c:3502
 alloc_reserved_tree_block fs/btrfs/extent-tree.c:4876 [inline]
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1765 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1799 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2064 [inline]
 __btrfs_run_delayed_refs+0x14af/0x46c0 fs/btrfs/extent-tree.c:2134
 btrfs_run_delayed_refs+0x188/0x2c0 fs/btrfs/extent-tree.c:2246
 commit_cowonly_roots+0x66b/0x860 fs/btrfs/transaction.c:1416
 btrfs_commit_transaction+0xff5/0x3740 fs/btrfs/transaction.c:2485
 btrfs_rebuild_free_space_tree+0x1de/0x370 fs/btrfs/free-space-tree.c:1344
 btrfs_start_pre_rw_mount+0xef3/0x1340 fs/btrfs/disk-io.c:2965

Memory state around the buggy address:
 ffff888021b2a300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888021b2a380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888021b2a400: 00 00 02 fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888021b2a480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888021b2a500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16b1a6c6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100aa8d6e80000


