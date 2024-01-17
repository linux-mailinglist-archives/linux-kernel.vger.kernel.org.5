Return-Path: <linux-kernel+bounces-28986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F1C830605
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518771C2230A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853A1EA7E;
	Wed, 17 Jan 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vV9OtZUr"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11B1DFFD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495892; cv=none; b=OvYdMxpNZ8boBW1LDZmKXI7tXg30diQbhesJxIZp+TNbc+G+Sr4QPUo6dtUJkxUYkdI25Ayk9kHQUkPE59MsohzTitqiXEAkt4vlycv1AbHXO4W4D6M73YaLtLkYQr8+w4IbwpI2pPhlAZ43Yr8Vbv1OMy0jJG/T29B843svXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495892; c=relaxed/simple;
	bh=St3Z/kw6cJnFDVGylMzuFV0mluiCY7evkTV4HtGezhQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=UeLkxT6K0KjH0w/Mu5yULd1lyrNzH7CRKWA7KontJYg2NywdBJBP+eF/XivJX21wdj6t/H8as96wLwZccI/XbsjceVrwLtU8XOJgga9JKfx5ywIQJDeDmu9RIoSREeTxYi4oPet8mDfW2cqR6ifYHEYX6oIfuRUVOv+IL9BMMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vV9OtZUr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-429c9c4c572so36407781cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 04:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705495888; x=1706100688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbhitSRWJTy3R5qEGWrKyL5/UYX6dud/VfUqn6JgH6M=;
        b=vV9OtZUrPPVW9mhBbVOKLNxc8/B10ueBWnJNj3q6px8Lozg5PC6AX2sfxK6X1x7bAU
         4K9g6zIt7SzB4PjbefShKb2o+XAyLLhmElOmVo0aTCGWt8YjNqf7Aak+Taa7Hm2qSMb/
         vbTzqxybEyvc3/x7ybdDWNrYvdICK7CFggQLmlhastiO87Za887rDgy1+qXtgYZ38yoN
         b3pv4HfBaPkAOC+R1bM9lH0SOqlNmI8pwT42pHzOp0xvrAXh7y0l8YyydLs0XT5+KxAy
         7g4lIPFwV/PCuDw+D2XrFE/YVCEfutVxBvWWPZM/jAFODDt+koRmCO5EL4uk6gUp86ZP
         +CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495888; x=1706100688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbhitSRWJTy3R5qEGWrKyL5/UYX6dud/VfUqn6JgH6M=;
        b=e08/tDexzwtoRAvVgidJKikpvn1YIoUcu9RRftO01s7ssvtOQGHXqj/DDPzfwcN3Yj
         yH7c+PEu30wFD48ggatPz5GiNHNRvqf9XEsGBONC0uk05pQ0C/4dcjQi2VWt2diisDDx
         zglhBjf0NIRSyuhUfC4KaugX864bVRRT+F0iEzTQIRW3KJybOpFwn+eefrZvAX5qb9kS
         U95cy37+Ikzehvw8Tb+qHYlmJRWoeJO1uchgGSY+R90kF388LapYpoAdMnHuB+LYbRVA
         Dp/Wfbj8NQfvL6CzIuk3uzbX9Pjf6XyxdorY8MtD7GmpjXDe2VxFzK4dZE6LFRnQrXlQ
         4x1A==
X-Gm-Message-State: AOJu0YyW53itKPOeP5I+K/0DrS39SaYwa/MN8vpNkS3c4FN7WmDOzywy
	EREcMkb/sgO2SFKAlnde2BgzEEoZhzolKQ==
X-Google-Smtp-Source: AGHT+IEeWsuwfXwh+3HoWh3GBCGTS2lq37xxT/85A/ffizSnArVvOc+1roEQij7ctzi+ETf/fTKafA==
X-Received: by 2002:ac8:7e92:0:b0:429:c765:b327 with SMTP id w18-20020ac87e92000000b00429c765b327mr11377765qtj.102.1705495888255;
        Wed, 17 Jan 2024 04:51:28 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id t26-20020ac86a1a000000b00419732075b4sm5758900qtr.84.2024.01.17.04.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 04:51:27 -0800 (PST)
