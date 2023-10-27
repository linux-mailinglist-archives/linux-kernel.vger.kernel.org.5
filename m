Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9847D985F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0Mej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJ0Meh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:34:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917DBD;
        Fri, 27 Oct 2023 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698410074; x=1729946074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iIOysqrWfB9MlIYycR6MYiypQqiAGhoBsKxcZd/zCcg=;
  b=FtyVnEGUReA0cwOiraGL/ACpJ0BKXfWoO5JXP2YJmQI3Qp5MlbJlKBjD
   92/+uMlOmk3h3Yfd6dXKPYJ5xIZ4v8C6OnNKc2WIO4UcZ+m9dWxPf6Jh4
   D7TYiVshAXfYf9a06AijDs9D/1Z4fYoVMX40V2+n1UVtAZDubVwobHSHt
   rESDLqysYfmMybOoT1oBnR20BxApbPWmKVJP1J+u6z6AnuycTn4THoxhZ
   0WEbBMdcsqk+RWVlBLhkGgsa/UksSjNGnLMlGVX2CUjRFWxkdrIfdIbr8
   z8zOcQ0sN99EwERLk475ATX9T9CvZSBPnKS0IN5+t+8f9c39AFy5JsYKu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="384974555"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="384974555"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="759583856"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="759583856"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:34:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwM2l-000000098rB-0N8f;
        Fri, 27 Oct 2023 15:34:27 +0300
Date:   Fri, 27 Oct 2023 15:34:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZTuuUl0PBklbVjb9@smile.fi.intel.com>
References: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
 <20231026143532.39660-3-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026143532.39660-3-subhajit.ghosh@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 01:05:32AM +1030, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor with als

WTH "als" is? Always think about reader of your commit message. It should be
clear to the unprepared reader.

> and clear channels with i2c interface. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.

> v0 -> v1
> - Fixed errors as per previous review
> - Longer commit messages and descriptions
> - Updated scale calculations as per iio gts scheme to export proper scale
>   values and tables to userspace
> - Removed processed attribute for the same channel for which raw is
>   provided, instead, exporting proper scale and scale table to userspace so
>   that userspace can do "(raw + offset) * scale" and derive Lux values
> - Fixed IIO attribute range syntax
> - Keeping the regmap lock enabled as the driver uses unlocked regfield
>   accesses from interrupt handler
> - Several levels of cleanups by placing guard mutexes in proper places and
>   returning immediately in case of an error
> - Using iio_device_claim_direct_mode() during raw reads so that
>   configurations could not be changed during an adc conversion period
> - In case of a powerdown error, returning immediately
> - Removing the definition of direction of the hardware interrupt and
>   leaving it on to device tree
> - Adding the powerdown callback after doing device initialization
> - Removed the regcache_cache_only() implementation

This is wrong location for the changelog...

> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---

...should go here, after cutter '---' line.

...

Missing bits.h.

Also array_size.h is pending for v6.7-rc1.

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

Missing types.h.

> +#include <linux/units.h>

...

> +#define APDS9306_ALS_THRES_VAL_MAX	0xFFFFF

It seems like the limit is hardware based, then probably better to mark it via
(BIT(20) - 1) to show this limitation explicitly.

...

> +enum apds9306_power_states {
> +	STANDBY,
> +	ACTIVE,

Perhaps namespace?

> +};

...

> +/**
> + * struct part_id_gts_multiplier - Part no. & corresponding gts multiplier

GTS? WTH "GTS" is, btw? (see comment on the commit message)

> + * @part_id: Part ID of the device
> + * @max_scale_int: Multiplier for iio_init_iio_gts()
> + * @max_scale_nano: Multiplier for iio_init_iio_gts()
> + */

...

> +/**

Hmm... Do we really need this in kernel doc?
Ditto for the similar cases.

> + * apds9306_repeat_rate_freq - Sampling Frequency in uHz
> + */

...

> +static const int apds9306_repeat_rate_period[] = {
> +	25000, 50000, 100000, 200000, 500000, 1000000, 2000000

Leave the trailing comma.

> +};

> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
> +	      ARRAY_SIZE(apds9306_repeat_rate_period));

Instead you may add a new definition and use it in [] in the respective arrays.

...

