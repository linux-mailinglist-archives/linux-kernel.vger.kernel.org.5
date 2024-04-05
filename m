Return-Path: <linux-kernel+bounces-132913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE2899BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3901F2340C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A216C6A5;
	Fri,  5 Apr 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bfGUHewc"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1E16C426;
	Fri,  5 Apr 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316965; cv=none; b=q4H6FLltZnNADOkEDYFv7xxBcv0ucaosjT1DoBdtf0SFJOitmU1oPl+/Y9rYaVa5svTGmIkNIooszBfF57n4h1Y3vvA08LNy4VzidR9QTvb1uBy33c+F3ticR37iqC63EKo3tvaZUcU6gBNu5K+Wxw0ZUL8LyxMja8ZzDC9QFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316965; c=relaxed/simple;
	bh=dtcfj64x/DbH4J83jgaQf165/61rA70kiyeU0XQuti4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCvcwpTPcVJOeG/Vp/tvf0AjRPkT5Kdu5MsoOo6eOe6lLl8hT5LXyCkRoAXi5XaNwRx9/ZoqTpmrtf287stub8X4gsX33Nmn7XoeGTCbUb8BYREuj01iI0ZSNeRI7f9sUJ/hwM8ybUA/SYV8rguydYJZsBOEDX5XYVYjA+N3zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bfGUHewc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CJp1+BJnCHioQp+DU63SJcb4jsAzGQK2w3ccuNxWycw=; b=bfGUHewcFdVduY14Pq0OjeGyw1
	DpsgB0719rKoZwgF59u1emrB+ni9APzRlZR2mj7y3RKBu97MbBOryjmhDGg44GnsTDbdGV6Uo1qik
	gMTgK9hf8lR5Bk1FVdP7aFcANuQ8fXXJDJR6ShiGc78/M9oR5pGFeDYm545rHVubsTmIY8K9hUowr
	B7xj2sua2+QBBOykDkyQFwT9q01gGnnlrGP5GN8gD8l4I9a55He3umjnlmnp0nh6opemh9Rz0wEFe
	LelDLVkXUEi4seOr7CPtm1Gc+7SXKXPs1t7CbhMFAT1cln6K5F2pDghulJ0KwiAA9hDw2l6LubVoD
	39s+mJMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53358)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rshrP-0002K6-1N;
	Fri, 05 Apr 2024 12:35:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rshrN-0001Lz-RJ; Fri, 05 Apr 2024 12:35:53 +0100
Date: Fri, 5 Apr 2024 12:35:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
Message-ID: <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk>
References: <000000000000e9a8d80615163f2a@google.com>
 <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
 <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
 <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 05, 2024 at 12:02:36PM +0100, Mark Rutland wrote:
> On Thu, Apr 04, 2024 at 03:57:04PM -0700, Alexei Starovoitov wrote:
> > On Wed, Apr 3, 2024 at 6:56 PM Andrew Morton <akpm@linux-foundationorg> wrote:
> > >
> > > On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com> wrote:
> > >
> > > > Hello,
> > >
> > > Thanks.  Cc: bpf@vger.kernel.org
> > 
> > I suspect the issue is not on bpf side.
> > Looks like the bug is somewhere in arm32 bits.
> > copy_from_kernel_nofault() is called from lots of places.
> > bpf is just one user that is easy for syzbot to fuzz.
> > Interestingly arm defines copy_from_kernel_nofault_allowed()
> > that should have filtered out user addresses.
> > In this case ffffffe9 is probably a kernel address?
> 
> It's at the end of the kernel range, and it's ERR_PTR(-EINVAL).
> 
> 0xffffffe9 is -0x16, which is -22, which is -EINVAL.
> 
> > But the kernel is doing a write?
> > Which makes no sense, since copy_from_kernel_nofault is probe reading.
> 
> It makes perfect sense; the read from 'src' happened, then the kernel tries to
> write the result to 'dst', and that aligns with the disassembly in the report
> below, which I beleive is:
> 
>      8: e4942000        ldr     r2, [r4], #0	<-- Read of 'src', fault fixup is elsewhere
>      c: e3530000        cmp     r3, #0
>   * 10: e5852000        str     r2, [r5]	<-- Write to 'dst'
> 
> As above, it looks like 'dst' is ERR_PTR(-EINVAL).
> 
> Are you certain that BPF is passing a sane value for 'dst'? Where does that
> come from in the first place?

It looks to me like it gets passed in from the BPF program, and the
"type" for the argument is set to ARG_PTR_TO_UNINIT_MEM. What that
means for validation purposes, I've no idea, I'm not a BPF hacker.

Obviously, if BPF is allowing copy_from_kernel_nofault() to be passed
an arbitary destination address, that would be a huge security hole.
So I think BPF folk need to urgently state what checks are done on
the destination value for _any_ function that BPF can call which
writes to memory.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

