Return-Path: <linux-kernel+bounces-44892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B382584289D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A544289A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26586ADC;
	Tue, 30 Jan 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ek59rirI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE586AE7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630480; cv=none; b=Ttx1IqgJ2XwcSHN4TnbTW9H/zOP0J2WPsLou4PTa53zAvTJtd1h1EjzVHxaaXzAY1D/pjYRHc3bgfJHwOZ2M8XsI+mbzusFRHwREMUnsP+Ceg765a3+I2iv020qIUIG/dbN0hssqRa2tZ1i3rQNLFAcd2VBASAcZz4q7DTQdZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630480; c=relaxed/simple;
	bh=fhjvj10L24GI7DWn8Jn75W5gJHmPbfjXordGT7jmw48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceU2zd/opgqq9hrMTfOgyc4cOW94g4KLIj0KiHiK0PBqGWwqjNtT+3+gvypmD/AnmEBgGZq+wbvB+w1vF4MujP6Prsq4tW2fJeKmqRouIwlFpmXOlvlqXUUmQzpSl2RvhibcikAiTR/WXSFWNmFT1S4UDOyXbKN78KyOe82Ok0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ek59rirI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf1288097aso55116881fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706630476; x=1707235276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7h3bqjiOVUfSqLhQW81x9xIsTSFjeMoOE/75i+emKIc=;
        b=Ek59rirI7ZXAdu7WnxF5G9WViAg59FER7k2LYaWi12BIljpq5GE0pyTxlKIrNya+0v
         QzeV5kv3n8ynMN2HPRBE4MbMlVfBgDI1aH0eZPbrp5dWfqqWbU6q22mE3flst91YXh+c
         f0ylgHbhdrFsnzm44mgQlY2+kBcEI3962QXfaeTF/+vpacWDzBbuYufdX+rYBvknAOA2
         agh2FX2wJjjD3PrRZonm3ANkL3HkYuq1rhOgNgCvRM1/UztIPSQ6rYULgH+61XJ03987
         HJ1XKpNP8ekwF3Vh6+PKy4wkGNUpppNvunOeU6UzxJ3R5eR+LGQIq24LCOhuBh0GT2YQ
         vKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630476; x=1707235276;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7h3bqjiOVUfSqLhQW81x9xIsTSFjeMoOE/75i+emKIc=;
        b=Y9zYWgW7EmWrwBMhMnKDQuoivc2j4y0vZeMi19PFpMNKr80gcrE2Vhb5kgPhy4C5m2
         c6DoWIbtrtRjUA6wxwZL8QO1Cp1sH6biHF3T13LVESp1TvKjrbC7h/ItVMpVYFCFj3B2
         uOo3Wn7gEJ5kJxL7aluDJtPn9TKbTtUx8/H9SJo3YS21BfSMELvQop5M1n9GCeXWiJIK
         Kea3g3FVAvvQTmGw6W4qCiM9RQzSl/5H7vN510/3fgaJRTeqvkbHud9i5mNFus+IyU18
         y/NjELLoDouV0w/xneErDd9umDF23sePj8oY3aYhctsfx6lM7O6t3JipVE3+vKcATIF4
         M3nA==
X-Gm-Message-State: AOJu0Yw/rLqFcRLc0K20AoU5F/IVIjpN+jQtbxkYgAl3OrPHVh5Bfy1C
	PYNeBE6oplRf1on75ImQBGOhBTgN1Kstb52vYx/5QlQ2/2xl00OPdbyCZnHdujQ=
