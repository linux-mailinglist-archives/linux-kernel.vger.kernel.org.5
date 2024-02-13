Return-Path: <linux-kernel+bounces-63055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DB9852A39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757BB1F22424
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40B1A701;
	Tue, 13 Feb 2024 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIo5zFN+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE1919452
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810413; cv=none; b=d9acjxpMqJeLmkH6fU7F0/AuoJYDdcVrJDDFslvKmQ7tcGBEs8YUUYhWrcRwc0MH9gy5fpVtfVMwiKP9Y8L33DRlfLF6DssXxZGj5sv2SDiI9Pdx2dAERsNrXFuxCsC/n63VFNeREaxub9oRGrmb0YgTb34zD/PkJV9a1As/pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810413; c=relaxed/simple;
	bh=oZKt5LG2w5Yz4qKHvivygXCsJ6lz+ZnxJkNmmOYscVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZNJ8gBdalL2FJs9lVWmf3mcF00YJcOKqWwrKIMwJRZNNp8lSnaMvxBd8pCafD6B+TrT+V29lE+uI7hFLO6CNcDOuvHTQB0vA/T0T6Fn3yrBKE9mkJiXR59L91WvCTeMEhPFU8lVQdYkBSCy+QbRZs4IiBd+hWnGEdCOkV15C0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xIo5zFN+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-410ee8ed659so10259285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707810409; x=1708415209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsRrHrpLNGxvj3Hpc9o+8hI8G6R3/zQa/0HCfH7df84=;
        b=xIo5zFN+xI1qTZ7Wzhxnf/AVmznrBy2j5H5MUlq6rAvpGXdljOi2n+owSMds41Pvb1
         2F4p1NFVpucC8KZRIaI9S7dRHmdBWQHifmvExUjsanu8KDGkfXzrhXJQZ0atNwg3q755
         0xxRR6nsXocIJksZbEMLHLkyNR65M2ZXTSCYoqAK20p2JAeYuSqO4OD/SQ49zoUaz+XH
         kgy+adIlp113rVcFMmm1z9nh7yBMDwX1HUB+mJ/ICbqEGHr9HKVwCBXsSUc7dC5eYzp3
         mQyq3wMmw2giAGUTHVhrklZxZUodRo+XdnCb42MWDAeNQOPFCMFA3tvO+9cgoEbxugoT
         jscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810409; x=1708415209;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsRrHrpLNGxvj3Hpc9o+8hI8G6R3/zQa/0HCfH7df84=;
        b=d4ShC44QnT1c8Nziffxv+Q42OADESKPEQD+fYA+n3AJZpswtpz0Hw9qawo0sDyoLEz
         FGggII55TyroYi22LXpTiSeDTcgskXQxJwLI9ZXHaEsZwFu9i4u/V7wpamTUG8vh1OJf
         TnZdcitqI7NmAi7sWg4QnGTpgmrpOV3Wu3R+uRgOPbsNAW+Pdbx+bdMwKNw53L0tF27o
         o/4qgt7VfDVQymCi/8tiiFOXsr4A4rgMaMtwfwxiy8QxQ1wy5dQ71pfn3GGtJ5xJuuRd
         hamMv+I1u8h9Hi6B1/NGuE9FzWwBpmZilhExRx0YFitD2fN92E3BKlijGk72uAab1m5V
         HwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi+9QJf4a+uhH4izhyzYLsuvbGC2jNRgvdTKyQn/ltAEVeGQBewYmXfWjixPQtZOM240wKKgWzVFz3Ahj2KyPfng7Z9t1vHpg2TAEB
X-Gm-Message-State: AOJu0YyfvotD0izXV6WAV6YtlUEx0r9xz/1LKteqAm9XQCKeXMO/6MYj
	tH9C+qUnuGemypPwPjessrkehBkGsQh/12v3Z4pRoGrGLDezOfTzZH4fMN60zmw=
