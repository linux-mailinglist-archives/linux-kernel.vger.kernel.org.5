Return-Path: <linux-kernel+bounces-105800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19A87E4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D32F1F22456
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABFF24B2A;
	Mon, 18 Mar 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lrp4hW5H"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D4249F5;
	Mon, 18 Mar 2024 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749146; cv=none; b=uU+ZIw/NvidJDwE5Mpo6m3tIl0dLFo4h3guXiK6h3iauy51YilEvESElzVOS5cFQ+bx122TpeEFmf68dt/makSLfy5xxs5/sNTjJ5cXfu/og0/tjQuHppHticvYCmeI+EM/rr4dJZZx/AkBKGdBzFtnojEe7ZpqZdWbHGg0ryGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749146; c=relaxed/simple;
	bh=wZOl8ELhCbgPbYlLMs3nOwcsGw2fIVkfUTh0HFVFIK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ameo9g/TUXXwfPu8zkqBLmbFnGV9XPe84Kh8wgWOyEhOMu2xEmqBuy9kpWsTCy1bXm4u4E9m9BUuOtPqtndiQFjgQrvQvgYzZtPcnN0kjc7C6CKx8ZSdE1B4eqCycdcV2+xqNTbUxycNwwmh6iRWSPGfpKh9QwVUDWAfJsOhExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lrp4hW5H; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC05D1BF20C;
	Mon, 18 Mar 2024 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710749135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tvbx1H5YEg+d5PC7Bdp5vKt6Is6Yx4h64tavZFQbdA=;
	b=Lrp4hW5HLkJgc12dpKpTUR2ZSa1dX/CXpruvtOVyLLO4Cpxw+/bC1xw8wzkrtQOuzpDktc
	nRJUbWfxBPJmJZZ9Lc89/x2+s5SaLWAF6stTbb8DBlfNNc27Dq6oon7LVE0lSLnkDmVb7m
	3Qbilc1INqqEuPKtbx4J4GXhJOvr51VT1MJERYdmozzieVg3IeqW1VGTt0+/UwBRq5mQgS
	I62r4P0ROzY5A450VeIhEIwiYEYIW5Elyw4oV9hj2Krkizrtn+IYFmmOSx26dPe3iiGouF
	RtF9mjnGYXSKacCkxE9jiiuBT83LOzlCv2NTjWYaVJ8AnwsHIFbegJy/xdNKiQ==
Date: Mon, 18 Mar 2024 09:05:33 +0100
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Jeff LaBundy <jeff@labundy.com>,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v9 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <20240318080533.GA35033@tpx1.home>
References: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
 <20240301103909.167923-4-kamel.bouhara@bootlin.com>
 <20240313202135.2lwgtu2z67ksh2tz@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313202135.2lwgtu2z67ksh2tz@pengutronix.de>
X-GND-Sasl: kamel.bouhara@bootlin.com

Le Wed, Mar 13, 2024 at 09:21:35PM +0100, Marco Felsch a écrit :
> Hi Kamel,
>

Hello Marco,

[...]

> > +static int axiom_i2c_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct input_dev *input_dev;
> > +	struct axiom_data *ts;
> > +	u32 poll_interval;
> > +	int target;
> > +	int error;
> > +
> > +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > +	if (!ts)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(client, ts);
> > +	ts->client = client;
> > +	ts->dev = dev;
> > +
> > +	ts->regmap = devm_regmap_init_i2c(client, &axiom_i2c_regmap_config);
> > +	error = PTR_ERR_OR_ZERO(ts->regmap);
> > +	if (error) {
> > +		dev_err(dev, "Failed to initialize regmap: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(ts->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
> > +
> > +	if (ts->reset_gpio)
> > +		axiom_reset(ts->reset_gpio);
>
> This seems useless, since you doing an reset without enabling the power
> supply (below). I know there are systems which do have the supply always
> connected or for ACPI the supply is managed via firmware, but the driver
> should implement the correct logic and for DT/OF case this is not
> correct.
>
> > +
> > +	ts->vddi = devm_regulator_get_optional(dev, "vddi");
> > +	if (!IS_ERR(ts->vddi)) {
> > +		error = devm_regulator_get_enable(dev, "vddi");
>
> Regulators are ref counted and now you request the regulator twice. Also
> the regulator is not optional, it is required for the device to work.
> Same applies to the vdda below.
>

While it is true most of the time, it occurs that for x86 based boards,
adding a regulator entirely is not always possible.

In our particular case, the I2C controller for this touchscreen is
behind a CPLD (aka embedded controller) so I have no direct access to
the I2C controller and it isn't described in the ACPI table.

In a normal case, I would use ACPI override to pass regulator
properties, but here it's not possible.

Having a CPLD exposing this kind of controller is quite common on x86
based boards. So, we need a way to support the case when a regulator
can't be described. The optional regulator looked like a good option,
but if you have a better alternative, I am open to considering it.

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

