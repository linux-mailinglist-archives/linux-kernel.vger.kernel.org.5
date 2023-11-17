Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE6F7EF049
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjKQK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKQK2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:28:09 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006018B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:28:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50a93c5647cso2504526e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700216883; x=1700821683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBrtAxlEr4GgfjZmKpLaY+8tcDXqNwU1BVb06jtClig=;
        b=OcWmBnCE/ICCCFSKmUVxPW5n+M5GsIA7rWSwtyoeWYCB8kJGz7SFBfHqajnkCzlQf4
         E7RWo4R1x67WKS0AzucdxG80BYVTUo3ojtA4mDnaQ+yuzJxu3vP/ddHVLVfMSvCNjI12
         Aem38FmbxpqlFRtVArQwXXtltb+t426Y0hyq8gvIwCEvPo5ui74JazJR6CG3pWJTP7Kx
         Jddx4Nq3xisb6eK8hgaa7x5Nq+4sCQzgNxaz2/ogCGHBwBvfX7o6pp1xvjk7YsWTY7Yv
         7mP4+GdudkRrfcyg9RSjE+v+8sUZx2MgphPdk7WGWpAsgJCUYoGkTtG9bjSlbX0NJh58
         P6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700216883; x=1700821683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBrtAxlEr4GgfjZmKpLaY+8tcDXqNwU1BVb06jtClig=;
        b=UauLv3f3O+xEHWAKWBnhorFG0pY/kLBCPDLw26PyHAaa/V5XtaBInPedYzcuPzTkCb
         xUSf3lL0NFR2SyX66MUy4ioJvxXWhox8bj3N+RaJ80arP/6vbwSkIP8a1BaHZEHx3Lb2
         bUe0K/B6fyh2a6CvFqSzur6ZzOpDmwOnvcqAoTeNOHB+NUSTUE26BPesm8o8sta7aKwc
         /DttnjtC3XmmPNUjR+p3K0RtyNojjPx/fyqAHyo2kVOVjEKiA9pXWjiFl5Gy3PrGxCiv
         J6LhRkgvNHpmdhc+/++J77XUJNuFvn59yT+MoHpu69iJz6Zx5ZGwsWys4zq5OYoy+1Lz
         Wi0Q==
X-Gm-Message-State: AOJu0Yz1gQf+JLWVRmlCQngTUsK/+P9WOSO9AEYaK0ZdBEx/T0c2ywc3
        63qaSVpmAtRpNlWjMY7nTNzvig==
X-Google-Smtp-Source: AGHT+IHw/7drLyVYWVWFOIq2GW70aj0nhBeS5RXoyLJ3gCPAA/HqfATafNHqBQXC8Mlkwy9Vhlv77Q==
X-Received: by 2002:a19:5518:0:b0:500:99a9:bc40 with SMTP id n24-20020a195518000000b0050099a9bc40mr12935886lfe.69.1700216883333;
        Fri, 17 Nov 2023 02:28:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f16-20020a19ae10000000b005041a71237asm182106lfc.111.2023.11.17.02.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:28:02 -0800 (PST)
Message-ID: <aecb04cd-805d-4c2d-b6a7-67a47b963ee9@linaro.org>
Date:   Fri, 17 Nov 2023 12:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] arm64: dts: qcom: sm8550-aim300: add SM8550 AIM300
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-7-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231117101817.4401-7-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 12:18, Tengfei Fan wrote:
> Add a minimal DTS for the new QRD8550 board, serial, UFS and USB should
> be working.

An explanation of what is AIM300 would be welcomed.

> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile          |   1 +
>   arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 490 +++++++++++++++++++++
>   2 files changed, 491 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d6cb840b7050..ea5d4a07671a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -229,5 +229,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sm8550-aim300.dtb

My email client suggests that alignment is broken here.

>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> new file mode 100644
> index 000000000000..202b979da8ca
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8550.dtsi"
> +#include "pm8010.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550b.dtsi"
> +#include "pm8550ve.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +#include "pmr735d_a.dtsi"
> +#include "pmr735d_b.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. SM8550 AIM300";
> +	compatible = "qcom,sm8550-aim300", "qcom,sm8550";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	pmic-glink {
> +		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_ss>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {

It's not demanded, I think, but I'd suggest 'regulator-vph-pwr' to allow 
all regulators to be grouped together.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};

Other than that looks good to me.

-- 
With best wishes
Dmitry

