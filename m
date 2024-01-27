Return-Path: <linux-kernel+bounces-41045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A698D83EAB0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EC0B2640B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C359475;
	Sat, 27 Jan 2024 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6b5sBLL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8971171A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706327303; cv=none; b=R7ZCO20hacyLbEl98Rdy/IQ3iQCokRSNK8aBwAEyI6nmyP+9xz9WbKuJ+6AKluKX35Uxuu/1NJmqDQQ/bHweZeMuip6Wi/Dcc5qbH5QkOhBDiAM1Cw7CI+r0CwoT6OOJr7MuMbVfKcRXdHgDCnnYgrZu4ON8Fa5uQGRPhtAYKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706327303; c=relaxed/simple;
	bh=I52GhTCmPvPY6McnPJul8fpNcyDEtefKHQkoHzciHE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEupAeWI1Zc5NKGdlgpXL7tREwPyu1HJpuiFofPKlAa17SCe/FAfrFVQicn6MTsgpUEzXBvWzrRd4fIMitLQHyuZWXxBYA1ThOTXyUt80Xkkj+wCjW1Fc89Lo+so8Ybg3UwaSEYVlQfnThDqxZSF9MQnnGKB329M7Iv1h8jWUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U6b5sBLL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a277339dcf4so90749066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706327300; x=1706932100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGOiz2BIpCS5BRwhbbDOvMFdiaSjuzcJzAunOII+sqk=;
        b=U6b5sBLLXVghd+SiFHocPoMCZYFf932/wfu8ooZAKZSaT3jQhLO4Wj+w8PXT0TbGoX
         66jQ0ojZeaEMNRLCeMP26CR4fard+99NqBPQVzGnkaVquN6OCXJlANMWXDsWRtt4Jiw4
         XuQoWzLbfGgoOYbjec6canc8jXaJ3FtfilPOoswoCj+CbZwEUIt0OFz6clhskwtcbPq9
         LDa28z9M3Jkwvm66RZ0UsARPj4eHSlIrH1UfqD9slpBMq6/MEEuEGEdFESRGw/QCXfK4
         45BtFV6+n+JzoNNAhAyk7/ynZaB3Q+9olxxVEMYj5YzPCCy7AvndvP/Qn5BfJ21Wc1on
         HlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706327300; x=1706932100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGOiz2BIpCS5BRwhbbDOvMFdiaSjuzcJzAunOII+sqk=;
        b=AZc8mleHJnhZ6k9AsVzVioBcZPFkDHC6y33xDFQYMhkNaYpXwEF6DNTA2M+bobqLtV
         18qZ+lBSZXfcCTkQQn2uqHhf98vYl3R36reGEWJqc7LQk0K2qIaU0qCvqBW1FiLq9eIW
         FZCoLvN3QaZbKjklVq3mkaKC6NuGsN0WHdET9nYdmdXQGWRjHHK0amLxbfjGIfe9H/pD
         sL+Wx3G7nLO+xSR/doIIrbNdnqtiguQJPB6/V8a+u7qPjZlmSwgWbmCTtfzlp85iMLgo
         uwCqfzdrTAyS5TmxpuSJyixCmtXdU9+KVcdDcomU5Jm+O4LjmbOD3MkO7XVMsSsaU387
         3t0A==
X-Gm-Message-State: AOJu0Yyde0K7L6/ySoddOuk6Tjpw9tChUyriP3hruh7fuMknBb06ODSb
	R8kK2sgLVp9/j205YWSOP8zktCVLEenNpQOHZyfkJWxWy91CFM8iYiwZXzJi0MQ=
X-Google-Smtp-Source: AGHT+IE279fNC4zsCFfWk/XuSa41cI+pdfY+0IsRQyFSl8lYOWU/VQRkp6AdeuHR5k20q+w8ySp7kA==
X-Received: by 2002:a17:906:46d8:b0:a31:953:5869 with SMTP id k24-20020a17090646d800b00a3109535869mr450482ejs.53.1706327299691;
        Fri, 26 Jan 2024 19:48:19 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id zo11-20020a170906ff4b00b00a316ecc4badsm1300651ejb.56.2024.01.26.19.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 19:48:19 -0800 (PST)
Message-ID: <e8245820-8e71-4336-b050-cd9e0f072af1@linaro.org>
Date: Sat, 27 Jan 2024 03:48:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: exynos: gs101: fix usi8 default mode
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
References: <20240127003607.501086-1-andre.draszik@linaro.org>
 <20240127003607.501086-3-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240127003607.501086-3-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/27/24 00:35, André Draszik wrote:
> While commit 6d44d1a1fb62 ("arm64: dts: exynos: gs101: define USI8 with
> I2C configuration") states that the USI8 CONFIG is 0 at reset, the boot
> loader has configured it by the time Linux runs and it has a different
> value at this stage.
> 

ah, I didn't think about this, nor checked it.

> Since we want board DTS files to explicitly select the mode, we should
> set it to none here so as to ensure things don't work by accident and
> to make it clear that board DTS actually need to set the mode based on
> the configuration.
> 
> Fixes: 6d44d1a1fb62 ("arm64: dts: exynos: gs101: define USI8 with I2C configuration")
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index aaac04df5e65..bc251e565be6 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -384,6 +384,7 @@ usi8: usi@109700c0 {
>  				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>;
>  			clock-names = "pclk", "ipclk";
>  			samsung,sysreg = <&sysreg_peric0 0x101c>;
> +			samsung,mode = <USI_V2_NONE>;
>  			status = "disabled";
>  
>  			hsi2c_8: i2c@10970000 {

