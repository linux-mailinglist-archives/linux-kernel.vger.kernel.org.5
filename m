Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02E6778927
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjHKIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHKIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:47:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA82738;
        Fri, 11 Aug 2023 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691743666; x=1723279666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mHF3X9OgaTLJrJbrPHGPVPH93vUmA3gTIi0Dz6FrL9Y=;
  b=SHwghIdqSrcHpKVyxa9A2XQDNWKUTsuJJ2UrW95rMIaxinybrhWCzMFK
   /QeS+HTYeUb7sCDDPsAqVwr5PkmJGKWI6YRjLVuUfgARVyxERkYnuDPeP
   YViBmrRICDaEHYJtZTfn2bNxRRF5i+5b8JD3b1IjdLv5fXF0rJFU9W1wQ
   7k4bC+C9QgpgpAQteP1FUPHm7oF46m0TzHR8w3Pv9Nch3tkmdsnVIM1QQ
   xwjvsMnf/GYKKz6YX6xhX4kM005Cx+5hSRw4jUxgBkgSyYrCjHfdiojGZ
   YEsHvW2pJM6xTwqjxdom+FU6keznpll3A4h3f4Tad46Zx49OQADbOZWnh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435526331"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="435526331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="726189849"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="726189849"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2023 01:47:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUNo0-00799n-2K;
        Fri, 11 Aug 2023 11:47:36 +0300
Date:   Fri, 11 Aug 2023 11:47:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Message-ID: <ZNX1qKmZQmWt2RXQ@smile.fi.intel.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
 <20230810093322.593259-2-mitrutzceclan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810093322.593259-2-mitrutzceclan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:33:17PM +0300, Dumitru Ceclan wrote:
> The AD717x family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.

...

> +	help
> +	  Say yes here to build support for Analog Devices AD717x ADC.

I believe checkpatch.pl expects at least 3 lines of help description.

One of them may tell the user what will be the module name, if chosen
to be built as a module.

...

> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

There is no user of the header. But missing bits.h, mod_devicetable.h,
property.h, and might be more.

So, revisit this block to see which ones are used and which one are missed,
and which are redundant.

> +#include <linux/sched.h>

Is this used? How?

> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/regulator/consumer.h>

Can you keep the above sorted?

...

> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Can you keep the above sorted?

+ Blank line

> +#include <linux/iio/adc/ad_sigma_delta.h>

...

> +#define AD717X_ID_MASK			0xfff0

GENMASK()

> +#define AD717X_ADC_MODE_MODE_MASK	0x70

> +#define AD717X_ADC_MODE_CLOCKSEL_MASK	0xc

You are using BIT(), and not GENMASK()...
All can be converted.

...

> +#define AD717X_SETUP_AREF_BUF		(0x3 << 10)
> +#define AD717X_SETUP_AIN_BUF		(0x3 << 8)
> +#define AD717X_SETUP_REF_SEL_MASK	0x30

Ditto for all.

...

> +#define AD717X_SETUP_REF_SEL_AVDD1_AVSS	0x30
> +#define AD717X_SETUP_REF_SEL_INT_REF	0x20
> +#define AD717X_SETUP_REF_SEL_EXT_REF2	0x10
> +#define AD717X_SETUP_REF_SEL_EXT_REF	0x00

Seems to me like plain decimals with shift should be used

#define AD717X_SETUP_REF_SEL_AVDD1_AVSS	(3...
#define AD717X_SETUP_REF_SEL_INT_REF	(2...
#define AD717X_SETUP_REF_SEL_EXT_REF2	(1...
#define AD717X_SETUP_REF_SEL_EXT_REF	(0 << 4)

...

> +#define AD717X_FILTER_ODR0_MASK		0x1f

GENMASK()

...

> +static const struct ad717x_device_info ad717x_device_info[] = {
> +	[ID_AD7172_2] = {

> +		.clock = 2000000,

> +	},
> +	[ID_AD7173_8] = {

> +		.clock = 2000000,

> +	},
> +	[ID_AD7175_2] = {

> +		.clock = 16000000,

> +	},
> +	[ID_AD7176_2] = {

> +		.clock = 16000000,

> +	},
> +};

