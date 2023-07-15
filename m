Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC3754908
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGON6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGON6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:58:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE12D6B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:58:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso43605181fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689429486; x=1692021486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvdKCYQuPX8/3jghEw7l+bBgatYxQRkdI1/Xcmy4Ga0=;
        b=Y5hx1znOW6KyRAY1S4ztPoPn0TUEaB/CukRqFUBIwBYf44pxKAI8hnHWbRjICc2ct1
         E9KQ1EJVP8HKVYNAy4wcIgmeKzp3sdH+TiY3sEAHO5IdRdfvF7PCnO1cyief5NQAM0xM
         tb+bXs8yfCDD4eCaKuZu0gPs6JtfzRoTXvocjfQMyKZqa2Fm+ni8nwXVgWgxP3ed4Xlx
         Pptomq4ScwyKBuoF7kD61jdBFS0FEd3J9J+1i2jU1OZ2KnlkWIsdfy8aSb1wdBlKKL8R
         P6w4D7lm5GG1ZZM1GFGTzJN2NvN6Zdc2+8JX+P1uOAjoKq7lqLr70/W523VExm6PHANq
         b9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689429486; x=1692021486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvdKCYQuPX8/3jghEw7l+bBgatYxQRkdI1/Xcmy4Ga0=;
        b=Os5Dzigfm4jyY2zP7sTWX3be04L9ziJFr3sCkS34Ew3C9q/ntvetlkHZUX7FARLPSg
         7W2i1LmoIY/r80t8lxlJhvOIPTp1sFeRTNnEk4YcXQStJouXuPPaEfsknXpOwgZftzVe
         v2btDTo2KrfuH0e9Ubyjsg3rLAnBOOPy2jgOMpAojQjtjz8KzPXL61NVNWUX/S5XX0TX
         clzT6D+mc9+b+JrZND1h5a00+iPbYnxdKpEmp4jLWDgP8kdsgePa+KTxQCKW3Q4Qff8p
         XsOckb1vuuUEEypBv1tY4nDaXaiE7UCHb0tgi4ArKpCFZfSZdNF9fU+Jpk6ZACICKGcQ
         +rGA==
X-Gm-Message-State: ABy/qLYxVMldXeY0ElG4tHeS4r8s7K3SRIos0pQcj+Acp8piPT59M7rh
        6DBuXaUahEBcefVhxRWzOw1jew==
X-Google-Smtp-Source: APBJJlEjRTL0TYidciKAmwAEAEPl4C0orxedBlQS0O2ue/5+wcEzy9yftbj/TQPIxjOPHJiVP9xOUw==
X-Received: by 2002:a2e:9bcb:0:b0:2b6:dec9:2813 with SMTP id w11-20020a2e9bcb000000b002b6dec92813mr6265513ljj.29.1689429486008;
        Sat, 15 Jul 2023 06:58:06 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id e24-20020a2e9858000000b002b3318c8d6fsm2526278ljj.28.2023.07.15.06.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 06:58:05 -0700 (PDT)
Message-ID: <2bf7ac6e-eeba-a082-2b0e-4fc302bef70a@linaro.org>
Date:   Sat, 15 Jul 2023 15:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] arm64: dts: qcom: ipq9574: Add common RDP dtsi
 file
Content-Language: en-US
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_saahtoma@quicinc.com
References: <20230713105909.14209-1-quic_anusha@quicinc.com>
 <20230713105909.14209-2-quic_anusha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230713105909.14209-2-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.2023 12:59, Anusha Rao wrote:
> Add a dtsi file to include interfaces that are common
> across RDPs.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
[...]

