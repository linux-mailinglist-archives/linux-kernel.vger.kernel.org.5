Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EC77A46A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbjIRKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbjIRKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:04:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3531AE;
        Mon, 18 Sep 2023 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695031441; x=1726567441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/Z5f9GB9bjVx4X2MBovZfYK4WSxegcXHdDzt5vr+HE=;
  b=lYKFavdlJzbi4zE8wo3k9Cdw1uazMEH8NGZWJ9+wNrUhkCfHZsz0W5QO
   XFw6uo4kUe8WP6N9FwEPaDOMLVvh7+5LVOONgPHKJVAjxXWJ1UwjBmNUb
   rYzy4Aia8PBgUwvy0xorCp7ANoWsrO6RBwN3gcC0SFX6JOjasVuUpTf0o
   N/d94UD6oW922BSaucBPZGYb5wMtY2RwifOGzf6FLT4/Kvb0jxPYo4PsT
   Wkc/96Mn6C86ywZJQPZ4VU47CAcKw3NIOkCP03GNq27HWsQzJoNESfzAy
   /ESCRVx+g8ZhDjJ74nT70P/iLtQ+3BOoy9qLlZUsOPjOAQgEMqQSNr1qo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="446075407"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446075407"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835964161"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="835964161"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:03:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiB6h-0000000226Y-0uk8;
        Mon, 18 Sep 2023 13:03:55 +0300
Date:   Mon, 18 Sep 2023 13:03:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <ZQggiuLyLGq/ekMS@smile.fi.intel.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918080314.11959-3-jagathjog1996@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:
> The Bosch BMI323 is a 6-axis low-power IMU that provide measurements for
> acceleration, angular rate, and temperature. This sensor includes
> motion-triggered interrupt features, such as a step counter, tap detection,
> and activity/inactivity interrupt capabilities.
> 
> The driver supports various functionalities, including data ready, FIFO
> data handling, and events such as tap detection, step counting, and
> activity interrupts

Missing period.

...

> +#include <linux/regmap.h>
> +#include <linux/bits.h>

Ordered?

Missing units.h.

...

> +#define BMI323_INT_MICRO_TO_RAW(val, val2, scale) (((val) * (scale)) + \
> +						  (((val2) * (scale)) / MEGA))

Better to split:

#define BMI323_INT_MICRO_TO_RAW(val, val2, scale)
	((val) * (scale) + ((val2) * (scale)) / MEGA)

Also note dropped redundant parentheses.

...

> +#define BMI323_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / scale)

...

> +struct bmi323_data {

> +	u32 odrns[2];
> +	u32 odrhz[2];


> +	__le16 steps_count[2];
> +};

I'm wondering if these 2:s anyhow semantically the same? Shouldn't a definition
be used instead of magic number?

...

> +	320 * MEGA,
> +	160 * MEGA,
> +	80 * MEGA,
> +	40 * MEGA,
> +	20 * MEGA,
> +	10 * MEGA,
> +	5 * MEGA,
> +	2500000,

	2500 * KILO,

for the sake of consistency?

> +	1250000,

	1250 * KILO,

> +};

...

> +static int bmi323_write_ext_reg(struct bmi323_data *data, unsigned int ext_addr,
> +				unsigned int ext_data)
> +{
> +	int ret, feature_status;
> +
> +	mutex_lock(&data->mutex);

You can start using cleanup.h, it will reduce your code by a few percents!
But the point is it makes it less error prone and less verbose.

Ditto for the entire code base.

> +	ret = regmap_read(data->regmap, BMI323_FEAT_DATA_STATUS,
> +			  &feature_status);
> +	if (ret)
> +		goto unlock_out;
> +
> +	if (!FIELD_GET(BMI323_FEAT_DATA_TX_RDY_MSK, feature_status)) {
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	ret = regmap_write(data->regmap, BMI323_FEAT_DATA_ADDR, ext_addr);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = regmap_write(data->regmap, BMI323_FEAT_DATA_TX, ext_data);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}

...

> +static int bmi323_update_ext_reg(struct bmi323_data *data,
> +				 unsigned int ext_addr,
> +				 unsigned int mask, unsigned int ext_data)
> +{
> +	unsigned int value;
> +	int ret;
> +
> +	ret = bmi323_read_ext_reg(data, ext_addr, &value);
> +	if (ret)
> +		return ret;
> +
> +	set_mask_bits(&value, mask, ext_data);

> +	ret = bmi323_write_ext_reg(data, ext_addr, value);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return _write_ext_reg(...);

> +}

...

	unsigned int state_value = GENMASK();

> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		msk = BMI323_FEAT_IO0_XYZ_MOTION_MSK;
> +		raw = 512;
> +		config = BMI323_ANYMO1_REG;
> +		irq_msk = BMI323_MOTION_MSK;
> +		set_mask_bits(&irq_field_val, BMI323_MOTION_MSK,
> +			      FIELD_PREP(BMI323_MOTION_MSK, motion_irq));
> +		set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_MOTION_MSK,
> +			      FIELD_PREP(BMI323_FEAT_IO0_XYZ_MOTION_MSK,
> +					 state ? 7 : 0));

