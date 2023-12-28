Return-Path: <linux-kernel+bounces-12703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3860E81F91A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97D2284EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995DF4FA;
	Thu, 28 Dec 2023 14:32:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41BE56D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35ff7c81f4aso39752615ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703773924; x=1704378724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3y+mx3ZbG/VWu7Syp53uyO6K/G7sLGcvq9q1dwWggrQ=;
        b=oXt7Rpc/7vc66ebMzY2yfNWQVt2AmwyHYQg/ST18wKL03/ajx3qdad0/ugVeUd3PDI
         6eLZ8FalSuSC/NkC4OybZwppFqOwh8a0NtgQ0GJqCrwLMRVPIja4xythOaXVR3fPkxwu
         dF1Hcxe/50AbmVpN/9WurXPJ9+SPPh3ZlgTzd3JCvkwTCgHZyjEtXVPlXH6HsG6g/qPe
         cHRABFdVSARPZFIY70eSy4XSvm3E/a+is3seoVMcOJjIGGFJLjuZac7qgy0lL9G3HQUD
         0Fs2gXjOf7//J9Ofy3goXihcz1Xi+BA3boY/teSoIRrZhKAb/5Key54fkPlqCJLdeCzx
         apEw==
X-Gm-Message-State: AOJu0YxPYfUxwqxFge5qd7XtCcmGP8hO8fu32bsr3TOlMgWoKo0RJOwF
	uGyflI8/G9X1xxCZj+MOcn60OI5lL5Ml2oneqOUQoRLQ+S/g
X-Google-Smtp-Source: AGHT+IF7OfdjhSgYW/Gwwr44ZQs1Hfeh8f28otmwwoAlvVz9SRzd+G7ddgmbd8GKoQ106h8RAyfY0CPbM3ajxgLY81eAfSO6dlEj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:eb20:3599 with SMTP id
 s7-20020a056e021a0700b0035feb203599mr956226ild.2.1703773923904; Thu, 28 Dec
 2023 06:32:03 -0800 (PST)
Date: Thu, 28 Dec 2023 06:32:03 -0800
In-Reply-To: <tencent_5E3C1D3628961837D24ACA7447769967B009@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000831818060d92c78d@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in z_erofs_lz4_decompress

loop0: detected capacity change from 0 to 16
erofs: (device loop0): mounted with root inode @ nid 36.
erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -12 in[46, 4050] out[917]
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
 z_erofs_lz4_decompress+0x2624/0x2b30 fs/erofs/decompressor.c:311
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
 z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
 z_erofs_runqueue+0x36cd/0x3830
 z_erofs_read_folio+0x435/0x810 fs/erofs/zdata.c:1843
 filemap_read_folio+0xce/0x370 mm/filemap.c:2323
 do_read_cache_folio+0x3b4/0x11e0 mm/filemap.c:3691
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 do_read_cache_folio+0x163/0x11e0 mm/filemap.c:3655
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5477 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14751455e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128ea2a1e80000


