Return-Path: <linux-kernel+bounces-65975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F6855499
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9188E1C21076
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5413EFF3;
	Wed, 14 Feb 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTlX+2vK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B4134740
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945518; cv=none; b=oPlJuRHyKamlMdJBXGOJEzYS9O3GgXSMv9yuiq6xh2P56isZiCPm/0ZNDZDSS5vtsMzKwV7Hot2dxdIZykNo+2fTzEH5zp9kwiDMg+Y6JcaojmjuHagJGkktK7UDjf48ppnoUlrMWraHYa71cDpu9UYVUFwboBLalz9GkYOzawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945518; c=relaxed/simple;
	bh=I9ZUxJJlafK0c3Z5PqT0rjC/48W7vAcuBMONCXbH/48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/QWcdsUiecSDBKab8tDtX1dYlMoGgdqJasyumTYmNQFceH6ldhvprn4NcXhahzrs/bbUYloroXDiVe5EvIUbJsxCy/JMTqBMZ11GXwBbmMVclgEjyNkdW/YIGAKMNaULxGC6TBLbAbhhUwcwnJIq0eamSVqEz8+U+K9DwR01Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KTlX+2vK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511831801f3so164604e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945515; x=1708550315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRyBUtzXbW0kgRi+8+Ri/hdHNlvzaJxlrnrYNx31b84=;
        b=KTlX+2vKTEtfE+pFrN+l7ZVs3N7IXxkBzl6D52YpAAcEVPKzqJoy9kdlRX6sVpvefe
         VqM9/jcXeQi2KcxU+5Bly47ndZ/TSzLcAY/VRrsD219Zp76sBKmHBJ8QhQrKRxiQH6TQ
         3i8ifBrdHymi/BqUj4CRp7QGfDfFUwluJ0oXPHnOOQEZst2rShC09+rBrlxrUpuWVpxJ
         xzXiPSsnQokryoTVuNnYlugfgvXJEfeYsbOoOayOWyEnff51q1CS0QuNJEIEr2x+yrIb
         olUe0Kc+SyBmWxF2r4n2rdwHP/oIxDHp7g121RBkwef4/gYRAHt79sGNr1BFHrgsxlux
         LvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945515; x=1708550315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRyBUtzXbW0kgRi+8+Ri/hdHNlvzaJxlrnrYNx31b84=;
        b=FQR4DHRGVyu99JEbAwBZzuqB7QnMQe+x9pz9FTaqhv5H8R3+hAS5AiD6u5/o0nWiwM
         mufdGb8bM/PqrhAPAdQ0G9/HWl/09e5Q2DshyHcTfLHcwAvt8fHORte8wJKLACpBy0LY
         +8hpDb+NK2cXq03bIEKv2hEfagOpSZyvlsA6OVHhJ66wXWJ/8U2ODdmp8UPCRWBOih9F
         ySTrpPyk9EaiG3NWKjymvQStTMvOyU6Y5r9wttJA3jmIvAX3Sj3pwU2v7+mfp4t0P/W1
         0hVZnsGatE7wGDPm5k/Et9nU516gozPanuSzNvTyLk219D7qPvjocq+F4ArwBOu4Br78
         BIrg==
X-Forwarded-Encrypted: i=1; AJvYcCWZiyRJPqxrtijyDeRLWNihd9lui+ye8IERXC/SvcokMk1JfYusZdiYA8+gA4ExiXi7F6qiCmn7Hs0lq4qD+7DzOojpbVhSSK2tcPl0
X-Gm-Message-State: AOJu0YzKSvgTX+4N4DX8RpmcCjybV2W8ymGstUgJIRF15+K3Mv/kuV2h
	0LPiOvAVdy+XYPcOB2RDCIrlYzhg+0AgbpmpJ9SFJd1nT22Ws0lrm9IwTaWeyGw=
