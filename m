Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5980B493
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjLINct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjLIN3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:29:41 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE613A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:29:47 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso2414500b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702128586; x=1702733386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dWKuQq2AbicCLjiyrMK6M/PUWZ+Zju2MWVOzN3LqaYE=;
        b=YICrchE8ww7IRYSNshxG6hYvfb36ui66hp9qA2R1goPIQTypu9oLKJU9GV6UM+N4GC
         VhauqM59924Hqu/G5nqJeNJUtgfsDPu63PT9HlAF3yukPpMYZtrNz9oB/ACGDSoSyffa
         VKBrXXhTvQiyw9JNIx3GE5HnBl0EytavhzOwURhbs/58Hi5r0xAMPvRcv9VJi+LsNdmf
         cwtFTfLwMu5ftFo9yyGAxP5tWIcqJWPlDObMIwk3B/GEmFQt+glbbu+ELv9HEy/2eTaa
         JiCNsvgTgV4dESmtDZaZi9vmE+iRjuB0prw2g2Nynly+2PP2Ba35mSS7oyB3/lkTShmc
         Z/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702128586; x=1702733386;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWKuQq2AbicCLjiyrMK6M/PUWZ+Zju2MWVOzN3LqaYE=;
        b=hPX1senFlRWdIIp/o/ovApP27YaHdQ2L2kxVgH0jBBicfNpWOzczNMejFZJOLZeDSl
         kXVaibsBBHzzDLSf83cF+ZijixfAAgREhmv29vtsoXc5/Cx8i71i2rtZh8HgAHWGaXMp
         WYrXXIV2ulxTE3U6ioIT7a02rRkU8XcBEMVQNoueamZtZfgLmcgvChIJgjD5OT4DTpOu
         iZn5YcrUOBXQr7y0L+kax+K08KprH77JrmX6kx2BcjRpGx/oy6BiXlyswZDk73v4ODZs
         osTEmyZiKXR+9jhTMOdq+ojDlpVaccAbUamgkCVN0hSDm0punitA4kyDUg1hIRE+/v0D
         TImg==
X-Gm-Message-State: AOJu0Yz/KtOEMcO5Tv6J29/loctgNev7JBDMcU4GpAx5uTcup5S3qOad
        JCJaG2qKFZjZO4mVt4x2dPhbWHmYjhJotXk5/1M=
X-Google-Smtp-Source: AGHT+IFe8P00qCEbo8xXINYfPC+mOYLMzwdb8XDSCcN5pA/0ke1DpoFOJCmc6RhCq1P+zsiHX0s0/gih5JAFmAkI6pM=
X-Received: by 2002:a05:6a00:c85:b0:6ce:2731:a093 with SMTP id
 a5-20020a056a000c8500b006ce2731a093mr2097590pfv.66.1702128586460; Sat, 09 Dec
 2023 05:29:46 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Sat, 9 Dec 2023 21:29:35 +0800
Message-ID: <CABOYnLwbz-Es5A+aa28yv-ApQ-X8Dr0E8FzCpLWm-4Vt4DKS1Q@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
To:     syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com,
        syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com, hdanton@sina.com,
        johan.hedberg@gmail.com,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I reproduced both two bugs with relatively stable poc, hope it helps.
In my prograss, I meet three bugs titles are respectively

KASAN: slab-out-of-bounds Write in sco_sock_timeout
https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
KASAN: slab-use-after-free Write in sco_conn_del
https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
KASAN: wild-memory-access Read in lock_sock_nested may be new.

My reproducer can crash in the latest net tree HEAD:
1ae4cd3cbdd08287c56c4cc816ebf05eb6681a0f and also the latest upstream
mainline.
However, when I try to execute their reproducer, the crash seems the
same, this makes me very likely that they are maybe the same bug.

