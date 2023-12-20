Return-Path: <linux-kernel+bounces-6368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAA8197B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694341C25282
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE21F5FC;
	Wed, 20 Dec 2023 04:22:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C91F5E4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fb524eb7cso25045115ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046126; x=1703650926;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84C7ElPwcoYL++Lkj9m2M0EoeIWtCtdfGV/OTZ8BF1I=;
        b=gH3AggV73EGRkdeSeOtzyFYvjKXezBcGcH6n0xbl6alq588FQuAxQIEjTb9eM9fWtf
         y06hA7ihmhQN7XkQdhKyG+E8BkUyI1XPPjucZ/ASlVonqJMl0HiDSj/gJV3gAMI5M+fY
         R0uKszzcZhiw2C9IexvBJqzoyw3la5ZLP9XHhXEe2VAW00T243YpS+rQIWdxOY5/GZ4A
         gO07Sg0LFf/L5MDFOKthMJByjI7NpRiPzbV1HoqeMdpgpCHrx2vYtGdHOCXHseC09zjw
         vGIWJXl9curQuo1SMI9BdjLv17zWYHdlRj1ghzN+52/xN9MrmySGsK+c3g6lhmIjPOqu
         19XQ==
X-Gm-Message-State: AOJu0Yx9KrZiwSclQsX/9sMUydd/9bJGXzE7E+BfPQaQ0QfiUOz9rnyg
	rUshqip9suv9xURVOGP0EjS0sHnr/N9G4bcvoYZLLUyLlERM
X-Google-Smtp-Source: AGHT+IF7F8zovf22pf3ChVX/RuEVAHLdOwAxeIWbKYN59tKIhb6sg61vDVbUQNJlBm/nckyNnL0lBl62iL858PIGfUfmvl9IlLMw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1544:b0:35f:b201:d621 with SMTP id
 j4-20020a056e02154400b0035fb201d621mr580892ilu.3.1703046125986; Tue, 19 Dec
 2023 20:22:05 -0800 (PST)
Date: Tue, 19 Dec 2023 20:22:05 -0800
In-Reply-To: <tencent_501F4BE81B712525BA1ABB71333D9E001B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006029a5060ce95366@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in arc4_crypt

"syz-executor.0" (5493) uses obsolete ecb(arc4) skcipher
req: ffff8880798ffa90, _skcipher_recvmsg
r: ffff8880798ffa90, ivs: ffff8880798ffae0, v: 0, s: 0, ri: 0000000000000010, wi: 0000000000000000, f: 1536, wnb: 0, crypto_lskcipher_crypt_sg
ivs: ffff8880798ffae0, v: 0, s: 0, ri: 0000000000000010, wi: 0000000000000010, f: 1536, wnb: 2, crypto_lskcipher_crypt_sg
ffff8880798ffae0, flags: 514, ctx: ffff88807b10a020, crypto_arc4_crypt
==================================================================
BUG: KASAN: slab-out-of-bounds in arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
Read of size 4 at addr ffff8880798ffee0 by task syz-executor.0/5493

CPU: 1 PID: 5493 Comm: syz-executor.0 Not tainted 6.7.0-rc5-next-20231215-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
 crypto_arc4_crypt+0x7f/0x90 crypto/arc4.c:38
 crypto_lskcipher_crypt_sg+0x41f/0x680 crypto/lskcipher.c:236
 crypto_skcipher_decrypt+0xda/0x160 crypto/skcipher.c:693
 _skcipher_recvmsg crypto/algif_skcipher.c:200 [inline]
 skcipher_recvmsg+0xc41/0x1050 crypto/algif_skcipher.c:222
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1066
 ____sys_recvmsg+0x21f/0x5c0 net/socket.c:2801
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2843
 __sys_recvmsg+0x114/0x1e0 net/socket.c:2873
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f34dc47cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f34dd1060c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007f34dc59bf80 RCX: 00007f34dc47cba9
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000004
RBP: 00007f34dc4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f34dc59bf80 R15: 00007ffcf6c49838
 </TASK>

