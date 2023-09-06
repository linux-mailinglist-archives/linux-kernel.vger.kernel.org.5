Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D77940B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbjIFPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbjIFPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:49:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6E1724;
        Wed,  6 Sep 2023 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694015344; x=1725551344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8TyErlWPn2OUMyUTIznB++mBYdEmrHlwUWEDV0fBkZw=;
  b=NgN7OLbLeKQQCdSPhlZW4bRzncls8LP96qmE/sDcpdxVLdX6PZMHN+H6
   nFofhSrscne53QmpBuwIFlk7L6W7VQLqIFvms7zfI3ZozIjZIiD1hNHAJ
   LOBx8YzVVl6NNMj0rVkUPzfJKeFJpQHUdMb3gEBPClWT4tG1TPPodBxpz
   XpL3bBS3Wddkwd+DajR1dIgaFywxzmEa3dyFI40hHQbtWyrgJa8PbLbiO
   Cnz8/2lLKjZr5VLMkKC/iaXVIR4+NP+4o4oycXacM9qT3iqrupLaloWee
   LJ/iIgQ9lbeBJQhugrZuuZBwijryP1mE4oBc0KMXCcAy0KQBmA7GdMOcU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367327036"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="367327036"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="1072432761"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="1072432761"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:48:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qduln-006yvU-01;
        Wed, 06 Sep 2023 18:48:43 +0300
Date:   Wed, 6 Sep 2023 18:48:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <ZPifWlRvX5hLFPvG@smile.fi.intel.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:
> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
> averaging and internal FIFO. The sensor does also provide temperature
> measurements.
> 
> Sensor does also contain IIR filter implemented in HW. The data-sheet
> says the IIR filter can be configured to be "weak", "middle" or
> "strong". Some RMS noise figures are provided in data sheet but no
> accurate maths for the filter configurations is provided. Hence, the IIR
> filter configuration is not supported by this driver and the filter is
> configured to the "middle" setting (at least not for now).
> 
> The FIFO measurement mode is only measuring the pressure and not the
> temperature. The driver measures temperature when FIFO is flushed and
> simply uses the same measured temperature value to all reported
> temperatures. This should not be a problem when temperature is not
> changing very rapidly (several degrees C / second) but allows users to
> get the temperature measurements from sensor without any additional logic.

...

> +struct bm1390_data_buf {
> +	u32 pressure;
> +	__be16 temp;

> +	s64 ts __aligned(8);

Would like to see aligned_s64, but it will depend on my series, so not your
problem and not right now :-)

> +};

...

> +struct bm1390_data {
> +	int64_t timestamp, old_timestamp;

Out of a sudden int64_t instead of u64?

> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct bm1390_data_buf buf;
> +	int irq;
> +	unsigned int state;
> +	bool trigger_enabled;

> +	u8 watermark;

Or u8 instead of uint8_t?

> +	/* Prevent accessing sensor during FIFO read sequence */
> +	struct mutex mutex;
> +};

...

> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
> +{
> +	u8 temp_reg[2] __aligned(2);

Why?! Just use proper bitwise type.

> +	__be16 *temp_raw;
> +	int ret;
> +	s16 val;
> +	bool negative;
> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
> +			       sizeof(temp_reg));
> +	if (ret)
> +		return ret;
> +
> +	if (temp_reg[0] & 0x80)
> +		negative = true;
> +	else
> +		negative = false;

> +	temp_raw = (__be16 *)&temp_reg[0];

Heck no. Make temp_reg be properly typed.

> +	val = be16_to_cpu(*temp_raw);
> +
> +	if (negative) {
> +		/*
> +		 * Two's complement. I am not sure if all supported
> +		 * architectures actually use 2's complement represantation of
> +		 * signed ints. If yes, then we could just do the endianes
> +		 * conversion and say this is the s16 value. However, as I
> +		 * don't know, and as the conversion is pretty simple. let's
> +		 * just convert the signed 2's complement to absolute value and
> +		 * multiply by -1.
> +		 */
> +		val = ~val + 1;
> +		val *= -1;
> +	}
> +
> +	*temp = val;
> +
> +	return 0;
> +}

> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
> +{
> +	int ret;
> +	u8 raw[3];
> +
> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
> +			       &raw[0], sizeof(raw));
> +	if (ret < 0)
> +		return ret;
> +
> +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
> +
> +	return 0;
> +}

