Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490B4811689
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442032AbjLMP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjLMOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:55:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9A99;
        Wed, 13 Dec 2023 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702479352; x=1734015352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8Ovprx/pmdQI7BPD8UN/Y5D5W355ODMK42OdQ/VfiQ=;
  b=ldx6CVWcOsmIUlGACUskH4JanJUyKB+kjidy+JLYuX5bwOIr6IfyUKr+
   wrgGosmWYlK3FYVo7vBMl1teV1pxNG+m8wObH3fWu5B7/PQii59otP/Gz
   xoy69MJ1YvAEBAyl1kg72Yv6UQhXolE42nBIejVq3XvA2gQyMo2Mk2OpZ
   2n9qiEK19GK1lpC08s5nf9VBrCeEOHuR9BD3y3yT3UFnulmMSt797DCEf
   4QXMTbUljx0YQJzvUz2iExPxRX14nCZjr4yPnomFmPDoRFTsq6ZIoNy6V
   GcW51lOKeEDgaZOTOOMOnI71TL5OL+cHakzXmchlRHdfDkhCcj2Fe0gok
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="398816716"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="398816716"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723676120"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="723676120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:55:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDQeF-00000005YJi-2rd8;
        Wed, 13 Dec 2023 16:55:43 +0200
Date:   Wed, 13 Dec 2023 16:55:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Okan Sahin <okan.sahin@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZXnF72wJCAeYWA8X@smile.fi.intel.com>
References: <20231213094722.31547-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.27993507-256d-4b05-88df-c8643e7f1a68@emailsignatures365.codetwo.com>
 <20231213094722.31547-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213094722.31547-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:47:22AM +0100, Mike Looijmans wrote:
> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.

...

> +config TI_ADS1298
> +	tristate "Texas Instruments ADS1298"
> +	depends on SPI
> +	select IIO_BUFFER

> +	default y

Huh?!

> +	help
> +	  If you say yes here you get support for Texas Instruments ADS1298
> +	  medical ADC chips
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads1298.

...

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>

> +#include <linux/kernel.h>

Is it used as a proxy? (At least for array_size.h)
Please use real headers in such case.

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>

> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

This is interesting grouping, but okay, I understand the point.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>

...

> +#define ADS1298_CLK_RATE	2048000

Units? _HZ ?

...

> +/* Outputs status word and 8 samples of 24 bits each, plus the command byte */

/* Outputs status word and 8 24-bit samples, plus the command byte */

a bit shorter.

> +#define ADS1298_SPI_RDATA_BUFFER_SIZE	((ADS1298_MAX_CHANNELS + 1) * 3 + 1)

...

> +#define ADS1298_CHAN(index)					\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.address = 3 * index + 4,				\

Hmm... does this 3 have a distinct definition?

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\

Can be written as below

	.info_mask_separate =					\
		BIT(IIO_CHAN_INFO_RAW) |			\
		BIT(IIO_CHAN_INFO_SCALE),			\

> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \

	.info_mask_shared_by_all =				\
		BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\

> +	.scan_index = index,					\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 24,					\
> +		.storagebits = 32,				\
> +		.endianness = IIO_BE,				\
> +	},							\
> +}

...

> +static int ads1298_write_cmd(struct ads1298_private *priv, u8 command)
> +{
> +	struct spi_transfer cmd_xfer = {
> +		.tx_buf = priv->cmd_buffer,
> +		.rx_buf = priv->cmd_buffer,
> +		.len = 1,

		sizeof(command) ?

> +		.speed_hz = ADS1298_SPI_BUS_SPEED_SLOW,

> +		.delay.value = 2,
> +		.delay.unit = SPI_DELAY_UNIT_USECS,

		.delay = {
			.value = ...
			.unit = ...
		},

> +	};

> +	priv->cmd_buffer[0] = command;
> +
> +	return spi_sync_transfer(priv->spi, &cmd_xfer, 1);
> +}

...

> +	/* Cannot take longer than 40ms (250Hz) */
> +	ret = wait_for_completion_timeout(&priv->completion,
> +					  msecs_to_jiffies(50));

One line?

> +	if (!ret)
> +		return -ETIMEDOUT;

...

> +	if (cfg & ADS1298_MASK_CONFIG1_HR)
> +		rate >>= 6; /* HR mode */
> +	else
> +		rate >>= 7; /* LP mode */

Are those magic numbers defined?

...

> +	factor = (rate >> 6) / val;

Is it the same 6 semantically as above?

...

> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}
> +
> +

One blank line is enough.

> +		*val = sign_extend32(get_unaligned_be24(
> +					priv->rx_buffer + chan->address), 23);

Strange indentation.

		*val = sign_extend32(get_unaligned_be24(priv->rx_buffer + chan->address),
				     23);

