Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EB7F6458
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjKWQrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKWQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:47:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB098AD;
        Thu, 23 Nov 2023 08:47:37 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423430454"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="423430454"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 08:47:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="802018855"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="802018855"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 08:47:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1r6CrO-0000000GPw7-3xQR;
        Thu, 23 Nov 2023 18:47:26 +0200
Date:   Thu, 23 Nov 2023 18:47:26 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     mitrutzceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZV-CHima8bpXcopc@smile.fi.intel.com>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
 <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 05:23:22PM +0200, mitrutzceclan wrote:
> From: Dumitru Ceclan <mitrutzceclan@gmail.com>

Thank you for the update!
My comments below.

> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> 

One blank line is enough here.

> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

...

> V5->V6
>  - No changes

Don't issue patches too often (minimum gap between versions is 24h).

...

> +	help
> +	  Say yes here to build support for Analog Devices AD7173 and similar ADC
> +	  Currently supported models:
> +	    AD7172-2,
> +	    AD7173-8,
> +	    AD7175-2,
> +	    AD7176-2

I would use

 - FOO
 - BAR

style that will reduce amount of potential churn if you need to add an entry at
the end of this list.

> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7173.

...

> +#include <linux/stddef.h>

You probably meant types.h here (it will include stddef, at least most of
the code relies on that), which is currently absent.

...

> +struct ad7173_device_info {
> +	char *name;
> +	unsigned int id;
> +	unsigned int num_inputs;
> +	unsigned int num_configs;
> +	unsigned int num_channels;

> +	unsigned char num_gpios;

I would use u8 as you have done for cfg_slot, for example. As it holds a number
and not a real character.

> +	bool has_temp;
> +	unsigned int clock;
> +
> +	const unsigned int *sinc5_data_rates;
> +	unsigned int num_sinc5_data_rates;
> +};

...

> +struct ad7173_channel_config {
> +	u8 cfg_slot;
> +	bool live;

Perhaps a blank line?

> +	/* Following fields are used to compare equality. */
> +	struct_group(config_props,
> +		bool bipolar;
> +		bool input_buf;
> +		u8 odr;
> +		u8 ref_sel;
> +	);
> +};

...

> +struct ad7173_state {
> +	const struct ad7173_device_info *info;
> +	struct ad_sigma_delta sd;

It might be better to embed that struct first. In any case you always can
consult with `pahole` tool for data structure layouts.

> +	struct ad7173_channel *channels;
> +	struct regulator_bulk_data regulators[3];
> +	unsigned int adc_mode;
> +	unsigned int interface_mode;
> +	unsigned int num_channels;
> +	struct ida cfg_slots_status;
> +	unsigned long long config_usage_counter;
> +	unsigned long long *config_cnts;
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +	struct regmap *reg_gpiocon_regmap;
> +	struct gpio_regmap *gpio_regmap;
> +#endif
> +};

...

> +static const char *const ad7173_ref_sel_str[] = {
> +	[AD7173_SETUP_REF_SEL_EXT_REF]    = "refin",
> +	[AD7173_SETUP_REF_SEL_EXT_REF2]   = "refin2",
> +	[AD7173_SETUP_REF_SEL_INT_REF]    = "refout-avss",

> +	[AD7173_SETUP_REF_SEL_AVDD1_AVSS] = "avdd"

Leave trailing comma here as well.

> +};

...

> +	struct device *dev = &st->sd.spi->dev;

For example, here st->sd become a no-op at compile time (see above about
placing sd to be the first member). The code generation can be checked
(for the size) by bloat-o-meter.

...

> +static int ad7173_free_config_slot_lru(struct ad7173_state *st)

> +static int ad7173_load_config(struct ad7173_state *st,
> +			      struct ad7173_channel_config *cfg)

Have you checked, btw, list_lru.h? Maybe all this can be simply changed by
using existing library?

...

> +	return vref / (MICRO/MILLI);

Wouldn't MILLI in the denominator just suffice?

...

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		reg = st->channels[chan->address].cfg.odr;
> +
> +		*val = st->info->sinc5_data_rates[reg] / MILLI;
> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO/MILLI);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}

> +	return -EINVAL;

Make this 'default' case.

...

> +static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		if (test_bit(i, scan_mask))
> +			ret = ad7173_set_channel(&st->sd, i);
> +		else
> +			ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(i), 2, 0);

> +

Unneeded blank line.

> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

> +static int ad7173_debug(struct iio_dev *indio_dev, unsigned int reg,
> +			unsigned int writeval, unsigned int *readval)

Hmm... The function suggests it debugs something or helps with debugging
something. Without actual description is hard to understand the purpose.
Can you add a top comment on this function with explanations?

...

> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);

One line?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");

...

> +			return dev_err_probe(dev, -EINVAL,
> +				"Input pin number out of range for pair (%d %d).", ain[0], ain[1]);

Seems broken indentation.

...

> +		ret = fwnode_property_read_string(child, "adi,reference-select", &ref_label);
> +		if (!ret) {
> +			for (i = 0; i < ARRAY_SIZE(ad7173_ref_sel_str); i++)
> +				if (strcmp(ref_label, ad7173_ref_sel_str[i]) == 0) {
> +					ref_sel = i;
> +					break;
> +				}

> +			if (i == ARRAY_SIZE(ad7173_ref_sel_str))
> +				return dev_err_probe(dev, -EINVAL, "Invalid channel reference name %s", ref_label);

Too long line.

> +		} else if (ret != -EINVAL) {
> +			return dev_err_probe(dev, ret, "Invalid channel reference value");
> +		}


Use standard pattern and it will be easier to see that 'else' is redundant.

		if (ret == -EINVAL) // However I don't like this handling of
				    // properties, but up to you and maintainer
			ret = 0;
		if (ret)
			return dev_err_probe(...);


BUT. Isn't it a home grown variant of fwnode_property_match_property_string()?

...

> +		ret = ad7173_get_ref_voltage_milli(st, (u8)ref_sel);

Why casting?

> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Cannot use reference %u", ref_sel);

...

> +			return dev_err_probe(dev, -EINVAL, "External reference 2 is only available on ad7173-8");

Missing \n. Check all your messages that they are terminated with \n.

...

> +	struct ad7173_state *st;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	int ret;

Reversed xmas tree order?

	struct device *dev = &spi->dev;
	struct iio_dev *indio_dev;
	struct ad7173_state *st;
	int ret;

...

> +static const struct of_device_id ad7173_of_match[] = {
> +	{ .compatible = "adi,ad7172-2",
> +	  .data = &ad7173_device_info[ID_AD7172_2], },
> +	{ .compatible = "adi,ad7173-8",
> +	  .data = &ad7173_device_info[ID_AD7173_8], },
> +	{ .compatible = "adi,ad7175-2",
> +	  .data = &ad7173_device_info[ID_AD7175_2], },
> +	{ .compatible = "adi,ad7176-2",
> +	  .data = &ad7173_device_info[ID_AD7176_2], },

Last inner commas are not needed.

> +	{ }
> +};

...

> +static const struct spi_device_id ad7173_id_table[] = {
> +	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2], },
> +	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8], },
> +	{ "ad7175-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_2], },
> +	{ "ad7176-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7176_2], },

Ditto.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


