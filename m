Return-Path: <linux-kernel+bounces-79756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB3862644
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CC71C212A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647E43ABE;
	Sat, 24 Feb 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="CzA7FC2T";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="4IwYhFpT"
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D6C42045
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794958; cv=none; b=LuBnd8SH9sypiitrRwAa2qr12YuNP+C3qKA/3dz4Zmmv4R5geJagLVtwF8zgmRFPAODBg66OZZbMaI3xpjadF57E07V4Dzjf8macKIQGY6M5m3pyiEIDRXrpuPd71ZHmOSEJu2LrHmDWMOPJ3kjW1fa5yABhwQ7ruEKyVXX5FGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794958; c=relaxed/simple;
	bh=VWwyux9i7geRWfos2fBrW8X2mv+sa/ZxUIw/OD7+8sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGwnmNNSZxpjnTQU00vA0IQCc4lSHy7BayFXOT/sB1SjWvxrzXaShB3Cy7J9jX4mZ7sUm2yutojGjkT0Rg04b4HGYzuvQhtnK83q0T/+kBmWTEp8qE8Qf5/W1INssLx2HAV2lDVnLeVLaU2y5wnm+wVBCmRQEA1E+S9X6hxvNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=CzA7FC2T; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=4IwYhFpT; arc=none smtp.client-ip=46.30.211.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=2pJjXBaY2kGPKvfJJqbfUQXDkhthgSiz6+4hch4Iuo4=;
	b=CzA7FC2ToBOLyndOQllkkLKtLcNzUrgR2s78tI8vnm25JDGHhMzC+Xoo1MD9hWAI8kjFT2JawVzN6
	 HdVjm/GuIPzaOEGCB7HA15K5HlfJBxPQ8oer3RxZ+n0aoEI2h51+aKORvAnjBk4xTcb+r773p7CI5W
	 +lxTwbKmopfdMq7Trn2Eiflf1Dn04w95iYhbkpveYCtkyRG7SoLI6RlopYqkvFuGa/zkDv8Uo6Kzit
	 4QS6LQGButrBNNjAtKdBCckglDlll5Y9QewAIFMWe/Pmx+4GjL0TgM5sCKuZ87pJUmH1Si9SX3cd0T
	 FucUrTZj8oHmfUhzEN49c0MH49AIaFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=2pJjXBaY2kGPKvfJJqbfUQXDkhthgSiz6+4hch4Iuo4=;
	b=4IwYhFpT6yPd2LEP0vfZKExDCZ0/D/n/MLD7ZEuW0Imr4Mrxud+BdWFW3AOY1bU/JvwW41rw/37Bc
	 +8Rf6biBA==
X-HalOne-ID: 32e46633-d338-11ee-91c2-dfbeffc51846
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 32e46633-d338-11ee-91c2-dfbeffc51846;
	Sat, 24 Feb 2024 17:14:44 +0000 (UTC)
Date: Sat, 24 Feb 2024 18:14:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	sparclinux@vger.kernel.org, linux-parport@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc32: Do not select GENERIC_ISA_DMA
Message-ID: <20240224171443.GA3312322@ravnborg.org>
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
 <alpine.DEB.2.21.2402240235570.61493@angie.orcam.me.uk>
 <alpine.DEB.2.21.2402240458100.61493@angie.orcam.me.uk>
 <73d9824f-898a-48ea-b3a8-ea420e3be007@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d9824f-898a-48ea-b3a8-ea420e3be007@app.fastmail.com>

Hi Arnd,

On Sat, Feb 24, 2024 at 12:24:01PM +0100, Arnd Bergmann wrote:
> On Sat, Feb 24, 2024, at 06:29, Maciej W. Rozycki wrote:
> > On Sat, 24 Feb 2024, Maciej W. Rozycki wrote:
> >
> > The GENERIC_ISA_DMA option itself was added to arch/sparc/config.in with 
> > 2.5.31 as:
> >
> > define_bool CONFIG_GENERIC_ISA_DMA y
> >
> > despite of:
> >
> > define_bool CONFIG_ISA n
> 
> I think I've seen any combination of CONFIG_ISA (the 62/98 pin slots), CONFIG_GENERIC_ISA_DMA (the request_dma() interface) and
> CONFIG_ISA_DMA_API (the set_dma_addr()/enable_dma() type interface),
> but I agree that sparc should have none of the three as both
> floppy and parport use some other interface.
> 
> > for a reason not clear to me (BLK_DEV_FD? -- but on SPARC that uses some 
> > hacks to work in the absence of ISA DMA anyway).
> >
> >  Am I missing anything here?
> 
> I think it was part of the ISA DMA lookalike that got removed
> in 334ae614772b ("sparc: Kill SBUS DVMA layer.") and should
> have been changed back then.

Hmm, that may well be the case.

I checked and sparc32 do not set any ISA symbols anymore
so we should be OK now.

I decided to just drop the Fixes: tag to not confuse anyone.

	Sam