TITLE: KASAN: slab-use-after-free Write in sco_sock_timeout
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write
home/dubbo/net/./include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed
home/dubbo/net/./include/linux/atomic/atomic-instrumented.h:252
[inline]
BUG: KASAN: slab-use-after-free in __refcount_add
home/dubbo/net/./include/linux/refcount.h:193 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc
home/dubbo/net/./include/linux/refcount.h:250 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc
home/dubbo/net/./include/linux/refcount.h:267 [inline]
BUG: KASAN: slab-use-after-free in sock_hold
home/dubbo/net/./include/net/sock.h:777 [inline]
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x68/0x2b0
home/dubbo/net/net/bluetooth/sco.c:88
Write of size 4 at addr ffff888156922080 by task kworker/1:0/8390
CPU: 1 PID: 8390 Comm: kworker/1:0 Not tainted 6.7.0-rc4-00141-g1ae4cd3cbdd0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/4
Workqueue: events sco_sock_timeout
Call Trace:
 <TASK>
 __dump_stack home/dubbo/net/lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 home/dubbo/net/lib/dump_stack.c:106
 print_address_description home/dubbo/net/mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 home/dubbo/net/mm/kasan/report.c:475
 kasan_report+0xda/0x110 home/dubbo/net/mm/kasan/report.c:588
 check_region_inline home/dubbo/net/mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 home/dubbo/net/mm/kasan/generic.c:187
 instrument_atomic_read_write
home/dubbo/net/./include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed
home/dubbo/net/./include/linux/atomic/atomic-instrumented.h:252
[inline]
 __refcount_add home/dubbo/net/./include/linux/refcount.h:193 [inline]
 __refcount_inc home/dubbo/net/./include/linux/refcount.h:250 [inline]
 refcount_inc home/dubbo/net/./include/linux/refcount.h:267 [inline]
 sock_hold home/dubbo/net/./include/net/sock.h:777 [inline]
 sco_sock_timeout+0x68/0x2b0 home/dubbo/net/net/bluetooth/sco.c:88
 process_one_work+0x830/0x1550 home/dubbo/net/kernel/workqueue.c:2627
 process_scheduled_works home/dubbo/net/kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 home/dubbo/net/kernel/workqueue.c:2781
 kthread+0x33c/0x440 home/dubbo/net/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 home/dubbo/net/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 home/dubbo/net/arch/x86/entry/entry_64.S:242
 </TASK>
Allocated by task 8208:
 kasan_save_stack+0x33/0x50 home/dubbo/net/mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 home/dubbo/net/mm/kasan/common.c:52
 ____kasan_kmalloc home/dubbo/net/mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 home/dubbo/net/mm/kasan/common.c:383
 kasan_kmalloc home/dubbo/net/./include/linux/kasan.h:198 [inline]
 __do_kmalloc_node home/dubbo/net/mm/slab_common.c:1007 [inline]
 __kmalloc+0x60/0x100 home/dubbo/net/mm/slab_common.c:1020
 kmalloc home/dubbo/net/./include/linux/slab.h:604 [inline]
 sk_prot_alloc+0x1a4/0x2a0 home/dubbo/net/net/core/sock.c:2075
 sk_alloc+0x36/0xb80 home/dubbo/net/net/core/sock.c:2128
 bt_sock_alloc+0x3b/0x3e0 home/dubbo/net/net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc home/dubbo/net/net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 home/dubbo/net/net/bluetooth/sco.c:526
 bt_sock_create+0x180/0x340 home/dubbo/net/net/bluetooth/af_bluetooth.c:132
 __sock_create+0x328/0x800 home/dubbo/net/net/socket.c:1569
 sock_create home/dubbo/net/net/socket.c:1620 [inline]
 __sys_socket_create home/dubbo/net/net/socket.c:1657 [inline]
 __sys_socket+0x14c/0x260 home/dubbo/net/net/socket.c:1704
 __do_sys_socket home/dubbo/net/net/socket.c:1718 [inline]
 __se_sys_socket home/dubbo/net/net/socket.c:1716 [inline]
 __x64_sys_socket+0x72/0xb0 home/dubbo/net/net/socket.c:1716
 do_syscall_x64 home/dubbo/net/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x3f/0x110 home/dubbo/net/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
