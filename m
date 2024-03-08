Return-Path: <linux-kernel+bounces-96589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5A875EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2BB1F2298B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F154F218;
	Fri,  8 Mar 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DqWmuoxK"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B74EB49;
	Fri,  8 Mar 2024 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883407; cv=none; b=oP+A6Vl+Gd6ReM36ZPkRLyV2AuHqsAcHLPdOitJSPpx/3r+FKIGHLpm3ApDKebTzhR6EaWK/UfLg4OneNV/58YGSGGGE6n/ctD2G2i9aq3kQ0J5RPvgqdK0Tkm2NH5/rBguWpifM9/fPjqFrjbyXdNtoeIae8v3SG4eUGGW1NSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883407; c=relaxed/simple;
	bh=ZiDn02LUfgV+/6Ykmt+R1wh4EgqPqJ+M2GikjKwMG+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2p+v2f8kTxz1NFHEnC3aiELsm64SlkuxiUKO/NYAvwT5GmfwRDR1r9Va9vlJ6jNVibrU74ClXLb1faMnrzoH7xhLlA4j4275knL1x44wGZGBRoe1tGYN/MnrLADfG+JMgaVrmVUp5b024zKaQZYX/uDnR1+sUIIwLLMMBfNkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DqWmuoxK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07F1920007;
	Fri,  8 Mar 2024 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709883401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGSqe7AdSDq/rJELatqXvjh2l9o5p+96qyY9cUtuWlw=;
	b=DqWmuoxK2s2FgZggo+7Fb+2aCTBDGG26G0JrfQh4B+IpyGom4N8b/iHlAFgV0XvbuXPgS2
	A/nThYrBp2kX2h3tcTQ3iBXWi1EjXh3f/Quu9oKQGC2EXlptBTaZo3Sg/hPzzxA+K7EH48
	ZwOgvj/m9z87BaLl2ySAxP45teiKUEbKgBGnojsdEKJw7wofXlUaUbyuNx2Tknv97J02uC
	XLa421ACTtXtvuCAL9Fa7kuzijn6vGxHhXb9innAJFDOYeyVz8N7V/a79gK7MTgfaq3kKQ
	p1Z11i73iycAH4WmBFFUhhspQSAfmAW6ryMHpC1F5b+64G3CKFdzJTxSpP5CUA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andy@kernel.org,
 geert@linux-m68k.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com, lee@kernel.org
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris
 Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on
 x530
In-Reply-To: <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
Date: Fri, 08 Mar 2024 08:36:40 +0100
Message-ID: <87edclgoon.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> The Allied Telesis x530 products have a 7-segment LED display which is
> used for node identification when the devices are stacked. Represent
> this as a gpio-7-segment device.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Normally, this patch should be taken in mvebu and then merged by
arm-soc. However, I haven't seen any other patch touching this file (so
no risk of merge conflict) and I think it's too late for me to make a
new pull request to arm-soc. So I'm not against it being taken with the
rest of the patches. However, I think it would be a good idea to see
what Arnd thinks about it.

Gregory

> ---
>
> Notes:
>     Changes in v5:
>     - group GPIO specifiers
>     Changes in v4:
>     - Use correct compatible name in commit message
>     Changes in v3:
>     - Use compatible = "gpio-7-segment" as suggested by Rob
>     Changes in v2:
>     - Use compatible = "generic-gpio-7seg" to keep checkpatch.pl happy
>
>  arch/arm/boot/dts/marvell/armada-385-atl-x530.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
> index 5a9ab8410b7b..2fb7304039be 100644
> --- a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
> +++ b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
> @@ -43,6 +43,17 @@ uart0: serial@12000 {
>  			};
>  		};
>  	};
> +
> +	led-7seg {
> +		compatible = "gpio-7-segment";
> +		segment-gpios = <&led_7seg_gpio 0 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 1 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 2 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 3 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 4 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 5 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 6 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &pciec {
> @@ -149,7 +160,7 @@ i2c@3 {
>  			#size-cells = <0>;
>  			reg = <3>;
>  
> -			gpio@20 {
> +			led_7seg_gpio: gpio@20 {
>  				compatible = "nxp,pca9554";
>  				gpio-controller;
>  				#gpio-cells = <2>;
> -- 
> 2.43.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

