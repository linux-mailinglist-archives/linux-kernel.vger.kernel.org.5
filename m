Return-Path: <linux-kernel+bounces-32082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25511835646
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921FD1F22DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1537179;
	Sun, 21 Jan 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKGaIqp7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5962376F9;
	Sun, 21 Jan 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705850626; cv=none; b=nBR84E3VWd19hVAFNlvprudGWcT51AKHRU++N3jgmF/IK9YFGOK8OOx3U41X0taEzwqKs8wbGMaEMfyCWKYudN6dqqdNRZhgfMu0BEZwhm+G4/t+CQUiGUuQGInSOjPB2OVCnIZLk43qxhVuHav4/TkHVSr5vmXDIuPJJsmoxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705850626; c=relaxed/simple;
	bh=I+TOzNlF8BsYvQRLwfXF3Qc4VhWjN4rpwB0FrCUvUEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bV3G3H2uBxPwtpJ073GsuKWmC5hzN8AmajnCtGsgXxKTCFJWSWH/tB0UHUHV/TkXhMOYoHTrplYEhWa7av0h9NEHKQVq7KTGlb0ttPJ6/4uzGQ6JhJDN7yCaChb0g6ng9/xTxqTgbOJiokwvgqrXsudoKd7TzXRcQecyZWBfqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKGaIqp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D64C43394;
	Sun, 21 Jan 2024 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705850626;
	bh=I+TOzNlF8BsYvQRLwfXF3Qc4VhWjN4rpwB0FrCUvUEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AKGaIqp7ByPbF1lwHNZamCzNJm3mskEW5ZzeCTy2H/+5gACl3vuKdHOVjXXabluQB
	 IJ9jfwD4m2aljOtJgdtVo1SkaCFUa2gv4VlQ+Ph9NwPlsyy3hvtcNmMTITOUByLDDk
	 U8Nr25xagBM7p8S+/U8koXBUfzqXxg3Bz0vNxug1VMvf8FkEd7xB3SOSP0PgH6aaMf
	 no+giNnyDVpkfWKXzn0D2LJs7o5jwD+VIcv/YjFnfmMIhEZBmG+0dnD6MemSKqe88N
	 U8Dvnr+mD7hDg2NIuRczEX2L0I0m6Yfe18CEmx1cP8ToY+ICS38mt8EZL4q9hW9gaQ
	 37oUZgKYftBsw==
Date: Sun, 21 Jan 2024 15:23:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240121152332.6b15666a@jic23-huawei>
In-Reply-To: <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
	<20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 15:47:34 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> channel approximates the response of the human-eye providing direct
> read out where the output count is proportional to ambient light levels.
> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> caused by artificial light sources. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.
> 
> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
> Scales, Gains and Integration time implementation.
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
> v2 -> v5:

Why did you jump to v5?  Some internal or private reviews perhaps?
Better for those tracking on the list if you just used v3.


>  - Removed scale attribute for Intensity channel:
>    Link: https://lore.kernel.org/all/20231204095108.22f89718@jic23-huawei/
> 
>  - Dropped caching of hardware gain, repeat rate and integration time and
>    updated code as per earlier reviews.
>    Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/

..

A few, mostly very minor comments inline to add to Christophe's review.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> new file mode 100644
> index 000000000000..8ed5899050ed
> --- /dev/null
> +++ b/drivers/iio/light/apds9306.c
> @@ -0,0 +1,1315 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * APDS-9306/APDS-9306-065 Ambient Light Sensor
> + * I2C Address: 0x52
> + * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> + *
> + * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Given you are still changing it, feel free to include 2024!

> + */
..
> +static const int apds9306_repeat_rate_freq[][2] = {
> +	{40, 0},
> +	{20, 0},
> +	{10, 0},
> +	{5,  0},
> +	{2,  0},
> +	{1,  0},
> +	{0, 500000},
Prefer
	{ 40, 0 },
etc and whilst I don't really like forcing alignment like this, if you
are going to do it be consistent.  The last 50000 is one space too far to the
left I think.


> +};
> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
> +		APDS9306_NUM_REPEAT_RATES);
> +
> +static const int apds9306_repeat_rate_period[] = {
> +	25000, 50000, 100000, 200000, 500000, 1000000, 2000000,
> +};
> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_period) ==
> +		APDS9306_NUM_REPEAT_RATES);
> +
> +/**
> + * struct apds9306_data - apds9306 private data and registers definitions
> + *
> + * @dev:	Pointer to the device structure
> + * @gts:	IIO Gain Time Scale structure
> + * @mutex:	Lock for protecting register access, adc reads and power

ADC.  I guess the double comment is to keep checkpatch happy?

Just ignore it being dumb as you have a comment up here and put all the info
here rather than splitting it up like this.

> + * @regmap:	Regmap structure pointer
> + * @regfield_sw_reset:	Reg: MAIN_CTRL, Field: SW_Reset
> + * @regfield_en:	Reg: MAIN_CTRL, Field: ALS_EN
> + * @regfield_intg_time:	Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width
> + * @regfield_repeat_rate:	Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate
> + * @regfield_gain:	Reg: ALS_GAIN, Field: ALS Gain Range
> + * @regfield_int_src:	Reg: INT_CFG, Field: ALS Interrupt Source
> + * @regfield_int_thresh_var_en:	Reg: INT_CFG, Field: ALS Var Interrupt Mode
> + * @regfield_int_en:	Reg: INT_CFG, Field: ALS Interrupt Enable
> + * @regfield_int_persist_val:	Reg: INT_PERSISTENCE, Field: ALS_PERSIST
> + * @regfield_int_thresh_var_val:	Reg: ALS_THRSH_VAR, Field: ALS_THRES_VAR
> + * @nlux_per_count:	nano lux per ADC count for a particular model
> + * @read_data_available:	Flag set by IRQ handler for ADC data available
> + */
> +struct apds9306_data {
> +	struct device *dev;
> +	struct iio_gts gts;
> +	/*
> +	 * Protects device settings changes where some calculations are required
> +	 * before or after setting or getting the raw settings values from regmap
> +	 * writes or reads respectively.
> +	 */
> +	struct mutex mutex;
> +
> +	struct regmap *regmap;
> +	struct regmap_field *regfield_sw_reset;
> +	struct regmap_field *regfield_en;
> +	struct regmap_field *regfield_intg_time;
> +	struct regmap_field *regfield_repeat_rate;
> +	struct regmap_field *regfield_gain;
> +	struct regmap_field *regfield_int_src;
> +	struct regmap_field *regfield_int_thresh_var_en;
> +	struct regmap_field *regfield_int_en;
> +	struct regmap_field *regfield_int_persist_val;
> +	struct regmap_field *regfield_int_thresh_var_val;
> +
> +	int nlux_per_count;
> +	int read_data_available;
> +};