HZ_PER_MHZ from units.h?

...

> +static int ad717x_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct ad717x_state *st = gpiochip_to_ad717x(chip);
> +	unsigned int mask;
> +	unsigned int value;
> +	int ret;
> +
> +	switch (offset) {
> +	case 0:
> +		mask = AD717X_GPIO_GP_DATA0;
> +		break;
> +	case 1:
> +		mask = AD717X_GPIO_GP_DATA1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = ad_sd_read_reg(&st->sd, AD717X_REG_GPIO, 2, &value);
> +	if (ret)
> +		return ret;
> +
> +	return (bool)(value & mask);

This is weird. You have int which you get from bool, wouldn't be better to use
!!(...) as other GPIO drivers do?

> +}

...

> +static void ad717x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +	struct ad717x_state *st = gpiochip_to_ad717x(chip);
> +	unsigned int mask, set_mask, clr_mask;
> +
> +	switch (offset) {
> +	case 0:
> +		mask = AD717X_GPIO_GP_DATA0;
> +		break;
> +	case 1:
> +		mask = AD717X_GPIO_GP_DATA1;
> +		break;
> +	case 2:
> +		mask = AD717X_GPIO_GP_DATA2;
> +		break;
> +	case 3:
> +		mask = AD717X_GPIO_GP_DATA3;
> +		break;
> +	default:
> +		return;
> +	}

> +	if (value) {
> +		set_mask = mask;
> +		clr_mask = 0;
> +	} else {
> +		set_mask = 0;
> +		clr_mask = mask;
> +	}
> +
> +	ad717x_gpio_update(st, set_mask, clr_mask);

It's too verbose, just

	if (value)
		ad717x_gpio_update(st, mask, 0);
	else
		ad717x_gpio_update(st, 0, mask);

Would save a half a dozen LoCs.

> +}

...

> +static int ad717x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct ad717x_state *st = gpiochip_to_ad717x(chip);
> +	unsigned int mask;
> +
> +	switch (offset) {
> +	case 0:
> +		mask = AD717X_GPIO_IP_EN0;
> +		break;
> +	case 1:
> +		mask = AD717X_GPIO_IP_EN1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	return ad717x_gpio_update(st, mask, 0);

Return directly from the switch case.

> +}

...

The GPIO methods are too verbose, I stopped looking into them here.
The main question, why gpio-regmap is not used for this?

...

> +static int ad717x_gpio_init(struct ad717x_state *st)
> +{

	struct device *dev = &st->sd.spi->dev;

makes code neater here and elsewhere.

> +	st->gpiochip.label = dev_name(&st->sd.spi->dev);
> +	st->gpiochip.base = -1;

> +	if (st->info->has_gp23)
> +		st->gpiochip.ngpio = 4;
> +	else
> +		st->gpiochip.ngpio = 2;

Instead of keeping a boolean flag in the info, why you not keep ngpio there
(0 implies no GPIO)?

> +	st->gpiochip.parent = &st->sd.spi->dev;
> +	st->gpiochip.can_sleep = true;
> +	st->gpiochip.direction_input = ad717x_gpio_direction_input;
> +	st->gpiochip.direction_output = ad717x_gpio_direction_output;
> +	st->gpiochip.get = ad717x_gpio_get;
> +	st->gpiochip.set = ad717x_gpio_set;
> +	st->gpiochip.free = ad717x_gpio_free;
> +	st->gpiochip.owner = THIS_MODULE;
> +
> +	return devm_gpiochip_add_data(&st->sd.spi->dev, &st->gpiochip, NULL);
> +}

...

> +static void ad717x_reset_usage_cnts(struct ad717x_state *st)
> +{
> +	int i;
> +
> +	for (i = 0; i < st->info->num_configs; i++)

> +		(st->config_cnts)[i] = 0;

What are the parentheses for?
Wouldn't this a NIH one of memsetXX()?

> +	st->config_usage_counter = 0;
> +}

...

> +	offset = offsetof(struct ad717x_channel_config, cfg_slot) +
> +		 sizeof(cfg->cfg_slot);
> +	cmp_size = sizeof(*cfg) - offset;

My gut's feeling this is some NIH one of macros from overflow.h.

