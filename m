Return-Path: <linux-kernel+bounces-32797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD783602C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC912283E18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150C3A28B;
	Mon, 22 Jan 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="VLuXpqaz"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B93A29A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920975; cv=none; b=XbLN9sgDnyKoR5KxAMwVCozRv1nwAmSMb6S7m+qJoSh3u6/W9tPTZ2HYQyMMxUcE5rfMtPQ02RSfxoSeC+BrFhXGBG3oowcA6gQacl7aif1rsLQeU1gHkWQxKEX1B1aWOl+92trVOV+jnD4w9SVoy3Bc5xDNbBF5X2Ez7TsQx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920975; c=relaxed/simple;
	bh=ziM+ArcWjSeZ/lCiJxhwg0Xwm+YVrsQibirAU7LV7eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVTfee/pGHhmIxAR4du6EhK2MBeQaqOn9xAWRJWQKFyldqwBXbpd9p+/38V9XjHvLAw+7JoRcLWlOJ0+N6Tzg6KSRq8Y//PwkM6RbrdwwUS7LRPMGo5Ny8bIgAByiOh+CTg4eS1/usPSP0eAquas2tZyBszKMRppBALsH+EFlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=VLuXpqaz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7354ba334so11291315ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705920972; x=1706525772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIH5N+ULE6SPzsM01jPwvQmo72Dw7fR8DZfeV0X+zs4=;
        b=VLuXpqazzQJw7mA3HouV0smDWXmEuNrUv7PtlpqumXzrAM+Vs3IuUbBeHolxl+53+h
         Ksd9R/1mVG1eQznpAaqbDey1o2U6pKdw45f+oDZYaHDNBCYngucXZxFstqzKLGoa2YiB
         /rtlpH/8Je+shXaMh2d90eNuy3eFevHqYDouLGNlcuXUrLjNmobzPOuWuih+Yye4p6G2
         LhDHFDf0QJyV7PAHEuQ+YQlgI97T3bBo7XMYFYPnZaYYUhcDRtFAgmyicNgr4DUMLsVb
         kruXwrZxJ1doyg6oCX7T2TrZMpjMxfpyEQzuOR38p66uMR1V8IYY+0oKgT5tcsUp/pnB
         EBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920972; x=1706525772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIH5N+ULE6SPzsM01jPwvQmo72Dw7fR8DZfeV0X+zs4=;
        b=ScEMse/eGsV2q7/y6jfA/hb3sdjDcSPRftCRXRjyIPvm0lLmRoALEwMpMSF5SOGBmZ
         j+g2w+wvNpvz/FMXD4QeUW0jAQae68/yD1PMg3BdJrANqdf7EYOMe4P8FDfTZjs75d2q
         N7y418dTG7hfa/jvJsuAtjtrD0Tt7eSuGaCbZCSTbX3FLR+yeghaFed7jAako9WH9wxW
         pXpQR/NVV08SKpNKq93RLlVQ09GCXVWEXn2xPDE8HlFvpNj/wGVznrAgWipYj4AF1ZZS
         kvkIUW5IUKY5ViqWgoxnTBgx9vWR9QEXz2g+sAfKepR/cARhaeh7yVM/T+qX8pHou0x2
         0LZQ==
X-Gm-Message-State: AOJu0YxJ3e0xdoCcpKwClpvQN3QSNoOOWy9K1FN14hGFSIWGczO/YODX
	IR3w2JmuzgZG/x7JkNPI4K7WcBec9D9208fEOfXoj4ns4CiZUXpjtdQBhHpxYJ8=
X-Google-Smtp-Source: AGHT+IFhhL/3Lz4T7aUuIwlA5GOQ5ee3HSBX0wtAHD/SMmnPF+LJvLtFg/Oh2gKv+9/FjEca3196fQ==
X-Received: by 2002:a17:902:ecc4:b0:1d7:35e0:2b5b with SMTP id a4-20020a170902ecc400b001d735e02b5bmr3783521plh.125.1705920972300;
        Mon, 22 Jan 2024 02:56:12 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001d74c285b55sm1899361pls.67.2024.01.22.02.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:56:11 -0800 (PST)
