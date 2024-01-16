Return-Path: <linux-kernel+bounces-26689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3784C82E539
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5522872C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71124B4F;
	Tue, 16 Jan 2024 00:15:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0324A1E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-360d8e54839so16832675ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705364106; x=1705968906;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ttfg8e+l7Pf8JPjsubqsBYFdtQZcrWDkbVYDFVSeKE=;
        b=E2Av9bWlLi7VfoItzwnk0kHF7r1bPP3S1CNQNPHo9sxO3Y+6DFxaIbxXRqxUuXu1zX
         YPO3J9dZl72kYt/QxrMuZUeuRXfktXFiC5qbL99w1aAqkkL0FikKxMielhtFeFlcL+Ea
         ptg+qxsvZKa/y5URsHqNEnCv9O2yYQyfVRcLNqc7xEAKkvrUjn6BDrIkK8PmSFd76Uty
         XurRcpIAJ29hCgdaTSOVWLoCVT02pHIFsVnRxDY80Iy1qU2f2zax7k5SRbeOZOmaDBW7
         o9++kdlpgKZwzOwsBQu51BZC1vK+yOkM1bovbq9ydR6cfPs+VtxAJ0gc9do9FjBROnC+
         spbA==
X-Gm-Message-State: AOJu0YyBMIM1jDEhoW6K3xIyC9udjL6d96yjFJv4yZUvfYWozxikogSW
	m20wp0+48mmR67GAqX4AC9jrPI1JNagTrIRQcf1+hqugpo28
X-Google-Smtp-Source: AGHT+IFGTgS6MHmhKPTniQgzpxXjY7g1P5ddmxnoLlaSEWBso7gpLJmGUwlhRf5f4DNuPH0a6b/G4UNUzmP12kFQFW0of3GILwm7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:35f:b1e7:cac with SMTP id
 15-20020a056e0216cf00b0035fb1e70cacmr667931ilx.4.1705364106568; Mon, 15 Jan
 2024 16:15:06 -0800 (PST)
Date: Mon, 15 Jan 2024 16:15:06 -0800
In-Reply-To: <tencent_6C6006C093630366C97083A2C44897777705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c92714060f050503@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in btrfs_dev_replace_by_ioctl

BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
================================================================================
UBSAN: array-index-out-of-bounds in fs/btrfs/dev-replace.c:746:2
index 4087 is out of range for type '__u8[1025]' (aka 'unsigned char[1025]')
CPU: 1 PID: 5485 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00200-g3bd7d7488169-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 btrfs_dev_replace_by_ioctl+0x1c1/0x1f10 fs/btrfs/dev-replace.c:746
 btrfs_ioctl_dev_replace+0x2c9/0x390 fs/btrfs/ioctl.c:3299
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f573be7cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f573cc170c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f573bf9bf80 RCX: 00007f573be7cba9
RDX: 0000000020000540 RSI: 00000000ca289435 RDI: 0000000000000005
RBP: 00007f573bec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f573bf9bf80 R15: 00007fff8c99b838
 </TASK>
================================================================================


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1761a2bde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1290befbe80000


