Return-Path: <linux-kernel+bounces-4893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE481836A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F68BB24385
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06711C96;
	Tue, 19 Dec 2023 08:35:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5E1172A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7ac24cef5so403774639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974909; x=1703579709;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSVL8QDIUac2OHhlf5opsGRO6P8IJbftbVT+XkeQvJU=;
        b=p0dxn339lGyZAq/IgfQrMkwXUmyGXE2CcUs0DMQxh2vTK40cwInSjYBF3r57WLI7hl
         r2Bqu0k1cD/D+lIxaCgzTPNavpXrZiW6AiAVq3qSs3SHwbWS/fLqZPmVgcVN3k5jC2dd
         vem8oZgXxVnf3aQBUUXY9rfVNcmEAGZ0aMWIpUAg8JN/fvGuPedd+I5LwF7uPpa7jVtF
         8uVYoVesGmyc4fxJxE8PhBxpnNg3OTGckBdZp8gbhEuU59+MEfOJPJDUZh9s1qsUKYn7
         EFkOxauTiWFsJZwlKnH0YgmMNyTpV4TzP3H0DC4tA2qmBHy93/8uNkDPrfyvSjPiPO7A
         xm2g==
X-Gm-Message-State: AOJu0YwFYYtqEumzE8NK+SkIfer9z51sAmSiY2k4Ww+QX9Gf1Cdn9a7e
	4iuDEjPAybeGmd666AGKTnNbvZd4nJuvAw8vLvrqf1lXcg2z
X-Google-Smtp-Source: AGHT+IE/0Y76tVNpO5kvNk2v4mmuOVqW5K35fsL7HKLrWz6Aiccv/PKIx+7lg5OeoBmI9poaKQur2/9RUPwJ5j+fqQgBhhCfqxwm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:238f:b0:46b:49e5:a22c with SMTP id
 q15-20020a056638238f00b0046b49e5a22cmr267858jat.1.1702974909424; Tue, 19 Dec
 2023 00:35:09 -0800 (PST)
Date: Tue, 19 Dec 2023 00:35:09 -0800
In-Reply-To: <tencent_9AECA6CDE47A4E6E702CA96FEC95B4EA3E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089ce25060cd8bee5@google.com>
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
BUG: KASAN: slab-out-of-bounds in btrfs_dev_replace_by_ioctl+0xb6/0x2010 fs/btrfs/dev-replace.c:735
Read of size 8 at addr ffff8880239268d8 by task syz-executor.0/5475

CPU: 1 PID: 5475 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 btrfs_dev_replace_by_ioctl+0xb6/0x2010 fs/btrfs/dev-replace.c:735
 btrfs_ioctl_dev_replace+0x2c9/0x390 fs/btrfs/ioctl.c:3299
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7ff58447cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff5852580c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff58459bf80 RCX: 00007ff58447cba9
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007ff5844c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff58459bf80 R15: 00007fff749803c8
 </TASK>

Allocated by task 5475:
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

The buggy address belongs to the object at ffff8880239268c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 7 bytes to the right of
 allocated 17-byte region [ffff8880239268c0, ffff8880239268d1)

The buggy address belongs to the physical page:
page:ffffea00008e4980 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23926
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41500 ffffea000099dd40 dead000000000002
raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 11104550106, free_ts 11081252843
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
 kvasprintf+0xdf/0x190 lib/kasprintf.c:25
 __kthread_create_on_node+0x1a9/0x3c0 kernel/kthread.c:444
 kthread_create_on_node+0xde/0x120 kernel/kthread.c:512
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1927 [inline]
 vivid_probe+0x5422/0x6fa0 drivers/media/test-drivers/vivid/vivid-core.c:2004
 platform_probe+0x135/0x1b0 drivers/base/platform.c:1404
 really_probe+0x294/0xc30 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:800
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x931/0xa60 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 mm_free_pgd kernel/fork.c:803 [inline]
 __mmdrop+0xb8/0x3d0 kernel/fork.c:919
 free_bprm+0x144/0x330 fs/exec.c:1490
 kernel_execve+0x8f7/0xa20 fs/exec.c:2024
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888023926780: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff888023926800: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>ffff888023926880: fb fb fb fb fc fc fc fc 00 00 01 fc fc fc fc fc
                                                    ^
 ffff888023926900: 00 00 03 fc fc fc fc fc 00 00 00 fc fc fc fc fc
 ffff888023926980: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12a3149ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12152276e80000


