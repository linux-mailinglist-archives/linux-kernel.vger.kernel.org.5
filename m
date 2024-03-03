Return-Path: <linux-kernel+bounces-89794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998A86F5C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB0AB21A18
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91F67C44;
	Sun,  3 Mar 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6CLbutE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664C5A0FA;
	Sun,  3 Mar 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478878; cv=none; b=VOrQ+rvhGntp7V4TIu9S9hj08/YLjd0gc4mvw4R/3Kew22o//XBOg1AA0lhvBf1g6sD8apiJv/fgJzuHOy30DlM9FI72491MWFrs3YglxNROr87ynvGiMloM0IRdh6MFmktpPI4ZIpuepuHaSH0H+cmXYEQ/zjcDoVspCEZEcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478878; c=relaxed/simple;
	bh=ar5msKX4t8/TY0Rlc2uvgoxlQoM1O/vhJlEwR83EsOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJeLB+BMEgb7E7Js4TQihr20tpV+XUayKsPeaSpBJ3uX3CziQWEANH7XK1+3n6DcycGs3fzgnLtRlRksu+xLJBwh/RlPdjiJk2m0NIdJLh1mOwgvj1HZ2t7m4wzosriWkb/jsw5l7fGcFQ6VR86gCXimWUkkZ6ppemwZyY//UbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6CLbutE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B38C433F1;
	Sun,  3 Mar 2024 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709478878;
	bh=ar5msKX4t8/TY0Rlc2uvgoxlQoM1O/vhJlEwR83EsOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6CLbutEFrMGyN42yiBRFUq6X+PaqWIdxWFL7T8w+nP7Kpawe8Vm5MWIjvUcsVm3m
	 T4btWHnnfRk8uK68RMT7NvlUvz16Ei4ZtEtpvZrHp+7bc4HJCl5/H5el2n7NS+v5Eb
	 utlsSf8q1vUfMAGQaf4vEbgBd3e05GbiX56KeTQcQSETeQGOtYeBo4TeYiBfERuENM
	 EYR2ZUBgIE6IahC5VKjBJqPgxCtIYKuv7BN1fEEc7Ba2TFImQi3F+dHbauEhsfGZQY
	 QSAARgm0Wjh68z3mzannGk2so6FKzzXX/KnB1yoeZ6hiQjSDNiPfCjj8FR0oeyWcwT
	 YWpWf1ZgsFWsw==
Date: Sun, 3 Mar 2024 15:14:22 +0000
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
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240303151422.5fc3c2f2@jic23-huawei>
In-Reply-To: <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
	<20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 22:54:08 +1030
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
> v7 -> v8:
>  - Renamed APDS9306_INT_CH_CLEAR to APDS9306_INT_SRC_CLEAR macro for higher
>    readability
>  - Removed APDS9306_CHANNEL macro for higher readability
>  - Updated iio_push_event() functions with correct type of events (Light or Intensity)

Partly right.  Need to push the modified part for the intensity channel.
The event should match the channel description.

I also noted some missing elements in the event specs (sorry missed those
before!).  Whilst what you have will work, that's just because the error checking
is relaxed in the IIO core and we don't complain if they aren't fully specified.
What you have creates the correct attributes, but that's a side effect of how
we use the data, not what data should be provided.

Thanks,

Jonathan

>  - Updated variable name "event_ch_is_light" to "int_src" and change as per
>    review to fix compiler warning
>  - Used scope for guard() functions
>  - Other fixes as per reviews
>    https://lore.kernel.org/all/20240224151340.3f2f51e8@jic23-huawei/
>    https://lore.kernel.org/all/ZdycR6nr3rtrnuth@smile.fi.intel.com/
> 

> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 2e5fdb33e0e9..a30f906e91ba 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
..

> +	GAIN_SCALE_ITIME_US(3125, APDS9306_MEAS_MODE_3125US, BIT(0)),
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
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static struct iio_event_spec apds9306_event_spec_clear[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),

Can't configure the threshold for this channel?

Whilst the IIO core doesn't check these for missing entries in 
shared attributes, you driver should replicate the parts that
are in mask_shared_by_all above.  The code that builds the attributes
expects duplication of entries so they are here to provide an easy
place for us to visually check what is supported.

I think that means this event spec will be identical to that for the
als channel. So reuse that.

Let us know if you copied this pattern from another driver as we
should fix any that have gotten through review doing this.

> +	},
> +};
> +
> +static struct iio_chan_spec apds9306_channels_with_events[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = apds9306_event_spec_als,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_als),
> +	}, {
> +		.type = IIO_INTENSITY,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +		.event_spec = apds9306_event_spec_clear,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec_clear),
> +	},
> +};
> +
> +static struct iio_chan_spec apds9306_channels_without_events[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		.type = IIO_INTENSITY,
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = 1,
> +	},
> +};


> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> +{

..

> +	/* If we reach here before the interrupt handler we push an event */
> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		ev_code = IIO_UNMOD_EVENT_CODE((int_src == APDS9306_INT_SRC_ALS ?
> +						IIO_LIGHT : IIO_INTENSITY), 0,
> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_EITHER);

As below.  The intensity channel is modified, so you need to push an event
for a modified channel for that - otherwise it won't match with the channel.

> +
> +		iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> +	if (ret) {
> +		dev_err_ratelimited(dev, "read data failed\n");
> +		return ret;
> +	}
> +
> +	*val = get_unaligned_le24(&buff);
> +
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	return 0;
> +}
> +

> +
> +static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
> +				      int val2)
> +{
> +	struct apds9306_regfields *rf = &data->rf;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++) {
> +		if (apds9306_repeat_rate_freq[i][0] == val &&
> +		    apds9306_repeat_rate_freq[i][1] == val2)
> +			break;
Up to you, but you could simplify this.

			return regmap_field_write(rf->repeate_rate, i);
	}

	return -EINVAL;

> +	}
> +
> +	if (i == ARRAY_SIZE(apds9306_repeat_rate_freq))
> +		return -EINVAL;
> +
> +	return regmap_field_write(rf->repeat_rate, i);
> +}
> +
> +static irqreturn_t apds9306_irq_handler(int irq, void *priv)
> +{

..

> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		ev_code = IIO_UNMOD_EVENT_CODE((int_src == APDS9306_INT_SRC_ALS ?
> +						IIO_LIGHT : IIO_INTENSITY), 0,

That ternary is not good for readability, particularly not with the trailing 0,
Use a local variable, though you won't need this anyway after the fix below.

> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_EITHER);

The INTENSITY channel is a modified channel so events on it need to report
as modified.  Right now you are reporting an event code that userspace will not
expect an unmodified intensity event because it is looking for something like

	IIO_MOD_EVENT_CODE(IIO_INTENSITY, 0, IIO_MOD_LIGHT_CLEAR,
			   IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER);

> +
> +		iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
> +	}
> +
> +	/*
> +	 * If a one-shot read through sysfs is underway at the same time
> +	 * as this interrupt handler is executing and a read data available
> +	 * flag was set, this flag is set to inform read_poll_timeout()
> +	 * to exit.
> +	 */
> +	if ((status & APDS9306_ALS_DATA_STAT_MASK))
> +		data->read_data_available = 1;
> +
> +	return IRQ_HANDLED;
> +}




