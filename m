Return-Path: <linux-kernel+bounces-129586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B01896CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DCE1F2EC36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1D1386D9;
	Wed,  3 Apr 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZZmDoIIM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D587317F;
	Wed,  3 Apr 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140909; cv=none; b=GBN7FkYx8ujFY9YNJwUoQ6a0uuE/1yxpchAqDvyhs2w0YPTT+JLI25V95D4ZywAl0PJyeBDu45v5wZhqUvMP877tVqqFWyCcJ7QhVLml6tXJCLnTQf2mvIN6iBpSQKXqhSqJawvXvXxOy/Fls61BsUWTPNq67C4Am09u5OWcSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140909; c=relaxed/simple;
	bh=cHoh/mCyG8gbipvFz56gKADMWpWhqnpXGRpDRvSto80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwJ/i7kNAo3TOdNxonnJO8L3rMAaajQD1NgVjXJUGfivrQHvHGArhg87Kv0YlXfQPcmaPjLuSJMtdYgfwnJIqnUbH2q6wf3+H6xuG4Yv75rG+m1KfeJtnPASbUARIlkBITN85N9D0c4tmQJzXolxeySyhvHrvxo/X27jT066ZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZZmDoIIM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 765E140E019C;
	Wed,  3 Apr 2024 10:41:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YQ_zvYeI4oPH; Wed,  3 Apr 2024 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712140899; bh=UzSO7Jsp105welFJNWCbRP4AatEptaub1c50MMxUNFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZmDoIIMGNqv7EUCTpd7QdLG6HLKRWT3K3iNOjkn/oZo1Fyr2uQ2L/wM9IvjkRqCc
	 5ykgW2lz7lQwAwsKNYc9wZOQtFN3BuleIXiN7qWsE6ggLsWPtU6bEi1VU4GDdyuN62
	 pPK4d/CkMbM3GRSPtgUF8JBV/NXJrz2lVplv1VmcIoKyBV7n2BT3wjKexlGo97Qfy5
	 8EWV+W1z+jYmq5C1L79SyyeCZWZzGnZwfqIvv+rpQJYpn8sFg6KBcMDcoyFaH6SU8C
	 hjZPdnztDvR1/2q8PGHMaZTlIg5Ou3USmIS0bGPBZO+fQkYEKJnEUURQxMjmFdusoQ
	 bL4vZm1QF8ypb+2VHAx3oft5O1YHSH8iMspV59AbfovmcAh94yk+9hvhHe4AG9LM06
	 5LU/6BY/QTTwTLR5abHs3nv5N73pznAv9DleR1MdZhodBtcd+Ue2wPcJGtYxmDdBRF
	 AOJ4xWKrLbZsIyNdVCacgcZEX98jz9pNpI0nW3XtOTwXWOwsjPz0yuaJ/pggaHAM9d
	 SE4bfMeWLuQQshO3xZKOxWjtXMq9UKGBF7FUGnkg0a0t5aafj/tZxHX2imYs/tKizS
	 d2QO3FR1DA5j94nQxhlYqIMRRnM+QavBWs9wOcSvjtJnuHHgzkqcbpZESn2sZK6Xr8
	 rjIM/oahcos7rGLy3uLF63Kg=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 703FB40E019B;
	Wed,  3 Apr 2024 10:41:25 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:41:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Zeng Heng <zengheng4@huawei.com>
Cc: linux-tip-commits@vger.kernel.org,
	Jun'ichi Nomura <junichi.nomura@nec.com>,
	Derek Barbosa <debarbos@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [tip: x86/boot] x86/boot: Ignore NMIs during very early boot
Message-ID: <20240403104119.GAZg0yTyTAGe65FoxF@fat_crate.local>
References: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
 <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
 <95f416eb-a0ea-acba-6427-2a38d431ba8d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95f416eb-a0ea-acba-6427-2a38d431ba8d@huawei.com>

Hi Zeng Heng,

On Wed, Apr 03, 2024 at 02:32:45PM +0800, Zeng Heng wrote:
> Until just now, I saw your completely different responses to the same patch.

Lemme explain how I see the situation.

You sent a patch:

https://lore.kernel.org/all/20230110102745.2514694-1-zengheng4@huawei.com/

which had a commit message which tried to explain what happens. And
I tried to parse your commit message and understand what you're trying
to do but there never was a clear explanation.

When I read "If kdump is enabled, when using mce_inject to inject
errors..." then I think, oh great, more experiments. ;-\

And no, I don't want to add code to early boot just to make some weird
experiments happy.

Yeah yeah, an MCE can happen very early but until a real reproducer, I'm
not convinced.

Now that other patch's commit message has at least a bit more clear
explanation how you can *actually* cause this. And I still would've
asked how *exactly* this happens but it is kinda clear: you can run perf
and generate an NMI storm and then have two back-to-back NMIs.

And I'm still not crazy about having an empty early NMI handler either
thus I suggested to make it at least say something so that we're aware
that early NMIs have happened.

So if it is not clear *why* a patch is being done, then it goes nowhere.
Because you'll go your merry way and "develop driver software based on
arm64 features" or whatever else you get to do but the maintainers will
be left to be dealing with your code indefinitely.

I hope this makes it more clear.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

