Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04257F1371
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjKTMfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:35:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF7D2;
        Mon, 20 Nov 2023 04:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700483746; x=1732019746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EW4QOV8Cp40d80U9mTKsMaiSKXMcK1syNIIBO5FEK4k=;
  b=bXHwtTpukQgTif3Fao8IRVHoOslAnB5Eddonpzyt6GlNRzVs8cfj0Vxd
   FKVg07FM/vbKsvuYynjL4MqYxqGaR1Dp3ECebJbOzuAsKht4+/WanMc0D
   jMXoNogjZVoqvgisPMgFxQJBsNWCL/1AZkgY65D14cFXd4M7qz6szXA2T
   G9fIXoTUzNKVaz4VkDtBoIafolOYXDFZKCsSnbzWCyNbyPuL6N+4NehuQ
   cspw/XPbh7lOwiK8crvSTDFQez0FTs4qxTa2mDVY8PTn4SjFDFA/TxalU
   c27Oj4WkicH0a2qKSmP5nUfV91uD2Q+E2Zv7DQHuXA+YQ1K+yxKL8p/6J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477818183"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="477818183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:35:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="795454521"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="795454521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:35:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r53V5-0000000FXzK-2as6;
        Mon, 20 Nov 2023 14:35:39 +0200
Date:   Mon, 20 Nov 2023 14:35:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: driver for Honeywell HSC/SSC series
 pressure sensors
Message-ID: <ZVtSm5f-Qyp8LFFp@smile.fi.intel.com>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117164232.8474-2-petre.rodan@subdimension.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117164232.8474-2-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 06:42:06PM +0200, Petre Rodan wrote:
> Adds driver for Honeywell TruStability HSC and SSC series pressure and
> temperature sensors.
> 
> Covers i2c and spi-based interfaces. For both series it supports all the
> combinations of four transfer functions and all 118 pressure ranges.
> In case of a special chip not covered by the nomenclature a custom range
> can be specified.
> 
> Devices tested:
>  HSCMLNN100PASA3 (SPI sensor)
>  HSCMRNN030PA2A3 (i2c sensor)

> Datasheet:
>  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
>  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
>  [i2c comms] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf

Make it a single tag per one URL as
Datasheet: URL_#1 [xxx]
Datasheet: URL_#2 [yyy]


> 

No blank line in tags block.

> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

...

> +config HSC030PA
> +	tristate "Honeywell HSC/SSC (TruStability pressure sensors series)"
> +	depends on (I2C || SPI_MASTER)

> +	select HSC030PA_I2C if (I2C)
> +	select HSC030PA_SPI if (SPI_MASTER)

Unneeded parentheses

> +	help
> +	  Say Y here to build support for the Honeywell HSC and SSC TruStability
> +      pressure and temperature sensor series.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called hsc030pa.

Yeah besides indentation issues the LKP complain about this.

...

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/init.h>
> +#include <linux/math64.h>
> +#include <linux/units.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/printk.h>

Keep them sorted alphabetically.
Also there are missing at least these ones: array_size.h, types.h.

+ blank line

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

+ blank line.

> +#include "hsc030pa.h"

...

> +// pressure range for current chip based on the nomenclature
> +struct hsc_range_config {
> +	char name[HSC_RANGE_STR_LEN];	// 5-char string that defines the range - ie "030PA"
> +	s32 pmin;		// minimal pressure in pascals
> +	s32 pmax;		// maximum pressure in pascals
> +};

Can you utilize linear ranges data types and APIs? (linear_range.h)

...

> +/*
> + * the first two bits from the first byte contain a status code
> + *
> + * 00 - normal operation, valid data
> + * 01 - device in hidden factory command mode
> + * 10 - stale data
> + * 11 - diagnostic condition
> + *
> + * function returns 1 only if both bits are zero
> + */

You really need to be consistent with style of multi-line comments.
And also C++/C variants. Besides that, respect English grammar and
punctuation.

...

> +static bool hsc_measurement_is_valid(struct hsc_data *data)
> +{
> +	if (data->buffer[0] & 0xc0)
> +		return 0;
> +
> +	return 1;

You use bool and return integers.

Besides, it can be just a oneliner.

	return !(buffer[0] & GENMASK(3, 2));

(Note, you will need bits.h for this.)

> +}

...

> +static int hsc_get_measurement(struct hsc_data *data)
> +{
> +	const struct hsc_chip_data *chip = data->chip;
> +	int ret;
> +
> +	/* don't bother sensor more than once a second */
> +	if (!time_after(jiffies, data->last_update + HZ))
> +		return data->is_valid ? 0 : -EAGAIN;
> +
> +	data->is_valid = false;
> +	data->last_update = jiffies;
> +
> +	ret = data->xfer(data);

> +

Redundant blank line.

> +	if (ret < 0)
> +		return ret;

> +	ret = chip->valid(data);
> +	if (!ret)
> +		return -EAGAIN;
> +
> +	data->is_valid = true;

Can this be like

	bool is_valid;

	is_valid = chip->valid(...);
	if (!is_valid)
		return ...


	data->is_valid = is_valid;

	// Depending on the flow you can even use that field directly

> +	return 0;
> +}

