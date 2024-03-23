Return-Path: <linux-kernel+bounces-112460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD332887A1F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245581F21802
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C459141;
	Sat, 23 Mar 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKThrdjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB352E410;
	Sat, 23 Mar 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221155; cv=none; b=pwAM51mggZqqYt5tSv/ifLXOuoZmgN1intdp4XlcxWtdtcjyGBDmZtGi3BFcrdtXf/OjSRdAHAL8bnV8WUfZKgu7fj8O9Z4zHytO0rkV5Y9IXZVcSbEHfFi8n/LqGoZrxoFxbxgLhSgLLlDUcrCaoYG+PAdkUrJp/FxG2lUpPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221155; c=relaxed/simple;
	bh=GRSwfmgFTok5Pc4Yw4GjhfG1CwvygHNkjpiogDVt0uM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AibN1K/sVWx8jAWSoLLLeRH/21f/y7PL98JVfsUOrIMAmNT4PAkHMQjnT3z+XuZcAXeHZiVFID+tBvFK/yV7DMhwB83F6y3p4nqSCBhri09YK02QYGWyUaS8QujPVvKNhObQ5XNCI9bNMJJce+hbVVS74PjJSKvK300bH0RpnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKThrdjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D723C433F1;
	Sat, 23 Mar 2024 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711221154;
	bh=GRSwfmgFTok5Pc4Yw4GjhfG1CwvygHNkjpiogDVt0uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OKThrdjJcMFCBtTSdZ+Q4/VofxNHbc9c/9gHc17pDq31DWN1Zt6FKSf1+nSgOvLY8
	 EKF2R5iZh8a0cnx6rmW9l6AhQXam+h5GWOVBoS8NnCXbw9Avgm3T9/9qGI05Wjxpp8
	 0M+HWmdE69sHxOAS3RZHFYRrmlu07mic0VZrrCrTPTLXyXe6H0YIVBU3LIB7Ksr7x7
	 VSvILnp3js9Uh8w4v9SNYclGmZmh8k54amW79/w85Fd9sHRlqzzwbMA/t8dX+DUOxD
	 /V7J+vKN0/mxqDtmCh3gtg4xdt2fni2Ax2i+qPX7PmfSKv1QCralQTCrfJXbRnrgZu
	 tqA8xGidr9BAQ==
Date: Sat, 23 Mar 2024 19:12:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add support for AD4000
Message-ID: <20240323191220.4333e372@jic23-huawei>
In-Reply-To: <15a70e55d7b6f0a97c4042bdaa41c2b672eb4f2f.1711131830.git.marcelo.schmitt@analog.com>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
	<15a70e55d7b6f0a97c4042bdaa41c2b672eb4f2f.1711131830.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 19:05:34 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for AD4000 series of high accuracy, high speed, low power,
> successive aproximation register (SAR) ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Pasting relevant comment from cover letter here to aid reviewers.
> 
> Differently from AD7944, AD4000 devices have a configuration register to
> toggle some features. For instance, turbo mode is set through configuration
> register rather than an external pin. This simplifies hardware connections,
> but then requires software interface. So, additional ABI being proposed 
> in sysfs-bus-iio-adc-ad4000. The one I'm most in doubt about is 
> span_compression_en which affects the in_voltageY_scale attribute.
> That might be instead supported by providing _scale_available and allowing write
> to _scale.

Yes. That's what I suggested inline before reading this properly. Much
prefer that as standard tooling will know how to use it.


Various comments inline. In particularly look at the spi helpers.
It's unusual to see a driver do so much manual handling of transfers.

Jonathan

> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad4000      |  36 +
>  MAINTAINERS                                   |   2 +
>  drivers/iio/adc/Kconfig                       |  12 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ad4000.c                      | 666 ++++++++++++++++++
>  5 files changed, 717 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
>  create mode 100644 drivers/iio/adc/ad4000.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
> new file mode 100644
> index 000000000000..98fb7539ad6d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
> @@ -0,0 +1,36 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/turbo_en
> +KernelVersion:	6.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable/disable turbo mode allowing
> +		slower SPI clock rates (at a minimum SCK rate of 75 MHz) to
> +		achieve the maximum throughput of 2 MSPS.

When would we turn this on or off from userspace?  From this brief description
it sounds like either we are trying to run very fast and the SPI bus can't clock
quick enough for the non turbo mode.  In which case detect that we need it
and then turn it on.

Right now I have no idea why I'd ever turn this off.  Who doesn't want to
press the turbo button?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/span_compression_en
> +KernelVersion:	6.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable/disable the input span
> +		compression feature that reduces the ADC input range by 10% from
> +		the top and bottom of the range while still accessing all
> +		available ADC codes. Enabling span compression causes a
> +		decrease in ADC scale which is reflected in the channel
> +		in_voltageY_scale attribute.
Can you not control it via in_voltageY_scale then?
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/status_bits_en
> +KernelVersion:	6.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to make the chip append a 6-bit status
> +		word at the end of conversion results. The 6 status bits contain
> +		the configuration register fields for OV clamp flag, span
> +		compression, high-z mode, and turbo mode.

Why would I want this? Which of these isn't something I control?
This sounds like a debug feature we shouldn't enable.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/high_impedance_en
> +KernelVersion:	6.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to enable/disable high impedance mode
> +		(high-z) which reduces nonlinear charge kickback to the ADC
> +		input.

For this one, do we have precendence in other drivers?  I'm find with a control
just not sure if this the write ABI to use.


> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index b3c434722364..f535d617ae89 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
> +obj-$(CONFIG_AD4000) += ad4000.o
>  obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) += ad7091r5.o
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> new file mode 100644
> index 000000000000..f77104755979
> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c
> @@ -0,0 +1,666 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD4000 SPI ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +#include <asm/unaligned.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

Why?  Probably want mod_devicetable.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>

You aren't providing a trigger so shouldn't need this one I think.

> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define AD400X_READ_COMMAND	0x54
> +#define AD400X_WRITE_COMMAND	0x14
> +
> +#define AD4000_CONFIG_REG_MSK	0xFF
> +
> +/* AD4000 Configuration Register programmable bits */
> +#define AD4000_STATUS		BIT(4) /* Status bits output */
> +#define AD4000_SPAN_COMP	BIT(3) /* Input span compression  */
> +#define AD4000_HIGHZ		BIT(2) /* High impedance mode  */
> +#define AD4000_TURBO		BIT(1) /* Turbo mode */
> +
> +#define AD4000_16BIT_MSK	GENMASK(31, 16)
> +#define AD4000_18BIT_MSK	GENMASK(31, 14)
> +#define AD4000_20BIT_MSK	GENMASK(31, 12)
> +
> +#define AD4000_CHANNEL(_sign, _real_bits)				\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				      BIT(IIO_CHAN_INFO_SCALE),		\
> +		.scan_type = {						\
> +			.sign = _sign,					\
> +			.realbits = _real_bits,				\
> +			.storagebits = 32,				\

Why store a 16 bit value in 32 bits?
Obviously will make code more complex to handling it differently but
the memory saving could be significant if the buffer is large.

> +			.endianness = IIO_BE,				\
> +		},							\
> +	}								\
> +

> +
> +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> +{
> +	struct spi_transfer t = {
> +		.tx_buf	= st->data.d8,
> +		.len = 2,
> +	};
> +	struct spi_message m;
> +
> +	put_unaligned_be16(AD400X_WRITE_COMMAND << BITS_PER_BYTE | val, st->data.d8);
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);

Why can't use init_with_transfers?  Though maybe spi_write() is enough here and in
other cases. + look at spi_write_then_read() and see if that's appropriate for
others.

> +
> +	return spi_sync(st->spi, &m);
> +}
> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +	struct spi_transfer t = {0};
> +	struct spi_message m;
> +	int ret;
> +
> +	st->data.d8[0] = AD400X_READ_COMMAND;
> +
> +	t.rx_buf = st->data.d8;
> +	t.tx_buf = st->data.d8;
> +	t.len = 2;

As below on structure initialization.

> +
> +	spi_message_init_with_transfers(&m, &t, 1);
> +
> +	ret = spi_sync(st->spi, &m);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = FIELD_GET(AD4000_CONFIG_REG_MSK, get_unaligned_be16(st->data.d8));
> +
> +	return ret;
> +}
> +
> +static int ad4000_read_sample(struct ad4000_state *st, uint32_t *val)
> +{
> +	struct spi_transfer t = {0};
> +	struct spi_message m;
> +	int ret;
> +
> +	t.rx_buf = &st->data.scan.sample_buf;
> +	t.len = 4;
> +	t.delay.value = 60;
> +	t.delay.unit = SPI_DELAY_UNIT_NSECS;

Similar to below, use c99 style structure initialization.

> +
> +	spi_message_init_with_transfers(&m, &t, 1);
> +
> +	if (st->cnv_gpio)
> +		gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_HIGH);
> +
> +	ret = spi_sync(st->spi, &m);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (st->cnv_gpio)
> +		gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_LOW);
> +
> +	*val = get_unaligned_be32(&st->data.scan.sample_buf);
> +
> +	return 0;
> +}
> +
> +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan, int *val)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	u32 sample;
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4000_read_sample(st, &sample);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	if (ret)
> +		return ret;
Scoped version works here too to avoid the need for delaying the error check.
(see below)

> +
> +	switch (chan->scan_type.realbits) {
> +	case 16:
> +		sample = FIELD_GET(AD4000_16BIT_MSK, sample);
> +		break;
> +	case 18:
> +		sample = FIELD_GET(AD4000_18BIT_MSK, sample);
> +		break;
> +	case 20:
> +		sample = FIELD_GET(AD4000_20BIT_MSK, sample);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (chan->scan_type.sign == 's')
> +		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
> +
> +	return IIO_VAL_INT;
> +}

> +static ssize_t ad4000_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	unsigned int reg_val;
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4000_read_reg(st, &reg_val);
> +	if (ret < 0)
> +		goto err_release;
> +
> +	switch ((u32)this_attr->address) {
> +	case AD4000_STATUS:
> +		reg_val &= ~AD4000_STATUS;
> +		reg_val |= FIELD_PREP(AD4000_STATUS, val);
> +		ret = ad4000_write_reg(st, reg_val);
> +		if (ret < 0)
> +			goto err_release;
> +
> +		st->status_bits = val;
> +		break;
> +	case AD4000_SPAN_COMP:
> +		reg_val &= ~AD4000_SPAN_COMP;
> +		reg_val |= FIELD_PREP(AD4000_SPAN_COMP, val);
> +		ret = ad4000_write_reg(st, reg_val);
> +		if (ret < 0)
> +			goto err_release;
> +
> +		st->span_comp = val;
> +		break;
> +	case AD4000_HIGHZ:
> +		reg_val &= ~AD4000_HIGHZ;
> +		reg_val |= FIELD_PREP(AD4000_HIGHZ, val);
> +		ret = ad4000_write_reg(st, reg_val);
> +		if (ret < 0)
> +			goto err_release;
> +
> +		st->high_z_mode = val;
> +		break;
> +	case AD4000_TURBO:
> +		reg_val &= ~AD4000_TURBO;
> +		reg_val |= FIELD_PREP(AD4000_TURBO, val);
> +		ret = ad4000_write_reg(st, reg_val);
> +		if (ret < 0)
> +			goto err_release;
> +
> +		st->turbo_mode = val;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err_release;
> +	}
> +
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
The scoped cleanup.h based version of this is no upstream and would clean#
this code up a lot by allowing early returns

See iio_device_claim_direct_scoped()



> +	return ret ? ret : len;
> +}


> +static irqreturn_t ad4000_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	struct spi_transfer t = {0};

Spaces around the 0, though technically I think you just need {};

> +	struct spi_message m;
> +	int ret;
> +
> +	t.rx_buf = &st->data.scan.sample_buf;
> +	t.len = 4;
> +	t.delay.value = 60;
> +	t.delay.unit = SPI_DELAY_UNIT_NSECS;
Better still.
	struct spi_transfer t = {
		.rx_buf = &...
		etc

	};
> +
> +	spi_message_init_with_transfers(&m, &t, 1);
> +
> +	if (st->cnv_gpio)
> +		gpiod_set_value(st->cnv_gpio, GPIOD_OUT_HIGH);
> +
> +	ret = spi_sync(st->spi, &m);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	if (st->cnv_gpio)
> +		gpiod_set_value(st->cnv_gpio, GPIOD_OUT_LOW);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +err_out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ad4000_info = {
> +	.read_raw = &ad4000_read_raw,
> +	.attrs = &ad4000_attribute_group,
> +};
> +
> +static void ad4000_regulator_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +	const struct ad4000_chip_info *chip;
> +	struct regulator *vref_reg;
> +	struct iio_dev *indio_dev;
> +	struct ad4000_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = (const struct ad4000_chip_info *)device_get_match_data(&spi->dev);

Shouldn't need the cast.  It's casting const void * to another const pointer
which the c spec allows to be done implicitly

> +	if (!chip)
> +		return -EINVAL;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	vref_reg = devm_regulator_get(&spi->dev, "vref");

I'm guessing there are other power supplies?  You should enable
them as well and given you don't use the voltage of the others you
can just use the calls to get them enabled.

