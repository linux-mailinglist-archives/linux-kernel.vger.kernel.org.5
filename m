Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6E7AAF54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjIVKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjIVKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:19:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A718F;
        Fri, 22 Sep 2023 03:19:20 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MA4eR1030864;
        Fri, 22 Sep 2023 12:18:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=EerirS/eMPpCFF2WVIwoG90vKsP2Tri82ZALKyAu6Q4=; b=Pa
        5GhxP/qn+j/g7e4mB/Qz3zoDiRj6JrHkQgsVFAHt/5eLwLpmp2uPLcztsXelilQz
        fzZZPuPfM1r0y9dRbjjnDdKd4R4h8DGB29EF2hr+hGWwNajBcUOuN+dDUMXZXi9c
        DHsq7oCJuH5G7WPxtkGvO2zIl0PH9Fu8UTGyQQcfsook91xcw5UMdc5U0EtOWCwu
        7pqkGx56dw4iBsIJqFWxtaRI4nKqrBVhIkiELzVqTA7bthHW56Y44t0FPHPNxGAe
        qS2GmeZJHRNWwhlGO3pejECcw9UXyR459G/Y3ljlL4mD4fzsF3Ulk+jUJQsc2rCq
        IdWgPZCev4xE1Z6UyNqA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt72x49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 12:18:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8CD61100051;
        Fri, 22 Sep 2023 12:18:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 80C092194E0;
        Fri, 22 Sep 2023 12:18:58 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 12:18:57 +0200
Message-ID: <75457051-d32b-a8bf-1cb5-1922f18df292@foss.st.com>
Date:   Fri, 22 Sep 2023 12:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ARM: dts: stm32: omit unused pinctrl groups from dtb
 files
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
References: <20230920123130.2821706-1-s.hauer@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230920123130.2821706-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_08,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha

On 9/20/23 14:31, Sascha Hauer wrote:
> stm32mp15-pinctrl.dtsi contains nearly all pinctrl groups collected from
> all boards. Most of them end up unused by a board and only waste binary
> space. Add /omit-if-no-ref/ to the groups to scrub the unused groups
> from the dtbs.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied on stm32-next.

Thanks.
Alex


