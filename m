Return-Path: <linux-kernel+bounces-25437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3189D82D041
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482EF1C20D7E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D903D7A;
	Sun, 14 Jan 2024 10:14:20 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC21FBF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36089faa032so60095655ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 02:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705227257; x=1705832057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fNOx073h65MV6PBEtaWUR1UDM18KXdO514Fu/B4QL8=;
        b=GvEkn+bt8+Fepvkv+ndT9IJJPTueMz9LemgzXRAjJZv0JdY2DHVngwFmsVts5koahQ
         z/QOyh6hW3NBPHH9fTEvNfGqqQ+CuKW6ntX3N7VSMg+ntBryRh7iyFczEvLJaoh9H+S2
         IVsWMU5elYaDcbShCeDPQ7jzfEriHjxPKtJgyXhU0mX7Asu9iNWhihJkuX22STmObQQF
         uOeoimVttHa1aFtEQd3nvh5uC3BfIRUHZFEMfo9TsnIzHE3Z086EVzihsix1r7OW7lmI
         E7dLuSNC3OLiu7DhPG3oz/PCMVuXykGVDXghQwpH3UCgInf1shbDk9q86SpMnIq/ydpo
         dtsg==
X-Gm-Message-State: AOJu0YzotYzke5czGxIdPTwlHc+rw7JkBu+7oGWy6EqcDychucrMHShA
	n2yEcEjFsI38dX1jzyah+dkC9a6OQ1wmx2kfsCT6KiUXa32s
X-Google-Smtp-Source: AGHT+IH8fMz0K/zVm3Xd/dOKA2b5qffoUR8Y5DkuYZpG1G71N52Mv4y5v/KpN4+oeFkcWc+0RBuPcP105KMRFCCS/Ri2Z5OTMewo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:35f:eceb:fc42 with SMTP id
 w11-20020a056e021c8b00b0035fecebfc42mr487839ill.3.1705227256796; Sun, 14 Jan
 2024 02:14:16 -0800 (PST)
Date: Sun, 14 Jan 2024 02:14:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e71ee0060ee5283b@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in lzo1x_1_do_compress (2)
From: syzbot <syzbot+9a049ebdaacbb076e50a@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc956ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e51fe20c3e51ba7f
dashboard link: https://syzkaller.appspot.com/bug?extid=9a049ebdaacbb076e50a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/616ff65c4cd0/disk-ac865f00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c25a3597c1c/vmlinux-ac865f00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db2a6f02e9fc/bzImage-ac865f00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a049ebdaacbb076e50a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in lzo1x_1_do_compress+0x913/0x2510 lib/lzo/lzo1x_compress.c:107
 lzo1x_1_do_compress+0x913/0x2510 lib/lzo/lzo1x_compress.c:107
 lzogeneric1x_1_compress+0x26a/0x11a0 lib/lzo/lzo1x_compress.c:333
 lzo1x_1_compress+0x47/0x70 lib/lzo/lzo1x_compress.c:383
 __lzo_compress crypto/lzo.c:58 [inline]
 lzo_scompress+0x98/0x180 crypto/lzo.c:79
 scomp_acomp_comp_decomp+0x4b6/0x780
 scomp_acomp_compress+0x32/0x40 crypto/scompress.c:159
 crypto_acomp_compress include/crypto/acompress.h:302 [inline]
 zswap_store+0x1b5c/0x32b0 mm/zswap.c:1314
 swap_writepage+0x122/0x340 mm/page_io.c:198
 shmem_writepage+0x1720/0x1e70 mm/shmem.c:1517
 pageout mm/vmscan.c:654 [inline]
 shrink_folio_list+0x508f/0x7760 mm/vmscan.c:1315
 evict_folios+0x9bb1/0xbaa0 mm/vmscan.c:4499
 try_to_shrink_lruvec+0x15ac/0x1b20 mm/vmscan.c:4704
 shrink_one+0x66e/0xd70 mm/vmscan.c:4743
 shrink_many mm/vmscan.c:4808 [inline]
 lru_gen_shrink_node mm/vmscan.c:4923 [inline]
 shrink_node+0x4bed/0x5890 mm/vmscan.c:5863
 kswapd_shrink_node mm/vmscan.c:6668 [inline]
 balance_pgdat mm/vmscan.c:6858 [inline]
 kswapd+0x1df1/0x4260 mm/vmscan.c:7118
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

