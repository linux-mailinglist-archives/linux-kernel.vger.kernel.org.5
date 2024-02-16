Return-Path: <linux-kernel+bounces-68197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBE85771C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15077B2382F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DBB17BAF;
	Fri, 16 Feb 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U9dXKhdL"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC721B28D;
	Fri, 16 Feb 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070173; cv=none; b=ZMOlTSV1v22ZwQvZtNUH1DF/r1UcSg1/ashYbS8jb1c2v+3wOYUy5HS3tFwAeXP2nvH8TgmC6s6GURyQE/F8dBZxebOJgrKW/aLaZh4D0sDu5Edxk10NF8OKstWpAysPk7AAnvW5YuGKPF4vzHwb4vHDARUeXssRm51OklUIQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070173; c=relaxed/simple;
	bh=qXUTqja3YaUc/dnaHvA106gil4VvjPmGptv2zxlDzck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQInSwychc2FerG4jo6P2IAIShawClWhGVJnv96QaiEZaEHR5Rgr2vsFe5wIk/IM1d7WyohlwsXs+I2tXDkb6JLhl8xK8b/K+g1IOrocUnlQjyjAnt1C+zNHhRqLaaEBkbLUrAYFvAJ7C2ZWKxrflv4Es6QqdNq+7xjCr8vWtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U9dXKhdL; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45E77240004;
	Fri, 16 Feb 2024 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708070169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26ksJFAWWRpQQPf57QDNWBsPe/lqnzGwrsfLlcE3f3Q=;
	b=U9dXKhdLVJrXkAZSU0XGKcs/1iiRaqtUUNgRBWi67R5YyOZj6nR5SUO4EpThVqLHP/utZZ
	zTQE0BP+2P5NsqlT/AEFNtmzyuhs7xTUcl3DuZkXaSXpkmzBOAM6AEp5fcFVdHqkYjTXTz
	Slyay/s82umoccv6ddA5deZ2ttgOAlxBXGSsablidYrcTd6jrS8kQ8mluRShMrRs2mceDw
	JttjJn4H/Ssk62qOZIvEw0HPmnqtCM9ePjAYw7fj/bxiD5jwelEWepjiOCmZDMMUG0AgMt
	gfwQmKhM2nE1hDTO1nHwFSTMU6O5qow35z8eOsrxCDUFDZbNlpmA8mMfjUMlCA==
Date: Fri, 16 Feb 2024 08:56:09 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mihai.Sain@microchip.com
Cc: conor@kernel.org, claudiu.beznea@tuxon.dev, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	Nicolas.Ferre@microchip.com, andre.przywara@arm.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Message-ID: <20240216075609e58aeee4@mail.local>
References: <20240215091524.14732-1-mihai.sain@microchip.com>
 <20240215091524.14732-3-mihai.sain@microchip.com>
 <20240215-lustily-flick-69cb48b123c3@spud>
 <PH8PR11MB6804E9353A8EEBD2B829D8B3824C2@PH8PR11MB6804.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB6804E9353A8EEBD2B829D8B3824C2@PH8PR11MB6804.namprd11.prod.outlook.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/02/2024 06:58:10+0000, Mihai.Sain@microchip.com wrote:
> > diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> > index 269e0a3ca269..c030b318985a 100644
> > --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
> > +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> > @@ -958,6 +958,30 @@ i2c9: i2c@600 {
> >  			};
> >  		};
> >  
> > +		flx10: flexcom@e2820000 {
> > +			compatible = "atmel,sama5d2-flexcom";
> 
> My comment here was ignored:
> https://lore.kernel.org/all/20240214-robe-pregnancy-a1b056c9fe14@spud/
> 
> The SAMA7G5 has the same flexcom controller as SAMA5D2 MPU.
> 

Still, it needs its own compatible plus a fallback to
atmel,sama5d2-flexcom

> https://github.com/torvalds/linux/blob/master/drivers/mfd/atmel-flexcom.c#L83
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt#L8

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

