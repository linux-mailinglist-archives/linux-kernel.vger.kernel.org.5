Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF078B6DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjH1R6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjH1R6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE778106;
        Mon, 28 Aug 2023 10:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5706C64450;
        Mon, 28 Aug 2023 17:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32420C433C8;
        Mon, 28 Aug 2023 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693245488;
        bh=cfdMH0xaO7a7YVGrzqatdGwfxoE8/4cSoZ2/JR6PuKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNaDNGPsPDb3Co1+iDrjlbzo7BZ3CnTbyKcxcxT25OEhkRhBIotKkqXsCzKKmd84Q
         kc0QGjkX1nXPEcvoN1of9HNOAOEngO49c636bch8nZAUD1rw7KpyDHuIPCnQisKb4f
         C0ZlQLbg7MXaWTSa12CEtwna4vE93IU4U81Ve82N7iVyTTWAOEKo/tj5CGSvNMHvdy
         g9W2fjHQm90SF+ZRTFjJrSiqFXHI8nzz5pSjKTfe2Vdf5D17dZxvLyU9xPC8WPKVAA
         K5FkPa7A2gHM2IW3xpwwtYadTgb/x3f8sucfEtsMem0mFA1+Qxt8tEjz8u2R2NP0Bo
         1NRp5a3S9A1Gg==
Date:   Mon, 28 Aug 2023 18:58:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Message-ID: <20230828185822.21bb3327@jic23-huawei>
In-Reply-To: <20230810093322.593259-2-mitrutzceclan@gmail.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
        <20230810093322.593259-2-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 12:33:17 +0300
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The AD717x family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Hi Dumitru

Looks like you've have a lot of good review already, so I've only taken
a very quick look at this version.  A few comments inline.

Jonathan


> ---
>  drivers/iio/adc/Kconfig  |   7 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad717x.c | 999 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1007 insertions(+)
>  create mode 100644 drivers/iio/adc/ad717x.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dc14bde31ac1..294a48b05769 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -54,6 +54,13 @@ config AD7124
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7124.
>  
> +config AD717X

No wild card please. Pick a supported device to name it after.
This applies to all naming of variable, function names etc as well as the Kconfig
naming.


> +	tristate "Analog Devices AD717x driver"
> +	depends on SPI_MASTER
> +	select AD_SIGMA_DELTA
> +	help
> +	  Say yes here to build support for Analog Devices AD717x ADC.
> +
>  config AD7192
>  	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
>  	depends on SPI

> diff --git a/drivers/iio/adc/ad717x.c b/drivers/iio/adc/ad717x.c
> new file mode 100644
> index 000000000000..d14a3e0e2d93
> --- /dev/null
> +++ b/drivers/iio/adc/ad717x.c
> @@ -0,0 +1,999 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
> + * Copyright (C) 2023 Analog Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>

Check if all these headers are needed. I suspect not.

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +
> +#define AD717X_REG_COMMS		0x00
> +#define AD717X_REG_ADC_MODE		0x01
> +#define AD717X_REG_INTERFACE_MODE	0x02
> +#define AD717X_REG_CRC			0x03
> +#define AD717X_REG_DATA			0x04
> +#define AD717X_REG_GPIO			0x06
> +#define AD717X_REG_ID			0x07
> +#define AD717X_REG_CH(x)		(0x10 + (x))
> +#define AD717X_REG_SETUP(x)		(0x20 + (x))
> +#define AD717X_REG_FILTER(x)		(0x28 + (x))
> +#define AD717X_REG_OFFSET(x)		(0x30 + (x))
> +#define AD717X_REG_GAIN(x)		(0x38 + (x))
> +
> +#define AD717X_CH_ENABLE		BIT(15)
> +#define AD717X_CH_SETUP_SEL(x)		((x) << 12)
> +#define AD717X_CH_SETUP_AINPOS(x)	((x) << 5)
> +#define AD717X_CH_SETUP_AINNEG(x)	(x)
> +
> +#define AD717X_CH_ADDRESS(pos, neg) \
> +	(AD717X_CH_SETUP_AINPOS(pos) | AD717X_CH_SETUP_AINNEG(neg))
> +
> +#define AD7172_ID			0x00d0
> +#define AD7173_ID			0x30d0
> +#define AD7175_ID			0x0cd0
> +#define AD7176_ID			0x0c90
> +#define AD717X_ID_MASK			0xfff0
> +
> +#define AD717X_ADC_MODE_REF_EN		BIT(15)
> +#define AD717X_ADC_MODE_SING_CYC	BIT(13)
> +#define AD717X_ADC_MODE_MODE_MASK	0x70
> +#define AD717X_ADC_MODE_MODE(x)		((x) << 4)