<Zero or more stacks not recorded to save memory>

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:268 [inline]
 copy_page_from_iter_atomic+0x12f1/0x2b70 lib/iov_iter.c:500
 generic_perform_write+0x4ae/0xc40 mm/filemap.c:3935
 shmem_file_write_iter+0x2b5/0x2e0 mm/shmem.c:2895
 do_iter_write+0xceb/0x1340 fs/read_write.c:860
 vfs_iter_write+0x8e/0xe0 fs/read_write.c:901
 lo_write_bvec drivers/block/loop.c:249 [inline]
 lo_write_simple drivers/block/loop.c:271 [inline]
 do_req_filebacked drivers/block/loop.c:495 [inline]
 loop_handle_cmd drivers/block/loop.c:1915 [inline]
 loop_process_work+0x20c3/0x39d0 drivers/block/loop.c:1950
 loop_rootcg_workfn+0x2b/0x30 drivers/block/loop.c:1981
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was stored to memory at:
 ntfs_write_bh+0x64e/0xda0 fs/ntfs3/fsntfs.c:1425
 indx_write fs/ntfs3/index.c:1027 [inline]
 indx_update_dup+0xd7d/0xf80 fs/ntfs3/index.c:2687
 ni_update_parent+0x12de/0x14a0 fs/ntfs3/frecord.c:3233
 ni_write_inode+0x1c73/0x1d70 fs/ntfs3/frecord.c:3321
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1029
 write_inode fs/fs-writeback.c:1473 [inline]
 __writeback_single_inode+0x843/0x12b0 fs/fs-writeback.c:1690
 writeback_sb_inodes+0xb73/0x1c00 fs/fs-writeback.c:1916
 wb_writeback+0x4a1/0xdf0 fs/fs-writeback.c:2092
 wb_do_writeback fs/fs-writeback.c:2239 [inline]
 wb_workfn+0x3a4/0x1710 fs/fs-writeback.c:2279
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was stored to memory at:
 ntfs_read_run_nb+0x6d5/0xf60 fs/ntfs3/fsntfs.c:1227
 ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1288
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
 indx_find+0xd08/0x1430 fs/ntfs3/index.c:1181
 indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2659
 ni_update_parent+0x12de/0x14a0 fs/ntfs3/frecord.c:3233
 ni_write_inode+0x1c73/0x1d70 fs/ntfs3/frecord.c:3321
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1029
 write_inode fs/fs-writeback.c:1473 [inline]
 __writeback_single_inode+0x843/0x12b0 fs/fs-writeback.c:1690
 writeback_sb_inodes+0xb73/0x1c00 fs/fs-writeback.c:1916
 wb_writeback+0x4a1/0xdf0 fs/fs-writeback.c:2092
 wb_do_writeback fs/fs-writeback.c:2239 [inline]
 wb_workfn+0x3a4/0x1710 fs/fs-writeback.c:2279
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was stored to memory at:
 ntfs_write_bh+0x64e/0xda0 fs/ntfs3/fsntfs.c:1425
 indx_write fs/ntfs3/index.c:1027 [inline]
 indx_insert_into_buffer+0xd8b/0x2000 fs/ntfs3/index.c:1804
 indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1981
 ntfs_create_inode+0x4619/0x4fc0 fs/ntfs3/inode.c:1655
 ntfs_symlink+0x88/0x110 fs/ntfs3/namei.c:202
 vfs_symlink+0x1e6/0x3e0 fs/namei.c:4464
 do_symlinkat+0x257/0x890 fs/namei.c:4490
 __do_sys_symlinkat fs/namei.c:4506 [inline]
 __se_sys_symlinkat fs/namei.c:4503 [inline]
 __ia32_sys_symlinkat+0xf3/0x160 fs/namei.c:4503
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 ntfs_read_run_nb+0x6d5/0xf60 fs/ntfs3/fsntfs.c:1227
 ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1288
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
 indx_find+0xd08/0x1430 fs/ntfs3/index.c:1181
 indx_insert_entry+0xadf/0xee0 fs/ntfs3/index.c:1958
 ntfs_create_inode+0x4619/0x4fc0 fs/ntfs3/inode.c:1655
 ntfs_symlink+0x88/0x110 fs/ntfs3/namei.c:202
 vfs_symlink+0x1e6/0x3e0 fs/namei.c:4464
 do_symlinkat+0x257/0x890 fs/namei.c:4490
 __do_sys_symlinkat fs/namei.c:4506 [inline]
 __se_sys_symlinkat fs/namei.c:4503 [inline]
 __ia32_sys_symlinkat+0xf3/0x160 fs/namei.c:4503
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 ntfs_write_bh+0x64e/0xda0 fs/ntfs3/fsntfs.c:1425
 indx_write fs/ntfs3/index.c:1027 [inline]
 indx_insert_into_buffer+0xd8b/0x2000 fs/ntfs3/index.c:1804
 indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1981
 ntfs_create_inode+0x4619/0x4fc0 fs/ntfs3/inode.c:1655
 ntfs_mkdir+0x5c/0xe0 fs/ntfs3/namei.c:216
 vfs_mkdir+0x49a/0x700 fs/namei.c:4106
 do_mkdirat+0x529/0x800 fs/namei.c:4129
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __ia32_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 hdr_insert_de fs/ntfs3/index.c:838 [inline]
 indx_insert_into_buffer+0xcdb/0x2000 fs/ntfs3/index.c:1800
 indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1981
 ntfs_create_inode+0x4619/0x4fc0 fs/ntfs3/inode.c:1655
 ntfs_mkdir+0x5c/0xe0 fs/ntfs3/namei.c:216
 vfs_mkdir+0x49a/0x700 fs/namei.c:4106
 do_mkdirat+0x529/0x800 fs/namei.c:4129
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __ia32_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x579/0xa90 mm/slub.c:3502
 ntfs_create_inode+0x658/0x4fc0 fs/ntfs3/inode.c:1303
 ntfs_mkdir+0x5c/0xe0 fs/ntfs3/namei.c:216
 vfs_mkdir+0x49a/0x700 fs/namei.c:4106
 do_mkdirat+0x529/0x800 fs/namei.c:4129
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __ia32_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

CPU: 0 PID: 76 Comm: kswapd0 Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
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

