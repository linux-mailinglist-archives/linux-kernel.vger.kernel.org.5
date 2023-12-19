Return-Path: <linux-kernel+bounces-4814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528E81825F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4701C2373C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00EC1171C;
	Tue, 19 Dec 2023 07:38:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAC11710
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35d678edc08so26212145ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702971486; x=1703576286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBGzPu2+fy6h8DikoGtIgIOYxuCKl/zgXCD5m5syRr8=;
        b=rpVCzSlCvrJDcHsrWnYwYLSUlj/p50q6twyepPWaxZXVEp8shwLLf6pXc4ZD/Ni3TK
         QWLRxs1z6fzsRn74tUJ/H6FB46JFUheUI4PKxrB1jCYat59NE+pX8WzXjHZ2hc+UAbC2
         o5yu7b7lB4FO+KtfcnUu/Kd/DoP5gMDuwf+Skzd37gmyRQ7WQhxHZuRNWZqgHCvsDLip
         R2sBnvPGFBgyWcvR5R8kIpB1Up1YFRwsBrGHk6bGiUsgm4iKHtouC3uWFnHzKNWpzqTt
         4CU5JBgimh1JjlWZ9bsK59bKUvcFRx9oXSrnD9IC9AoYxurNfGE/VGvBl5aMYNWMQwdJ
         pdjA==
X-Gm-Message-State: AOJu0YzrcmOHfNSp6t1LwNbRbe/dibwM2E69IWgfMU0/6JIhGW764bG1
	Aj40cRSJz53hT2ItBk87ouf64dQsoGg9cvi9aiZq/LasFkhl
X-Google-Smtp-Source: AGHT+IEImPfuYRs7Z/gMdnI70ldBVEEUzpxKI7N2gtoqVDcHyhVeoO19kKiSBRZrrD3G4vGFgpsXL2QNu3DHTy0WUHJ8BmFF/hhm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d30e:0:b0:35f:ab18:74e9 with SMTP id
 x14-20020a92d30e000000b0035fab1874e9mr64237ila.2.1702971486106; Mon, 18 Dec
 2023 23:38:06 -0800 (PST)
Date: Mon, 18 Dec 2023 23:38:06 -0800
In-Reply-To: <tencent_B8D761176D66C51367E368496703B5045805@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dfde7060cd7f29d@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: stack-out-of-bounds Read in getname_kernel

BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
==================================================================
BUG: KASAN: stack-out-of-bounds in strlen+0x58/0x70 lib/string.c:418
Read of size 1 at addr ffffc9000519fe08 by task syz-executor.0/5479

CPU: 1 PID: 5479 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
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
 btrfs_ioctl_dev_replace+0x3c9/0x4a0 fs/btrfs/ioctl.c:3298
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f412127cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4121f980c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f412139bf80 RCX: 00007f412127cba9
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007f41212c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f412139bf80 R15: 00007ffcdd6baae8
 </TASK>

The buggy address belongs to stack of task syz-executor.0/5479
 and is located at offset 2632 in frame:
 btrfs_ioctl_dev_replace+0x0/0x4a0 fs/btrfs/ioctl.c:3931

This frame has 1 object:
 [32, 2632) 'p'

The buggy address belongs to the virtual mapping at
 [ffffc90005198000, ffffc900051a1000) created by:
 copy_process+0x5d1/0x3fb0 kernel/fork.c:2332

The buggy address belongs to the physical page:
page:ffffea00007149c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c527
memcg:ffff88801e905a82
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88801e905a82
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5449, tgid 5449 (dhcpcd-run-hook), ts 81588018886, free_ts 81585719939
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0x9a3/0x14a0 mm/vmalloc.c:3320
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct+0x3e5/0x7d0 kernel/fork.c:1118
 copy_process+0x5d1/0x3fb0 kernel/fork.c:2332
 kernel_clone+0x222/0x840 kernel/fork.c:2907
 __do_sys_clone kernel/fork.c:3050 [inline]
 __se_sys_clone kernel/fork.c:3034 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x931/0xa60 mm/page_alloc.c:2347
 free_unref_page_list+0x5a0/0x840 mm/page_alloc.c:2533
 release_pages+0x2117/0x2400 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu+0x34c/0x4e0 mm/mmu_gather.c:300
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:392
 exit_mmap+0x4d3/0xc60 mm/mmap.c:3321
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x9b7/0x2750 kernel/exit.c:858
 do_group_exit+0x206/0x2c0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffffc9000519fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000519fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000519fe00: 00 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3
                      ^
 ffffc9000519fe80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000519ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1753a73ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fde369e80000


