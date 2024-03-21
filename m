Return-Path: <linux-kernel+bounces-110026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F354E885907
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C4F1F213D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABF7603C;
	Thu, 21 Mar 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lkj3c18Y"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0075811;
	Thu, 21 Mar 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023814; cv=none; b=KhrTgrYQDM0y/BwqRcth7s5vrxvSydjUbwAUojUBhFETCMP2gfVBuGdlk5ygJJSjfBmMxmmlj7S1slIhX4uZPeL7+/nuKIxPCCHalDN//2lsIHBIGwmhWj1avN8kPrykYaK3G4y9owvuvHFESmxA4OBnxzBapWg/4w37o6n1hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023814; c=relaxed/simple;
	bh=z0N29RLfNcOGlvR4fveRMkFS5KdyxhdBZ5rmI2uvv4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5kIvSFcAiXkph14S3ucStB2VCRWLOflNqI052aSxEPPuIay+KR4iBQ+GQTJ1hlYlZjPkPxgeWpd7oFThb3orbxELJb7X/ogwlL5RIcwvpEblFCwRgRUGRLtGtHXF+4lzkUYLn+5qeuJsTBj3JYF4wTWwNRFRzIBkBWoEdzO4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lkj3c18Y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bv5iaIHPCtllbUdTBibdobMZ0uFxV6D8XvDh1qKAPRc=; b=Lkj3c18YRRBepAzzJc64myDSZ6
	vTbXteiIViBqHGeU6E9lDwpYqA0nDPgbUdpNDKiKND3D3T7kC05v3NOAPvITBZ8sQH/gZ/oYjHuR0
	Jr9QRYKBkKGYOSs1J56y0aTRsIsA7gFEzzc4ioVpgPvb96lA+eVHPF27AqqLR96jTwaTeYsmli5DK
	6lHemPYIN4ZXJrAQ8ki1duGAs00GxSlSMT5x5tqU7qxB7/sU9bKdNQuB3hXCxVSDzBg5CdCm9aXGM
	t7xvvUgoUj6DAWZuSdv/CrgjYFfm8lenv+szEn2gueWVKhEgXbVFPfutWDZd7VNTtqWD43wt/75rk
	5W9R5S2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55568)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnHRo-0007XB-0R;
	Thu, 21 Mar 2024 12:23:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnHRi-0003dh-TB; Thu, 21 Mar 2024 12:22:58 +0000
Date: Thu, 21 Mar 2024 12:22:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Laight <David.Laight@aculab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	'Jiangfeng Xiao' <xiaojiangfeng@huawei.com>,
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
Message-ID: <ZfwmomjUwQdCefzh@shell.armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 21, 2024 at 12:07:51PM +0000, David Laight wrote:
> From: Russell King
> > Sent: 21 March 2024 11:24
> > 
> > On Thu, Mar 21, 2024 at 10:22:30AM +0000, David Laight wrote:
> > > How aggressively does the compiler optimise 'noreturn' functions?
> > 
> > I've seen cases where the compiler emits a BL instruction as the very
> > last thing in the function, and nothing after it.
> 
> I've also seen the compiler defer generating a stack frame until
> after an initial conditional.

. which is why we pass -mno-sched-prolog to GCC.

> That might mean you can get the BL in the middle of a function
> but where the following instruction is for the 'no stack frame'
> side of the branch.
> That is very likely to break any stack offset calculations. 

No it can't. At any one point in the function, the stack has to be in
a well defined state, so that access to local variables can work, and
also the stack can be correctly unwound. If there exists a point in
the function body which can be reached where the stack could be in two
different states, then the stack can't be restored to the parent
context.

> > This is where the problem lies - because the link register value
> > created by the BL instruction will point to the instruction after the
> > BL which will _not_ part of the function that invoked the BL. That
> > will probably cause issues for the ELF unwinder, which means this
> > issue probably goes beyond _just_ printing the function name.
> 
> Isn't this already in the unwinder?
> A BL itself isn't going to fault with PC = next-instruction.

You are missing the fact that the PC can be the saved LR, and thus
can very well be the next instruction.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

