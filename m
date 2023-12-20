Return-Path: <linux-kernel+bounces-7039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24881A0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF1D1C22B34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A438DEA;
	Wed, 20 Dec 2023 14:11:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928F38DD6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35f97a33404so50731765ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703081464; x=1703686264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqAeFyMEEAWK9XV1MxoTJIM86NtgUnIH0j/PcYmHgE0=;
        b=sKiWXZ3Sx5QPv8eDDVgt+lQB/W7x4sxcYrwrxMKHeLPlU++R1zkNkuGkoFO/HtgItB
         Li6dck2idOJasJqfpCVHfvSDFhIiNcZYAjokKfG0lkVgOkF0Ms800fSb0FrPp7LCWfFd
         2p50k62iEoXrOHfVmfao6qtSRG4ElT5xyFYKWOAmD/Tumd6qEDtYRfZCkSYNKWx2kGyp
         LL9okYF+JSN43VOJUnT+ShWkSoCwxcDKGo7dPN3w6gluKnAanreEAg86eARnq+jiU2Gx
         ahN1H/CTJlzhv3M3Se+l+E3YDJPfWa6WwgvI1c3VMDYwdqm3x6VvRZ7C+1DoA0ENJPCa
         tKuA==
X-Gm-Message-State: AOJu0YzTkgnXu101asADlDrTxoD8Glpq7HfkWaSnP/UCXteTZnVu5VbY
	kKZMTcGh57E53zoTrMloc6eDHw/vS9n3qHS8CKDvUQbe4Olk
X-Google-Smtp-Source: AGHT+IFcrtYecHrKs1n1hs0kCXtNz2vgAvYQl+/Q8oOWpDfGrtVBBTe+/4egUdvG0smLj3Czr8oN0VYQiGLuoAdBz/v+/EU3ppey
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:35f:b16a:d0cb with SMTP id
 k15-20020a056e021a8f00b0035fb16ad0cbmr677873ilv.2.1703081464622; Wed, 20 Dec
 2023 06:11:04 -0800 (PST)
Date: Wed, 20 Dec 2023 06:11:04 -0800
In-Reply-To: <tencent_A10367297463BFC44CB76A577DE6C1737305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8f7ea060cf18df1@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in arc4_crypt

"syz-executor.0" (5486) uses obsolete ecb(arc4) skcipher
0, _skcipher_recvmsg
==================================================================
BUG: KASAN: slab-out-of-bounds in arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
Read of size 4 at addr ffff8880221f66e0 by task syz-executor.0/5486

CPU: 0 PID: 5486 Comm: syz-executor.0 Not tainted 6.7.0-rc5-next-20231215-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
 crypto_arc4_crypt+0x61/0x70 crypto/arc4.c:37
 crypto_lskcipher_crypt_sg+0x28c/0x460 crypto/lskcipher.c:229
 crypto_skcipher_decrypt+0xda/0x160 crypto/skcipher.c:692
 _skcipher_recvmsg crypto/algif_skcipher.c:204 [inline]
 skcipher_recvmsg+0xcd6/0x1100 crypto/algif_skcipher.c:226
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1066
 ____sys_recvmsg+0x21f/0x5c0 net/socket.c:2801
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2843
 __sys_recvmsg+0x114/0x1e0 net/socket.c:2873
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fa471e7cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa472b000c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007fa471f9bf80 RCX: 00007fa471e7cba9
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000004
RBP: 00007fa471ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa471f9bf80 R15: 00007ffec9ceddb8
 </TASK>

Allocated by task 78:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 ____kasan_kmalloc mm/kasan/common.c:375 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:384
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 mpls_add_dev net/mpls/af_mpls.c:1461 [inline]
 mpls_dev_notify+0x339/0xa00 net/mpls/af_mpls.c:1618
 notifier_call_chain+0xb6/0x3d0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x130 net/core/dev.c:1966
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 register_netdevice+0x16e2/0x1da0 net/core/dev.c:10288
 lowpan_newlink+0x30b/0x5c0 net/ieee802154/6lowpan/core.c:174
 rtnl_newlink_create net/core/rtnetlink.c:3521 [inline]
 __rtnl_newlink+0x118a/0x1940 net/core/rtnetlink.c:3741
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3754
 rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6566
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b4/0xd70 net/netlink/af_netlink.c:1909
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 __sys_sendto+0x225/0x310 net/socket.c:2189
 __do_sys_sendto net/socket.c:2201 [inline]
 __se_sys_sendto net/socket.c:2197 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2197
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a

