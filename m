Return-Path: <linux-kernel+bounces-105474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A087DEAD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA101C20B00
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0EF1CAAE;
	Sun, 17 Mar 2024 16:32:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BA17EF
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693161; cv=none; b=lnqAny0pS6qe95FGLVLnSz7Ltuq8fGug1BKJIOPA0G04J4oA5cL+wNUnlU3jx9/LRxjPmD6IeyZi5wBgBjTp/WOo0sVTKFKyh/sWs+ssaZvBb6nFWYiXeBIJnDCX/WVyv0L2HUqLU97EPkGO0dGxvqfqtHrjP2PSLXIY+nv/EgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693161; c=relaxed/simple;
	bh=Ru9Q3tyHpIPcIy60i8PZiPeo4E8COxNTkWu1Vxczqsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKr9ModBlvWRrmn/wnYt6/JPWgCdzMrptMyUhibrmnAAl2vB9WtMeg0mrulIvtp3Cc5TSe6FKV4WmuYNy+egLSikAVl3JADvtr5dB5RH2R33tQjS7Q2gojng/6rOF7w8PtYHU/eEXQRGph3+az8PzTlYf48l0f+KzhnfClTJZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rltQx-0005gT-B6; Sun, 17 Mar 2024 17:32:27 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rltQu-006umO-R0; Sun, 17 Mar 2024 17:32:24 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rltQu-0041DJ-2N;
	Sun, 17 Mar 2024 17:32:24 +0100
