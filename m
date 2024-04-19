Return-Path: <linux-kernel+bounces-151534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C58AB025
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FACB24F87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E412F5AD;
	Fri, 19 Apr 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fiJSUS3J"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0812F59D;
	Fri, 19 Apr 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535383; cv=none; b=AxeCMTutYDuqq0Ra+EVPA+dtqsrqleqSE0KRhMOrxErO/LrhsHpg+YlnRbv7ftIxdCqVGc3xND634qQ71VTGjUP20fXQ/y8Xpu15Kf6y7qseMVr1J5BcqqQdX+H7RrBO5zUV590J8S/xMrMppAVp/oeuSYcOCc5JlqxLj2S0Siw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535383; c=relaxed/simple;
	bh=CN/+wm3+Qj6FICC+hSr71I3dwIzODtJnFhfPT2Vu1JQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aVX8EnkJaOCOJet0awjB6vxVuIGMn2AVS37WRg+IfimcI6CsnXvyvUhv6oMfbRjDFV/XZvWtUMiYnqyWQjRcwWJkwXpXSkClDbK6vUa6oRmH9yt498bzGHdSu0M7mowvXGGkRACrGn9V/tI+HrknaX80TuNEOD6v+BoszVL1wvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fiJSUS3J; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 94D1A1C000D;
	Fri, 19 Apr 2024 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713535374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdTP2GU6XnhUFERNGxFgsC12yOYDO6hvGybnNNH9OX0=;
	b=fiJSUS3JTK+fippuuTYYY0qtqgX+BtmflELwtxI030PEf0LL/XRj8TO1v7T1cXTVTDIIG3
	r0V7bd/rOMgUJIwgB9NjEL0uvJrU1LA/VmDGiA53d5HoM2T5+xMRYcMy7KiwxyFdWcAzIR
	S2MiLcYlgZImYyeVeHL2zQtiFC5nihTvc32X2ED735nAaW0lUvGNBotj7A5OZ7meGOtJ6R
	12B1IO+EPRLPrvsBkTMt0uZbXlgQttStKEGtXzBmVAm6Nx+BklVClq33ydlF0H1HGsK4uo
	HHr+N9ffpRoX9tGE3Gki0SsiTpZYs85XhmmRgAhh+vemrNh3LdJ4k/GekqwpWQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 16:02:53 +0200
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
Subject: Re: [PATCH v10 3/3] Input: Add TouchNetix axiom i2c touchscreen
 driver
In-Reply-To: <20240419092826.2gq72etn4fh4q7ph@pengutronix.de>
References: <20240419083342.61199-1-kamel.bouhara@bootlin.com>
 <20240419083342.61199-4-kamel.bouhara@bootlin.com>
 <20240419092826.2gq72etn4fh4q7ph@pengutronix.de>
Message-ID: <48ba61c44b16fcc25a45a708d17b4c2e@bootlin.com>
X-Sender: kamel.bouhara@bootlin.com
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Le 2024-04-19 11:28, Marco Felsch a écrit :
> Hi Kamel,
> 

Hello,

