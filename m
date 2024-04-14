Return-Path: <linux-kernel+bounces-135132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C85589BB7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC08B23D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B2E45946;
	Mon,  8 Apr 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qbszd7Aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F03FBBE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567967; cv=none; b=jyoCQvz6OTNWnR8xNIesBmQANW261W99ln6sQJncWsRfuH8xxNhqs2y4vWD0TqE7dfnPY3YEN10qabKbrs9m50Q1GHNFmiC7k/hyXkByDd3+cknJZya4p6p7iNOQOMCg999Y6hvvKjlyk2bbuJNEPRzHSmVP/3FKPK7+7XdkZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567967; c=relaxed/simple;
	bh=lM8w3tn5AAvQKCD7yYmQlWmfw+1oLvifWiwW0bJQ7Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNd/UAtzwx8cpIwiQMxGsY6Q0y8nrQXQbGdDYjgkmOUa1UluuRht+CXht1na7X+C3gtNRN1iTpvCMPiHRHXLTg5eYhp2ashIxfQyT2hrn58Kamr68RPKo010Cc4hAPBEz2G6JQvkMU5mU9Y80jBp/xMf1x9bVWzaW3r7ngOlIKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qbszd7Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1119AC433C7;
	Mon,  8 Apr 2024 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712567966;
	bh=lM8w3tn5AAvQKCD7yYmQlWmfw+1oLvifWiwW0bJQ7Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qbszd7AjYBdlafO7ZjZkGWxSifIDGZLkgYTyZaHKJE5D8J8olVWGFWqIgLOjyIoyc
	 FReMbxW077bk4cIHG/1XIOJkycForZUSN8torcljMEgGfXPu1j9FHJqLmAMJB3txw/
	 LfyKlKITheQR/spI8FU3oNzVPHegEE0hxHSoGAGeMREz7I3AJv7g/QA4Rdn1HAh07w
	 jDz8APqrVjwUKMRtDvT1p9YI9MWXwR0QTkSwmiuwpuUGriCRltsvzvB7w/mtL2Y6f0
	 9rXp+lyZra/HVWf6dqO7tvkosSUixhPejzSsmCBkwbvufDSGWNqtQCYEs+QH4U/d+6
	 3SWVRP3dN4v5Q==
Date: Mon, 8 Apr 2024 11:19:21 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+05e63c0981a31f35f3fa@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [syzbot] [mm?] general protection fault in shmem_get_next_id
Message-ID: <lqxgvg4mjyo5togrvrzz44agdnzcxap7i34vbtsf7hglydnuy2@7rzx5wnulqtf>
References: <000000000000a1ff78061517a148@google.com>
 <hgK3SYtGnWjzLbOQ_fdQNLYxKsQF05DY6Zsw62PEgIEFbIMC9cQqz4rx0twm_rQY_JO8IoPT074TBcvYnML1Kg==@protonmail.internalid>
 <20240403183339.7a257066e79ac04a7d6e33fd@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403183339.7a257066e79ac04a7d6e33fd@linux-foundation.org>

On Wed, Apr 03, 2024 at 06:33:39PM -0700, Andrew Morton wrote:
> On Mon, 01 Apr 2024 23:58:20 -0700 syzbot <syzbot+05e63c0981a31f35f3fa@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> 
> Hello.
> 
> Seems that the new TMPFS_QUOTA code has blown up.  Cc's added, thanks
> for the report and the reproducer!

Thanks Andrew,

I'm adding it to my todo list, and will take a look on it ASAP.

Carlos

> 
> > syzbot found the following issue on:
> >
> > HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c90795180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=05e63c0981a31f35f3fa
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f51129180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150d3cee180000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+05e63c0981a31f35f3fa@syzkaller.appspotmail.com
> >
> > general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 0 PID: 5070 Comm: syz-executor253 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > RIP: 0010:shmem_get_next_id+0x92/0x5c0 mm/shmem_quota.c:119
> > Code: 04 db 49 8d 9c c6 90 02 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 f8 66 1b 00 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 df 66 1b 00 4c 8b 23 48 8d 5d 07
> > RSP: 0018:ffffc900043a7be0 EFLAGS: 00010256
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880266c8000
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
> > RBP: ffffc900043a7d00 R08: ffffffff81dcdd47 R09: ffffffff822e7d5a
> > R10: 0000000000000003 R11: ffffffff81dcdcf0 R12: 1ffff92000874fa0
> > R13: ffff888022110000 R14: ffff888022110000 R15: dffffc0000000000
> > FS:  0000555578677380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020001000 CR3: 000000007a384000 CR4: 0000000000350ef0
> > Call Trace:
> >  <TASK>
> >  dquot_get_next_dqblk+0x75/0x3a0 fs/quota/dquot.c:2705
> >  quota_getnextquota+0x2c7/0x6c0 fs/quota/quota.c:250
> >  __do_sys_quotactl_fd fs/quota/quota.c:1002 [inline]
> >  __se_sys_quotactl_fd+0x2a1/0x440 fs/quota/quota.c:973
> >  do_syscall_64+0xfd/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7f5c0349b329
> > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffc39d71138 EFLAGS: 00000246 ORIG_RAX: 00000000000001bb
> > RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f5c0349b329
> > RDX: 0000000000000000 RSI: ffffffff80000901 RDI: 0000000000000003
> > RBP: 00007f5c0350e610 R08: 0000000000000000 R09: 00007ffc39d71308
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffc39d712f8 R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:shmem_get_next_id+0x92/0x5c0 mm/shmem_quota.c:119
> > Code: 04 db 49 8d 9c c6 90 02 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 f8 66 1b 00 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 df 66 1b 00 4c 8b 23 48 8d 5d 07
> > RSP: 0018:ffffc900043a7be0 EFLAGS: 00010256
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880266c8000
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
> > RBP: ffffc900043a7d00 R08: ffffffff81dcdd47 R09: ffffffff822e7d5a
> > R10: 0000000000000003 R11: ffffffff81dcdcf0 R12: 1ffff92000874fa0
> > R13: ffff888022110000 R14: ffff888022110000 R15: dffffc0000000000
> > FS:  0000555578677380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020001000 CR3: 000000007a384000 CR4: 0000000000350ef0
> > ----------------
> > Code disassembly (best guess):
> >    0:	04 db                	add    $0xdb,%al
> >    2:	49 8d 9c c6 90 02 00 	lea    0x290(%r14,%rax,8),%rbx
> >    9:	00
> >    a:	48 89 d8             	mov    %rbx,%rax
> >    d:	48 c1 e8 03          	shr    $0x3,%rax
> >   11:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
> >   16:	74 08                	je     0x20
> >   18:	48 89 df             	mov    %rbx,%rdi
> >   1b:	e8 f8 66 1b 00       	call   0x1b6718
> >   20:	48 8b 1b             	mov    (%rbx),%rbx
> >   23:	48 89 d8             	mov    %rbx,%rax
> >   26:	48 c1 e8 03          	shr    $0x3,%rax
> > * 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
> >   2f:	74 08                	je     0x39
> >   31:	48 89 df             	mov    %rbx,%rdi
> >   34:	e8 df 66 1b 00       	call   0x1b6718
> >   39:	4c 8b 23             	mov    (%rbx),%r12
> >   3c:	48 8d 5d 07          	lea    0x7(%rbp),%rbx
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

