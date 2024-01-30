Return-Path: <linux-kernel+bounces-44215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310AB841F21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74ADB2A1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD160241;
	Tue, 30 Jan 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNwNUHtP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A786605B2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605915; cv=none; b=PSq7JZcW3ff0/02ZrOvPzyyr9NRiY558drMn3AfzbaAsfjqnoQ1iJYQPAwRFXzLWrY+LpeqYrjC//62VvjZJ3Vr1lSloBkrwTG2it31UoiyW1n8g9HhmIpP0hUIUaoUW+5MyvBDbYj8yZ2IW+tjS+2dRWl7n/7wn0lPbV0cCq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605915; c=relaxed/simple;
	bh=mg13l6GoIYbaIsT206+Ed4s9MWuDP+u3gPMxCKTqenA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAZgD7nuKPfil4LyxZTbY3J5PXfrnFTfMsR1ndRBx+7/67xFtvU7wtPkmBdvLbRXaeQOkq7lSrNTayv5tePgEQDvbSZEnAOvv8epMQAKcOrNYo8rwAUw6HCxk1422f/7h+wPjKUwlfk5HjaSFw7C14zPx2uKXRwY588lM6iKt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNwNUHtP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so688344866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706605911; x=1707210711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0uzspMxyTAe1K1El4yqw3UnGLBxlhUfh6vxmuD6SvI=;
        b=rNwNUHtPt5sl998s0l65eQmK0XyBmwRtK3J9yrLWt+za4NqWmwxlrF0SPArOr3uC/P
         GkYsEAGM/iSn3EEwAk1ZRhFIjn23Kh+w6WfRwI3BmwDouMK3F8qClM/yEtTd+EXbvG2j
         ZnMGSWO9qW/QT0KPuU0koS6FQWD2+LID2RoGFnNHYzn1iYujzkd9VN7IxSYUfv2Cbt6G
         pn+CAS5mb7ui0nQ01woeOp8xf5bY+C1LZXstUiaNvrW/VrGGuwnKLDwWt+NujDlpi7N/
         OEZjHmEoPkbryBhaYVvVnm1kBaXZcwDolk5pAGaGPB2W38BKZ94KoHcB6gvuC6FSPtHP
         CePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605911; x=1707210711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0uzspMxyTAe1K1El4yqw3UnGLBxlhUfh6vxmuD6SvI=;
        b=jMWKieZF2h3Uwb3+XMH8+iNM3DYrU1yigIgUg2OSEt1kgPw+nZaQJ/JA5+vN2Hrp/7
         A1Icdo7+NOsuLagZ7qE4P0PXxpYbVqUxLEs2RW6eTWXGLRk1P95L50WtLQbfTXlX8MDX
         Xxb2IceLUhBauLSBeQuB9Q4wmqLoHS1bPP8/cMcn739+zK2/d1f2r4j/C8h8KA2bVEN6
         dWx64stWpBrhZEWQNW7Pz8lQBIxT/K2sWDm84+R7FLRK/CtYwof3IaNGNTeunPJWvJ3r
         wHJcY4mcYPtFk5Jmf3nSRZSJrnpO4SyOpHLNSMB3nVobp/fxMDNDlHtWRJ0CcIwf12N8
         6kQw==
X-Gm-Message-State: AOJu0YzuYokPTOiEHN5hlUECGUhraMzFb/sMv/7wpSSJ5A2BZod+EofW
	GEcMUnlZ19VY1zqFZHsHfTBy6tRRpiekh6iO0ZuobNXL70gRyOP0E0QUafPSPMc=
X-Google-Smtp-Source: AGHT+IHY75lv43WV7NtMQ5xrm3xMVd5ZHPUbyq3NYqVsdgPeWfMSMy1jjyvDwAwa/OPcCY10VkSgAg==
X-Received: by 2002:a17:907:a091:b0:a36:416:a365 with SMTP id hu17-20020a170907a09100b00a360416a365mr736648ejc.5.1706605911217;
        Tue, 30 Jan 2024 01:11:51 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id ss6-20020a170907c00600b00a3535b76c42sm3958064ejc.15.2024.01.30.01.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:11:50 -0800 (PST)
Message-ID: <354b72d7-ea53-4686-bfa6-023c632d8edd@linaro.org>
Date: Tue, 30 Jan 2024 09:11:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm64: dts: exynos: gs101: define USI12 with I2C
 configuration
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
 <20240129174703.1175426-7-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240129174703.1175426-7-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/24 17:46, André Draszik wrote:
> On the gs101-oriole board, i2c bus 12 has various USB-related
> controllers attached to it.
> 
> Note the selection of the USI protocol is intentionally left for the
> board dts file.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> 
> ---
> v2:
> * reorder pinctrl-0 & pinctrl-names
> * collect Reviewed-by: tags
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index e1bcf490309a..9876ecae0ad8 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -451,6 +451,36 @@ pinctrl_peric1: pinctrl@10c40000 {
>  			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH 0>;
>  		};
>  
> +		usi12: usi@10d500c0 {
> +			compatible = "google,gs101-usi",
> +				     "samsung,exynos850-usi";
> +			reg = <0x10d500c0 0x20>;
> +			ranges;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>,
> +				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>;
> +			clock-names = "pclk", "ipclk";
> +			samsung,sysreg = <&sysreg_peric1 0x1010>;
> +			samsung,mode = <USI_V2_NONE>;
> +			status = "disabled";
> +
> +			hsi2c_12: i2c@10d50000 {
> +				compatible = "google,gs101-hsi2c",
> +					     "samsung,exynosautov9-hsi2c";
> +				reg = <0x10d50000 0xc0>;
> +				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				pinctrl-0 = <&hsi2c12_bus>;
> +				pinctrl-names = "default";
> +				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>,
> +					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>;
> +				clock-names = "hsi2c", "hsi2c_pclk";
> +				status = "disabled";
> +			};
> +		};
> +
>  		pinctrl_hsi1: pinctrl@11840000 {
>  			compatible = "google,gs101-pinctrl";
>  			reg = <0x11840000 0x00001000>;

