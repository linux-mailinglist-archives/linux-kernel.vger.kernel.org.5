Return-Path: <linux-kernel+bounces-140392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ADA8A13CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C701F21817
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9A14AD31;
	Thu, 11 Apr 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7HJsMGy"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A7148307
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836794; cv=none; b=JdMSPAyi/9aVqicKEHmoXR2FoGNVFRthe/yhfUnlM/umELyYpoXNcozE2RApIz17B2X1P2NHbYQtHaxcuNURBUbhPIUkN7jA3dNwPpwiF8mh+qtU5spqEx4i5imna7LIWTnKZRK3M7eu7r5lNXFxCBZkykcJLy9wNTRtSY2mkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836794; c=relaxed/simple;
	bh=fS582YpI+pRlIqdC/4g7jLRnQ8WCGikH9yxEDM7WuQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZ1IRCT05UI9ggFfhBuQK5OnCK1euO3Jb+ZdcrrPCJODF+sXPfPXybNFYnpawySEo4HEzhYawrMGQOkbuspko+6frNkCZzP1YYfIiqDb0ZX9uOeW/HvlB+XP7PKgUpFcJvcVmbjpC7K/PUa7lXYhv8R6fQf+uzbY4UqTncFtYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7HJsMGy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso5516856f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712836791; x=1713441591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WeKuN3h/3Pb22y47aBZ3Pn5JtCjCnNRsOr2IK/NKbCQ=;
        b=W7HJsMGyz4BjavV62JAwBz7Zgsz6n7HBO0qo8wl0yErluhdiNYd+cgDj85HRWfl/mM
         xVBc/vwMehzk1SeOZ58J7NMxaA+jxugybn6p5jMJjyLXkfRHTOwuzj7hlImi79JgUL/7
         6gGsCS9kI8+wFDXQe7ZUacmWvfp/zyV6LmvyXHG8Z4V10n8My0XwYafLNmZz/9dW+5U3
         avdFOVolN5xaUY9g1yGw2V4g/N7DRG0Z4aL2BTEIvvukV1B5vZe1hIwmgH406ALfiygs
         88ErIeLUP1+scZ7AKEQOnigmpvAP1pKz5mvTl125jahgC2Zj8pq/tT7xE2bjCREKLrgp
         bvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836791; x=1713441591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeKuN3h/3Pb22y47aBZ3Pn5JtCjCnNRsOr2IK/NKbCQ=;
        b=iTloNSVgxXsCFbPJ5UgxNB/HPb2l6Yc8kIm3+WLiAi687MKDusDYNI2wDzLg1wsKgf
         Sj1NI69QgdiHtM76K4eEBhouhM21N6qFHOJxkKoIVq8agCxZYDgjs8VlDcbVim1S8YP1
         R/ZfMU4IOUWSoef4z6TiMZ0zRGGjiBS7u66xtq6dG+R+qIn/FmmFehcDmcVQ6Qbc1gYT
         aKHSo0qPL+/d7rhg6Enl3Griea+3lF0NsOLKmfTKJI1yJ5zWYrkbICcXgFyDq0AiBxpd
         piurUXymLUZAqbKuuN7sc1cKw2jrRF19PeAmi2lcKCR0XqQKzzZXQdAY5hofiHOo+OxU
         kz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnI1dBw62KPwI16ylK1Di6L5wr87Z8RIkCQdfjXVGtMKRFDTyhjsvJbEJ1Q26PZjpUdARCxIr5rucnu5dMv6eMCxr1LGE2n1cegoRk
X-Gm-Message-State: AOJu0Yy8HaTgL1Mji3cwca6MU8u58WFH859b8vbh6F4vyhY1A74mUCxl
	VNibcG3AkR4kU57FhGLudOF7/ruWYsoLQ4ftgY1LZdDXcnzhCUH5Ph9gBcT4eNA=
