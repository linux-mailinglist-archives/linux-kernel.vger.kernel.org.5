Return-Path: <linux-kernel+bounces-36529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273EA83A276
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9323AB229DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993E15AF9;
	Wed, 24 Jan 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSbSse7r"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34412E70
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079641; cv=none; b=aXDJoHrQgYlW8jDXh9CYQVjVS4ZOUGiWn2byDGRqN2mSm4edW3JOWND8aNsnejJT8uKiBRHLrPLlf4yNFxw5ZmujVhDZzXKU2Yea6CrNw8fG6qbsWMv99APgz4fHH3RZLHoyZyGCwl+Ei+LvyjH/4t+rFNZZ0IyDuhiNnC+By3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079641; c=relaxed/simple;
	bh=nEvn0/4hOrbydyuJcYje0Aae9UV5RIs9X829QxYjZDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QozYTDtL4rLn/mgmxmntdDsEjX/Wj+0WPEnAmKQOUT1sFze7tSVeAND8lZNFFUlIdDhdvnMO7L1X1rVImfKYhEDSqkuwdHkKb0Pm/5aHsqgy9HSj44k053wqU4G+dOQ/tRYHNd3I1rEv5w6fsRLbI7+2ZlZLoFJ2i2cY10QmLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSbSse7r; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55cc182da17so293690a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706079637; x=1706684437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d69rfvGmLzzk4jFemO+qScxqDFLXMqBxzotcHMdu4KQ=;
        b=NSbSse7rTRa5EQ0xLhiIIWhoe2YIyflsS4qx2WSevfPJmCevgt+UnZCAMC0oTNUKix
         syW4YYbh3tlP9cwghjRbq57Ex8fYeWO7cTqzifo5lYY+eHWVgqNyvNjofDYpKgsURtvF
         O+a4g10tzEU1NGQcf4KTjYEvh7oaMkod2vv95GqgMv8ogFlh5fCN9W8gx/fjJ4N/mk/s
         QLYUx7badkeIOW8jDDMPXPzRodec8MQZfK7ncsApWvbdP9lfnDqzBbV6x5yxpvusfs82
         5w+mJN/NZMj4kpf47my3oQz+VFrFjouxUDd04jHlYgiFci2xH4e2e5XBVBT4m+3huR1b
         kSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079637; x=1706684437;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d69rfvGmLzzk4jFemO+qScxqDFLXMqBxzotcHMdu4KQ=;
        b=ZlHxAKMapfSFw/Rk+A83jgU8Jx+D3QPKUV+ViVIheaAdZu51q7vBYxAKT76hr8sTsn
         CprOYVme+rotwVpEQXWMMblVnik5uW59LGYD08Kay6MbylQvvz4Y4pvKOKH7Iiw1Q1xX
         kevvqaB6uxFLBpJW5gvI5eHFN7LaNxysQHqL92wKQQJX4xQcElhzY17PaKajLxi+cbm5
         XgwzM0JNLm5Rmu7ht8bAV/ZObdr/vN3vP5AKvhPJwQ1WTgWiH45inQ9VFBCfX5h1E/Z8
         W/6dGRUOn0SKX797yaVTDJqSFek4y3K0kL5nY1MxcbGidK8b9/ukS4Os35x1gnSjNmdD
         DR5g==
X-Gm-Message-State: AOJu0Yx7ECcQGBmRksgBiNHXTQsuEgtEr3E9wz3QzNHEbEcntUA1NCRD
	dme/jFidBdtY/+X8Do4MuwTeVnszd++7O6j+oZ6ir7efoc5nk7c1JFmZVuibouA=
X-Google-Smtp-Source: AGHT+IFiMpe8pJr8jg4RmX820Qjf6XBstYcxT4EIJ1x9bw8CLsB0NlILy65sG/cotpF2Ok1aAySFtA==
X-Received: by 2002:a50:fe8d:0:b0:55a:3efe:5113 with SMTP id d13-20020a50fe8d000000b0055a3efe5113mr1537750edt.81.1706079637436;
        Tue, 23 Jan 2024 23:00:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9804691edb.6.2024.01.23.23.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 23:00:37 -0800 (PST)