Freed by task 8209:
 kasan_save_stack+0x33/0x50 home/dubbo/net/mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 home/dubbo/net/mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 home/dubbo/net/mm/kasan/generic.c:522
 ____kasan_slab_free home/dubbo/net/mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 home/dubbo/net/mm/kasan/common.c:200
 kasan_slab_free home/dubbo/net/./include/linux/kasan.h:164 [inline]
 slab_free_hook home/dubbo/net/mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 home/dubbo/net/mm/slub.c:1826
 slab_free home/dubbo/net/mm/slub.c:3809 [inline]
 __kmem_cache_free+0xc0/0x180 home/dubbo/net/mm/slub.c:3822
 sk_prot_free home/dubbo/net/net/core/sock.c:2111 [inline]
 __sk_destruct+0x602/0x770 home/dubbo/net/net/core/sock.c:2203
 sk_destruct+0xc2/0xf0 home/dubbo/net/net/core/sock.c:2218
 __sk_free+0xf4/0x3e0 home/dubbo/net/net/core/sock.c:2229
 sk_free+0x7c/0xa0 home/dubbo/net/net/core/sock.c:2240
 sock_put home/dubbo/net/./include/net/sock.h:1990 [inline]
 sco_sock_kill home/dubbo/net/net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 home/dubbo/net/net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 home/dubbo/net/net/bluetooth/sco.c:1256
 __sock_release+0xae/0x260 home/dubbo/net/net/socket.c:659
 sock_close+0x1c/0x20 home/dubbo/net/net/socket.c:1419
 __fput+0x270/0xbb0 home/dubbo/net/fs/file_table.c:394
 task_work_run+0x14d/0x240 home/dubbo/net/kernel/task_work.c:180
 get_signal+0x1077/0x26e0 home/dubbo/net/kernel/signal.c:2680
 arch_do_signal_or_restart+0x90/0x7f0
home/dubbo/net/arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop home/dubbo/net/kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 home/dubbo/net/kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work
home/dubbo/net/kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 home/dubbo/net/kernel/entry/common.c:296
 do_syscall_64+0x4b/0x110 home/dubbo/net/arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
Last potentially related work creation:
 kasan_save_stack+0x33/0x50 home/dubbo/net/mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 home/dubbo/net/mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 home/dubbo/net/kernel/rcu/tree.c:2681
 netlink_release+0x120d/0x1ff0 home/dubbo/net/net/netlink/af_netlink.c:831
 __sock_release+0xae/0x260 home/dubbo/net/net/socket.c:659
 sock_close+0x1c/0x20 home/dubbo/net/net/socket.c:1419
 __fput+0x270/0xbb0 home/dubbo/net/fs/file_table.c:394
 __fput_sync+0x47/0x50 home/dubbo/net/fs/file_table.c:475
 __do_sys_close home/dubbo/net/fs/open.c:1590 [inline]
 __se_sys_close home/dubbo/net/fs/open.c:1575 [inline]
 __x64_sys_close+0x87/0xf0 home/dubbo/net/fs/open.c:1575
 do_syscall_x64 home/dubbo/net/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x3f/0x110 home/dubbo/net/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