X-Google-Smtp-Source: AGHT+IFUKRKvbpdR24Z6SudAte0J7ejBMsaEcVIXka6ZQ4yZZgiCftGJUAVrYXVf7YKCYkcp1ylMHA==
X-Received: by 2002:a2e:b8d1:0:b0:2cf:334f:a7f9 with SMTP id s17-20020a2eb8d1000000b002cf334fa7f9mr8024318ljp.27.1706630476287;
        Tue, 30 Jan 2024 08:01:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV257u3fFRiDcWVH/FDEhbKjw8Vj9QzNhrYNV+Ku3OhCtzrEbjmq7p2Tucufpvk4Ghj10neha7S5fqEg0ktwVE3aGyWin7r/XkeNYYKLPqOBvZvM6UuwtwkiP2y6fvLKxLdq6B9O/MhnfB9fQsGQlVJEyG8ghS1b3jmV5YaDiOWCNpGnpFcMeVbu3m5q81IZnhXCQHrTeGoOnwycA/XJdYvZokwXsVQJMEBtAOqA7KJBs8G+AOuv/RvAC+csnR2dhdAI3pM3mOKTQSpg3McoXJ8ZJlU0KVzpjYdKKto+LiDTA4S0v0I3rdDNCTJUjs/kJ5/Bx2uP78hvJILBPWR5BqyS/wVLkVGsflPf1QZhHLh+Wznjp9WDFqXqVxweAK01SpOaV/UjIDyCrXmJEd3rhhyluIjWfT7mSTEzNaHm61AmDxZ8gc+ZAQR3ggWe0zuz8vaH8IruVM4MJ0gymqUQHmwz6FvnVCMEN0DFgHE7k7yFBxzlBA8KtUaz1LHCzJCF9W3c/Hfo8D2mFy6BUMs5XexXJrUuRFgUEf6BL5de11spxM9jEaXy9uzYhOtk+Mib4n3Wgvq92jt9iA0j22CfMeETN4hbE1BqWISmLZj4UK7N1SYSA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7dacd000000b0055eb8830906sm3858929eds.85.2024.01.30.08.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:01:15 -0800 (PST)
Message-ID: <fb530eb8-e32b-4faf-81f3-efc334ebf241@linaro.org>
Date: Tue, 30 Jan 2024 17:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
 linux@roeck-us.net, wim@linux-watchdog.org, alim.akhtar@samsung.com,
 jaewon02.kim@samsung.com, semen.protsenko@linaro.org
Cc: kernel-team@android.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240129211912.3068411-1-peter.griffin@linaro.org>
 <20240129211912.3068411-2-peter.griffin@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129211912.3068411-2-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 22:19, Peter Griffin wrote:
> Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> security hardening reasons so that they are only accessible in el3 via an
> SMC call.
> 
> As most Exynos drivers that need to write PMU registers currently obtain a
> regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
> is implemented in this driver using a custom regmap similar to syscon to
> handle the SMC call. Platforms that don't secure PMU registers, get a mmio
> regmap like before. As regmaps abstract out the underlying register access
> changes to the leaf drivers are minimal.
> 
> A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> that currently use syscon_regmap_lookup_by_phandle(). This also handles
> deferred probing.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c       | 227 ++++++++++++++++++++++++-
>  include/linux/soc/samsung/exynos-pmu.h |  10 ++
>  2 files changed, 236 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 250537d7cfd6..7bcc144e53a2 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -5,6 +5,7 @@
>  //
>  // Exynos - CPU PMU(Power Management Unit) support
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/mfd/core.h>
> @@ -12,20 +13,159 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>  #include <linux/soc/samsung/exynos-pmu.h>
>  
>  #include "exynos-pmu.h"
>  
> +static struct platform_driver exynos_pmu_driver;

I don't understand why do you need it. You can have only one
pmu_context. The moment you probe second one, previous becomes invalid.

I guess you want to parse phandle and check if just in case if it points
to the right device, but still the original code is not ready for two
PMU devices. I say either this problem should be solved entirely,
allowing two devices, or just compare device node from phandle with
device node of exynos_pmu_context->dev and return -EINVAL on mismatches.

Anyway, keep all file scope declarations together.


