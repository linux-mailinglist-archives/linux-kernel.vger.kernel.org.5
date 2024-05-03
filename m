Return-Path: <linux-kernel+bounces-167375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4228BA89D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5931F22AD8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571A14885A;
	Fri,  3 May 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eKXGJ8b5"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479B148313;
	Fri,  3 May 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724626; cv=none; b=uIVHxBUjEo/78CADI9lv3GhRzbvcX22PRuJWr4sqny8B4s+BlK2imKWQdku2gkNSbpJJz9nlzaRLIVc3bxSzbpY5h1oG6Uhfas9TahZoxGJv/f7FeheH73m3Z1NC2paslB9JF/QVxwa4FAhIj5i7xQW47O32eVKh7Ukpdk64MDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724626; c=relaxed/simple;
	bh=fi9zfNvu7Hehmv5yf396y1MMHBBl915r8w1/oBAejqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycrx32jQEaRhAcruQKu/mNdTyK8L/PGW+Fow9Ng3soE8SFjpR5QjTzbc2gNSuR1qSt9ZE9yXSpjJVZRX5wp/S19uFE65Yi5wqlDANcAshAb5zG4gcvYIemUyQM7FUW3BC0iBoByUKBSCx35gs2mg1oxZNnJTxgJ1y82bWTJsFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eKXGJ8b5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bJqgkSNI0KMYKMaZpLNc2ZcSIXK696qy5pXy2UUEZzk=; b=eKXGJ8b5nugmkV+Y+179pTdmgT
	XcY5uxNGvhZNQDz6T2nqWlrbPG7nq9xGdUqcruyO/PCL/uXEO4vWgzXonANSMPtmqPDVLX/WA0SPy
	6TEQXe/YdIX6kUVrD6zaNCWA04XVWL9j+IiG5UDH8oBhGgKQad2wjzAGpBcLioVk2Qa8DHZYk9YbA
	i4DRNKiE3s4jLoIgmlC1RUkpch1InTudk/EEnt0TufMVdmujUJYFjNaBPKziXWivna/r8kSqtkWGO
	8KC1EzY63R2JDH17LRJ9M0fSxTjXCYQauSPMts6IESRSieX2GdME8qGiBKqWICPCU6H0bxUYb/uf+
	QTsYUpGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2oCh-000873-1e;
	Fri, 03 May 2024 09:23:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2oCi-0004Rt-Sp; Fri, 03 May 2024 09:23:40 +0100
Date: Fri, 3 May 2024 09:23:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm tree
Message-ID: <ZjSfDGh+yqndr9ya@shell.armlinux.org.uk>
References: <20240503101516.09f01e44@canb.auug.org.au>
 <ZjSduO+MI7EA3O9A@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjSduO+MI7EA3O9A@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 03, 2024 at 09:18:01AM +0100, Russell King (Oracle) wrote:
> On Fri, May 03, 2024 at 10:15:16AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the arm tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> > drivers/clk/clkdev.c:195:16: error: assignment to '__va_list_tag (*)[1]' from incompatible pointer type '__va_list_tag **' [-Werror=incompatible-pointer-types]
> >   195 |         fmt.va = &ap;
> >       |                ^
> > cc1: all warnings being treated as errors
> 
> This builds perfectly fine for me - this is on debian stable with
> arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110:
> 
>   CC      drivers/clk/clkdev.o
>   AR      drivers/clk/built-in.a
>   AR      drivers/built-in.a
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
>   OBJCOPY modules.builtin.modinfo
>   GEN     modules.builtin
>   MODPOST Module.symvers
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   LD      .tmp_vmlinux.kallsyms1
>   NM      .tmp_vmlinux.kallsyms1.syms
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   NM      .tmp_vmlinux.kallsyms2.syms
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   NM      System.map
> 
> No warnings, no errors.
> 
> va_format is defined as:
> 
> struct va_format {
>         const char *fmt;
>         va_list *va;
> };
> 
> and what we have here is a "va_list ap".
> 
> Therefore, the assignment:
> 
>         fmt.va = &ap;
> 
> is correct.
> 
> What certainly won't work is:
> 
> 	fmt.va = ap;
> 
> and there aren't any other reasonable alternatives.
> 
> My conclusion: your compiler is being stupid.

.. and even more evidence that your error is strange:

void __ext4_error(struct super_block *sb, const char *function,
                  unsigned int line, bool force_ro, int error, __u64 block,
                  const char *fmt, ...)
{
        struct va_format vaf;
        va_list args;

                vaf.fmt = fmt;
                vaf.va = &args;

Now, looking at __ext4_error(), it seems that va_start()..va_end()
need to be around this - but why this oddity? None of the other printing
functions like vsnprintf() require it? Why do we have this pitfall?
Why isn't this oddity documented anywhere?

However, I don't see that lack of va_start() etc would cause a type
error.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

