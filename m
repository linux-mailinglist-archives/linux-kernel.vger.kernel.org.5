Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF747983CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbjIHINq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjIHINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:13:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D051BDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:13:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c4923195dso219852166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694160819; x=1694765619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWZM8Q/uIy8my/IXpdHmpbEduZUYWK8mH9X8KWk+rE4=;
        b=IXQ+dqqFkd/ASkI/zwtTA6zuPxiuprT7OFtt7KR0IrEnpqKMOUKuuEQ2CXNyjjKlbp
         i2sUakTjkTnJnFAJ1XHuNESG7ko191imx/iqeZAPlfAWNW+NYtkGE/XKMDYRdpRFFpZP
         YjYsDwu7ij73CGKz6NcDxDTzSMSYL4PiBtqMfaVw6q/h/Z3EjXPDUGxOGgq87bWHWi/L
         27bhJv7QH3I6uNaCgc7NIS7P7+RgbWZ/QNs2KsFbHVM1pMTMu/U8k7ONWWGOeEPGfCOP
         5YTJsQuWU3Leg/04UDAIVRcTwFPEFY4y8pnKdOMoZmve7+ulDG+MC7t+iBDhAZ5QoWy1
         pWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160819; x=1694765619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWZM8Q/uIy8my/IXpdHmpbEduZUYWK8mH9X8KWk+rE4=;
        b=R5+j/TpBavacbMv+D87RaqoFVgWhDmKeIaFp/x7BkQwyyJ/Ay9tB+wd4oXkq8y5ane
         XxDqAL4/38qSY3YxgayaK3j3fYImdUjUl6KPVG+1wD0Evd8qqs25OJOrpFzkf27MqSOe
         nKoe8bG5qFFJHg1ntTR8lwEUba9oGfw0su+MW8KacJxT2idXRS1JV6hsg2C6i98NUoBh
         nLfAK8XZ367qdue7JWqm2lSc4HWP6/MlCz6k38VpziXzKRsDgsdekYr9baUL3KLvgUxr
         oU+O4ooDWOVQs9XzqHfCzw3rQTaXBpouBJJbtkrvGcMUAttnRBINdojkHfUfqjmV25VO
         RJsA==
X-Gm-Message-State: AOJu0Yz6akgOxq5RO9f6GrL97rztNr/NJuPHBkqf8c1qakI5ygp4plOH
        INLYN1lD7HChsuCo7Wq7loTNzA==
X-Google-Smtp-Source: AGHT+IFlgUgFFWJP4twtv7eegf3o5nfvQzIkS3a6S8h2RTjkRlbK3B/juMDPxfbjjDget6fljmxQVA==
X-Received: by 2002:a17:906:300f:b0:9a1:b43b:73a0 with SMTP id 15-20020a170906300f00b009a1b43b73a0mr1224993ejz.20.1694160819243;
        Fri, 08 Sep 2023 01:13:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906241400b009829d2e892csm695713eja.15.2023.09.08.01.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 01:13:38 -0700 (PDT)
Message-ID: <9626f079-22f3-5327-5a45-23e5dfcda5c6@linaro.org>
Date:   Fri, 8 Sep 2023 10:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6/6] arm64: dts: qcom: add uart console support for SM4450
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org
Cc:     robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        quic_bjorande@quicinc.com
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-7-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908065847.28382-7-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 08:58, Tengfei Fan wrote:
> Add base description of UART, TLMM, interconnect, TCSRCC and SMMU nodes
> which helps SM4450 boot to shell with console on boards with this SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm4450-qrd.dts |  14 +-
>  arch/arm64/boot/dts/qcom/sm4450.dtsi    | 258 ++++++++++++++++++++++++
>  2 files changed, 270 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> index 00a1c81ca397..bb8c58fb4267 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> @@ -10,9 +10,19 @@
>  	model = "Qualcomm Technologies, Inc. SM4450 QRD";
>  	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>  
> -	aliases { };
> +	aliases {
> +		serial0 = &uart7;
> +	};
>  
>  	chosen {
> -		bootargs = "console=hvc0";
> +		stdout-path = "serial0:115200n8";

Wait, what? You told me you cannot use serial and stdout-path!

https://lore.kernel.org/all/f0f94ea9-94b1-ccd1-0a43-3cb119fc5d94@quicinc.com/

>  	};
>  };
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> index 2395b1d655a2..3af7255fca35 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> @@ -7,6 +7,8 @@
>  #include <dt-bindings/clock/qcom,sm4450-gcc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interconnect/qcom,icc.h>
> +#include <dt-bindings/interconnect/qcom,sm4450.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
> @@ -262,6 +264,26 @@
>  		};
>  	};
>  
> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm-sm4450", "qcom,scm";
> +			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
> +			#reset-cells = <1>;
> +		};
> +	};
> +
> +	clk_virt: interconnect-0 {
> +		compatible = "qcom,sm4450-clk-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	mc_virt: interconnect-1 {
> +		compatible = "qcom,sm4450-mc-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
>  	memory@a0000000 {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the size */
> @@ -387,12 +409,118 @@
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>  		};
>  
> +		qupv3_id_0: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0x00ac0000 0x0 0x2000>;
> +			ranges;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			iommus = <&apps_smmu 0x163 0x0>;
> +			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
> +			interconnect-names = "qup-core";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			status = "disabled";
> +
> +			uart7: serial@a88000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0 0x00a88000 0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		aggre1_noc: interconnect@16e0000 {
> +			tible = "qcom,sm4450-aggre1-noc";
> +			reg = <0 0x016e0000 0 0x1c080>;
> +			#interconnect-cells = <2>;
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre2_noc: interconnect@1700000 {
> +			compatible = "qcom,sm4450-aggre2-noc";
> +			reg = <0 0x01700000 0 0x31080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&rpmhcc RPMH_IPA_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> +		};
> +
> +		cnoc2: interconnect@1500000 {

Keep order by unit address.

> +			compatible = "qcom,sm4450-cnoc2";
> +			reg = <0 0x1500000 0 0x6200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +

...

> +
>  		intc: interrupt-controller@17200000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
> @@ -480,4 +711,31 @@
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
> +
> +	tlmm: pinctrl@f100000 {

You did not test it... This node cannot be here and tools will tell you
this. No need for review from us - tools are doing this.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
> +		compatible = "qcom,sm4450-tlmm";
> +		reg = <0 0x0f100000 0 0x300000>;
> +		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		gpio-ranges = <&tlmm 0 0 137>;
> +		wakeup-parent = <&pdc>;
> +
> +		qup_uart7_rx: qup-uart7-rx-state {
> +			pins = "gpio22";
> +			function = "qup1_se2_l2";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		qup_uart7_tx: qup-uart7-tx-state {
> +			pins = "gpio22";
> +			function = "qup1_se2_l2";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +

Stray blank line.

>  };

Best regards,
Krzysztof

