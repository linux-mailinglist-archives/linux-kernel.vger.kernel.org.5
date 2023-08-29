Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09E478BCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjH2CQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjH2CQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:16:25 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1C6110;
        Mon, 28 Aug 2023 19:16:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4108f57db7fso18564871cf.1;
        Mon, 28 Aug 2023 19:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693275381; x=1693880181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YAPuJcY2DCOE8Ee6dDajrQEg62hDEwsvqOlAM/4eYE=;
        b=LhvO3ZPqVKVWNZ5BIVvygS8CMVf+vi6SZCTyLqduK3JjXrFmaZ3RC9ocjps3Lzh52o
         koX/tw8uH7XRklfcsZ5wisZdoZ/G4TSj31cj+5cA/qHyAqGZAWg5PqR3AjB3i2bpm6OF
         OarZ5tjz0+9F6gC5TAoU+Zmn7wPfMcKDawB4BbBqHzgg8Z7PRTb//1ihTMSTeMo8Rn0k
         fpdTFlhU+hGh8l3h6PEUmhmK0SW06zKa+buKoiLnPQBD1ucMygggYMKPgDgqM26Rz73u
         HLweDiFOpyBXtB0G/w+pFDmw74jSyIuluruaEZe0KzSNuii3jP/YvsuE0ZtAKDXAo4mB
         WerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693275381; x=1693880181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YAPuJcY2DCOE8Ee6dDajrQEg62hDEwsvqOlAM/4eYE=;
        b=N5I21/twx8jYcUKyOm42BrXG6Nel5p3CQsEHyQx46O6msGj6x2NcOsVbKuWbjTGsmH
         1QCmnJ4dSDTgHk8uMxl87s12cCG3ymZPgDmwTY4U4ZoLSmAGsYn2P+GqrOeRreCyhcCp
         v0sHFSenna6a4V+Z1fzjIH/mNxPA52tSsgG2oJ3lIEIOgZMsZ6+r54RocKqLiwQPfE2V
         lWZvcL8rJk3QNf+3rRU2VwWFifuuhO3kEv0vfznT91ZGVcoACNLC9Ic/26PY/BSBDVsD
         dI8TKt+7U5rQd3L8EuTsACPYzdShpTTfUCTjY0cnREaY7DmPFq42qtL08/AeZ4jAX9ua
         QjUA==
X-Gm-Message-State: AOJu0YzW/B/ZF5viUBZJpVfihrsKylxTE6Z8LNIzAaiuRP0rVoZjBChF
        pu/6w3mac/PW4EMQRAF+A6Hl3BbS1GcLp6b3
X-Google-Smtp-Source: AGHT+IFt2qKgvTcxytrVwW9DJ1FgTW3xOFZjWLsN9eoDOrkhgNK4/KVdevnCKsyZkvtuzHz/FRmIUQ==
X-Received: by 2002:a05:622a:50f:b0:405:4f9a:5737 with SMTP id l15-20020a05622a050f00b004054f9a5737mr30623709qtx.61.1693275380814;
        Mon, 28 Aug 2023 19:16:20 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id k4-20020ac86044000000b00411fcc18cc1sm2705731qtm.64.2023.08.28.19.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:16:19 -0700 (PDT)
Date:   Mon, 28 Aug 2023 22:16:17 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add ltc2309 support
Message-ID: <20230829021617.GA657648@shaak>
References: <20230825-ltc2309-v2-0-6d75f2b3fb50@gmail.com>
 <20230825-ltc2309-v2-2-6d75f2b3fb50@gmail.com>
 <20230827184542.23a56402@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827184542.23a56402@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 06:45:42PM +0100, Jonathan Cameron wrote:
> On Fri, 25 Aug 2023 14:20:59 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
> 
> > The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> > 
> > This implements support for all single-ended and differential channels,
> > in unipolar mode only.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> Hi Liam,
> 
> Some comments inline.
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

Thanks for reviewing, I'll address your comments and resend shortly.

Liam

