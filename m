Return-Path: <linux-kernel+bounces-145309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DED8A5272
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95661C22703
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E77352B;
	Mon, 15 Apr 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BywKZqOv"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7062A33080
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189487; cv=none; b=TK42oLnnJ5JZ7G6DzAlz3Gk9+kCMUi/AFh8prxqS+QObFXW7zcxPVbHHmap7p4/bKXENYzzSzao1kuKDRzoMPvKM6+xE9VARnpqMc2L7qO7enG2VzsWxLSNfscaMBTBSbwOPRZIcWPLz0b8MmAlhEi+y4tNTgLfACRdz+BKyDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189487; c=relaxed/simple;
	bh=cXmuk02yardD7sK0mmbeHpQjs8LzSBc0Pq+OZbHu/tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLNu46Dam9QiDd6WvCEwpyWQZ19V7sdFFvmHlkIGjI+NDm0ZnFEHg/z9QQBWdDQVXq3OgLTQY2+dGySspaGcbGVVXkZVkIkMjYQRGmAg2GSDyq3PboP1BOU7snKkHhxD4OT9NEwtPU6j9IswUMapfoSaaUzyA93B3AF/OJQk1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BywKZqOv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e6723c606dso8164665ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713189484; x=1713794284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVuQCo/DoesmumNLbytxbUmN6PFT19OiHvggiXb/Rg4=;
        b=BywKZqOv72fFNdV3hcqhYpM5OAwvGmhgRto34LsJxNYuO/MsLFMIommBm7WPFFXsS3
         duaXkxzorkO7yBzFizAwpw6ZF2QHQ/9MCgXc3o9htGS7KZyJfzMc688SrYsXjU9nt7Oc
         nXX7tXHJoLsWvEsF2hMB6NatIG9bHEU6k6bEFGS8yMO1eCx4n+q+4mWGP6wp9cdfRJis
         ZYWUQ2qJcN70BTuAoZbU0RABWnEDX+n+l2Ma1GczWMBDiCn5feFJXB2DlBYSGegQ+TiS
         Xkqaiibxvl4QtIuF0gCFi6e6+/llAd7se257cNh5ZrBkJdecd/8s+VgeE91f82koG3Ir
         z2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189484; x=1713794284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVuQCo/DoesmumNLbytxbUmN6PFT19OiHvggiXb/Rg4=;
        b=jre00q38JCIX519DXHDzLVU0yHCQS0mXQxXLJlfDVzERqk2M5TlXd8JooddKF4uuFJ
         TwJwI/IdrVdLJvihzgdtfEY1VcvXL+1z4zXcMa/e93R1jcksBFkTDXaoI9w5CAQX+sOx
         DnC2HRRbdeP4V5DqPbrrhKOzdRJzCC/jejbVYZnDXTdugPmlpg8m1+EoLjqdes7uF8s/
         kv6eJCZeC56SuoxiFt2nNPMOmwsFNoNzI0Wu5jP3SkZgXbRO2LWNRn45braC+hWpzhqe
         cVRrkCEa3rHy4WcIVZFboYDKaGCjqPETsNpDW5EtkRCBloz7n1q3kBHTPDq/XTovukQX
         LzVA==
X-Forwarded-Encrypted: i=1; AJvYcCU4eN6lqitDf0ccsMvFuHcgrn6xO+M5MKDhyZbKGROFa3jhiWciBew4R73LkqkoLPNOlhglAYV+W1NcfDtc5AJ9rCpemhtONRYcM1ub
X-Gm-Message-State: AOJu0Yzn3hUvP5k5N58uW+QkOZOnG4mteSKSiTuQD5lmmcHnV8pVha14
	czVcCgWlGuyxOmQrDFvEuMtHp01kCEMh6IMYnrLbchAqLhszZKhJYuKQL7KRaPg=
X-Google-Smtp-Source: AGHT+IH1EJlNhxHBbJx4rlhNdixoqaV81K17xIAdFpby2ITRn1UkjQwWr1KOH1NPYHANUXU7rHhUMA==
X-Received: by 2002:a17:902:e786:b0:1e6:3494:61fc with SMTP id cp6-20020a170902e78600b001e6349461fcmr4593155plb.0.1713189483773;
        Mon, 15 Apr 2024 06:58:03 -0700 (PDT)