>  		data-pins {
>  			pins = "gpio0", "gpio1", "gpio2",
> -			       "gpio3", "gpio6", "gpio7",
> -			       "gpio8", "gpio9";
> +				"gpio3", "gpio6", "gpio7",
> +				"gpio8", "gpio9";
This (and a similar one in the other file) change looks unrelated
and I think it makes the indentation worse :/

Konrad
>  			function = "sdc_data";
>  			drive-strength = <8>;
>  			bias-pull-up;
> @@ -110,15 +60,4 @@
>  			bias-pull-down;
>  		};
>  	};
> -
> -	spi_0_pins: spi-0-state {
> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> -		function = "blsp0_spi";
> -		drive-strength = <8>;
> -		bias-disable;
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 877026ccc6e2..7685176f90ef 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -8,69 +8,11 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>  	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
> -
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	regulator_fixed_3p3: s3300 {
> -		compatible = "regulator-fixed";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-name = "fixed_3p3";
> -	};
> -
> -	regulator_fixed_0p925: s0925 {
> -		compatible = "regulator-fixed";
> -		regulator-min-microvolt = <925000>;
> -		regulator-max-microvolt = <925000>;
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-name = "fixed_0p925";
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -
> -		mp5496_l2: l2 {
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-always-on;
> -			regulator-boot-on;
> -		};
> -	};
>  };
>  
>  &sdhc_1 {
> @@ -85,10 +27,6 @@
>  	status = "okay";
>  };
>  
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
>  &tlmm {
>  	sdc_default_state: sdc-default-state {
>  		clk-pins {
> @@ -107,8 +45,8 @@
>  
>  		data-pins {
>  			pins = "gpio0", "gpio1", "gpio2",
> -			       "gpio3", "gpio6", "gpio7",
> -			       "gpio8", "gpio9";
> +				"gpio3", "gpio6", "gpio7",
> +				"gpio8", "gpio9";
>  			function = "sdc_data";
>  			drive-strength = <8>;
>  			bias-pull-up;
> @@ -122,30 +60,3 @@
>  		};
>  	};
>  };
> -
> -&usb_0_dwc3 {
> -	dr_mode = "host";
> -};
> -
> -&usb_0_qmpphy {
> -	vdda-pll-supply = <&mp5496_l2>;
> -	vdda-phy-supply = <&regulator_fixed_0p925>;
> -
> -	status = "okay";
> -};
> -
> -&usb_0_qusbphy {
> -	vdd-supply = <&regulator_fixed_0p925>;
> -	vdda-pll-supply = <&mp5496_l2>;
> -	vdda-phy-dpdm-supply = <&regulator_fixed_3p3>;
> -
> -	status = "okay";
> -};
> -
> -&usb3 {
> -	status = "okay";
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
> -};
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
> index c8fa54e1a62c..d36d1078763e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
> @@ -8,73 +8,10 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C6";
>  	compatible = "qcom,ipq9574-ap-al02-c6", "qcom,ipq9574";
>  
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&blsp1_spi0 {
> -	pinctrl-0 = <&spi_0_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
> -		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		spi-max-frequency = <50000000>;
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -	};
> -};
> -
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
> -&tlmm {
> -	spi_0_pins: spi-0-state {
> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> -		function = "blsp0_spi";
> -		drive-strength = <8>;
> -		bias-disable;
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> index f01de6628c3b..c30c9fbedf26 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> @@ -8,73 +8,10 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
>  	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
>  
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&blsp1_spi0 {
> -	pinctrl-0 = <&spi_0_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
> -		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		spi-max-frequency = <50000000>;
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -	};
> -};
> -
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
> -&tlmm {
> -	spi_0_pins: spi-0-state {
> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> -		function = "blsp0_spi";
> -		drive-strength = <8>;
> -		bias-disable;
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
> index 6efae3426cb8..0dc382f5d5ec 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
> @@ -8,73 +8,9 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9";
>  	compatible = "qcom,ipq9574-ap-al02-c9", "qcom,ipq9574";
> -
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&blsp1_spi0 {
> -	pinctrl-0 = <&spi_0_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
> -		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		spi-max-frequency = <50000000>;
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -	};
> -};
> -
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
> -&tlmm {
> -	spi_0_pins: spi-0-state {
> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> -		function = "blsp0_spi";
> -		drive-strength = <8>;
> -		bias-disable;
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
>  };
