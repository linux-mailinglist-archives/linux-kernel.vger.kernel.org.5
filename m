Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B227F13DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjKTNA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:00:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282119C;
        Mon, 20 Nov 2023 05:00:53 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4794400"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="4794400"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 05:00:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="801163675"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="801163675"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 05:00:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1r53tK-0000000FYIP-0fKV;
        Mon, 20 Nov 2023 15:00:42 +0200
Date:   Mon, 20 Nov 2023 15:00:41 +0200
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
Subject: Re: [PATCH v4 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZVtYeWZmcDZ_SMPo@smile.fi.intel.com>
References: <20231116134655.21052-1-user@HYB-hhAwRlzzMZb>
 <20231116134655.21052-2-user@HYB-hhAwRlzzMZb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116134655.21052-2-user@HYB-hhAwRlzzMZb>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:46:55PM +0200, mitrutzceclan wrote:
> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> 
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.

...

> +	help
> +	  Say yes here to build support for Analog Devices AD7173 and similar ADC
> +	  (currently supported: AD7172-2, AD7173-8, AD7175-2, AD7176-2).

This is hard to maintain, list it one model per a single line.

> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7173.

...

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>

> +#include <linux/bits.h>

This is guaranteed to be included by one from the above (don't remember
by heart which one or even both).

+ container_of.h

> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>

> +#include <linux/kernel.h>

How is this being used (as not a proxy)?

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>

...

> +#define AD7173_CH_ADDRESS(pos, neg) \
> +	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) |\

Space before \ here and everywhere else in multi-line definitions.

> +	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))

...

> +#define AD7173_VOLTAGE_INT_REF_MICROV	2500000

MICROV --> uV (yes, with small letter), it's a common use for Amperes, Volts,
etc.

...

> +struct ad7173_channel_config {
> +	bool live;
> +	u8 cfg_slot;
> +	/* Following fields are used to compare equality. Bipolar must be first */
> +	bool bipolar;
> +	bool input_buf;
> +	u8 odr;
> +	u8 ref_sel;

If you group better by types, it might save a few bytes on the architectures /
compilers where bool != byte.

> +};

...

> +	st->reg_gpiocon_regmap = devm_regmap_init_spi(st->sd.spi, &ad7173_regmap_config);
> +	if (IS_ERR(st->reg_gpiocon_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(st->reg_gpiocon_regmap),
> +				     "Unable to init regmap\n");
> +	}

{} are not needed, can also be written as

	st->reg_gpiocon_regmap = devm_regmap_init_spi(st->sd.spi, &ad7173_regmap_config);
	ret = PTR_ERR_OR_ZERO(st->reg_gpiocon_regmap);
	if (ret)
		return dev_err_probe(dev, ret, "Unable to init regmap\n");

...

> +	st->gpio_regmap = devm_gpio_regmap_register(dev, &gpio_regmap);
> +	if (IS_ERR(st->gpio_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_regmap),
> +				     "Unable to init gpio-regmap\n");
> +	}

Ditto.

...

> +static struct ad7173_channel_config *ad7173_find_live_config
> +	(struct ad7173_state *st, struct ad7173_channel_config *cfg)

This is strange indentation.

Perhaps

static struct ad7173_channel_config *
ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)

?

...

> +	offset = offsetof(struct ad7173_channel_config, cfg_slot) +
> +		 sizeof(cfg->cfg_slot);

Isn't it a offsetofend() from stddef.h?

> +	cmp_size = sizeof(*cfg) - offset;

sizeof_field() from the above mentioned header?

...

> +	for (i = 0; i < st->num_channels; i++) {
> +		cfg_aux = &st->channels[i].cfg;
> +
> +		if (cfg_aux->live && !memcmp(&cfg->bipolar, &cfg_aux->bipolar,
> +					     cmp_size))

I would split this on logic operator, it will be easier to read.

> +			return cfg_aux;
> +	}

...

> +	free_cfg_slot = find_first_zero_bit(st->cfg_slots_status,
> +					    st->info->num_configs);
> +	if (free_cfg_slot == st->info->num_configs)
> +		free_cfg_slot = ad7173_free_config_slot_lru(st);
> +
> +	set_bit(free_cfg_slot, st->cfg_slots_status);
> +	cfg->cfg_slot = free_cfg_slot;

Looks like reinvention of IDA.

...

> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	unsigned int id;
> +	u8 buf[AD7173_RESET_LENGTH];
> +	int ret;

Reversed xmas tree order?

	struct ad7173_state *st = iio_priv(indio_dev);
	u8 buf[AD7173_RESET_LENGTH];
	unsigned int id;
	int ret;

...

> +	return vref / (MICRO/MILLI);

What does the denominator mean and why you can't simply use MILL?

...

> +			if (ch->cfg.bipolar)
> +				/* (1<<31) is UB for a 32bit channel */
> +				*val = (chan->scan_type.realbits == 32) ?
> +					INT_MIN :
> +					-(1 << (chan->scan_type.realbits - 1));

So, what's the issue to use BIT() which has no such issue with UB?

> +			else
> +				*val = 0;

...

> +		*val = st->info->sinc5_data_rates[reg] / (MICRO/MILLI);
> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO/MILLI);

Same Q about denominator.

...

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		freq = val * MILLI + val2 / MILLI;

> +

Unneeded blank line.

> +		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++) {
> +			if (freq >= st->info->sinc5_data_rates[i])
> +				break;
> +		}
> +
> +		cfg = &st->channels[chan->address].cfg;
> +		cfg->odr = i;
> +
> +		if (!cfg->live)
> +			break;
> +
> +		ret = ad_sd_read_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, &reg);
> +		if (ret)
> +			break;
> +		reg &= ~AD7173_FILTER_ODR0_MASK;
> +		reg |= FIELD_PREP(AD7173_FILTER_ODR0_MASK, i);
> +		ret = ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, reg);
> +		break;

...

> +static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);

> +	int i, ret = 0;

Use the 0 directly...

> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		if (test_bit(i, scan_mask))
> +			ret = ad7173_set_channel(&st->sd, i);
> +		else
> +			ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(i), 2, 0);
> +
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return ret;

...here.

> +}

> +	chan_arr = devm_kcalloc(dev, sizeof(*chan_arr), num_channels,
> +				GFP_KERNEL);

One line.

> +	if (!chan_arr)
> +		return -ENOMEM;

...

> +		if (fwnode_property_read_u32(child, "adi,reference-select", &ref_sel))
> +			ref_sel = AD7173_SETUP_REF_SEL_INT_REF;

if is redundant.

		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
		fwnode_property_read_u32(child, "adi,reference-select", &ref_sel);

-- 
With Best Regards,
Andy Shevchenko