state_value

> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		msk = BMI323_FEAT_IO0_XYZ_NOMOTION_MSK;
> +		raw = 0;
> +		config = BMI323_NOMO1_REG;
> +		irq_msk = BMI323_NOMOTION_MSK;
> +		set_mask_bits(&irq_field_val, BMI323_NOMOTION_MSK,
> +			      FIELD_PREP(BMI323_NOMOTION_MSK, motion_irq));
> +		set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_NOMOTION_MSK,
> +			      FIELD_PREP(BMI323_FEAT_IO0_XYZ_NOMOTION_MSK,
> +					 state ? 7 : 0));

Ditto.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}

...

> +static ssize_t in_accel_gesture_tap_max_dur_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	unsigned int reg_value, raw;
> +	int ret, val[2];

Why val is int (i.e. not unsigned)?

> +	ret = bmi323_read_ext_reg(data, BMI323_TAP2_REG, &reg_value);
> +	if (ret)
> +		return ret;
> +
> +	raw = FIELD_GET(BMI323_TAP2_MAX_DUR_MSK, reg_value);

> +	val[0] = raw / BMI323_MAX_GES_DUR_SCALE;
> +	val[1] = BMI323_RAW_TO_MICRO(raw, BMI323_MAX_GES_DUR_SCALE);

> +	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, val);

ARRAY_SIZE()

> +}

...

> +static ssize_t in_accel_gesture_tap_timeout_store(struct device *dev,
> +						  struct device_attribute *attr,
> +						  const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bmi323_data *data = iio_priv(indio_dev);
> +	int ret, val;

> +	if (kstrtoint(buf, 10, &val))
> +		return -EINVAL;

Don't shadow the error code.


> +	if (!(val == 0 || val == 1))
> +		return -EINVAL;

So, effectively you should use kstrtobool().

> +	ret = bmi323_update_ext_reg(data, BMI323_TAP1_REG,
> +				    BMI323_TAP1_TIMOUT_MSK,
> +				    FIELD_PREP(BMI323_TAP1_TIMOUT_MSK, val));
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}

...

> +static const struct attribute_group bmi323_event_attribute_group = {
> +	.attrs = bmi323_event_attributes,
> +};

ATTRIBUTE_GROUPS() ?

...

