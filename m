Return-Path: <linux-kernel+bounces-140605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E398A16C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD78528CF01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D51509BF;
	Thu, 11 Apr 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MlBWNr6O"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55714F9FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844481; cv=none; b=HKCABVjdSMwHTdRcRG4zTno3XvRiTBcQjkqsKQnyOEidO9JEnB7hYpB1FzPR8o5f7J14RjXyXjwv42AVer5p4BwJlgkDjFt9nWDAH4KrNNfboFb2JVhnpmVSnzm8PtFgw5YdtFqS8SexKxYLcqlTSF8Yl4sG2Jgf73A7EyIbQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844481; c=relaxed/simple;
	bh=1773So4LwIloYfhoBmfXHSLI8aFc0Pjsr/GEqoZXqI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGAX2OYABj/DA9JxOk4QXghyS/9A8W3jgc65oyHdLB2n2wgomuGwWA9deFLoeTYGilPEI1BgiF0ITO3+EwkLeKbeZE9qsXCCBNcQHo6CPkPMte2QuAp1ssdvJAggGCa6qKw0WfeRHGTCZkj3pz5KYTf5csqIZIICG1Ap1bj/aD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MlBWNr6O; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-434d0a63151so22460561cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712844476; x=1713449276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oahy6T90Z6e6EcGIq7K2uZ47rKjv7XMHMVOfbdyQeMc=;
        b=MlBWNr6ORJ0LWL0xn17QOqWFoJTte/ZUeOVe3l7lvlQHgvSfbILOaIR8VXz182yYwy
         YeuA1EZTbHKqtl6qMnvmnTbxZCzKkEzrZWa7b++ClA7Lyd8u29tBU701dgduhte0piGR
         wQd0Wx71HexBaUKn7lHLaMywI4ZCqah28VcbCHX2Rb6Kz1L7EH6hpPWsBI2BmAhwSvHm
         1jAzIvqnZ8c0ei3eShQOcoZYqZsHBczJ8OjeY6HHOz78KtPj2LZtmqxalR6p5Psqe36U
         c19edDZjCeZNZ7yNRVXaiLypaKt1N4gEbbVeGrwLV7n61culGm3l1SEwPy5e42l8d8kM
         XcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844476; x=1713449276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oahy6T90Z6e6EcGIq7K2uZ47rKjv7XMHMVOfbdyQeMc=;
        b=N1fi4fKbYnh+3tVHVmlX8iifSRcqs/yG+z9T4QFAFB48NN4Xgli5Io4Z0qbU8weGkc
         5focKoor752jZ18pwMmDmRhhS6b02gHfhTj0itCN8JafaPR42KLsyoMvP0Aagl8rFQ19
         lEFh7yTUTNsAyVHPfBOOancRgcCv1dUoswu3U9vGk64tEprjsvd01vbHj5xkHX+CMOzW
         Rn3Tt1WFWTjL1gda5JfC3W/j3DAFO+j9Nd7tPHg4JWiko8hgw6mgcbgvLB4Nmaynyhak
         UUtEDmj4KJeaSmo7enduRq/7zfvxQv03bZ9RUWTpuBEJgWGuf7DxlbFrddIsEMECHBYq
         clHA==
X-Forwarded-Encrypted: i=1; AJvYcCVZndsv2TFU0Os1nt9DIEJ0EPqa0fKDqcIocutziOWM5/zr8eDlLS23CP5W+mx/cXOzwHQQOaexRi7C/8Kim75bhmT8HDA7/TOE+TXk
X-Gm-Message-State: AOJu0YxIzPYK7reXE9DuYjbGjI5pUYNUgVIMV5swTbQtIi8JzOJCCrrB
	wb06Lj9kzaAUOrIF2ufEn/EPbHZWJP+GSl+FzqyUluu0yerD+IKN+yGS9/JCYjV/OX+b33lvj+b
	wkdo=
X-Google-Smtp-Source: AGHT+IHiU+6hJJ+BFq937sa9WOhWPVYn2b4K4Y6RuK0IETx9T0nECwhJ6x2/TRoY5V5O2HBg6gyo9w==
X-Received: by 2002:a05:622a:92:b0:436:4e4c:3bb9 with SMTP id o18-20020a05622a009200b004364e4c3bb9mr4284531qtw.38.1712844476483;
        Thu, 11 Apr 2024 07:07:56 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8490f000000b00434d86fb403sm941755qtq.86.2024.04.11.07.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 07:07:56 -0700 (PDT)
Message-ID: <f2579349-2cb0-434a-bae1-493218a62d53@baylibre.com>
Date: Thu, 11 Apr 2024 10:07:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v4] pwm: Add driver for AXI PWM generator
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dlechner@baylibre.com, Drew Fustini <dfustini@baylibre.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>
References: <20240301173343.1086332-1-tgamblin@baylibre.com>
 <20240301173343.1086332-3-tgamblin@baylibre.com>
 <zwer5e7jmrqfi3yeooandpfyhs663i3adcaxjeizmwgmfxltp3@gnpimhyoaqjf>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <zwer5e7jmrqfi3yeooandpfyhs663i3adcaxjeizmwgmfxltp3@gnpimhyoaqjf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-04-11 12:59, Uwe Kleine-König wrote:
> Hello,
Hi,
>
> On Fri, Mar 01, 2024 at 12:33:42PM -0500, Trevor Gamblin wrote:
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
>> Acked-by: Nuno Sa <nuno.sa@analog.com>
>> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>> v4 changes:
>> * Address feedback for driver in v3:
>>    * Update to use devm_pwmchip_alloc() function
>>    * Simplify use of dev symbol in axi_pwmgen_probe
>>    * Remove unnecessary axi_pwmgen_from_chip function and use
>>      pwmchip_get_drvdata directly
>>
>> v3 changes:
>> * Address feedback for driver in v2:
>>    * Remove unnecessary blank line in axi_pwmgen_apply
>>    * Use macros already defined in <linux/fpga/adi-axi-common.h> for
>>      version checking
>>
>> v2 changes:
>> * Address feedback for driver and device tree in v1:
>>    * Use more reasonable Kconfig approach
>>    * Use common prefixes for all functions
>>    * Rename axi_pwmgen struct to axi_pwmgen_ddata
>>    * Change use of "pwm" to "ddata"
>>    * Set and check state->polarity
>>    * Multiply safely with mul_u64_u64_div_u64()
>>    * Improve handling of max and zero periods
>>    * Error if clk_rate_hz > NSEC_PER_SEC
>>    * Add "Limitations" section at top of pwm-axi-pwmgen.c
>>    * Don't disable outputs by default
>>    * Remove unnecessary macros for period, duty, offset
>>    * Fix axi_pwmgen_ddata alignment
>>    * Don't artificially limit npwm to four
>>    * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
>>    * Cache clk rate in axi_pwmgen_ddata
>>    * Don't assign pwm->chip.base, do assign pwm->chip.atomic
>> * Remove redundant calls to clk_get_rate
>> * Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
>>    arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
>> * Remove redundant clk struct from axi_pwmgen_ddata
>> * Add self as module author
>> * Add major version check for IP core
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/pwm/Kconfig          |  13 ++
>>   drivers/pwm/Makefile         |   1 +
>>   drivers/pwm/pwm-axi-pwmgen.c | 244 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 259 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8a4ed5545680..2baa7a0a1c8c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3438,6 +3438,7 @@ L:	linux-pwm@vger.kernel.org
>>   S:	Supported
>>   W:	https://ez.analog.com/linux-software-drivers
>>   F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>> +F:	drivers/pwm/pwm-axi-pwmgen.c
>>   
>>   AXXIA I2C CONTROLLER
>>   M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4b956d661755..d44b0e86adee 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -98,6 +98,19 @@ config PWM_ATMEL_TCB
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-atmel-tcb.
>>   
>> +config PWM_AXI_PWMGEN
>> +	tristate "Analog Devices AXI PWM generator"
>> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
>> +	select REGMAP_MMIO
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
>> index 000000000000..0c8f7f893a21
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-axi-pwmgen.c
>> @@ -0,0 +1,244 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Analog Devices AXI PWM generator
>> + *
>> + * Copyright 2024 Analog Devices Inc.
>> + * Copyright 2024 Baylibre SAS
>> + *
>> + * Limitations:
>> + * - The writes to registers for period and duty are shadowed until
>> + *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the end of the
>> + *   current period.
> This implies that a currently running period is completed before the new
> settings get active, right?
Right.
>
>> + * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
>> + *   enabled channels, which could cause glitching on other channels. It
>> + *   is therefore expected that channels are assigned harmonic periods
>> + *   and all have a single user coordinating this.
> What does "re-synchronize" mean here? Are all counters reset to zero?
> "harmonic" means that all channels should use the same period length?
Yes, it means that all counters are reset to zero. Harmonic in this case 
means that channels can have different periods, but they should be 
integer multiples of each other. Should I rewrite the comment to be more 
explicit?
>
>> + * - Supports normal polarity. Does not support changing polarity.
> Please add an item documenting how the HW behaves on disable. (Typical
> behaviours are "freeze" or "inactive".)
Will do.
>
>> + */
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/fpga/adi-axi-common.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +#define AXI_PWMGEN_REG_CORE_VERSION	0x00
>> +#define AXI_PWMGEN_REG_ID		0x04
>> +#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
>> +#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
>> +#define AXI_PWMGEN_REG_CONFIG		0x10
>> +#define AXI_PWMGEN_REG_NPWM		0x14
>> +#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
>> +#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
>> +#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))
> Reading https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen I would
> have expected:
>
> 	/* ch in { 0, ... 15 } */
> 	#define AXI_PWMGEN_REG_PULSE_X_PERIOD(ch)	(0x40 + 4 * (ch))
> 	#define AXI_PWMGEN_REG_PULSE_X_WIDTH(ch)	(0x80 + 4 * (ch))
> 	#define AXI_PWMGEN_REG_PULSE_X_OFFSET		(0xc0 + 4 * (ch))

