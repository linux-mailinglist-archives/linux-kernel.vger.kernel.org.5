Return-Path: <linux-kernel+bounces-2454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA816815D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2271F2233B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA64110A;
	Sun, 17 Dec 2023 04:04:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AF610E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b71da9f8b9so363057339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 20:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702785846; x=1703390646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYyISyfiO600TXKaOTCUN9KmO5nFThcxumHQg0Lhkic=;
        b=hlt/eXQ3q5GPTJ32G9ys58CcrDzlAQ2K2XSIfS3i0cFHjqImJ/b6dv+AFpgRwJVIJT
         wLRjCB1lVTOdXw1W0jGPHPifG6OYDPUKZvxTTdRSKUsq2D0rnoWme3Vp71wc1T43KUNE
         iye+v7p4omVghwLEvz5yQbIUnbhqty8FHZRpSr9GJbMkX7VIKQCBbCKVdsoub/mP7lKE
         H/saE9Oiu44S12YUGFammQarKQqM1Isno/K/zZ0VNs6u3MTUSNV2J9eiRZaxNW6pzQtK
         7pEYtJtwOFeMxdImFAHoSqRHimB1Rn2QExjJrUCuTy+B9Vi6kpO3qokc2Zivi61XL9w2
         0oKw==
X-Gm-Message-State: AOJu0YwUEmcl6+Mm6B//0fubq+QOG5YqtKIrbQ9oN8fZ5nxH1aKUjill
	Bl5KRefLWjmFKJ75/nY8j6UuotENfnbgh8f9mMMNrymErUUT
X-Google-Smtp-Source: AGHT+IGyNBLd8Ne/3GWkzR76NWDbv3+z3D6zMCkprHj3OhaqOWPCNRHHDNfstcvMBjFBKOMG5l11Aiz6o5y+BrDUA5HIM8cc6Xuk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56e:0:b0:35f:a839:9a6a with SMTP id
 b14-20020a92c56e000000b0035fa8399a6amr129941ilj.6.1702785846138; Sat, 16 Dec
 2023 20:04:06 -0800 (PST)
Date: Sat, 16 Dec 2023 20:04:06 -0800
In-Reply-To: <tencent_BC66DF537D0372896683AD445B5767376D05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cdec7060cacb957@google.com>
Subject: Re: [syzbot] [reiserfs?] [squashfs?] BUG: Dentry still in use in unmount
From: syzbot <syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Dentry still in use in unmount

------------[ cut here ]------------
BUG: Dentry ffff88807d684a48{i=1a,n=#3}  still in use (1) [unmount of f2fs loop0]
WARNING: CPU: 0 PID: 5411 at fs/dcache.c:1675 umount_check+0x189/0x1e0 fs/dcache.c:1667
Modules linked in:
CPU: 0 PID: 5411 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:umount_check+0x189/0x1e0 fs/dcache.c:1667
Code: e8 ff 4c 8b 0b 48 81 c5 60 06 00 00 48 c7 c7 c0 c7 77 8b 4c 89 fe 4c 89 f2 4c 89 f9 45 89 e8 55 e8 8c c8 52 ff 48 83 c4 08 90 <0f> 0b 90 90 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 89 f9 80 e1 07
RSP: 0018:ffffc90005247af8 EFLAGS: 00010282
RAX: 6b1a0fb562407300 RBX: ffffffff8dec05e0 RCX: ffff88807882bb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807eda4660 R08: ffffffff81545d52 R09: 1ffff92000a48eb0
R10: dffffc0000000000 R11: fffff52000a48eb1 R12: dffffc0000000000
R13: 0000000000000001 R14: 000000000000001a R15: ffff88807d684a48
FS:  0000555556544480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3d029a6440 CR3: 000000002acc0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 d_walk+0x1f6/0x6e0 fs/dcache.c:1386
 do_one_tree+0x35/0xe0 fs/dcache.c:1682
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1698
 generic_shutdown_super+0x6a/0x2c0 fs/super.c:668
 kill_block_super+0x44/0x90 fs/super.c:1667
 kill_f2fs_super+0x303/0x3b0 fs/f2fs/super.c:4933
 deactivate_locked_super+0xc1/0x130 fs/super.c:484
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xde/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x150 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x69/0x2a0 kernel/entry/common.c:296
 do_syscall_64+0x52/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5ed4c7ded7
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdf73a1ae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5ed4c7ded7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffdf73a1ba0
RBP: 00007ffdf73a1ba0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffdf73a2c60
R13: 00007f5ed4cc73b9 R14: 0000000000015340 R15: 000000000000000d
 </TASK>


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=169fe8f1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=8608bb4553edb8c78f41
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171fe8f1e80000