> +	if (IS_ERR(vref_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
> +				     "Failed to get vref regulator\n");
> +
> +	ret = regulator_enable(vref_reg);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to enable voltage regulator\n");
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad4000_regulator_disable, vref_reg);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to add regulator disable action\n");
> +
> +	st->vref = regulator_get_voltage(vref_reg);
> +	if (st->vref < 0)
> +		return dev_err_probe(&spi->dev, st->vref, "Failed to get vref\n");
> +
> +	if (!device_property_present(&spi->dev, "adi,spi-cs-mode")) {
> +		st->cnv_gpio = devm_gpiod_get(&spi->dev, "cnv", GPIOD_OUT_HIGH);
> +		if (IS_ERR(st->cnv_gpio)) {
> +			if (PTR_ERR(st->cnv_gpio) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_gpio),
> +					     "Failed to get CNV GPIO");
> +		}
> +	}
> +
> +	indio_dev->name = chip->dev_name;
> +	indio_dev->info = &ad4000_info;
> +	indio_dev->channels = &chip->chan_spec;
> +	indio_dev->num_channels = 1;
> +
> +	if (device_property_present(&spi->dev, "adi,gain-milli")) {
> +		u32 val;
> +
> +		ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
> +		if (ret)
> +			return ret;
> +
> +		switch (val) {
> +		case 454:
> +			st->pin_gain = AD4000_0454_GAIN;
> +			break;
> +		case 909:
> +			st->pin_gain = AD4000_0909_GAIN;
> +			break;
> +		case 1000:
> +			st->pin_gain = AD4000_1_GAIN;
> +			break;
> +		case 1900:
> +			st->pin_gain = AD4000_1900_GAIN;
> +			break;
> +		default:
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "Invalid firmware provided gain\n");
> +		}
> +	} else {
> +		st->pin_gain = AD4000_1_GAIN;
For defaults, a nice pattern is to just set them before the
attempt to read the property and don't update them if the property
isn't available.

	st->pin_gain = AD4000_1_GAIN;
	if (device_property_present(&spi->dev, "adi,gain-milli")) {
		...
	}


> +	}

> +static const struct spi_device_id ad4000_id[] = {
> +	{ "ad4000", (kernel_ulong_t)&ad4000_chips[ID_AD4000] },
> +	{ "ad4001", (kernel_ulong_t)&ad4000_chips[ID_AD4001] },
> +	{ "ad4002", (kernel_ulong_t)&ad4000_chips[ID_AD4002] },
> +	{ "ad4003", (kernel_ulong_t)&ad4000_chips[ID_AD4003] },
> +	{ "ad4004", (kernel_ulong_t)&ad4000_chips[ID_AD4004] },
> +	{ "ad4005", (kernel_ulong_t)&ad4000_chips[ID_AD4005] },
> +	{ "ad4006", (kernel_ulong_t)&ad4000_chips[ID_AD4006] },
> +	{ "ad4007", (kernel_ulong_t)&ad4000_chips[ID_AD4007] },
> +	{ "ad4008", (kernel_ulong_t)&ad4000_chips[ID_AD4008] },
> +	{ "ad4010", (kernel_ulong_t)&ad4000_chips[ID_AD4010] },
> +	{ "ad4011", (kernel_ulong_t)&ad4000_chips[ID_AD4011] },
> +	{ "ad4020", (kernel_ulong_t)&ad4000_chips[ID_AD4020] },
> +	{ "ad4021", (kernel_ulong_t)&ad4000_chips[ID_AD4021] },
> +	{ "ad4022", (kernel_ulong_t)&ad4000_chips[ID_AD4022] },
> +	{ "adaq4001", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4001] },
> +	{ "adaq4003", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4003] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4000_id);
> +
> +static const struct of_device_id ad4000_of_match[] = {
> +	{ .compatible = "adi,ad4000",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4000] },

Why the casts? Shouldn't need them as data is a const void * and you
are casting from another const pointer.

> +	{ .compatible = "adi,ad4001",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4001] },
> +	{ .compatible = "adi,ad4002",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4002] },
> +	{ .compatible = "adi,ad4003",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4003] },
> +	{ .compatible = "adi,ad4004",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4004] },
> +	{ .compatible = "adi,ad4005",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4005] },
> +	{ .compatible = "adi,ad4006",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4006] },
> +	{ .compatible = "adi,ad4007",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4007] },
> +	{ .compatible = "adi,ad4008",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4008] },
> +	{ .compatible = "adi,ad4010",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4010] },
> +	{ .compatible = "adi,ad4011",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4011] },
> +	{ .compatible = "adi,ad4020",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4020] },
> +	{ .compatible = "adi,ad4021",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4021] },
> +	{ .compatible = "adi,ad4022",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_AD4022] },
> +	{ .compatible = "adi,adaq4001",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_ADAQ4001] },
> +	{ .compatible = "adi,adaq4003",
> +	  .data = (struct ad4000_chip_info *)&ad4000_chips[ID_ADAQ4003] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4000_of_match);