Message-ID: <e6fbf553-f2f8-47ea-8781-cf01d37196a5@baylibre.com>
Date: Wed, 17 Jan 2024 07:51:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: Add driver for AXI PWM generator
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
References: <20240115201222.1423626-1-tgamblin@baylibre.com>
 <20240115201222.1423626-3-tgamblin@baylibre.com>
 <gbessnmierg5gvdguhwauoe2mxr3krwcfk2afhazrqvz45md64@itbchezepncg>
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <gbessnmierg5gvdguhwauoe2mxr3krwcfk2afhazrqvz45md64@itbchezepncg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Responses inline - I'll have another series with all fixes submitted soon.

On 2024-01-15 16:18, Uwe Kleine-König wrote:
> Hello,
>
> On Mon, Jan 15, 2024 at 03:12:21PM -0500, Trevor Gamblin wrote:
>> From: Drew Fustini <dfustini@baylibre.com>
>>
>> Add support for the Analog Devices AXI PWM Generator. This device is an
>> FPGA-implemented peripheral used as PWM signal generator and can be
>> interfaced with AXI4. The register map of this peripheral makes it
>> possible to configure the period and duty cycle of the output signal.
>>
>> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
>> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>> Co-developed-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
>> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/pwm/Kconfig          |  12 ++
>>   drivers/pwm/Makefile         |   1 +
>>   drivers/pwm/pwm-axi-pwmgen.c | 229 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 243 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7b0f3aec5381..3abe90dec82e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3422,6 +3422,7 @@ L:	linux-pwm@vger.kernel.org
>>   S:	Supported
>>   W:	https://ez.analog.com/linux-software-drivers
>>   F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>> +F:	drivers/pwm/pwm-axi-pwmgen.c
>>   
>>   AXXIA I2C CONTROLLER
>>   M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4b956d661755..b105c0db4936 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -98,6 +98,18 @@ config PWM_ATMEL_TCB
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-atmel-tcb.
>>   
>> +config PWM_AXI_PWMGEN
>> +	tristate "Analog Devices AXI PWM generator"
>> +	select REGMAP_MMIO
> Assuming you won't find the device on all machines, can you please add a
> reasonable dependency to not annoy users?
Will do.
>
>> +	help
>> +	  This enables support for the Analog Devices AXI PWM generator.
>> +
>> +	  This is a configurable PWM generator with variable pulse width and
>> +	  period.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called pwm-axi-pwmgen.
>> +
>>   config PWM_BCM_IPROC
>>   	tristate "iProc PWM support"
>>   	depends on ARCH_BCM_IPROC || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index c5ec9e168ee7..8322089954e9 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
>>   obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
>>   obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
>>   obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
>> +obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
>>   obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
>>   obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
>>   obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
>> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
>> new file mode 100644
>> index 000000000000..5e91636b88b4
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-axi-pwmgen.c
>> @@ -0,0 +1,229 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Analog Devices AXI PWM generator
>> + *
>> + * Copyright 2024 Analog Devices Inc.
>> + * Copyright 2024 Baylibre SAS
>> + */
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +#define AXI_PWMGEN_NPWM			4
>> +#define AXI_PWMGEN_REG_CORE_VERSION	0x00
>> +#define AXI_PWMGEN_REG_ID		0x04
>> +#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
>> +#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
>> +#define AXI_PWMGEN_REG_CONFIG		0x10
>> +#define AXI_PWMGEN_REG_NPWM		0x14
>> +#define AXI_PWMGEN_CH_PERIOD_BASE	0x40
>> +#define AXI_PWMGEN_CH_DUTY_BASE		0x44
>> +#define AXI_PWMGEN_CH_OFFSET_BASE	0x48
>> +#define AXI_PWMGEN_CHX_PERIOD(ch)	(AXI_PWMGEN_CH_PERIOD_BASE + (12 * (ch)))
>> +#define AXI_PWMGEN_CHX_DUTY(ch)		(AXI_PWMGEN_CH_DUTY_BASE + (12 * (ch)))
>> +#define AXI_PWMGEN_CHX_OFFSET(ch)	(AXI_PWMGEN_CH_OFFSET_BASE + (12 * (ch)))
> I'd drop the name AXI_PWMGEN_CH_PERIOD_BASE and just hard code it in the
> definition of AXI_PWMGEN_CHX_PERIOD. Ditto for the two other macros.
>
>> +#define AXI_PWMGEN_TEST_DATA		0x5A0F0081
> Is this a documented constant, or just a random (as in xkcd#221) value?
This is just a random (as in xkcd#221) value to write to the scratch 
register.
>
>> +#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
>> +#define AXI_PWMGEN_RESET		BIT(0)
>> +#define AXI_PWMGEN_MAX_REGISTER		0x6C
>> +
>> +struct axi_pwmgen {
>> +	struct pwm_chip		chip;
>> +	struct clk		*clk;
>> +	struct regmap		*regmap;
>> +
>> +	/* Used to store the period when the channel is disabled */
>> +	unsigned int		ch_period[AXI_PWMGEN_NPWM];
>> +	bool			ch_enabled[AXI_PWMGEN_NPWM];
>> +};
> I'm not a fan of this alignment. If you don't have a strong opinion here
> please just use a single space here. (I would expect you to not have a
> strong opinion as other structs in this driver are not aligned in this
> way.)
>
>> +
>> +static const struct regmap_config axi_pwm_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.max_register = AXI_PWMGEN_MAX_REGISTER,
>> +};
>> +
>> +static struct axi_pwmgen *to_axi_pwmgen(struct pwm_chip *chip)
> I'm a big fan of common symbol prefixes. I suggest to rename
> axi_pwm_regmap_config to axi_pwmgen_regmap_config and to_axi_pwmgen to
> axi_pwmgen_from_chip.
>
>> +{
>> +	return container_of(chip, struct axi_pwmgen, chip);
>> +}
>> +
>> +static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *device,
>> +			    const struct pwm_state *state)
>> +{
>> +	struct axi_pwmgen *pwm = to_axi_pwmgen(chip);
> Please pick a different name. "pwm" is reserved for pwm_device
> variables. (And please use it for these.) A typical name would be
> "ddata", or "pc" or "apg". (Maybe also rename axi_pwmgen to
> axi_pwmgen_ddata?)
>
>> +	unsigned long clk_rate_hz = clk_get_rate(pwm->clk);
>> +	unsigned int ch = device->hwpwm;
>> +	struct regmap *regmap = pwm->regmap;
>> +	u64 period_cnt, duty_cnt;
>> +	int ret;
> You didn't check for state->polarity. You should however. Also
> .get_state() needs to assign that one.
>
>> +	if (!clk_rate_hz)
>> +		return -EINVAL;
>> +
>> +	period_cnt = DIV_ROUND_UP_ULL(state->period * clk_rate_hz, NSEC_PER_SEC);
> The multiplication might overflow. Please use mul_u64_u64_div_u64() (or
> one of its variant) and error out on clk_rate_hz > NSEC_PER_SEC.
>
> Also round-up is wrong. I would expect that enabling PWM_DEBUG and
> enough testing should tell you that. .apply is supposed to implement the
> biggest period not bigger than the requested one. So you have to round
> down here.
To be clear, I should use mul_u64_u64_div_u64 only, or should I round 
down afterwards with another function as well?
>
>> +	if (period_cnt > UINT_MAX)
>> +		return -EINVAL;
> That's wrong. Please continue with period_cnd = UINT_MAX here.
>
> Instead you should probably error out on period_cnt == 0.
>
>> +	pwm->ch_period[ch] = period_cnt;
>> +	pwm->ch_enabled[ch] = state->enabled;
>> +	ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), state->enabled ? period_cnt : 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	duty_cnt = DIV_ROUND_UP_ULL(state->duty_cycle * clk_rate_hz, NSEC_PER_SEC);
>> +	ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
> I assume this means that the writes above are to shadow registers and on
> this write they are latched into the hardware. So there is no glitch?!
>
> Does this wait for the currently running period to complete before
> switching to the new configuration?
>
> Please document these two hardware properties in a "Limitations"
> paragraph at the top of the driver. See other drivers for the format.

