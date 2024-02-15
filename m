Return-Path: <linux-kernel+bounces-67559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F9856D76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610551F2506B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82E139587;
	Thu, 15 Feb 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mU6mpivB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCD12BEAF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024515; cv=none; b=d3Ib6S+FBdxH5znFxVKZa0VEo7yRcWkVf1VGC4c/NQnH9q1F/lD+YzW1MdQWuy8bx9KgC1gKqAfadZlZN+aG2T3n0BnDLeUWQ73hm2bHYvbhLXlk+jvzFk1C+eyb+U/uVJKiqGjGqpFmJH9NVKBXR/1ftJIcCZe66/MXUcIh9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024515; c=relaxed/simple;
	bh=RWn2sDTInPL6ORCFVxTvBqxT4MyC2F+J6tkFP65XU1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4Xiu/s10tM/xYKD7EDA7p+2riI7rK0mYWbOGu4gkjFc9rUjgJ1uPJEfMkQ2aqEfrzoIcClEb6em/lWCpU/+yuxFLnS3eFN4bPX5Ai3k8Y8lzKJ6km0Y5e4JdRx+L69lAqQuIwfpT/LtNibFJl9cMq1c9Iyz8t9q1lDQBWdd36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mU6mpivB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3c2efff32aso150174866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708024511; x=1708629311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03bx4h6W54n3ll8KPUGR6EpaQLp3pZs4yWzEKDL4cxo=;
        b=mU6mpivBWtfdgL6bfMHAGgbR+pygyy+4K3TIlWzhiXQFhpdBEBpt18KMj1K57bgmjn
         2OFzdpD1QZ7lZHcZ5g3CWtWtMJHrF6uvQKPMt07S6VghluCJPCwn6AMXCCLOrWaf5vG1
         VYtpkv/iS+FpsOIaR8AGTqeB0RNTCM6xuRyNSr3jeBXOfT2EQXQZtpUYPN425SYzakDA
         2OidvfHQkSGi/qoCyZs/Oh1dXfcCoL8x/KyGvy9aY2aHrUkJfaOq/J0VzK5vjZrf72rY
         6swqvV140EwxqL5gbo/7Bl5aF8IVi7OXnDPt6GN240UVWXr9a5olLainx+gSxfBwWYvA
         z+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024511; x=1708629311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03bx4h6W54n3ll8KPUGR6EpaQLp3pZs4yWzEKDL4cxo=;
        b=eeEWeO2NZ+R52nUOaeF5wqDqsbhX0zvnkegrAD0w2BaYLQF6PJsDMRWDVpnL0Vkr0P
         GWS4HZSr9MP4CGm9UsOc2Gmjh/x262m7dvmc/EhkRrDR6gasSmIzpox2WTRTOAL5/Hnk
         Jashg6bZQu7Anw3Z/th5tdlOlFPBG2WoDwhmrtHTIGibZPAj1sg+xN1fGxMItqnSwqXQ
         fqcBd6qqRcWKsXs3o9FmrWkD1VuSvQqNVEUMKTIaWbscQKss8CIn7OsMjJ+7Ic5Pk2d1
         P1lQHakiKbLTLWQhI4LOO/t3o8AkM4yRBfa8wjYdMIum91rIE9qXYC2B+c7uICKkeb9i
         gLWw==
X-Forwarded-Encrypted: i=1; AJvYcCVtYYkUDt1++dqFsDAb7k8TQa0DZrw+LZG9mPh0mbdGojbhoh1Naycc8Qkr1ZhToAnhhJ0rxQPG1IsRSoA3URaHMEhc8AfD1qOWlSmO
X-Gm-Message-State: AOJu0YxxFtdEFYjBEMmp79w5+FOgFQBsAAnKmWNHOtlw234EG16YwsF3
	TuF/jLqg0N3N+e9pcNCvJB4yfYgotummdxVCJMUgKEVbwSVEm1an2kDsq4sc1dQ=
X-Google-Smtp-Source: AGHT+IEJ7DK/FPBdmOR3PEhbFxksznsSYht8YW3TLpX0t+JbHP1akj0nyARCL6mHmiNqyScCJy/Fug==
X-Received: by 2002:a17:906:c13:b0:a3d:45ca:679e with SMTP id s19-20020a1709060c1300b00a3d45ca679emr1899556ejf.58.1708024511060;
        Thu, 15 Feb 2024 11:15:11 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id op27-20020a170906bcfb00b00a3d11908bbcsm825959ejb.203.2024.02.15.11.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:15:10 -0800 (PST)
Message-ID: <682f2d6e-31fb-418c-9622-d3e5ebd4ee7f@linaro.org>
Date: Thu, 15 Feb 2024 20:15:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
Content-Language: en-US
To: forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 18:46, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Add support for Hi3798MV200 specific extension.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>


> +
> +static int dw_mci_hi3798mv200_init(struct dw_mci *host)
> +{
> +	struct dw_mci_hi3798mv200_priv *priv;
> +	struct device_node *np = host->dev->of_node;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
> +
> +	priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
> +	if (IS_ERR(priv->sample_clk)) {
> +		dev_err(host->dev, "failed to get enabled ciu-sample clock\n");

syntax is: return dev_err_probe()

> +		return PTR_ERR(priv->sample_clk);
> +	}
> +
> +	priv->drive_clk = devm_clk_get_enabled(host->dev, "ciu-drive");
> +	if (IS_ERR(priv->drive_clk)) {
> +		dev_err(host->dev, "failed to get enabled ciu-drive clock\n");

syntax is: return dev_err_probe()

> +		return PTR_ERR(priv->drive_clk);
> +	}
> +
> +	priv->sap_dll_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
> +	if (IS_ERR(priv->sap_dll_reg)) {
> +		dev_err(host->dev, "failed to get sap-dll-reg\n");

syntax is: return dev_err_probe()

> +		return PTR_ERR(priv->sap_dll_reg);
> +	}
> +
> +	host->priv = priv;
> +	return 0;
> +}
> +

...

> +
> +MODULE_DEVICE_TABLE(of, dw_mci_hi3798mv200_match);
> +static struct platform_driver dw_mci_hi3798mv200_driver = {
> +	.probe = dw_mci_hi3798mv200_probe,
> +	.remove_new = dw_mci_hi3798mv200_remove,
> +	.driver = {
> +		.name = "dwmmc_hi3798mv200",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table = dw_mci_hi3798mv200_match,
> +	},
> +};
> +module_platform_driver(dw_mci_hi3798mv200_driver);
> +
> +MODULE_DESCRIPTION("HiSilicon Hi3798MV200 Specific DW-MSHC Driver Extension");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:dwmmc_hi3798mv200");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.

> 

Best regards,
Krzysztof


