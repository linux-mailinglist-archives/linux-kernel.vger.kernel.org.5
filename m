Return-Path: <linux-kernel+bounces-139877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F50A8A08CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A764287C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DAE13DB9A;
	Thu, 11 Apr 2024 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UI85FZoB"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0413D61D;
	Thu, 11 Apr 2024 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818133; cv=none; b=KOWi1MCLtcOELiOvSemioGoD2t6ge9jmR2eURbQWlc0tEsL19EL77RZXAM9i8dV8eKXqcEMT+b35Mzm+TC2e2SMD7gmb1XE6YQyUN6aK9+Tb8HA7JT0tTvtIqCizDVmxBnufg0M1X2joKbH4r5zgIO0jwRhziBI9IDIE+eRywG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818133; c=relaxed/simple;
	bh=LxDnqQD/Ynf2v6X4vOkgAXNsM8jplzr/Ybx4tashRDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CNf+G6Qqb5X7z7A3lFxFKF/jbPxd1AI3zOqqLIJh1oB9i+yaYCY8+9IO5LYcWNUP6GpTZhHLHmXJrvdYTn6EezRgr3vPBVK2qsj8BmLS3p6qhXIzcsit0dKMavM7rGMLLAInmDJhVmbgC72QCby4tX93RdE6MUptlbw2g5TV57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UI85FZoB; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AFD7FF803;
	Thu, 11 Apr 2024 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712818127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ht4yL7p2G9syjEPhGbbLFmsLSUE4MFaHnCtOBwa2f0U=;
	b=UI85FZoBJxkSr5IRNhTf81V9ubkj+rBrOmYUQdxIB2xHindV3eFcedgof+/ctlJxTgJOKo
	WWAG8oOTy3wWc4njjvvtTLHkCMKpX3hM+k+qbYOe+sSPR67i6fq59mJt9PhzNqIJIbQcek
	kyti06DfTIHAM100jdTvgfA9aLu9vH/ZrWmsQUOnZKUd6t0n7WeNkKXagnBBY+47Nj7cKh
	6K4zEMvfn7S/cnrx+cFY8zurNZ7nwHP1KLCay/Y4NLHj7TGO1vnK6x6J/51VDC7UruHRcW
	ShkAGAVDIpNFHpiPmN34kIMkB6KZwEGPe4fmQyo1KK7V/sv0JW3vOiVJnqBshg==
Date: Thu, 11 Apr 2024 08:49:22 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
cc: Jakub Kicinski <kuba@kernel.org>, 
    Romain Gantois <romain.gantois@bootlin.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Magnus Damm <magnus.damm@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-renesas-soc@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 3/5] net: stmmac: dwmac-socfpga: use
 pcs_init/pcs_exit
In-Reply-To: <ZhbmVVXgu27ZZaNf@shell.armlinux.org.uk>
Message-ID: <5efb5cb1-92ad-0e94-9431-f525c837b98a@bootlin.com>
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com> <20240409-rzn1-gmac1-v2-3-79ca45f2fc79@bootlin.com> <20240409183404.7d3eb04f@kernel.org> <ZhbmVVXgu27ZZaNf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hello Russell,

On Wed, 10 Apr 2024, Russell King (Oracle) wrote:

> patch as a theoretical solution to Romain. After build-testing it locally
> I did notice it. I would've thought that Romain would've build-tested
> before sending out his patch set and would've fixed it up... I didn't
> have time to properly fix up my patch (essentially would've ment

I build-tested the patches but didn't realize that CONFIG_DWMAC_SOCFPGA was not 
enabled in my configuration. So that's my bad, sorry.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