X-Google-Smtp-Source: AGHT+IGr/ycC3cYPwSszciZFAJofEPSOnqIDMBPJvXfvRrx+/F47kMyZ/5sM5UhzWb/hIZ4wO0jHuQ==
X-Received: by 2002:a5d:654f:0:b0:343:2d43:2b00 with SMTP id z15-20020a5d654f000000b003432d432b00mr3579974wrv.62.1712836790649;
        Thu, 11 Apr 2024 04:59:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id z3-20020adfc003000000b00343e5f3a3e2sm1635603wre.19.2024.04.11.04.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 04:59:50 -0700 (PDT)
Message-ID: <769a6a2a-2f38-42de-b3ce-8585b8b0a758@linaro.org>
Date: Thu, 11 Apr 2024 13:59:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 configuration
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
 <20240411115506.1170360-1-volodymyr_babchuk@epam.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240411115506.1170360-1-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 13:55, Volodymyr Babchuk wrote:
> There are multiple issues with SDHC2 configuration for SA8155P-ADP,
> which prevent use of SDHC2 and causes issues with ethernet:
> 
> - Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
>   PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
>   TX. If sdhc driver probes after dwmac driver, it reconfigures
>   gpio4 and this breaks Ethernet MAC.
> 
> - pinctrl configuration mentions gpio96 as CD pin. It seems it was
>   copied from some SM8150 example, because as mentioned above,
>   correct CD pin is gpio4 on PMM8155AU_1.
> 
> - L13C voltage regulator limits minimal voltage to 2.504V, which
>   prevents use 1.8V to power SD card, which in turns does not allow
>   card to work in UHS mode.

That's not really related. One issue, one commit.

> 
> This patch fixes all the mentioned issues.
> 
> Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD card")
> Cc: stable@vger.kernel.org
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 
> ---
> 
> In v2:
>  - Added "Fixes:" tag
>  - CCed stable ML
>  - Fixed pinctrl configuration
>  - Extended voltage range for L13C voltage regulator
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 32 +++++++++++-------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 5e4287f8c8cd1..b9d56bda96759 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
>  
>  		vreg_l13c_2p96: ldo13 {
>  			regulator-name = "vreg_l13c_2p96";
> -			regulator-min-microvolt = <2504000>;
> +			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <2960000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> @@ -384,10 +384,10 @@ &remoteproc_cdsp {
>  &sdhc_2 {
>  	status = "okay";
>  
> -	cd-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
> +	cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default", "sleep";
> -	pinctrl-0 = <&sdc2_on>;
> -	pinctrl-1 = <&sdc2_off>;
> +	pinctrl-0 = <&sdc2_on &pmm8155au_1_sdc2_cd>;
> +	pinctrl-1 = <&sdc2_off &pmm8155au_1_sdc2_cd>;
>  	vqmmc-supply = <&vreg_l13c_2p96>; /* IO line power */
>  	vmmc-supply = <&vreg_l17a_2p96>;  /* Card power line */
>  	bus-width = <4>;
> @@ -505,13 +505,6 @@ data-pins {
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <16>;	/* 16 MA */
>  		};
> -
> -		sd-cd-pins {
> -			pins = "gpio96";
> -			function = "gpio";
> -			bias-pull-up;		/* pull up */
> -			drive-strength = <2>;	/* 2 MA */
> -		};
>  	};
>  
>  	sdc2_off: sdc2-off-state {
> @@ -532,13 +525,6 @@ data-pins {
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <2>;	/* 2 MA */
>  		};
> -
> -		sd-cd-pins {
> -			pins = "gpio96";
> -			function = "gpio";
> -			bias-pull-up;		/* pull up */
> -			drive-strength = <2>;	/* 2 MA */
> -		};
>  	};
>  
>  	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
> @@ -604,3 +590,13 @@ phy-reset-pins {
>  		};
>  	};
>  };
> +
> +&pmm8155au_1_gpios {
> +	pmm8155au_1_sdc2_cd: pmm8155au_1-sdc2-cd {

No underscores in node names.

Please also follow tlmm style of naming nodes.

Also does not look like node is placed in alphabetical place. Where did
you put it?

Best regards,
Krzysztof