> > ---
> >  drivers/iio/adc/Kconfig   |  10 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/ltc2309.c | 248 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 259 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index dc14bde31ac1..6ec18e02faf9 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -607,6 +607,16 @@ config LPC32XX_ADC
> >  	  activate only one via device tree selection.  Provides direct access
> >  	  via sysfs.
> >  
> > +config LTC2309
> > +	tristate "Linear Technology LTC2309 ADC driver"
> > +	depends on I2C
> > +	help
> > +	  Say yes here to build support for Linear Technology LTC2309, a low
> > +	  noise, low power, 8-channel, 12-bit SAR ADC
> > +
> > +	  This driver can also be built as a module. If so, the module will
> > +	  be called ltc2309.
> > +
> >  config LTC2471
> >  	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index eb6e891790fb..fbd86184ec94 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
> >  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
> >  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
> >  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> > +obj-$(CONFIG_LTC2309) += ltc2309.o
> >  obj-$(CONFIG_LTC2471) += ltc2471.o
> >  obj-$(CONFIG_LTC2485) += ltc2485.o
> >  obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
> > diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> > new file mode 100644
> > index 000000000000..145f3c63d157
> > --- /dev/null
> > +++ b/drivers/iio/adc/ltc2309.c
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> > + *
> > + * Datasheet:
> > + * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
> > + *
> > + * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
> 
> Blank line here doesn't add anything useful. I'll drop it if not much else
> comes up.
> 
> > + *
> > + */
> > +#include <linux/bitfield.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define DRIVER_NAME		"ltc2309"
> I'd rather see this string directly in line within the code.
> In general the places you used it could have different strings, so it's
> much nicer just to see the string itself where it is used.
> 
> > +#define LTC2309_ADC_RESOLUTION	12
> > +
> > +#define LTC2309_DIN_CH_MASK	GENMASK(7, 4)
> > +#define LTC2309_DIN_SDN		BIT(7)
> > +#define LTC2309_DIN_OSN		BIT(6)
> > +#define LTC2309_DIN_S1		BIT(5)
> > +#define LTC2309_DIN_S0		BIT(4)
> > +#define LTC2309_DIN_UNI		BIT(3)
> > +#define LTC2309_DIN_SLEEP	BIT(2)
> > +
> > +/* struct ltc2309 - internal device data structure
>   /*
>    * struct ltc2039
> 
> 
> for comments in IIO.
> 
> Also, this is kernel doc so should be
>   /**
>    * struct ...
> 
> > + *
> > + * @dev:	Device reference
> > + * @client:	I2C reference
> > + * @vref:	External reference source
> > + * @lock:	Lock to serialize data access
> > + * @vref_mv	Internal voltage reference
> > + */
> > +struct ltc2309 {
> > +	struct device		*dev;
> > +	struct i2c_client	*client;
> > +	struct regulator	*vref;
> > +	struct mutex		lock; /* serialize data access */
> > +	int			vref_mv;
> > +};
> > +
> > +/* Order matches expected channel address, See datasheet Table 1. */
> > +enum ltc2309_channels {
> > +	LTC2309_CH0_CH1 = 0,
> > +	LTC2309_CH2_CH3,
> > +	LTC2309_CH4_CH5,
> > +	LTC2309_CH6_CH7,
> > +	LTC2309_CH1_CH0,
> > +	LTC2309_CH3_CH2,
> > +	LTC2309_CH5_CH4,
> > +	LTC2309_CH7_CH6,
> > +	LTC2309_CH0,
> > +	LTC2309_CH2,
> > +	LTC2309_CH4,
> > +	LTC2309_CH6,
> > +	LTC2309_CH1,
> > +	LTC2309_CH3,
> > +	LTC2309_CH5,
> > +	LTC2309_CH7,
> > +};
> > +
> > +#define LTC2309_CHAN(_chan, _addr) {				\
> > +	.type = IIO_VOLTAGE,					\
> > +	.indexed = 1,						\
> > +	.address = _addr,					\
> > +	.channel = _chan,					\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +	.datasheet_name = "CH" #_chan,				\
> 
> I'd not bother providing a datasheet name it it's so directly related
> to the channel index which is readily available. It just adds
> ABI that is fairly pointless as it isn't conveying any information.
> 
> > +}
> > +
> > +#define LTC2309_DIFF_CHAN(_chan, _chan2, _addr) {		\
> > +	.type = IIO_VOLTAGE,					\
> > +	.differential = 1,					\
> > +	.indexed = 1,						\
> > +	.address = _addr,					\
> > +	.channel = _chan,					\
> > +	.channel2 = _chan2,					\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +	.datasheet_name = "CH" #_chan "-CH" #_chan2,		\
> 
> As above - this is obvious anyway, I'd drop the datasheet_name.
> It's optional so just don't provide it ;)
> 
> > +}
> > +
> > +static const struct iio_chan_spec ltc2309_channels[] = {
> > +	LTC2309_CHAN(0, LTC2309_CH0),
> > +	LTC2309_CHAN(1, LTC2309_CH1),
> > +	LTC2309_CHAN(2, LTC2309_CH2),
> > +	LTC2309_CHAN(3, LTC2309_CH3),
> > +	LTC2309_CHAN(4, LTC2309_CH4),
> > +	LTC2309_CHAN(5, LTC2309_CH5),
> > +	LTC2309_CHAN(6, LTC2309_CH6),
> > +	LTC2309_CHAN(7, LTC2309_CH7),
> > +	LTC2309_DIFF_CHAN(0, 1, LTC2309_CH0_CH1),
> > +	LTC2309_DIFF_CHAN(2, 3, LTC2309_CH2_CH3),
> > +	LTC2309_DIFF_CHAN(4, 5, LTC2309_CH4_CH5),
> > +	LTC2309_DIFF_CHAN(6, 7, LTC2309_CH6_CH7),
> > +	LTC2309_DIFF_CHAN(1, 0, LTC2309_CH1_CH0),
> > +	LTC2309_DIFF_CHAN(3, 2, LTC2309_CH3_CH2),
> > +	LTC2309_DIFF_CHAN(5, 4, LTC2309_CH5_CH4),
> > +	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
> > +};
> > +
> > +static int ltc2309_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct ltc2309 *ltc2309 = iio_priv(indio_dev);
> > +	u16 buf;
> > +	int ret;
> > +	u8 din;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		din = FIELD_PREP(LTC2309_DIN_CH_MASK, chan->address & 0x0f) |
> > +			FIELD_PREP(LTC2309_DIN_UNI, 1) |
> > +			FIELD_PREP(LTC2309_DIN_SLEEP, 0);
> > +
> > +		mutex_lock(&ltc2309->lock);
> > +		ret = i2c_smbus_write_byte(ltc2309->client, din);
> > +		if (ret < 0) {
> > +			dev_err(ltc2309->dev, "i2c command failed: %pe\n",
> > +				ERR_PTR(ret));
> > +			goto out;
> 
> This sort of messy mutex handling for error paths is a strong signal
> that the code would be better with a little utility function around which
> you take the locks.  
> 
> 		mutex_lock(&ltc2309->lock);
> 		ret = ltc2309_read_raw(...);  // move the field prep in there as well even though it expands the scope a tiny bit
> 		mutex_unlock()
> 		if (ret)
> 			...
> 
> 		carry on.
> 
> > +		}
> > +
> > +		ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
> > +		if (ret < 0) {
> > +			dev_err(ltc2309->dev, "i2c read failed: %pe\n",
> > +				ERR_PTR(ret));
> > +			goto out;
> > +		}
> > +
> > +		*val = be16_to_cpu(buf) >> 4;
> This doesn't really need to be under the lock, but if it makes sense to
> do it in the utility function I suggest above then that's fine.
> 
> > +		mutex_unlock(&ltc2309->lock);
> > +
> > +		ret = IIO_VAL_INT;
> 
> 		return IIO_VAL_INT;
> 
> > +		break;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = ltc2309->vref_mv;
> > +		*val2 = LTC2309_ADC_RESOLUTION;
> > +		ret = IIO_VAL_FRACTIONAL_LOG2;
> return IIO_VAL_FRACTIONAL_LOG2 and get rid of the rbeadk.
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> return -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +
> > +out:
> > +	mutex_unlock(&ltc2309->lock);
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info ltc2309_info = {
> > +	.read_raw = ltc2309_read_raw,
> > +};
> > +
> > +void ltc2309_regulator_disable(void *regulator)
> > +{
> > +	struct regulator *r = (struct regulator *)regulator;
> > +
> > +	regulator_disable(r);
> > +}
> > +
> > +static int ltc2309_probe(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct ltc2309 *ltc2309;
> > +	int ret = 0;
> 
> Always set in paths where it is used so don't set it here.
> 
> 
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(client, indio_dev);
> 
> Is this used?
> 
> > +
> > +	ltc2309 = iio_priv(indio_dev);
> > +	ltc2309->dev = &indio_dev->dev;
> > +	ltc2309->client = client;
> > +	ltc2309->vref_mv = 4096; /* Default to the internal ref */
> > +
> > +	indio_dev->name = DRIVER_NAME;
> > +	indio_dev->dev.parent = &client->dev;
> 
> That's not been needed for quite a long time as devm_iio_device_alloc()
> sets it. Ultimately it's here:
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-core.c#L1645
> 
> 
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = ltc2309_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
> > +	indio_dev->info = &ltc2309_info;
> > +
> > +	ltc2309->vref = devm_regulator_get_optional(&client->dev, "vref");
> > +	if (!IS_ERR_OR_NULL(ltc2309->vref)) {
> 
> What if you get a request to defer?  To use devm_regulator_get_optional()
> and detect the cases where the regulator is not provided separately from
> errors during the probe.  IIRC check for PTR_ERR(-ENODEV) as meaning 
> one wasn't supplied.  However do check I have that right.
> 
> > +		ret = regulator_enable(ltc2309->vref);
> > +		if (ret) {
> > +			dev_err(ltc2309->dev, "failed to enable vref\n");
> > +			return ret;
> 
> dev_err_probe() for all error messages in a probe function. 
> 
> > +		}
> > +
> > +		ret = devm_add_action_or_reset(ltc2309->dev,
> > +					       ltc2309_regulator_disable,
> > +					       ltc2309->vref);
> > +		if (ret) {
> > +			dev_err(ltc2309->dev,
> > +				"failed to add regulator_disable action: %d\n",
> > +				ret);
> return dev_err_probe()
> 
> > +			return ret;
> > +		}
> > +
> > +		ret = regulator_get_voltage(ltc2309->vref);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ltc2309->vref_mv = ret / 1000;
> > +	}
> > +
> > +	mutex_init(&ltc2309->lock);
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id ltc2309_of_match[] = {
> > +	{ .compatible = "lltc,ltc2309" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ltc2309_of_match);
> > +
> > +static const struct i2c_device_id ltc2309_id[] = {
> > +	{"ltc2309", 0},
> 
> Don't provide data unless it's doing anything useful.
> Also, consistency on spacing after { and before }
> 
> > +	{},
> 
> No comma on a list terminator like this one as nothing can come
> after it that isn't a bug.
> 
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ltc2309_id);
> > +
> > +static struct i2c_driver ltc2309_driver = {
> > +	.driver = {
> > +		.name = DRIVER_NAME,
> > +		.of_match_table = ltc2309_of_match,
> > +	},
> > +	.probe		= ltc2309_probe,
> > +	.id_table	= ltc2309_id,
> > +};
> > +module_i2c_driver(ltc2309_driver);
> > +
> > +MODULE_AUTHOR("Liam Beguin <liambeguin@gmail.com>");
> > +MODULE_DESCRIPTION("Linear Technology LTC2309 ADC");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