Received: from ?IPV6:2601:602:9081:11e0::ba8? ([2601:602:9081:11e0::ba8])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b001e2a7ed52d0sm7939883plx.239.2024.04.15.06.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:58:03 -0700 (PDT)
Message-ID: <6adb0adb-51b7-40cd-9768-23373265388b@baylibre.com>
Date: Mon, 15 Apr 2024 06:58:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: support version 2.00.a
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, dlechner@baylibre.com
References: <20240314204722.1291993-1-tgamblin@baylibre.com>
 <20240314204722.1291993-3-tgamblin@baylibre.com>
 <2by7rakflv22s6uk2e2jk5lw65erjljpwdxdxg3z73furlprj5@2qlacusapkgr>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <2by7rakflv22s6uk2e2jk5lw65erjljpwdxdxg3z73furlprj5@2qlacusapkgr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-04-14 05:05, Uwe Kleine-König wrote:
> Hello Trevor,
Hi Uwe,
>
> On Thu, Mar 14, 2024 at 04:47:22PM -0400, Trevor Gamblin wrote:
>> This adds support for the AXI PWMGEN v2 IP block. This version is
>> nearly identical to v1 other than it supports up to 16 channels instead
>> of 4 and a few of the memory mapped registers have moved.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>>   drivers/pwm/pwm-axi-pwmgen.c | 62 ++++++++++++++++++++++++++++--------
>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
>> index 0c8f7f893a21..539625c404ac 100644
>> --- a/drivers/pwm/pwm-axi-pwmgen.c
>> +++ b/drivers/pwm/pwm-axi-pwmgen.c
>> @@ -32,16 +32,25 @@
>>   #define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
>>   #define AXI_PWMGEN_REG_CONFIG		0x10
>>   #define AXI_PWMGEN_REG_NPWM		0x14
>> -#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
>> -#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
>> -#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))
>> +#define AXI_PWMGEN_CHX_PERIOD(v, ch)	((v)->period_base + (v)->ch_step * (ch))
>> +#define AXI_PWMGEN_CHX_DUTY(v, ch)	((v)->duty_base + (v)->ch_step * (ch))
>> +#define AXI_PWMGEN_CHX_OFFSET(v, ch)	((v)->offset_base + (v)->ch_step * (ch))
>>   #define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
>>   #define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
>>   #define AXI_PWMGEN_RESET		BIT(0)
>>   
>> +struct axi_pwm_variant {
>> +	u8 period_base;
>> +	u8 duty_base;
>> +	u8 offset_base;
>> +	u8 major_version;
>> +	u8 ch_step;
>> +};
>> +
>>   struct axi_pwmgen_ddata {
>>   	struct regmap *regmap;
>>   	unsigned long clk_rate_hz;
>> +	const struct axi_pwm_variant *variant;
>>   };
>>   
>>   static const struct regmap_config axi_pwmgen_regmap_config = {
>> @@ -50,12 +59,30 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
>>   	.val_bits = 32,
>>   };
>>   
>> +static const struct axi_pwm_variant pwmgen_1_00_variant = {
>> +	.period_base = 0x40,
>> +	.duty_base = 0x44,
>> +	.offset_base = 0x48,
>> +	.major_version = 1,
>> +	.ch_step = 12,
>> +};
>> +
>> +static const struct axi_pwm_variant pwmgen_2_00_variant = {
>> +	.period_base = 0x40,
>> +	.duty_base = 0x80,
>> +	.offset_base = 0xC0,
>> +	.major_version = 2,
>> +	.ch_step = 4,
>> +};
> My first intuition to model the register differences would have been
> something like:
>
> 	#define ..._PERIOD 0
> 	#define ..._DUTY 1
> 	#define ..._OFFSET 2
>
> and then store a "register_step"(?) variable (which is 0x4 for v1 and
> 0x40 for v2) in the variant struct and then use:
>
> #define AXI_PWMGEN_CHX_PERIOD(v, ch)	(0x40 + (v)->ch_step * (ch))
> #define AXI_PWMGEN_CHX_DUTY(v, ch)	(0x40 + (v)->register_step + (v)->ch_step * (ch))
> #define AXI_PWMGEN_CHX_OFFSET(v, ch)	(0x40 + 2 * (v)->register_step + (v)->ch_step * (ch))
>
> This saves a tiny bit of memory, not entirely sure this is a good idea.
> Pick it up if you like, or keep your approach, I don't care much.
>
>> +
>>   static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   			    const struct pwm_state *state)
>>   {
>>   	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
>>   	unsigned int ch = pwm->hwpwm;
>>   	struct regmap *regmap = ddata->regmap;
>> +	const struct axi_pwm_variant *variant = ddata->variant;
>>   	u64 period_cnt, duty_cnt;
>>   	int ret;
>>   
>> @@ -70,7 +97,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   		if (period_cnt == 0)
>>   			return -EINVAL;
>>   
>> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), period_cnt);
>>   		if (ret)
>>   			return ret;
>>   
>> @@ -78,15 +105,15 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   		if (duty_cnt > UINT_MAX)
>>   			duty_cnt = UINT_MAX;
>>   
>> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), duty_cnt);
>>   		if (ret)
>>   			return ret;
>>   	} else {
>> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), 0);
>>   		if (ret)
>>   			return ret;
>>   
>> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
>> +		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), 0);
>>   		if (ret)
>>   			return ret;
>>   	}
>> @@ -99,11 +126,12 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   {
>>   	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
>>   	struct regmap *regmap = ddata->regmap;
>> +	const struct axi_pwm_variant *variant = ddata->variant;
>>   	unsigned int ch = pwm->hwpwm;
>>   	u32 cnt;
>>   	int ret;
>>   
>> -	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
>> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), &cnt);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -111,7 +139,7 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   
>>   	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
>>   
>> -	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
>> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), &cnt);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -127,7 +155,8 @@ static const struct pwm_ops axi_pwmgen_pwm_ops = {
>>   	.get_state = axi_pwmgen_get_state,
>>   };
>>   
>> -static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
>> +static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev,
>> +			    const struct axi_pwm_variant *variant)
>>   {
>>   	int ret;
>>   	u32 val;
>> @@ -146,7 +175,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (ADI_AXI_PCORE_VER_MAJOR(val) != 1) {
>> +	if (ADI_AXI_PCORE_VER_MAJOR(val) != variant->major_version) {
>>   		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
> Hmm, is it worth to also diagnose a mismatch here? That is if the dt
> tells this was a version 2 device but the register says version 1? In
> this case
>
> 	Unsupported peripheral version 1.x.y
>
> might be misleading, because version 1 is supported and the problem is
> maybe only a wrong dt?
Good point, I'll look into this change too.
>
>>   			ADI_AXI_PCORE_VER_MAJOR(val),
>>   			ADI_AXI_PCORE_VER_MINOR(val),
>> @@ -178,9 +207,14 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>>   	struct pwm_chip *chip;
>>   	struct axi_pwmgen_ddata *ddata;
>>   	struct clk *clk;
>> +	const struct axi_pwm_variant *variant;
>>   	void __iomem *io_base;
>>   	int ret;
>>   
>> +	variant = device_get_match_data(dev);
>> +	if (!variant)
>> +		return -EINVAL;
>> +
>>   	io_base = devm_platform_ioremap_resource(pdev, 0);
>>   	if (IS_ERR(io_base))
>>   		return PTR_ERR(io_base);
>> @@ -190,7 +224,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>>   		return dev_err_probe(dev, PTR_ERR(regmap),
>>   				     "failed to init register map\n");
>>   
>> -	ret = axi_pwmgen_setup(regmap, dev);
>> +	ret = axi_pwmgen_setup(regmap, dev, variant);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> @@ -199,6 +233,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>>   		return PTR_ERR(chip);
>>   	ddata = pwmchip_get_drvdata(chip);
>>   	ddata->regmap = regmap;
>> +	ddata->variant = variant;
>>   
>>   	clk = devm_clk_get_enabled(dev, NULL);
>>   	if (IS_ERR(clk))
>> @@ -224,7 +259,8 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>>   }
>>   
>>   static const struct of_device_id axi_pwmgen_ids[] = {
>> -	{ .compatible = "adi,axi-pwmgen-1.00.a" },
>> +	{ .compatible = "adi,axi-pwmgen-1.00.a", .data = &pwmgen_1_00_variant },
>> +	{ .compatible = "adi,axi-pwmgen-2.00.a", .data = &pwmgen_2_00_variant },
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);
> Otherwise looks fine.
>
> Can you please add the next iteration of this patch together with the
> series adding support for v1?

Thank you, will do. I'm currently traveling so I may not get to it until 
the weekend or early next week.

Trevor

>
> Best regards
> Uwe
>

