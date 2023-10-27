Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47B87D9588
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjJ0KtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJ0KtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:49:15 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6271129;
        Fri, 27 Oct 2023 03:49:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so28994091fa.1;
        Fri, 27 Oct 2023 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698403750; x=1699008550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMu5YjDmD7M90Ihy1ElM06pJGmJ/11f5UFSFKa+oWAI=;
        b=g1uvjsPoanEe6CUYtn4EabMJPQnyBDmhSV+ghYviKjeHKSHYKA1XXT+TEwp/ICz5YB
         Pv/p++5hEfnyCY6YEuGi1ypqJalbJT8j6H60mavoDMiUSNWtptoPEHTaY3psc6KyK8aQ
         wQMqXmkr/Y1nlxt4bc8W0SuvLt5SWEMcSxlHScg5YUkwVBcfBggs7C/iXdEXAcdVSR2j
         6dloJ7RTGM+Cnr2H/nt60v0dgeG0BBKUQPV4e6r98V1BBqOSrjgjTsWpTrWkpsYeE2IL
         fMHr78iQC3eVm/1WEH//PwlazeRNSK0vLJnhKaLnOxHghKWGcgcQAXEjHfF5Ul2WOPhn
         g1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698403750; x=1699008550;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMu5YjDmD7M90Ihy1ElM06pJGmJ/11f5UFSFKa+oWAI=;
        b=PlKxqbSM1O0rcHc6Z5ig21DuE+BCaG3B9QjoTXDZmcdyDdG14uqgbKD2zDUbd2vEtu
         9oyrxKQjEC12poQ8itaOEN5eWmEO5IId8GlQpJW6b+E4VUN0m34livd7xtQwDkvvaM72
         Ijqm47UyBLOhoCAT/WYYcXuiq9Lpki9ce16BOx/0xEbmr0pvX/zkCa1o2i7fHmfXOCps
         KeuT4dr6e9HFPMtGDK4SGGb/MG4ZFu/tsv4BCBruclNkxj1IZoBRc22R2iUJ3qX8Sd30
         /0RPH9RdypZJBbccAKiu6NCl1tZtqFTvHN4OI9GFn041g4xjQkxrrFZ6cl9fYmPMzHVJ
         swbA==
X-Gm-Message-State: AOJu0YypIW8GV6bd85MP3192EdUO7a4B95BPhnVCKV4GAs6oojov/a35
        7v192u1GmAKsI8wjONq8fG0=
X-Google-Smtp-Source: AGHT+IF692W4oajXfgbo1nm/rWKtfpLHS+FIjrWmRTCnXv63TUVwBApphjQvDqnwEQ7zSNDMxtUyBQ==
X-Received: by 2002:a05:6512:118d:b0:503:3816:c42c with SMTP id g13-20020a056512118d00b005033816c42cmr1777825lfr.41.1698403749449;
        Fri, 27 Oct 2023 03:49:09 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g3-20020a19e043000000b004ff8cd27a61sm233428lfj.213.2023.10.27.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 03:49:08 -0700 (PDT)
Message-ID: <341cb934-2e91-442a-a4db-2f69f79ad0b6@gmail.com>
Date:   Fri, 27 Oct 2023 13:49:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: light: Add support for APDS9306 Light Sensor
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
 <20231026143532.39660-3-subhajit.ghosh@tweaklogic.com>
Content-Language: en-US, en-GB
In-Reply-To: <20231026143532.39660-3-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Subhajit,

It's nice to see the GTS helpers are used (and hopefully helpful). I 
didn't have the time to go through everything with full focus - so 
please just tell me if some of my questions are silly :) The comments I 
marked as 'nit' aren't really important - feel free to use your 
judgement on them :)

