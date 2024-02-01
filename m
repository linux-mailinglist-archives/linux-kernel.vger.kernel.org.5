Return-Path: <linux-kernel+bounces-47966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA7845564
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB27B1C240DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478953A1BB;
	Thu,  1 Feb 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEuoIlVs"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922714DA05
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783472; cv=none; b=CNnt1Ts4EZ6LEz8uSZoWvpki3ShhDA0t1ei2DLc8d6yN55dbmMiHbS1CxbE0GYiCApsxNhfk49Lykdl5ntHxvYKxveYmQhjBH1DiGjxOv8ilHw5+M9+WNccZ2kZCKH12z5IeikriioVbc0rJvhH/3NQhVmEdGt6xDCO4aGzA1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783472; c=relaxed/simple;
	bh=56dGwm2oE9j9GXv7oUo5ziEJmv9YXFq07zikp2GU5hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsX+E/aI/ESAjzCbl1Rhko70xr/e1nPO+EIu8ZbQ6Di+fi1Ej3gKldI8VPfFvUbUrgH6PHBsYHFFCG7XtGkTSz3hHq1t7gRzFKMTgJohNQl6mgiz+cSdP79b27xFowIZ8X3lUbKfnaq9iHNsltsVDqhl+gv4ZN1RjEfCjEuao/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wEuoIlVs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so912300a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706783468; x=1707388268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErwkxjalVwnXMJfMcEKbiOjhMjqyzs2J4ZdFwBtH0+g=;
        b=wEuoIlVsCtZOkeNaQDC8CLMbct9RhBYpVhoNABgEISbV7wJgSFggfEXy4K1LUJHZGQ
         3vKwo2ekyaqE0c3p8uTwYYem08qSj8T7SFFAvIuJ23NcQddA6BucGvDYXgufuNuXDdba
         O41eVQNl8xKN2kFlRavaesN39IyfJKrkCau8+rmZTXFfoi7G7x3XbZpVzjdpQQ8jbD+n
         aOmQkj2c/DlR9hWjIF2ElvcFm4WcliYgPG7vn6E6/hDLSg7OgL/litU1bpmm6hFcIkme
         vtPBWyFelZxNQuiWmzgSlTrVVzGl3pZPTKi2YM0lTq3tEb/9+nlvov3vbzJz4XEqsof/
         8Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706783468; x=1707388268;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErwkxjalVwnXMJfMcEKbiOjhMjqyzs2J4ZdFwBtH0+g=;
        b=k8Ugv+yGZxS2VEZSD9hvZwO1lRjetNaZR/IXyr0GjvJYb0BVcBZ/9njy3SglySCOVV
         iSMNhApK6tITwA7MpHJUodC0+HsMThQ+pRSrAybosZvZqjK6HkoyCrswhvJCv0VJ3HEF
         98EOgugQgjtN1cSk/U2gu4AWu/VZda6WwSEBUMeqno6LeS8hkX2pqA0Mfab+1f3SIqON
         AbYjB2piIKQow+bW7okRk99RpInhCvgKU6fexuxO5LiAmV6Rsd4G5gLjCVtLJLsMGNHt
         yakGEEKsPT63JvG7EPnGiPHPSISP95fPXTrQoh1pryFEvRw+cA2AWFvPquoU1TbQINdt
         QEdQ==
X-Gm-Message-State: AOJu0YxhfIR/5I6KfaCOh/tp3XGopIeIqoRZO0PFjqjVyRFgxK2m3jiq
	CTCmvVbJj1G3qcrToznJCgNffH7BiStlmre7wsN6dXY0jEo2/Vch0Nv8C+FwNyA=
X-Google-Smtp-Source: AGHT+IHHHqDDiBFUrqiFtvcmxMYaTzKRdgnq4x6ymQkK9H1i3KOysHd20DADcB+RO93Is1v9eG/epQ==
X-Received: by 2002:aa7:d341:0:b0:55f:c9cb:2089 with SMTP id m1-20020aa7d341000000b0055fc9cb2089mr358584edr.37.1706783467824;
        Thu, 01 Feb 2024 02:31:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWcuG5NQqW5PpVoX2+qKGPl5qa+r9Ty1Jip1KLD2qdxdYdhNJsHj1P0gUrac9h4ryhVFIUmaltj8vL+HpmpIi8Oe4llH5UPpghwWHSezX1HXCBloJ70De1fl9FGA1HSKDSd6vrm+t3t4Q83jkNGYW5aGEZEpqQNgb7xx/TE6JTi+OMgh1nMN0sMqnW9pyPOY2ihEglnfGOw/b62urJS/Adu1uwPe2mQIWO6YNID8MWbBTY8NGlMcZGqJIC9/2hbRQABczvNd5i3iDoPfgCuflmUqTKB8VO/3BEIsRnrK06v6nhH6vc1zFClbFzw3Q03dzFAJdGaQ8u8iy97SzATuFwt1U7F4PmV6P2ve4tMVKM7wgOi0ezpQGpwi1PwC2oCskm/6y6wWNuKWx3l1pYBv4nH9O1arTyIbAWfncrCr4nrhje1NJlwy2WpFC7JUt66ZWkqsLkLh7WB4tcEiIyuCrWtyWHx/Y+M3ytudoXrpNKWvwzxCmdwgno=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0055eeb5f0efcsm4455932edb.58.2024.02.01.02.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 02:31:07 -0800 (PST)
Message-ID: <cd9ca36f-84f6-4cc7-bc1e-a4c5781d2bf2@linaro.org>
Date: Thu, 1 Feb 2024 11:31:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: exynos: Add SPI nodes for Exynos850
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240125013858.3986-1-semen.protsenko@linaro.org>
 <20240125013858.3986-4-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240125013858.3986-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 02:38, Sam Protsenko wrote:
> Some USI blocks can be configured as SPI controllers. Add corresponding
> SPI nodes to Exynos850 SoC device tree.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Sorted pinctrl properties properly
> 
>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 54 +++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> index 618bc674896e..ca257da74b50 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -738,6 +738,24 @@ usi_spi_0: usi@139400c0 {
>  				 <&cmu_peri CLK_GOUT_SPI0_IPCLK>;
>  			clock-names = "pclk", "ipclk";
>  			status = "disabled";
> +
> +			spi_0: spi@13940000 {
> +				compatible = "samsung,exynos850-spi";
> +				reg = <0x13940000 0x30>;
> +				interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&spi0_pins>;
> +				pinctrl-names = "default";
> +				clocks = <&cmu_peri CLK_GOUT_SPI0_IPCLK>,
> +					 <&cmu_peri CLK_GOUT_SPI0_PCLK>;
> +				clock-names = "spi_busclk0", "spi";
> +				samsung,spi-src-clk = <0>;
> +				dmas = <&pdma0 5>, <&pdma0 4>;
> +				dma-names = "tx", "rx";
> +				num-cs = <1>;

For the future: please keep properties sorted by name, so clocks+name,
dmas+name, interrupts, pinctrl+name, more-or-less matching DTS coding
style. address/size cells can go to the end.

Best regards,
Krzysztof


