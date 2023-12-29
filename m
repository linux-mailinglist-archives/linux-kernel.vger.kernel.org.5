Return-Path: <linux-kernel+bounces-12889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B068981FC22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DD6B23829
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85781FD3;
	Fri, 29 Dec 2023 00:08:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB881FA8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35ff54778ddso78557105ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703808484; x=1704413284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95vr8T8ggZqW3Bq9/rzgrnZasLlu5URfa7PcdoxQO9M=;
        b=kxUfdXk0gaQCUxHqREb2a4+JNwiTgNGHXtDR7efaV0gLtxGZwVhwuTCG+V+GucGFeW
         t0dD2/k2MLjFx6LwQF2038QeTOopvXFuSrPhfLEn2ZXm9l3XjBUvrM583C8coilASyZU
         lTuWnpBISw8yMs3bdMxG+8B7k1IZm/h6PWp9U5qbhL7ETVBg9V65sOAC/m09ly3olH2i
         mU3rjDoSCIQpEXWg/ETF05H7ygLw2LMmFLDhhqju5NqVl7sBNt12QpWnbn5k/Cup1osp
         KeYJvgMqAAA/Mkx90VKMr5OYhVVy6/N6pogeZ/pr2XpOe4fSKvtc0O/28Sex8P1ig4Cd
         G46g==
X-Gm-Message-State: AOJu0YyszyYo/xgQEps3cM2eEXg4fdmeRJwWz0hcbfgXweFyOTfCkv0F
	GJq00dovy5jxBNiBDnoqFP1+nqLJk+kI/SGYUSp2UnZNt4vg
X-Google-Smtp-Source: AGHT+IF3TVnlznYAut69c59r5kntV0NrB9WiRytLCXOxl9Mmahxqx1o5FRH4im/KkMKjj4sbAJVV0cdkELt98fGAhUtZaOLADmZ8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:35f:efdc:75b6 with SMTP id
 h18-20020a056e021d9200b0035fefdc75b6mr1169289ila.6.1703808484196; Thu, 28 Dec
 2023 16:08:04 -0800 (PST)
Date: Thu, 28 Dec 2023 16:08:04 -0800
In-Reply-To: <tencent_A16363296CC3BF645C7762576306DA737405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000774a19060d9ad3c8@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfsplus_ext_cache_extent
From: syzbot <syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __hfsplus_ext_cache_extent

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in __hfsplus_ext_read_extent fs/hfsplus/extents.c:170 [inline]
BUG: KMSAN: uninit-value in __hfsplus_ext_cache_extent+0x851/0x960 fs/hfsplus/extents.c:191
 __hfsplus_ext_read_extent fs/hfsplus/extents.c:170 [inline]
 __hfsplus_ext_cache_extent+0x851/0x960 fs/hfsplus/extents.c:191
 hfsplus_file_truncate+0x730/0xf50 fs/hfsplus/extents.c:598
 hfsplus_write_failed+0xab/0x100 fs/hfsplus/inode.c:42
 hfsplus_write_begin+0x12e/0x130 fs/hfsplus/inode.c:56
 generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
 __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4013
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4039
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable fd created at:
 hfsplus_file_truncate+0x5d/0xf50 fs/hfsplus/extents.c:547
 hfsplus_write_failed+0xab/0x100 fs/hfsplus/inode.c:42

CPU: 1 PID: 5490 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14922dcee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e443d9e80000