On 10/26/23 17:35, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor with als
> and clear channels with i2c interface. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.
> 
> v0 -> v1
> - Fixed errors as per previous review
> - Longer commit messages and descriptions
> - Updated scale calculations as per iio gts scheme to export proper scale
>    values and tables to userspace
> - Removed processed attribute for the same channel for which raw is
>    provided, instead, exporting proper scale and scale table to userspace so
>    that userspace can do "(raw + offset) * scale" and derive Lux values
> - Fixed IIO attribute range syntax
> - Keeping the regmap lock enabled as the driver uses unlocked regfield
>    accesses from interrupt handler
> - Several levels of cleanups by placing guard mutexes in proper places and
>    returning immediately in case of an error
> - Using iio_device_claim_direct_mode() during raw reads so that
>    configurations could not be changed during an adc conversion period
> - In case of a powerdown error, returning immediately
> - Removing the definition of direction of the hardware interrupt and
>    leaving it on to device tree
> - Adding the powerdown callback after doing device initialization
> - Removed the regcache_cache_only() implementation
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
>   drivers/iio/light/Kconfig    |   12 +
>   drivers/iio/light/Makefile   |    1 +
>   drivers/iio/light/apds9306.c | 1334 ++++++++++++++++++++++++++++++++++
>   3 files changed, 1347 insertions(+)
>   create mode 100644 drivers/iio/light/apds9306.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 45edba797e4c..04e7d10f1470 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -73,6 +73,18 @@ config APDS9300
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called apds9300.
>   
> +config APDS9306
> +	tristate "Avago APDS9306 Ambient Light Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_GTS_HELPER
> +	help
> +	  If you say Y or M here, you get support for Avago APDS9306
> +	  Ambient Light Sensor.
> +
> +	  If built as a dynamically linked module, it will be called
> +	  apds9306.
> +
>   config APDS9960
>   	tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
>   	select REGMAP_I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0db4c4c36ec..ab94eac04db0 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
>   obj-$(CONFIG_AL3010)		+= al3010.o
>   obj-$(CONFIG_AL3320A)		+= al3320a.o
>   obj-$(CONFIG_APDS9300)		+= apds9300.o
> +obj-$(CONFIG_APDS9306)		+= apds9306.o
>   obj-$(CONFIG_APDS9960)		+= apds9960.o
>   obj-$(CONFIG_AS73211)		+= as73211.o
>   obj-$(CONFIG_BH1750)		+= bh1750.o
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> new file mode 100644
> index 000000000000..352893913a29
> --- /dev/null
> +++ b/drivers/iio/light/apds9306.c
> @@ -0,0 +1,1334 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * APDS-9306/APDS-9306-065 Ambient Light Sensor
> + * I2C Address: 0x52
> + * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> + *
> + * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> + */
> +

...

