Return-Path: <linux-kernel+bounces-151232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13F8AAB77
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98221B21A95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006578676;
	Fri, 19 Apr 2024 09:28:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBB762F7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518918; cv=none; b=luOEc4Htfom2YH3msFAsykFhoMvtl0/pGF7wHXMkzi5WwABvBIa5uRQ0zLSCsnSOOCHPCLHfe+Iw7aqVVlm7X7Zd+RgeOdEn+Dyl85L477nM5v9tQrBjk6zgy0Mh3wE9F4l+Qr/YWEhxpdxI01R6j5q96/VRVysf7zieUyBBK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518918; c=relaxed/simple;
	bh=RzsGOHqQ+PBnsoxOmJDgqk3bfw/edxPwlwpalPgjzwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obvSheKv3uZ0ZQEQjdlut+nrFpM10VTPhbpWwhskXqr6apVxjYUkwxgxyNgHtgJibUtRCCN2zhrF7i1K8QJ6dd3Qt2f8S+odLsMucfTrmGdA71yy7Al52Af4s66/6/NBnuZUDqsqnHcysy400jEONUIFniOZi2xgE80d58o/yls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rxkXj-0008Iw-W0; Fri, 19 Apr 2024 11:28:28 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rxkXi-00D89e-MH; Fri, 19 Apr 2024 11:28:26 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rxkXi-0039nT-1t;
	Fri, 19 Apr 2024 11:28:26 +0200
Date: Fri, 19 Apr 2024 11:28:26 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
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
Subject: Re: [PATCH v10 3/3] Input: Add TouchNetix axiom i2c touchscreen
 driver
Message-ID: <20240419092826.2gq72etn4fh4q7ph@pengutronix.de>
References: <20240419083342.61199-1-kamel.bouhara@bootlin.com>
 <20240419083342.61199-4-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419083342.61199-4-kamel.bouhara@bootlin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Kamel,

thank you for the patch. Again just a rough review.

On 24-04-19, Kamel Bouhara wrote:
> Add a new driver for the TouchNetix's axiom family of
> touchscreen controllers. This driver only supports i2c
> and can be later adapted for SPI and USB support.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---

..

> +static int axiom_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct input_dev *input_dev;
> +	struct axiom_data *ts;
> +	u32 poll_interval;
> +	int target;
> +	int error;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, ts);
> +	ts->client = client;
> +	ts->dev = dev;
> +
> +	ts->regmap = devm_regmap_init_i2c(client, &axiom_i2c_regmap_config);
> +	error = PTR_ERR_OR_ZERO(ts->regmap);
> +	if (error) {
> +		dev_err(dev, "Failed to initialize regmap: %d\n", error);
> +		return error;
> +	}
> +
> +	ts->vddi = devm_regulator_get(dev, "VDDI");

This does not match the dt-bindings.

> +	if (IS_ERR(ts->vddi))
> +		return dev_err_probe(&client->dev, PTR_ERR(ts->vddi),
> +				     "Failed to enable VDDI regulator\n");
> +
> +	ts->vdda = devm_regulator_get(dev, "VDDA");

Here as well.

> +	if (IS_ERR(ts->vdda))
> +		return dev_err_probe(&client->dev, PTR_ERR(ts->vdda),
> +				     "Failed to enable VDDA regulator\n");

Now we handle it as always but..

> +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ts->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
> +
> +	if (ts->reset_gpio)
> +		axiom_reset(ts->reset_gpio);
> +	else
> +		msleep(AXIOM_STARTUP_TIME_MS);

still the reset is useless since you never enabled the regulators. So
either use devm_regulator_get_enable() or you do the enable/disable
separate via regulator_enable()/disable(). If there are no strict
enablement restrictions like orders and timings you could also make use
of the regulator_bulk API (e.g. devm_regulator_bulk_get_enable).

Regards,
  Marco

> +
> +	error = axiom_discover(ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed touchscreen discover\n");
> +
> +	input_dev = devm_input_allocate_device(ts->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	input_dev->name = "TouchNetix axiom Touchscreen";
> +	input_dev->phys = "input/axiom_ts";
> +
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
> +
> +	touchscreen_parse_properties(input_dev, true, &ts->prop);
> +
> +	/* Registers the axiom device as a touchscreen instead of a mouse pointer */
> +	error = input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, INPUT_MT_DIRECT);
> +	if (error)
> +		return error;
> +
> +	/* Enables the raw data for up to 4 force channels to be sent to the input subsystem */
> +	set_bit(EV_REL, input_dev->evbit);
> +	set_bit(EV_MSC, input_dev->evbit);
> +	/* Declare that we support "RAW" Miscellaneous events */
> +	set_bit(MSC_RAW, input_dev->mscbit);
> +
> +	ts->input_dev = input_dev;
> +	input_set_drvdata(ts->input_dev, ts);
> +
> +	/* Ensure that all reports are initialised to not be present. */
> +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
> +		ts->targets[target].state = AXIOM_TARGET_STATE_NOT_PRESENT;
> +
> +	error = devm_request_threaded_irq(dev, client->irq, NULL,
> +					  axiom_irq, IRQF_ONESHOT, dev_name(dev), ts);
> +	if (error) {
> +		dev_info(dev, "Request irq failed, falling back to polling mode");
> +
> +		error = input_setup_polling(input_dev, axiom_i2c_poll);
> +		if (error)
> +			return dev_err_probe(ts->dev, error, "Unable to set up polling mode\n");
> +
> +		if (!device_property_read_u32(ts->dev, "poll-interval", &poll_interval))
> +			input_set_poll_interval(input_dev, poll_interval);
> +		else
> +			input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
> +	}
> +
> +	return input_register_device(input_dev);
> +}
> +
> +static const struct i2c_device_id axiom_i2c_id_table[] = {
> +	{ "ax54a" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> +
> +static const struct of_device_id axiom_i2c_of_match[] = {
> +	{ .compatible = "touchnetix,ax54a", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, axiom_i2c_of_match);
> +
> +static struct i2c_driver axiom_i2c_driver = {
> +	.driver = {
> +		   .name = "axiom",
> +		   .of_match_table = axiom_i2c_of_match,
> +	},
> +	.id_table = axiom_i2c_id_table,
> +	.probe = axiom_i2c_probe,
> +};
> +module_i2c_driver(axiom_i2c_driver);
> +
> +MODULE_AUTHOR("Bart Prescott <bartp@baasheep.co.uk>");
> +MODULE_AUTHOR("Pedro Torruella <pedro.torruella@touchnetix.com>");
> +MODULE_AUTHOR("Mark Satterthwaite <mark.satterthwaite@touchnetix.com>");
> +MODULE_AUTHOR("Hannah Rossiter <hannah.rossiter@touchnetix.com>");
> +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
> +MODULE_DESCRIPTION("TouchNetix axiom touchscreen I2C bus driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
> 