The buggy address belongs to the object at ffff888156922000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff888156922000, ffff888156922800)
The buggy address belongs to the physical page:
page:ffffea00055a4800 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x15690
head:ffffea00055a4800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000840(slab|head|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000840 ffff888012c43240 ffffea00053b0e10 ffffea000502e810
raw: 0000000000000000 0000000000050005 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd2040(__GFP_IO|__GFP_N3
 set_page_owner home/dubbo/net/./include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 home/dubbo/net/mm/page_alloc.c:1537
 prep_new_page home/dubbo/net/mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xa28/0x36c0 home/dubbo/net/mm/page_alloc.c:3312
 __alloc_pages+0x1d0/0x4a0 home/dubbo/net/mm/page_alloc.c:4568
 alloc_pages_mpol+0x258/0x5f0 home/dubbo/net/mm/mempolicy.c:2133
 alloc_slab_page home/dubbo/net/mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 home/dubbo/net/mm/slub.c:2017
 new_slab home/dubbo/net/mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 home/dubbo/net/mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 home/dubbo/net/mm/slub.c:3322
 __slab_alloc_node home/dubbo/net/mm/slub.c:3375 [inline]
 slab_alloc_node home/dubbo/net/mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 home/dubbo/net/mm/slub.c:3517
 __do_kmalloc_node home/dubbo/net/mm/slab_common.c:1006 [inline]
 __kmalloc+0x4f/0x100 home/dubbo/net/mm/slab_common.c:1020
 kmalloc home/dubbo/net/./include/linux/slab.h:604 [inline]
 kzalloc home/dubbo/net/./include/linux/slab.h:721 [inline]
 tomoyo_init_log+0x1276/0x1f60 home/dubbo/net/security/tomoyo/audit.c:275
 tomoyo_supervisor+0x30c/0x1170 home/dubbo/net/security/tomoyo/common.c:2089
 tomoyo_audit_env_log home/dubbo/net/security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x18f/0x200 home/dubbo/net/security/tomoyo/environ.c:63
 tomoyo_environ home/dubbo/net/security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0xed8/0x2020
home/dubbo/net/security/tomoyo/domain.c:878
 tomoyo_bprm_check_security home/dubbo/net/security/tomoyo/tomoyo.c:101 [inline]
 tomoyo_bprm_check_security+0x12b/0x1d0
home/dubbo/net/security/tomoyo/tomoyo.c:91
 security_bprm_check+0x6a/0xe0 home/dubbo/net/security/security.c:1103
 search_binary_handler home/dubbo/net/fs/exec.c:1725 [inline]
 exec_binprm home/dubbo/net/fs/exec.c:1779 [inline]
 bprm_execve home/dubbo/net/fs/exec.c:1854 [inline]
 bprm_execve+0x73a/0x1a90 home/dubbo/net/fs/exec.c:1810
page last free stack trace:
 reset_page_owner home/dubbo/net/./include/linux/page_owner.h:24 [inline]
 free_pages_prepare home/dubbo/net/mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x4e5/0xa20 home/dubbo/net/mm/page_alloc.c:2347
 free_unref_page+0x33/0x3b0 home/dubbo/net/mm/page_alloc.c:2487
 qlink_free home/dubbo/net/mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 home/dubbo/net/mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x18e/0x1d0 home/dubbo/net/mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x65/0x90 home/dubbo/net/mm/kasan/common.c:305
 kasan_slab_alloc home/dubbo/net/./include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook home/dubbo/net/mm/slab.h:763 [inline]
 slab_alloc_node home/dubbo/net/mm/slub.c:3478 [inline]
 slab_alloc home/dubbo/net/mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru home/dubbo/net/mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x163/0x390 home/dubbo/net/mm/slub.c:3502
 kmem_cache_zalloc home/dubbo/net/./include/linux/slab.h:711 [inline]
 alloc_empty_file+0x73/0x1d0 home/dubbo/net/fs/file_table.c:216
 path_openat+0xdd/0x2c40 home/dubbo/net/fs/namei.c:3765
 do_filp_open+0x1de/0x430 home/dubbo/net/fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 home/dubbo/net/fs/open.c:1440
 do_sys_open home/dubbo/net/fs/open.c:1455 [inline]
 __do_sys_openat home/dubbo/net/fs/open.c:1471 [inline]
 __se_sys_openat home/dubbo/net/fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 home/dubbo/net/fs/open.c:1466
 do_syscall_x64 home/dubbo/net/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x3f/0x110 home/dubbo/net/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
Memory state around the buggy address:
 ffff888156921f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888156922000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888156922080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888156922100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888156922180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


and my reproducer is at the same kernel commit at the lastest net tree
kernel commit: 1ae4cd3cbdd08287c56c4cc816ebf05eb6681a0f
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=b50bd31249191be8

KASAN: slab-out-of-bounds Write in sco_sock_timeout:
https://gist.github.com/xrivendell7/0dbaa3529a9845b008c31e0bc6c29236
KASAN: slab-use-after-free Write in sco_conn_del:
https://gist.github.com/xrivendell7/b813252b1c8f3f35aaee1af60b698d0a
KASAN: wild-memory-access Read in lock_sock_nested:
https://gist.github.com/xrivendell7/f2a0fba9a55413c64c6153d03cd3df58

all the gist contains the report, repro.c and repro.txt
BTW, I also run another crash maybe related to this one, Titled:

KASAN: use-after-free Write in sco_sock_timeout
KASAN: slab-out-of-bounds Write in sco_sock_timeout
KASAN: slab-use-after-free Write in __sco_sock_close
WARNING: refcount bug in sco_sock_timeout
INFO: trying to register non-static key in sco_sock_timeout

However, for now, i can not reproduce those bugs with stable reproducer.
I hope is helps.

Best Regards
xingwei Lee
