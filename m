Return-Path: <linux-kernel+bounces-12406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7E81F459
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA41D1C216DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CA3C1D;
	Thu, 28 Dec 2023 03:20:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A163C00
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fd902c677so63389085ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 19:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703733604; x=1704338404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6pFLePW4Ul2JnmEQGAfwkB2GJoT9oKLQ+YIW9vKHNg=;
        b=Ym55rreYQJkeAVEz6xf5HPAQ3Efk0B84rSe2XytxKYPxgk4h773l6WpxmHzwptVfAz
         +zVr1Dxd/lEoR1gpw8Hj0QX0eikj3DeeLCS7LBId7fjfGF/EM9QagBsS+biU3YeLQvnm
         toaUQ5Dq7Kg2ah8Cs445aLB08URLhYFNXbVMDYjixRH1Y1z2iZ1ylipqe2F5Tz7KRH8x
         Qf90dKaH5JSS7/1q+y8ZHJ3ei5BkDVCJzrl4F68ccxQnP4NMNX9ckgFuUJqHtVdB3ijB
         CPFoOYu5hmQPfRe1EtWREKMvV+aVBocz90Cp97vAAvL9U59JBcIcFyLwz+UNrHZbz0RE
         aJoA==
X-Gm-Message-State: AOJu0YxSI43gc+DukI4/oR3T3TsELwafmMoYZfzox4THstUncByp98T+
	+c6oflZBv+386meNrwU0HmHU9Dldc/AEYL0Oc0r3u9VhnKqnf8A=
X-Google-Smtp-Source: AGHT+IEIZQoJNdcLAXML2g7EsI/1K/wlVg5h0MZku7oJmrEwbGsFw6xaFSz/cyVPHmk6bubeVQjpirletba2ENI++nb5FPlGT7+a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a49:b0:35f:cd35:f07e with SMTP id
 u9-20020a056e021a4900b0035fcd35f07emr1314326ilv.6.1703733604233; Wed, 27 Dec
 2023 19:20:04 -0800 (PST)
Date: Wed, 27 Dec 2023 19:20:04 -0800
In-Reply-To: <20231228005410.3716686-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045b7ed060d8964d8@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_case_cmp_key
From: syzbot <syzbot+50d8672fea106e5387bb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hfsplus_cat_case_cmp_key

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfsplus_cat_case_cmp_key+0xf1/0x190 fs/hfsplus/catalog.c:23
 hfsplus_cat_case_cmp_key+0xf1/0x190 fs/hfsplus/catalog.c:23
 hfs_find_rec_by_key+0xb0/0x240 fs/hfsplus/bfind.c:100
 __hfsplus_brec_find+0x26b/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_brec_read+0x46/0x1a0 fs/hfsplus/bfind.c:222
 hfsplus_find_cat+0xdb/0x460 fs/hfsplus/catalog.c:202
 hfsplus_iget+0x752/0xb00 fs/hfsplus/super.c:82
 hfsplus_fill_super+0x151b/0x26f0 fs/hfsplus/super.c:503
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:641
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3863
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
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_iget+0x3f3/0xb00 fs/hfsplus/super.c:80
 hfsplus_fill_super+0x151b/0x26f0 fs/hfsplus/super.c:503
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:641
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5485 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16eca09ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e5c579e80000