> +
> +/**
> + * struct part_id_gts_multiplier - Part no. & corresponding gts multiplier
> + * @part_id: Part ID of the device
> + * @max_scale_int: Multiplier for iio_init_iio_gts()
> + * @max_scale_nano: Multiplier for iio_init_iio_gts()
> + */
> +struct part_id_gts_multiplier {
> +	int part_id;
> +	int max_scale_int;
> +	int max_scale_nano;
> +};
> +
> +/*
> + * As per the datasheet, at HW Gain = 3x, Integration time 100mS (32x),
> + * typical 2000 ADC counts are observed for 49.8 uW per sq cm (340.134 lux)
> + * for apds9306 and 43 uW per sq cm (293.69 lux) for apds9306-065.
> + * Assuming lux per count is linear across all integration time ranges.

I love this comment. Still, even with this I managed to get confused :) 
It might be beneficial to mention that the minimum gain is 1x from both 
the integration time and gain. (Not mandatory, I was just trying to 
figure out why this was so difficult for me to follow).

> + * Lux = (raw + offset) * scale; offset can be any value by userspace.
> + * HG = Hardware Gain; ITG = Gain by changing integration time.
> + * Scale table by IIO GTS Helpers = (1 / HG) * (1 / ITG) * Multiplier.
> + *
> + * The Lux values provided in the datasheet are at ITG=32x and HG=3x,
> + * at typical 2000 count.
> + *
> + * Lux per ADC count at 3x and 32x for apds9306 = 340.134 / 2000
> + * Lux per ADC count at 3x and 32x for apds9306-065 = 293.69 / 2000
> + *
> + * The Multiplier for the scale table provided to userspace:
> + * IIO GTS scale Multiplier for apds9306 = (340.134 / 2000) * 32 * 3

'nit'
Could you please show also the result of the computation (16.326432)...

> + * IIO GTS scale Multiplier for apds9306-065 = (293.69 / 2000) * 32 * 3
> + */
> +static struct part_id_gts_multiplier apds9306_gts_mul[] = {
> +	{
> +		.part_id = 0xB1,
> +		.max_scale_int = 16,
> +		.max_scale_nano = 3264320,

'nit'
... to make it easier to see what we have here corresponds to the values 
in comment above.

> +	}, {
> +		.part_id = 0xB3,
> +		.max_scale_int = 14,
> +		.max_scale_nano = 9712000,
> +	},
> +};
> +
> +/**
> + * apds9306_repeat_rate_freq - Sampling Frequency in uHz
> + */
> +static const int apds9306_repeat_rate_freq[][2] = {
> +	{40, 0},
> +	{20, 0},
> +	{10, 0},
> +	{5,  0},
> +	{2,  0},
> +	{1,  0},
> +	{0, 500000},
> +};
> +
> +/**
> + * apds9306_repeat_rate_period - Sampling period in uSec
> + */
> +static const int apds9306_repeat_rate_period[] = {
> +	25000, 50000, 100000, 200000, 500000, 1000000, 2000000
> +};
> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
> +	      ARRAY_SIZE(apds9306_repeat_rate_period));
> +
> +/**
> + * struct apds9306_data - apds9306 private data and registers definitions
> + *
> + * All regfield definitions are named exactly according to datasheet for easy
> + * search
> + *
> + * @dev:	Pointer to the device structure
> + * @gts:	IIO Gain Time Scale structure
> + * @mutex:	Lock for protecting register access, adc reads and power
> + * @regmap:	Regmap structure pointer
> + * @regfield_sw_reset:	Reg: MAIN_CTRL, Field: SW_Reset
> + * @regfield_en:	Reg: MAIN_CTRL, Field: ALS_EN
> + * @regfield_intg_time:	Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width
> + * @regfield_repeat_rate:	Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate
> + * @regfield_scale:	Reg: ALS_GAIN, Field: ALS Gain Range
> + * @regfield_int_src:	Reg: INT_CFG, Field: ALS Interrupt Source
> + * @regfield_int_thresh_var_en:	Reg: INT_CFG, Field: ALS Var Interrupt Mode
> + * @regfield_int_en:	Reg: INT_CFG, Field: ALS Interrupt Enable
> + * @regfield_int_persist_val:	Reg: INT_PERSISTENCE, Field: ALS_PERSIST
> + * @regfield_int_thresh_var_val:	Reg: ALS_THRSH_VAR, Field: ALS_THRES_VAR
> + * @nlux_per_count:	nano lux per ADC count for a particular model
> + * @read_data_available:	Flag set by IRQ handler for ADC data available
> + * @intg_time_idx:	Array index for integration times
> + * @repeat_rate_idx:	Array index for sampling frequency
> + * @gain_idx:	Array index for gain
> + * @int_ch:	Currently selected Interrupt channel
> + */
> +struct apds9306_data {
> +	struct device *dev;
> +	struct iio_gts gts;
> +	/*
> +	 * Protects device settings changes where some calculations are required
> +	 * before or after setting or getting the raw settings values from regmap
> +	 * writes or reads respectively.
> +	 */
> +	struct mutex mutex;
> +
> +	struct regmap *regmap;
> +	struct regmap_field *regfield_sw_reset;
> +	struct regmap_field *regfield_en;
> +	struct regmap_field *regfield_intg_time;
> +	struct regmap_field *regfield_repeat_rate;
> +	struct regmap_field *regfield_scale;
> +	struct regmap_field *regfield_int_src;
> +	struct regmap_field *regfield_int_thresh_var_en;
> +	struct regmap_field *regfield_int_en;
> +	struct regmap_field *regfield_int_persist_val;
> +	struct regmap_field *regfield_int_thresh_var_val;
> +
> +	int nlux_per_count;
> +	int read_data_available;
> +	u8 intg_time_idx;
> +	u8 repeat_rate_idx;
> +	u8 gain_idx;

'nit'
I'm not sure caching the time and gain idx in the driver data is that 
beneficial? I assume you use regmap cache amyways. For me caching these 
add a bit of complexity when trying to ensure they are not used 
'uninitialized' for not that obvious benefit.

> +	u8 int_ch;
> +};
> +
> +/*
> + * Available scales with gain 1x - 18x, timings 3.125, 25, 50, 100, 200,
> + * 400 mS
> + * Time impacts to gain: 1x, 8x, 16x, 32x, 64x, 128x > + */
> +
> +#define APDS9306_GSEL_1X	0x00
> +#define APDS9306_GSEL_3X	0x01
> +#define APDS9306_GSEL_6X	0x02
> +#define APDS9306_GSEL_9X	0x03
> +#define APDS9306_GSEL_18X	0x04
> +
> +static const struct iio_gain_sel_pair apds9306_gains[] = {
> +	GAIN_SCALE_GAIN(1, APDS9306_GSEL_1X),
> +	GAIN_SCALE_GAIN(3, APDS9306_GSEL_3X),
> +	GAIN_SCALE_GAIN(6, APDS9306_GSEL_6X),
> +	GAIN_SCALE_GAIN(9, APDS9306_GSEL_9X),
> +	GAIN_SCALE_GAIN(18, APDS9306_GSEL_18X),
> +};
> +
> +#define APDS9306_MEAS_MODE_400MS	0x00
> +#define APDS9306_MEAS_MODE_200MS	0x01
> +#define APDS9306_MEAS_MODE_100MS	0x02
> +#define APDS9306_MEAS_MODE_50MS		0x03
> +#define APDS9306_MEAS_MODE_25MS		0x04
> +#define APDS9306_MEAS_MODE_3125US	0x05
> +
> +static const struct iio_itime_sel_mul apds9306_itimes[] = {
> +	GAIN_SCALE_ITIME_US(400000, APDS9306_MEAS_MODE_400MS, 128),
> +	GAIN_SCALE_ITIME_US(200000, APDS9306_MEAS_MODE_200MS, 64),
> +	GAIN_SCALE_ITIME_US(100000, APDS9306_MEAS_MODE_100MS, 32),
> +	GAIN_SCALE_ITIME_US(50000, APDS9306_MEAS_MODE_50MS, 16),
> +	GAIN_SCALE_ITIME_US(25000, APDS9306_MEAS_MODE_25MS, 8),
> +	GAIN_SCALE_ITIME_US(3125, APDS9306_MEAS_MODE_3125US, 1),
> +};
> +