> +{
> +	struct bmi323_data *data = iio_priv(indio_dev);

> +	int ret;

Unneeded variable, return directly.

> +
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		ret = bmi323_motion_event_en(data, dir, state);
> +		return ret;
> +	case IIO_EV_TYPE_GESTURE:
> +		return bmi323_tap_event_en(data, dir, state);
> +	case IIO_EV_TYPE_CHANGE:
> +		ret = bmi323_step_wtrmrk_en(data, state);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +		case IIO_EV_INFO_RESET_TIMEOUT:
> +			if (val != 0 || val2 < 40000 || val2 > 600000)
> +				return -EINVAL;

			if (val || ...

Use is_range() from minmax.h.

> +
> +			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
> +						      BMI323_QUITE_TIM_GES_SCALE);
> +
> +			return bmi323_update_ext_reg(data, BMI323_TAP3_REG,
> +						     BMI323_TAP3_QT_AFT_GES_MSK,
> +						     FIELD_PREP(BMI323_TAP3_QT_AFT_GES_MSK,

...

> +		case IIO_EV_INFO_TAP2_MIN_DELAY:
> +			if (val != 0 || val2 < 5000 || val2 > 75000)

Ditto.

> +				return -EINVAL;
> +
> +			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
> +						      BMI323_DUR_BW_TAP_SCALE);
> +
> +			return bmi323_update_ext_reg(data, BMI323_TAP3_REG,
> +						     BMI323_TAP3_QT_BW_TAP_MSK,
> +						     FIELD_PREP(BMI323_TAP3_QT_BW_TAP_MSK,
> +								raw));

...

> +		case IIO_EV_INFO_VALUE:
> +			if (val < 0 || val > 7)
> +				return -EINVAL;

Ditto.

> +			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
> +						      BMI323_MOTION_THRES_SCALE);
> +
> +			return bmi323_update_ext_reg(data, reg,
> +						     BMI323_MO1_SLOPE_TH_MSK,
> +						     FIELD_PREP(BMI323_MO1_SLOPE_TH_MSK,
> +								raw));
> +		case IIO_EV_INFO_PERIOD:
> +			if (val < 0 || val > 162)

Ditto.

> +				return -EINVAL;
> +
> +			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
> +						      BMI323_MOTION_DURAT_SCALE);
> +
> +			return bmi323_update_ext_reg(data,
> +						     reg + BMI323_MO3_OFFSET,
> +						     BMI323_MO3_DURA_MSK,
> +						     FIELD_PREP(BMI323_MO3_DURA_MSK,
> +								raw));
> +		case IIO_EV_INFO_HYSTERESIS:
> +			if (!(val == 0 || val == 1))

Ditto.

> +				return -EINVAL;
> +
> +			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
> +						      BMI323_MOTION_HYSTR_SCALE);
> +
> +			return bmi323_update_ext_reg(data,
> +						     reg + BMI323_MO2_OFFSET,
> +						     BMI323_MO2_HYSTR_MSK,
> +						     FIELD_PREP(BMI323_MO2_HYSTR_MSK,
> +								raw));

...

> +	case IIO_EV_TYPE_CHANGE:
> +		if (val < 0 || val > 20460)

Ditto.

> +			return -EINVAL;
> +
> +		raw = val / 20;
> +		return bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
> +					     BMI323_STEP_SC1_WTRMRK_MSK,
> +					     FIELD_PREP(BMI323_STEP_SC1_WTRMRK_MSK,
> +							raw));

...

> +	if (val > BMI323_FIFO_FULL_IN_FRAMES)
> +		val = BMI323_FIFO_FULL_IN_FRAMES;

min()

...

> +	ret = regmap_update_bits(data->regmap, BMI323_FIFO_CONF_REG,
> +				 BMI323_FIFO_CONF_ACC_GYR_EN_MSK,
> +				 FIELD_PREP(BMI323_FIFO_CONF_ACC_GYR_EN_MSK,
> +					    3));

GENMASK() ?

> +	if (ret)
> +		goto unlock_out;

...

> +	state = data->state == BMI323_BUFFER_FIFO ? true : false;

== already results in boolean type.

...

> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);

Place them closer to the respective callbacks.

...

> +	if (!status || FIELD_GET(BMI323_STATUS_ERROR_MSK, status)) {
> +		dev_err(data->dev, "status error = 0x%x\n", status);

If it's not your interrupt you may flood the logs here.

> +		return IRQ_NONE;
> +	}

...

> +	int ret, raw;

Why raw is signed?

> +	for (raw = 0; raw < ARRAY_SIZE(bmi323_accel_gyro_avrg); raw++)
> +		if (avg == bmi323_accel_gyro_avrg[raw])
> +			break;

> +	if (raw >= ARRAY_SIZE(bmi323_accel_gyro_avrg))

When is the > part true?

> +		return -EINVAL;

...

> +static const struct attribute_group bmi323_attrs_group = {
> +	.attrs = bmi323_attributes,
> +};

ATTRIBUTE_GROUPS() ?

...

> +	ret = bmi323_feature_engine_events(data, BMI323_FEAT_IO0_STP_CNT_MSK,
> +					   val ? 1 : 0);

Ternary here...