Last potentially related work creation:
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1540
 prep_new_page mm/page_alloc.c:1547 [inline]
 get_page_from_freelist+0xa19/0x3740 mm/page_alloc.c:3355
 __alloc_pages+0x22e/0x2410 mm/page_alloc.c:4611
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:2191 [inline]
 allocate_slab mm/slub.c:2358 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2411
 ___slab_alloc+0x4ab/0x1990 mm/slub.c:3544
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3629
 __slab_alloc_node mm/slub.c:3682 [inline]
 slab_alloc_node mm/slub.c:3854 [inline]
 kmalloc_trace+0x2ff/0x330 mm/slub.c:4011
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 acpi_os_allocate_zeroed include/acpi/platform/aclinuxex.h:57 [inline]
 acpi_ut_evaluate_object+0x80/0x490 drivers/acpi/acpica/uteval.c:50
 acpi_ut_execute_CID+0x9a/0x780 drivers/acpi/acpica/utids.c:214
 acpi_ns_get_device_callback+0x2ee/0x510 drivers/acpi/acpica/nsxfeval.c:694
 acpi_ns_walk_namespace+0x3fe/0x5a0 drivers/acpi/acpica/nswalk.c:233
 acpi_get_devices+0x135/0x160 drivers/acpi/acpica/nsxfeval.c:805
 acpi_early_processor_control_setup+0x5a/0xb0 drivers/acpi/acpi_processor.c:601
 acpi_bus_init drivers/acpi/bus.c:1366 [inline]
 acpi_init+0x2c0/0xb70 drivers/acpi/bus.c:1430
 do_one_initcall+0x128/0x680 init/main.c:1236

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slub.c:3817 [inline]
 slab_alloc_node mm/slub.c:3864 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3871
 kmem_cache_zalloc include/linux/slab.h:701 [inline]
 acpi_os_acquire_object include/acpi/platform/aclinuxex.h:67 [inline]
 acpi_ns_create_node+0x68/0x100 drivers/acpi/acpica/nsalloc.c:35
 acpi_ns_search_and_enter+0x2ec/0x810 drivers/acpi/acpica/nssearch.c:373
 acpi_ns_lookup+0x71e/0xce0 drivers/acpi/acpica/nsaccess.c:589
 acpi_ds_create_buffer_field+0x2dc/0x610 drivers/acpi/acpica/dsfield.c:176
 acpi_ds_load2_end_op+0x5d8/0x1070 drivers/acpi/acpica/dswload2.c:475
 acpi_ds_exec_end_op+0xbb7/0x1460 drivers/acpi/acpica/dswexec.c:542
 acpi_ps_parse_loop+0x429/0x1ce0 drivers/acpi/acpica/psloop.c:525
 acpi_ps_parse_aml+0x3c1/0xca0 drivers/acpi/acpica/psparse.c:475
 acpi_ps_execute_table+0x37b/0x4c0 drivers/acpi/acpica/psxface.c:295
 acpi_ns_execute_table+0x3ee/0x550 drivers/acpi/acpica/nsparse.c:116
 acpi_ns_load_table+0x5b/0x130 drivers/acpi/acpica/nsload.c:71
 acpi_tb_load_namespace+0x435/0x700 drivers/acpi/acpica/tbxfload.c:186
 acpi_load_tables+0x2c/0x110 drivers/acpi/acpica/tbxfload.c:59
 acpi_bus_init drivers/acpi/bus.c:1321 [inline]
 acpi_init+0x123/0xb70 drivers/acpi/bus.c:1430
 do_one_initcall+0x128/0x680 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x692/0xc30 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff8880221f6000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 1024 bytes to the right of
 allocated 736-byte region [ffff8880221f6000, ffff8880221f62e0)

The buggy address belongs to the physical page:
page:ffffea0000887c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x221f0
head:ffffea0000887c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041dc0 ffffea0000a19000 0000000000000003
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 12, tgid 12 (kworker/u4:1), ts 88321977785, free_ts 88105026975
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1540
 prep_new_page mm/page_alloc.c:1547 [inline]
 get_page_from_freelist+0xa19/0x3740 mm/page_alloc.c:3355
 __alloc_pages+0x22e/0x2410 mm/page_alloc.c:4611
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:2191 [inline]
 allocate_slab mm/slub.c:2358 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2411
 ___slab_alloc+0x4ab/0x1990 mm/slub.c:3544
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3629
 __slab_alloc_node mm/slub.c:3682 [inline]
 slab_alloc_node mm/slub.c:3854 [inline]
 __do_kmalloc_node mm/slub.c:3984 [inline]
 __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:4005
 kmalloc_reserve+0xef/0x260 net/core/skbuff.c:582
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1298 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 inet6_rt_notify+0xf0/0x2b0 net/ipv6/route.c:6171
 fib6_del_route net/ipv6/ip6_fib.c:1999 [inline]
 fib6_del+0xfae/0x17a0 net/ipv6/ip6_fib.c:2034
 fib6_clean_node+0x41f/0x5b0 net/ipv6/ip6_fib.c:2196
 fib6_walk_continue+0x44c/0x8c0 net/ipv6/ip6_fib.c:2118
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2166
 fib6_clean_tree+0xd7/0x110 net/ipv6/ip6_fib.c:2246
page last free pid 5144 tgid 5144 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x51f/0xb10 mm/page_alloc.c:2390
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2530
 __put_partials+0x14c/0x160 mm/slub.c:2926
 qlink_free mm/kasan/quarantine.c:178 [inline]
 qlist_free_all+0xc1/0x1e0 mm/kasan/quarantine.c:194
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:301
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:306
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slub.c:3817 [inline]
 slab_alloc_node mm/slub.c:3864 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3871
 vm_area_alloc+0x1f/0x220 kernel/fork.c:463
 do_brk_flags+0x2e1/0x1e30 mm/mmap.c:3166
 __do_sys_brk+0x6ec/0xb40 mm/mmap.c:259
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a

Memory state around the buggy address:
 ffff8880221f6580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880221f6600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880221f6680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff8880221f6700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880221f6780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e6ec26e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d429d6e80000