Use FIELD_PREP along with the MODE_MASK wherever this is currently
called. Do the same for other similar cases.  Normally a field
should be defined just using a mask as that includes
any necessary shift.  FIELD_PREP() and FIELD_GET() do the
magic to extract that shift.

> +#define AD717X_ADC_MODE_CLOCKSEL_MASK	0xc
> +#define AD717X_ADC_MODE_CLOCKSEL(x)	((x) << 2)

> +
> +struct ad717x_state {
> +	const struct ad717x_device_info *info;
> +	struct ad_sigma_delta sd;
> +	struct ad717x_channel *channels;
> +	struct regulator *reg;
> +	unsigned int adc_mode;
> +	unsigned int interface_mode;
> +	unsigned int num_channels;
> +	struct mutex cfgs_lock; /* lock for configs access */

What config?

> +	unsigned long cfg_slots_status; /* slots usage status bitmap*/
> +	unsigned long long config_usage_counter;
> +	unsigned long long *config_cnts;
> +
> +#ifdef CONFIG_GPIOLIB
> +	struct gpio_chip gpiochip;
> +	unsigned int gpio_reg;
> +	unsigned int gpio_23_mask;
> +#endif
> +};

> +
> +static int ad717x_gpio_init(struct ad717x_state *st)

Even though it's simple, include the linux-gpio list an maintainers
given the presence of a gpio chip in here.

> +{
> +	st->gpiochip.label = dev_name(&st->sd.spi->dev);
> +	st->gpiochip.base = -1;
> +	if (st->info->has_gp23)
> +		st->gpiochip.ngpio = 4;
> +	else
> +		st->gpiochip.ngpio = 2;
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
> +
> +#else
> +
> +static int ad717x_gpio_init(struct ad717x_state *st) { return 0 };
> +static void ad717x_gpio_cleanup(struct ad717x_state *st) {};
> +
> +#endif

...

> +
> +static int ad717x_load_config(struct ad717x_state *st,
> +			      struct ad717x_channel_config *cfg)
> +{
> +	unsigned int config;
> +	int free_cfg_slot, ret;
> +
> +	free_cfg_slot = find_first_zero_bit(&st->cfg_slots_status,
> +					    st->info->num_configs);
> +	if (free_cfg_slot == st->info->num_configs)
> +		free_cfg_slot = ad717x_free_config_slot_lru(st);
> +
> +	assign_bit(free_cfg_slot, &st->cfg_slots_status, 1);
> +	cfg->cfg_slot = free_cfg_slot;
> +
> +	config = AD717X_SETUP_REF_SEL_INT_REF;
> +
> +	if (cfg->bipolar)
> +		config |= AD717X_SETUP_BIPOLAR;
> +
> +	if (cfg->input_buf)
> +		config |= AD717X_SETUP_AIN_BUF;
> +
> +	ret = ad_sd_write_reg(&st->sd, AD717X_REG_SETUP(free_cfg_slot), 2, config);
> +	if (ret)
> +		return ret;
> +
> +	config = AD717X_FILTER_ODR0_MASK & cfg->odr;
> +	return ad_sd_write_reg(&st->sd, AD717X_REG_FILTER(free_cfg_slot), 2, config);

Putting value inline is probably more readable here.

> +}


> +static struct ad_sigma_delta_info ad717x_sigma_delta_info = {
> +	.set_channel = ad717x_set_channel,
> +	.append_status = ad717x_append_status,
> +	.disable_all = ad717x_disable_all,
> +	.set_mode = ad717x_set_mode,
> +	.has_registers = true,
> +	.addr_shift = 0,
> +	.read_mask = BIT(6),
> +	.status_ch_mask = GENMASK(3, 0),
> +	.data_reg = AD717X_REG_DATA,
> +	.irq_flags = IRQF_TRIGGER_FALLING
> +};
> +
> +static int ad717x_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);
> +	unsigned int id;
> +	u8 *buf;
> +	int ret;
> +
> +	/* reset the serial interface */
> +	buf = kcalloc(8, sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memset(buf, 0xff, 8);
> +	ret = spi_write(st->sd.spi, buf, 8);

spi_write_then_read() as mentioned in other thread.

> +	kfree(buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* datasheet recommends a delay of at least 500us after reset */
> +	usleep_range(500, 1000);
> +
> +	ret = ad_sd_read_reg(&st->sd, AD717X_REG_ID, 2, &id);
> +	if (ret)
> +		return ret;
> +
> +	id &= AD717X_ID_MASK;
> +	if (id != st->info->id)
> +		dev_warn(&st->sd.spi->dev, "Unexpected device id: %x, expected: %x\n",
> +					    id, st->info->id);
> +
> +	mutex_init(&st->cfgs_lock);
> +	st->adc_mode |= AD717X_ADC_MODE_REF_EN | AD717X_ADC_MODE_SING_CYC;
> +	st->interface_mode = 0x0;
> +
> +	st->config_usage_counter = 0;
> +	st->config_cnts = devm_kzalloc(&indio_dev->dev,
> +				       st->info->num_configs * sizeof(u64),
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
> +
> +static int ad717x_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long info)

Prefer variables to align with the one on the first line.

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
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 250000000;
> +			*val2 = 800273203; /* (2**24 * 477) / 10 */
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
> +
> +static int ad717x_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long info)
> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);
> +	struct ad717x_channel_config *cfg;
> +	unsigned int freq, i, reg;
> +	int ret = 0;
> +
> +	mutex_lock(&st->cfgs_lock);

