Return-Path: <linux-kernel+bounces-31991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F4F8354FE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0532E282821
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D0A364B4;
	Sun, 21 Jan 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XNjE4JbI"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C833070;
	Sun, 21 Jan 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705828982; cv=none; b=T3SNil82akDk70wdkzyo8olDt5NBj46jZnnu1COsn/odrgrDwB04uxhuELpDx2X6JE7ab+kUWCR562R4yURE3UAmeWB7CfrGVHSYZDKpkDDlL/mubFnGn9Addq9f/8iT8l3VCH/7iaieNuXZblP+rYJz5aXn6s3kk0kHifO83j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705828982; c=relaxed/simple;
	bh=InXK47ol3t2PSKdnF/cWQkgh8WSzpcuoyT8OUwijSAw=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=PvfK6wt6U+bkfPWTag6pvc67Sm04galYEMEXGtb4dpzI4+FHNlpmEjbwME87dmbohZef7kc6BuMr6pGxHqQomK3/8i7dYN6CDWRIoMqpl0WuIcT8X4uTgrzoQ4tdbjxOp2uoX0ZnSqYjvTXDPAarRacHp4nFVRjhOnwSO6kLe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XNjE4JbI; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id RU2UrzPWD5f7aRU2VrCtTT; Sun, 21 Jan 2024 10:22:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705828976;
	bh=+KyQBjNv3+mS/R0TGs5MPGTfE26qMTIh/ByLOA2SxAA=;
	h=Date:Subject:References:From:To:Cc:In-Reply-To;
	b=XNjE4JbIyZ5Np/rHJBAd0Fyp2/pp+wQnNA42yOqdo+XP3ZUZW4IAbwoX2/LMpsj/t
	 DjthdCPbmMifKmxtXEUw3Zm58K2vQmDmBDAT5epjwIeLSX7g4hTUnYBnLLcGCRU6d6
	 Rm6z1Wb0LETu0yog6+C8UJxlgTCC+9ETJznM8KUmOK7tK64xHUek+fvxutf/qpHNKj
	 Sm73CXM3nhSnv5/8oKkrs51j3LchgC91nefT440J/aly0ElfGprq4LM4OQq9WRN3bz
	 Za06CKZPREnCQ+i6Y4YjQhyhXWDDyGra7vCpxWauWUtcEiKqznLtjwPdlzJKrnfLsh
	 GHfinxnKVobeQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jan 2024 10:22:56 +0100
X-ME-IP: 92.140.202.140
Message-ID: <8a7f03b6-caca-4fbb-8093-0ba87bd2e850@wanadoo.fr>
Date: Sun, 21 Jan 2024 10:22:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: subhajit.ghosh@tweaklogic.com
Cc: andriy.shevchenko@linux.intel.com, anshulusr@gmail.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 javier.carrasco.cruz@gmail.com, jic23@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
 matt@ranostay.sg, mazziesaccount@gmail.com, robh+dt@kernel.org,
 stefan.windfeldt-prytz@axis.com
In-Reply-To: <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/01/2024 à 06:17, Subhajit Ghosh a écrit :
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
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh-ojZBjWEdjYKukZHgTAicrQ@public.gmane.org>
> ---

Hi,

a few nits and a few real comment/question below.

Just my 2c.

CJ
..

> +#define APDS9306_ALS_THRES_VAL_MAX	(BIT(20) - 1)
> +#define APDS9306_ALS_THRES_VAR_VAL_MAX	(BIT(3) - 1)
> +#define APDS9306_ALS_PERSIST_VAL_MAX	(BIT(4) - 1)

Nit: GENMASK()?

> +#define APDS9306_ALS_READ_DATA_DELAY_US	20000
> +#define APDS9306_NUM_REPEAT_RATES	7

..

> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> +{
> +	struct device *dev = data->dev;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int ret, delay, intg_time, intg_time_idx, repeat_rate_idx, int_src;
> +	int status = 0;
> +	u8 buff[3];
> +
> +	ret = apds9306_runtime_power_on(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->regfield_intg_time, &intg_time_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->regfield_repeat_rate, &repeat_rate_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->regfield_int_src, &int_src);
> +	if (ret)
> +		return ret;
> +
> +	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> +	if (intg_time < 0)
> +		delay = apds9306_repeat_rate_period[repeat_rate_idx];

'delay' is always overwritten by the line below.

> +
> +	/*
> +	 * Whichever is greater - integration time period or
> +	 * sampling period.
> +	 */
> +	delay = max(intg_time,
> +		    apds9306_repeat_rate_period[repeat_rate_idx]);
> +
> +	/*
> +	 * Clear stale data flag that might have been set by the interrupt
> +	 * handler if it got data available flag set in the status reg.
> +	 */
> +	data->read_data_available = 0;
> +
> +	/*
> +	 * If this function runs parallel with the interrupt handler, either
> +	 * this reads and clears the status registers or the interrupt handler
> +	 * does. The interrupt handler sets a flag for read data available
> +	 * in our private structure which we read here.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
> +				status, (status & (APDS9306_ALS_DATA_STAT_MASK |
> +				APDS9306_ALS_INT_STAT_MASK)) ||
> +				data->read_data_available,
> +				APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
> +	if (ret)
> +		return ret;
> +
> +	/* If we reach here before the interrupt handler we push an event */
> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, int_src,
> +			       IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> +	if (ret) {
> +		dev_err(dev, "read data failed\n");

Would dev_err_ratelimited() make sense here?

> +		return ret;
> +	}
> +
> +	*val = get_unaligned_le24(&buff);
> +
> +	return apds9306_runtime_power_off(dev);
> +}