> +	if (ret)
> +		return ret;
> +
> +	set_mask_bits(&data->feature_events, BMI323_FEAT_IO0_STP_CNT_MSK,
> +		      FIELD_PREP(BMI323_FEAT_IO0_STP_CNT_MSK, val ? 1 : 0));

...and here are dups.

> +	return ret;

Can it be not 0 here?

...

> +static int bmi323_get_temp_data(struct bmi323_data *data, int *val)
> +{
> +	unsigned int value;

Why it's not defined as __le16 to begin with?

> +	int ret;
> +
> +	ret = bmi323_get_error_status(data);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = regmap_read(data->regmap, BMI323_TEMP_REG, &value);
> +	if (ret)
> +		return ret;
> +
> +	*val = sign_extend32(le16_to_cpup((const __le16 *)&value), 15);

No, simply no castings here.

> +	return IIO_VAL_INT;
> +}

...

> +	if (bmi323_acc_gyro_odr[odr_index][0] <= 25)

Why not positive check: if (... > 25) ... else ...?

> +		mode = ACC_GYRO_MODE_DUTYCYCLE;
> +	else
> +		mode = ACC_GYRO_MODE_CONTINOUS;

...

> +	int odr_raw, ret;

Why odr_raw is signed?

> +
> +	odr_raw = ARRAY_SIZE(bmi323_acc_gyro_odr);
> +
> +	while (odr_raw--)
> +		if (odr == bmi323_acc_gyro_odr[odr_raw][0] &&
> +		    uodr == bmi323_acc_gyro_odr[odr_raw][1])
> +			break;
> +	if (odr_raw < 0)
> +		return -EINVAL;

In one case in the code you used for-loop, here is while-loop. Maybe a bit of
consistency?

...

> +static int bmi323_set_scale(struct bmi323_data *data,
> +			    enum bmi323_sensor_type sensor, int val, int val2)
> +{
> +	int scale_raw;
> +
> +	if (data->state != BMI323_IDLE)
> +		return -EBUSY;
> +
> +	scale_raw = bmi323_hw[sensor].scale_table_len;
> +
> +	while (scale_raw--)
> +		if (val == bmi323_hw[sensor].scale_table[scale_raw][0] &&
> +		    val2 == bmi323_hw[sensor].scale_table[scale_raw][1])
> +			break;
> +	if (scale_raw < 0)
> +		return -EINVAL;

Note, here is a different case and hence fine to be while-loop.

> +	return regmap_update_bits(data->regmap, bmi323_hw[sensor].config,
> +				  BMI323_ACC_GYRO_CONF_SCL_MSK,
> +				  FIELD_PREP(BMI323_ACC_GYRO_CONF_SCL_MSK,
> +					     scale_raw));
> +}

...

> +	fwnode = dev_fwnode(data->dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq > 0) {
> +		irq_pin = BMI323_IRQ_INT1;
> +	} else {
> +		irq = fwnode_irq_get_byname(fwnode, "INT2");
> +		if (irq <= 0)

When can it be == 0?

> +			return 0;
> +
> +		irq_pin = BMI323_IRQ_INT2;
> +	}

...

> +	irq_type = irqd_get_trigger_type(desc);

> +

Redundant blank line.

> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +		latch = false;
> +		active_high = true;
> +		break;
> +	case IRQF_TRIGGER_HIGH:
> +		latch = true;
> +		active_high = true;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		latch = false;
> +		active_high = false;
> +		break;
> +	case IRQF_TRIGGER_LOW:
> +		latch = true;
> +		active_high = false;
> +		break;
> +	default:
> +		dev_err(data->dev, "Invalid interrupt type 0x%x specified\n",
> +			irq_type);
> +		return -EINVAL;

Here and above, why not dev_err_probe() as you used it already below?

> +	}

...