> +static int hsc_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *channel, int *val,
> +			int *val2, long mask)
> +{
> +	struct hsc_data *data = iio_priv(indio_dev);

> +	int ret = -EINVAL;

Just use value directly, no need to have this assignment.

> +
> +	switch (mask) {

> +

Redundant blank line.

> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = hsc_get_measurement(data);
> +		mutex_unlock(&data->lock);

Use guard() operator from cleanup.h.

> +		if (ret)
> +			return ret;
> +
> +		switch (channel->type) {
> +		case IIO_PRESSURE:
> +			*val =
> +			    ((data->buffer[0] & 0x3f) << 8) + data->buffer[1];
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val =
> +			    (data->buffer[2] << 3) +
> +			    ((data->buffer[3] & 0xe0) >> 5);

Is this some endianess / sign extension? Please convert using proper APIs.

> +			ret = 0;
> +			if (!ret)

lol

> +				return IIO_VAL_INT;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +
> +/**
> + *	IIO ABI expects
> + *	value = (conv + offset) * scale
> + *
> + *	datasheet provides the following formula for determining the temperature
> + *	temp[C] = conv * a + b
> + *        where a = 200/2047; b = -50
> + *
> + *	temp[C] = (conv + (b/a)) * a * (1000)
> + *      =>
> + *	scale = a * 1000 = .097703957 * 1000 = 97.703957
> + *	offset = b/a = -50 / .097703957 = -50000000 / 97704
> + *
> + *	based on the datasheet
> + *	pressure = (conv - HSC_OUTPUT_MIN) * Q + Pmin =
> + *	           ((conv - HSC_OUTPUT_MIN) + Pmin/Q) * Q
> + *	=>
> + *	scale = Q = (Pmax - Pmin) / (HSC_OUTPUT_MAX - HSC_OUTPUT_MIN)
> + *	offset = Pmin/Q = Pmin * (HSC_OUTPUT_MAX - HSC_OUTPUT_MIN) / (Pmax - Pmin)
> + */
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (channel->type) {
> +		case IIO_TEMP:
> +			*val = 97;
> +			*val2 = 703957;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_PRESSURE:
> +			*val = data->p_scale;
> +			*val2 = data->p_scale_nano;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}

> +		break;
> +

Dead code?

> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (channel->type) {
> +		case IIO_TEMP:
> +			*val = -50000000;
> +			*val2 = 97704;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_PRESSURE:
> +			*val = data->p_offset;
> +			*val2 = data->p_offset_nano;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	}

> +	return ret;

Use default with explicit error code.

> +}

...

> +static const struct iio_chan_spec hsc_channels[] = {
> +	{
> +	 .type = IIO_PRESSURE,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET)
> +	 },
> +	{
> +	 .type = IIO_TEMP,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +	 BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET)
> +	 },

Strange indentation of }:s...

> +};

...

> +int hsc_probe(struct iio_dev *indio_dev, struct device *dev,
> +	      const char *name, int type)
> +{
> +	struct hsc_data *hsc;
> +	u64 tmp;
> +	int index;
> +	int found = 0;
> +
> +	hsc = iio_priv(indio_dev);
> +
> +	hsc->last_update = jiffies - HZ;
> +	hsc->chip = &hsc_chip;
> +
> +	if (strcasecmp(hsc->range_str, "na") != 0) {
> +		// chip should be defined in the nomenclature
> +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> +			if (strcasecmp
> +			    (hsc_range_config[index].name,
> +			     hsc->range_str) == 0) {
> +				hsc->pmin = hsc_range_config[index].pmin;
> +				hsc->pmax = hsc_range_config[index].pmax;
> +				found = 1;
> +				break;
> +			}
> +		}

Reinventing match_string() / sysfs_match_string() ?

> +		if (hsc->pmin == hsc->pmax || !found)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "honeywell,range_str is invalid\n");
> +	}
> +
> +	hsc->outmin = hsc_func_spec[hsc->function].output_min;
> +	hsc->outmax = hsc_func_spec[hsc->function].output_max;
> +
> +	// multiply with MICRO and then divide by NANO since the output needs
> +	// to be in KPa as per IIO ABI requirement
> +	tmp = div_s64(((s64) (hsc->pmax - hsc->pmin)) * MICRO,
> +		      (hsc->outmax - hsc->outmin));
> +	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_nano);
> +	tmp =
> +	    div_s64(((s64) hsc->pmin * (s64) (hsc->outmax - hsc->outmin)) *
> +		    MICRO, hsc->pmax - hsc->pmin);