> thank you for the patch. Again just a rough review.
> 
> On 24-04-19, Kamel Bouhara wrote:
>> Add a new driver for the TouchNetix's axiom family of
>> touchscreen controllers. This driver only supports i2c
>> and can be later adapted for SPI and USB support.
>> 
>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> ---
> 
> ...
> 
>> +static int axiom_i2c_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct input_dev *input_dev;
>> +	struct axiom_data *ts;
>> +	u32 poll_interval;
>> +	int target;
>> +	int error;
>> +
>> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>> +	if (!ts)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, ts);
>> +	ts->client = client;
>> +	ts->dev = dev;
>> +
>> +	ts->regmap = devm_regmap_init_i2c(client, &axiom_i2c_regmap_config);
>> +	error = PTR_ERR_OR_ZERO(ts->regmap);
>> +	if (error) {
>> +		dev_err(dev, "Failed to initialize regmap: %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	ts->vddi = devm_regulator_get(dev, "VDDI");
> 
> This does not match the dt-bindings.
> 
>> +	if (IS_ERR(ts->vddi))
>> +		return dev_err_probe(&client->dev, PTR_ERR(ts->vddi),
>> +				     "Failed to enable VDDI regulator\n");
>> +
>> +	ts->vdda = devm_regulator_get(dev, "VDDA");
> 
> Here as well.
> 
>> +	if (IS_ERR(ts->vdda))
>> +		return dev_err_probe(&client->dev, PTR_ERR(ts->vdda),
>> +				     "Failed to enable VDDA regulator\n");
> 
> Now we handle it as always but..
> 
>> +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", 
>> GPIOD_OUT_HIGH);
>> +	if (IS_ERR(ts->reset_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get 
>> reset GPIO\n");
>> +
>> +	if (ts->reset_gpio)
>> +		axiom_reset(ts->reset_gpio);
>> +	else
>> +		msleep(AXIOM_STARTUP_TIME_MS);
> 
> still the reset is useless since you never enabled the regulators. So
> either use devm_regulator_get_enable() or you do the enable/disable
> separate via regulator_enable()/disable(). If there are no strict
> enablement restrictions like orders and timings you could also make use
> of the regulator_bulk API (e.g. devm_regulator_bulk_get_enable).
> 

Fixed in v11, thanks !

> Regards,
>   Marco
> 
>> +
>> +	error = axiom_discover(ts);
>> +	if (error)
>> +		return dev_err_probe(dev, error, "Failed touchscreen discover\n");
>> +
>> +	input_dev = devm_input_allocate_device(ts->dev);
>> +	if (!input_dev)
>> +		return -ENOMEM;
>> +
>> +	input_dev->name = "TouchNetix axiom Touchscreen";
>> +	input_dev->phys = "input/axiom_ts";
>> +
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 
>> 0);
>> +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
>> +
>> +	touchscreen_parse_properties(input_dev, true, &ts->prop);
>> +
>> +	/* Registers the axiom device as a touchscreen instead of a mouse 
>> pointer */
>> +	error = input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, 
>> INPUT_MT_DIRECT);
>> +	if (error)
>> +		return error;
>> +
>> +	/* Enables the raw data for up to 4 force channels to be sent to the 
>> input subsystem */
>> +	set_bit(EV_REL, input_dev->evbit);
>> +	set_bit(EV_MSC, input_dev->evbit);
>> +	/* Declare that we support "RAW" Miscellaneous events */
>> +	set_bit(MSC_RAW, input_dev->mscbit);
>> +
>> +	ts->input_dev = input_dev;
>> +	input_set_drvdata(ts->input_dev, ts);shfs 
>> kamel@build3.bootlin.com:/home/kamel/granitenet/modem/cmux cmux/
>> +
>> +	/* Ensure that all reports are initialised to not be present. */
>> +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
>> +		ts->targets[target].state = AXIOM_TARGET_STATE_NOT_PRESENT;
>> +
>> +	error = devm_request_threaded_irq(dev, client->irq, NULL,
>> +					  axiom_irq, IRQF_ONESHOT, dev_name(dev), ts);
>> +	if (error) {
>> +		dev_info(dev, "Request irq failed, falling back to polling mode");
>> +
>> +		error = input_setup_polling(input_dev, axiom_i2c_poll);
>> +		if (error)
>> +			return dev_err_probe(ts->dev, error, "Unable to set up polling 
>> mode\n");
>> +
>> +		if (!device_property_read_u32(ts->dev, "poll-interval", 
>> &poll_interval))
>> +			input_set_poll_interval(input_dev, poll_interval);
>> +		else
>> +			input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
>> +	}
>> +
>> +	return input_register_device(input_dev);
>> +}
>> +
>> +static const struct i2c_device_id axiom_i2c_id_table[] = {
>> +	{ "ax54a" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
>> +
>> +static const struct of_device_id axiom_i2c_of_match[] = {
>> +	{ .compatible = "touchnetix,ax54a", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, axiom_i2c_of_match);
>> +
>> +static struct i2c_driver axiom_i2c_driver = {
>> +	.driver = {
>> +		   .name = "axiom",
>> +		   .of_match_table = axiom_i2c_of_match,
>> +	},
>> +	.id_table = axiom_i2c_id_table,
>> +	.probe = axiom_i2c_probe,
>> +};
>> +module_i2c_driver(axiom_i2c_driver);
>> +
>> +MODULE_AUTHOR("Bart Prescott <bartp@baasheep.co.uk>");
>> +MODULE_AUTHOR("Pedro Torruella <pedro.torruella@touchnetix.com>");
>> +MODULE_AUTHOR("Mark Satterthwaite 
>> <mark.satterthwaite@touchnetix.com>");
>> +MODULE_AUTHOR("Hannah Rossiter <hannah.rossiter@touchnetix.com>");
>> +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
>> +MODULE_DESCRIPTION("TouchNetix axiom touchscreen I2C bus driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>> 
>> 

-- 
--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

