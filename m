Return-Path: <linux-kernel+bounces-35181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9FA838D38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8428CB26369
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38235D8E6;
	Tue, 23 Jan 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxAGskvY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A55D759
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008627; cv=none; b=R6kqS6Ks5q84TQMRyfnyiZPme/ht0gXkut7FktmFJ+ir44sMv97A28JATN9JVo5jBoc4/srgvoeZNlcf4lFDULn8UzKRUqiYN2DiuhNwKJI4RxY/Hk7VdyS+ljLECGvdeJxs48OIPAdOfSvLVipTvhMHNJ0a4DGPsll29VKcOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008627; c=relaxed/simple;
	bh=yzIpgSarbLnkTu1ruIWuQf/KD1Y53tWgm7gNTofFOMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+iZyG2SpJ/bsq8qa/4hgN9ElI1oC9alb0wqKopk54z/OkoStFum/7l+omqMbL06nNvn8Rz6yiZdSMtIxxEpndpvQ8W6t4G9ExKMn8lqTpjE/ns+V05UQJFGoof2mVh3du6fuMkEMx+SZ5bSYeGZKjil+O0hXtG8slUboy5lP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bxAGskvY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so18286135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706008624; x=1706613424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjP6iJ/yX6dQK3yxWU3uAXRBZwEHVZpEGxhPfzJdMQA=;
        b=bxAGskvY3e0s2n6jcVsGbADv3zVC0fWrq/e34WBfR4rhbr26URlJzqC+gZywrFfvJB
         BAt7MVoLymWSDkCj6basRnh7i9ZcEgdVE2gpTVVMxBiqfAi9533OAeoe4eE+9nF1u3aJ
         5phBzU8ACV6yWTycmymSISrVvEeLLsKcd3ZPWScXOfFB5i7Da76f+t1kH3xa5L8zR2FB
         ZATX//ATzL/eKK7/Eui+kieXJa1fFLV5djhtfRWf2IfSQcv38zs1ZJdxVVlVyGAVCLgZ
         eLSYjrDfML207LvnxXS+6l9u9KteGwlgIcQYsm10XKq0/lIY7QtHxb7/xXJVFMgdjmNL
         s32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008624; x=1706613424;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjP6iJ/yX6dQK3yxWU3uAXRBZwEHVZpEGxhPfzJdMQA=;
        b=q4yMPYpWBH5rcbPeShMh9DIf+Upspi+qVWz9wePu4BzfRZTczDZg192ZizjLajMSXc
         feEjozQfJVdoNq6ZlofR4/N8LZpr659Yq5+zg4AKX/lpVrsQQC3xReZ+j1vXo2hOlsyV
         yYLvwozfbJu4f86Q6wSPPkpBSK7XVFy0rP6XWo7cTBhwKybOvp/XbJ3bpsfUuIPHvl3Z
         p448rRWFt+wPPo+sHxsrsTU2OqZdu4HixaRxZUtO635CyYJsIBWpc5pq0aH++My1V2OL
         huRC2cvcAKjwN3jViUJ5MGvc40bL2YBoxrGIo2QCzTlYetPlg54ekLl9DgzQKehraKUC
         viBA==
X-Gm-Message-State: AOJu0YwUlQ4NLk+wVnKafpuc0FAts/lAhlcutJGGq2VU7/rN9B52L8I1
	ulz9faCuJvfyPI7I272oXt2LPt8ZT9RC20jAGZFmVJrp0LVz9uwKdnMQxn5SH4E=
X-Google-Smtp-Source: AGHT+IGi4oRmEbEte4U8kteyuUXQDR6c8dGS8ONy9WyBOQRr1Fq1GgBagTCnaGeXaQtCiJP+kwrZsw==
X-Received: by 2002:a05:600c:474b:b0:40e:4672:5227 with SMTP id w11-20020a05600c474b00b0040e46725227mr25481wmo.96.1706008624158;
        Tue, 23 Jan 2024 03:17:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id w18-20020a05600c475200b0040d2d33312csm42650785wmo.2.2024.01.23.03.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:17:03 -0800 (PST)
Message-ID: <26b9a75c-3721-4d7a-985e-772d9f67e6d5@linaro.org>
Date: Tue, 23 Jan 2024 12:17:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] soc: samsung: exynos-pmu: Add
 exynos_pmu_update/read/write APIs and SoC quirks
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
 wim@linux-watchdog.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 jaewon02.kim@samsung.com, chanho61.park@samsung.com,
 semen.protsenko@linaro.org
Cc: kernel-team@android.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-3-peter.griffin@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240122225710.1952066-3-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 23:57, Peter Griffin wrote:
> Newer Exynos SoCs have atomic set/clear bit hardware for PMU registers as
> these registers can be accessed by multiple masters. Some platforms also
> protect the PMU registers for security hardening reasons so they can't be
> written by normal world and are only write acessible in el3 via a SMC call.


Typo? accessible?

