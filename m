Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342377A1715
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjIOHO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjIOHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:14:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37881BCA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:14:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so1678281f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694762054; x=1695366854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpdehBZhOpXjItGWyjFqpfia0zcLOUxclgclSra7oec=;
        b=kwJJ29CuUVUy9UR+X3QYYBx/wLuAO8UpyBUSBsNQiq21O5iuqTR3AtN8l4wHtWr2xg
         TquxI5JS5HkggGwtS9heK9OCMiYGnW/1ipFz790kCUC9cM0/0+zu6pBQeS1C6v7DrXHN
         vxV4bllNjAdiDStCbYvJIs0AehkkhYBLq96pD6Zkdb1Z3vHkbY/T0FxAqnXtgovh5yEd
         FzrCzdUNqqKgxs5mAMoOLghMeX2uYKKMdbwQjYKuRfD4bNjaQKzHP9HpV2Z8341+cVHE
         NSLoDnKTzPJGhIBM8Lo9QIEfPfaoYizeHmxcT5ssKolqkGuJ8JsZ6yL/9oWeOmPfjrID
         jmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762054; x=1695366854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpdehBZhOpXjItGWyjFqpfia0zcLOUxclgclSra7oec=;
        b=jmLNntmc73PPoMqW+Wzb1afwuMJEViQmG1zUt71LU9uO8NSr/kIh58ax8VFDMtP9Sj
         rEpv8q65tAI6ZdSqqR9470l5SWEEAGEp73UbermpOrENiHnMhZDz3NayRNl6zLw74PTj
         8xXhXekfrr0Y6jwLVxee74fsJ1TeDg/K46S6ZITf+E8HkiMu6FVdT0pTsToy+o0B4Okk
         Q39AQKT3pn8YI082BW5yWfeqvFpWLcxSc60BqNwKvaCj65QBLpbHUP/zRjDOoiQy8qwV
         0CSwOfzEw6VzvhLc9HHHRcEQos0HA1JRC7w7k/wOFxzQhVk/rkhCs3mpdtmXjRmTJXnN
         aD8Q==
X-Gm-Message-State: AOJu0YxYPJIWihwaHklzGjgDAjNJ1D9eRDwraIZ+9K+t1Xw5VivB4svX
        sRtLZmdimT+8YBSFreHm83QNNQ==
X-Google-Smtp-Source: AGHT+IFV6aAMkkF5kxajk9mABCKe1hkvqeUVE5untdTNYKQ0F7lLZ0iBFfna+kbMHBvWEHujtgQRIw==
X-Received: by 2002:adf:e88c:0:b0:314:32b6:af3 with SMTP id d12-20020adfe88c000000b0031432b60af3mr820016wrm.5.1694762054205;
        Fri, 15 Sep 2023 00:14:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id o3-20020adfe803000000b00317f3fd21b7sm3617576wrm.80.2023.09.15.00.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:14:13 -0700 (PDT)
Message-ID: <7c94e075-1702-daa8-41f2-b74aa7c11a11@linaro.org>
Date:   Fri, 15 Sep 2023 09:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: add uart console support for
 SM4450
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-9-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915021509.25773-9-quic_tengfan@quicinc.com>
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