...

> +	for (i = 0; i < st->num_channels; i++) {
> +		cfg_aux = &st->channels[i].cfg;
> +
> +		if (cfg_aux->live && !memcmp(((void *)cfg) + offset,
> +					    ((void *)cfg_aux) + offset, cmp_size))

My gosh! Explicit castings should be really rear. Can't you use proper
struct / array pointers?

> +			return cfg_aux;
> +	}

...

> +	int ret = 0;

How is this 0 used?

> +	if (!cfg->live) {

> +		live_cfg = ad717x_find_live_config(st, cfg);
> +		if (!live_cfg) {

Why not positive check?

> +			ret = ad717x_load_config(st, cfg);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			cfg->cfg_slot = live_cfg->cfg_slot;
> +		}
> +	}

> +	cfg->live = true;

Can be moved inside the conditional.

...

> +	ret = ad717x_config_channel(st, channel);
> +	if (ret < 0)

What is the meaning of > 0?
Same Q to other similar checks.

> +		return ret;

...

> +static int ad717x_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);
> +	unsigned int id;
> +	u8 *buf;
> +	int ret;
> +
> +	/* reset the serial interface */
> +	buf = kcalloc(8, sizeof(*buf), GFP_KERNEL);

Magic number!

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memset(buf, 0xff, 8);
> +	ret = spi_write(st->sd.spi, buf, 8);
> +	kfree(buf);
> +	if (ret < 0)
> +		return ret;

I agree with comments by Nuno on this.

> +	/* datasheet recommends a delay of at least 500us after reset */
> +	usleep_range(500, 1000);

	fsleep(500);

> +	ret = ad_sd_read_reg(&st->sd, AD717X_REG_ID, 2, &id);
> +	if (ret)
> +		return ret;
> +
> +	id &= AD717X_ID_MASK;
> +	if (id != st->info->id)
> +		dev_warn(&st->sd.spi->dev, "Unexpected device id: %x, expected: %x\n",
> +					    id, st->info->id);

Wrong indentation.

> +	mutex_init(&st->cfgs_lock);
> +	st->adc_mode |= AD717X_ADC_MODE_REF_EN | AD717X_ADC_MODE_SING_CYC;
> +	st->interface_mode = 0x0;
> +
> +	st->config_usage_counter = 0;
> +	st->config_cnts = devm_kzalloc(&indio_dev->dev,
> +				       st->info->num_configs * sizeof(u64),

No, let kernel do the right thing with this.

> +				       GFP_KERNEL);
> +	if (!st->config_cnts)
> +		return -ENOMEM;
> +
> +	/* All channels are enabled by default after a reset */
> +	ret = ad717x_disable_all(&st->sd);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

...

> +static int ad717x_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long info)
> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* disable channel after single conversion */

> +		ret = ad_sd_write_reg(&st->sd, AD717X_REG_CH(chan->address), 2,
> +				      0);

This is much better on a single line.

> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 250000000;
> +			*val2 = 800273203; /* (2**24 * 477) / 10 */

Use mathematical notations (TeX like)

	(2^24 * 477) / 10

> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> +			*val = 2500;
> +			if (chan->differential)
> +				*val2 = 23;
> +			else
> +				*val2 = 24;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP) {
> +			*val = -874379;
> +		} else {
> +			if (chan->differential)
> +				*val = -(1 << (chan->scan_type.realbits - 1));
> +			else
> +				*val = 0;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		reg = st->channels[chan->address].cfg.odr;
> +
> +		*val = st->info->sinc5_data_rates[reg] / MILLI;
> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * MILLI;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}

...

> +static int ad717x_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long info)
> +{

> +	int ret = 0;

You won't need this if...

> +	mutex_lock(&st->cfgs_lock);

...you switch to use guarded mutex (see cleanup.h).

Same applicable to many other functions.

> +	mutex_unlock(&st->cfgs_lock);
> +	return ret;
> +}

...

> +static int ad717x_debug(struct iio_dev *indio_dev, unsigned int reg,
> +			unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);

> +	u8 reg_size = 2;

Better to make it an else branch...

