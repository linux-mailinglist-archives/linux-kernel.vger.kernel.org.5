Return-Path: <linux-kernel+bounces-36531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33B83A297
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE81B28A7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668C16415;
	Wed, 24 Jan 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3vMEx8L"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E400168AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079838; cv=none; b=VU1ZAvEiKEK0ExmCK9PfMQ1139JAfd0Tg+x4UayErXHVNL122FF/zdtVrV8S0XlfoFukNOj0/egCkxzzzEDUOiib8fTcuRkpP0Fb0ORov2vg4BVs2Dd8S2l3nUN56tudx+J7JhR/lbLspblLEH2RIekrlvEOP06F5/DqgJ4nKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079838; c=relaxed/simple;
	bh=Zhhtq7uBrRvjDGHhyHyS7VXvNPW7N5QPlOY9IDvbyz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geqFwRCdPdkJ8E+/f/2eoj8j6OHpxdAj9ZBmHmPa3Wjc3lGy6rcB2VUIa6pur1u5OO9UAP5qF3BqTCgiVCLkb3YEEz2diiR7+i0/mFxH31L0kuilvrXTxC8vI2F8XnetXd/hTTz9C8cZtr4cTKc+VoXrK3kx1MTzD/dUa5ek8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3vMEx8L; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso4284335a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706079834; x=1706684634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haXTBEQvGaOsM7nV6ezZAlDYCdcGMV2LvzCRWvLOdJU=;
        b=C3vMEx8LMu6dEu0nIfohQ4NDrWP1dFgdIJSgjxztTXDkF/EXI4JnfDcQMVwMRLNyhl
         vS+3tKTZpID6SOqJnboSZbOOAx+J+fFFmDawcBJeGHEBxqcajlzuiQoSv4ZymvaWqVzn
         zwfuYCwOJjOtfgIKJTDnqLX3dhAbjS9++iB1q00j9IycZznOqPH8TLAPUo039LGOPC8p
         TiTIv3yjwCqN4anxthRDVAbYk3EXXJMliUqgvzvTL2cvNzlrWfMV4mi3tXv7N8QpqcmB
         FhEf3mvGOVhpAa3CbJpn/yGj2WUgykHZ+zsz/VSyCeLPGOVq+Tgmn5o3AD0W9zeOUgc2
         e+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079834; x=1706684634;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haXTBEQvGaOsM7nV6ezZAlDYCdcGMV2LvzCRWvLOdJU=;
        b=Vm5Q8fpbSwI3O/ILa8fSr5PDy/g6oXWSGrsErQTQSBT0J/MwW7+/11z7syFE21rCHj
         R7M8IsRw8MN+wqboEvNpV48oQvEKO/rssdkZnvrQZk/4YE45EeMrVeIkkHQe7vxPWEa1
         KnK+WhMKa/HteyKd21p7rdOys7Y5AvG/Ew+g0jT7Qdh4P5etYfX9KQDsZVkD/4BOXgp0
         N30JUtgdDO2JycFVlp1R+6+kwD8b97FellG3vNtf+4E8QdWHMp2xBn4WRvP/pWC72a5p
         nxEWzdbxIyo+e2cKsZwfo6ABoAAfhDiZhPNphKW3XH2JX480kL9pCnM9kmhlkDSFkfYs
         qEoQ==
X-Gm-Message-State: AOJu0YxE3Eu7vZP3TL0H//MNMgh6s6Hlctjrv1k1NA+hYBzaCv7QH4/w
	TnY3c7fXU8LJ3F1MjxkMsywCpnQ4bledCf6vjh6+Jypi64v35PofacjkGwIt7cw=
X-Google-Smtp-Source: AGHT+IHc1VS0ppd5vyZESV0GAkIaQ8E7thG/8vrwPpz9MUb+uoqfBuwRFUYnWCx5FlSkc/UIvwT2Vw==
X-Received: by 2002:a05:6402:28b1:b0:55c:2132:36dd with SMTP id eg49-20020a05640228b100b0055c213236ddmr916832edb.84.1706079834571;
        Tue, 23 Jan 2024 23:03:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402151000b0055c0167eb9fsm4353779edw.51.2024.01.23.23.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 23:03:54 -0800 (PST)
Message-ID: <5e06d14a-baa7-4e18-a731-6621e623565f@linaro.org>
Date: Wed, 24 Jan 2024 08:03:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] pinctrl: eyeq5: add platform driver
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
 <20240123-mbly-clk-v3-10-392b010b8281@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240123-mbly-clk-v3-10-392b010b8281@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 19:46, Théo Lebrun wrote:
> Add the Mobileye EyeQ5 pin controller driver. It might grow to add later
> support of other platforms from Mobileye. It belongs to a syscon region
> called OLB.
> 
> Existing pins and their function live statically in the driver code
> rather than in the devicetree, see compatible match data.
> 

..

> +static int eq5p_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *parent_np = of_get_parent(np);
> +	const struct eq5p_match *match = of_device_get_match_data(dev);
> +	struct pinctrl_dev *pctldev;
> +	struct eq5p_pinctrl *pctrl;
> +	int ret;
> +
> +	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
> +	if (!pctrl)
> +		return -ENOMEM;
> +
> +	pctrl->olb = ERR_PTR(-ENODEV);
> +	if (parent_np)
> +		pctrl->olb = syscon_node_to_regmap(parent_np);
> +	if (IS_ERR(pctrl->olb))
> +		pctrl->olb = syscon_regmap_lookup_by_phandle(np, "mobileye,olb");
> +	if (IS_ERR(pctrl->olb))
> +		return PTR_ERR(pctrl->olb);

No, we talked about this, you got comments on this. There is no
mobileye,olb. You cannot have undocumented properties.

> +
> +	pctrl->regs = match->regs;
> +	pctrl->funcs = match->funcs;
> +	pctrl->nfuncs = match->nfuncs;
> +
> +	pctrl->desc.name = dev_name(dev);
> +	pctrl->desc.pins = match->pins;
> +	pctrl->desc.npins = match->npins;
> +	pctrl->desc.pctlops = &eq5p_pinctrl_ops;
> +	pctrl->desc.pmxops = &eq5p_pinmux_ops;
> +	pctrl->desc.confops = &eq5p_pinconf_ops;
> +	pctrl->desc.owner = THIS_MODULE;
> +
> +	ret = devm_pinctrl_register_and_init(dev, &pctrl->desc, pctrl, &pctldev);
> +	if (ret) {
> +		dev_err(dev, "Failed registering pinctrl device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pinctrl_enable(pctldev);
> +	if (ret) {
> +		dev_err(dev, "Failed enabling pinctrl device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "probed\n");

I am pretty sure you got comments for these. Drop such debugs from all
of your code. Current and future.

> +
> +	return 0;
> +}
> +
> +static const struct eq5p_match eq5p_match_a = {
> +	.regs = {
> +		[EQ5P_PD] = 0x0C0,
> +		[EQ5P_PU] = 0x0C4,
> +		[EQ5P_DS_LOW] = 0x0D0,
> +		[EQ5P_DS_HIGH] = 0x0D4,
> +		[EQ5P_IOCR] = 0x0B0,
> +	},
> +	.pins = eq5p_pins_a,
> +	.npins = ARRAY_SIZE(eq5p_pins_a),
> +	.funcs = eq5p_functions_a,
> +	.nfuncs = ARRAY_SIZE(eq5p_functions_a),
> +};
> +
> +static const struct eq5p_match eq5p_match_b = {
> +	.regs = {
> +		[EQ5P_PD] = 0x0C8,
> +		[EQ5P_PU] = 0x0CC,
> +		[EQ5P_DS_LOW] = 0x0D8,
> +		[EQ5P_DS_HIGH] = 0x0DC,
> +		[EQ5P_IOCR] = 0x0B4,
> +	},
> +	.pins = eq5p_pins_b,
> +	.npins = ARRAY_SIZE(eq5p_pins_b),
> +	.funcs = eq5p_functions_b,
> +	.nfuncs = ARRAY_SIZE(eq5p_functions_b),
> +};
> +
> +static const struct of_device_id eq5p_match[] = {
> +	{ .compatible = "mobileye,eyeq5-a-pinctrl", .data = &eq5p_match_a },
> +	{ .compatible = "mobileye,eyeq5-b-pinctrl", .data = &eq5p_match_b },
> +	{},
> +};
> +
> +static struct platform_driver eq5p_driver = {
> +	.driver = {
> +		.name = "eyeq5-pinctrl",
> +		.of_match_table = eq5p_match,
> +	},
> +	.probe = eq5p_probe,
> +};
> +
> +static int __init eq5p_init(void)
> +{
> +	return platform_driver_register(&eq5p_driver);
> +}
> +core_initcall(eq5p_init);

No, pins are not a core_initcall. This could be arch_initcall, but
considering you depend on the parent this must be module driver.

Even from this dependency point of view your initcalls are totally wrong
and will lead to issues.

Best regards,
Krzysztof