Allocated by task 78:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slub.c:3817 [inline]
 slab_alloc_node mm/slub.c:3864 [inline]
 kmem_cache_alloc_lru+0x142/0x6f0 mm/slub.c:3883
 __d_alloc+0x32/0xac0 fs/dcache.c:1769
 d_alloc+0x4e/0x220 fs/dcache.c:1849
 d_alloc_parallel+0xe9/0x12d0 fs/dcache.c:2638
 __lookup_slow+0x194/0x450 fs/namei.c:1678
 lookup_one_len+0x17d/0x1b0 fs/namei.c:2755
 securityfs_create_dentry+0xe3/0x4c0 security/inode.c:131
 lockdown_secfs_init+0x29/0x60 security/lockdown/lockdown.c:159
 do_one_initcall+0x128/0x680 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x692/0xc30 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

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
 acpi_ec_alloc+0x3c/0x380 drivers/acpi/ec.c:1374
 acpi_ec_dsdt_probe+0x26/0x160 drivers/acpi/ec.c:1761
 acpi_bus_init drivers/acpi/bus.c:1372 [inline]
 acpi_init+0x2c5/0xb70 drivers/acpi/bus.c:1430
 do_one_initcall+0x128/0x680 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x692/0xc30 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

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
 acpi_ut_allocate_object_desc_dbg drivers/acpi/acpica/utobject.c:359 [inline]
 acpi_ut_create_internal_object_dbg+0x7b/0x400 drivers/acpi/acpica/utobject.c:69
 acpi_ex_create_method+0x35/0x2c0 drivers/acpi/acpica/excreate.c:421
 acpi_ds_load2_end_op+0xd85/0x1070 drivers/acpi/acpica/dswload2.c:668
 acpi_ds_exec_end_op+0x513/0x1460 drivers/acpi/acpica/dswexec.c:638
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

The buggy address belongs to the object at ffff8880798ff800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 1024 bytes to the right of
 allocated 736-byte region [ffff8880798ff800, ffff8880798ffae0)

The buggy address belongs to the physical page:
page:ffffea0001e63e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x798f8
head:ffffea0001e63e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4738, tgid 4738 (dhcpcd-run-hook), ts 46995283544, free_ts 46977104435
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
 __kmalloc+0x3b4/0x440 mm/slub.c:3998
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 tomoyo_init_log+0x142a/0x2100 security/tomoyo/audit.c:275
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x18f/0x200 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0xef5/0x2020 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12a/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x6a/0xe0 security/security.c:1187
 search_binary_handler fs/exec.c:1724 [inline]
 exec_binprm fs/exec.c:1778 [inline]
 bprm_execve fs/exec.c:1853 [inline]
 bprm_execve+0x730/0x1a80 fs/exec.c:1809
 do_execveat_common.isra.0+0x679/0x8e0 fs/exec.c:1974
page last free pid 4737 tgid 4737 stack trace:
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
 kmalloc_trace+0x147/0x330 mm/slub.c:4011
 kmalloc include/linux/slab.h:590 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x19f/0x2100 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x373/0x3b0 security/tomoyo/file.c:777
 tomoyo_file_open security/tomoyo/tomoyo.c:333 [inline]
 tomoyo_file_open+0xa7/0xd0 security/tomoyo/tomoyo.c:328
 security_file_open+0x75/0x620 security/security.c:2914
 do_dentry_open+0x583/0x18c0 fs/open.c:940
 do_open fs/namei.c:3631 [inline]
 path_openat+0x1df1/0x2990 fs/namei.c:3788
 do_filp_open+0x1dc/0x430 fs/namei.c:3815

Memory state around the buggy address:
 ffff8880798ffd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880798ffe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880798ffe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff8880798fff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880798fff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16624b3ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16765921e80000