...

> +
> +static const struct regmap_config apds9306_regmap = {
> +	.name = "apds9306_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.rd_table = &apds9306_readable_table,
> +	.wr_table = &apds9306_writable_table,
> +	.volatile_table = &apds9306_volatile_table,
> +	.precious_table = &apds9306_precious_table,
> +	.max_register = APDS9306_ALS_THRES_VAR,
> +	.cache_type = REGCACHE_RBTREE,
> +	/*
> +	 * Leaving the regmap lock enabled as regfield accesses are everywhere
> +	 * which are read modify writes and data mutex is not used in the
> +	 * interrupt handler.
> +	 */

To my eye this comment looks a bit misplaced without the
	.disable_locking = false,
- which is a no-op here. I think what you wrote in the comment is true 
(default assumption) for many drivers - maybe the comment is not needed?

> +};

...

> +static int apds9306_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> +			reg = APDS9306_CLEAR_DATA_0;
> +		else
> +			reg = APDS9306_ALS_DATA_0;
> +		/*
> +		 * Changing device parameters during adc operation, resets
> +		 * the ADC which has to avoided.
> +		 */

Would you need to grab the mutex here? I think you want also prevent 
changing gain/time during the computations.

> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		ret = apds9306_read_data(data, val, reg);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = apds9306_intg_time_get(data, val2);
> +		if (ret)
> +			return ret;
> +		*val = 0;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = apds9306_sampling_freq_get(data, val, val2);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = apds9306_scale_get(data, val, val2);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +};
> +

Thanks for the nice driver!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


