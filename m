Return-Path: <linux-kernel+bounces-56204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CF684C751
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C2F1F22305
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9521112;
	Wed,  7 Feb 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N9P8Cowo"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980D2233E;
	Wed,  7 Feb 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298144; cv=none; b=LdwQ95lbRd6Q6Wy94KjS++JzowQzUDN7Ou/xaqOprmVzvT0dErNoOR6yiywqeMXglQ2LR/0FfjxinvPOxwjzow9gpiP4rhXQ/wWaD+piJQ7u7f5Mv9YTr/0jmh2T998M/86iMhgJc7BgDUrbWkiVW9swFkNIYLbGCcVOx2QKE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298144; c=relaxed/simple;
	bh=tZvO5HE5qIBsU4ugSLAGn3zDv2wwFN+ZxY7OuECjo+Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Gbp7697xX4qNz7wP87/bLrandfdm5dnaagJflbWh+EfynLkUxlwerBpXiFxlCw29ORxoUMua8chgWIz69dTGNqhcTJw+2w4L9CBnN4u52TAD/DrR20g65ZZXdEGnZMqMhoEGgumuYX+hbpuAH09SDVEXCdDwSW8m63paaqWldqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N9P8Cowo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F197F240005;
	Wed,  7 Feb 2024 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707298140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BU0/Sm8egevmDE5Fx9StEyR84uQHscaV0FmSOe4RKiE=;
	b=N9P8CowoVS6aHtnXEZfpEdzXufF4DBdIfo9uX/1GKGZxGUwrC+WIpaK+Fvrd38vkLG8vME
	l85g34lppP595QZB5qYEpj5/VjU1ghU0jqW/8o2Trk907O3/PvrrqLYK/na+2vWw4ZNQfl
	uz5jMQre7aSXkVTCveh4rSz2apZVz2bu5Je0lSmqhivGyI3hZf+G3ExjM2LCZl5aVfYoao
	ErZk3lWj82vxiXkrHtMZSfIaMPEqSzxdOLaSSQz2YglbvsReK/yAl16dAubPc3xH0qVO+V
	v/sozOTgCYmc++BBwCmbr9Je5hb+Q/1jOgYuRmCyMJHmhFDZujBByHyz6/3SIw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Feb 2024 10:28:59 +0100
Message-Id: <CYYQOHJ4783D.39ZQKS2IK40RV@bootlin.com>
Cc: "Mark Brown" <broonie@kernel.org>, "Apurva Nandan" <a-nandan@ti.com>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Dhruva Gole" <d-gole@ti.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 2/4] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
X-Mailer: aerc 0.15.2
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
 <20240207084253.fxrnoskda5x6usqo@dhruva>
In-Reply-To: <20240207084253.fxrnoskda5x6usqo@dhruva>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 7, 2024 at 9:42 AM CET, Dhruva Gole wrote:
> On Feb 05, 2024 at 15:57:30 +0100, Th=C3=A9o Lebrun wrote:
> > dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
> > controller. Neither embed the other; this lead to memory corruption.
> >=20
> > On a given platform (Mobileye EyeQ5) the memory corruption is hidden
> > inside cqspi->f_pdata. Also, this uninitialised memory is used as a
> > mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().
> >=20
> > Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implemen=
tations")
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadenc=
e-quadspi.c
> > index 720b28d2980c..1a27987638f0 100644
> > --- a/drivers/spi/spi-cadence-quadspi.c
> > +++ b/drivers/spi/spi-cadence-quadspi.c
> > @@ -1930,10 +1930,9 @@ static void cqspi_remove(struct platform_device =
*pdev)
> >  static int cqspi_runtime_suspend(struct device *dev)
> >  {
> >  	struct cqspi_st *cqspi =3D dev_get_drvdata(dev);
> > -	struct spi_controller *host =3D dev_get_drvdata(dev);
>
> Or you could do:
> +	struct spi_controller *host =3D cqspi->host;

Indeed. I preferred minimizing line count as I didn't see a benefit to
introducing a new variable. It goes away new patch anyway. If you
prefer it this way tell me and I'll fix it for next revision.

Thanks Dhruva,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