> +	if (en) {

> +		ret = regmap_write(data->regmap, BMI323_FEAT_IO2_REG,
> +				   0x012c);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(data->regmap, BMI323_FEAT_IO_STATUS_REG,
> +				   BMI323_FEAT_IO_STATUS_MSK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(data->regmap, BMI323_FEAT_CTRL_REG,
> +				   BMI323_FEAT_ENG_EN_MSK);
> +		if (ret)
> +			return ret;

> +		i = 5;
> +		do {
> +			ret = regmap_read(data->regmap, BMI323_FEAT_IO1_REG,
> +					  &feature_status);
> +			if (ret)
> +				return ret;
> +
> +			i--;
> +			mdelay(2);
> +		} while (feature_status != 0x01 && i);

NIH regmap_read_poll_timeout().

> +		if (feature_status != 0x01) {
> +			dev_err(data->dev, "Failed to enable feature engine\n");
> +			return -EINVAL;
> +		}
> +
> +		return ret;

> +	} else {

Redundant. But here it's okay to leave (I can understand the justification).

> +		return regmap_write(data->regmap, BMI323_FEAT_CTRL_REG, 0);
> +	}

...

> +	if ((val & 0xFF) != BMI323_CHIP_ID_VAL) {

GENMASK() ? (BIT(x) - 1) ? A defined constant?

> +		dev_err(data->dev, "Chip ID mismatch\n");
> +		return -EINVAL;

Why not dev_err_probe() in this entire function?

> +	}

...

> +	ret = devm_add_action_or_reset(data->dev, bmi323_disable, data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return devm_...

...

> +	regmap = dev_get_regmap(dev, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "No regmap\n");
> +		return -EINVAL;

Why not dev_err_probe()?

> +	}

> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

...

> +static int bmi323_regmap_i2c_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct i2c_msg msgs[2];

> +	u8 *buff = NULL;

Redundant assignment.

> +	int ret;
> +
> +	buff = kmalloc(val_size + BMI323_I2C_DUMMY, GFP_KERNEL);

size_add() and include overflow.h for it.

> +	if (!buff)
> +		return -ENOMEM;
> +
> +	msgs[0].addr = i2c->addr;
> +	msgs[0].flags = i2c->flags;
> +	msgs[0].len = reg_size;
> +	msgs[0].buf = (u8 *)reg_buf;
> +
> +	msgs[1].addr = i2c->addr;
> +	msgs[1].len = val_size + BMI323_I2C_DUMMY;
> +	msgs[1].buf = (u8 *)buff;
> +	msgs[1].flags = i2c->flags | I2C_M_RD;
> +
> +	ret = i2c_transfer(i2c->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0) {
> +		kfree(buff);

With cleanup.h this will look better.

> +		return -EIO;
> +	}
> +
> +	memcpy(val_buf, buff + BMI323_I2C_DUMMY, val_size);
> +	kfree(buff);
> +
> +	return 0;
> +}

...

> +static int bmi323_regmap_i2c_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +	u8 reg;
> +
> +	reg = *(u8 *)data;
> +	ret = i2c_smbus_write_i2c_block_data(i2c, reg, count - 1,
> +					     data + sizeof(u8));
> +
> +	return ret;
> +}

Hmm... Don't we have a better approach for these? regmap doesn't provide SMBus
accessors?

...

> +static const struct i2c_device_id bmi323_i2c_ids[] = {
> +	{ "bmi323", 0 },

', 0' is redundant

> +	{ }
> +};

...

> +static int bmi323_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	u8 reg, *buff = NULL;
> +	int ret;
> +
> +	buff = kmalloc(val_size + BMI323_SPI_DUMMY, GFP_KERNEL);

As per i2c part.

> +	if (!buff)
> +		return -ENOMEM;
> +
> +	reg = *(u8 *)reg_buf | 0x80;

Doesn't regmap configuration provide a way to set this?

> +	ret = spi_write_then_read(spi, &reg, sizeof(reg), buff,
> +				  val_size + BMI323_SPI_DUMMY);
> +	if (ret) {
> +		kfree(buff);
> +		return ret;
> +	}
> +
> +	memcpy(val_buf, buff + BMI323_SPI_DUMMY, val_size);
> +	kfree(buff);
> +
> +	return ret;
> +}

...

> +	regmap = devm_regmap_init(dev, &bmi323_regmap_bus, dev,
> +				  &bmi323_regmap_config);

> +

Redundant blank line.

> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize SPI Regmap\n");
> +

...

> +static const struct spi_device_id bmi323_spi_ids[] = {
> +	{ "bmi323", 0 },

As per above.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