> 
> Add support for both of these usecases using SoC specific quirks that are
> determined from the DT compatible string.>
> Drivers which need to read and write PMU registers should now use these
> new exynos_pmu_*() APIs instead of obtaining a regmap using
> syscon_regmap_lookup_by_phandle()
> 
> Depending on the SoC specific quirks, the exynos_pmu_*() APIs will access
> the PMU register in the appropriate way.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c       | 209 ++++++++++++++++++++++++-
>  drivers/soc/samsung/exynos-pmu.h       |   4 +
>  include/linux/soc/samsung/exynos-pmu.h |  28 ++++
>  3 files changed, 234 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 250537d7cfd6..e9e933ede568 100644
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
> @@ -12,29 +13,204 @@
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
> +/**
> + * DOC: Quirk flags for different Exynos PMU IP-cores
> + *
> + * This driver supports multiple Exynos based SoCs, each of which might have a
> + * different set of registers and features supported.
> + *
> + * Quirk flags described below serve the purpose of telling the driver about
> + * mentioned SoC traits, and can be specified in driver data for each particular
> + * supported device.
> + *
> + * %QUIRK_HAS_ATOMIC_BITSETHW: PMU IP has special atomic bit set/clear HW
> + * to protect against PMU registers being accessed from multiple bus masters.
> + *
> + * %QUIRK_PMU_ALIVE_WRITE_SEC: PMU registers are *not* write accesible from
> + * normal world. This is found on some SoCs as a security hardening measure. PMU
> + * registers on these SoCs can only be written via a SMC call and registers are
> + * checked by EL3 firmware against an allowlist before the write can procede.
> + * Note: This quirk should only be set for platforms whose el3 firmware
> + * implements the TENSOR_SMC_PMU_SEC_REG interface below.
> + */
> +
> +#define QUIRK_HAS_ATOMIC_BITSETHW		BIT(0)
> +#define QUIRK_PMU_ALIVE_WRITE_SEC		BIT(1)
> +
> +#define PMUALIVE_MASK GENMASK(14, 0)
> +
>  struct exynos_pmu_context {
>  	struct device *dev;
>  	const struct exynos_pmu_data *pmu_data;
> +	struct regmap *pmureg;
> +	void __iomem *pmu_base_addr;
> +	phys_addr_t pmu_base_pa;
> +	/* protect PMU reg atomic update operations */
> +	spinlock_t update_lock;
>  };
>  
> -void __iomem *pmu_base_addr;
>  static struct exynos_pmu_context *pmu_context;
>  
> +/*
> + * Some SoCs are configured so that PMU_ALIVE registers can only be written
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

These are tensor specific...

> +
> +int set_priv_reg(phys_addr_t reg, u32 val)

..but this not...

> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,

.. and this is again.

Some naming should be clarified, e.g. tensor specific functions should
have some prefix as well, e.g. tensor_writel(), tensor_cmpxchg() or
something similar.


> +		      reg,
> +		      TENSOR_PMUREG_WRITE,
> +		      val, 0, 0, 0, 0, &res);
> +
> +	if (res.a0)
> +		pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> +
> +	return (int)res.a0;
> +}
> +
> +int rmw_priv_reg(phys_addr_t reg, u32 mask, u32 val)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> +		      reg,
> +		      TENSOR_PMUREG_RMW,
> +		      mask, val, 0, 0, 0, &res);
> +
> +	if (res.a0)
> +		pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> +
> +	return (int)res.a0;
> +}
> +
> +/*
> + * For SoCs that have set/clear bit hardware (as indicated by
> + * QUIRK_HAS_ATOMIC_BITSETHW) this function can be used when
> + * the PMU register will be accessed by multiple masters.
> + *
> + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> + * exynos_pmu_set_bit_atomic(0x3e80, 0x3f00, 0x3f00);
> + *
> + * To clear bits 13:8 in PMU offset 0x3e80
> + * exynos_pmu_set_bit_atomic(0x3e80, 0x0, 0x3f00);
> + */
> +static inline void exynos_pmu_set_bit_atomic(unsigned int offset,
> +					     u32 val, u32 mask)
> +{
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&pmu_context->update_lock, flags);
> +	for (i = 0; i < 32; i++) {
> +		if (mask & BIT(i)) {
> +			if (val & BIT(i)) {
> +				offset |= 0xc000;
> +				pmu_raw_writel(i, offset);
> +			} else {
> +				offset |= 0x8000;
> +				pmu_raw_writel(i, offset);
> +			}
> +		}
> +	}
> +	spin_unlock_irqrestore(&pmu_context->update_lock, flags);
> +}
> +
> +int exynos_pmu_update_bits(unsigned int offset, unsigned int mask,
> +			   unsigned int val)
> +{
> +	if (pmu_context->pmu_data &&
> +	    pmu_context->pmu_data->quirks & QUIRK_PMU_ALIVE_WRITE_SEC)
> +		return rmw_priv_reg(pmu_context->pmu_base_pa + offset,
> +				    mask, val);
> +
> +	return regmap_update_bits(pmu_context->pmureg, offset, mask, val);
> +}
> +EXPORT_SYMBOL(exynos_pmu_update_bits);

You need kerneldoc for all exported functions.

Also, EXPORT_SYMBOL_GPL

> +
>  void pmu_raw_writel(u32 val, u32 offset)
>  {
> -	writel_relaxed(val, pmu_base_addr + offset);
> +	if (pmu_context->pmu_data &&
> +	    pmu_context->pmu_data->quirks & QUIRK_PMU_ALIVE_WRITE_SEC)
> +		return (void)set_priv_reg(pmu_context->pmu_base_pa + offset,
> +					  val);
> +
> +	return writel_relaxed(val, pmu_context->pmu_base_addr + offset);
>  }
>  

..

> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
> index 1c652ffd79b4..570c6e4dc8c3 100644
> --- a/drivers/soc/samsung/exynos-pmu.h
> +++ b/drivers/soc/samsung/exynos-pmu.h
> @@ -25,8 +25,12 @@ struct exynos_pmu_data {
>  	void (*pmu_init)(void);
>  	void (*powerdown_conf)(enum sys_powerdown);
>  	void (*powerdown_conf_extra)(enum sys_powerdown);
> +	u32 quirks;
>  };
>  
> +int set_priv_reg(phys_addr_t reg, u32 val);
> +int rmw_priv_reg(phys_addr_t reg, u32 mask, u32 val);

Why these are in the header?

Best regards,
Krzysztof