> +	if (reg == 0)
> +		reg_size = 1;
> +	else if (reg == AD717X_REG_CRC || reg == AD717X_REG_DATA ||
> +		 reg >= AD717X_REG_OFFSET(0))
> +		reg_size = 3;

	else
		reg_size = 2;

> +	if (readval)
> +		return ad_sd_read_reg(&st->sd, reg, reg_size, readval);
> +
> +	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
> +}

...

> +static int ad717x_of_parse_channel_config(struct iio_dev *indio_dev)

of --> fw

> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);
> +	struct ad717x_channel *channels_st_priv;
> +	struct fwnode_handle *child;
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *chan;

> +	unsigned int num_channels = 0;

How is this 0 being used?

> +	unsigned int ain[2], chan_index = 0;

> +	bool use_temp = false;

No assignment needed here, see below.

> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);

> +	if (device_property_read_bool(dev, "adi,temp-channel")) {

	use_temp = device_property_...
	if (use_temp) {

> +		if (!st->info->has_temp) {

> +			dev_err(indio_dev->dev.parent,
> +				"Current chip does not support temperature channel");
> +			return -EINVAL;

			return dev_err_probe(...);

> +		}
> +
> +		num_channels++;
> +		use_temp = true;
> +	}

> +	st->num_channels = num_channels;

I believe that it's already 0, so this can be moved...

> +	if (num_channels == 0)
> +		return 0;

...after this check.

> +	chan = devm_kcalloc(indio_dev->dev.parent, sizeof(*chan), num_channels,

Why not use dev?

> +			    GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	channels_st_priv = devm_kcalloc(indio_dev->dev.parent, num_channels,

Ditto.

> +					sizeof(*channels_st_priv), GFP_KERNEL);
> +	if (!channels_st_priv)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = num_channels;
> +	st->channels = channels_st_priv;
> +
> +	if (use_temp) {
> +		chan[chan_index] = ad717x_temp_iio_channel_template;
> +		channels_st_priv[chan_index].ain =
> +			AD717X_CH_ADDRESS(chan[chan_index].channel, chan[chan_index].channel2);
> +		channels_st_priv[chan_index].cfg.bipolar = false;
> +		channels_st_priv[chan_index].cfg.input_buf = true;
> +		chan_index++;
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		ret = fwnode_property_read_u32_array(child, "diff-channels", ain, 2);

ARRAY_SIZE() ?

> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		if (ain[0] >= st->info->num_inputs ||
> +		    ain[1] >= st->info->num_inputs) {
> +			dev_err(indio_dev->dev.parent,
> +				"Input pin number out of range for pair (%d %d).", ain[0], ain[1]);
> +			fwnode_handle_put(child);
> +			return -EINVAL;

			return dev_err_probe(...);

> +		}
> +
> +		chan[chan_index] = ad717x_channel_template;
> +		chan[chan_index].address = chan_index;
> +		chan[chan_index].scan_index = chan_index;
> +		chan[chan_index].channel = ain[0];
> +		chan[chan_index].channel2 = ain[1];

> +		channels_st_priv[chan_index].ain =
> +			AD717X_CH_ADDRESS(ain[0], ain[1]);

Why not one line here?

> +		channels_st_priv[chan_index].chan_reg = chan_index;
> +		channels_st_priv[chan_index].cfg.input_buf = true;
> +		channels_st_priv[chan_index].cfg.odr = 0;
> +
> +		chan[chan_index].differential = fwnode_property_read_bool(child, "adi,bipolar");
> +		if (chan[chan_index].differential) {
> +			chan[chan_index].info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
> +			channels_st_priv[chan_index].cfg.bipolar = true;
> +		}
> +
> +		chan_index++;
> +	}
> +
> +	return 0;
> +}

...

> +	if (!spi->irq) {
> +		dev_err(&spi->dev, "No IRQ specified\n");
> +		return -ENODEV;

		return dev_err_probe(...);

> +	}

...

> +static const struct spi_device_id ad717x_id_table[] = {
> +	{ "ad7172-2", },
> +	{ "ad7173-8", },
> +	{ "ad7175-2", },
> +	{ "ad7176-2", },
> +	{}

Missing driver_data here.

> +};

-- 
With Best Regards,
Andy Shevchenko


