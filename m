Return-Path: <linux-kernel+bounces-167640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3C8BAC88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CE21F22F07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D514BFA8;
	Fri,  3 May 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="avVItQ1N"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63518C3D;
	Fri,  3 May 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739396; cv=none; b=sBEAG/9ELksz0awMvvXW+ClmSqA5AtdG2DxeVkSDI/vDkKplgmMO2LijB4C3s+RmqPruYfSv+7iV0dey07AfzYj8O4h+ar8yo8ygI9wZojQrdxitIzfygmjjbfKKPplxe2rPNosnMcUcdobL0VUd4RUOehp11cQ8Zi/oLHHMOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739396; c=relaxed/simple;
	bh=e0n/TGXxwB9sJ48pgnHjIMk7j4yTJJ513iQPc6r5xv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuwBAPWphfSRSFT01TAzEHy9BEqEeZIdFpLF/XGtGmdqtEt5bqnaOs/PliEtTwRhABeQWsPrkA1XrI7vprHkdUUfugv5RprQGLidgk4xrheLEX5KleadSAh153bJRXeBWgkJfwXDJMKri6RkgNeUtSYH0+a9ZXuOIj+nwwdpZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=avVItQ1N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S0UJPqXtsVag5h+QuENMSLncR/6k7COzDF1p8qBCEHw=; b=avVItQ1NOJVtLkOkOlSb/6AU1P
	HGpsPtACY47xIcbHRe5euJXrEHeXS2GIPzI+H/4t8y9ngM886Imc981km10xGtYcvRNtT82zHOWXI
	k7Z7WDD/+qqJSrVPd6Lsl6LrsHyqcg+Cm+kEQ14F+WyXUXMtUN8L9VFD/DrPpGqMKSASHyq3dzUcA
	9AL4YdI5giRHWHecNwJ9uGQ2llgqAlBrl76CZMCsrkq7vPV7yrY1DE79o5KXsvP8V5cN6H1dHgBpU
	RGWOJdcc7CtFh97mu68Fu5jlABxq8pyrxoUkgkI9HJ81BpeBllTSZCpf2+0vhcYDnDdKFSAdIpmzT
	seqE/ZFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43680)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2s2u-0008Lz-1E;
	Fri, 03 May 2024 13:29:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2s2v-0004aO-Ch; Fri, 03 May 2024 13:29:49 +0100
Date: Fri, 3 May 2024 13:29:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm tree
Message-ID: <ZjTYvarXbn5eVPFT@shell.armlinux.org.uk>
References: <20240503101516.09f01e44@canb.auug.org.au>
 <ZjSduO+MI7EA3O9A@shell.armlinux.org.uk>
 <20240503220826.48a59ffd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503220826.48a59ffd@canb.auug.org.au>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 03, 2024 at 10:08:26PM +1000, Stephen Rothwell wrote:
> Hi Russell,
> 
> On Fri, 3 May 2024 09:18:00 +0100 "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >
> > On Fri, May 03, 2024 at 10:15:16AM +1000, Stephen Rothwell wrote:
> > > 
> > > After merging the arm tree, today's linux-next build (x86_64 allmodconfig)
> > > failed like this:
> > > 
> > > drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> > > drivers/clk/clkdev.c:195:16: error: assignment to '__va_list_tag (*)[1]' from incompatible pointer type '__va_list_tag **' [-Werror=incompatible-pointer-types]
> > >   195 |         fmt.va = &ap;
> > >       |                ^
> > > cc1: all warnings being treated as errors  
> > 
> > This builds perfectly fine for me - this is on debian stable with
> > arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110:
> > 
> > No warnings, no errors.
> > 
> > va_format is defined as:
> > 
> > struct va_format {
> >         const char *fmt;
> >         va_list *va;
> > };
> > 
> > and what we have here is a "va_list ap".
> > 
> > Therefore, the assignment:
> > 
> >         fmt.va = &ap;
> > 
> > is correct.
> > 
> > What certainly won't work is:
> > 
> > 	fmt.va = ap;
> > 
> > and there aren't any other reasonable alternatives.
> > 
> > My conclusion: your compiler is being stupid.
> 
> Definitely possible.  My build is an x86_64 allmodconfig cross build
> hosted on PowerPC64LE.
> 
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 13.2.0-7) 13.2.0
> 
> It still fails for me even just building your tree.  :-(
> 
> And if I revert commit 5d998425e37b it does not fail (of course).

So I think the questions are...

1) why does this fail with this compiler?

2) why does this instance fail, when we have plenty of other instances
in the kernel doing the same thing? (grep vaf fs/)

I'm wrong about the va_start()/va_end() - those are done in the
caller, e.g. clkdev_create() does the va_start..va_end before
passing the va_list to vclkdev_create() which then passes it down
to vclkdev_alloc(). So it would be wrong to add another va_start()
in vclkdev_alloc().

The only thing I can think of doing is something like:

#ifdef CONFIg_X86_64
	pr_error("%s:%s ID is greater than %zu\n",
		 "[compiler error - unreportable device]",
        	 con_id, failure, max_size);
#else
	{
		struct va_format fmt;
	        fmt.fmt = dev_fmt;
	        fmt.va = &ap;
	        pr_err("%pV:%s: %s ID is greater than %zu\n",
        	       &fmt, con_id, failure, max_size);
	}
#endif
	kfree(cla);
	return NULL;

which would be better than nothing... but really we shouldn't be
working around what looks to me like a compiler bug like this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