On 15/09/2023 04:15, Tengfei Fan wrote:
> Add base description of UART, TLMM, interconnect, TCSRCC and SMMU nodes
> which helps SM4450 boot to shell with console on boards with this SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm4450-qrd.dts |  18 +-
>  arch/arm64/boot/dts/qcom/sm4450.dtsi    | 313 +++++++++++++++++++++---
>  2 files changed, 301 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> index 00a1c81ca397..0f253a2ba170 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> @@ -10,9 +10,23 @@
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
>  	};
>  };
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <136 1>;
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> index df59027a2f93..3af976478d0d 100644
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
> @@ -350,34 +372,6 @@
>  		dma-ranges = <0 0 0 0 0x10 0>;
>  		compatible = "simple-bus";
>  
> -		apps_rsc: rsc@17a00000 {
> -			compatible = "qcom,rpmh-rsc";

You just added this entire node few patches ago. This does not make any
sense.

> -			reg = <0 0x17a00000 0 0x10000>,
> -			      <0 0x17a10000 0 0x10000>,
> -			      <0 0x17a20000 0 0x10000>;
> -			reg-names = "drv-0", "drv-1", "drv-2";
> -			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> -			label = "apps_rsc";
> -			qcom,tcs-offset = <0xd00>;
> -			qcom,drv-id = <2>;
> -			qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
> -					  <WAKE_TCS      3>, <CONTROL_TCS   0>;
> -			power-domains = <&CLUSTER_PD>;
> -
> -			apps_bcm_voter: bcm-voter {
> -				compatible = "qcom,bcm-voter";
> -			};
> -
> -			rpmhcc: clock-controller {
> -				compatible = "qcom,sm4450-rpmh-clk";
> -				#clock-cells = <1>;
> -				clock-names = "xo";
> -				clocks = <&xo_board>;
> -			};
> -		};
> -
>  		gcc: clock-controller@100000 {
>  			compatible = "qcom,sm4450-gcc";
>  			reg = <0x0 0x00100000 0x0 0x1f4200>;
> @@ -387,12 +381,111 @@
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
> +		cnoc2: interconnect@1500000 {
> +			compatible = "qcom,sm4450-cnoc2";
> +			reg = <0 0x1500000 0 0x6200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		cnoc3: interconnect@1510000 {
> +			compatible = "qcom,sm4450-cnoc3";
> +			reg = <0 0x01510000 0 0xF200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		system_noc: interconnect@1680000 {
> +			compatible = "qcom,sm4450-system-noc";
> +			reg = <0 0x1680000 0 0x19080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		pcie_anoc: interconnect@16c0000 {
> +			compatible = "qcom,sm4450-pcie-anoc";
> +			reg = <0 0x16C0000 0 0x7080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_AHB_CLK>;
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
> +		mmss_noc: interconnect@1740000 {
> +			compatible = "qcom,sm4450-mmss-noc";
> +			reg = <0 0x1740000 0 0x19080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		video_aggre_noc: interconnect@1760000 {
> +			compatible = "qcom,sm4450-video-aggre-noc";
> +			reg = <0 0x1760000 0 0x1100>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
>  			#hwlock-cells = <1>;
>  		};
>  
> +		tcsr: syscon@1fc0000 {
> +			compatible = "qcom,sm4450-tcsr", "syscon";
> +			reg = <0x0 0x1fc0000 0x0 0x30000>;
> +		};
> +
> +		lpass_ag_noc: interconnect@3c40000 {
> +			compatible = "qcom,sm4450-lpass-ag-noc";
> +			reg = <0 0x3C40000 0 0x17200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sm4450-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
> @@ -403,6 +496,135 @@
>  			interrupt-controller;
>  		};
>  
> +		tlmm: pinctrl@f100000 {
> +			compatible = "qcom,sm4450-tlmm";
> +			reg = <0 0x0f100000 0 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 137>;
> +			wakeup-parent = <&pdc>;
> +
> +			qup_uart7_rx: qup-uart7-rx-state {
> +				pins = "gpio22";
> +				function = "qup1_se2_l2";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			qup_uart7_tx: qup-uart7-tx-state {
> +				pins = "gpio22";
> +				function = "qup1_se2_l2";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +		};
> +
> +		apps_smmu: iommu@15000000 {
> +			compatible = "qcom,sm4450-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0 0x15000000 0 0x100000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 670 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		intc: interrupt-controller@17200000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
> @@ -471,6 +693,41 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		apps_rsc: rsc@17a00000 {
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0 0x17a00000 0 0x10000>,

No, you added it already in previous patch.


Best regards,
Krzysztof

