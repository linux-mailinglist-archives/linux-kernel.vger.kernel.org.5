Return-Path: <linux-kernel+bounces-79568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BEC86244D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13AC1F21914
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B7822301;
	Sat, 24 Feb 2024 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvM4iiLn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85D12B7B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708771001; cv=none; b=c8pqqSeNfCXgPgzGAWNddnEVwfJYBeAEi5cgIML8HCYtYh30cC7o84j1zdaVHvuWb3nQ/5FQ8WoqlbkMaYRG8WtP/Yho+dmDr/3xv/XGJyBdgwwNevAjAczyahCLYO7tVuZGJdeBB3mb1Ftz7FWJUi01IUvh0SyagDdPN/ZOFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708771001; c=relaxed/simple;
	bh=58adu5hvmmb2LOEQiDHsQjLazEwZVBt1UbSh0UkM2No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ST86bs6wjQLKtrEwLPL9HL5m6xPlmDcq60160wlQ639yRwCuDNT0UVigIXpICC/ERcpbgF9vuG+QBvG9xKH9B8hrwh6N2GDPxQNht9yZYXirgzHD8/86ELcrnY4msJeo4zZsAj7F3GQB1PCLU0Ti0mpY6Sf+SFs9Dxyj4Etwx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cvM4iiLn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so2041509a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708770996; x=1709375796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oywdlN7ttlpIa6C90/nFZJ1AJJorSsP7MnjdUxAPcfI=;
        b=cvM4iiLnm2HJ0QXVBt+rbbaaMsgYa7UE3KCX4pcLsgfVGBpD0colpOaaObMzlUkX5q
         uQ8SnEQYbp8A0LjXDcIzFPzd71A3W4Eo8QlpsnwMv85mxvsupKsu3dtlKCKcuhqlATNz
         uBrF0es1hsYVK2zxUfSXLxyFM+3Lq7xC3uFNTyd0yBxn4wBUG0+LL3WB6SfiCayH7FfM
         YeH41UezyadaqvhXAz45JPqWXmVgin5D48I6HCYdr2PqOZ28oYs/2H+gg7Y+6gtmzbz5
         l9fumB1urr0uxKldon25rf1AARbSLY6AOnRgRqNTFxXzEO7d/4f5SIWglqIjORLV4SLJ
         1Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708770996; x=1709375796;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oywdlN7ttlpIa6C90/nFZJ1AJJorSsP7MnjdUxAPcfI=;
        b=iqZJPCGU/ytmgL//FQEpaPdzhLMHiyrupBkdMnfXGMoRqiSFpC7Q3uZbcXgpXg92EF
         O3xC4zxXPef83tH4AKzNx4LB9nzRFtuz8r5Ib9KcnJGsvPVFyi1pvWWL+Uu2UKMpD0/4
         gQyIvrRgiFBae+b4uEMYhJraRxqvkElTC/Pk3BfILhgvZdAacHI+HzuzOc3gdF1EGHBI
         gLvZzWGMd8o4tmyV+u8Q7r/X9azxTuKh/JkmV9n2UQjfNd0kuPE8g86Hxxtvg6anH/2s
         drSH1JocRsapeGuODDxYVRfn9K7fTh3svi7Bq2AxUhVEN5PCU+vfKE5bVFvPI/BdO8Ki
         x3FA==
X-Forwarded-Encrypted: i=1; AJvYcCVvlJg+4OmCr+jTe4jE9Kb3BW0r8poaRZEnYjjr5fNMYBYSZHu5pVD2uMXbmKMu+1y6z4RDhc62b6VX1rTiRBXpihJ3E+mWEpVc3bzx
X-Gm-Message-State: AOJu0YzWS2scbFzKC+hDDSeReb8AgjU+95vXH+bNOyms3sy/bM1oYnO1
	o+XWzE3ENXJFltatdoWNqK9evEOuOMjXA+hRMzP00ZIf7nO7rrooRz/YT9sWQQo=
X-Google-Smtp-Source: AGHT+IFQ1CTLhVHev3X3ZsNIvWOvLmOq9DnNPyZNr2LsttwMkZxgcML6EMs7YR3aM8ssnQ0Gl1q6og==
X-Received: by 2002:a05:6402:5201:b0:565:a5e1:3a12 with SMTP id s1-20020a056402520100b00565a5e13a12mr740380edd.3.1708770996394;
        Sat, 24 Feb 2024 02:36:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id k1-20020a05640212c100b005653fe3f180sm416424edx.70.2024.02.24.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 02:36:35 -0800 (PST)
Message-ID: <fb14acfa-5b43-4ce7-93f4-9f6681152ca7@linaro.org>
Date: Sat, 24 Feb 2024 11:36:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
 <20240223-archer-ax55-v1-v1-2-99f8fa2c3858@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240223-archer-ax55-v1-v1-2-99f8fa2c3858@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 09:17, Gabor Juhos wrote:
> Add device tree source for the TP-Link Archer AX55 v1 [1]
> which is a dual-band WiFi router based on the IPQ5018 SoC.
> 
> At the moment, only the UART, the GPIO LEDs and buttons
> are usable, but it makes it possible to boot an initramfs
> image on the device.
> 
> The device tree can be extended in the future, once support
> for other periherals will be available for the platform.
> 
> 1. https://www.tp-link.com/en/home-networking/wifi-router/archer-ax55/v1/
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Note: running 'make CHECK_DTBS=y qcom/ipq5018-tplink-archer-ax55-v1.dtb'
> shows the following:
> 
>     DTC_CHK arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb
>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names:0: 'pwr_event' was expected
>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
>   <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
>   	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> 
> This is not caused by the new device tree per se but comes from
> the usb@8af8800 node defined in ipq5018.dtsi. Running the check
> on 'qcom/ipq5018-rdp432-c2.dtb' shows the same.

Thanks for noticing and describing. Appreciated!

> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 133 +++++++++++++++++++++
>  2 files changed, 134 insertions(+)

..

> +
> +		button-wps {
> +			debounce-interval = <60>;
> +			gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +		};
> +	};
> +};
> +
> +&blsp1_uart1 {
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	button_pins: button-pins-state {
> +		pins = "gpio25", "gpio31";
> +		bias-pull-up;
> +		drive-strength = <8>;
> +		function = "gpio";

Usually we keep 'function' as second property, after 'pins', but there
is no need to send new version just for that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


