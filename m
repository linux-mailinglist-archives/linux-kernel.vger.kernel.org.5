Return-Path: <linux-kernel+bounces-16616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CB82413F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850FF287730
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBFC21376;
	Thu,  4 Jan 2024 12:04:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9321362
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fe3fbbea8so2297945ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704369865; x=1704974665;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5h4zCC2hUS/A4eGxWFau/Ir/9rP/TRBrjlRWoRrC1o8=;
        b=S3xOGzsYDm4UIIDdm56VjT0oDL0GzV5/fibdCILbBbTWp/uJeiGBtVstBErn8zx+ku
         2EXy9z655K8t0uDct3xzmLEWwejC6+hILuaikpTHWpMjyNek92/c6H3eWzEp69l1kxBW
         PYeH1heH/7s/MTQftEvRCpciZ2RZWkFPTf/NYcEzAWXjAheFsRtMQrcVuIbGXLGyNG4O
         +oNWFR7/pXk4usJpqjVFsEfN9zYWviz89YFBeJTQoLOF5ruYSGeen7hUr/SF16YrhaF8
         aha2ZjHcM5YTpu0gIvzsMEL6sajuR5OGMYQ1AfHudN8GnCwWqkSv8TKhu8fUJHLPhQR3
         WtLQ==
X-Gm-Message-State: AOJu0YyNiQCGrsbWWom55/8BQr43NljsidL88GCDNE1BjtV1WvA/ZjnE
	wURKYr5fETfUgw6LUGgh/zHj6K1f3a8MLkAVb9JtxSaCftXF
X-Google-Smtp-Source: AGHT+IEpRdYEUpk+QhT8i+5s3rd/dbOy04wsTYq0jFBu6zIyiwxN5sLmfhVs+S11QU0A2JGZ1WH88c+DRE7pk+Bm7MDN3UCGPqZo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2a:b0:35f:f683:f76b with SMTP id
 g10-20020a056e021a2a00b0035ff683f76bmr75190ile.3.1704369865137; Thu, 04 Jan
 2024 04:04:25 -0800 (PST)
Date: Thu, 04 Jan 2024 04:04:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060a6c9060e1d8851@google.com>
Subject: [syzbot] [ntfs3?] KMSAN: kernel-infoleak in listxattr
From: syzbot <syzbot+608044293020556ff16b@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8735c7c84d1b Merge tag '6.7rc7-smb3-srv-fix' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dec9a1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4130d4bb32c48ef
dashboard link: https://syzkaller.appspot.com/bug?extid=608044293020556ff16b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03cd0531b6f3/disk-8735c7c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bb4ebecaed0/vmlinux-8735c7c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e40c5a86a2b5/bzImage-8735c7c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+608044293020556ff16b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 listxattr+0x2e9/0x6a0 fs/xattr.c:843
 path_listxattr fs/xattr.c:865 [inline]
 __do_sys_listxattr fs/xattr.c:877 [inline]
 __se_sys_listxattr fs/xattr.c:874 [inline]
 __x64_sys_listxattr+0x16b/0x2e0 fs/xattr.c:874
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ntfs_list_ea fs/ntfs3/xattr.c:232 [inline]
 ntfs_listxattr+0x5d2/0x8d0 fs/ntfs3/xattr.c:733
 vfs_listxattr fs/xattr.c:494 [inline]
 listxattr+0x1f0/0x6a0 fs/xattr.c:841
 path_listxattr fs/xattr.c:865 [inline]
 __do_sys_listxattr fs/xattr.c:877 [inline]
 __se_sys_listxattr fs/xattr.c:874 [inline]
 __x64_sys_listxattr+0x16b/0x2e0 fs/xattr.c:874
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 ntfs_read_ea+0x78c/0x10b0 fs/ntfs3/xattr.c:118
 ntfs_list_ea fs/ntfs3/xattr.c:204 [inline]
 ntfs_listxattr+0x173/0x8d0 fs/ntfs3/xattr.c:733
 vfs_listxattr fs/xattr.c:494 [inline]
 listxattr+0x1f0/0x6a0 fs/xattr.c:841
 path_listxattr fs/xattr.c:865 [inline]
 __do_sys_listxattr fs/xattr.c:877 [inline]
 __se_sys_listxattr fs/xattr.c:874 [inline]
 __x64_sys_listxattr+0x16b/0x2e0 fs/xattr.c:874
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 26-31 of 63 are uninitialized
Memory access of size 63 starts at ffff888103174b40
Data copied to user address 0000000020000080

CPU: 0 PID: 5727 Comm: syz-executor.4 Not tainted 6.7.0-rc7-syzkaller-00029-g8735c7c84d1b #0
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