...

> + /* The enum values map directly to register bits */

In this case assign _all_ values explicitly. Currently it's prone to errors
if somebody squeezed a value in between.

> +enum bm1390_meas_mode {
> +	BM1390_MEAS_MODE_STOP = 0x0,
> +	BM1390_MEAS_MODE_1SHOT,
> +	BM1390_MEAS_MODE_CONTINUOUS,
> +};

...

> +	mutex_lock(&data->mutex);

Wouldn't you like to start using cleanup.h?

...

> +	/*
> +	 * We use 'continuous mode' even for raw read because according to the
> +	 * data-sheet an one-shot mode can't be used with IIR filter

Missing period at the end.

> +	 */

...

> +		goto unlock_out;

cleanup.h makes these goto:s unneeded.

...

> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 31;
> +			*val2 = 250000;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		} else if (chan->type == IIO_PRESSURE) {
> +			*val = 0;
> +			/*
> +			 * pressure in hPa is register value divided by 2048.
> +			 * This means kPa is 1/20480 times the register value,
> +			 * which equals to 48828.125 * 10 ^ -9
> +			 * This is 48828.125 nano kPa.
> +			 *
> +			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
> +			 * get 48828 - which means we lose some accuracy. Well,
> +			 * let's try to live with that.
> +			 */
> +			*val2 = 48828;
> +
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +
> +		return -EINVAL;

Why not switch-case like other drivers do?

> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(idev);
> +		if (ret)
> +			return ret;
> +
> +		ret = bm1390_read_data(data, chan, val, val2);
> +		iio_device_release_direct_mode(idev);

> +		if (!ret)
> +			return IIO_VAL_INT;
> +
> +		return ret;

Why not usual pattern?

		if (ret)
			return ret;

> +	default:
> +		return -EINVAL;
> +	}

...

> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);

> +

Unneeded blank line.

> +	if (smp_lvl > 4) {
> +		/*
> +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
> +		 * bit errors in I2C line. Don't overflow if this happens.
> +		 */
> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
> +		smp_lvl = 4;
> +	}

> +	if (!smp_lvl)
> +		return ret;

This can be checked first as it's and error condition and previous branch has
no side effects on this. Also, wouldn't be better to use error code explicitly?

...

> +static int bm1390_write_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(idev);
> +	if (ret)
> +		return ret;

> +	switch (mask) {
> +	default:
> +		ret = -EINVAL;
> +	}

This needs a comment: Why we have a dead code.

> +	iio_device_release_direct_mode(idev);
> +
> +	return ret;
> +}

...

> +	/*
> +	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
> +	 * be fixed when IIR is in use

Missing period.

> +	 */

...

> +	ret = regmap_read(data->regmap, BM1390_REG_STATUS,
> +			  &dummy);

This is perfectly one line even for fanatics of 80 characters limitation.

> +	if (ret || !dummy)
> +		return IRQ_NONE;

...

> +	if (state) {
> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);

This ret is never used, what's going on here?

> +	} else {
> +		int dummy;
> +
> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
> +
> +		/*
> +		 * We need to read the status register in order to ACK the
> +		 * data-ready which may have been generated just before we
> +		 * disabled the measurement.
> +		 */
> +		if (!ret)
> +			ret = regmap_read(data->regmap, BM1390_REG_STATUS,
> +					  &dummy);
> +	}
> +
> +	ret = bm1390_set_drdy_irq(data, state);
> +	if (ret)
> +		goto unlock_out;

> +
> +

One blank line is enough.

> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;

> +

We do not put blank lines at the end of functions.

> +}

...

> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
> +					      &iio_pollfunc_store_time,
> +					      &bm1390_trigger_handler,
> +					      &bm1390_buffer_ops);

> +

Yet another redundant blank line. I dunno how you manage to almost in every
second attempt to randomly place blank lines here and there... I feel like
a conspiracy theory against myself :-)

> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio_triggered_buffer_setup FAIL\n");

...

> +
> +

Ditto.

> +	ret = devm_iio_trigger_register(data->dev, itrig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Trigger registration failed\n");

> +
> +

Ditto.

> +	return ret;

...

> +	ret = devm_iio_device_register(dev, idev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +

> +	return ret;

Do you expect anything than 0 here?

-- 
With Best Regards,
Andy Shevchenko


