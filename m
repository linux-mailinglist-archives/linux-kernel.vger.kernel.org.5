Return-Path: <linux-kernel+bounces-162481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9E8B5BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87341F2194E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C47E8172F;
	Mon, 29 Apr 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1vmX3/lo"
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0B80604
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401992; cv=none; b=mL2ZB2H3pZzI1q/N0kCI5OVJQ/cD5sHxueUq1O6xL9L8CfVRR82bOsijhViR73gU8rxny4KYwcYypIZlF/MwZ5V8Zgm+RBBqPaaoxxt6TAPVL6cQNFNjKRGDu9b0x1/zOosS1dtM+0dIRlA831gUPeGLKQ8xBewMWd42DqVN5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401992; c=relaxed/simple;
	bh=ZPYXNWtZgVhgJXwEodlMEK1xGAdzBeNDB4Dn1jTvHBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAX3S9ur/9qUJgL81rfSwV0hIjUkvFaBgimSow3PcJWyS3/Jj/lmDjFrSTY64TqytTAyEfxk29ZugBIujZFdsR7rVoXVBad60W9xfszVRDzPxjv5/fCalO3sQwovb3ykNA6JxxioNUgH4MWzLOSpMVSUP6TumxviJKic4tivp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1vmX3/lo; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSmNs2sPczCVc;
	Mon, 29 Apr 2024 16:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714401981;
	bh=ZPYXNWtZgVhgJXwEodlMEK1xGAdzBeNDB4Dn1jTvHBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1vmX3/lolLE2GryXLD5Hs8sDa+5RkY9f+2t2tMX3X8Sj73JCWdcxofA58YW4Ca/x/
	 G5gOzMcK9hwKO/RRz0XkLpWUG23sL0s4+Uto2tnBN5meKCF/5xBuQP/nelUmAC0726
	 TRgZvxv62ryr6+PsJDP9ESy1la6P8WDOtIptXfK0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSmNr6DWfzFnV;
	Mon, 29 Apr 2024 16:46:20 +0200 (CEST)
Date: Mon, 29 Apr 2024 16:46:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yaV0FSTklO?= =?utf-8?Q?G?= in
 current_check_refer_path
Message-ID: <20240429.ieR4Ajeitee5@digikod.net>
References: <c426821d-8380-46c4-a494-7008bbd7dd13.bugreport@ubisectech.com>
 <20240429.Iyohkaimiep1@digikod.net>
 <d36cf38a-a22a-44ec-b606-b58ccc559a47.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d36cf38a-a22a-44ec-b606-b58ccc559a47.bugreport@ubisectech.com>
X-Infomaniak-Routing: alpha

On Mon, Apr 29, 2024 at 05:16:57PM +0800, Ubisectech Sirius wrote:
> > Hello,
> 
> > Thanks for the report.  Could you please provide a reproducer?
> 
> > Regards,
> > Mickaël
> 
> Hi.
>   The Poc file has seed to you as attachment.

Indeed, but could you please trim down the file. There are 650 lines,
most of them are irrelevant.

> 
> > On Sun, Apr 28, 2024 at 10:47:02AM +0800, Ubisectech Sirius wrote:
> >> Hello.
> >> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.
> >> 
> >> Stack dump:
> >> 
> > > loop3: detected capacity change from 0 to 1024
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 30368 at security/landlock/fs.c:598 get_mode_access security/landlock/fs.c:598 [inline]
> > > WARNING: CPU: 0 PID: 30368 at security/landlock/fs.c:598 get_mode_access security/landlock/fs.c:578 [inline]
> > > WARNING: CPU: 0 PID: 30368 at security/landlock/fs.c:598 current_check_refer_path+0x955/0xa60 security/landlock/fs.c:758
> > > Modules linked in:
> > > CPU: 0 PID: 30368 Comm: syz-executor.3 Not tainted 6.7.0 #2
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > > RIP: 0010:get_mode_access security/landlock/fs.c:598 [inline]
> > > RIP: 0010:get_mode_access security/landlock/fs.c:578 [inline]
> > > RIP: 0010:current_check_refer_path+0x955/0xa60 security/landlock/fs.c:758
> > > Code: e9 76 fb ff ff 41 bc fe ff ff ff e9 6b fb ff ff e8 00 99 77 fd 90 0f 0b 90 41 bc f3 ff ff ff e9 57 fb ff ff e8 ec 98 77 fd 90 <0f> 0b 90 31 db e9 86 f9 ff ff bb 00 08 00 00 e9 7c f9 ff ff 41 ba
> > > RSP: 0018:ffffc90001fb7ba0 EFLAGS: 00010212
> > > RAX: 0000000000000bc5 RBX: ffff88805feeb7b0 RCX: ffffc90006e15000
> > > RDX: 0000000000040000 RSI: ffffffff84125d64 RDI: 0000000000000003
> > > RBP: ffff8880123c5608 R08: 0000000000000003 R09: 000000000000c000
> > > R10: 000000000000f000 R11: 0000000000000000 R12: ffff88805d32fc00
> > > R13: ffff8880123c5608 R14: 0000000000000000 R15: 0000000000000001
> > > FS:  00007fd70c4d8640(0000) GS:ffff88802c600000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001b2c136000 CR3: 000000005b2a0000 CR4: 0000000000750ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  security_path_rename+0x124/0x230 security/security.c:1828
> > >  do_renameat2+0x9f6/0xd30 fs/namei.c:4983
> > >  __do_sys_rename fs/namei.c:5042 [inline]
> > >  __se_sys_rename fs/namei.c:5040 [inline]
> > >  __x64_sys_rename+0x81/0xa0 fs/namei.c:5040
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x43/0x120 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > > RIP: 0033:0x7fd70b6900ed
> > > Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fd70c4d8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> > > RAX: ffffffffffffffda RBX: 00007fd70b7cbf80 RCX: 00007fd70b6900ed
> >>  RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000020000100
> > > RBP: 00007fd70b6f14a6 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 000000000000000b R14: 00007fd70b7cbf80 R15: 00007fd70c4b8000
> > >  </TASK>
> > > 
> > > Thank you for taking the time to read this email and we look forward to working with you further.
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > 
> > 
> > 
> 
> 