Message-ID: <b9b8aa19-aa08-42ff-8b2f-dedb1e64700c@linaro.org>
Date: Wed, 24 Jan 2024 08:00:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/17] reset: eyeq5: add platform driver
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-9-392b010b8281@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240123-mbly-clk-v3-9-392b010b8281@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 19:46, Théo Lebrun wrote:
> Add the Mobileye EyeQ5 reset controller driver. It belongs to a syscon
> region called OLB. It might grow to add later support of other
> platforms from Mobileye.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  MAINTAINERS                 |   1 +
>  drivers/reset/Kconfig       |  12 ++
>  drivers/reset/Makefile      |   1 +
>  drivers/reset/reset-eyeq5.c | 383 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 397 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ea96ab7d2b8..dd3b5834386f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14794,6 +14794,7 @@ F:	arch/mips/boot/dts/mobileye/
>  F:	arch/mips/configs/eyeq5_defconfig
>  F:	arch/mips/mobileye/board-epm5.its.S
>  F:	drivers/clk/clk-eyeq5.c
> +F:	drivers/reset/reset-eyeq5.c
>  F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
>  F:	include/dt-bindings/soc/mobileye,eyeq5.h
>  
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index ccd59ddd7610..80bfde54c076 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,18 @@ config RESET_BRCMSTB_RESCAL
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
>  	  BCM7216.
>  
> +config RESET_EYEQ5
> +	bool "Mobileye EyeQ5 reset controller"
> +	depends on MFD_SYSCON
> +	depends on MACH_EYEQ5 || COMPILE_TEST
> +	default MACH_EYEQ5
> +	help
> +	  This enables the Mobileye EyeQ5 reset controller.
> +
> +	  It has three domains, with a varying number of resets in each of them.
> +	  Registers are located in a shared register region called OLB accessed
> +	  through a syscon & regmap.
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 8270da8a4baa..4fabe0070390 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
> +obj-$(CONFIG_RESET_EYEQ5) += reset-eyeq5.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> diff --git a/drivers/reset/reset-eyeq5.c b/drivers/reset/reset-eyeq5.c
> new file mode 100644
> index 000000000000..2217e42e140b
> --- /dev/null
> +++ b/drivers/reset/reset-eyeq5.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Reset driver for the Mobileye EyeQ5 platform.
> + *
> + * The registers are located in a syscon region called OLB. We handle three
> + * reset domains. Domains 0 and 2 look similar in that they both use one bit
> + * per reset line. Domain 1 has a register per reset.
> + *
> + * We busy-wait after updating a reset in domains 0 or 1. The reason is hardware
> + * logic built-in self-test (LBIST) that might be enabled.
> + *
> + * We use eq5r_ as prefix, as-in "EyeQ5 Reset", but way shorter.
> + *
> + * Known resets in domain 0:
> + *  3. CAN0
> + *  4. CAN1
> + *  5. CAN2
> + *  6. SPI0
> + *  7. SPI1
> + *  8. SPI2
> + *  9. SPI3
> + * 10. UART0
> + * 11. UART1
> + * 12. UART2
> + * 13. I2C0
> + * 14. I2C1
> + * 15. I2C2
> + * 16. I2C3
> + * 17. I2C4
> + * 18. TIMER0
> + * 19. TIMER1
> + * 20. TIMER2
> + * 21. TIMER3
> + * 22. TIMER4
> + * 23. WD0
> + * 24. EXT0
> + * 25. EXT1
> + * 26. GPIO
> + * 27. WD1
> + *
> + * Known resets in domain 1:
> + * 0. VMP0	(Vector Microcode Processors)
> + * 1. VMP1
> + * 2. VMP2
> + * 3. VMP3
> + * 4. PMA0	(Programmable Macro Array)
> + * 5. PMA1
> + * 6. PMAC0
> + * 7. PMAC1
> + * 8. MPC0	(Multi-threaded Processing Clusters)
> + * 9. MPC1
> + *
> + * Known resets in domain 2:
> + *  0. PCIE0_CORE
> + *  1. PCIE0_APB
> + *  2. PCIE0_LINK_AXI
> + *  3. PCIE0_LINK_MGMT
> + *  4. PCIE0_LINK_HOT
> + *  5. PCIE0_LINK_PIPE
> + *  6. PCIE1_CORE
> + *  7. PCIE1_APB
> + *  8. PCIE1_LINK_AXI
> + *  9. PCIE1_LINK_MGMT
> + * 10. PCIE1_LINK_HOT
> + * 11. PCIE1_LINK_PIPE
> + * 12. MULTIPHY
> + * 13. MULTIPHY_APB
> + * 15. PCIE0_LINK_MGMT
> + * 16. PCIE1_LINK_MGMT
> + * 17. PCIE0_LINK_PM
> + * 18. PCIE1_LINK_PM
> + *
> + * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +/* Offsets into the OLB region as well as masks for domain 1 registers. */
> +#define EQ5R_OLB_SARCR0			(0x004)
> +#define EQ5R_OLB_SARCR1			(0x008)
> +#define EQ5R_OLB_PCIE_GP		(0x120)
> +#define EQ5R_OLB_ACRP_REG(n)		(0x200 + 4 * (n)) // n=0..12
> +#define EQ5R_OLB_ACRP_PD_REQ		BIT(0)
> +#define EQ5R_OLB_ACRP_ST_POWER_DOWN	BIT(27)
> +#define EQ5R_OLB_ACRP_ST_ACTIVE		BIT(29)
> +
> +/* Vendor-provided values. D1 has a long timeout because of LBIST. */
> +#define D0_TIMEOUT_POLL			10
> +#define D1_TIMEOUT_POLL			40000
> +
> +/*
> + * Masks for valid reset lines in each domain. This array is also used to get
> + * the domain and reset counts.
> + */
> +static const u32 eq5r_valid_masks[] = { 0x0FFFFFF8, 0x00001FFF, 0x0007BFFF };
> +
> +#define EQ5R_DOMAIN_COUNT ARRAY_SIZE(eq5r_valid_masks)
> +
> +struct eq5r_private {
> +	struct mutex mutexes[EQ5R_DOMAIN_COUNT]; /* We serialize all reset operations. */
> +	struct regmap *olb;			 /* Writes go to a syscon regmap. */
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static int _eq5r_busy_wait(struct eq5r_private *priv, struct device *dev,
> +			   u32 domain, u32 offset, bool assert)
> +{
> +	unsigned int val, mask;
> +	int i;
> +
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		for (i = 0; i < D0_TIMEOUT_POLL; i++) {
> +			regmap_read(priv->olb, EQ5R_OLB_SARCR1, &val);
> +			val = !(val & BIT(offset));
> +			if (val == assert)
> +				return 0;
> +			__udelay(1);

What is even "__udelay"? It is the first use in drivers. Please use
common methods, like fsleep or udelay... but actually you should rather
use regmap_read_poll_timeout() or some variants instead of open-coding it.


> +		}
> +		break;
> +	case 1:
> +		mask = assert ? EQ5R_OLB_ACRP_ST_POWER_DOWN : EQ5R_OLB_ACRP_ST_ACTIVE;
> +		for (i = 0; i < D1_TIMEOUT_POLL; i++) {
> +			regmap_read(priv->olb, EQ5R_OLB_ACRP_REG(offset), &val);
> +			if (val & mask)
> +				return 0;
> +			__udelay(1);
> +		}
> +		break;
> +	case 2:
> +		return 0; /* No busy waiting for domain 2. */
> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "%u-%u: timeout\n", domain, offset);
> +	return -ETIMEDOUT;
> +}
> +
> +static void _eq5r_assert(struct eq5r_private *priv, u32 domain, u32 offset)