Message-ID: <757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
Date: Mon, 22 Jan 2024 21:26:03 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <20240121152332.6b15666a@jic23-huawei>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240121152332.6b15666a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/1/24 01:53, Jonathan Cameron wrote:
> On Sun, 21 Jan 2024 15:47:34 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
>> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
>> channel approximates the response of the human-eye providing direct
>> read out where the output count is proportional to ambient light levels.
>> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
>> caused by artificial light sources. Hardware interrupt configuration is
>> optional. It is a low power device with 20 bit resolution and has
>> configurable adaptive interrupt mode and interrupt persistence mode.
>> The device also features inbuilt hardware gain, multiple integration time
>> selection options and sampling frequency selection options.
>>
>> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
>> Scales, Gains and Integration time implementation.
>>
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>> ---
>> v2 -> v5:
> 
> Why did you jump to v5?  Some internal or private reviews perhaps?
> Better for those tracking on the list if you just used v3.
Wish I had someone to review my code before sending it to kernel community!
I do this in my own time.

v5 was suggested by you. Now I understand that Suggested-by: tag has to be used :)
https://lore.kernel.org/all/20231028143631.2545f93e@jic23-huawei/

> 
> 
>>   - Removed scale attribute for Intensity channel:
>>     Link: https://lore.kernel.org/all/20231204095108.22f89718@jic23-huawei/
>>
>>   - Dropped caching of hardware gain, repeat rate and integration time and
>>     updated code as per earlier reviews.
>>     Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
> 
> ...
> 
> A few, mostly very minor comments inline to add to Christophe's review.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
>> new file mode 100644
>> index 000000000000..8ed5899050ed
>> --- /dev/null
>> +++ b/drivers/iio/light/apds9306.c
>> @@ -0,0 +1,1315 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * APDS-9306/APDS-9306-065 Ambient Light Sensor
>> + * I2C Address: 0x52
>> + * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
>> + *
>> + * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 
> Given you are still changing it, feel free to include 2024!
I sincerely hope that I don't have to update it to 2025!
> 
>> + */
> ...
>> +static const int apds9306_repeat_rate_freq[][2] = {
>> +	{40, 0},
>> +	{20, 0},
>> +	{10, 0},
>> +	{5,  0},
>> +	{2,  0},
>> +	{1,  0},
>> +	{0, 500000},
> Prefer
> 	{ 40, 0 },
> etc and whilst I don't really like forcing alignment like this, if you
> are going to do it be consistent.  The last 50000 is one space too far to the
> left I think.
> 
> 
>> +};
>> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
>> +		APDS9306_NUM_REPEAT_RATES);
>> +
>> +static const int apds9306_repeat_rate_period[] = {
>> +	25000, 50000, 100000, 200000, 500000, 1000000, 2000000,
>> +};
>> +static_assert(ARRAY_SIZE(apds9306_repeat_rate_period) ==
>> +		APDS9306_NUM_REPEAT_RATES);
>> +
>> +/**
>> + * struct apds9306_data - apds9306 private data and registers definitions
>> + *
>> + * @dev:	Pointer to the device structure
>> + * @gts:	IIO Gain Time Scale structure
>> + * @mutex:	Lock for protecting register access, adc reads and power
> 
> ADC.  I guess the double comment is to keep checkpatch happy?
> 
> Just ignore it being dumb as you have a comment up here and put all the info
> here rather than splitting it up like this.
> 
>> + * @regmap:	Regmap structure pointer
>> + * @regfield_sw_reset:	Reg: MAIN_CTRL, Field: SW_Reset
>> + * @regfield_en:	Reg: MAIN_CTRL, Field: ALS_EN
>> + * @regfield_intg_time:	Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width
>> + * @regfield_repeat_rate:	Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate
>> + * @regfield_gain:	Reg: ALS_GAIN, Field: ALS Gain Range
>> + * @regfield_int_src:	Reg: INT_CFG, Field: ALS Interrupt Source
>> + * @regfield_int_thresh_var_en:	Reg: INT_CFG, Field: ALS Var Interrupt Mode
>> + * @regfield_int_en:	Reg: INT_CFG, Field: ALS Interrupt Enable
>> + * @regfield_int_persist_val:	Reg: INT_PERSISTENCE, Field: ALS_PERSIST
>> + * @regfield_int_thresh_var_val:	Reg: ALS_THRSH_VAR, Field: ALS_THRES_VAR
>> + * @nlux_per_count:	nano lux per ADC count for a particular model
>> + * @read_data_available:	Flag set by IRQ handler for ADC data available
>> + */
>> +struct apds9306_data {
>> +	struct device *dev;
>> +	struct iio_gts gts;
>> +	/*
>> +	 * Protects device settings changes where some calculations are required
>> +	 * before or after setting or getting the raw settings values from regmap
>> +	 * writes or reads respectively.
>> +	 */
>> +	struct mutex mutex;
>> +
>> +	struct regmap *regmap;
>> +	struct regmap_field *regfield_sw_reset;
>> +	struct regmap_field *regfield_en;
>> +	struct regmap_field *regfield_intg_time;
>> +	struct regmap_field *regfield_repeat_rate;
>> +	struct regmap_field *regfield_gain;
>> +	struct regmap_field *regfield_int_src;
>> +	struct regmap_field *regfield_int_thresh_var_en;
>> +	struct regmap_field *regfield_int_en;
>> +	struct regmap_field *regfield_int_persist_val;
>> +	struct regmap_field *regfield_int_thresh_var_val;
>> +
>> +	int nlux_per_count;
>> +	int read_data_available;
>> +};
> 
>> +
>> +static struct iio_event_spec apds9306_event_spec_als[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_RISING,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	}, {
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> 
> What's the intent of this final entry?
> The type will default to IIO_EV_TYPE_THRESH anyway but if that
> the intent you should specify it.   There isn't an 'obvious'
> default for type in the same way there sort of is for dir
> (as it's either direction).
Understood, let me experiment and see the ABI difference, if any and get back to you.

> 
>> +	},
>> +};
> 
>> +
> 
>> +
>> +static int apds9306_runtime_power_on(struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0)
>> +		dev_err(dev, "runtime resume failed: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int apds9306_runtime_power_off(struct device *dev)
>> +{
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>> +
>> +	return 0;
>> +}
> 
> I'm not entirely convinced these two wrappers are worthwhile given they
> aren't that common used and locally obscure what is going on when
> it could be apparent at the few call sites.
The above was suggested by Andy.
https://lore.kernel.org/linux-devicetree/ZTuuUl0PBklbVjb9@smile.fi.intel.com/

Apologies for my ignorance - "it could be apparent at the few call sites" -
I did not understand the above statement. Can you please elaborate?
> 
> 
> 
>> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir)
>> +{
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	int int_en, int_ch, ret;
>> +
>> +	guard(mutex)(&data->mutex);
>> +
>> +	switch (type) {
>> +	case IIO_EV_TYPE_THRESH:
>> +		ret = regmap_field_read(data->regfield_int_src, &int_ch);
> 
> int_ch is a not particularly informative name.
> 
> event_ch_is_light perhaps?
> 
>> +		if (ret)
>> +			return ret;
>> +		ret = regmap_field_read(data->regfield_int_en, &int_en);
>> +		if (ret)
>> +			return ret;
>> +		if (chan->type == IIO_LIGHT)
>> +			return int_en & int_ch;
>> +		else if (chan->type == IIO_INTENSITY)
>> +			return int_en & !int_ch;
>> +		return -EINVAL;
>> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>> +		ret = regmap_field_read(data->regfield_int_thresh_var_en, &int_en);
>> +		if (ret)
>> +			return ret;
>> +		return int_en;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
>> +				       const struct iio_chan_spec *chan,
>> +				       enum iio_event_type type,
>> +				       enum iio_event_direction dir,
>> +				       int state)
>> +{
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	int ret, val;
>> +
>> +	state = !!state;
>> +
>> +	guard(mutex)(&data->mutex);
>> +
>> +	switch (type) {
>> +	case IIO_EV_TYPE_THRESH:
>> +		/*
>> +		 * If interrupt is enabled, the channel is set before enabling
>> +		 * the interrupt. In case of disable, no need to switch
>> +		 * channels. In case of different channel is selected while
>> +		 * interrupt in on, just change the channel.
>> +		 */
>> +		if (state) {
>> +			if (chan->type == IIO_LIGHT)
>> +				val = 1;
>> +			else if (chan->type == IIO_INTENSITY)
>> +				val = 0;
>> +			else
>> +				return -EINVAL;
> 
> Blank line here and similar.
> 
>> +			ret = regmap_field_write(data->regfield_int_src, val);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +		ret = regmap_field_read(data->regfield_int_en, &val);
>> +		if (ret)
>> +			return ret;
>> +		if (val == state)
>> +			return 0;
> 
> Blank line.  Basically add one whenever a block of related code ends.
> 
>> +		ret = regmap_field_write(data->regfield_int_en, state);
>> +		if (ret)
>> +			return ret;
>> +		if (state)
>> +			return apds9306_runtime_power_on(data->dev);
>> +		return apds9306_runtime_power_off(data->dev);
>> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>> +		return regmap_field_write(data->regfield_int_thresh_var_en, state);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>>
> 
> ..
> 
>> +static void apds9306_powerdown(void *ptr)
>> +{
>> +	struct apds9306_data *data = (struct apds9306_data *)ptr;
>> +	int ret;
>> +
>> +	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
>> +	if (ret)
>> +		return;
> 
> blank line here ideally.
> 
>> +	ret = regmap_field_write(data->regfield_int_en, 0);
>> +	if (ret)
>> +		return;
>> +
>> +	apds9306_power_state(data, false);
>> +}
> 
> ...
> 
>> +
>> +static int apds9306_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct apds9306_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +
>> +	mutex_init(&data->mutex);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &apds9306_regmap);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
>> +				     "regmap initialization failed\n");
>> +
>> +	data->dev = dev;
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret = apds9306_regfield_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "regfield initialization failed\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
>> +
>> +	indio_dev->name = "apds9306";
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	if (client->irq) {
>> +		indio_dev->info = &apds9306_info;
>> +		indio_dev->channels = apds9306_channels_with_events;
>> +		indio_dev->num_channels =
>> +				ARRAY_SIZE(apds9306_channels_with_events);
>> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>> +				apds9306_irq_handler, IRQF_ONESHOT,
>> +					"apds9306_event", indio_dev);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "failed to assign interrupt.\n");
>> +	} else {
>> +		indio_dev->info = &apds9306_info_no_events;
>> +		indio_dev->channels = apds9306_channels_without_events;
>> +		indio_dev->num_channels = ARRAY_SIZE(apds9306_channels_without_events);
>> +	}
>> +
>> +	ret = apds9306_pm_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed pm init\n");
>> +
>> +	ret = apds9306_device_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to init device\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to add action or reset\n");
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed iio device registration\n");
>> +
>> +	pm_runtime_put_autosuspend(dev);
> 
> Where is the matching get?  I don't recall any of the pm functions
> leaving us with the reference count raised except for the where it is
> called out in the function name.
> 
I blindly copy pasted your below suggestion.
https://lore.kernel.org/all/20231028162025.4259f1cc@jic23-huawei/

"this lot of runtime pm stuff isn't initializing the device, so I don't
see it as making sense in here. I'd push it out to the caller with
the power up before init and the autosuspend etc after.
I'll note that I'd expect to see a a pm_runtime_put_autosuspend()
at the end of probe to put device to sleep soon after loading."

> The runtime pm reference counters are protected against underflowing so this
> probably just has no impact.  Still good to only have it if necessary and if
> you do need the power to be on until this point, force it to do so by
> an appropriate pm_runtime_get().
I will use a pm_runtime_get() in the apds9306_pm_init() function above.
> 
> 
>> +
>> +	return 0;
>> +}
> 
Thank you for your review.

Regards,
Subhajit Ghosh