Date: Sun, 17 Mar 2024 17:32:24 +0100
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
Subject: Re: [PATCH v9 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <20240317163224.l6mme67w5g3qz2hs@pengutronix.de>
References: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
 <20240301103909.167923-4-kamel.bouhara@bootlin.com>
 <20240313202135.2lwgtu2z67ksh2tz@pengutronix.de>
 <20240314082842.GA6963@tpx1.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314082842.GA6963@tpx1.home>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-03-14, Kamel Bouhara wrote:
> Le Wed, Mar 13, 2024 at 09:21:35PM +0100, Marco Felsch a écrit :
> > Hi Kamel,
> >
> Hi Marco,
> 
> > please see below, be aware that this is just an rough review.
> >
> 
> [...]
> 
> > > +
> > > +static int axiom_i2c_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct input_dev *input_dev;
> > > +	struct axiom_data *ts;
> > > +	u32 poll_interval;
> > > +	int target;
> > > +	int error;
> > > +
> > > +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > > +	if (!ts)
> > > +		return -ENOMEM;
> > > +
> > > +	i2c_set_clientdata(client, ts);
> > > +	ts->client = client;
> > > +	ts->dev = dev;
> > > +
> > > +	ts->regmap = devm_regmap_init_i2c(client, &axiom_i2c_regmap_config);
> > > +	error = PTR_ERR_OR_ZERO(ts->regmap);
> > > +	if (error) {
> > > +		dev_err(dev, "Failed to initialize regmap: %d\n", error);
> > > +		return error;
> > > +	}
> > > +
> > > +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(ts->reset_gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
> > > +
> > > +	if (ts->reset_gpio)
> > > +		axiom_reset(ts->reset_gpio);
> >
> > This seems useless, since you doing an reset without enabling the power
> > supply (below). I know there are systems which do have the supply always
> > connected or for ACPI the supply is managed via firmware, but the driver
> > should implement the correct logic and for DT/OF case this is not
> > correct.
> >
> 
> Alright, this can be moved after enabling vdda regulator as this is
> still required in the power sequence.
> 
> > > +
> > > +	ts->vddi = devm_regulator_get_optional(dev, "vddi");
> > > +	if (!IS_ERR(ts->vddi)) {
> > > +		error = devm_regulator_get_enable(dev, "vddi");
> >
> > Regulators are ref counted and now you request the regulator twice. Also
> > the regulator is not optional, it is required for the device to work.
> > Same applies to the vdda below.
> >
> 
> Ack, I wrongly took my use case (ACPI + fixed regulators) but this isn't
> a common use case.
> 
> > > +		if (error)
> > > +			return dev_err_probe(&client->dev, error,
> > > +					     "Failed to enable vddi regulator\n");
> > > +	}
> > > +
> > > +	ts->vdda = devm_regulator_get_optional(dev, "vdda");
> > > +	if (!IS_ERR(ts->vdda)) {
> > > +		error = devm_regulator_get_enable(dev, "vdda");
> > > +		if (error)
> > > +			return dev_err_probe(&client->dev, error,
> > > +					     "Failed to enable vdda regulator\n");
> > > +		msleep(AXIOM_STARTUP_TIME_MS);
> > > +	}
> > > +
> > > +	error = axiom_discover(ts);
> > > +	if (error)
> > > +		return dev_err_probe(dev, error, "Failed touchscreen discover\n");
> > > +
> > > +	input_dev = devm_input_allocate_device(ts->dev);
> > > +	if (!input_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	input_dev->name = "TouchNetix axiom Touchscreen";
> > > +	input_dev->phys = "input/axiom_ts";
> > > +
> > > +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
> > > +
> > > +	touchscreen_parse_properties(input_dev, true, &ts->prop);
> > > +
> > > +	/* Registers the axiom device as a touchscreen instead of a mouse pointer */
> > > +	error = input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, INPUT_MT_DIRECT);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	/* Enables the raw data for up to 4 force channels to be sent to the input subsystem */
> > > +	set_bit(EV_REL, input_dev->evbit);
> > > +	set_bit(EV_MSC, input_dev->evbit);
> > > +	/* Declare that we support "RAW" Miscellaneous events */
> > > +	set_bit(MSC_RAW, input_dev->mscbit);
> > > +
> > > +	ts->input_dev = input_dev;
> > > +	input_set_drvdata(ts->input_dev, ts);
> > > +
> > > +	/* Ensure that all reports are initialised to not be present. */
> > > +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
> > > +		ts->targets[target].state = AXIOM_TARGET_STATE_NOT_PRESENT;
> > > +
> > > +	error = devm_request_threaded_irq(dev, client->irq, NULL,
> > > +					  axiom_irq, IRQF_ONESHOT, dev_name(dev), ts);
> > > +	if (error) {
> > > +		dev_info(dev, "Request irq failed, falling back to polling mode");
> > > +
> > > +		error = input_setup_polling(input_dev, axiom_i2c_poll);
> > > +		if (error)
> > > +			return dev_err_probe(ts->dev, error, "Unable to set up polling mode\n");
> > > +
> > > +		if (!device_property_read_u32(ts->dev, "poll-interval", &poll_interval))
> >
> > This is not wrong but can we move the "poll-intervall" parsing into
> > touchscreen_parse_properties() since it seems pretty common to me.
> 
> Maybe too late to add it in this series :).
> 
> >
> > > +			input_set_poll_interval(input_dev, poll_interval);
> > > +		else
> > > +			input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
> > > +	}
> > > +
> > > +	error = input_register_device(input_dev);
> > > +	if (error)
> > > +		return dev_err_probe(ts->dev, error,
> > > +				     "Could not register with Input Sub-system.\n");
> >
> > 	return input_register_device(input_dev);
> 
> Ack, thanks.
> 
> >
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct i2c_device_id axiom_i2c_id_table[] = {
> > > +	{ "ax54a" },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> >
> > Do we really need an i2c-id table here? Most platforms do either use OF
> > or ACPI.
> 
> If not wrong this is used to enumarate the device from userspace
> and in my case it is required as there is no direct i2c controller
> exposed from ACPI pov.

Ah you're right, I forgot this use-case.

Regards,
  Marco

> 
> Thanks !
> 
> --
> Kamel Bouhara, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 