Drop leading _ and name the function in some informative way.

> +{
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		regmap_clear_bits(priv->olb, EQ5R_OLB_SARCR0, BIT(offset));
> +		break;
> +	case 1:
> +		regmap_set_bits(priv->olb, EQ5R_OLB_ACRP_REG(offset),
> +				EQ5R_OLB_ACRP_PD_REQ);
> +		break;
> +	case 2:
> +		regmap_clear_bits(priv->olb, EQ5R_OLB_PCIE_GP, BIT(offset));
> +		break;
> +	default:
> +		WARN_ON(1);
> +	}
> +}
> +
> +static int eq5r_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct eq5r_private *priv = dev_get_drvdata(rcdev->dev);
> +	u32 offset = id & GENMASK(7, 0);
> +	u32 domain = id >> 8;
> +	int ret;
> +
> +	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
> +		return -EINVAL;
> +
> +	dev_dbg(rcdev->dev, "%u-%u: assert request\n", domain, offset);
> +
> +	mutex_lock(&priv->mutexes[domain]);
> +	_eq5r_assert(priv, domain, offset);
> +	ret = _eq5r_busy_wait(priv, rcdev->dev, domain, offset, true);
> +	mutex_unlock(&priv->mutexes[domain]);
> +
> +	return ret;
> +}
> +
> +static void _eq5r_deassert(struct eq5r_private *priv, u32 domain, u32 offset)
> +{
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		regmap_set_bits(priv->olb, EQ5R_OLB_SARCR0, BIT(offset));
> +		break;
> +	case 1:
> +		regmap_clear_bits(priv->olb, EQ5R_OLB_ACRP_REG(offset),
> +				  EQ5R_OLB_ACRP_PD_REQ);
> +		break;
> +	case 2:
> +		regmap_set_bits(priv->olb, EQ5R_OLB_PCIE_GP, BIT(offset));
> +		break;
> +	default:
> +		WARN_ON(1);
> +	}
> +}
> +
> +static int eq5r_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct eq5r_private *priv = dev_get_drvdata(rcdev->dev);
> +	u32 offset = id & GENMASK(7, 0);
> +	u32 domain = id >> 8;
> +	int ret;
> +
> +	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
> +		return -EINVAL;
> +
> +	dev_dbg(rcdev->dev, "%u-%u: deassert request\n", domain, offset);
> +
> +	mutex_lock(&priv->mutexes[domain]);
> +	_eq5r_deassert(priv, domain, offset);
> +	ret = _eq5r_busy_wait(priv, rcdev->dev, domain, offset, false);
> +	mutex_unlock(&priv->mutexes[domain]);
> +
> +	return ret;
> +}
> +
> +static int eq5r_reset(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct device *dev = rcdev->dev;
> +	struct eq5r_private *priv = dev_get_drvdata(dev);
> +	u32 offset = id & GENMASK(7, 0);
> +	u32 domain = id >> 8;
> +	int ret;
> +
> +	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "%u-%u: reset request\n", domain, offset);
> +
> +	mutex_lock(&priv->mutexes[domain]);
> +
> +	_eq5r_assert(priv, domain, offset);
> +	ret = _eq5r_busy_wait(priv, dev, domain, offset, true);
> +	if (ret) /* don't let an error disappear silently */
> +		dev_warn(dev, "%u-%u: reset assert failed: %d\n",
> +			 domain, offset, ret);
> +
> +	_eq5r_deassert(priv, domain, offset);
> +	ret = _eq5r_busy_wait(priv, dev, domain, offset, false);
> +
> +	mutex_unlock(&priv->mutexes[domain]);
> +
> +	return ret;
> +}
> +
> +static int eq5r_status(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct eq5r_private *priv = dev_get_drvdata(rcdev->dev);
> +	u32 offset = id & GENMASK(7, 0);
> +	u32 domain = id >> 8;
> +	unsigned int val;
> +	int ret;
> +
> +	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
> +		return -EINVAL;
> +
> +	dev_dbg(rcdev->dev, "%u-%u: status request\n", domain, offset);
> +
> +	mutex_lock(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		regmap_read(priv->olb, EQ5R_OLB_SARCR1, &val);
> +		ret = !(val & BIT(offset));
> +		break;
> +	case 1:
> +		regmap_read(priv->olb, EQ5R_OLB_ACRP_REG(offset), &val);
> +		ret = !(val & EQ5R_OLB_ACRP_ST_ACTIVE);
> +		break;
> +	case 2:
> +		regmap_read(priv->olb, EQ5R_OLB_PCIE_GP, &val);
> +		ret = !(val & BIT(offset));
> +		break;
> +	}
> +
> +	mutex_unlock(&priv->mutexes[domain]);
> +
> +	return ret;
> +}
> +
> +static const struct reset_control_ops eq5r_ops = {
> +	.reset	  = eq5r_reset,
> +	.assert	  = eq5r_assert,
> +	.deassert = eq5r_deassert,
> +	.status	  = eq5r_status,
> +};
> +
> +static int eq5r_of_xlate(struct reset_controller_dev *rcdev,
> +			 const struct of_phandle_args *reset_spec)
> +{
> +	u32 domain, offset;
> +
> +	if (WARN_ON(reset_spec->args_count != 2))
> +		return -EINVAL;
> +
> +	domain = reset_spec->args[0];
> +	offset = reset_spec->args[1];
> +
> +	if (domain >= EQ5R_DOMAIN_COUNT || offset > 31 ||
> +	    !(eq5r_valid_masks[domain] & BIT(offset))) {
> +		dev_err(rcdev->dev, "%u-%u: invalid reset\n", domain, offset);
> +		return -EINVAL;
> +	}
> +
> +	return (domain << 8) | offset;
> +}
> +
> +static int eq5r_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *parent_np = of_get_parent(np);
> +	struct eq5r_private *priv;
> +	int ret, i;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;