> +
> +#define PMUALIVE_MASK GENMASK(14, 0)
> +
>  struct exynos_pmu_context {
>  	struct device *dev;
>  	const struct exynos_pmu_data *pmu_data;
> +	struct regmap *pmureg;
>  };
>  
>  void __iomem *pmu_base_addr;
>  static struct exynos_pmu_context *pmu_context;
>  
> +/*
> + * Tensor SoCs are configured so that PMU_ALIVE registers can only be written
> + * from el3. As Linux needs to write some of these registers, the following
> + * SMC register read/write/read,write,modify interface is used.
> + *
> + * Note: This SMC interface is known to be implemented on gs101 and derivative
> + * SoCs.
> + */
> +#define TENSOR_SMC_PMU_SEC_REG			(0x82000504)
> +#define TENSOR_PMUREG_READ			0
> +#define TENSOR_PMUREG_WRITE			1
> +#define TENSOR_PMUREG_RMW			2
> +
> +/**
> + * tensor_sec_reg_write
> + * Write to a protected SMC register.
> + * @base: Base address of PMU
> + * @reg:  Address offset of register
> + * @val:  Value to write
> + * Return: (0) on success
> + *

This does not really look like kerneldoc...

> + */
> +static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned int val)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long pmu_base = (unsigned long)base;
> +
> +	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> +		      pmu_base + reg,
> +		      TENSOR_PMUREG_WRITE,
> +		      val, 0, 0, 0, 0, &res);
> +
> +	if (res.a0)
> +		pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> +
> +	return (int)res.a0;
> +}
> +
> +/**
> + * tensor_sec_reg_rmw
> + * Read/Modify/Write to a protected SMC register.
> + * @base: Base address of PMU
> + * @reg:  Address offset of register
> + * @val:  Value to write
> + * Return: (0) on success
> + *
> + */
> +static int tensor_sec_reg_rmw(void *base, unsigned int reg,
> +			      unsigned int mask, unsigned int val)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long pmu_base = (unsigned long)base;
> +
> +	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> +		      pmu_base + reg,
> +		      TENSOR_PMUREG_RMW,
> +		      mask, val, 0, 0, 0, &res);
> +
> +	if (res.a0)
> +		pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> +
> +	return (int)res.a0;
> +}
> +
> +/**
> + * tensor_sec_reg_read
> + * Read a protected SMC register.
> + * @base: Base address of PMU
> + * @reg:  Address offset of register
> + * @val:  Value read
> + * Return: (0) on success
> + */
> +static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned int *val)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long pmu_base = (unsigned long)base;
> +
> +	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> +		      pmu_base + reg,
> +		      TENSOR_PMUREG_READ,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	*val = (unsigned int)res.a0;
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * For SoCs that have set/clear bit hardware this function
> + * can be used when the PMU register will be accessed by
> + * multiple masters.
> + *
> + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> + * tensor_set_bit_atomic(0x3e80, 0x3f00, 0x3f00);
> + *
> + * To clear bits 13:8 in PMU offset 0x3e80
> + * tensor_set_bit_atomic(0x3e80, 0x0, 0x3f00);
> + */
> +static inline void tensor_set_bit_atomic(void *ctx, unsigned int offset,
> +					 u32 val, u32 mask)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < 32; i++) {
> +		if (mask & BIT(i)) {
> +			if (val & BIT(i)) {
> +				offset |= 0xc000;
> +				tensor_sec_reg_write(ctx, offset, i);
> +			} else {
> +				offset |= 0x8000;
> +				tensor_sec_reg_write(ctx, offset, i);
> +			}
> +		}
> +	}
> +}
> +
> +int tensor_sec_update_bits(void *ctx, unsigned int reg, unsigned int mask, unsigned int val)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
> +	 * as the target registers can be accessed by multiple masters.
> +	 */
> +	if (reg > PMUALIVE_MASK)
> +		return tensor_sec_reg_rmw(ctx, reg, mask, val);
> +
> +	tensor_set_bit_atomic(ctx, reg, val, mask);
> +
> +	return ret;
> +}
> +
>  void pmu_raw_writel(u32 val, u32 offset)
>  {
>  	writel_relaxed(val, pmu_base_addr + offset);
> @@ -80,6 +220,8 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>   */
>  static const struct of_device_id exynos_pmu_of_device_ids[] = {
>  	{
> +		.compatible = "google,gs101-pmu",
> +	}, {
>  		.compatible = "samsung,exynos3250-pmu",
>  		.data = exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
>  	}, {
> @@ -113,19 +255,73 @@ static const struct mfd_cell exynos_pmu_devs[] = {
>  	{ .name = "exynos-clkout", },
>  };
>  
> +/**
> + * exynos_get_pmu_regmap
> + * Find the pmureg previously configured in probe() and return regmap property.
> + * Return: regmap if found or error if not found.
> + */
>  struct regmap *exynos_get_pmu_regmap(void)
>  {
>  	struct device_node *np = of_find_matching_node(NULL,
>  						      exynos_pmu_of_device_ids);
>  	if (np)
> -		return syscon_node_to_regmap(np);
> +		return exynos_get_pmu_regmap_by_phandle(np, NULL);
>  	return ERR_PTR(-ENODEV);
>  }
>  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
>  
> +/**
> + * exynos_get_pmu_regmap_by_phandle
> + * Find the pmureg previously configured in probe() and return regmap property.
> + * Return: regmap if found or error if not found.

Return is the last. This does not look tested - make htmldocs, make W=1

> + *
> + * @np: Pointer to device's Device Tree node
> + * @property: Device Tree property name which references the pmu
> + */
> +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +						const char *property)
> +{
> +	struct device *dev;
> +	struct exynos_pmu_context *ctx;
> +	struct device_node *pmu_np;
> +
> +	if (property)
> +		pmu_np = of_parse_phandle(np, property, 0);
> +	else
> +		pmu_np = np;
> +
> +	if (!pmu_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	dev = driver_find_device_by_of_node(&exynos_pmu_driver.driver,
> +					    (void *)pmu_np);
> +	of_node_put(pmu_np);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	ctx = dev_get_drvdata(dev);
> +
> +	return ctx->pmureg;
> +}
> +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> +
> +static struct regmap_config pmu_regs_regmap_cfg = {
> +	.name = "pmu_regs",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
> +
>  static int exynos_pmu_probe(struct platform_device *pdev)
>  {
> +	struct resource *res;
> +	struct regmap *regmap;
> +	struct regmap_config pmuregmap_config = pmu_regs_regmap_cfg;
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;

Please do not mix order declarations with and without initializations. I
propose first ones with initializations, followed by ones without.

>  	int ret;
>  
>  	pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
> @@ -137,6 +333,35 @@ static int exynos_pmu_probe(struct platform_device *pdev)
>  			GFP_KERNEL);
>  	if (!pmu_context)
>  		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	pmuregmap_config.max_register = resource_size(res) -
> +				     pmuregmap_config.reg_stride;
> +
> +	if (of_device_is_compatible(np, "google,gs101-pmu")) {

No compatibles inside the probe. Use driver match data. This applies to
all drivers in all subsystems.

> +		pmuregmap_config.reg_read = tensor_sec_reg_read;
> +		pmuregmap_config.reg_write = tensor_sec_reg_write;
> +		pmuregmap_config.reg_update_bits = tensor_sec_update_bits;

No, regmap_config should be const and please use match data.

> +
> +		/* Need physical address for SMC call */
> +		regmap = devm_regmap_init(dev, NULL,
> +					  (void *)(uintptr_t)res->start,
> +					  &pmuregmap_config);
> +	} else {
> +		pmuregmap_config.max_register = resource_size(res) - 4;
> +		regmap = devm_regmap_init_mmio(dev, pmu_base_addr,
> +					       &pmuregmap_config);
> +	}
> +
> +	if (IS_ERR(regmap)) {
> +		pr_err("regmap init failed\n");

dev_err

> +		return PTR_ERR(regmap);
> +	}
> +
> +	pmu_context->pmureg = regmap;
>  	pmu_context->dev = dev;
>  	pmu_context->pmu_data = of_device_get_match_data(dev);
>  
> diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
> index a4f5516cc956..68fb01ba6bef 100644
> --- a/include/linux/soc/samsung/exynos-pmu.h
> +++ b/include/linux/soc/samsung/exynos-pmu.h
> @@ -21,11 +21,21 @@ enum sys_powerdown {
>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
>  #ifdef CONFIG_EXYNOS_PMU
>  extern struct regmap *exynos_get_pmu_regmap(void);
> +
> +extern struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +						       const char *property);

Drop extern from new code. I understand it makes it inconsistent but it
extern does not matter, so at some point we will clean all existing code...

Best regards,
Krzysztof