No need to have space after castings

> +	hsc->p_offset =
> +	    div_s64_rem(tmp, NANO, &hsc->p_offset_nano) - hsc->outmin;
> +
> +	mutex_init(&hsc->lock);
> +	indio_dev->name = name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hsc_info;
> +	indio_dev->channels = hsc->chip->channels;
> +	indio_dev->num_channels = hsc->chip->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

This one devm wrapped...

> +void hsc_remove(struct iio_dev *indio_dev)
> +{
> +	iio_device_unregister(indio_dev);
> +}

...but not this. Why do you even need remove if the above is using devm always?

...

> + * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>

> + *

Redundant blank line.

...

> +#ifndef _HSC030PA_H
> +#define _HSC030PA_H

This header is using a lot and you are missing to include even a single
provider. :-(

At first glance:

mutex.h
types.h

A few forward declarations:

struct device;

struct iio_chan_spec;
struct iio_dev;

struct hsc_chip_data;

(Note blank lines in between.)

...

> +struct hsc_data {
> +	void *client;                           // either i2c or spi kernel interface struct for current dev
> +	const struct hsc_chip_data *chip;
> +	struct mutex lock;                      // lock protecting chip reads
> +	int (*xfer)(struct hsc_data *data);    // function that implements the chip reads
> +	bool is_valid;                          // false if last transfer has failed
> +	unsigned long last_update;              // time of last successful conversion
> +	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE]; // raw conversion data
> +	char range_str[HSC_RANGE_STR_LEN];	// range as defined by the chip nomenclature - ie "030PA" or "NA"
> +	s32 pmin;                               // min pressure limit
> +	s32 pmax;                               // max pressure limit
> +	u32 outmin;                             // minimum raw pressure in counts (based on transfer function)
> +	u32 outmax;                             // maximum raw pressure in counts (based on transfer function)
> +	u32 function;                           // transfer function
> +	s64 p_scale;                            // pressure scale
> +	s32 p_scale_nano;                       // pressure scale, decimal places
> +	s64 p_offset;                           // pressure offset
> +	s32 p_offset_nano;                      // pressure offset, decimal places
> +};
> +
> +struct hsc_chip_data {
> +	bool (*valid)(struct hsc_data *data);  // function that checks the two status bits
> +	const struct iio_chan_spec *channels;   // channel specifications
> +	u8 num_channels;                        // pressure and temperature channels
> +};

Convert comments to kernel-doc format.

...

> +enum hsc_func_id {
> +	HSC_FUNCTION_A,
> +	HSC_FUNCTION_B,
> +	HSC_FUNCTION_C,
> +	HSC_FUNCTION_F

Leave trailing comma. It make code slightly better to maintain.

> +};
> +
> +enum hsc_variant {
> +	HSC,
> +	SSC

Ditto.

> +};

...

> +static int hsc_i2c_xfer(struct hsc_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	struct i2c_msg msg;
> +	int ret;
> +
> +	msg.addr = client->addr;
> +	msg.flags = client->flags | I2C_M_RD;
> +	msg.len = HSC_REG_MEASUREMENT_RD_SIZE;
> +	msg.buf = (char *)&data->buffer;
> +
> +	ret = i2c_transfer(client->adapter, &msg, 1);
> +
> +	return (ret == 2) ? 0 : ret;
> +}

Can you use regmap I2C?

...

> +static int hsc_i2c_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)

No use of this function prototype, we have a new one.

...

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> +	if (!indio_dev) {

> +		dev_err(&client->dev, "Failed to allocate device\n");
> +		return -ENOMEM;

First of all, use

		return dev_err_probe();

Second, since it's ENOMEM, we do not issue an errors like this, error
code is already enough.

> +	}
> +
> +	hsc = iio_priv(indio_dev);

> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		hsc->xfer = hsc_i2c_xfer;
> +	else

Redundant 'else', see below.

> +		return -EOPNOTSUPP;

Use traditional pattern, i.e. checking for errors first:

	if (...)
		return ...

...

> +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> +	if (ret == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

Oh, boy, this should check for ENODEV or so, yeah, regulator APIs a bit
interesting.

...

> +	if (!dev_fwnode(dev))
> +		return -EOPNOTSUPP;

Why do you need this?
And why this error code?


> +	ret = device_property_read_u32(dev,
> +				       "honeywell,transfer-function",
> +				       &hsc->function);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "honeywell,transfer-function could not be read\n");

...

> +	ret = device_property_read_string(dev,
> +					  "honeywell,range_str", &range_nom);

