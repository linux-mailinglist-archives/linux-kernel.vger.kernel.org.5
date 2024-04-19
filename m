Return-Path: <linux-kernel+bounces-151171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A88AAA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77791F221C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E435960263;
	Fri, 19 Apr 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m6xtwdTU"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511B6FB0;
	Fri, 19 Apr 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515610; cv=none; b=p9h5HcyNyMiqLcqYvbDHeZeS942HMrnHH7SGRdNrmcZDfNtnUy9aH6ytRTkteU3uc8HV3dsUHsQ4gUFqM5Ym0PytIxQcOwurHOLXCcoKN+DDq6tlIbPjTi+Yvjhunb8Tu9MgqeaqK7K+8mCrVYgcGSq93FCvpyHvwIkU5tBxs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515610; c=relaxed/simple;
	bh=vlE4rwJQHlsOi1ldSLGIf7/jMTPexZtX8v3sDXizJuc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=awzuLH5IEaaSjM7Yn2iGqv1SzO8nQU997ogMFYedw33BKj7eDdJjTMXiRhSWmI+/pAJysDJKq5ah6FV+/5gufgCm+lql89LqD3I8byD2xmHQuw9vov404YMHnEb3Rwx14eXBPovmrVhBKYRMslixczXxeDJKxPQXrRXWItfyjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m6xtwdTU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C48DD1BF204;
	Fri, 19 Apr 2024 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713515602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPs5NKF6CmcZYT/KHoZl4EPR3FsLdrDhJEzbwPyJ0fA=;
	b=m6xtwdTUI2Y0nPDKm8+jQm/RG00HPsd3NWj29JkAUlaHKxBZtsu2h4odIh1iB9HT6c378u
	v+6Ktold4O6S5sLYpKMX7yodV5q1eTyDh5BVXQ3DoyTGuUiG8nnmCkPgd81tupnC4MsxTd
	jnZ8F6pngzlLVMmdKu8XLcD8d6qpBP21gbfR33VBzBp+2JaqeMYS3+lZ+ZBL8PN1eThn28
	+3HyhoYyI2hd1FuAMneCearo6kE0s7Sq2WMD62fJoP6TWr7GdCftobUarwJYL+ZKio83Mq
	Uvam9IG5PL63AhpvEYG2B/e/vM+i0/JfEcHT7hb8s6zrbVMsLA4X/M6V9oTRbA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 10:33:21 +0200
From: Kamel BOUHARA <kamel.bouhara@bootlin.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jeff LaBundy
 <jeff@labundy.com>, catalin.popescu@leica-geosystems.com,
 mark.satterthwaite@touchnetix.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Gregory Clement
 <gregory.clement@bootlin.com>, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v9 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
In-Reply-To: <20240318080533.GA35033@tpx1.home>
References: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
 <20240301103909.167923-4-kamel.bouhara@bootlin.com>
 <20240313202135.2lwgtu2z67ksh2tz@pengutronix.de>
 <20240318080533.GA35033@tpx1.home>
Message-ID: <2fdb461055af669d35b20f5d994c17c6@bootlin.com>
X-Sender: kamel.bouhara@bootlin.com
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Le 2024-03-18 09:05, Kamel Bouhara a écrit :
> Le Wed, Mar 13, 2024 at 09:21:35PM +0100, Marco Felsch a écrit :
>> Hi Kamel,
>> 
> 
> Hello Marco,
> 
> [...]
> 

Hello,

>> > +static int axiom_i2c_probe(struct i2c_client *client)
>> > +{
>> > +	struct device *dev = &client->dev;
>> > +	struct input_dev *input_dev;
>> > +	struct axiom_data *ts;
>> > +	u32 poll_interval;
>> > +	int target;
>> > +	int error;
>> > +
>> > +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>> > +	if (!ts)
>> > +		return -ENOMEM;
>> > +
>> > +	i2c_set_clientdata(client, ts);
>> > +	ts->client = client;
>> > +	ts->dev = dev;
>> > +
>> > +	ts->regmap = devm_regmap_init_i2c(client, &axiom_i2c_regmap_config);
>> > +	error = PTR_ERR_OR_ZERO(ts->regmap);
>> > +	if (error) {
>> > +		dev_err(dev, "Failed to initialize regmap: %d\n", error);
>> > +		return error;
>> > +	}
>> > +
>> > +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> > +	if (IS_ERR(ts->reset_gpio))
>> > +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
>> > +
>> > +	if (ts->reset_gpio)
>> > +		axiom_reset(ts->reset_gpio);
>> 
>> This seems useless, since you doing an reset without enabling the 
>> power
>> supply (below). I know there are systems which do have the supply 
>> always
>> connected or for ACPI the supply is managed via firmware, but the 
>> driver
>> should implement the correct logic and for DT/OF case this is not
>> correct.
>> 
>> > +
>> > +	ts->vddi = devm_regulator_get_optional(dev, "vddi");
>> > +	if (!IS_ERR(ts->vddi)) {
>> > +		error = devm_regulator_get_enable(dev, "vddi");
>> 
>> Regulators are ref counted and now you request the regulator twice. 
>> Also
>> the regulator is not optional, it is required for the device to work.
>> Same applies to the vdda below.
>> 
> 
> While it is true most of the time, it occurs that for x86 based boards,
> adding a regulator entirely is not always possible.
> 
> In our particular case, the I2C controller for this touchscreen is
> behind a CPLD (aka embedded controller) so I have no direct access to
> the I2C controller and it isn't described in the ACPI table.
> 
> In a normal case, I would use ACPI override to pass regulator
> properties, but here it's not possible.
> 
> Having a CPLD exposing this kind of controller is quite common on x86
> based boards. So, we need a way to support the case when a regulator
> can't be described. The optional regulator looked like a good option,
> but if you have a better alternative, I am open to considering it.
> 

I actually confirmed this case is already handled in 
acpi_subsystem_init():
                 ...
»       »       /*
»       »        * If the system is using ACPI then we can be reasonably
»       »        * confident that any regulators are managed by the 
firmware
»       »        * so tell the regulator core it has everything it needs 
to
»       »        * know.
»       »        */
»       »       regulator_has_full_constraints();

Thanks Marco for the clue :) !

Regards,

-- 
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

