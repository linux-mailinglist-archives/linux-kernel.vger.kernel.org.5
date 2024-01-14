Return-Path: <linux-kernel+bounces-25439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196F82D046
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0056628297F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288823BE;
	Sun, 14 Jan 2024 10:15:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44215399
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf0305ded5so151806839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 02:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705227321; x=1705832121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkWasQ++Mab08/ryMTBCXw8J551aaZAW6Ugwqeze+mE=;
        b=C5/iuopxmSckO3jP7RyyJbbgqm9S8lnSmv9JC2sVmg+Nbqx0ERUnZkRJIkxphzA8pk
         IL/2An6+1j3xI9sW/PRr+9yGslK5Rtc+FOcIBeTZFDBzcQ5fK43dsgxHV7lnK+HFNFbh
         y4Q7A9eHF9rQ+YXpH6VuNKHpG4aMFwIWc8WgL3C6sCFv2Omp6z0xobHo/0mse5/Xnl3d
         JcfyIyw61gejxv9IVY6QGBVI1Fs369Oa/qmY5td2cMJNcEIRcMEZniYIcUZCaDbyo5q7
         t5SEj2Og3uZD5ZIQiSX/atNU8E+VpWe/ORC/tp7mfnflQehYt+Cl3suPAE9SkqLTsWgt
         LE+Q==
X-Gm-Message-State: AOJu0YwrRmMZShDfmeiThPxxTNVXZoekq+iNDnqzU+XOJsW/gOLaQZkE
	Hq0OukoRLX4H0Ri0afaTJLHg9i3VzK0U6RtLf0K0WEhhIWki
X-Google-Smtp-Source: AGHT+IFL3P/KyfWtk5t5RX3ilVyXWysXx3wABkTaGwg1bbPpg42WzdALJw+f3WiLAcjjMqiY3T02mBydxhaps7RInAGCKt1utSro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3726:b0:46e:6732:7cf0 with SMTP id
 k38-20020a056638372600b0046e67327cf0mr119010jav.2.1705227321086; Sun, 14 Jan
 2024 02:15:21 -0800 (PST)
Date: Sun, 14 Jan 2024 02:15:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc186d060ee52c29@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in af_alg_free_sg (2)
From: syzbot <syzbot+3266db0c26d1fbbe3abb@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0dd3ee311255 Linux 6.7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169326ade80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=373206b1ae2fe3d4
dashboard link: https://syzkaller.appspot.com/bug?extid=3266db0c26d1fbbe3abb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/983c6822f4f0/disk-0dd3ee31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7ac98ec5a78/vmlinux-0dd3ee31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f568a85da78f/bzImage-0dd3ee31.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3266db0c26d1fbbe3abb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in af_alg_free_sg+0x1a7/0x270 crypto/af_alg.c:547
 af_alg_free_sg+0x1a7/0x270 crypto/af_alg.c:547
 hash_sendmsg+0x1938/0x1c30 crypto/algif_hash.c:172
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2586
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2640
 __sys_sendmmsg+0x3c4/0x950 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2755 [inline]
 __se_sys_sendmmsg net/socket.c:2752 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2752
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
 sock_kmalloc+0x128/0x1c0 net/core/sock.c:2688
 hash_accept_parent_nokey crypto/algif_hash.c:418 [inline]
 hash_accept_parent+0xbf/0x430 crypto/algif_hash.c:445
 af_alg_accept+0x1fc/0x810 crypto/af_alg.c:439
 hash_accept+0x340/0x790 crypto/algif_hash.c:254
 do_accept+0x606/0xa80 net/socket.c:1929
 __sys_accept4_file net/socket.c:1969 [inline]
 __sys_accept4+0x18e/0x360 net/socket.c:1999
 __do_sys_accept4 net/socket.c:2010 [inline]
 __se_sys_accept4 net/socket.c:2007 [inline]
 __x64_sys_accept4+0xb8/0x120 net/socket.c:2007
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 6735 Comm: syz-executor.4 Not tainted 6.7.0-syzkaller #0
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