What is this lock protecting?  I'd kind of expect it to be held in more places
so perhaps I'm misunderstanding the intended scope.

> +	if (iio_buffer_enabled(indio_dev)) {
> +		mutex_unlock(&st->cfgs_lock);
> +		return -EBUSY;

Someone else pointed this out, but this is probably racey as it isn't using the IIO core
locks that protect against a state change, so use iio_device_claim_direct() instead.
Do keep the local locking though as that is protecting different data.

> +	}
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		freq = val * MILLI + val2 / MILLI;
> +
> +		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++) {
> +			if (freq >= st->info->sinc5_data_rates[i])
> +				break;
> +		}
> +
> +		cfg = &st->channels[chan->address].cfg;
> +		cfg->odr = i;
> +
> +		if (cfg->live) {
> +			ret = ad_sd_read_reg(&st->sd, AD717X_REG_FILTER(cfg->cfg_slot), 2, &reg);
> +			if (ret)
> +				break;
> +			reg &= ~AD717X_FILTER_ODR0_MASK;
> +			reg |= i;
> +			ret = ad_sd_write_reg(&st->sd, AD717X_REG_FILTER(cfg->cfg_slot), 2, reg);
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&st->cfgs_lock);
> +	return ret;
> +}
> +
> +static int ad717x_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, long mask)
> +{
> +	return IIO_VAL_INT_PLUS_MICRO;

Fairly sure that's the default, so you don't need this function to be provided.

> +}
> +
> +static int ad717x_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);
> +	bool bit_set;
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&st->cfgs_lock);
> +	for (i = 0; i < st->num_channels; i++) {
> +		bit_set = test_bit(i, scan_mask);
> +		if (bit_set)
> +			ret = ad717x_set_channel(&st->sd, i);
> +		else
> +			ret = ad_sd_write_reg(&st->sd, AD717X_REG_CH(i), 2, 0);
> +
> +		if (ret < 0) {
> +			mutex_unlock(&st->cfgs_lock);
> +			return ret;

Use a goto or break to share the single unlock location.
Or you could use the new scope based locking stuff if you are feeling adventurous.


> +		}
> +	}
> +
> +	mutex_unlock(&st->cfgs_lock);
> +
> +	return 0;
> +}
> +

...