X-Google-Smtp-Source: AGHT+IEJzS+a/N0hEePfei4g8rF7eBX5FU0IitrV848R3OKkMmnBlNczo0RLXpoyy0ZZiZ3TvdWT2A==
X-Received: by 2002:a19:c20c:0:b0:511:977b:3103 with SMTP id l12-20020a19c20c000000b00511977b3103mr7920lfc.15.1707945514686;
        Wed, 14 Feb 2024 13:18:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0Xe7Z87iFYT+ScCrOZSQ2nZNL3AUE0yfC1zxuFl25IsRPLCQr74wTZ2Y+mW/tx//Hhm1LQGV1v67zal/mFt9D+kww4sCBkvOBbgNMY0I3k7N+QcvZCS0yRjFS/w51GBoLFB2ezPDfIy6fHb/1YzFUzWZY7nUkLGwyQ/6RfjyJktwt2Z8Pd+QNL/aK1ZW4FWGOKjp4k8Fb0MlBHBeXniKyQeFUiYkFJoDc+v8qEIM3WCRsW93a1xmWhCNHP5cCKO7Mr/XgVqeSEfhrZwHApg9SotLteadQWHNgOwmOGVq5d+9tp1c1d9KBJbncGviFDpygCO2BLaQcgnQ1/yJhKb/5gI7KRZhOOA6Z/eROdUvSywQNLhu6CyT5KspD+zAuYtwQLWXk1fMwNdBzBm9ya4y+iP42sEiJp9VMvfv2hwzqO0xRUVC7AgaIxAapeZdZC995RMHop2RbTMOUExs8I5LNntPkAiAV9bE=
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id mj18-20020a170906af9200b00a3d3fde216dsm1006846ejb.217.2024.02.14.13.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:18:34 -0800 (PST)
Message-ID: <d9d8e86b-a499-49d1-90ad-6fae5b7dcbb7@linaro.org>
Date: Wed, 14 Feb 2024 22:18:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/4] spmi: pmic-arb: Make core resources acquiring
 a version operation
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
 <20240214-spmi-multi-master-support-v3-3-0bae0ef04faf@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240214-spmi-multi-master-support-v3-3-0bae0ef04faf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.02.2024 22:13, Abel Vesa wrote:
> Rather than setting up the core, obsrv and chnls in probe by using
> version specific conditionals, add a dedicated "get_core_resources"
> version specific op and move the acquiring in there.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/spmi/spmi-pmic-arb.c | 111 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 78 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 23939c0d225f..489556467a4c 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -203,6 +203,7 @@ struct spmi_pmic_arb {
>   */
>  struct pmic_arb_ver_ops {
>  	const char *ver_str;
> +	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
>  	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
>  	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
>  	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
> @@ -956,6 +957,19 @@ static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
>  	return 0;
>  }
>  
> +static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
> +					  void __iomem *core)
> +{
> +	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
> +
> +	pmic_arb->wr_base = core;
> +	pmic_arb->rd_base = core;
> +
> +	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
> +
> +	return 0;
> +}
> +
>  static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
>  {
>  	u32 *mapping_table;
> @@ -1063,6 +1077,41 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>  	return apid;
>  }
>  
> +static int pmic_arb_get_obsrvr_chnls_v2(struct platform_device *pdev)
> +{
> +	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,

It's no longer indented to deep, no need to keep such aggressive wrapping

> +					   "obsrvr");
> +	pmic_arb->rd_base = devm_ioremap(dev, res->start,
> +					 resource_size(res));
> +	if (IS_ERR(pmic_arb->rd_base))
> +		return PTR_ERR(pmic_arb->rd_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "chnls");
> +	pmic_arb->wr_base = devm_ioremap(dev, res->start,
> +					 resource_size(res));
> +	if (IS_ERR(pmic_arb->wr_base))
> +		return PTR_ERR(pmic_arb->wr_base);

Could probably make it "devm_platform_get_and_ioremap_resource "

Konrad

