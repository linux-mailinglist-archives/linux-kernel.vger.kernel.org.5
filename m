Return-Path: <linux-kernel+bounces-102970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF30287B946
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A411C214B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E95D75D;
	Thu, 14 Mar 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CabL6gBM"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E644A12;
	Thu, 14 Mar 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404930; cv=none; b=d/GOLmMld8XQEUuSirV3hJPXLC0lsGd08l9lKnKEN0T4aJXVBGUc/AWjhlfAJJ0H6zJ55QcU6cXvO4SsWQJodwAE/zd/JOU9ua6ny6H20jSnfl3ew6nfOIZk3BEc3YPl4KEnYZhx359KgNEhEsXCqa4N2XbS3q3TfiGYc+xm9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404930; c=relaxed/simple;
	bh=dWBvzMvhEojLc4YRKahCcivlodgKip+79gtNWQpwMpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO7+1+l6kskSogSqdUYewEQQIxDm+BsNAWjBu1e6wGJbBHzX2kHJAqIupLp8GMr8yY0qbnIxq7bqqYB37hlKQ/SMx6p49CHJJnAX+13EMqIwKvoDE58Et8F/Wf7WLst1PHZVbya8p18ThN4bc46Kvlmu2XTKN+uJTlHnDrHGOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CabL6gBM; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45ED6C0008;
	Thu, 14 Mar 2024 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710404925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ta2o1x/LIlySc7obf85xA0brUjSk62k5/P2oqyy2gbY=;
	b=CabL6gBMbBp+8mopqE1f1dUVAINgn7OlUvLJsnZJP08TZJbgD6yr+zl4f51i4Vx5aLBh25
	TX8yKi/akLHzClY5day0luGdWE3lSOtAcicijuAPdyiqtQ+2uWWQQZW5twGzVeuTEXw5ov
	SHfll56j0kvJcdOD4psPs0Qo6jCc5FUM3/ZKJA09M6eXMacXKQUQNj7Iqbymk1KKRGIujj
	+OtAA89rIgEMuzY3y1Ixvf+66cWzZ444hwAVewSAwuV6KTFP7Ek/30QEXAZTe7zMMW4toc
	6C4GAMYQFjz6fyFmqwFGe5p+wPIQupGrr2dH1Bkp3v6lfQnKYk3czhpPasYkrg==
Date: Thu, 14 Mar 2024 09:28:42 +0100
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
Message-ID: <20240314082842.GA6963@tpx1.home>
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
Hi Marco,

> please see below, be aware that this is just an rough review.
>

[...]

> > +
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

Alright, this can be moved after enabling vdda regulator as this is
still required in the power sequence.

> > +
> > +	ts->vddi = devm_regulator_get_optional(dev, "vddi");
> > +	if (!IS_ERR(ts->vddi)) {
> > +		error = devm_regulator_get_enable(dev, "vddi");
>
> Regulators are ref counted and now you request the regulator twice. Also
> the regulator is not optional, it is required for the device to work.
> Same applies to the vdda below.
>

Ack, I wrongly took my use case (ACPI + fixed regulators) but this isn't
a common use case.

> > +		if (error)
> > +			return dev_err_probe(&client->dev, error,
> > +					     "Failed to enable vddi regulator\n");
> > +	}
> > +
> > +	ts->vdda = devm_regulator_get_optional(dev, "vdda");
> > +	if (!IS_ERR(ts->vdda)) {
> > +		error = devm_regulator_get_enable(dev, "vdda");
> > +		if (error)
> > +			return dev_err_probe(&client->dev, error,
> > +					     "Failed to enable vdda regulator\n");
> > +		msleep(AXIOM_STARTUP_TIME_MS);
> > +	}
> > +
> > +	error = axiom_discover(ts);
> > +	if (error)
> > +		return dev_err_probe(dev, error, "Failed touchscreen discover\n");
> > +
> > +	input_dev = devm_input_allocate_device(ts->dev);
> > +	if (!input_dev)
> > +		return -ENOMEM;
> > +
> > +	input_dev->name = "TouchNetix axiom Touchscreen";
> > +	input_dev->phys = "input/axiom_ts";
> > +
> > +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
> > +
> > +	touchscreen_parse_properties(input_dev, true, &ts->prop);
> > +
> > +	/* Registers the axiom device as a touchscreen instead of a mouse pointer */
> > +	error = input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, INPUT_MT_DIRECT);
> > +	if (error)
> > +		return error;
> > +
> > +	/* Enables the raw data for up to 4 force channels to be sent to the input subsystem */
> > +	set_bit(EV_REL, input_dev->evbit);
> > +	set_bit(EV_MSC, input_dev->evbit);
> > +	/* Declare that we support "RAW" Miscellaneous events */
> > +	set_bit(MSC_RAW, input_dev->mscbit);
> > +
> > +	ts->input_dev = input_dev;
> > +	input_set_drvdata(ts->input_dev, ts);
> > +
> > +	/* Ensure that all reports are initialised to not be present. */
> > +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
> > +		ts->targets[target].state = AXIOM_TARGET_STATE_NOT_PRESENT;
> > +
> > +	error = devm_request_threaded_irq(dev, client->irq, NULL,
> > +					  axiom_irq, IRQF_ONESHOT, dev_name(dev), ts);
> > +	if (error) {
> > +		dev_info(dev, "Request irq failed, falling back to polling mode");
> > +
> > +		error = input_setup_polling(input_dev, axiom_i2c_poll);
> > +		if (error)
> > +			return dev_err_probe(ts->dev, error, "Unable to set up polling mode\n");
> > +
> > +		if (!device_property_read_u32(ts->dev, "poll-interval", &poll_interval))
>
> This is not wrong but can we move the "poll-intervall" parsing into
> touchscreen_parse_properties() since it seems pretty common to me.

Maybe too late to add it in this series :).

>
> > +			input_set_poll_interval(input_dev, poll_interval);
> > +		else
> > +			input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
> > +	}
> > +
> > +	error = input_register_device(input_dev);
> > +	if (error)
> > +		return dev_err_probe(ts->dev, error,
> > +				     "Could not register with Input Sub-system.\n");
>
> 	return input_register_device(input_dev);

Ack, thanks.

>
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id axiom_i2c_id_table[] = {
> > +	{ "ax54a" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
>
> Do we really need an i2c-id table here? Most platforms do either use OF
> or ACPI.

If not wrong this is used to enumarate the device from userspace
and in my case it is required as there is no direct i2c controller
exposed from ACPI pov.

Thanks !

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

