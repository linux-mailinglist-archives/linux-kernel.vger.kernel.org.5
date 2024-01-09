Return-Path: <linux-kernel+bounces-21241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02695828C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D571C2520A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFA3C49B;
	Tue,  9 Jan 2024 18:20:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E33C070
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36089faa032so22495205ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824430; x=1705429230;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3afYaT69mpR33XvqXUKpkUgLg62032dTf6kloyJqf7Q=;
        b=WfpHos1FZjZXD0/XWQSG00uW0Pby56O1499DW9BpIPMpJ+JkV4ooqbixtqXngn/MO/
         vu24CA/bKXJlcCvq+AQTd5/8JteJzhv3/RWh5cxnr+wH4hukuiLgtlw4r4quNs8FuzQK
         SeYKoEftXjhniUnCE8TEpxbJG0Isdz3+/zCZXt2Caz+EdvwnFSslPbpjjYtCBtMXz7yE
         USjOZvrPJ0uRTbLVSNQA0e0FMyZldqGhwPYxgOa4HrHDK0Xci+wT5gyjJBXHALUaQ23F
         eOIgRcaFLeGOaqg0b1i8L8m/X7Du4DeXuwVTGDR7C8YIjHvWoMsTWX5wgWBGSYyWWawW
         Z1XA==
X-Gm-Message-State: AOJu0YzWVVC+l2upEtIj4D54OvnhBuW++Vfp4FUH0rhrRDHqlJFDsnlO
	rjrAzrAJoylJaDbasO0ubLTmC6RIewsAAQC7MNDBgrw/wAr2
X-Google-Smtp-Source: AGHT+IErfY0+Jt+xXsA/4Rpjdd6+W/usaew9RH68Xf/lrjEp7D/0pOM0JtFs+mcRcZJEZAoQJ3/5VHCgQLQMTElvcN7TREW38Eev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:35f:d5ea:8a86 with SMTP id
 k8-20020a92c248000000b0035fd5ea8a86mr744195ilo.5.1704824430591; Tue, 09 Jan
 2024 10:20:30 -0800 (PST)
Date: Tue, 09 Jan 2024 10:20:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000970711060e875e50@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in chksum_update
From: syzbot <syzbot+9c0d9ba56264f1602420@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127054ade80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4130d4bb32c48ef
dashboard link: https://syzkaller.appspot.com/bug?extid=9c0d9ba56264f1602420
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09f8d17b45e5/disk-453f5db0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/384c334e26ee/vmlinux-453f5db0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c93513aa17de/bzImage-453f5db0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c0d9ba56264f1602420@syzkaller.appspotmail.com

EXT4-fs error (device loop4): __ext4_ext_dirty:202: inode #2: comm syz-executor.4: mark_inode_dirty error
=====================================================
BUG: KMSAN: uninit-value in chksum_update+0xae/0xd0 crypto/crc32c_generic.c:88
 chksum_update+0xae/0xd0 crypto/crc32c_generic.c:88
 crypto_shash_update+0x75/0xa0 crypto/shash.c:74
 ext4_chksum fs/ext4/ext4.h:2474 [inline]
 ext4_dirblock_csum fs/ext4/namei.c:382 [inline]
 ext4_dirblock_csum_set fs/ext4/namei.c:430 [inline]
 ext4_handle_dirty_dirblock+0x6d5/0x8d0 fs/ext4/namei.c:438
 add_dirent_to_buf+0x885/0x9f0 fs/ext4/namei.c:2215
 ext4_add_entry+0xcc2/0x1b30 fs/ext4/namei.c:2447
 ext4_mkdir+0xaae/0x1510 fs/ext4/namei.c:3031
 vfs_mkdir+0x49a/0x700 fs/namei.c:4106
 do_mkdirat+0x529/0x800 fs/namei.c:4129
 __do_sys_mkdir fs/namei.c:4149 [inline]
 __se_sys_mkdir fs/namei.c:4147 [inline]
 __x64_sys_mkdir+0xa1/0xe0 fs/namei.c:4147
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ext4_chksum fs/ext4/ext4.h:2472 [inline]
 ext4_dirblock_csum fs/ext4/namei.c:382 [inline]
 ext4_dirblock_csum_set fs/ext4/namei.c:430 [inline]
 ext4_handle_dirty_dirblock+0x7d5/0x8d0 fs/ext4/namei.c:438
 add_dirent_to_buf+0x885/0x9f0 fs/ext4/namei.c:2215
 ext4_add_entry+0xcc2/0x1b30 fs/ext4/namei.c:2447
 ext4_mkdir+0xaae/0x1510 fs/ext4/namei.c:3031
 vfs_mkdir+0x49a/0x700 fs/namei.c:4106
 do_mkdirat+0x529/0x800 fs/namei.c:4129
 __do_sys_mkdir fs/namei.c:4149 [inline]
 __se_sys_mkdir fs/namei.c:4147 [inline]
 __x64_sys_mkdir+0xa1/0xe0 fs/namei.c:4147
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages+0x1be/0x1e0 mm/mempolicy.c:2204
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x421/0x1570 mm/slub.c:2070
 ___slab_alloc+0x13db/0x33d0 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc_lru+0x552/0x970 mm/slub.c:3509
 alloc_inode_sb include/linux/fs.h:2937 [inline]
 ext4_alloc_inode+0x63/0x850 fs/ext4/super.c:1408
 alloc_inode+0x83/0x440 fs/inode.c:261
 new_inode_pseudo fs/inode.c:1006 [inline]
 new_inode+0x38/0x420 fs/inode.c:1032
 __ext4_new_inode+0x297/0x79b0 fs/ext4/ialloc.c:958
 ext4_symlink+0x57e/0x1440 fs/ext4/namei.c:3398
 vfs_symlink+0x1e6/0x3e0 fs/namei.c:4464
 do_symlinkat+0x257/0x890 fs/namei.c:4490
 __do_sys_symlinkat fs/namei.c:4506 [inline]
 __se_sys_symlinkat fs/namei.c:4503 [inline]
 __x64_sys_symlinkat+0xf8/0x160 fs/namei.c:4503
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5681 Comm: syz-executor.4 Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

