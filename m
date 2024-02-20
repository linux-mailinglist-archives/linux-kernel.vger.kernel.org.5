Return-Path: <linux-kernel+bounces-73199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D943C85BF28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E3A285059
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E03371B55;
	Tue, 20 Feb 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TPJr3gRv"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FE6DCE4;
	Tue, 20 Feb 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440832; cv=none; b=s8WCre957v0/p9WeXoiIB4Ra5TW8CcBVShX+PXLWPvvZNhmdAjcIgZPgVEZ3ViDSZo4c4I9i1+JhtQsU1UF0TscWhY8YNW7OKZitWGFwM3ooDi+z0aUnLN7CKMi8sJxlp+qMrMdog3vmzeCTtG2MxjruhHo9ENO4zdOvQbMgqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440832; c=relaxed/simple;
	bh=itDAo79625wqrXYRJyMiUGlWUNZEtxI7Ja1FRFv4+J8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPPJgt7QUcW5ZHq8QdKo/UTqjRpY438uQaSm9UckH4FdetFOqvwstcYuFGXZ5zWuFtBhCAykCg7K0Z+NCG0JcwRhPf7UbwPXZGkFqhAjgFmG+VmNHlPGYyzvlcSGNkKhF4jbSrfYwbHINQJqNGbzLpE3bBIlGV2DTqb58bQH6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TPJr3gRv; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03AEDE0005;
	Tue, 20 Feb 2024 14:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708440828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xISkpa9Luec/jOP2bZPSmTe0UClACPSRWqJ7CnqNu3A=;
	b=TPJr3gRvQ4WVsBd4bTT4RMKt8vRtZRB+PcgJ8krMPE0XC8TgXWchXlmKEsrb/JYIL9KJqI
	rAuNGDf9z58I3bbYSM4vuv/Ghbas0HxE27JuRClGmZ/nHHuKlhxC/MDa7d73hlW0dOetq1
	9DI6zgL67wEg7m61Zfng3KhvMRInBAf6DgLsUoLpQBr11qx4WodgoGxDrd988SpCF5ALQU
	aW5WF6Cs2MBDImjxj/enwtoHj4fl0Db+am4OcFcPT0KgazB9nOdvt6gRnu5urEWeh4EBSM
	yAIBcZKIIQYFK4XgP+F0vXXTDQNsmvIROjEqFRHYcNOyoATrHIZZgpsyPOo9zQ==
Date: Tue, 20 Feb 2024 15:53:47 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Saravana Kannan <saravanak@google.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RESEND 0/2] leds: gpio: Add devlink between the
 leds-gpio device and the gpio used.
Message-ID: <20240220155347.693e46e1@bootlin.com>
In-Reply-To: <CAMRc=MfWPEOHeNvAwra-JxHZBFMrQbP+273zbFLDZfxi7fx8Yg@mail.gmail.com>
References: <20240220133950.138452-1-herve.codina@bootlin.com>
	<CAMRc=MfWPEOHeNvAwra-JxHZBFMrQbP+273zbFLDZfxi7fx8Yg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Tue, 20 Feb 2024 15:19:57 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Tue, Feb 20, 2024 at 2:39 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi,
> >
> > Note: Resent this series with Saravana added in Cc.
> >
> > When a gpio used by the leds-gpio device is removed, the leds-gpio
> > device continues to use this gpio. Also, when the gpio is back, the
> > leds-gpio still uses the old removed gpio.
> >
> > A consumer/supplier relationship is missing between the leds-gpio device
> > (consumer) and the gpio used (supplier).
> >
> > This series adds an addionnal devlink between this two device.
> > With this link when the gpio is removed, the leds-gpio device is also
> > removed.
> >
> > Best regards,
> > Hervé Codina
> >
> > Herve Codina (2):
> >   gpiolib: Introduce gpiod_device_add_link()
> >   leds: gpio: Add devlinks between the gpio consumed and the gpio leds
> >     device
> >
> >  drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
> >  drivers/leds/leds-gpio.c      | 15 +++++++++++++++
> >  include/linux/gpio/consumer.h |  5 +++++
> >  3 files changed, 52 insertions(+)
> >
> > --
> > 2.43.0
> >  
> 
> Can you add some more context here in the form of DT snippets that
> lead to this being needed?

/ {
	leds-dock {
		compatible = "gpio-leds";

		led-5 {
			label = "dock:alarm:red";
			gpios = <&tca6424_dock_2 12 GPIO_ACTIVE_HIGH>;
		};

		led-6 {
			label = "dock:alarm:yellow";
			gpios = <&tca6424_dock_2 13 GPIO_ACTIVE_HIGH>;
		};

		led-7 {
			label = "dock:alarm:blue";
			gpios = <&tca6424_dock_2 14 GPIO_ACTIVE_HIGH>;
		};
	};

	...
	i2c5 {
		...
		tca6424_dock_2: gpio@23 {
			compatible = "ti,tca6424";
			reg = <0x23>;
			gpio-controller;
			#gpio-cells = <2>;
			interrupt-parent = <&tca6424_dock_1>;
			interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
			interrupt-controller;
			#interrupt-cells = <2>;
			vcc-supply = <&reg_dock_ctrl_3v3>;
		};
		tca6424_dock_1: gpio@22 {
			compatible = "ti,tca6424";
			reg = <0x22>;
			gpio-controller;
			#gpio-cells = <2>;
			interrupt-parent = <&gpio4>;
			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
			interrupt-controller;
			#interrupt-cells = <2>;
			vcc-supply = <&reg_dock_ctrl_3v3>;
		};
	};
};

Also, had the exact same issue if I use a SoC gpio chip instead of an
i2c gpio expander.

Best regards,
Hervé

