Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1782F79D049
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjILLom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjILLod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:44:33 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CAC10D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:44:29 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68fbbe8a6d3so2622605b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694519068; x=1695123868;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2s6exGvB2Piv0KrKSJZaXRDgDGVfFGEJ2bzktsVpl0=;
        b=cu2/+f00UP0g57eh9dhmN+lRq8r8sBM1G8YXAxVCOh3oUtUVsSOPLdDn0FP6LJuvsA
         8mawUviQ0ibgH96HN+znzYHXJRjDnGuVHyDsSdbnszz6XIAGjkF1m0bk+KpM1WtICjo9
         Uqkz6PuKweR9wDShFHAmL4ytsqgoMbY08Wyjxh6g/4BOHSR0jTDgu48VL71rOywLF95J
         Yuyf+6t0sLB92IjWbPSqqyrIL1AEoUq6Hxt7S0rf3N5s17kUwsWdExn0ODWEh8HwFeEO
         lBBcf8Q/6tf3yG6KqOOn8DD6S+CBX7Axf4MG4WN5mpc1Hs5/fUNWSWYdOFa1vaC4AyM+
         eYUg==
X-Gm-Message-State: AOJu0Yzhlnhl5E6u4Tw1TcmOvXm7EwirApQ9JjN9qkLdXPoCJtnGs+HK
        xjobY/kzk0IsXvvBqDqIh/5MoisahmTLvp1VpqBCjhPpMwQp
X-Google-Smtp-Source: AGHT+IHD0Iipr7ZBDJJ3fVW0ulIX6DJ3ERVgLsaCkX7Ju67GIX9sNltoTNHGQK5OqeDHqEb56E+BIc6tFj3lXTUEFmFszdb7TqZM
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1a8b:b0:68c:6a:aa65 with SMTP id
 e11-20020a056a001a8b00b0068c006aaa65mr1019415pfv.0.1694519068568; Tue, 12 Sep
 2023 04:44:28 -0700 (PDT)
Date:   Tue, 12 Sep 2023 04:44:28 -0700
In-Reply-To: <20230912112004.6546-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025b5c6060527f716@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
From:   syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad page map

BUG: Bad page map in process syz-executor.0  pte:fffff99a98120 pmd:1fbee067
page:ffffea00019959c0 refcount:9 mapcount:-1 mapping:ffff88807736c9d0 index:0x3 pfn:0x66567
head:ffffea0001995900 order:2 entire_mapcount:0 nr_pages_mapped:8388607 pincount:0
memcg:ffff88802112c000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001995901 dead000000000122 dead000000000400
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea0001c1b9c8 ffff888020f3a030 ffff88807736c9d0
head: 0000000000000000 ffff8880146f3b80 00000009ffffffff ffff88802112c000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5463, tgid 5461 (syz-executor.0), ts 75822700865, free_ts 14932935563
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:976
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3291
 __xfs_filemap_fault+0x286/0x960 fs/xfs/xfs_file.c:1354
 __do_fault+0x133/0x4e0 mm/memory.c:4204
 do_read_fault mm/memory.c:4568 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x48d2/0x6200 mm/memory.c:5284
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x6bd/0x15e0 mm/gup.c:1239
 __get_user_pages_locked mm/gup.c:1504 [inline]
 get_dump_page+0x146/0x2b0 mm/gup.c:2018
 dump_user_range+0x126/0x910 fs/coredump.c:913
 elf_core_dump+0x3b75/0x4490 fs/binfmt_elf.c:2142
 do_coredump+0x1b73/0x2ab0 fs/coredump.c:764
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6342
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020006000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff88807736c9d0 index:5
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 1 PID: 5463 Comm: syz-executor.0 Not tainted 6.6.0-rc1-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_bad_pte+0x581/0x5c0 mm/memory.c:535
 zap_pte_range mm/memory.c:1458 [inline]
 zap_pmd_range mm/memory.c:1573 [inline]
 zap_pud_range mm/memory.c:1602 [inline]
 zap_p4d_range mm/memory.c:1623 [inline]
 unmap_page_range+0x1a76/0x3300 mm/memory.c:1644
 unmap_vmas+0x209/0x3a0 mm/memory.c:1731
 exit_mmap+0x297/0xc50 mm/mmap.c:3210
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x612/0x2290 kernel/exit.c:861
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a06c7cae9
Code: Unable to access opcode bytes at 0x7f3a06c7cabf.
RSP: 002b:00007f3a07a010c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 00007f3a06d9bf80 RCX: 00007f3a06c7cae9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 00007f3a06cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3a06d9bf80 R15: 00007fffc30ea648
 </TASK>
