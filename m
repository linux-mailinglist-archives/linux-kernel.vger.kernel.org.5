Return-Path: <linux-kernel+bounces-16604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D98240E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A171F23C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C4221361;
	Thu,  4 Jan 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q+3QJNw+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA921344;
	Thu,  4 Jan 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18F322000A;
	Thu,  4 Jan 2024 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704368889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jtxASBHYv7DYWaUVWi8zHXXkgICuHN1u6bOMe9fkFs=;
	b=Q+3QJNw+iinp96gAThb2+cr1/1jNmbAMsuTsmzXtwdFbYE50g/h5DGmC2NmUID1HolWQgy
	MZun+DnRrZ2WZe4nP6h3AbKbygeNtiYp2/Au2P7n3zHkx2cenkA9jrtQp86thrb47iOuDB
	P+0ys/Whl3QF9i8JcSrNWeqSxm0gaMfqHW2eLcnWolOQtk3yPcsbWmz8Yi7e0XysZjwbVY
	rpqaKtzLWUZYYvl2wkZrZDiZTXH5qprzluTmj1x1GGYmS00aiqfFdJtKcNSKWCN1W+7DYD
	h/0z2LnpDSqVCfbJqFLiN8uIw8s8UOIithNnmmSVruF6rBcPsvZPi7X6kQ8PNQ==
Date: Thu, 4 Jan 2024 12:48:05 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 William Zhang <william.zhang@broadcom.com>, Anand Gore
 <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 =?UTF-8?B?RmVybsOhbmRleg==?= Rojas <noltari@gmail.com>, Sven Schwermer
 <sven.schwermer@disruptive-technologies.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v8 5/5] net: phy: at803x: add LED support for
 qca808x
Message-ID: <20240104124805.1b0ba142@device-28.home>
In-Reply-To: <20240104110114.2020-6-ansuelsmth@gmail.com>
References: <20240104110114.2020-1-ansuelsmth@gmail.com>
	<20240104110114.2020-6-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Christian,

On Thu,  4 Jan 2024 12:01:12 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Add LED support for QCA8081 PHY.
> 
> Documentation for this LEDs PHY is very scarce even with NDA access
> to Documentation for OEMs. Only the blink pattern are documented and are
> very confusing most of the time. No documentation is present about
> forcing the LED on/off or to always blink.
> 
> Those settings were reversed by poking the regs and trying to find the
> correct bits to trigger these modes. Some bits mode are not clear and
> maybe the documentation option are not 100% correct. For the sake of LED
> support the reversed option are enough to add support for current LED
> APIs.

I have one small comment below :

> +static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
> +				 unsigned long *delay_on,
> +				 unsigned long *delay_off)
> +{
> +	int ret;
> +	u16 reg;
> +
> +	if (index > 2)
> +		return -EINVAL;
> +
> +	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
> +
> +	/* Set blink to 50% off, 50% on at 4Hz by default */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
> +			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
> +			     QCA808X_LED_BLINK_FREQ_256HZ | QCA808X_LED_BLINK_DUTY_50_50);

The comment (4Hz) and the blink frequency (256Hz) don't match, is that
right ? because I see there exists a QCA808X_LED_BLINK_FREQ_4HZ
definition, shouldn't it be used ?

Thanks,

Maxime

