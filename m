Return-Path: <linux-kernel+bounces-27361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB882EEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E12B2342F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BDB1B972;
	Tue, 16 Jan 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRHjUUnA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CB1BC3A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so11566979e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705406791; x=1706011591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGcpeohddZRzmLbURIeRjYDTQ//7aY759Xdu5YEODvQ=;
        b=CRHjUUnAYDy6Ta9DIer6zWpsy4/Duw3/1z++TT9EtlsaCxE61RpASRcnVxei3FP7wU
         erVpWr+TuJSQagYg+GpttJ+ew0PuiW0fNtS+ZU8AUdo8y9drMdY4KjPnnYbbpgmpgBo6
         pMbBxdRTRaLRBDvCTsHQR0kVIbK9sGVZbCFrATtKE5/EJDpfn6/0X2/L7gC772TpwQID
         ihmXv45ZT+MuVwvg+AvRIZfBSR5Lyqr6qQeYm7medJCjTfrThRdNdo3knxDwxiOtWMTh
         Ys+963z5RarwW3dbY/ZCC9BoZ25wudrRw88lFFb8u7H17UilunQQ+aOzlP/CKnzU8GD5
         +I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705406791; x=1706011591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGcpeohddZRzmLbURIeRjYDTQ//7aY759Xdu5YEODvQ=;
        b=bRAvRaBPbzMCPJ4mFWY1jquUqxN049NRrjUr16ZLHLLLPrj0GHQZMTPUzyA7micVxE
         1OHNNSIxv4XEGjmT6oq9aVyEoQT6OJdU/Gh83bxNtrtXQeasdCL3hBNOfoOU8dS1Ha3B
         7Ko7SBw9/g1SfHxC1Hk4OOElButYOdCf7E5vTCUX+jXOIP/yklTF3ba0I1RBtCyRFNUy
         6mSVqiE1DIU2MccjpvjB8QbA5o04nczd43tJVdOOIUSvPES/XGzrLGDP+mYCelGkOX/d
         hi7nRFN7tPZNcXC11RlUOQ1DYCMsFdl/ot6idAxhhuvjjIPsUq9koioD0qxwGQdAOXXP
         D10w==
X-Gm-Message-State: AOJu0YwUn0pg0IKDg3mmASsStmyxmvz155iv7CPE5SZQyKuN4Ek2xIkq
	ouWooGFQQ05I9k/eZuiA3Q93J4e+yLdPAg==
X-Google-Smtp-Source: AGHT+IGkerh401LRgXbq3n5vsV1wjQJWRCpuqXgZnkRfmdSgQpCrtm4NTaKEm0hTZom0CM9kmklmLA==
X-Received: by 2002:a05:6512:2355:b0:50e:75a3:5804 with SMTP id p21-20020a056512235500b0050e75a35804mr4214271lfu.14.1705406791349;
        Tue, 16 Jan 2024 04:06:31 -0800 (PST)
Received: from [172.30.204.234] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512105000b0050eb1fd820esm1734329lfb.258.2024.01.16.04.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:06:30 -0800 (PST)
Message-ID: <20a8efd1-e243-434e-8f75-aa786ac8014f@linaro.org>
Date: Tue, 16 Jan 2024 13:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
Content-Language: en-US
To: Ritesh Kumar <quic_riteshk@quicinc.com>, andersson@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com,
 geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
 m.szyprowski@samsung.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com,
 quic_vproddut@quicinc.com
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-3-quic_riteshk@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240116094935.9988-3-quic_riteshk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/24 10:49, Ritesh Kumar wrote:
> Enable Display Subsystem with Novatek NT36672E Panel
> on qcm6490 idp platform.
> 
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 2a6e4907c5ee..efa5252130a1 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -9,6 +9,7 @@
>   #define PM7250B_SID 8
>   #define PM7250B_SID1 9
>   
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "sc7280.dtsi"
>   #include "pm7250b.dtsi"
> @@ -38,6 +39,25 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	lcd_disp_bias: lcd-disp-bias-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_disp_bias";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_disp_bias_en>;

property-n
property-names

all throughout the patch

> +&gpu {
> +	status = "disabled";
> +};

Hm.. generally we disable the GPU in the SoC DT, but that doesn't
seem to have happened here..

Thinking about it more, is disabling it here necessary? Does it
not fail gracefully?

Konrad