>   arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 228 ++++++++++++++++++++
>   1 file changed, 228 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> index e1df345801dc2..da475d6cb8dc2 100644
> --- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> @@ -6,6 +6,7 @@
>   #include <dt-bindings/pinctrl/stm32-pinfunc.h>
>   
>   &pinctrl {
> +	/omit-if-no-ref/
>   	adc1_ain_pins_a: adc1-ain-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* ADC1_INP2 */
> @@ -17,12 +18,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	adc1_in6_pins_a: adc1-in6-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 12, ANALOG)>;
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	adc12_ain_pins_a: adc12-ain-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* ADC1 in13 */
> @@ -32,6 +35,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	adc12_ain_pins_b: adc12-ain-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 12, ANALOG)>, /* ADC1 in6 */
> @@ -39,6 +43,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	adc12_usb_cc_pins_a: adc12-usb-cc-pins-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 4, ANALOG)>, /* ADC12 in18 */
> @@ -46,6 +51,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	cec_pins_a: cec-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 15, AF4)>;
> @@ -55,12 +61,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	cec_sleep_pins_a: cec-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 15, ANALOG)>; /* HDMI_CEC */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	cec_pins_b: cec-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 6, AF5)>;
> @@ -70,24 +78,28 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	cec_sleep_pins_b: cec-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 6, ANALOG)>; /* HDMI_CEC */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dac_ch1_pins_a: dac-ch1-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 4, ANALOG)>;
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dac_ch2_pins_a: dac-ch2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 5, ANALOG)>;
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dcmi_pins_a: dcmi-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 8,  AF13)>,/* DCMI_HSYNC */
> @@ -109,6 +121,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dcmi_sleep_pins_a: dcmi-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 8,  ANALOG)>,/* DCMI_HSYNC */
> @@ -129,6 +142,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dcmi_pins_b: dcmi-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 4,  AF13)>,/* DCMI_HSYNC */
> @@ -146,6 +160,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dcmi_sleep_pins_b: dcmi-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 4,  ANALOG)>,/* DCMI_HSYNC */
> @@ -162,6 +177,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dcmi_pins_c: dcmi-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 4,  AF13)>,/* DCMI_HSYNC */
> @@ -181,6 +197,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	dcmi_sleep_pins_c: dcmi-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 4,  ANALOG)>,/* DCMI_HSYNC */
> @@ -199,6 +216,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_pins_a: rgmii-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
> @@ -230,6 +248,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_sleep_pins_a: rgmii-sleep-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
> @@ -250,6 +269,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_pins_b: rgmii-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
> @@ -281,6 +301,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_sleep_pins_b: rgmii-sleep-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
> @@ -301,6 +322,7 @@ pins1 {
>   		 };
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_pins_c: rgmii-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
> @@ -332,6 +354,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_sleep_pins_c: rgmii-sleep-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
> @@ -352,6 +375,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_pins_d: rgmii-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> @@ -382,6 +406,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_sleep_pins_d: rgmii-sleep-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> @@ -401,6 +426,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_pins_e: rgmii-4 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> @@ -424,6 +450,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rgmii_sleep_pins_e: rgmii-sleep-4 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> @@ -441,6 +468,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rmii_pins_a: rmii-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH1_RMII_TXD0 */
> @@ -461,6 +489,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rmii_sleep_pins_a: rmii-sleep-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH1_RMII_TXD0 */
> @@ -475,6 +504,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rmii_pins_b: rmii-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 5, AF0)>, /* ETH1_CLK */
> @@ -502,6 +532,7 @@ pins4 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rmii_sleep_pins_b: rmii-sleep-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('A', 2, ANALOG)>, /* ETH1_MDIO */
> @@ -516,6 +547,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rmii_pins_c: rmii-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH1_RMII_TXD0 */
> @@ -536,6 +568,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ethernet0_rmii_sleep_pins_c: rmii-sleep-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH1_RMII_TXD0 */
> @@ -550,6 +583,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	fmc_pins_a: fmc-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('D', 4, AF12)>, /* FMC_NOE */
> @@ -575,6 +609,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	fmc_sleep_pins_a: fmc-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 4, ANALOG)>, /* FMC_NOE */
> @@ -594,6 +629,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	fmc_pins_b: fmc-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 4, AF12)>, /* FMC_NOE */
> @@ -623,6 +659,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	fmc_sleep_pins_b: fmc-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 4, ANALOG)>, /* FMC_NOE */
> @@ -649,6 +686,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c1_pins_a: i2c1-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
> @@ -659,6 +697,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c1_sleep_pins_a: i2c1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
> @@ -666,6 +705,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c1_pins_b: i2c1-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 14, AF5)>, /* I2C1_SCL */
> @@ -676,6 +716,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c1_sleep_pins_b: i2c1-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 14, ANALOG)>, /* I2C1_SCL */
> @@ -683,6 +724,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c2_pins_a: i2c2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 4, AF4)>, /* I2C2_SCL */
> @@ -693,6 +735,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c2_sleep_pins_a: i2c2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 4, ANALOG)>, /* I2C2_SCL */
> @@ -700,6 +743,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c2_pins_b1: i2c2-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
> @@ -709,12 +753,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c2_sleep_pins_b1: i2c2-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c2_pins_c: i2c2-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 1, AF4)>, /* I2C2_SCL */
> @@ -725,6 +771,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c2_pins_sleep_c: i2c2-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 1, ANALOG)>, /* I2C2_SCL */
> @@ -732,6 +779,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c5_pins_a: i2c5-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 11, AF4)>, /* I2C5_SCL */
> @@ -742,6 +790,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c5_sleep_pins_a: i2c5-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* I2C5_SCL */
> @@ -750,6 +799,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c5_pins_b: i2c5-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 0, AF4)>, /* I2C5_SCL */
> @@ -760,6 +810,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c5_sleep_pins_b: i2c5-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 0, ANALOG)>, /* I2C5_SCL */
> @@ -767,6 +818,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2s2_pins_a: i2s2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 3, AF5)>, /* I2S2_SDO */
> @@ -778,6 +830,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2s2_sleep_pins_a: i2s2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 3, ANALOG)>, /* I2S2_SDO */
> @@ -786,6 +839,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2s2_pins_b: i2s2-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C',  3, AF5)>, /* I2S2_SDO */
> @@ -797,6 +851,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2s2_sleep_pins_b: i2s2-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* I2S2_SDO */
> @@ -805,6 +860,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_pins_a: ltdc-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G',  7, AF14)>, /* LCD_CLK */
> @@ -841,6 +897,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_sleep_pins_a: ltdc-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_CLK */
> @@ -874,6 +931,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_pins_b: ltdc-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 14, AF14)>, /* LCD_CLK */
> @@ -910,6 +968,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_sleep_pins_b: ltdc-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 14, ANALOG)>, /* LCD_CLK */
> @@ -943,6 +1002,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_pins_c: ltdc-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B',  1, AF9)>,  /* LTDC_R6 */
> @@ -978,6 +1038,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_sleep_pins_c: ltdc-sleep-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 1, ANALOG)>,  /* LTDC_R6 */
> @@ -1005,6 +1066,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_pins_d: ltdc-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G',  7, AF14)>; /* LCD_CLK */
> @@ -1046,6 +1108,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_sleep_pins_d: ltdc-sleep-3 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_CLK */
> @@ -1079,6 +1142,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_pins_e: ltdc-4 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('H',  2, AF14)>, /* LTDC_R0 */
> @@ -1121,6 +1185,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	ltdc_sleep_pins_e: ltdc-sleep-4 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H',  2, ANALOG)>, /* LTDC_R0 */
> @@ -1154,6 +1219,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	mco1_pins_a: mco1-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 13, AF2)>; /* MCO1 */
> @@ -1163,12 +1229,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	mco1_sleep_pins_a: mco1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 13, ANALOG)>; /* MCO1 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	mco2_pins_a: mco2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G', 2, AF1)>; /* MCO2 */
> @@ -1178,12 +1246,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	mco2_sleep_pins_a: mco2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G', 2, ANALOG)>; /* MCO2 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_pins_a: m-can1-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
> @@ -1197,6 +1267,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_sleep_pins_a: m_can1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* CAN1_TX */
> @@ -1204,6 +1275,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_pins_b: m-can1-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('A', 12, AF9)>; /* CAN1_TX */
> @@ -1217,6 +1289,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_sleep_pins_b: m_can1-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 12, ANALOG)>, /* CAN1_TX */
> @@ -1224,6 +1297,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_pins_c: m-can1-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
> @@ -1237,6 +1311,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_sleep_pins_c: m_can1-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* CAN1_TX */
> @@ -1244,6 +1319,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_pins_d: m-can1-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('D', 1, AF9)>; /* CAN1_TX */
> @@ -1257,6 +1333,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can1_sleep_pins_d: m_can1-sleep-3 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* CAN1_TX */
> @@ -1264,6 +1341,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can2_pins_a: m-can2-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
> @@ -1277,6 +1355,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	m_can2_sleep_pins_a: m_can2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 13, ANALOG)>, /* CAN2_TX */
> @@ -1284,6 +1363,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm1_pins_a: pwm1-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 9, AF1)>, /* TIM1_CH1 */
> @@ -1295,6 +1375,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm1_sleep_pins_a: pwm1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 9, ANALOG)>, /* TIM1_CH1 */
> @@ -1303,6 +1384,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm1_pins_b: pwm1-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 9, AF1)>; /* TIM1_CH1 */
> @@ -1312,12 +1394,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm1_sleep_pins_b: pwm1-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 9, ANALOG)>; /* TIM1_CH1 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm1_pins_c: pwm1-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 11, AF1)>; /* TIM1_CH2 */
> @@ -1326,12 +1410,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm1_sleep_pins_c: pwm1-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 11, ANALOG)>; /* TIM1_CH2 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm2_pins_a: pwm2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
> @@ -1341,12 +1427,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm2_sleep_pins_a: pwm2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 3, ANALOG)>; /* TIM2_CH4 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm3_pins_a: pwm3-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 7, AF2)>; /* TIM3_CH2 */
> @@ -1356,12 +1444,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm3_sleep_pins_a: pwm3-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 7, ANALOG)>; /* TIM3_CH2 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm3_pins_b: pwm3-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 5, AF2)>; /* TIM3_CH2 */
> @@ -1371,12 +1461,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm3_sleep_pins_b: pwm3-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 5, ANALOG)>; /* TIM3_CH2 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm4_pins_a: pwm4-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 14, AF2)>, /* TIM4_CH3 */
> @@ -1387,6 +1479,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm4_sleep_pins_a: pwm4-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 14, ANALOG)>, /* TIM4_CH3 */
> @@ -1394,6 +1487,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm4_pins_b: pwm4-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 13, AF2)>; /* TIM4_CH2 */
> @@ -1403,12 +1497,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm4_sleep_pins_b: pwm4-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 13, ANALOG)>; /* TIM4_CH2 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm5_pins_a: pwm5-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 11, AF2)>; /* TIM5_CH2 */
> @@ -1418,12 +1514,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm5_sleep_pins_a: pwm5-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 11, ANALOG)>; /* TIM5_CH2 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm5_pins_b: pwm5-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 11, AF2)>, /* TIM5_CH2 */
> @@ -1435,6 +1533,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm5_sleep_pins_b: pwm5-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 11, ANALOG)>, /* TIM5_CH2 */
> @@ -1443,6 +1542,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm8_pins_a: pwm8-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 2, AF3)>; /* TIM8_CH4 */
> @@ -1452,12 +1552,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm8_sleep_pins_a: pwm8-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 2, ANALOG)>; /* TIM8_CH4 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm8_pins_b: pwm8-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 5, AF3)>, /* TIM8_CH1 */
> @@ -1469,6 +1571,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm8_sleep_pins_b: pwm8-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* TIM8_CH1 */
> @@ -1478,6 +1581,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm12_pins_a: pwm12-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 6, AF2)>; /* TIM12_CH1 */
> @@ -1487,12 +1591,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	pwm12_sleep_pins_a: pwm12-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 6, ANALOG)>; /* TIM12_CH1 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_clk_pins_a: qspi-clk-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 10, AF9)>; /* QSPI_CLK */
> @@ -1502,12 +1608,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_clk_sleep_pins_a: qspi-clk-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 10, ANALOG)>; /* QSPI_CLK */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_bk1_pins_a: qspi-bk1-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
> @@ -1520,6 +1628,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_bk1_sleep_pins_a: qspi-bk1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 8, ANALOG)>, /* QSPI_BK1_IO0 */
> @@ -1529,6 +1638,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_bk2_pins_a: qspi-bk2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 2, AF9)>, /* QSPI_BK2_IO0 */
> @@ -1541,6 +1651,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_bk2_sleep_pins_a: qspi-bk2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* QSPI_BK2_IO0 */
> @@ -1550,6 +1661,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_cs1_pins_a: qspi-cs1-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 6, AF10)>; /* QSPI_BK1_NCS */
> @@ -1559,12 +1671,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_cs1_sleep_pins_a: qspi-cs1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 6, ANALOG)>; /* QSPI_BK1_NCS */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_cs2_pins_a: qspi-cs2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 0, AF10)>; /* QSPI_BK2_NCS */
> @@ -1574,12 +1688,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	qspi_cs2_sleep_pins_a: qspi-cs2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 0, ANALOG)>; /* QSPI_BK2_NCS */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2a_pins_a: sai2a-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 5, AF10)>, /* SAI2_SCK_A */
> @@ -1592,6 +1708,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2a_sleep_pins_a: sai2a-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* SAI2_SCK_A */
> @@ -1601,6 +1718,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2a_pins_b: sai2a-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('I', 6, AF10)>,	/* SAI2_SD_A */
> @@ -1612,6 +1730,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2a_sleep_pins_b: sai2a-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 6, ANALOG)>,  /* SAI2_SD_A */
> @@ -1620,6 +1739,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2a_pins_c: sai2a-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 13, AF10)>, /* SAI2_SCK_A */
> @@ -1631,6 +1751,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2a_sleep_pins_c: sai2a-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 13, ANALOG)>, /* SAI2_SCK_A */
> @@ -1639,6 +1760,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_pins_a: sai2b-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('E', 12, AF10)>, /* SAI2_SCK_B */
> @@ -1654,6 +1776,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_sleep_pins_a: sai2b-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* SAI2_SD_B */
> @@ -1663,6 +1786,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_pins_b: sai2b-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
> @@ -1670,12 +1794,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_sleep_pins_b: sai2b-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_pins_c: sai2b-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
> @@ -1683,12 +1809,14 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_sleep_pins_c: sai2b-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_pins_d: sai2b-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('H', 2, AF10)>, /* SAI2_SCK_B */
> @@ -1704,6 +1832,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai2b_sleep_pins_d: sai2b-sleep-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* SAI2_SCK_B */
> @@ -1713,6 +1842,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai4a_pins_a: sai4a-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 5, AF10)>; /* SAI4_SD_A */
> @@ -1722,12 +1852,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sai4a_sleep_pins_a: sai4a-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 5, ANALOG)>; /* SAI4_SD_A */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> @@ -1747,6 +1879,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> @@ -1771,6 +1904,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_b4_init_pins_a: sdmmc1-b4-init-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> @@ -1783,6 +1917,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
> @@ -1794,6 +1929,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_b4_pins_b: sdmmc1-b4-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> @@ -1813,6 +1949,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_b4_od_pins_b: sdmmc1-b4-od-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> @@ -1837,6 +1974,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_b4_sleep_pins_b: sdmmc1-b4-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
> @@ -1848,6 +1986,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_dir_pins_a: sdmmc1-dir-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
> @@ -1863,6 +2002,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_dir_init_pins_a: sdmmc1-dir-init-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
> @@ -1874,6 +2014,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 2, ANALOG)>, /* SDMMC1_D0DIR */
> @@ -1883,6 +2024,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_dir_pins_b: sdmmc1-dir-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
> @@ -1898,6 +2040,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc1_dir_sleep_pins_b: sdmmc1-dir-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 2, ANALOG)>, /* SDMMC1_D0DIR */
> @@ -1907,6 +2050,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_b4_pins_a: sdmmc2-b4-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> @@ -1926,6 +2070,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> @@ -1950,6 +2095,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
> @@ -1961,6 +2107,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_b4_pins_b: sdmmc2-b4-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> @@ -1980,6 +2127,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_b4_od_pins_b: sdmmc2-b4-od-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> @@ -2004,6 +2152,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_pins_a: sdmmc2-d47-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
> @@ -2016,6 +2165,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_sleep_pins_a: sdmmc2-d47-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> @@ -2025,6 +2175,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_pins_b: sdmmc2-d47-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, AF9)>,  /* SDMMC2_D4 */
> @@ -2037,6 +2188,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_sleep_pins_b: sdmmc2-d47-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> @@ -2046,6 +2198,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_pins_c: sdmmc2-d47-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
> @@ -2058,6 +2211,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_sleep_pins_c: sdmmc2-d47-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> @@ -2067,6 +2221,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_pins_d: sdmmc2-d47-3 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
> @@ -2076,6 +2231,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_sleep_pins_d: sdmmc2-d47-sleep-3 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> @@ -2086,6 +2242,7 @@ pins {
>   	};
>   
>   	sdmmc2_d47_pins_e: sdmmc2-d47-4 {
> +	/omit-if-no-ref/
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, AF9)>,	/* SDMMC2_D4 */
>   				 <STM32_PINMUX('A', 9, AF10)>,	/* SDMMC2_D5 */
> @@ -2097,6 +2254,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc2_d47_sleep_pins_e: sdmmc2-d47-sleep-4 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> @@ -2106,6 +2264,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc3_b4_pins_a: sdmmc3-b4-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
> @@ -2125,6 +2284,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc3_b4_od_pins_a: sdmmc3-b4-od-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
> @@ -2149,6 +2309,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc3_b4_sleep_pins_a: sdmmc3-b4-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 0, ANALOG)>, /* SDMMC3_D0 */
> @@ -2160,6 +2321,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc3_b4_pins_b: sdmmc3-b4-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
> @@ -2179,6 +2341,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc3_b4_od_pins_b: sdmmc3-b4-od-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
> @@ -2203,6 +2366,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	sdmmc3_b4_sleep_pins_b: sdmmc3-b4-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 0, ANALOG)>, /* SDMMC3_D0 */
> @@ -2214,6 +2378,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spdifrx_pins_a: spdifrx-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G', 12, AF8)>; /* SPDIF_IN1 */
> @@ -2221,12 +2386,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spdifrx_sleep_pins_a: spdifrx-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G', 12, ANALOG)>; /* SPDIF_IN1 */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi1_pins_b: spi1-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('A', 5, AF5)>, /* SPI1_SCK */
> @@ -2242,6 +2409,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi2_pins_a: spi2-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF5)>, /* SPI2_SCK */
> @@ -2257,6 +2425,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi2_pins_b: spi2-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('I', 1, AF5)>, /* SPI2_SCK */
> @@ -2272,6 +2441,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi2_pins_c: spi2-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('I', 1, AF5)>, /* SPI2_SCK */
> @@ -2286,6 +2456,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi4_pins_a: spi4-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> @@ -2300,6 +2471,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi5_pins_a: spi5-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 7, AF5)>, /* SPI5_SCK */
> @@ -2315,6 +2487,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	stusb1600_pins_a: stusb1600-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 11, GPIO)>;
> @@ -2322,6 +2495,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_pins_a: uart4-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
> @@ -2335,6 +2509,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_idle_pins_a: uart4-idle-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
> @@ -2345,6 +2520,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_sleep_pins_a: uart4-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G', 11, ANALOG)>, /* UART4_TX */
> @@ -2352,6 +2528,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_pins_b: uart4-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('D', 1, AF8)>; /* UART4_TX */
> @@ -2365,6 +2542,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_pins_c: uart4-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
> @@ -2378,6 +2556,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_pins_d: uart4-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('A', 13, AF8)>; /* UART4_TX */
> @@ -2391,6 +2570,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_idle_pins_d: uart4-idle-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('A', 13, ANALOG)>; /* UART4_TX */
> @@ -2401,6 +2581,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart4_sleep_pins_d: uart4-sleep-3 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 13, ANALOG)>, /* UART4_TX */
> @@ -2408,6 +2589,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart5_pins_a: uart5-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 13, AF14)>; /* UART5_TX */
> @@ -2421,6 +2603,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart7_pins_a: uart7-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART7_TX */
> @@ -2436,6 +2619,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart7_pins_b: uart7-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 7, AF7)>; /* UART7_TX */
> @@ -2449,6 +2633,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart7_pins_c: uart7-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART7_TX */
> @@ -2462,6 +2647,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart7_idle_pins_c: uart7-idle-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('E', 8, ANALOG)>; /* UART7_TX */
> @@ -2472,6 +2658,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart7_sleep_pins_c: uart7-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 8, ANALOG)>, /* UART7_TX */
> @@ -2479,6 +2666,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart8_pins_a: uart8-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
> @@ -2492,6 +2680,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	uart8_rtscts_pins_a: uart8rtscts-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G', 7, AF8)>, /* UART8_RTS */
> @@ -2500,6 +2689,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart1_pins_a: usart1-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('A', 12, AF7)>; /* USART1_RTS */
> @@ -2513,6 +2703,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart1_idle_pins_a: usart1-idle-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('A', 12, ANALOG)>, /* USART1_RTS */
> @@ -2520,6 +2711,7 @@ pins1 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart1_sleep_pins_a: usart1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 12, ANALOG)>, /* USART1_RTS */
> @@ -2527,6 +2719,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart2_pins_a: usart2-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
> @@ -2542,6 +2735,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart2_sleep_pins_a: usart2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 5, ANALOG)>, /* USART2_TX */
> @@ -2551,6 +2745,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart2_pins_b: usart2-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
> @@ -2566,6 +2761,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart2_sleep_pins_b: usart2-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 5, ANALOG)>, /* USART2_TX */
> @@ -2575,6 +2771,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart2_pins_c: usart2-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('D', 5, AF7)>, /* USART2_TX */
> @@ -2590,6 +2787,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart2_idle_pins_c: usart2-idle-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('D', 5, ANALOG)>, /* USART2_TX */
> @@ -2607,6 +2805,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart2_sleep_pins_c: usart2-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 5, ANALOG)>, /* USART2_TX */
> @@ -2616,6 +2815,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_pins_a: usart3-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
> @@ -2629,6 +2829,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_idle_pins_a: usart3-idle-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>; /* USART3_TX */
> @@ -2639,6 +2840,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_sleep_pins_a: usart3-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2646,6 +2848,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_pins_b: usart3-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> @@ -2661,6 +2864,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_idle_pins_b: usart3-idle-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2678,6 +2882,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_sleep_pins_b: usart3-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2687,6 +2892,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_pins_c: usart3-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> @@ -2702,6 +2908,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_idle_pins_c: usart3-idle-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2719,6 +2926,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_sleep_pins_c: usart3-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2728,6 +2936,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_pins_d: usart3-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> @@ -2743,6 +2952,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_idle_pins_d: usart3-idle-3 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2755,6 +2965,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_sleep_pins_d: usart3-sleep-3 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2764,6 +2975,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_pins_e: usart3-4 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> @@ -2779,6 +2991,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_idle_pins_e: usart3-idle-4 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2796,6 +3009,7 @@ pins3 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_sleep_pins_e: usart3-sleep-4 {
>   		pins {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> @@ -2805,6 +3019,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart3_pins_f: usart3-5 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> @@ -2820,12 +3035,14 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usbotg_hs_pins_a: usbotg-hs-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 10, ANALOG)>; /* OTG_ID */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usbotg_fs_dp_dm_pins_a: usbotg-fs-dp-dm-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* OTG_FS_DM */
> @@ -2835,6 +3052,7 @@ pins {
>   };
>   
>   &pinctrl_z {
> +	/omit-if-no-ref/
>   	i2c2_pins_b2: i2c2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 0, AF3)>; /* I2C2_SCL */
> @@ -2844,12 +3062,14 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c2_sleep_pins_b2: i2c2-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 0, ANALOG)>; /* I2C2_SCL */
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c4_pins_a: i2c4-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 4, AF6)>, /* I2C4_SCL */
> @@ -2860,6 +3080,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c4_sleep_pins_a: i2c4-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 4, ANALOG)>, /* I2C4_SCL */
> @@ -2867,6 +3088,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c6_pins_a: i2c6-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 6, AF2)>, /* I2C6_SCL */
> @@ -2877,6 +3099,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	i2c6_sleep_pins_a: i2c6-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 6, ANALOG)>, /* I2C6_SCL */
> @@ -2884,6 +3107,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi1_pins_a: spi1-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('Z', 0, AF5)>, /* SPI1_SCK */
> @@ -2899,6 +3123,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	spi1_sleep_pins_a: spi1-sleep-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 0, ANALOG)>, /* SPI1_SCK */
> @@ -2907,6 +3132,7 @@ pins {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart1_pins_b: usart1-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('Z', 7, AF7)>; /* USART1_TX */
> @@ -2920,6 +3146,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart1_idle_pins_b: usart1-idle-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('Z', 7, ANALOG)>; /* USART1_TX */
> @@ -2930,6 +3157,7 @@ pins2 {
>   		};
>   	};
>   
> +	/omit-if-no-ref/
>   	usart1_sleep_pins_b: usart1-sleep-1 {
>   		pins {
>   			pinmux = <STM32_PINMUX('Z', 7, ANALOG)>, /* USART1_TX */