> +/**
> + * struct apds9306_data - apds9306 private data and registers definitions

> + * All regfield definitions are named exactly according to datasheet for easy
> + * search

I'm not sure this comment adds any value.

> + * @dev:	Pointer to the device structure
> + * @gts:	IIO Gain Time Scale structure
> + * @mutex:	Lock for protecting register access, adc reads and power
> + * @regmap:	Regmap structure pointer
> + * @regfield_sw_reset:	Reg: MAIN_CTRL, Field: SW_Reset
> + * @regfield_en:	Reg: MAIN_CTRL, Field: ALS_EN
> + * @regfield_intg_time:	Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width
> + * @regfield_repeat_rate:	Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate
> + * @regfield_scale:	Reg: ALS_GAIN, Field: ALS Gain Range
> + * @regfield_int_src:	Reg: INT_CFG, Field: ALS Interrupt Source
> + * @regfield_int_thresh_var_en:	Reg: INT_CFG, Field: ALS Var Interrupt Mode
> + * @regfield_int_en:	Reg: INT_CFG, Field: ALS Interrupt Enable
> + * @regfield_int_persist_val:	Reg: INT_PERSISTENCE, Field: ALS_PERSIST
> + * @regfield_int_thresh_var_val:	Reg: ALS_THRSH_VAR, Field: ALS_THRES_VAR
> + * @nlux_per_count:	nano lux per ADC count for a particular model
> + * @read_data_available:	Flag set by IRQ handler for ADC data available
> + * @intg_time_idx:	Array index for integration times
> + * @repeat_rate_idx:	Array index for sampling frequency
> + * @gain_idx:	Array index for gain
> + * @int_ch:	Currently selected Interrupt channel
> + */

...

> +static const struct iio_itime_sel_mul apds9306_itimes[] = {
> +	GAIN_SCALE_ITIME_US(400000, APDS9306_MEAS_MODE_400MS, 128),
> +	GAIN_SCALE_ITIME_US(200000, APDS9306_MEAS_MODE_200MS, 64),
> +	GAIN_SCALE_ITIME_US(100000, APDS9306_MEAS_MODE_100MS, 32),
> +	GAIN_SCALE_ITIME_US(50000, APDS9306_MEAS_MODE_50MS, 16),
> +	GAIN_SCALE_ITIME_US(25000, APDS9306_MEAS_MODE_25MS, 8),
> +	GAIN_SCALE_ITIME_US(3125, APDS9306_MEAS_MODE_3125US, 1),

Hmm... Maybe BIT() in all values?

> +};

> +static const struct attribute_group apds9306_event_attr_group = {
> +	.attrs = apds9306_event_attributes,
> +};

...

> +	data->regfield_intg_time = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_intg_time);
> +	if (IS_ERR(data->regfield_intg_time))
> +		return PTR_ERR(data->regfield_intg_time);
> +
> +	data->regfield_repeat_rate = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_repeat_rate);
> +	if (IS_ERR(data->regfield_repeat_rate))
> +		return PTR_ERR(data->regfield_repeat_rate);
> +
> +	data->regfield_scale = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_scale);
> +	if (IS_ERR(data->regfield_scale))
> +		return PTR_ERR(data->regfield_scale);
> +
> +	data->regfield_int_src = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_int_src);
> +	if (IS_ERR(data->regfield_int_src))
> +		return PTR_ERR(data->regfield_int_src);
> +
> +	data->regfield_int_thresh_var_en = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_int_thresh_var_en);
> +	if (IS_ERR(data->regfield_int_thresh_var_en))
> +		return PTR_ERR(data->regfield_int_thresh_var_en);
> +
> +	data->regfield_int_en = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_int_en);
> +	if (IS_ERR(data->regfield_int_en))
> +		return PTR_ERR(data->regfield_int_en);
> +
> +	data->regfield_int_persist_val = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_int_persist_val);
> +	if (IS_ERR(data->regfield_int_persist_val))
> +		return PTR_ERR(data->regfield_int_en);
> +
> +	data->regfield_int_thresh_var_val = devm_regmap_field_alloc(dev, regmap,
> +			apds9306_regfield_int_thresh_var_val);
> +	if (IS_ERR(data->regfield_int_thresh_var_val))
> +		return PTR_ERR(data->regfield_int_thresh_var_en);

