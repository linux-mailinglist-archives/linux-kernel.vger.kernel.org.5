Return-Path: <linux-kernel+bounces-79508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D43862361
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7ED8283E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F44171AC;
	Sat, 24 Feb 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="biI3Or3M";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Qm5OuQ19"
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDE13FEA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708761564; cv=none; b=TIyxWGxHw8bwHcUP9LlvUMVdNTKXBhJqiCcTZnASd01y36MV6kRAbhVz9i5zdSzKoObhoQxJbTMhvnBksn4peJTqxnBYh9A5i46oFAzh4fjuAWueMOyoSknncpedAK0pF13GxtlmZmHW28J73IDGAYoTU2+cBI/jID4wsfODAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708761564; c=relaxed/simple;
	bh=IqUhJWwmMonEc4OhD9ftFsdV7ar9wnvzL/o/+DIhCYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQbUMHdD3mAFnQE5REqNRKCQEv9WyguB4pNiI/hEu/bcT1cYZuedtQm0iFKvwjJCy3letaeXkw9P1afHaPPLbYMAjXWkdvl9zpgiUcQ0hagVEem2LWWh4nM1GJOQOljTRdTcYu7HOTNdpd2FudPWUGjzA6cRORhQQPIM5voL40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=biI3Or3M; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=Qm5OuQ19; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=o1C0+AUnLT8vTzsLkx6TlC4ol/MArNCmdQKVohEbTME=;
	b=biI3Or3MPGuNThyjSNHLBfM+7SAl7NgxbyRm84iNa8Qi4Ygtd+Sb0zDCrAGETln1hhQyweMNnTMyC
	 O/62jNcK1EZxtQjYvVcmnVuuY15vjnlFd6wxKxHEUVoM6EvAkWLgimgLwJWcIWcBNfderduy/mVQwc
	 jegtqJB6zRk2iK14XYIGCDIBtfn51SNNZnfhSJ+/bkvBI6KxQCVXB9qVSj7qyZ+szW4RITSX1HrbBQ
	 zO2ACtB4gH8aBsDc6HtQoE/QPsbbyof8QPjMlYlpeGkrdziMr53e1N4ImGJdLM5T2gwGdgjDfEvMm8
	 c1CIQ4F2tIINy5CBvXyzTY3HQ0YWjGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=o1C0+AUnLT8vTzsLkx6TlC4ol/MArNCmdQKVohEbTME=;
	b=Qm5OuQ19rFGKkAWIAgie/8SWj3TvXY5EkixcA8OYt8qG5b8sqYs+fCVlBR3Iwyz7Z9WiQFBZ0PxV0
	 GYOW35SDA==
X-HalOne-ID: 9c373c13-d2ea-11ee-b3bd-657a30c718c6
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 9c373c13-d2ea-11ee-b3bd-657a30c718c6;
	Sat, 24 Feb 2024 07:59:19 +0000 (UTC)
Date: Sat, 24 Feb 2024 08:59:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, sparclinux@vger.kernel.org,
	linux-parport@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc32: Do not select GENERIC_ISA_DMA
Message-ID: <20240224075918.GB2959352@ravnborg.org>
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
 <alpine.DEB.2.21.2402240235570.61493@angie.orcam.me.uk>
 <alpine.DEB.2.21.2402240458100.61493@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2402240458100.61493@angie.orcam.me.uk>

Hi Marciej,

On Sat, Feb 24, 2024 at 05:29:43AM +0000, Maciej W. Rozycki wrote:
> On Sat, 24 Feb 2024, Maciej W. Rozycki wrote:
> 
> > > sparc32 do not support generic isa dma, so do not select the symbol.
> > > Without this fix, the following patch would break the build with a
> > > missing prototype.
> > 
> >  Not according to my observations, kernel/dma.c is always built for 
> > GENERIC_ISA_DMA configurations, so:
> > 
> > kernel/dma.c:70:5: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]
> >    70 | int request_dma(unsigned int dmanr, const char * device_id)
> >       |     ^~~~~~~~~~~
> > kernel/dma.c:88:6: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]
> >    88 | void free_dma(unsigned int dmanr)
> >       |      ^~~~~~~~
> > 
> > are issued regardless (and FAOD with PARPORT_PC unset).
> > 
> >  I can't speak for SPARC support for ISA DMA, but it seems to me like the 
> > second sentence would best be removed, as would the Fixes: tag (in favour 
> > to:
> > 
> > Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
> > 
> > I presume), and possibly the messages quoted above included instead.

Thanks, I will update in v2.

> 
>  Actually I think ZONE_DMA should go too (it's linked to GENERIC_ISA_DMA, 
> isn't it? -- cf. commit 5ac6da669e24 ("[PATCH] Set CONFIG_ZONE_DMA for 
> arches with GENERIC_ISA_DMA")), and the whole thing use:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> The GENERIC_ISA_DMA option itself was added to arch/sparc/config.in with 
> 2.5.31 as:
> 
> define_bool CONFIG_GENERIC_ISA_DMA y
> 
> despite of:
> 
> define_bool CONFIG_ISA n
> 
> for a reason not clear to me (BLK_DEV_FD? -- but on SPARC that uses some 
> hacks to work in the absence of ISA DMA anyway).
> 
>  Am I missing anything here?
Nice find - the code below conforms you are right:

	max_zone_pfn[ZONE_DMA] = max_low_pfn;
	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;

As they are set to the same value there is no smaller ZONE_DMA area.
I will add an extra patch for this in v2.

	Sam