BUG: Bad page map in process syz-executor.0  pte:fffff99a99120 pmd:1fbee067
page:ffffea0001995980 refcount:9 mapcount:-1 mapping:ffff88807736c9d0 index:0x2 pfn:0x66566
head:ffffea0001995900 order:2 entire_mapcount:0 nr_pages_mapped:8388606 pincount:0
memcg:ffff88802112c000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001995901 ffffea0001995990 ffffea0001995990
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea0001c1b9c8 ffff888020f3a030 ffff88807736c9d0
head: 0000000000000000 ffff8880146f3b80 00000009ffffffff ffff88802112c000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5463, tgid 5461 (syz-executor.0), ts 75822700865, free_ts 14932929861
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:976
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3291
 __xfs_filemap_fault+0x286/0x960 fs/xfs/xfs_file.c:1354
 __do_fault+0x133/0x4e0 mm/memory.c:4204
 do_read_fault mm/memory.c:4568 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x48d2/0x6200 mm/memory.c:5284
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x6bd/0x15e0 mm/gup.c:1239
 __get_user_pages_locked mm/gup.c:1504 [inline]
 get_dump_page+0x146/0x2b0 mm/gup.c:2018
 dump_user_range+0x126/0x910 fs/coredump.c:913
 elf_core_dump+0x3b75/0x4490 fs/binfmt_elf.c:2142
 do_coredump+0x1b73/0x2ab0 fs/coredump.c:764
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6342
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020007000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff88807736c9d0 index:6
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 1 PID: 5463 Comm: syz-executor.0 Tainted: G    B              6.6.0-rc1-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_bad_pte+0x581/0x5c0 mm/memory.c:535
 zap_pte_range mm/memory.c:1458 [inline]
 zap_pmd_range mm/memory.c:1573 [inline]
 zap_pud_range mm/memory.c:1602 [inline]
 zap_p4d_range mm/memory.c:1623 [inline]
 unmap_page_range+0x1a76/0x3300 mm/memory.c:1644
 unmap_vmas+0x209/0x3a0 mm/memory.c:1731
 exit_mmap+0x297/0xc50 mm/mmap.c:3210
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x612/0x2290 kernel/exit.c:861
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a06c7cae9
Code: Unable to access opcode bytes at 0x7f3a06c7cabf.
RSP: 002b:00007f3a07a010c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 00007f3a06d9bf80 RCX: 00007f3a06c7cae9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 00007f3a06cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3a06d9bf80 R15: 00007fffc30ea648
 </TASK>
BUG: Bad page map in process syz-executor.0  pte:fffff99a9a120 pmd:1fbee067
page:ffffea0001995940 refcount:9 mapcount:-1 mapping:ffff88807736c9d0 index:0x1 pfn:0x66565
head:ffffea0001995900 order:2 entire_mapcount:0 nr_pages_mapped:8388605 pincount:0
memcg:ffff88802112c000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000202 ffffea0001995901 dead000000000122 fffffffdffffffff
raw: 0000000400000000 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea0001c1b9c8 ffff888020f3a030 ffff88807736c9d0
head: 0000000000000000 ffff8880146f3b80 00000009ffffffff ffff88802112c000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5463, tgid 5461 (syz-executor.0), ts 75822700865, free_ts 14932924004
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:976
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3291
 __xfs_filemap_fault+0x286/0x960 fs/xfs/xfs_file.c:1354
 __do_fault+0x133/0x4e0 mm/memory.c:4204
 do_read_fault mm/memory.c:4568 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x48d2/0x6200 mm/memory.c:5284
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x6bd/0x15e0 mm/gup.c:1239
 __get_user_pages_locked mm/gup.c:1504 [inline]
 get_dump_page+0x146/0x2b0 mm/gup.c:2018
 dump_user_range+0x126/0x910 fs/coredump.c:913
 elf_core_dump+0x3b75/0x4490 fs/binfmt_elf.c:2142
 do_coredump+0x1b73/0x2ab0 fs/coredump.c:764
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6342
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020008000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff88807736c9d0 index:7
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 1 PID: 5463 Comm: syz-executor.0 Tainted: G    B              6.6.0-rc1-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_bad_pte+0x581/0x5c0 mm/memory.c:535
 zap_pte_range mm/memory.c:1458 [inline]
 zap_pmd_range mm/memory.c:1573 [inline]
 zap_pud_range mm/memory.c:1602 [inline]
 zap_p4d_range mm/memory.c:1623 [inline]
 unmap_page_range+0x1a76/0x3300 mm/memory.c:1644
 unmap_vmas+0x209/0x3a0 mm/memory.c:1731
 exit_mmap+0x297/0xc50 mm/mmap.c:3210
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x612/0x2290 kernel/exit.c:861
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a06c7cae9
Code: Unable to access opcode bytes at 0x7f3a06c7cabf.
RSP: 002b:00007f3a07a010c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 00007f3a06d9bf80 RCX: 00007f3a06c7cae9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 00007f3a06cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3a06d9bf80 R15: 00007fffc30ea648
 </TASK>


Tested on:

commit:         0bb80ecc Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cb00e8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f2a37749f07ab2
dashboard link: https://syzkaller.appspot.com/bug?extid=55cc72f8cc3a549119df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12510d08680000