The regmap you find there now reflects v2 of the pwmgen IP; v1 used a 
step of 12 instead of 4. The v2 series sent a little bit later on adds 
this extra support: 
https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamblin@baylibre.com/

I've added support for both versions since v1 of the IP could still be 
in use on some devices. Would it be better to have the two patch series 
squashed together into a v5 of the axi-pwmgen driver?

>
>> +#define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
>> +#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
>> +#define AXI_PWMGEN_RESET		BIT(0)
> I'm a fan of including the register name in bitfield definitions. So
> maybe:
>
> 	#define AXI_PWMGEN_REG_CONFIG_RESET	BIT(0)
Will do.
>
>> +struct axi_pwmgen_ddata {
>> +	struct regmap *regmap;
>> +	unsigned long clk_rate_hz;
>> +};
>> +
>> +static const struct regmap_config axi_pwmgen_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +};
>> +
>> +static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			    const struct pwm_state *state)
>> +{
>> +	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
>> +	unsigned int ch = pwm->hwpwm;
>> +	struct regmap *regmap = ddata->regmap;
>> +	u64 period_cnt, duty_cnt;
>> +	int ret;
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> +		return -EINVAL;
>> +
>> +	if (state->enabled) {
>> +		period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
>> +		if (period_cnt > UINT_MAX)
>> +			period_cnt = UINT_MAX;
>> +
>> +		if (period_cnt == 0)
>> +			return -EINVAL;
>> +
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
>> +		if (ret)
>> +			return ret;
>> +
>> +		duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
>> +		if (duty_cnt > UINT_MAX)
>> +			duty_cnt = UINT_MAX;
>> +
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
>> +}
>> +
>> +static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				struct pwm_state *state)
>> +{
>> +	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
>> +	struct regmap *regmap = ddata->regmap;
>> +	unsigned int ch = pwm->hwpwm;
>> +	u32 cnt;
>> +	int ret;
>> +
>> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	state->enabled = cnt != 0;
>> +
>> +	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
>> +
>> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
>> +
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops axi_pwmgen_pwm_ops = {
>> +	.apply = axi_pwmgen_apply,
>> +	.get_state = axi_pwmgen_get_state,
>> +};
>> +
>> +static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_MAGIC, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val != AXI_PWMGEN_REG_CORE_MAGIC_VAL)
>> +		return dev_err_probe(dev, -ENODEV,
>> +			"failed to read expected value from register: got %08x, expected %08x\n",
>> +			val,
>> +			AXI_PWMGEN_REG_CORE_MAGIC_VAL);
>> +
>> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_VERSION, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (ADI_AXI_PCORE_VER_MAJOR(val) != 1) {
>> +		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
>> +			ADI_AXI_PCORE_VER_MAJOR(val),
>> +			ADI_AXI_PCORE_VER_MINOR(val),
>> +			ADI_AXI_PCORE_VER_PATCH(val));
>> +	}
>> +
>> +	/* Enable the core */
>> +	ret = regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_RESET, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Return the number of PWMs */
>> +	return val;
>> +}
>> +
>> +static void axi_pwmgen_clk_rate_exclusive_put(void *data)
>> +{
>> +	clk_rate_exclusive_put(data);
>> +}
>> +
>> +static int axi_pwmgen_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct regmap *regmap;
>> +	struct pwm_chip *chip;
>> +	struct axi_pwmgen_ddata *ddata;
>> +	struct clk *clk;
>> +	void __iomem *io_base;
>> +	int ret;
>> +
>> +	io_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>> +
>> +	regmap = devm_regmap_init_mmio(dev, io_base, &axi_pwmgen_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap),
>> +				     "failed to init register map\n");
>> +
>> +	ret = axi_pwmgen_setup(regmap, dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	chip = devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +	ddata = pwmchip_get_drvdata(chip);
>> +	ddata->regmap = regmap;
>> +
>> +	clk = devm_clk_get_enabled(dev, NULL);
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
>> +
>> +	ret = clk_rate_exclusive_get(clk);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, axi_pwmgen_clk_rate_exclusive_put, clk);
>> +	if (ret)
>> +		return ret;
> There is a devm variant of clk_rate_exclusive_get() in the meantime.
Okay, I'll try using that.
>
>> +	ddata->clk_rate_hz = clk_get_rate(clk);
>> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
>> +
>> +	chip->ops = &axi_pwmgen_pwm_ops;
>> +	chip->atomic = true;
>> +
>> +	return devm_pwmchip_add(dev, chip);
> Error message in case devm_pwmchip_add fails, please.

Will do.

Thanks!

>
>> +}