The registers are shadow registers and changes don't take effect right 
away. It also keeps the phase offset in sync between outputs.

>
>> +}
>> +
>> +static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *device,
>> +				struct pwm_state *state)
>> +{
>> +	struct axi_pwmgen *pwm = to_axi_pwmgen(chip);
>> +	unsigned long clk_rate_hz = clk_get_rate(pwm->clk);
>> +	struct regmap *regmap = pwm->regmap;
>> +	unsigned int ch = device->hwpwm;
>> +	u32 cnt;
>> +	int ret;
>> +
>> +	if (!clk_rate_hz) {
>> +		dev_err(device->chip->dev, "axi pwm clock has no frequency\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	state->enabled = pwm->ch_enabled[ch];
>> +
>> +	if (state->enabled) {
>> +		ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		cnt = pwm->ch_period[ch];
>> +	}
> If state->enabled is false, state->period is (or should) be ignored by
> the caller, so there shouldn't be a need to track ch_period.
>
> Also ch_enabled shouldn't be needed. Just reporting
> AXI_PWMGEN_CHX_PERIOD(ch) == 0 as disabled should work fine?!
>
> I think then you also don't need to artificially limit npwm to four.
The only concern I have with not tracking ch_period is that it might not 
be clear what period to restore after disabling and re-enabling the 
device, unless I'm missing something.
>
>> +	state->period = DIV_ROUND_CLOSEST_ULL((u64)cnt * NSEC_PER_SEC, clk_rate_hz);
> As feeding the result for .get_state() to .apply() should not modify the
> hardware state, you have to round up here.
>
>> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)cnt * NSEC_PER_SEC, clk_rate_hz);
> ditto.
>
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops axi_pwmgen_pwm_ops = {
>> +	.apply = axi_pwmgen_apply,
>> +	.get_state = axi_pwmgen_get_state,
>> +};
>> +
>> +static int axi_pwmgen_setup(struct axi_pwmgen *pwm, struct device *dev)
>> +{
>> +	struct regmap *regmap = pwm->regmap;
>> +	int idx;
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = regmap_write(regmap, AXI_PWMGEN_REG_SCRATCHPAD, AXI_PWMGEN_TEST_DATA);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_SCRATCHPAD, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val != AXI_PWMGEN_TEST_DATA)
>> +		return dev_err_probe(dev, -EIO, "failed to access the device registers\n");
>> +
>> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &pwm->chip.npwm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (pwm->chip.npwm > AXI_PWMGEN_NPWM) {
>> +		dev_warn(dev, "driver is limited to %d channels but hardware reported %u\n",
>> +				AXI_PWMGEN_NPWM, pwm->chip.npwm);
>> +		pwm->chip.npwm = AXI_PWMGEN_NPWM;
>> +	}
>> +
>> +	/* Disable all the outputs */
> Please don't. If the bootloader setup a splash screen, loading the pwm
> driver shouldn't disable the backlight. So please don't touch the
> configuration in .probe().
Thank you for the catch.
>
>> +	for (idx = 0; idx < pwm->chip.npwm; idx++) {
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(idx), 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(idx), 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(idx), 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Enable the core */
>> +	return regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_RESET, 0);
>> +}
>> +
>> +static int axi_pwmgen_probe(struct platform_device *pdev)
>> +{
>> +	struct axi_pwmgen *pwm;
>> +	void __iomem *io_base;
>> +	int ret;
>> +
>> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +
>> +	io_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>> +
>> +	pwm->regmap = devm_regmap_init_mmio(&pdev->dev, io_base, &axi_pwm_regmap_config);
>> +	if (IS_ERR(pwm->regmap))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->regmap),
>> +				     "failed to init register map\n");
>> +
>> +	pwm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>> +	if (IS_ERR(pwm->clk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk), "failed to get clock\n");
> Please call clk_rate_exclusive_get() on pwm->clk and cache the rate in
> struct axi_pwmgen.
>
>> +	pwm->chip.dev = &pdev->dev;
>> +	pwm->chip.ops = &axi_pwmgen_pwm_ops;
>> +	pwm->chip.base = -1;
> Don't assign .base.
Alright. I will set pwm->chip.atomic as per Sean's comment as well.
>
>> +
>> +	ret = axi_pwmgen_setup(pwm, &pdev->dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
>> +}
>> +
>> +static const struct of_device_id axi_pwmgen_ids[] = {
>> +	{ .compatible = "adi,axi-pwmgen-1.00.a" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);
>> +
>> +static struct platform_driver axi_pwmgen_driver = {
>> +	.driver = {
>> +		.name = "axi-pwmgen",
>> +		.of_match_table = axi_pwmgen_ids,
>> +	},
>> +	.probe = axi_pwmgen_probe,
>> +};
>> +
> Drop this empty line.
>
>> +module_platform_driver(axi_pwmgen_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
>> +MODULE_DESCRIPTION("Driver for the Analog Devices AXI PWM generator");
> Best regards
> Uwe
>

