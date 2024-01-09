Return-Path: <linux-kernel+bounces-21228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1053828C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29151C24BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8113C088;
	Tue,  9 Jan 2024 18:17:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315633B7A9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bedda4c4dfso76444139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824227; x=1705429027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1fRK8LclclkjLxKsHAmbJYlYghzjAn6EVMQKQCm2fo=;
        b=uMJgU416onuhGxJZceDGsGUenmOd7KmlviyryCXiVmeEI8eEjoyl7511o9/GiYb54M
         6VjVyspAObuwxuntLFpH9MPg4orKQOpuXvafZUQBvOhzTKroC20QZ1ozZQFJnA7lMg+C
         JI5Fx9WIiqEqVNsphA6qZPO4Vs5O62AIHTQrPnZtEWOo5gZqHokXeTCboB7qMbcRKFna
         RYcs0WLiMUBxcvvARaA8U5UAuiLDm3dqek5t2jAfLA8g66P6MQnQ8PrDqzZ4tXDhwuZn
         QzIYYZwCi23ufeU05jg/MU4fN5zZcg8VCoze2OfyZRxzpfmSlI/UYIf5uv3fQu3H3nIg
         EjVg==
X-Gm-Message-State: AOJu0YyCgs+T5fpgJhg3VQ8rmi3Bh5b8S2I8+f2NF26GglFi3ON8C3di
	ZvhgjLRoCPy9OIv/eu9mat8+ATkHhezheu2rhCTQTUMIlF91
X-Google-Smtp-Source: AGHT+IEsFCkksksqD2TBTDO3A2p9hQE9gZFx+w1zRqDw/Ez1fPelzjDSs61+34Y4/ZcNjI/HS5HaHiz5QjaphF0hQdJ47do2SVUw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c9:b0:46b:719a:62d0 with SMTP id
 g9-20020a05663816c900b0046b719a62d0mr692311jat.5.1704824227409; Tue, 09 Jan
 2024 10:17:07 -0800 (PST)
Date: Tue, 09 Jan 2024 10:17:07 -0800
In-Reply-To: <20240106024807.3011-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ab6f3060e87524f@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
From: syzbot <syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_quota_write

EXT4-fs error (device loop0) in ext4_process_orphan:347: Corrupt filesystem
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
ext4 filesystem being mounted at /root/syzkaller-testdir1916097639/syzkaller.TbSsym/0/file1 supports timestamps until 2038-01-19 (0x7fffffff)
------------[ cut here ]------------
kernel BUG at fs/ext4/super.c:7251!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5480 Comm: syz-executor.0 Not tainted 6.7.0-rc8-syzkaller-00159-ga4ab2706bb12-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:ext4_quota_write+0x6e5/0x6f0 fs/ext4/super.c:7251
Code: f9 ff ff e8 8d 37 39 ff 48 c7 c7 00 16 af 8d 4c 89 e6 48 89 da e8 7b 2e 68 02 e9 38 fa ff ff e8 21 27 c3 08 e8 6c 37 39 ff 90 <0f> 0b 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 53 48 89 fb e8 53 37
RSP: 0018:ffffc9000547ee00 EFLAGS: 00010293
RAX: ffffffff82554284 RBX: ffff8880739ac690 RCX: ffff88801bfd0000
RDX: 0000000000000000 RSI: ffff8880739ac690 RDI: ffff8880739ac690
RBP: ffffc9000547eef0 R08: ffffffff82553f4d R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed100e7358d3 R12: ffff8880739ac690
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880739ac690
FS:  00007f079ddca6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055636d85ffc8 CR3: 0000000028711000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qtree_write_dquot+0x243/0x530 fs/quota/quota_tree.c:431
 v2_write_dquot+0x120/0x190 fs/quota/quota_v2.c:358
 dquot_commit+0x3c4/0x520 fs/quota/dquot.c:512
 ext4_write_dquot+0x1f2/0x2c0 fs/ext4/super.c:6877
 mark_dquot_dirty fs/quota/dquot.c:372 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:410 [inline]
 dquot_alloc_inode+0x69f/0xb70 fs/quota/dquot.c:1780
 ext4_xattr_inode_alloc_quota fs/ext4/xattr.c:932 [inline]
 ext4_xattr_set_entry+0xaf3/0x3fc0 fs/ext4/xattr.c:1715
 ext4_xattr_block_set+0x73f/0x3680 fs/ext4/xattr.c:1970
 ext4_xattr_set_handle+0xcdf/0x1570 fs/ext4/xattr.c:2456
 ext4_xattr_set+0x241/0x3d0 fs/ext4/xattr.c:2558
 __vfs_setxattr+0x460/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x420 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f079d07cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f079ddca0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f079d19bf80 RCX: 00007f079d07cce9
RDX: 0000000020000380 RSI: 0000000020000340 RDI: 00000000200002c0
RBP: 00007f079d0c947a R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000ffed R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f079d19bf80 R15: 00007fff6aba59d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_quota_write+0x6e5/0x6f0 fs/ext4/super.c:7251
Code: f9 ff ff e8 8d 37 39 ff 48 c7 c7 00 16 af 8d 4c 89 e6 48 89 da e8 7b 2e 68 02 e9 38 fa ff ff e8 21 27 c3 08 e8 6c 37 39 ff 90 <0f> 0b 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 53 48 89 fb e8 53 37
RSP: 0018:ffffc9000547ee00 EFLAGS: 00010293
RAX: ffffffff82554284 RBX: ffff8880739ac690 RCX: ffff88801bfd0000
RDX: 0000000000000000 RSI: ffff8880739ac690 RDI: ffff8880739ac690
RBP: ffffc9000547eef0 R08: ffffffff82553f4d R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed100e7358d3 R12: ffff8880739ac690
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880739ac690
FS:  00007f079ddca6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055636d85ffc8 CR3: 0000000028711000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         a4ab2706 Merge tag 'firewire-fixes-6.7-final' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15f50a09e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=a43d4f48b8397d0e41a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15123275e80000