..

> +static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
> +{
> +	struct device *dev = data->dev;
> +	int ret, intg_old, gain_old, gain_new, gain_new_closest, intg_time_idx;
> +	int gain_idx;
> +	bool ok;
> +
> +	if (!iio_gts_valid_time(&data->gts, val2)) {
> +		dev_err(dev, "Unsupported integration time %u\n", val2);

Would dev_err_ratelimited() make sense here?

> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_field_read(data->regfield_intg_time, &intg_time_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->regfield_gain, &gain_idx);
> +	if (ret)
> +		return ret;
> +
> +	intg_old = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (intg_old == val2)
> +		return 0;
> +
> +	gain_old = iio_gts_find_gain_by_sel(&data->gts, gain_idx);
> +	if (gain_old < 0)
> +		return gain_old;
> +
> +	ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old, intg_old,
> +						     val2, &gain_new);
> +	if (gain_new < 0) {
> +		dev_err(dev, "Unsupported gain with time\n");

Would dev_err_ratelimited() make sense here?

> +		return gain_new;
> +	}
> +
> +	gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
> +	if (gain_new_closest < 0) {
> +		gain_new_closest = iio_gts_get_min_gain(&data->gts);
> +		if (gain_new_closest < 0)
> +			return gain_new_closest;
> +	}
> +	if (!ok)
> +		dev_dbg(dev, "Unable to find optimum gain, setting minimum");
> +
> +	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_field_write(data->regfield_intg_time, ret);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_gts_find_sel_by_gain(&data->gts, gain_new_closest);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_field_write(data->regfield_gain, ret);
> +}

..

> +static int apds9306_event_period_get(struct apds9306_data *data, int *val)
> +{
> +	int period, ret;
> +
> +	ret = regmap_field_read(data->regfield_int_persist_val, &period);
> +	if (ret)
> +		return ret;
> +
> +	if (period > APDS9306_ALS_PERSIST_VAL_MAX)

Nit: in_range() to be consistent with code below?

> +		return -EINVAL;
> +
> +	*val = period;
> +
> +	return ret;
> +}
> +
> +static int apds9306_event_period_set(struct apds9306_data *data, int val)
> +{
> +	if (!in_range(val, 0, APDS9306_ALS_PERSIST_VAL_MAX))
> +		return -EINVAL;
> +
> +	return regmap_field_write(data->regfield_int_persist_val, val);
> +}

..

> +static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
> +				     int val)
> +{
> +	int var;
> +	u8 buff[3];
> +
> +	if (dir == IIO_EV_DIR_RISING)
> +		var = APDS9306_ALS_THRES_UP_0_REG;
> +	else if (dir == IIO_EV_DIR_FALLING)
> +		var = APDS9306_ALS_THRES_LOW_0_REG;
> +	else
> +		return -EINVAL;
> +
> +	if (!in_range(val, 0, APDS9306_ALS_THRES_VAL_MAX))
> +		return -EINVAL;
> +
> +	put_unaligned_le24(val, buff);
> +
> +	return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
> +}
> +
> +static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data,
> +					      int *val)
> +{
> +	int thr_adpt, ret;
> +
> +	ret = regmap_field_read(data->regfield_int_thresh_var_val, &thr_adpt);
> +	if (ret)
> +		return ret;
> +
> +	if (thr_adpt > APDS9306_ALS_THRES_VAR_VAL_MAX)

Nit: in_range()? to be consistent with code below and above.

> +		return -EINVAL;
> +
> +	*val = thr_adpt;
> +
> +	return ret;
> +}
> +
> +static int apds9306_event_thresh_adaptive_set(struct apds9306_data *data,
> +		int val)
> +{
> +	if (!in_range(val, 0, APDS9306_ALS_THRES_VAR_VAL_MAX))
> +		return -EINVAL;
> +
> +	return regmap_field_write(data->regfield_int_thresh_var_val, val);
> +}

..

> +static irqreturn_t apds9306_irq_handler(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, status, int_ch;
> +
> +	/*
> +	 * The interrupt line is released and the interrupt flag is
> +	 * cleared as a result of reading the status register. All the
> +	 * status flags are cleared as a result of this read.
> +	 */
> +	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS_REG, &status);
> +	if (ret < 0) {
> +		dev_err(data->dev, "status reg read failed\n");

Would dev_err_ratelimited() make sense here?

> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_field_read(data->regfield_int_src, &int_ch);
> +	if (ret)
> +		return ret;
> +
> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, int_ch,
> +				   IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +				   iio_get_time_ns(indio_dev));
> +	}

Nit: superfluous {}

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
> +
> +static int apds9306_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;

Other functions below that look really similar have a:
    guard(mutex)(&data->mutex);

Is it needed here?

> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
> +			ret = apds9306_event_period_get(data, val);
> +		else
> +			ret = apds9306_event_thresh_get(data, dir, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = apds9306_event_thresh_adaptive_get(data, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

..


