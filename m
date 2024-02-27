Return-Path: <linux-kernel+bounces-83915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFE86A00D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B59A1F24566
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7214830D;
	Tue, 27 Feb 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEuUcZVn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41D51C33;
	Tue, 27 Feb 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061650; cv=none; b=HXhXugU1bS2RNW3lczRGRbUkrtsRU56NuH3A6H/YW1sp+I8TWlzOMej+HwICu1uhk1aqfKoGlKXpIQEEEvFhGyJ5pEpXqHY4Y1pFOfpsnd+YCQsWYPphf2RgsHW1/SZZSzzjTEAZfLHE0HXVv5gYCiDB8U6LwDBCr1kBOlzTTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061650; c=relaxed/simple;
	bh=AcsguI5VlTxYraStv84Cz5LPfQ1mLD4JEQO3egcz8aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1XUOJaJelDUXGZ7OD9hqXUCUJ3Q9eapMcJaYjRhC5OcI/fdvBYK54PCzhwteIQwYxeW2OBPsQsIFRHrrVaJGCWk+VB0m816TtCmreROnj5BJk9HZelR/kOxYSMh6MQWvwgN7AcUfIbNCeLvNFXFq8E5FewrOqQKT4r6wXgkj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEuUcZVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5BCC433C7;
	Tue, 27 Feb 2024 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709061650;
	bh=AcsguI5VlTxYraStv84Cz5LPfQ1mLD4JEQO3egcz8aQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fEuUcZVnvT7jPeRafbXwl9X2+Ue1xo/+Fc1S1CoA6CTSWszlq2B2iX+dEQnBi/bjq
	 FuJ2sHKeIy7v6s+iH/eUqiz7dtHyaxeQMxAgAm0oONOV2mMUGRUfyPXrJNwH0GtPKO
	 e2eeqqvroNjt8+bTBvFs4mDxZubuqWdt4MpipKpH5lKSxtux6KzrATZuIC2FT7qeoq
	 BJMhnVF/EbSPeT8NTwZo6qVQ9n3DFqhERHkFnxvyspyg0GGbnPOQm+iCStVLku0AvN
	 O30yLFvvQDeYAdZC1OGfeeBs0m/FZdXc0NaZPcflZKU9UMnfYN7LP2ij4U0L4zrGHW
	 giKX/UJvS9RJQ==
Date: Tue, 27 Feb 2024 19:20:32 +0000
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
Subject: Re: [PATCH v7 5/5] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240227192032.12def64a@jic23-huawei>
In-Reply-To: <a94b86fe-0896-47ba-a597-0cd59a0665a2@tweaklogic.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
	<20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
	<20240224151340.3f2f51e8@jic23-huawei>
	<a94b86fe-0896-47ba-a597-0cd59a0665a2@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 23:42:48 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 25/2/24 01:43, Jonathan Cameron wrote:
> > On Sun, 18 Feb 2024 16:18:26 +1030
> > Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> >   
> >> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> >> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> >> channel approximates the response of the human-eye providing direct
> >> read out where the output count is proportional to ambient light levels.
> >> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> >> caused by artificial light sources. Hardware interrupt configuration is
> >> optional. It is a low power device with 20 bit resolution and has
> >> configurable adaptive interrupt mode and interrupt persistence mode.
> >> The device also features inbuilt hardware gain, multiple integration time
> >> selection options and sampling frequency selection options.
> >>
> >> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
> >> Scales, Gains and Integration time implementation.
> >>
> >> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>  
> > I applied this but then got some build warnings that made me look
> > more closely at the int_src handling.
> > 
> > This is confusing because of the less than helpful datasheet defintion
> > of a 2 bit register that takes values 0 and 1 only.
> > 
> > I thought about trying to fix this up whilst applying but the event code
> > issue is too significant to do without a means to test it.
> > 
> > Jonathan
> >   
> 
> >> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> >> +{
> >> +	struct device *dev = data->dev;
> >> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >> +	struct apds9306_regfields *rf = &data->rf;
> >> +	int ret, delay, intg_time, intg_time_idx, repeat_rate_idx, int_src;
> >> +	int status = 0;
> >> +	u8 buff[3];
> >> +
> >> +	ret = pm_runtime_resume_and_get(data->dev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regmap_field_read(rf->int_src, &int_src);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> >> +	if (intg_time < 0)
> >> +		return intg_time;
> >> +
> >> +	/* Whichever is greater - integration time period or sampling period. */
> >> +	delay = max(intg_time, apds9306_repeat_rate_period[repeat_rate_idx]);
> >> +
> >> +	/*
> >> +	 * Clear stale data flag that might have been set by the interrupt
> >> +	 * handler if it got data available flag set in the status reg.
> >> +	 */
> >> +	data->read_data_available = 0;
> >> +
> >> +	/*
> >> +	 * If this function runs parallel with the interrupt handler, either
> >> +	 * this reads and clears the status registers or the interrupt handler
> >> +	 * does. The interrupt handler sets a flag for read data available
> >> +	 * in our private structure which we read here.
> >> +	 */
> >> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
> >> +				       status, data->read_data_available ||
> >> +				       (status & (APDS9306_ALS_DATA_STAT_MASK |
> >> +						  APDS9306_ALS_INT_STAT_MASK)),
> >> +				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* If we reach here before the interrupt handler we push an event */
> >> +	if ((status & APDS9306_ALS_INT_STAT_MASK))
> >> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> >> +			       int_src, IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),  
> > 
> > You are pushing an event on channel 0 or 1 (which is non obvious as that
> > int_src is a 2 bit value again).  However you don't use indexed channels
> > so this is wrong.
> > It's also pushing IIO_LIGHT for both channels which makes no sense as you
> > only have one IIO_LIGHT channel.  
> Hi Jonathan,
> 
> For the above fix I am supplying the second parameter to IIO_UNMOD_EVENT_CODE()
> as "0" which gives me the below output from userspace:
> ./iio_event_monitor /dev/iio:device0
> Event: time: xx, type: illuminance, channel: 0, evtype: thresh, direction: either
> Event: time: yy, type: intensity, channel: 0, evtype: thresh, direction: either
> 
> As I do not have indexed channels, I have used zero for both Light and Intensity
> channel numbers. Should I make the intensity type as channel one for the output
> to look like this?
> Event: time: xx, type: illuminance, channel: 0, evtype: thresh, direction: either
> Event: time: yy, type: intensity, channel: 1, evtype: thresh, direction: either
> 
No need. It's not an ABI bug if you did have that mix of channels, but you'd
need to make them indexed in the chan_spec to match.  Don't bother.

You should however us a modified event for the intensity channel seeing as
it is .modified = 1, IIO_MOD_LIGHT_CLEAR

So IIO_MOD_EVENT_CODE would be appropriate.


> What do you think?
> 
> Regards,
> Subhajit Ghosh
> > 
> >   
> >> +			       iio_get_time_ns(indio_dev));
> >> +
> >> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> >> +	if (ret) {
> >> +		dev_err_ratelimited(dev, "read data failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	*val = get_unaligned_le24(&buff);
> >> +
> >> +	pm_runtime_mark_last_busy(data->dev);
> >> +	pm_runtime_put_autosuspend(data->dev);
> >> +
> >> +	return 0;
> >> +}
> >> +  
> > 
> > ...  
> 
> 