> +
> +static struct iio_event_spec apds9306_event_spec_als[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),

What's the intent of this final entry?
The type will default to IIO_EV_TYPE_THRESH anyway but if that
the intent you should specify it.   There isn't an 'obvious'
default for type in the same way there sort of is for dir
(as it's either direction).

> +	},
> +};

> +

> +
> +static int apds9306_runtime_power_on(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		dev_err(dev, "runtime resume failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int apds9306_runtime_power_off(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}

I'm not entirely convinced these two wrappers are worthwhile given they
aren't that common used and locally obscure what is going on when
it could be apparent at the few call sites.



> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int int_en, int_ch, ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		ret = regmap_field_read(data->regfield_int_src, &int_ch);

int_ch is a not particularly informative name.

event_ch_is_light perhaps? 

> +		if (ret)
> +			return ret;
> +		ret = regmap_field_read(data->regfield_int_en, &int_en);
> +		if (ret)
> +			return ret;
> +		if (chan->type == IIO_LIGHT)
> +			return int_en & int_ch;
> +		else if (chan->type == IIO_INTENSITY)
> +			return int_en & !int_ch;
> +		return -EINVAL;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_read(data->regfield_int_thresh_var_en, &int_en);
> +		if (ret)
> +			return ret;
> +		return int_en;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	state = !!state;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		/*
> +		 * If interrupt is enabled, the channel is set before enabling
> +		 * the interrupt. In case of disable, no need to switch
> +		 * channels. In case of different channel is selected while
> +		 * interrupt in on, just change the channel.
> +		 */
> +		if (state) {
> +			if (chan->type == IIO_LIGHT)
> +				val = 1;
> +			else if (chan->type == IIO_INTENSITY)
> +				val = 0;
> +			else
> +				return -EINVAL;

Blank line here and similar.

> +			ret = regmap_field_write(data->regfield_int_src, val);
> +			if (ret)
> +				return ret;
> +		}
> +		ret = regmap_field_read(data->regfield_int_en, &val);
> +		if (ret)
> +			return ret;
> +		if (val == state)
> +			return 0;

Blank line.  Basically add one whenever a block of related code ends.

> +		ret = regmap_field_write(data->regfield_int_en, state);
> +		if (ret)
> +			return ret;
> +		if (state)
> +			return apds9306_runtime_power_on(data->dev);
> +		return apds9306_runtime_power_off(data->dev);
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		return regmap_field_write(data->regfield_int_thresh_var_en, state);
> +	default:
> +		return -EINVAL;
> +	}
> +}
>

.

> +static void apds9306_powerdown(void *ptr)
> +{
> +	struct apds9306_data *data = (struct apds9306_data *)ptr;
> +	int ret;
> +
> +	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
> +	if (ret)
> +		return;

blank line here ideally.

> +	ret = regmap_field_write(data->regfield_int_en, 0);
> +	if (ret)
> +		return;
> +
> +	apds9306_power_state(data, false);
> +}

..

> +
> +static int apds9306_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct apds9306_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	mutex_init(&data->mutex);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &apds9306_regmap);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	data->dev = dev;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = apds9306_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regfield initialization failed\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	indio_dev->name = "apds9306";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	if (client->irq) {
> +		indio_dev->info = &apds9306_info;
> +		indio_dev->channels = apds9306_channels_with_events;
> +		indio_dev->num_channels =
> +				ARRAY_SIZE(apds9306_channels_with_events);
> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +				apds9306_irq_handler, IRQF_ONESHOT,
> +					"apds9306_event", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to assign interrupt.\n");
> +	} else {
> +		indio_dev->info = &apds9306_info_no_events;
> +		indio_dev->channels = apds9306_channels_without_events;
> +		indio_dev->num_channels = ARRAY_SIZE(apds9306_channels_without_events);
> +	}
> +
> +	ret = apds9306_pm_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed pm init\n");
> +
> +	ret = apds9306_device_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init device\n");
> +
> +	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add action or reset\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed iio device registration\n");
> +
> +	pm_runtime_put_autosuspend(dev);

Where is the matching get?  I don't recall any of the pm functions 
leaving us with the reference count raised except for the where it is
called out in the function name.

The runtime pm reference counters are protected against underflowing so this
probably just has no impact.  Still good to only have it if necessary and if
you do need the power to be on until this point, force it to do so by
an appropriate pm_runtime_get().


> +
> +	return 0;
> +}


