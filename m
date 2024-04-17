Return-Path: <linux-kernel+bounces-148339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97D8A8123
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004C01F23D95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865B613C680;
	Wed, 17 Apr 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="iDw0+Ko4";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="LIzpgBeT"
Received: from c180-15.smtp-out.ap-south-1.amazonses.com (c180-15.smtp-out.ap-south-1.amazonses.com [76.223.180.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF84685;
	Wed, 17 Apr 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350363; cv=none; b=DYfRNW8ZlV0eSZJAObj6eXdMLcRYBBhQuM43Ozc29InBxPkPA8RJWUziSMm3OiDyxGDDlEwbB+7DivmJFRUU/g4sX3O971GO79JEodzNRCLuqYZX/OwH062TUBU17WaV3+vZ7YI2S8VYrLXZCFsvrwpEzknAU0tMXW1A5EiXNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350363; c=relaxed/simple;
	bh=NWxt9d6qlEYlWK8ONuEubNI6cEEiqQEqAs1/YysiTXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn/11TfDgWFDI/6ThbON3gPBxtykCurQboF42gqsK8tv/Dr5TRePg0Y1M79ecCmZt2Q83IRIe9suzGY1hR3nKvKVYodgVmMdmzXjQcv37III3en97/S5r0//Vhdr+JIRyufNhZtvk6J9b9uw+QBw4aDTgPVqjIfIo3HtPodM6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=iDw0+Ko4; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=LIzpgBeT; arc=none smtp.client-ip=76.223.180.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713350359;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NWxt9d6qlEYlWK8ONuEubNI6cEEiqQEqAs1/YysiTXc=;
	b=iDw0+Ko4VjjNSOLAqtbkxxSW4kWOmku+JNmuqlam4SazW4E757F2+T1UPRMQf+Vv
	gwDGl9l+IRdcc+oBfazWBWYDXjOH3xNOciWI956r00FYT6eCPHi8233jbyHt4JIaCoZ
	60j5IsQc9LNNbLQgbNEfgiRnMd8KR/5xcHxefMbGgg1KSHr9r8OKDZkBQhJlZxng88K
	Vg2Q3dvdRZzry3Jy0E5qUNzh2pUA/SPueG6gfiks113lCOMXHdjWwVzNgfJ7bSeH2eK
	jfYlTC8j1bYeKduKp1tAb5qXIbvyv0zQ7vrtLEVk4pu++RdX/1Rm2bOxhGBiWWR/BVL
	P+1hg62FmQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713350359;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=NWxt9d6qlEYlWK8ONuEubNI6cEEiqQEqAs1/YysiTXc=;
	b=LIzpgBeTCWEWB5WNJnCh9aTyItQegEqFPWzULF+5NjwWCOIJiOkwy2cP9ZrIDZoH
	fAw8skjRXHGzJuWyEvI4vzJ2wz+cDYqe1ikxWdDHhHjJ6HjVBEj2Erhc9o/tVQJbjGS
	jznsQSMvHm8VBjpqI4dIk03VMLY2LO8E7s7R7lH8=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: eblanc@baylibre.com
Cc: arnd@arndb.de, bhargav.r@ltts.com, broonie@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, 
	lgirdwood@gmail.com, linus.walleij@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, nm@ti.com, 
	robh+dt@kernel.org, vigneshr@ti.com
Subject: Re: [PATCH v6 10/11] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
Date: Wed, 17 Apr 2024 10:39:19 +0000
Message-ID: <0109018eeba3b870-adff6d96-6d05-45e3-b2ef-1b5ec0b034e0-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D0I0M4T4O9G1.UUESU247CE42@baylibre.com>
References: <D0I0M4T4O9G1.UUESU247CE42@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.15

On Fri, 12 Apr 2024 10:52:43 +0200, Esteban Blanc wrote:
> On Mon Apr 8, 2024 at 2:40 PM CEST, Bhargav Raviprakash wrote:
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >
> > Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they have
> > significant functional overlap.
> > TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> > dedicated device functions.
> >
> > Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/pinctrl/pinctrl-tps6594.c | 275 +++++++++++++++++++++++++-----
> >  1 file changed, 228 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
> > index 66985e54b..f3d1c1518 100644
> > --- a/drivers/pinctrl/pinctrl-tps6594.c
> > +++ b/drivers/pinctrl/pinctrl-tps6594.c
> > @@ -338,8 +506,20 @@ static int tps6594_pinctrl_probe(struct platform_device *pdev)
> >  	config.parent = tps->dev;
> >  	config.regmap = tps->regmap;
> > -	config.ngpio = TPS6594_PINCTRL_PINS_NB;
> > -	config.ngpio_per_reg = 8;
> > +	switch (tps->chip_id) {
> > +	case TPS65224:
> > +		config.ngpio = ARRAY_SIZE(tps65224_gpio_func_group_names);
> > +		config.ngpio_per_reg = TPS65224_NGPIO_PER_REG;
> > +		break;
> > +	case TPS6593:
> > +	case TPS6594:
> > +		config.ngpio = ARRAY_SIZE(tps6594_gpio_func_group_names);
> > +		config.ngpio_per_reg = TPS6594_NGPIO_PER_REG;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> Please merge the two switch case. 
> 
> Other than that I think it's ok.
> 
> Best regards,
> 
> -- 
> Esteban "Skallwar" Blanc
> BayLibre

Thanks! I will merge those switch cases in the next version.

Regards,
Bhargav