One line.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "honeywell,range_str not defined\n");

...

> +	memcpy(hsc->range_str, range_nom, HSC_RANGE_STR_LEN - 1);
> +	hsc->range_str[HSC_RANGE_STR_LEN - 1] = 0;

Oh, why do you need this all and can use the property value directly?
(Besides the fact the interesting operations are being used for strings.)

> +	if (strcasecmp(hsc->range_str, "na") == 0) {
> +		// "not available"
> +		// we got a custom-range chip not covered by the nomenclature
> +		ret = device_property_read_u32(dev,
> +					     "honeywell,pmin-pascal",
> +					     &hsc->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "honeywell,pmin-pascal could not be read\n");
> +		ret = device_property_read_u32(dev,
> +					     "honeywell,pmax-pascal",
> +					     &hsc->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "honeywell,pmax-pascal could not be read\n");
> +	}

...

> +	i2c_set_clientdata(client, indio_dev);

How is this being used?

> +	hsc->client = client;
> +
> +	return hsc_probe(indio_dev, &client->dev, id->name, id->driver_data);
> +}

...

> +static const struct of_device_id hsc_i2c_match[] = {
> +	{.compatible = "honeywell,hsc",},
> +	{.compatible = "honeywell,ssc",},

Inner commas are redundant.

> +	{},

Drop the comma in the terminator entry.

> +};

> +

Redundant blank line.

> +MODULE_DEVICE_TABLE(of, hsc_i2c_match);
> +
> +static const struct i2c_device_id hsc_i2c_id[] = {
> +	{"hsc", HSC},
> +	{"ssc", SSC},

Both ID tables should use pointers in driver data and respective API to get
that.

> +	{}
> +};

> +

Redundant blank line.

> +MODULE_DEVICE_TABLE(i2c, hsc_i2c_id);

...

> +static struct i2c_driver hsc_i2c_driver = {
> +	.driver = {
> +		   .name = "honeywell_hsc",
> +		   .of_match_table = hsc_i2c_match,

> +		   },

Indentation level can be dropped a bit.

> +	.probe = hsc_i2c_probe,
> +	.id_table = hsc_i2c_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(hsc_i2c_driver);

...

> +++ b/drivers/iio/pressure/hsc030pa_spi.c

...

> +	int ret;
> +
> +	ret = spi_sync_transfer(data->client, &xfer, 1);
> +
> +	return ret;

So, why ret is needed?

...

> +	spi_set_drvdata(spi, indio_dev);

How is this being used?

> +	spi->mode = SPI_MODE_0;
> +	spi->max_speed_hz = min(spi->max_speed_hz, 800000U);
> +	spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return ret;

Why the firmware can't provide the correct information to begin with?

...

> +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> +	if (ret == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

As per I2C driver.

But why is not in the main ->probe()?

...

> +	ret = device_property_read_u32(dev,
> +				       "honeywell,transfer-function",
> +				       &hsc->function);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "honeywell,transfer-function could not be read\n");
> +	if (hsc->function > HSC_FUNCTION_F)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "honeywell,transfer-function %d invalid\n",
> +				     hsc->function);
> +
> +	ret =
> +	    device_property_read_string(dev, "honeywell,range_str", &range_nom);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "honeywell,range_str not defined\n");
> +
> +	// minimal input sanitization
> +	memcpy(hsc->range_str, range_nom, HSC_RANGE_STR_LEN - 1);
> +	hsc->range_str[HSC_RANGE_STR_LEN - 1] = 0;
> +
> +	if (strcasecmp(hsc->range_str, "na") == 0) {
> +		// range string "not available"
> +		// we got a custom chip not covered by the nomenclature with a custom range
> +		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> +					       &hsc->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "honeywell,pmin-pascal could not be read\n");
> +		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> +					       &hsc->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "honeywell,pmax-pascal could not be read\n");
> +	}

Ditto. Why is this duplication?

...

> +static const struct of_device_id hsc_spi_match[] = {
> +	{.compatible = "honeywell,hsc",},
> +	{.compatible = "honeywell,ssc",},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, hsc_spi_match);
> +
> +static const struct spi_device_id hsc_spi_id[] = {
> +	{"hsc", HSC},
> +	{"ssc", SSC},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(spi, hsc_spi_id);
> +
> +static struct spi_driver hsc_spi_driver = {
> +	.driver = {
> +		   .name = "honeywell_hsc",
> +		   .of_match_table = hsc_spi_match,
> +		   },
> +	.probe = hsc_spi_probe,
> +	.id_table = hsc_spi_id,
> +};
> +
> +module_spi_driver(hsc_spi_driver);

Same comments as per I2C driver above.

-- 
With Best Regards,
Andy Shevchenko