Instead I would rather do with a temporary variable all of these...

	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_regfield_int_thresh_var_val);
	if (IS_ERR(tmp)
		return PTR_ERR(tmp);
	data->regfield_int_thresh_var_val = tmp;

...

> +static int apds9306_power_state(struct apds9306_data *data,
> +				enum apds9306_power_states state)
> +{
> +	int ret;
> +
> +	/* Reset not included as it causes ugly I2C bus error */
> +	switch (state) {
> +	case STANDBY:
> +		return regmap_field_write(data->regfield_en, 0);
> +	case ACTIVE:
> +		ret = regmap_field_write(data->regfield_en, 1);
> +		if (ret)
> +			return ret;
> +		/* 5ms wake up time */
> +		usleep_range(5000, 10000);

fsleep()

> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int apds9306_runtime_power(struct apds9306_data *data, int en)
> +{
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	if (en) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "runtime resume failed: %d\n", ret);
> +			return ret;
> +		}
> +		return 0;
> +	}
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return 0;
> +}

Wouldn't be better to have something like

static int apds9306_runtime_power_on(struct device *dev)
{
	int ret;

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		dev_err(dev, "runtime resume failed: %d\n", ret);
	return ret;
}

static int apds9306_runtime_power_off(struct device *dev)
{
	pm_runtime_mark_last_busy(dev);
	pm_runtime_put_autosuspend(dev);
	return 0;
}

// Not sure you will even need this one
static int apds9306_runtime_power(struct apds9306_data *data, bool en)
{
	struct device *dev = data->dev;

	if (en)
		return apds9306_runtime_power_on(dev);

	return apds9306_runtime_power_off(dev);
}

?

...

> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> +{
> +	struct device *dev = data->dev;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int ret, delay, intg_time, status = 0;
> +	u8 buff[3];
> +
> +	ret = apds9306_runtime_power(data, 1);

	ret = apds9306_runtime_power_on(dev);


> +	if (ret)
> +		return ret;
> +
> +	intg_time = iio_gts_find_int_time_by_sel(&data->gts,
> +						 data->intg_time_idx);
> +	if (intg_time < 0)
> +		delay = apds9306_repeat_rate_period[data->repeat_rate_idx];
> +
> +	/*
> +	 * Whichever is greater - integration time period or
> +	 * sampling period.
> +	 */
> +	delay = max(intg_time,
> +		    apds9306_repeat_rate_period[data->repeat_rate_idx]);
> +
> +

One blank line is enough.

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
> +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS,
> +				status, (status & (APDS9306_ALS_DATA_STAT_MASK |
> +				APDS9306_ALS_INT_STAT_MASK)) ||
> +				data->read_data_available,
> +				APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);

> +

Redundant blank line.

> +	if (ret)
> +		return ret;
> +
> +	/* If we reach here before the interrupt handler we push an event */
> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +			       data->int_ch,
> +			       IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +	}

> +	if ((status & APDS9306_ALS_DATA_STAT_MASK) ||
> +		data->read_data_available) {

Wrong indentation, perhaps put them on one line?

> +		ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> +		if (ret) {
> +			dev_err(dev, "read data failed\n");
> +			return ret;
> +		}
> +		*val = get_unaligned_le24(&buff);
> +	}
> +
> +	return apds9306_runtime_power(data, 0);

	return apds9306_runtime_power_off(dev);

> +}

...

> +	gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
> +	if (gain_new_closest < 0) {
> +		gain_new_closest = iio_gts_get_min_gain(&data->gts);
> +		if (gain_new_closest < 0)

> +			return gain_new_closest < 0;

Typo?

> +	}

...

> +static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
> +				int val2)
> +{
> +	int i, ret = -EINVAL;

Use value directly.

> +
> +	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++)
> +		if (apds9306_repeat_rate_freq[i][0] == val &&
> +				apds9306_repeat_rate_freq[i][1] == val2) {

Wrong indentation.

> +			ret = regmap_field_write(data->regfield_repeat_rate, i);
> +			if (ret)
> +				return ret;
> +			data->repeat_rate_idx = i;

> +			return ret;

You meant break here or return 0; ?

> +		}
> +
> +	return ret;
> +}

You can rewrite this as

	unsigned int i;
	int ret;

	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++) {
		if (apds9306_repeat_rate_freq[i][0] == val &&
		    apds9306_repeat_rate_freq[i][1] == val2)
			break;
	}
	if (i == ARRAY_SIZE(apds9306_repeat_rate_freq))
		return -EINVAL;

	ret = regmap_field_write(data->regfield_repeat_rate, i);
	if (ret)
		return ret;

	data->repeat_rate_idx = i;

	return 0;

...which is easier to read and understand.

...

> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
> +				     data->intg_time_idx, val, val2, &gain_sel);
> +	if (ret) {
> +		for (i = 0; i < data->gts.num_itime; i++) {
> +			time_sel = data->gts.itime_table[i].sel;
> +
> +			if (time_sel == data->intg_time_idx)
> +				continue;
> +
> +			ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
> +						time_sel, val, val2, &gain_sel);
> +			if (!ret)
> +				break;
> +		}
> +		if (ret)
> +			return -EINVAL;
> +
> +		ret = apds9306_intg_time_set_hw(data, time_sel);
> +		if (ret)
> +			return ret;

Looks like a candidate for a helper function.

> +	}

...

> +	if (val < 0 || val > APDS9306_ALS_PERSIST_VAL_MAX)

in_range()

> +		return -EINVAL;

...

> +static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> +				     int *val)
> +{
> +	int var, ret;
> +	u8 buff[3];
> +
> +	if (dir == IIO_EV_DIR_RISING)
> +		var = APDS9306_ALS_THRES_UP_0;
> +	else if (dir == IIO_EV_DIR_FALLING)
> +		var = APDS9306_ALS_THRES_LOW_0;
> +	else
> +		return -EINVAL;

> +	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
> +	if (ret)
> +		return ret;
> +	*val = get_unaligned_le24(&buff);
> +	return 0;

In some cases you put blank line(s) in between, in some seems not. Please,
be consistent with your style for whatever it is: blank lines, comments,
indentation, ...

> +}

...

> +	if (val < 0 || val > APDS9306_ALS_THRES_VAL_MAX)

in_range()

> +		return -EINVAL;

...

> +	if (val < 0 || val > APDS9306_ALS_THRES_VAR_VAL_MAX)

Ditto.

> +		return -EINVAL;

...

> +		return iio_gts_all_avail_scales(&data->gts, vals, type,
> +						length);

It's exactly 80 character if on a single line, why wrapped?

...

> +	mutex_lock(&data->mutex);

You can use guard() from cleanup.h for this kind of stuff to make your life and
maintenance easier.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:

> +		if (!val)

What's wrong with positive check and even more with the usual pattern -- check
for errors first?

> +			ret = apds9306_intg_time_set(data, val2);
> +		else
> +			ret = -EINVAL;
> +		break;

With the above (i.e guard() use) this will become as simple as

		if (val)
			return -EINVAL;

		return apds9306_intg_time_set(data, val2);

> +	case IIO_CHAN_INFO_SCALE:
> +		ret = apds9306_scale_set(data, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = apds9306_sampling_freq_set(data, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);

...

> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		mutex_lock(&data->mutex);
> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
> +			ret = apds9306_event_period_get(data, val);
> +		else
> +			ret = apds9306_event_thresh_get(data, dir, val);
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		mutex_lock(&data->mutex);
> +		ret = apds9306_event_thresh_adaptive_get(data, val);
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}

This will benefit from guard() or scoped_guard().
And many other functions in your driver.
I believe ~15% of LoCs can be dropped with help of cleanup.h.

...

> +#define APDS9306_IIO_INFO \
> +	.read_avail = apds9306_read_avail, \
> +	.read_raw = apds9306_read_raw, \
> +	.write_raw = apds9306_write_raw, \
> +	.write_raw_get_fmt = apds9306_write_raw_get_fmt,

Not using this macro will only add 1 LoC, but will be much easier to read.

...

> +			return dev_err_probe(dev, ret,
> +					"failed to assign interrupt.\n");

Indentation issue.

...

> +		return dev_err_probe(dev, ret,
> +				"failed to add action on driver unwind\n");

Ditto.

...

> +

Unneeded blank line.

> +module_i2c_driver(apds9306_driver);

-- 
With Best Regards,
Andy Shevchenko


