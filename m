Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7163F7D6F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjJYOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbjJYNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:11:05 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF09131
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:11:02 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b3edaef525so8260793b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239461; x=1698844261;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+8APXn3PJFyQX7drqUxO6zXUVVoaXt2pwDy701mwL4=;
        b=FhaSGmbg8s0JxLwR+W276K5oWdVqmbsD0M9ZYcXlsDykK97xge6aBt8iC96gejF+zG
         yTYcAIirpmQ60bMMxuc+sxmhoZQ9cLuf5YZwOhSZWxJQiwBgrn4PvW/zZ+ICDukmT/PB
         D9pp48v87RZjTpmTIFImY8BtrwJibuWc0jr+nAnPqX3mlkiQ+ZBGh2r5d6A88v/Xl5t6
         00WjK2RfH4DLD6xtbGlUakJ/cAIDvOKeSMXFZL1vwAv96ECdCbCdhNOMXYl5e9E+Yc7d
         nX0HF2wLj52EXXBrfe0z8EKX8+YcGCyBOmqK8QKmkD52Oo6SYi26tKNohHeeeDi568Qr
         8qUQ==
X-Gm-Message-State: AOJu0Yy8RqK61Adt+jkAyaTtpSyiCZU8apwIQImoNgBJJ1X8LVNMuS8o
        7bRr/KNXWc0k9d6gjLLh8ERI8N2QTmtyQEtbCxGm2pcWCKXn
X-Google-Smtp-Source: AGHT+IESz/xp/Z/MK5u6ALeX1Gh665NwdxwexAMdq1wqndzTSTS8nmmrsMhbCLoXKTWH6SmTS63rdshLhpEUlkQAlIYr+XCoQKel
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3590:b0:3a7:3488:bc37 with SMTP id
 cp16-20020a056808359000b003a73488bc37mr5112516oib.9.1698239461333; Wed, 25
 Oct 2023 06:11:01 -0700 (PDT)
Date:   Wed, 25 Oct 2023 06:11:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d621b406088a2f55@google.com>
Subject: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_ioas_iova_ranges
From:   syzbot <syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com>
To:     iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
        kevin.tian@intel.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15013471680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
dashboard link: https://syzkaller.appspot.com/bug?extid=45f6cae2ca8c1f71e529
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/caa5c1eed3ec/disk-c3200081.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7990a3a9f71e/vmlinux-c3200081.xz
kernel image: https://storage.googleapis.com/syzbot-assets/015551ac9acc/bzImage-c3200081.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
Read of size 8 at addr ffff8880283c9068 by task syz-executor.2/30372

CPU: 1 PID: 30372 Comm: syz-executor.2 Not tainted 6.6.0-rc6-syzkaller-00244-gc3200081020d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
 iommufd_put_object drivers/iommu/iommufd/iommufd_private.h:149 [inline]
 iommufd_ioas_iova_ranges+0x5bc/0x6e0 drivers/iommu/iommufd/ioas.c:108
 iommufd_fops_ioctl+0x4c2/0x580 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5c74a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c7582b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5c74b9c120 RCX: 00007f5c74a7cae9
RDX: 00000000200000c0 RSI: 0000000000003b84 RDI: 0000000000000003
RBP: 00007f5c74ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5c74b9c120 R15: 00007fffc5056178
 </TASK>

Allocated by task 30371:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 _iommufd_object_alloc+0x26/0x1c0 drivers/iommu/iommufd/main.c:40
 iommufd_ioas_alloc drivers/iommu/iommufd/ioas.c:27 [inline]
 iommufd_ioas_alloc_ioctl+0xa9/0x300 drivers/iommu/iommufd/ioas.c:46
 iommufd_fops_ioctl+0x4c2/0x580 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 30368:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
 iommufd_destroy+0x31d/0x370 drivers/iommu/iommufd/main.c:216
 iommufd_fops_ioctl+0x4c2/0x580 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880283c9000
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 104 bytes inside of
 freed 1024-byte region [ffff8880283c9000, ffff8880283c9400)

The buggy address belongs to the physical page:
page:ffffea0000a0f200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x283c8
head:ffffea0000a0f200 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88807617ff01
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff88801284f280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffffff ffff88807617ff01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 27781, tgid 27767 (syz-executor.5), ts 2835959749777, free_ts 2828040563896
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 _iommufd_object_alloc+0x26/0x1c0 drivers/iommu/iommufd/main.c:40
 iommufd_ioas_alloc drivers/iommu/iommufd/ioas.c:27 [inline]
 iommufd_ioas_alloc_ioctl+0xa9/0x300 drivers/iommu/iommufd/ioas.c:46
 iommufd_fops_ioctl+0x4c2/0x580 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 __slab_free+0x2f6/0x390 mm/slub.c:3715
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x141/0x270 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x530 security/tomoyo/realpath.c:80
 tomoyo_path_perm+0x3ca/0x730 security/tomoyo/file.c:831
 tomoyo_path_symlink+0xde/0x120 security/tomoyo/tomoyo.c:211
 security_path_symlink+0xdd/0x130 security/security.c:1786
 do_symlinkat+0x136/0x3a0 fs/namei.c:4505
 __do_sys_symlinkat fs/namei.c:4523 [inline]
 __se_sys_symlinkat fs/namei.c:4520 [inline]
 __x64_sys_symlinkat+0x99/0xb0 fs/namei.c:4520
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80

Memory state around the buggy address:
 ffff8880283c8f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880283c8f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880283c9000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff8880283c9080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880283c9100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