X-Google-Smtp-Source: AGHT+IGLlGPKUXKUCZMz1EaVZ6mJB3Pvj1K630QCRVUmMxA6RlZZZV77RDHcUhhc9uVzQ4zernkqhQ==
X-Received: by 2002:a05:600c:4f42:b0:410:726b:6f87 with SMTP id m2-20020a05600c4f4200b00410726b6f87mr6790081wmq.32.1707810409078;
        Mon, 12 Feb 2024 23:46:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYP7h+XC3hcncLIeqOcdYxjoS5oh28yxDHfTTz8B6cshmu4ZEyCifZhVkdk8U71LV29RzvuoMPUHky+0r8ciBxHTicZvkA+iUFBd4O+ikuqXGMDUEVv7IiwicuIxgXRhzdfFNCcSc46jQH/C/gWRmahIky2IQOhR/L2Sxg1CjfZ7N6nlrgROGfmh+PGztvkvfZdHHJ71w+b/v8VlpktyJib7Ddy/sxje3Xs16qqJCFzGjdpmY+zsm7G0uK+O8SHwPYxEs54YyFFx3F41Fek60BLHArRsdfXPAUdf9Y8pCeIv1EVPpRWI8yn0qW21kYqPCcyq+tlZTecgSPGFy79dg9SUhLztVaxZBxqH2MKkFX8ZQivpTps8FiiOg=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b00411b7c91470sm1128366wmb.12.2024.02.12.23.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 23:46:48 -0800 (PST)
Message-ID: <6bc91742-66d8-425b-ba40-fe5fa6ba18c4@linaro.org>
Date: Tue, 13 Feb 2024 08:46:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] memory: stm32-fmc2-ebi: update the driver to
 support revision 2
Content-Language: en-US
To: Christophe Kerello <christophe.kerello@foss.st.com>,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-6-christophe.kerello@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212174822.77734-6-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 18:48, Christophe Kerello wrote:
> Add the support of the revision 2 of FMC2 IP.
>  - PCSCNTR register has been removed,
>  - CFGR register has been added,
>  - the bit used to enable the IP has moved from BCR1 to CFGR,
>  - the timeout for CEx deassertion has moved from PCSCNTR to BCRx,
>  - the continuous clock enable has moved from BCR1 to CFGR,
>  - the clk divide ratio has moved from BCR1 to CFGR.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  drivers/memory/stm32-fmc2-ebi.c | 206 +++++++++++++++++++++++++-------
>  1 file changed, 163 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
> index d79dcb6c239a..066722274a45 100644
> --- a/drivers/memory/stm32-fmc2-ebi.c
> +++ b/drivers/memory/stm32-fmc2-ebi.c
> @@ -20,8 +20,10 @@
>  #define FMC2_BCR(x)			((x) * 0x8 + FMC2_BCR1)
>  #define FMC2_BTR(x)			((x) * 0x8 + FMC2_BTR1)
>  #define FMC2_PCSCNTR			0x20
> +#define FMC2_CFGR			0x20
>  #define FMC2_BWTR1			0x104
>  #define FMC2_BWTR(x)			((x) * 0x8 + FMC2_BWTR1)
> +#define FMC2_VERR			0x3f4
>  
>  /* Register: FMC2_BCR1 */
>  #define FMC2_BCR1_CCLKEN		BIT(20)
> @@ -42,6 +44,7 @@
>  #define FMC2_BCR_ASYNCWAIT		BIT(15)
>  #define FMC2_BCR_CPSIZE			GENMASK(18, 16)
>  #define FMC2_BCR_CBURSTRW		BIT(19)
> +#define FMC2_BCR_CSCOUNT		GENMASK(21, 20)
>  #define FMC2_BCR_NBLSET			GENMASK(23, 22)
>  
>  /* Register: FMC2_BTRx/FMC2_BWTRx */
> @@ -58,6 +61,15 @@
>  #define FMC2_PCSCNTR_CSCOUNT		GENMASK(15, 0)
>  #define FMC2_PCSCNTR_CNTBEN(x)		BIT((x) + 16)
>  
> +/* Register: FMC2_CFGR */
> +#define FMC2_CFGR_CLKDIV		GENMASK(19, 16)
> +#define FMC2_CFGR_CCLKEN		BIT(20)
> +#define FMC2_CFGR_FMC2EN		BIT(31)
> +
> +/* Register: FMC2_VERR */
> +#define FMC2_VERR_MAJREV		GENMASK(7, 4)
> +#define FMC2_VERR_MAJREV_2		2
> +
>  #define FMC2_MAX_EBI_CE			4
>  #define FMC2_MAX_BANKS			5
>  
> @@ -74,6 +86,11 @@
>  #define FMC2_BCR_MTYP_PSRAM		0x1
>  #define FMC2_BCR_MTYP_NOR		0x2
>  
> +#define FMC2_BCR_CSCOUNT_0		0x0
> +#define FMC2_BCR_CSCOUNT_1		0x1
> +#define FMC2_BCR_CSCOUNT_64		0x2
> +#define FMC2_BCR_CSCOUNT_256		0x3
> +
>  #define FMC2_BXTR_EXTMOD_A		0x0
>  #define FMC2_BXTR_EXTMOD_B		0x1
>  #define FMC2_BXTR_EXTMOD_C		0x2
> @@ -85,7 +102,7 @@
>  #define FMC2_BXTR_DATAST_MAX		0xff
>  #define FMC2_BXTR_BUSTURN_MAX		0xf
>  #define FMC2_BXTR_DATAHLD_MAX		0x3
> -#define FMC2_BTR_CLKDIV_MAX		0xf
> +#define FMC2_REG_CLKDIV_MAX		0xf