> +
> +static const struct iio_chan_spec ad717x_channel_template = {
> +	.type = IIO_VOLTAGE,
> +	.indexed = 1,
> +	.channel = 0,
> +	.address = AD717X_CH_ADDRESS(0, 0),
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_index = 0,
> +	.scan_type = {
> +		.sign = 'u',
> +		.realbits = 24,
> +		.storagebits = 32,
> +		.shift = 0,

As below.

> +		.endianness = IIO_BE,
> +	},
> +};
> +
> +static const struct iio_chan_spec ad717x_temp_iio_channel_template = {
> +	.type = IIO_TEMP,
> +	.indexed = 1,
> +	.channel = 17,

Why set random values in here?  Fine to leave the stuff that will always be written defaulting to 0.

> +	.channel2 = 18,
> +	.address = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_index = 0,
> +	.scan_type = {
> +		.sign = 'u',
> +		.realbits = 24,
> +		.storagebits = 32,
> +		.shift = 0,
Don't bother defining a shift of 0, that's considered the obvious default (and is what c will
set this to anyway).
> +		.endianness = IIO_BE,
> +	},
> +};
> +
> +static int ad717x_of_parse_channel_config(struct iio_dev *indio_dev)
> +{
> +	struct ad717x_state *st = iio_priv(indio_dev);
> +	struct ad717x_channel *channels_st_priv;
> +	struct fwnode_handle *child;
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels = 0;

Always set so don't init here.

> +	unsigned int ain[2], chan_index = 0;
> +	bool use_temp = false;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +
> +	if (device_property_read_bool(dev, "adi,temp-channel")) {
> +		if (!st->info->has_temp) {
> +			dev_err(indio_dev->dev.parent,
> +				"Current chip does not support temperature channel");
> +			return -EINVAL;
> +		}
> +
> +		num_channels++;
> +		use_temp = true;
I would make this..
	use_temp = device_property_...
	if (use_temp) {
		....

	}

> +	}
> +
> +	st->num_channels = num_channels;
> +
> +	if (num_channels == 0)
> +		return 0;
Do this 2 lines up, before setting st->num_channels.

Though I'm not clear why st needs a copy of that anyway as it's in the iio_device structure.

> +
> +	chan = devm_kcalloc(indio_dev->dev.parent, sizeof(*chan), num_channels,
> +			    GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	channels_st_priv = devm_kcalloc(indio_dev->dev.parent, num_channels,
> +					sizeof(*channels_st_priv), GFP_KERNEL);

Use local dev

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
> +		}
> +
> +		chan[chan_index] = ad717x_channel_template;
> +		chan[chan_index].address = chan_index;
> +		chan[chan_index].scan_index = chan_index;
> +		chan[chan_index].channel = ain[0];
> +		chan[chan_index].channel2 = ain[1];
> +
> +		channels_st_priv[chan_index].ain =
> +			AD717X_CH_ADDRESS(ain[0], ain[1]);
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
> +
> +static int ad717x_probe(struct spi_device *spi)
> +{
> +	struct ad717x_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!spi->irq) {
> +		dev_err(&spi->dev, "No IRQ specified\n");

It's rare a device can't be used at all without an IRQ.
Is that the case here, or is it just that the driver currently assumes
one is present?

> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->info = device_get_match_data(&spi->dev);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad717x_info;
> +
> +	ad717x_sigma_delta_info.num_slots = st->info->num_configs;
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad717x_sigma_delta_info);
> +	if (ret < 0)
> +		return ret;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	ret = ad717x_of_parse_channel_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad717x_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return ad717x_gpio_init(st);
> +}
> +
> +static const struct of_device_id ad717x_of_match[] = {
> +	{ .compatible = "adi,ad7172-2",
> +	  .data = &ad717x_device_info[ID_AD7172_2] },
> +	{ .compatible = "adi,ad7173-8",
> +	  .data = &ad717x_device_info[ID_AD7173_8] },
> +	{ .compatible = "adi,ad7175-2",
> +	  .data = &ad717x_device_info[ID_AD7175_2] },
> +	{ .compatible = "adi,ad7176-2",
> +	  .data = &ad717x_device_info[ID_AD7176_2] },
> +	{}
> +}
> +MODULE_DEVICE_TABLE(of, ad717x_of_match);
> +
> +static const struct spi_device_id ad717x_id_table[] = {
> +	{ "ad7172-2", },
> +	{ "ad7173-8", },
> +	{ "ad7175-2", },
> +	{ "ad7176-2", },

Add the info[] pointers here as well. If you get another
firmware type it may not match against the of_device_id table
entries.

As noted by others we have an spi function to grab the data from
which ever place it can be found.
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad717x_id_table);