...

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = regmap_read(priv->regmap, ADS1298_REG_CONFIG1, val);
> +		if (!ret) {

Why not using standard pattern?

		if (ret)
			return ret;

(see below)

> +			ret = IIO_VAL_INT;
> +			*val = (16 << (*val & ADS1298_MASK_CONFIG1_DR));

Outer parentheses are redundant.

> +		}
> +		break;

		return IIO_VAL_INT;


> +	default:
> +		ret = -EINVAL;
> +		break;

return directly.

> +	}

> +	return ret;

It will gone.

...

> +static int ads1298_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ads1298_private *priv = iio_priv(indio_dev);

> +	int ret;

No need, just return directly.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ads1298_set_samp_freq(priv, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}

...

> +static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			      unsigned int writeval, unsigned int *readval)
> +{
> +	struct ads1298_private *priv = iio_priv(indio_dev);

> +	if (!readval)

Perhaps positive conditional?

	if (readval)
		return readval;
	return writeval;

> +		return regmap_write(priv->regmap, reg, writeval);
> +
> +	return regmap_read(priv->regmap, reg, readval);
> +}

...

> +	/* Power down channels that aren't in use */
> +	for (i = 0; i < ADS1298_MAX_CHANNELS; i++) {
> +		regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
> +				   ADS1298_MASK_CH_PD,
> +				   test_bit(i, scan_mask) ?
> +							0 : ADS1298_MASK_CH_PD);

Broken indentation.

> +	}

...

> +static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
> +{
> +	unsigned long flags;
> +
> +	/* Notify we're no longer waiting for the SPI transfer to complete */
> +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
> +	priv->rdata_xfer_busy = false;
> +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);

Perhaps switch to use guard()?
(And scoped_guard() where it makes sense.)

> +}

> +		/* Transfer 24-bit value into 32-bit array */
> +		memcpy(bounce + 1, data, 3);

Hmm... Wouldn't get_unaligned_..24() work here better?

> +		bounce += 4;

If so, you can iterate over u32 members directly without this += 4.

...

> +static const char *ads1298_family_name(unsigned int id)
> +{
> +	switch (id & 0xe0) {

GENMASK() ?

> +	case 0x80:
> +		return "ADS129x";
> +	case 0xc0:
> +		return "ADS129xR";

Can we have these all magics be defined?

> +	default:
> +		return "(unknown)";
> +	}
> +}

...

> +	if ((val & 0x18) == 0x10) {

Ditto.

> +		dev_info(dev, "Found %s, %d channels\n",
> +			 ads1298_family_name(val),
> +			 4 + 2 * (val & 0x07));

Ditto for 0x07.

> +	} else {
> +		dev_err(dev, "Unknown ID: 0x%x\n", val);
> +		return -ENODEV;
> +	}

...

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (indio_dev == NULL)

We do !indio_dev in this case.

> +		return -ENOMEM;

...

> +		ret = devm_add_action_or_reset(dev, ads1298_reg_disable,
> +					       priv->reg_vref);

One line?


> +		if (ret)
> +			return ret;

...

> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Failed to get clk\n");

Ditto.

...

> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable avdd regulator\n");

Ditto.

...

> +	ret = devm_add_action_or_reset(dev, ads1298_reg_disable,
> +				       priv->reg_avdd);

Ditto.

...

> +	priv->regmap = devm_regmap_init(dev, NULL, priv,
> +					&ads1298_regmap_config);

Ditto.

...

> +	/* Avoid giving all the same name, iio scope doesn't handle that well */

IIO

> +	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "%s@%s",
> +					 spi_get_device_id(spi)->name,
> +					 dev_name(dev));

No error check?

> +	if (reset_gpio) {
> +		udelay(1); /* Minimum pulse width is 2 clocks at 2MHz */

How do you know it's 2MHz? Is it always the same on all platforms / setups?

> +		gpiod_set_value(reset_gpio, 0);
> +	} else {
> +		ret = ads1298_write_cmd(priv, ADS1298_CMD_RESET);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "RESET failed\n");
> +	}
> +	/* Wait 18 clock cycles for reset command to complete */

Ditto.

> +	udelay(9);

...

> +	ret = devm_request_irq(&spi->dev, spi->irq, &ads1298_interrupt,

&spi->dev is different to dev?

> +			       IRQF_TRIGGER_FALLING, indio_dev->name,
> +			       indio_dev);

...

> +	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
> +					  &ads1298_setup_ops);

Ditto.

...

> +static const struct spi_device_id ads1298_id[] = {
> +	{ "ads1298",  },

Inner comma is not needed.

> +	{ }
> +};

...

> +static const struct of_device_id ads1298_of_table[] = {
> +	{ .compatible = "ti,ads1298" },
> +	{ },

Drop the comma in terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko


