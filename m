Return-Path: <linux-kernel+bounces-111251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D098869BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305CD1C21C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B5618EC3;
	Fri, 22 Mar 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y384k+jz"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED717575;
	Fri, 22 Mar 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101172; cv=none; b=DcF8KeEtOn99TKewVAlxdlNGpeRcfngtAVfRZXOKTslIqAvARVyDbqCl6tZsRHt3F3DiPYdtHtbXcdsbX/58WGNppXeGeY2sl73OohynR8nr4ePDQOOMWcYfcUX7z6+mApLjXENyhqa5fPyQ/PTVTB5Dj+ss9jHxp3BQH778zU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101172; c=relaxed/simple;
	bh=bOhLcsYDVZmhBgEUm4A+AenfvHCVdl7QYceTR0y7L2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f60irZwXF1ONF2rI1tL7iaer3o9vpfyJpjCINhtDjk93c6JO0bSwCgQdg1JaBr4Dpo1eJ+pFqqb0iXAduoZnw8Iqal7ZLllwrnyiRnWwBQ922eMBESFQ6ry/NplQPrm9c0728UfiZbGi5vQsj/GvaUB46/+tHwOUvdHzY172Nv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y384k+jz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uY3ErBRSm13BWg/PRQDPTz4nkc8UUIhrKSwSU3A1w7U=; b=Y384k+jzKaq1zpLti0tPPj9ga5
	MNe50rOqiaFr4DqqJtrpa5NP1INK5UeoY34zpnnSteBYYYUajBQLdyy1U9zWiG+/kgjgaffsnzQ0J
	1keQ8qPvs8MHWpN9QXTeEvBiMg37vNC0qwPQC6JVGIqKs563vXAJ37YbSJ/xvT1xWHIYRjFp09otU
	OYbqxq5EXKWY+ARCABdGy8Xr+tcpLKRNzl9CkkLqGLgIuRiYdgvSwbhg5xAHUwuUWE8ENBgmH0jfX
	0NETo0ksPxJpcda3ZrZALDQO0wDdwRAhbd5TkOsT9YkqP+rFlBporRUq1fni/+o8sTOcKBTxNe/N3
	jgcRP+Wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnbZT-0000BM-0N;
	Fri, 22 Mar 2024 09:52:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnbZL-0004bs-DT; Fri, 22 Mar 2024 09:52:11 +0000
Date: Fri, 22 Mar 2024 09:52:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Laight <David.Laight@aculab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jiangfeng Xiao <xiaojiangfeng@huawei.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"haibo.li@mediatek.com" <haibo.li@mediatek.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"douzhaolei@huawei.com" <douzhaolei@huawei.com>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"kepler.chenxin@huawei.com" <kepler.chenxin@huawei.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"nixiaoming@huawei.com" <nixiaoming@huawei.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"wangbing6@huawei.com" <wangbing6@huawei.com>,
	"wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
	"jannh@google.com" <jannh@google.com>,
	"willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Message-ID: <Zf1UyxlDf/oCjXxr@shell.armlinux.org.uk>
References: <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
 <ZfzMFv3zmYY36l9u@shell.armlinux.org.uk>
 <2b2993fb215c4a5abd7d77ff1c984113@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2993fb215c4a5abd7d77ff1c984113@AcuMS.aculab.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 22, 2024 at 09:24:20AM +0000, David Laight wrote:
> From: Russell King
> > Sent: 22 March 2024 00:09
> > 
> > On Thu, Mar 21, 2024 at 11:43:41PM +0100, Ard Biesheuvel wrote:
> > > Given that this particular issue would just disappear if the compiler
> > > would just insert a BRK after the BL, I'd prefer to explore first
> > > whether we can get this fixed on the compiler side.
> > 
> > Arm32 doesn't have a BRK instruction. What would be appropriate after
> > the no-return BL would be OS specific.
> 
> It would need to depend on what was being compiled.

Yes, but as for the rest...

> For the kernel it could be much the same as BUG().
> (Probably without any extra data.)
> I suspect that arm32 could use 'swi' in kernel space,
> but you wouldn't want to use that in userspace.
> 
> Looks like armv5 has a bkpt instruction - could that be used?
> Or does the kernel need to support armv4?
> 
> The last arm I wrote anything for was a strongarm.

Thank you David, but remember - I have programmed 32-bit Arm since 1992,
and wrote the majority of the 32-bit Arm kernel support. I think I know
what I'm walking about by now.

The compiler can't do the same as BUG() - that is a kernel specific
construct and not an architecture one. It is an undefined instruction
specifically chosen to be undefined on both 32-bit and 16-bit Arm ISAs.

As for your idea of using "swi" in kernel space, no that's never going
to happen - to shoe-horn that into the SWI exception path for the sake
of the compiler would be totally idiotic - it would cause userspace
performance regressions for something that never happens. Moreover,
with EABI the "comment" field in the "swi" instruction is ignored so
all SWIs under EABI are treated the same. So no, that's not going to
work without causing inefficiencies - again - for a case that will
likely never happen.

Whereas we already provide an abort() function because iirc the
compiler used to emit branches to that due to noreturn functions. If
correct, there's previous convention for doing this - and abort() is
still exists in the kernel and in userspace since it's part of ANSI
C. This would be a more reliable and portable solution, but probably
not for embedded platforms - and that's probably why it got removed.

There isn't going to be a single solution to this which satisfies
everyone, and I don't blame the compiler people for deciding to
basically give up with putting any instruction after a call to a
no-return function - because there isn't an instruction defined in
the architecture that _could_ be put there that would work everywhere.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