Why?

>  #define FMC2_BTR_DATLAT_MAX		0xf
>  #define FMC2_PCSCNTR_CSCOUNT_MAX	0xff
>  
> @@ -101,7 +118,8 @@ enum stm32_fmc2_ebi_register_type {
>  	FMC2_REG_BCR = 1,
>  	FMC2_REG_BTR,
>  	FMC2_REG_BWTR,
> -	FMC2_REG_PCSCNTR
> +	FMC2_REG_PCSCNTR,
> +	FMC2_REG_CFGR,
>  };
>  
>  enum stm32_fmc2_ebi_transaction_type {
> @@ -132,6 +150,13 @@ enum stm32_fmc2_ebi_cpsize {
>  	FMC2_CPSIZE_1024 = 1024
>  };
>  
> +enum stm32_fmc2_ebi_cscount {
> +	FMC2_CSCOUNT_0 = 0,
> +	FMC2_CSCOUNT_1 = 1,
> +	FMC2_CSCOUNT_64 = 64,
> +	FMC2_CSCOUNT_256 = 256
> +};
> +
>  struct stm32_fmc2_ebi_data {
>  	bool rnb_for_nand;
>  };
> @@ -142,11 +167,13 @@ struct stm32_fmc2_ebi {
>  	struct regmap *regmap;
>  	const struct stm32_fmc2_ebi_data *data;
>  	u8 bank_assigned;
> +	u8 majrev;
>  
>  	u32 bcr[FMC2_MAX_EBI_CE];
>  	u32 btr[FMC2_MAX_EBI_CE];
>  	u32 bwtr[FMC2_MAX_EBI_CE];
>  	u32 pcscntr;
> +	u32 cfgr;
>  };
>  
>  /*
> @@ -274,15 +301,29 @@ static int stm32_fmc2_ebi_check_clk_period(struct stm32_fmc2_ebi *ebi,
>  					   const struct stm32_fmc2_prop *prop,
>  					   int cs)
>  {
> -	u32 bcr, bcr1;
> +	u32 bcr, cfgr;
>  
>  	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
> -	if (cs)
> -		regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
> -	else
> -		bcr1 = bcr;
>  
> -	if (bcr & FMC2_BCR_BURSTEN && (!cs || !(bcr1 & FMC2_BCR1_CCLKEN)))
> +	if (ebi->majrev < FMC2_VERR_MAJREV_2) {
> +		u32 bcr1;
> +
> +		if (cs)
> +			regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
> +		else
> +			bcr1 = bcr;
> +
> +		if (bcr & FMC2_BCR_BURSTEN &&
> +		    (!cs || !(bcr1 & FMC2_BCR1_CCLKEN)))
> +			return 0;
> +
> +		return -EINVAL;
> +	}

The function is not really readable anymore. Please split it into three
functions: for v1 (so original code), v2 and wrapper choosing it based
on revision). Or two functions and some sort of ops with function
pointers (so you call ops->check_clk_period). Or just parametrize the
registers with two different "struct reg_field" and use appropriate one
for given revision (the code looks the same!)
Or just two set of stm32_fmc2_child_props...

Anyway the duplicated code just two read different register is it not
the way to go.


> +
> +	regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
> +
> +	if (bcr & FMC2_BCR_BURSTEN &&
> +	    (!cs || !(cfgr & FMC2_CFGR_CCLKEN)))
>  		return 0;
>  
>  	return -EINVAL;
> @@ -311,15 +352,29 @@ static u32 stm32_fmc2_ebi_ns_to_clk_period(struct stm32_fmc2_ebi *ebi,
>  					   int cs, u32 setup)
>  {
>  	u32 nb_clk_cycles = stm32_fmc2_ebi_ns_to_clock_cycles(ebi, cs, setup);
> -	u32 bcr, btr, clk_period;
> +	u32 btr, clk_period;
>  
> -	regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
> -	if (bcr & FMC2_BCR1_CCLKEN || !cs)
> -		regmap_read(ebi->regmap, FMC2_BTR1, &btr);
> -	else
> -		regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
> +	if (ebi->majrev < FMC2_VERR_MAJREV_2) {
> +		u32 bcr;
>  
> -	clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
> +		regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
> +		if (bcr & FMC2_BCR1_CCLKEN || !cs)
> +			regmap_read(ebi->regmap, FMC2_BTR1, &btr);
> +		else
> +			regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
> +
> +		clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
> +	} else {
> +		u32 cfgr;
> +
> +		regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
> +		if (cfgr & FMC2_CFGR_CCLKEN) {
> +			clk_period = FIELD_GET(FMC2_CFGR_CLKDIV, cfgr) + 1;
> +		} else {
> +			regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
> +			clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
> +		}
> +	}
>  
>  	return DIV_ROUND_UP(nb_clk_cycles, clk_period);
>  }
> @@ -339,6 +394,9 @@ static int stm32_fmc2_ebi_get_reg(int reg_type, int cs, u32 *reg)
>  	case FMC2_REG_PCSCNTR:
>  		*reg = FMC2_PCSCNTR;
>  		break;
> +	case FMC2_REG_CFGR:
> +		*reg = FMC2_CFGR;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -672,10 +730,26 @@ static int stm32_fmc2_ebi_set_clk_period(struct stm32_fmc2_ebi *ebi,
>  					 int cs, u32 setup)
>  {
>  	u32 val;
> +	u32 reg = FMC2_BTR(cs);
> +	u32 mask = FMC2_BTR_CLKDIV;
>  
> -	val = setup ? clamp_val(setup - 1, 1, FMC2_BTR_CLKDIV_MAX) : 1;
> -	val = FIELD_PREP(FMC2_BTR_CLKDIV, val);
> -	regmap_update_bits(ebi->regmap, FMC2_BTR(cs), FMC2_BTR_CLKDIV, val);
> +	if (ebi->majrev >= FMC2_VERR_MAJREV_2) {
> +		u32 cfgr;
> +
> +		regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
> +
> +		if (cfgr & FMC2_CFGR_CCLKEN) {
> +			reg = FMC2_CFGR;
> +			mask = FMC2_CFGR_CLKDIV;
> +		}
> +	}
> +
> +	val = setup ? clamp_val(setup - 1, 1, FMC2_REG_CLKDIV_MAX) : 1;
> +	if (reg == FMC2_CFGR)
> +		val = FIELD_PREP(FMC2_CFGR_CLKDIV, val);
> +	else
> +		val = FIELD_PREP(FMC2_BTR_CLKDIV, val);

This scales poorly for any new revision. You should really start using
reg_field per each version.

> +	regmap_update_bits(ebi->regmap, reg, mask, val);
>  
>  	return 0;
>  }
> @@ -697,27 +771,58 @@ static int stm32_fmc2_ebi_set_max_low_pulse(struct stm32_fmc2_ebi *ebi,
>  					    const struct stm32_fmc2_prop *prop,
>  					    int cs, u32 setup)
>  {
> -	u32 old_val, new_val, pcscntr;
> +	u32 val;
> +	u32 reg = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_PCSCNTR :
> +						     FMC2_BCR(cs);
> +	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_PCSCNTR_CSCOUNT :
> +						      FMC2_BCR_CSCOUNT;

You have such code everywhere... sorry, that's not readable at all. No
conditional assignmnents, that's a clear NAK.



Best regards,
Krzysztof