You leak parent.

> +
> +	dev_set_drvdata(dev, priv);
> +
> +	priv->olb = ERR_PTR(-ENODEV);
> +	if (parent_np) {
> +		priv->olb = syscon_node_to_regmap(parent_np);
> +		of_node_put(parent_np);
> +	}
> +	if (IS_ERR(priv->olb))

Also here

> +		return PTR_ERR(priv->olb);

This looks over-complicated. First, you cannot just
dev_get_regmap(pdev->dev.parent)?



> +
> +	for (i = 0; i < EQ5R_DOMAIN_COUNT; i++)
> +		mutex_init(&priv->mutexes[i]);
> +
> +	priv->rcdev.ops = &eq5r_ops;
> +	priv->rcdev.owner = THIS_MODULE;
> +	priv->rcdev.dev = dev;
> +	priv->rcdev.of_node = np;
> +	priv->rcdev.of_reset_n_cells = 2;
> +	priv->rcdev.of_xlate = eq5r_of_xlate;
> +
> +	priv->rcdev.nr_resets = 0;
> +	for (i = 0; i < EQ5R_DOMAIN_COUNT; i++)
> +		priv->rcdev.nr_resets += __builtin_popcount(eq5r_valid_masks[i]);
> +
> +	ret = reset_controller_register(&priv->rcdev);
> +	if (ret) {
> +		dev_err(dev, "Failed registering reset controller: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id eq5r_match_table[] = {
> +	{ .compatible = "mobileye,eyeq5-reset" },
> +	{}
> +};
> +
> +static struct platform_driver eq5r_driver = {
> +	.probe = eq5r_probe,
> +	.driver = {
> +		.name = "eyeq5-reset",
> +		.of_match_table = eq5r_match_table,
> +	},
> +};
> +
> +static int __init eq5r_init(void)
> +{
> +	return platform_driver_register(&eq5r_driver);
> +}
> +
> +arch_initcall(eq5r_init);

This is does not look like arch code, but driver or subsys. Use regular
module_driver. I see there is such pattern in reset but I doubt this is
something good.

Best regards,
Krzysztof


