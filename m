Return-Path: <linux-kernel+bounces-80700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2629D866B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12622815EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9761C2A5;
	Mon, 26 Feb 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrqQizda"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9251BF2F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934074; cv=none; b=dyT9ISKxlpVEVU0NKFnQQAkglgqpKmSxYD/E1l25HLZdhPZSG6aWcVC+XbWWnPH4dcLT2kvonkzq9IBs3/ltIlkg3fdFNJC7Ygoeh0sTTCapMlYFzM77lguzTRKRNS5ka7JYyidfTRHIQYX4hg8M8VJbm5PgsDSt2b3OL4muQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934074; c=relaxed/simple;
	bh=G5KOtPDbpnAFOpFzpaTSqNX7Tz4AFEc+OIzZeezuDr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZda2zBqVMn1iBhesIbKgoureIFXtZRwXx0vwcod7VdTdg2pnvizXJ994CAtHBB9YFdTCyuX+9fw9ooutF2SkV0SD98w+KBM7UVq/J5+4asK7L9ZcJfEloRkg4c8aqVmUJF0XP55gnT0arb+2GuxyISWtMqKR3ccRL/dflLnd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TrqQizda; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4348aaa705so74281966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708934071; x=1709538871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbQEFDf7xkN53excRVfl59sUr+LDuUA3URXOCRzV1z8=;
        b=TrqQizdaTU2kdsZRM2UMFe+erNbzVhymTvOiMMu1sL85ZgF3X72GwuMpRTtS5KWJiN
         SsXSV24E2CXM3dwmLyQZ+07VCxGYSNF1XT6aTyeXeBZYZu3GOrfRLruzgw61BjeujMYU
         3H8DtANSA9t8K/xiv2nSTB+mENe1LKzTH1AnFmRAEEUELZPDqCpnjXi5ORPs2WhhlBIj
         oXkbfISHhMERHo4v6z84haaFITHpzpJRY8RtDwniSakb3fIGNB/30XGDr7BuMNdr/Fia
         MfYd8ssvjIzBVOzRjuQ1N+sMAV1v3W2C0mvwwDu22+mpxu4lIF+rjgPA+XodGapUa/Un
         EQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934071; x=1709538871;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbQEFDf7xkN53excRVfl59sUr+LDuUA3URXOCRzV1z8=;
        b=BwO24b0oRwjUm7KcRBkXpmeNsL7vDKRsNX3hBoE7TvaQGC7tF1KXqYbWxcQvJdJE/L
         wOcnuyymDxQzGdNzZ2hhMQhO7EnG8GkS0Eq7GBvfgMdie5RlfU8/jIW7omvETOCuQKEQ
         5dsM/r1RcPJom+tiovv5vOycIpfJ/sAUHn2RIfHmR2xn0A83c+b/9MfGSo4q/d785vYD
         cN6ZKCH+jDzizxuOmpXYXLrlkUrfY+iblJAGqoF/4yhePVgoUDNxg6kjYe05JZdjEIrF
         ksUxbleZSot9EGrzGQTk1pi4cLonJ8hPYQKXGxKLRYx0HuH9btIlAfYWphXoZ+CSwuwV
         DVWw==
X-Forwarded-Encrypted: i=1; AJvYcCUxo/qmlEcUEZPLbtH9troIantfw3hvA6OUn6EKT4iB93rRAvmDO9TLEMPBFBAt7xV8Ur/88X5VU+lUpBJl56Eg1nmGddu3QJAxxL6d
X-Gm-Message-State: AOJu0YwyR/LyyCvNre+fzkCajwSlQkyoX8bQAerU2807aX5hFp5dA2jJ
	nZp4OFx+EAWWzFs/+3zIhAY4ap7H1JJOYg5EZ2eREHZ8qzNSXfMz0CGIY1Y9FsU=
X-Google-Smtp-Source: AGHT+IH3+zlRhHgufUywyLyswVKOQJQDCv1xR/RwWvblgkIKWTxcusx3WC/q/IejnnrgZJIAixSxuQ==
X-Received: by 2002:a17:906:e1b:b0:a3f:1e62:2674 with SMTP id l27-20020a1709060e1b00b00a3f1e622674mr4190082eji.48.1708934071273;
        Sun, 25 Feb 2024 23:54:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vg9-20020a170907d30900b00a42ec389486sm2115596ejc.207.2024.02.25.23.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 23:54:30 -0800 (PST)
Message-ID: <2fd7a1e7-4f49-4c22-8252-7f6cbd989f49@linaro.org>
Date: Mon, 26 Feb 2024 08:54:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: forbidden405@outlook.com, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-5-eea68f93f090@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240222-net-v4-5-eea68f93f090@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Register the sub MDIO bus if it is found. Also implement the internal
> PHY reset procedure as needed.
> 


> +	ret = clk_bulk_prepare_enable(CLK_NUM, priv->clks);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable clk bulk: %d\n", ret);
> +		return ret;
> +	}
>  
> -	clk_prepare_enable(priv->clk);
>  	if (priv->phy_rst)
>  		hisi_femac_phy_reset(priv);
>  
> @@ -948,6 +993,7 @@ static const struct of_device_id hisi_femac_match[] = {
>  	{.compatible = "hisilicon,hisi-femac-v1",},
>  	{.compatible = "hisilicon,hisi-femac-v2",},
>  	{.compatible = "hisilicon,hi3516cv300-femac",},
> +	{.compatible = "hisilicon,hi3798mv200-femac",},

What's the point of growing the list? All are fully compatible according
to your match table.

Stop growing it and either express compatibility or use proper match
data, if they are not compatible.

Best regards,
Krzysztof


