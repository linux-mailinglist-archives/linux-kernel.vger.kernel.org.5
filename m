Return-Path: <linux-kernel+bounces-27243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DD82ECA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278291C22FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A813AC4;
	Tue, 16 Jan 2024 10:18:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE841134DB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3618e0060d1so1381955ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705400283; x=1706005083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ5fg7wJP5yE7vjjp+45FVa4xlojHSf9ZckRRaGQ5Sg=;
        b=aal5kg6jCZy2c7qoxa+QLyVO8Wcy7591xaUfYTJpwXGzKDECLG2aln/1Iu1OHLKdGT
         TYJmIlmPqiSw260EIq+nyYuOZQvWftFnsEfOsNGEKdvry350BPdn2xx6ARl0ZLgRLTg4
         nnosVzAeArFl0EalPmpWDzl4R3nw7x27W7NnvS4NvCEeGbfAMhcmFCb2V92WshwIjPsD
         SUj76oZex/BRvRltkBvkhLdEDT1SVSBaGZ/LCLIMGQ/oZSmXbNMtwLxn/PvQ1wIzwYVJ
         ALqnar1nh2KcsLtVOZa4cntTKzGpmi/1FhfGVy0+dI2ahHY5hxjvWc+mLdEv7V5Z2Pxj
         pwjg==
X-Gm-Message-State: AOJu0YwnPfB6FSUAOhhsgfjE/jqZ7AazFA2Ed1/MYcNW0AC8LQuiQ6Iz
	UmVIKqqlqIKuyt5Pr3KT+jTbYPzzakVkltJE9a+QmCE9uqfd
X-Google-Smtp-Source: AGHT+IG4YeHbckWdBfuR6ywaBm2BXSqhYtOTFeZWG5hH/zwDYgU5WHuuk3b1CKnRWsrPo+C0RlJg1sdYl+mJsLeEO2LxUiPsME0T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:360:fa:2c2c with SMTP id
 5-20020a056e0216c500b0036000fa2c2cmr1022650ilx.6.1705400282918; Tue, 16 Jan
 2024 02:18:02 -0800 (PST)
Date: Tue, 16 Jan 2024 02:18:02 -0800
In-Reply-To: <tencent_60371697EC37444A2C756B77D567103CA109@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001036b6060f0d7240@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
From: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in dsa_user_changeupper

==================================================================
BUG: KASAN: slab-out-of-bounds in dsa_user_to_port net/dsa/user.h:58 [inline]
BUG: KASAN: slab-out-of-bounds in dsa_user_changeupper+0x3d/0x570 net/dsa/user.c:2809
Read of size 8 at addr ffff8880708e2c90 by task syz-executor.0/5471

CPU: 0 PID: 5471 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-04629-g3e7aeb78ab01-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x170 mm/kasan/report.c:601
 dsa_user_to_port net/dsa/user.h:58 [inline]
 dsa_user_changeupper+0x3d/0x570 net/dsa/user.c:2809
 dsa_user_netdevice_event+0x47f/0x2ab0 net/dsa/user.c:3347
 notifier_call_chain+0x18c/0x3b0 kernel/notifier.c:93
 __netdev_upper_dev_link+0x4bf/0x670 net/core/dev.c:7759
 netdev_upper_dev_link+0x9e/0xe0 net/core/dev.c:7800
 macvlan_common_newlink+0x11c9/0x1930 drivers/net/macvlan.c:1539
 macvtap_newlink+0x154/0x1d0 drivers/net/macvtap.c:108
 rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1584/0x2080 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x882/0x1030 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8eab87cd29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8eac6310c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8eab9abf80 RCX: 00007f8eab87cd29
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000005
RBP: 00007f8eab8c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8eab9abf80 R15: 00007ffe246ecc68
 </TASK>

Allocated by task 5399:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc_node+0x24e/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x72/0x180 mm/util.c:617
 kvmalloc include/linux/slab.h:728 [inline]
 kvzalloc include/linux/slab.h:736 [inline]
 alloc_netdev_mqs+0x9d/0xf80 net/core/dev.c:10826
 rtnl_create_link+0x2ea/0xc10 net/core/rtnetlink.c:3379
 rtnl_newlink_create net/core/rtnetlink.c:3505 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x141e/0x2080 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x882/0x1030 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x440/0x600 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0xf0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff8880708e2000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3216 bytes inside of
 allocated 3223-byte region [ffff8880708e2000, ffff8880708e2c97)

The buggy address belongs to the physical page:
page:ffffea0001c23800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x708e0
head:ffffea0001c23800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802b2be101
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c4f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff88802b2be101
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5399, tgid 5399 (syz-executor.0), ts 75743044831, free_ts 67319580511
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13d0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node_track_caller+0x2cd/0x4e0 mm/slub.c:4001
 kmemdup+0x2a/0x60 mm/util.c:131
 __addrconf_sysctl_register+0xb1/0x3f0 net/ipv6/addrconf.c:7129
 addrconf_sysctl_register+0x167/0x1c0 net/ipv6/addrconf.c:7195
 ipv6_add_dev+0xd60/0x1290 net/ipv6/addrconf.c:453
 addrconf_notify+0x6a7/0x1010 net/ipv6/addrconf.c:3593
 notifier_call_chain+0x18c/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 register_netdevice+0x150c/0x19b0 net/core/dev.c:10294
 team_newlink+0x10a/0x170 drivers/net/team/team.c:2217
 rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1584/0x2080 net/core/rtnetlink.c:3748
page last free pid 5255 tgid 5255 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x959/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:234 [inline]
 pipe_read+0x6ee/0x13e0 fs/pipe.c:354
 call_read_iter include/linux/fs.h:2079 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x662/0x900 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff8880708e2b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880708e2c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880708e2c80: 00 00 07 fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff8880708e2d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880708e2d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         3e7aeb78 Merge tag 'net-next-6.8' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1647ebf5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e557b1c0a57d2c0
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec955e36bb239bd720f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157e3c2be80000


