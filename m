Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222857A7E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjITMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjITMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:15:50 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB9C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:15:38 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qiw73-00060g-Ms; Wed, 20 Sep 2023 14:15:25 +0200
Message-ID: <33956b8b-465f-3a99-0331-7ed784c502f3@pengutronix.de>
Date:   Wed, 20 Sep 2023 14:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: stm32: omit unused pinctrl groups from dtb
 files
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230920121147.2807758-1-s.hauer@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20230920121147.2807758-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sascha,

On 20.09.23 14:11, Sascha Hauer wrote:
> stm32mp15-pinctrl.dtsi contains nearly all pinctrl groups collected from
> all boards. Most of them end up unused by a board and only waste binary
> space. Add /omit-if-no-ref/ to the groups to scrub the unused groups
> from the dtbs.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 228 ++++++++++++++++++++
>  1 file changed, 228 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> index e1df345801dc2..778a83471df4c 100644
> --- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> @@ -7,6 +7,7 @@
>  
>  &pinctrl {
>  	adc1_ain_pins_a: adc1-ain-0 {
> +		/omit-if-no-ref/

I think the correct place is above the node name that would be referenced,
i.e. before adc1_ain_pins_a: adc1-ain-0 here.

Cheers,
Ahmad

>  		pins {
>  			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* ADC1_INP2 */
>  				 <STM32_PINMUX('B', 1, ANALOG)>, /* ADC1_INP5 */
> @@ -18,12 +19,14 @@ pins {
>  	};
>  
>  	adc1_in6_pins_a: adc1-in6-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 12, ANALOG)>;
>  		};
>  	};
>  
>  	adc12_ain_pins_a: adc12-ain-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* ADC1 in13 */
>  				 <STM32_PINMUX('F', 12, ANALOG)>, /* ADC1 in6 */
> @@ -33,6 +36,7 @@ pins {
>  	};
>  
>  	adc12_ain_pins_b: adc12-ain-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 12, ANALOG)>, /* ADC1 in6 */
>  				 <STM32_PINMUX('F', 13, ANALOG)>; /* ADC2 in2 */
> @@ -40,6 +44,7 @@ pins {
>  	};
>  
>  	adc12_usb_cc_pins_a: adc12-usb-cc-pins-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 4, ANALOG)>, /* ADC12 in18 */
>  				 <STM32_PINMUX('A', 5, ANALOG)>; /* ADC12 in19 */
> @@ -47,6 +52,7 @@ pins {
>  	};
>  
>  	cec_pins_a: cec-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 15, AF4)>;
>  			bias-disable;
> @@ -56,12 +62,14 @@ pins {
>  	};
>  
>  	cec_sleep_pins_a: cec-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 15, ANALOG)>; /* HDMI_CEC */
>  		};
>  	};
>  
>  	cec_pins_b: cec-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 6, AF5)>;
>  			bias-disable;
> @@ -71,24 +79,28 @@ pins {
>  	};
>  
>  	cec_sleep_pins_b: cec-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 6, ANALOG)>; /* HDMI_CEC */
>  		};
>  	};
>  
>  	dac_ch1_pins_a: dac-ch1-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 4, ANALOG)>;
>  		};
>  	};
>  
>  	dac_ch2_pins_a: dac-ch2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 5, ANALOG)>;
>  		};
>  	};
>  
>  	dcmi_pins_a: dcmi-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 8,  AF13)>,/* DCMI_HSYNC */
>  				 <STM32_PINMUX('B', 7,  AF13)>,/* DCMI_VSYNC */
> @@ -110,6 +122,7 @@ pins {
>  	};
>  
>  	dcmi_sleep_pins_a: dcmi-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 8,  ANALOG)>,/* DCMI_HSYNC */
>  				 <STM32_PINMUX('B', 7,  ANALOG)>,/* DCMI_VSYNC */
> @@ -130,6 +143,7 @@ pins {
>  	};
>  
>  	dcmi_pins_b: dcmi-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 4,  AF13)>,/* DCMI_HSYNC */
>  				 <STM32_PINMUX('B', 7,  AF13)>,/* DCMI_VSYNC */
> @@ -147,6 +161,7 @@ pins {
>  	};
>  
>  	dcmi_sleep_pins_b: dcmi-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 4,  ANALOG)>,/* DCMI_HSYNC */
>  				 <STM32_PINMUX('B', 7,  ANALOG)>,/* DCMI_VSYNC */
> @@ -163,6 +178,7 @@ pins {
>  	};
>  
>  	dcmi_pins_c: dcmi-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 4,  AF13)>,/* DCMI_HSYNC */
>  				 <STM32_PINMUX('B', 7,  AF13)>,/* DCMI_VSYNC */
> @@ -182,6 +198,7 @@ pins {
>  	};
>  
>  	dcmi_sleep_pins_c: dcmi-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 4,  ANALOG)>,/* DCMI_HSYNC */
>  				 <STM32_PINMUX('B', 7,  ANALOG)>,/* DCMI_VSYNC */
> @@ -200,6 +217,7 @@ pins {
>  	};
>  
>  	ethernet0_rgmii_pins_a: rgmii-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
>  				 <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> @@ -231,6 +249,7 @@ pins3 {
>  	};
>  
>  	ethernet0_rgmii_sleep_pins_a: rgmii-sleep-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
>  				 <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> @@ -251,6 +270,7 @@ pins1 {
>  	};
>  
>  	ethernet0_rgmii_pins_b: rgmii-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
>  				 <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> @@ -282,6 +302,7 @@ pins3 {
>  	};
>  
>  	ethernet0_rgmii_sleep_pins_b: rgmii-sleep-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
>  				 <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> @@ -302,6 +323,7 @@ pins1 {
>  	};
>  
>  	ethernet0_rgmii_pins_c: rgmii-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
>  				 <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> @@ -333,6 +355,7 @@ pins3 {
>  	};
>  
>  	ethernet0_rgmii_sleep_pins_c: rgmii-sleep-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
>  				 <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> @@ -353,6 +376,7 @@ pins1 {
>  	};
>  
>  	ethernet0_rgmii_pins_d: rgmii-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
>  				 <STM32_PINMUX('G', 13, AF11)>,	/* ETH_RGMII_TXD0 */
> @@ -383,6 +407,7 @@ pins3 {
>  	};
>  
>  	ethernet0_rgmii_sleep_pins_d: rgmii-sleep-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
>  				 <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
> @@ -402,6 +427,7 @@ pins1 {
>  	};
>  
>  	ethernet0_rgmii_pins_e: rgmii-4 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
>  				 <STM32_PINMUX('G', 13, AF11)>, /* ETH_RGMII_TXD0 */
> @@ -425,6 +451,7 @@ pins2 {
>  	};
>  
>  	ethernet0_rgmii_sleep_pins_e: rgmii-sleep-4 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
>  				 <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
> @@ -442,6 +469,7 @@ pins1 {
>  	};
>  
>  	ethernet0_rmii_pins_a: rmii-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH1_RMII_TXD0 */
>  				 <STM32_PINMUX('G', 14, AF11)>, /* ETH1_RMII_TXD1 */
> @@ -462,6 +490,7 @@ pins2 {
>  	};
>  
>  	ethernet0_rmii_sleep_pins_a: rmii-sleep-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH1_RMII_TXD0 */
>  				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH1_RMII_TXD1 */
> @@ -476,6 +505,7 @@ pins1 {
>  	};
>  
>  	ethernet0_rmii_pins_b: rmii-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 5, AF0)>, /* ETH1_CLK */
>  				<STM32_PINMUX('C', 1, AF11)>, /* ETH1_MDC */
> @@ -503,6 +533,7 @@ pins4 {
>  	};
>  
>  	ethernet0_rmii_sleep_pins_b: rmii-sleep-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 2, ANALOG)>, /* ETH1_MDIO */
>  				<STM32_PINMUX('A', 7, ANALOG)>, /* ETH1_CRS_DV */
> @@ -517,6 +548,7 @@ pins1 {
>  	};
>  
>  	ethernet0_rmii_pins_c: rmii-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH1_RMII_TXD0 */
>  				 <STM32_PINMUX('G', 14, AF11)>, /* ETH1_RMII_TXD1 */
> @@ -537,6 +569,7 @@ pins2 {
>  	};
>  
>  	ethernet0_rmii_sleep_pins_c: rmii-sleep-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH1_RMII_TXD0 */
>  				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH1_RMII_TXD1 */
> @@ -551,6 +584,7 @@ pins1 {
>  	};
>  
>  	fmc_pins_a: fmc-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('D', 4, AF12)>, /* FMC_NOE */
>  				 <STM32_PINMUX('D', 5, AF12)>, /* FMC_NWE */
> @@ -576,6 +610,7 @@ pins2 {
>  	};
>  
>  	fmc_sleep_pins_a: fmc-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 4, ANALOG)>, /* FMC_NOE */
>  				 <STM32_PINMUX('D', 5, ANALOG)>, /* FMC_NWE */
> @@ -595,6 +630,7 @@ pins {
>  	};
>  
>  	fmc_pins_b: fmc-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 4, AF12)>, /* FMC_NOE */
>  				 <STM32_PINMUX('D', 5, AF12)>, /* FMC_NWE */
> @@ -624,6 +660,7 @@ pins {
>  	};
>  
>  	fmc_sleep_pins_b: fmc-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 4, ANALOG)>, /* FMC_NOE */
>  				 <STM32_PINMUX('D', 5, ANALOG)>, /* FMC_NWE */
> @@ -650,6 +687,7 @@ pins {
>  	};
>  
>  	i2c1_pins_a: i2c1-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
>  				 <STM32_PINMUX('F', 15, AF5)>; /* I2C1_SDA */
> @@ -660,6 +698,7 @@ pins {
>  	};
>  
>  	i2c1_sleep_pins_a: i2c1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
>  				 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
> @@ -667,6 +706,7 @@ pins {
>  	};
>  
>  	i2c1_pins_b: i2c1-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 14, AF5)>, /* I2C1_SCL */
>  				 <STM32_PINMUX('F', 15, AF5)>; /* I2C1_SDA */
> @@ -677,6 +717,7 @@ pins {
>  	};
>  
>  	i2c1_sleep_pins_b: i2c1-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 14, ANALOG)>, /* I2C1_SCL */
>  				 <STM32_PINMUX('F', 15, ANALOG)>; /* I2C1_SDA */
> @@ -684,6 +725,7 @@ pins {
>  	};
>  
>  	i2c2_pins_a: i2c2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 4, AF4)>, /* I2C2_SCL */
>  				 <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
> @@ -694,6 +736,7 @@ pins {
>  	};
>  
>  	i2c2_sleep_pins_a: i2c2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 4, ANALOG)>, /* I2C2_SCL */
>  				 <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
> @@ -701,6 +744,7 @@ pins {
>  	};
>  
>  	i2c2_pins_b1: i2c2-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
>  			bias-disable;
> @@ -710,12 +754,14 @@ pins {
>  	};
>  
>  	i2c2_sleep_pins_b1: i2c2-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
>  		};
>  	};
>  
>  	i2c2_pins_c: i2c2-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 1, AF4)>, /* I2C2_SCL */
>  				 <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
> @@ -726,6 +772,7 @@ pins {
>  	};
>  
>  	i2c2_pins_sleep_c: i2c2-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 1, ANALOG)>, /* I2C2_SCL */
>  				 <STM32_PINMUX('H', 5, ANALOG)>; /* I2C2_SDA */
> @@ -733,6 +780,7 @@ pins {
>  	};
>  
>  	i2c5_pins_a: i2c5-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 11, AF4)>, /* I2C5_SCL */
>  				 <STM32_PINMUX('A', 12, AF4)>; /* I2C5_SDA */
> @@ -743,6 +791,7 @@ pins {
>  	};
>  
>  	i2c5_sleep_pins_a: i2c5-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* I2C5_SCL */
>  				 <STM32_PINMUX('A', 12, ANALOG)>; /* I2C5_SDA */
> @@ -751,6 +800,7 @@ pins {
>  	};
>  
>  	i2c5_pins_b: i2c5-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 0, AF4)>, /* I2C5_SCL */
>  				 <STM32_PINMUX('D', 1, AF4)>; /* I2C5_SDA */
> @@ -761,6 +811,7 @@ pins {
>  	};
>  
>  	i2c5_sleep_pins_b: i2c5-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 0, ANALOG)>, /* I2C5_SCL */
>  				 <STM32_PINMUX('D', 1, ANALOG)>; /* I2C5_SDA */
> @@ -768,6 +819,7 @@ pins {
>  	};
>  
>  	i2s2_pins_a: i2s2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 3, AF5)>, /* I2S2_SDO */
>  				 <STM32_PINMUX('B', 9, AF5)>, /* I2S2_WS */
> @@ -779,6 +831,7 @@ pins {
>  	};
>  
>  	i2s2_sleep_pins_a: i2s2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 3, ANALOG)>, /* I2S2_SDO */
>  				 <STM32_PINMUX('B', 9, ANALOG)>, /* I2S2_WS */
> @@ -787,6 +840,7 @@ pins {
>  	};
>  
>  	i2s2_pins_b: i2s2-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C',  3, AF5)>, /* I2S2_SDO */
>  				 <STM32_PINMUX('B', 12, AF5)>, /* I2S2_WS */
> @@ -798,6 +852,7 @@ pins {
>  	};
>  
>  	i2s2_sleep_pins_b: i2s2-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* I2S2_SDO */
>  				 <STM32_PINMUX('B', 12, ANALOG)>, /* I2S2_WS */
> @@ -806,6 +861,7 @@ pins {
>  	};
>  
>  	ltdc_pins_a: ltdc-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G',  7, AF14)>, /* LCD_CLK */
>  				 <STM32_PINMUX('I', 10, AF14)>, /* LCD_HSYNC */
> @@ -842,6 +898,7 @@ pins {
>  	};
>  
>  	ltdc_sleep_pins_a: ltdc-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_CLK */
>  				 <STM32_PINMUX('I', 10, ANALOG)>, /* LCD_HSYNC */
> @@ -875,6 +932,7 @@ pins {
>  	};
>  
>  	ltdc_pins_b: ltdc-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 14, AF14)>, /* LCD_CLK */
>  				 <STM32_PINMUX('I', 12, AF14)>, /* LCD_HSYNC */
> @@ -911,6 +969,7 @@ pins {
>  	};
>  
>  	ltdc_sleep_pins_b: ltdc-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 14, ANALOG)>, /* LCD_CLK */
>  				 <STM32_PINMUX('I', 12, ANALOG)>, /* LCD_HSYNC */
> @@ -944,6 +1003,7 @@ pins {
>  	};
>  
>  	ltdc_pins_c: ltdc-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B',  1, AF9)>,  /* LTDC_R6 */
>  				 <STM32_PINMUX('B',  9, AF14)>, /* LTDC_B7 */
> @@ -979,6 +1039,7 @@ pins2 {
>  	};
>  
>  	ltdc_sleep_pins_c: ltdc-sleep-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 1, ANALOG)>,  /* LTDC_R6 */
>  				 <STM32_PINMUX('B', 9, ANALOG)>, /* LTDC_B7 */
> @@ -1006,6 +1067,7 @@ pins1 {
>  	};
>  
>  	ltdc_pins_d: ltdc-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G',  7, AF14)>; /* LCD_CLK */
>  			bias-disable;
> @@ -1047,6 +1109,7 @@ pins2 {
>  	};
>  
>  	ltdc_sleep_pins_d: ltdc-sleep-3 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_CLK */
>  				 <STM32_PINMUX('I', 10, ANALOG)>, /* LCD_HSYNC */
> @@ -1080,6 +1143,7 @@ pins {
>  	};
>  
>  	ltdc_pins_e: ltdc-4 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('H',  2, AF14)>, /* LTDC_R0 */
>  				 <STM32_PINMUX('H',  3, AF14)>, /* LTDC_R1 */
> @@ -1122,6 +1186,7 @@ pins2 {
>  	};
>  
>  	ltdc_sleep_pins_e: ltdc-sleep-4 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H',  2, ANALOG)>, /* LTDC_R0 */
>  				 <STM32_PINMUX('H',  3, ANALOG)>, /* LTDC_R1 */
> @@ -1155,6 +1220,7 @@ pins {
>  	};
>  
>  	mco1_pins_a: mco1-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 13, AF2)>; /* MCO1 */
>  			bias-disable;
> @@ -1164,12 +1230,14 @@ pins {
>  	};
>  
>  	mco1_sleep_pins_a: mco1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 13, ANALOG)>; /* MCO1 */
>  		};
>  	};
>  
>  	mco2_pins_a: mco2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G', 2, AF1)>; /* MCO2 */
>  			bias-disable;
> @@ -1179,12 +1247,14 @@ pins {
>  	};
>  
>  	mco2_sleep_pins_a: mco2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G', 2, ANALOG)>; /* MCO2 */
>  		};
>  	};
>  
>  	m_can1_pins_a: m-can1-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
>  			slew-rate = <1>;
> @@ -1198,6 +1268,7 @@ pins2 {
>  	};
>  
>  	m_can1_sleep_pins_a: m_can1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* CAN1_TX */
>  				 <STM32_PINMUX('I', 9, ANALOG)>; /* CAN1_RX */
> @@ -1205,6 +1276,7 @@ pins {
>  	};
>  
>  	m_can1_pins_b: m-can1-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 12, AF9)>; /* CAN1_TX */
>  			slew-rate = <1>;
> @@ -1218,6 +1290,7 @@ pins2 {
>  	};
>  
>  	m_can1_sleep_pins_b: m_can1-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 12, ANALOG)>, /* CAN1_TX */
>  				 <STM32_PINMUX('A', 11, ANALOG)>; /* CAN1_RX */
> @@ -1225,6 +1298,7 @@ pins {
>  	};
>  
>  	m_can1_pins_c: m-can1-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
>  			slew-rate = <1>;
> @@ -1238,6 +1312,7 @@ pins2 {
>  	};
>  
>  	m_can1_sleep_pins_c: m_can1-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* CAN1_TX */
>  				 <STM32_PINMUX('H', 14, ANALOG)>; /* CAN1_RX */
> @@ -1245,6 +1320,7 @@ pins {
>  	};
>  
>  	m_can1_pins_d: m-can1-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('D', 1, AF9)>; /* CAN1_TX */
>  			slew-rate = <1>;
> @@ -1258,6 +1334,7 @@ pins2 {
>  	};
>  
>  	m_can1_sleep_pins_d: m_can1-sleep-3 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* CAN1_TX */
>  				 <STM32_PINMUX('D', 0, ANALOG)>; /* CAN1_RX */
> @@ -1265,6 +1342,7 @@ pins {
>  	};
>  
>  	m_can2_pins_a: m-can2-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
>  			slew-rate = <1>;
> @@ -1278,6 +1356,7 @@ pins2 {
>  	};
>  
>  	m_can2_sleep_pins_a: m_can2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 13, ANALOG)>, /* CAN2_TX */
>  				 <STM32_PINMUX('B', 5, ANALOG)>; /* CAN2_RX */
> @@ -1285,6 +1364,7 @@ pins {
>  	};
>  
>  	pwm1_pins_a: pwm1-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 9, AF1)>, /* TIM1_CH1 */
>  				 <STM32_PINMUX('E', 11, AF1)>, /* TIM1_CH2 */
> @@ -1296,6 +1376,7 @@ pins {
>  	};
>  
>  	pwm1_sleep_pins_a: pwm1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 9, ANALOG)>, /* TIM1_CH1 */
>  				 <STM32_PINMUX('E', 11, ANALOG)>, /* TIM1_CH2 */
> @@ -1304,6 +1385,7 @@ pins {
>  	};
>  
>  	pwm1_pins_b: pwm1-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 9, AF1)>; /* TIM1_CH1 */
>  			bias-pull-down;
> @@ -1313,12 +1395,14 @@ pins {
>  	};
>  
>  	pwm1_sleep_pins_b: pwm1-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 9, ANALOG)>; /* TIM1_CH1 */
>  		};
>  	};
>  
>  	pwm1_pins_c: pwm1-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 11, AF1)>; /* TIM1_CH2 */
>  			drive-push-pull;
> @@ -1327,12 +1411,14 @@ pins {
>  	};
>  
>  	pwm1_sleep_pins_c: pwm1-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 11, ANALOG)>; /* TIM1_CH2 */
>  		};
>  	};
>  
>  	pwm2_pins_a: pwm2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
>  			bias-pull-down;
> @@ -1342,12 +1428,14 @@ pins {
>  	};
>  
>  	pwm2_sleep_pins_a: pwm2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 3, ANALOG)>; /* TIM2_CH4 */
>  		};
>  	};
>  
>  	pwm3_pins_a: pwm3-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 7, AF2)>; /* TIM3_CH2 */
>  			bias-pull-down;
> @@ -1357,12 +1445,14 @@ pins {
>  	};
>  
>  	pwm3_sleep_pins_a: pwm3-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 7, ANALOG)>; /* TIM3_CH2 */
>  		};
>  	};
>  
>  	pwm3_pins_b: pwm3-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 5, AF2)>; /* TIM3_CH2 */
>  			bias-disable;
> @@ -1372,12 +1462,14 @@ pins {
>  	};
>  
>  	pwm3_sleep_pins_b: pwm3-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 5, ANALOG)>; /* TIM3_CH2 */
>  		};
>  	};
>  
>  	pwm4_pins_a: pwm4-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 14, AF2)>, /* TIM4_CH3 */
>  				 <STM32_PINMUX('D', 15, AF2)>; /* TIM4_CH4 */
> @@ -1388,6 +1480,7 @@ pins {
>  	};
>  
>  	pwm4_sleep_pins_a: pwm4-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 14, ANALOG)>, /* TIM4_CH3 */
>  				 <STM32_PINMUX('D', 15, ANALOG)>; /* TIM4_CH4 */
> @@ -1395,6 +1488,7 @@ pins {
>  	};
>  
>  	pwm4_pins_b: pwm4-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 13, AF2)>; /* TIM4_CH2 */
>  			bias-pull-down;
> @@ -1404,12 +1498,14 @@ pins {
>  	};
>  
>  	pwm4_sleep_pins_b: pwm4-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 13, ANALOG)>; /* TIM4_CH2 */
>  		};
>  	};
>  
>  	pwm5_pins_a: pwm5-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 11, AF2)>; /* TIM5_CH2 */
>  			bias-pull-down;
> @@ -1419,12 +1515,14 @@ pins {
>  	};
>  
>  	pwm5_sleep_pins_a: pwm5-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 11, ANALOG)>; /* TIM5_CH2 */
>  		};
>  	};
>  
>  	pwm5_pins_b: pwm5-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 11, AF2)>, /* TIM5_CH2 */
>  				 <STM32_PINMUX('H', 12, AF2)>, /* TIM5_CH3 */
> @@ -1436,6 +1534,7 @@ pins {
>  	};
>  
>  	pwm5_sleep_pins_b: pwm5-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 11, ANALOG)>, /* TIM5_CH2 */
>  				 <STM32_PINMUX('H', 12, ANALOG)>, /* TIM5_CH3 */
> @@ -1444,6 +1543,7 @@ pins {
>  	};
>  
>  	pwm8_pins_a: pwm8-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 2, AF3)>; /* TIM8_CH4 */
>  			bias-pull-down;
> @@ -1453,12 +1553,14 @@ pins {
>  	};
>  
>  	pwm8_sleep_pins_a: pwm8-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 2, ANALOG)>; /* TIM8_CH4 */
>  		};
>  	};
>  
>  	pwm8_pins_b: pwm8-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 5, AF3)>, /* TIM8_CH1 */
>  				 <STM32_PINMUX('I', 6, AF3)>, /* TIM8_CH2 */
> @@ -1470,6 +1572,7 @@ pins {
>  	};
>  
>  	pwm8_sleep_pins_b: pwm8-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* TIM8_CH1 */
>  				 <STM32_PINMUX('I', 6, ANALOG)>, /* TIM8_CH2 */
> @@ -1479,6 +1582,7 @@ pins {
>  	};
>  
>  	pwm12_pins_a: pwm12-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 6, AF2)>; /* TIM12_CH1 */
>  			bias-pull-down;
> @@ -1488,12 +1592,14 @@ pins {
>  	};
>  
>  	pwm12_sleep_pins_a: pwm12-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 6, ANALOG)>; /* TIM12_CH1 */
>  		};
>  	};
>  
>  	qspi_clk_pins_a: qspi-clk-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 10, AF9)>; /* QSPI_CLK */
>  			bias-disable;
> @@ -1503,12 +1609,14 @@ pins {
>  	};
>  
>  	qspi_clk_sleep_pins_a: qspi-clk-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 10, ANALOG)>; /* QSPI_CLK */
>  		};
>  	};
>  
>  	qspi_bk1_pins_a: qspi-bk1-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>  				 <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
> @@ -1521,6 +1629,7 @@ pins {
>  	};
>  
>  	qspi_bk1_sleep_pins_a: qspi-bk1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 8, ANALOG)>, /* QSPI_BK1_IO0 */
>  				 <STM32_PINMUX('F', 9, ANALOG)>, /* QSPI_BK1_IO1 */
> @@ -1530,6 +1639,7 @@ pins {
>  	};
>  
>  	qspi_bk2_pins_a: qspi-bk2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 2, AF9)>, /* QSPI_BK2_IO0 */
>  				 <STM32_PINMUX('H', 3, AF9)>, /* QSPI_BK2_IO1 */
> @@ -1542,6 +1652,7 @@ pins {
>  	};
>  
>  	qspi_bk2_sleep_pins_a: qspi-bk2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* QSPI_BK2_IO0 */
>  				 <STM32_PINMUX('H', 3, ANALOG)>, /* QSPI_BK2_IO1 */
> @@ -1551,6 +1662,7 @@ pins {
>  	};
>  
>  	qspi_cs1_pins_a: qspi-cs1-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 6, AF10)>; /* QSPI_BK1_NCS */
>  			bias-pull-up;
> @@ -1560,12 +1672,14 @@ pins {
>  	};
>  
>  	qspi_cs1_sleep_pins_a: qspi-cs1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 6, ANALOG)>; /* QSPI_BK1_NCS */
>  		};
>  	};
>  
>  	qspi_cs2_pins_a: qspi-cs2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 0, AF10)>; /* QSPI_BK2_NCS */
>  			bias-pull-up;
> @@ -1575,12 +1689,14 @@ pins {
>  	};
>  
>  	qspi_cs2_sleep_pins_a: qspi-cs2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 0, ANALOG)>; /* QSPI_BK2_NCS */
>  		};
>  	};
>  
>  	sai2a_pins_a: sai2a-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 5, AF10)>, /* SAI2_SCK_A */
>  				 <STM32_PINMUX('I', 6, AF10)>, /* SAI2_SD_A */
> @@ -1593,6 +1709,7 @@ pins {
>  	};
>  
>  	sai2a_sleep_pins_a: sai2a-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* SAI2_SCK_A */
>  				 <STM32_PINMUX('I', 6, ANALOG)>, /* SAI2_SD_A */
> @@ -1602,6 +1719,7 @@ pins {
>  	};
>  
>  	sai2a_pins_b: sai2a-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('I', 6, AF10)>,	/* SAI2_SD_A */
>  				 <STM32_PINMUX('I', 7, AF10)>,	/* SAI2_FS_A */
> @@ -1613,6 +1731,7 @@ pins1 {
>  	};
>  
>  	sai2a_sleep_pins_b: sai2a-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 6, ANALOG)>,  /* SAI2_SD_A */
>  				 <STM32_PINMUX('I', 7, ANALOG)>,  /* SAI2_FS_A */
> @@ -1621,6 +1740,7 @@ pins {
>  	};
>  
>  	sai2a_pins_c: sai2a-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 13, AF10)>, /* SAI2_SCK_A */
>  				 <STM32_PINMUX('D', 11, AF10)>, /* SAI2_SD_A */
> @@ -1632,6 +1752,7 @@ pins {
>  	};
>  
>  	sai2a_sleep_pins_c: sai2a-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 13, ANALOG)>, /* SAI2_SCK_A */
>  				 <STM32_PINMUX('D', 11, ANALOG)>, /* SAI2_SD_A */
> @@ -1640,6 +1761,7 @@ pins {
>  	};
>  
>  	sai2b_pins_a: sai2b-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('E', 12, AF10)>, /* SAI2_SCK_B */
>  				 <STM32_PINMUX('E', 13, AF10)>, /* SAI2_FS_B */
> @@ -1655,6 +1777,7 @@ pins2 {
>  	};
>  
>  	sai2b_sleep_pins_a: sai2b-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* SAI2_SD_B */
>  				 <STM32_PINMUX('E', 12, ANALOG)>, /* SAI2_SCK_B */
> @@ -1664,6 +1787,7 @@ pins {
>  	};
>  
>  	sai2b_pins_b: sai2b-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
>  			bias-disable;
> @@ -1671,12 +1795,14 @@ pins {
>  	};
>  
>  	sai2b_sleep_pins_b: sai2b-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
>  		};
>  	};
>  
>  	sai2b_pins_c: sai2b-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
>  			bias-disable;
> @@ -1684,12 +1810,14 @@ pins1 {
>  	};
>  
>  	sai2b_sleep_pins_c: sai2b-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
>  		};
>  	};
>  
>  	sai2b_pins_d: sai2b-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('H', 2, AF10)>, /* SAI2_SCK_B */
>  				 <STM32_PINMUX('C', 0, AF8)>, /* SAI2_FS_B */
> @@ -1705,6 +1833,7 @@ pins2 {
>  	};
>  
>  	sai2b_sleep_pins_d: sai2b-sleep-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* SAI2_SCK_B */
>  				 <STM32_PINMUX('C', 0, ANALOG)>, /* SAI2_FS_B */
> @@ -1714,6 +1843,7 @@ pins1 {
>  	};
>  
>  	sai4a_pins_a: sai4a-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 5, AF10)>; /* SAI4_SD_A */
>  			slew-rate = <0>;
> @@ -1723,12 +1853,14 @@ pins {
>  	};
>  
>  	sai4a_sleep_pins_a: sai4a-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 5, ANALOG)>; /* SAI4_SD_A */
>  		};
>  	};
>  
>  	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>  				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> @@ -1748,6 +1880,7 @@ pins2 {
>  	};
>  
>  	sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>  				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> @@ -1772,6 +1905,7 @@ pins3 {
>  	};
>  
>  	sdmmc1_b4_init_pins_a: sdmmc1-b4-init-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>  				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> @@ -1784,6 +1918,7 @@ pins1 {
>  	};
>  
>  	sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
>  				 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
> @@ -1795,6 +1930,7 @@ pins {
>  	};
>  
>  	sdmmc1_b4_pins_b: sdmmc1-b4-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>  				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> @@ -1814,6 +1950,7 @@ pins2 {
>  	};
>  
>  	sdmmc1_b4_od_pins_b: sdmmc1-b4-od-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>  				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> @@ -1838,6 +1975,7 @@ pins3 {
>  	};
>  
>  	sdmmc1_b4_sleep_pins_b: sdmmc1-b4-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
>  				 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
> @@ -1849,6 +1987,7 @@ pins {
>  	};
>  
>  	sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
>  				 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
> @@ -1864,6 +2003,7 @@ pins2 {
>  	};
>  
>  	sdmmc1_dir_init_pins_a: sdmmc1-dir-init-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
>  				 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
> @@ -1875,6 +2015,7 @@ pins1 {
>  	};
>  
>  	sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 2, ANALOG)>, /* SDMMC1_D0DIR */
>  				 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
> @@ -1884,6 +2025,7 @@ pins {
>  	};
>  
>  	sdmmc1_dir_pins_b: sdmmc1-dir-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
>  				 <STM32_PINMUX('E', 14, AF11)>, /* SDMMC1_D123DIR */
> @@ -1899,6 +2041,7 @@ pins2 {
>  	};
>  
>  	sdmmc1_dir_sleep_pins_b: sdmmc1-dir-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 2, ANALOG)>, /* SDMMC1_D0DIR */
>  				 <STM32_PINMUX('E', 14, ANALOG)>, /* SDMMC1_D123DIR */
> @@ -1908,6 +2051,7 @@ pins {
>  	};
>  
>  	sdmmc2_b4_pins_a: sdmmc2-b4-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
>  				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
> @@ -1927,6 +2071,7 @@ pins2 {
>  	};
>  
>  	sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
>  				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
> @@ -1951,6 +2096,7 @@ pins3 {
>  	};
>  
>  	sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
>  				 <STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC2_D1 */
> @@ -1962,6 +2108,7 @@ pins {
>  	};
>  
>  	sdmmc2_b4_pins_b: sdmmc2-b4-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
>  				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
> @@ -1981,6 +2128,7 @@ pins2 {
>  	};
>  
>  	sdmmc2_b4_od_pins_b: sdmmc2-b4-od-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
>  				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC2_D1 */
> @@ -2005,6 +2153,7 @@ pins3 {
>  	};
>  
>  	sdmmc2_d47_pins_a: sdmmc2-d47-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
> @@ -2017,6 +2166,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_sleep_pins_a: sdmmc2-d47-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
> @@ -2026,6 +2176,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_pins_b: sdmmc2-d47-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, AF9)>,  /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
> @@ -2038,6 +2189,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_sleep_pins_b: sdmmc2-d47-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
> @@ -2047,6 +2199,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_pins_c: sdmmc2-d47-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 15, AF9)>, /* SDMMC2_D5 */
> @@ -2059,6 +2212,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_sleep_pins_c: sdmmc2-d47-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 15, ANALOG)>, /* SDMMC2_D5 */
> @@ -2068,6 +2222,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_pins_d: sdmmc2-d47-3 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
> @@ -2077,6 +2232,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_sleep_pins_d: sdmmc2-d47-sleep-3 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
> @@ -2086,6 +2242,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_pins_e: sdmmc2-d47-4 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, AF9)>,	/* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, AF10)>,	/* SDMMC2_D5 */
> @@ -2098,6 +2255,7 @@ pins {
>  	};
>  
>  	sdmmc2_d47_sleep_pins_e: sdmmc2-d47-sleep-4 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
>  				 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
> @@ -2107,6 +2265,7 @@ pins {
>  	};
>  
>  	sdmmc3_b4_pins_a: sdmmc3-b4-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
>  				 <STM32_PINMUX('F', 4, AF9)>, /* SDMMC3_D1 */
> @@ -2126,6 +2285,7 @@ pins2 {
>  	};
>  
>  	sdmmc3_b4_od_pins_a: sdmmc3-b4-od-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
>  				 <STM32_PINMUX('F', 4, AF9)>, /* SDMMC3_D1 */
> @@ -2150,6 +2310,7 @@ pins3 {
>  	};
>  
>  	sdmmc3_b4_sleep_pins_a: sdmmc3-b4-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 0, ANALOG)>, /* SDMMC3_D0 */
>  				 <STM32_PINMUX('F', 4, ANALOG)>, /* SDMMC3_D1 */
> @@ -2161,6 +2322,7 @@ pins {
>  	};
>  
>  	sdmmc3_b4_pins_b: sdmmc3-b4-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
>  				 <STM32_PINMUX('F', 4, AF9)>, /* SDMMC3_D1 */
> @@ -2180,6 +2342,7 @@ pins2 {
>  	};
>  
>  	sdmmc3_b4_od_pins_b: sdmmc3-b4-od-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 0, AF9)>, /* SDMMC3_D0 */
>  				 <STM32_PINMUX('F', 4, AF9)>, /* SDMMC3_D1 */
> @@ -2204,6 +2367,7 @@ pins3 {
>  	};
>  
>  	sdmmc3_b4_sleep_pins_b: sdmmc3-b4-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 0, ANALOG)>, /* SDMMC3_D0 */
>  				 <STM32_PINMUX('F', 4, ANALOG)>, /* SDMMC3_D1 */
> @@ -2215,6 +2379,7 @@ pins {
>  	};
>  
>  	spdifrx_pins_a: spdifrx-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G', 12, AF8)>; /* SPDIF_IN1 */
>  			bias-disable;
> @@ -2222,12 +2387,14 @@ pins {
>  	};
>  
>  	spdifrx_sleep_pins_a: spdifrx-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G', 12, ANALOG)>; /* SPDIF_IN1 */
>  		};
>  	};
>  
>  	spi1_pins_b: spi1-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 5, AF5)>, /* SPI1_SCK */
>  				 <STM32_PINMUX('B', 5, AF5)>; /* SPI1_MOSI */
> @@ -2243,6 +2410,7 @@ pins2 {
>  	};
>  
>  	spi2_pins_a: spi2-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF5)>, /* SPI2_SCK */
>  				 <STM32_PINMUX('I', 3, AF5)>; /* SPI2_MOSI */
> @@ -2258,6 +2426,7 @@ pins2 {
>  	};
>  
>  	spi2_pins_b: spi2-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('I', 1, AF5)>, /* SPI2_SCK */
>  				 <STM32_PINMUX('I', 3, AF5)>; /* SPI2_MOSI */
> @@ -2273,6 +2442,7 @@ pins2 {
>  	};
>  
>  	spi2_pins_c: spi2-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('I', 1, AF5)>, /* SPI2_SCK */
>  				 <STM32_PINMUX('I', 3, AF5)>; /* SPI2_MOSI */
> @@ -2287,6 +2457,7 @@ pins2 {
>  	};
>  
>  	spi4_pins_a: spi4-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
>  				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
> @@ -2301,6 +2472,7 @@ pins2 {
>  	};
>  
>  	spi5_pins_a: spi5-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 7, AF5)>, /* SPI5_SCK */
>  				 <STM32_PINMUX('F', 9, AF5)>; /* SPI5_MOSI */
> @@ -2316,6 +2488,7 @@ pins2 {
>  	};
>  
>  	stusb1600_pins_a: stusb1600-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('I', 11, GPIO)>;
>  			bias-pull-up;
> @@ -2323,6 +2496,7 @@ pins {
>  	};
>  
>  	uart4_pins_a: uart4-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
>  			bias-disable;
> @@ -2336,6 +2510,7 @@ pins2 {
>  	};
>  
>  	uart4_idle_pins_a: uart4-idle-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
>  		};
> @@ -2346,6 +2521,7 @@ pins2 {
>  	};
>  
>  	uart4_sleep_pins_a: uart4-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G', 11, ANALOG)>, /* UART4_TX */
>  				 <STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
> @@ -2353,6 +2529,7 @@ pins {
>  	};
>  
>  	uart4_pins_b: uart4-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('D', 1, AF8)>; /* UART4_TX */
>  			bias-disable;
> @@ -2366,6 +2543,7 @@ pins2 {
>  	};
>  
>  	uart4_pins_c: uart4-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
>  			bias-disable;
> @@ -2379,6 +2557,7 @@ pins2 {
>  	};
>  
>  	uart4_pins_d: uart4-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 13, AF8)>; /* UART4_TX */
>  			bias-disable;
> @@ -2392,6 +2571,7 @@ pins2 {
>  	};
>  
>  	uart4_idle_pins_d: uart4-idle-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 13, ANALOG)>; /* UART4_TX */
>  		};
> @@ -2402,6 +2582,7 @@ pins2 {
>  	};
>  
>  	uart4_sleep_pins_d: uart4-sleep-3 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 13, ANALOG)>, /* UART4_TX */
>  				 <STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
> @@ -2409,6 +2590,7 @@ pins {
>  	};
>  
>  	uart5_pins_a: uart5-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 13, AF14)>; /* UART5_TX */
>  			bias-disable;
> @@ -2422,6 +2604,7 @@ pins2 {
>  	};
>  
>  	uart7_pins_a: uart7-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART7_TX */
>  			bias-disable;
> @@ -2437,6 +2620,7 @@ pins2 {
>  	};
>  
>  	uart7_pins_b: uart7-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 7, AF7)>; /* UART7_TX */
>  			bias-disable;
> @@ -2450,6 +2634,7 @@ pins2 {
>  	};
>  
>  	uart7_pins_c: uart7-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART7_TX */
>  			bias-disable;
> @@ -2463,6 +2648,7 @@ pins2 {
>  	};
>  
>  	uart7_idle_pins_c: uart7-idle-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('E', 8, ANALOG)>; /* UART7_TX */
>  		};
> @@ -2473,6 +2659,7 @@ pins2 {
>  	};
>  
>  	uart7_sleep_pins_c: uart7-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('E', 8, ANALOG)>, /* UART7_TX */
>  				 <STM32_PINMUX('E', 7, ANALOG)>; /* UART7_RX */
> @@ -2480,6 +2667,7 @@ pins {
>  	};
>  
>  	uart8_pins_a: uart8-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
>  			bias-disable;
> @@ -2493,6 +2681,7 @@ pins2 {
>  	};
>  
>  	uart8_rtscts_pins_a: uart8rtscts-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('G', 7, AF8)>, /* UART8_RTS */
>  				 <STM32_PINMUX('G', 10, AF8)>; /* UART8_CTS */
> @@ -2501,6 +2690,7 @@ pins {
>  	};
>  
>  	usart1_pins_a: usart1-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 12, AF7)>; /* USART1_RTS */
>  			bias-disable;
> @@ -2514,6 +2704,7 @@ pins2 {
>  	};
>  
>  	usart1_idle_pins_a: usart1-idle-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 12, ANALOG)>, /* USART1_RTS */
>  				 <STM32_PINMUX('A', 11, AF7)>; /* USART1_CTS_NSS */
> @@ -2521,6 +2712,7 @@ pins1 {
>  	};
>  
>  	usart1_sleep_pins_a: usart1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 12, ANALOG)>, /* USART1_RTS */
>  				 <STM32_PINMUX('A', 11, ANALOG)>; /* USART1_CTS_NSS */
> @@ -2528,6 +2720,7 @@ pins {
>  	};
>  
>  	usart2_pins_a: usart2-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
>  				 <STM32_PINMUX('D', 4, AF7)>; /* USART2_RTS */
> @@ -2543,6 +2736,7 @@ pins2 {
>  	};
>  
>  	usart2_sleep_pins_a: usart2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 5, ANALOG)>, /* USART2_TX */
>  				 <STM32_PINMUX('D', 4, ANALOG)>, /* USART2_RTS */
> @@ -2552,6 +2746,7 @@ pins {
>  	};
>  
>  	usart2_pins_b: usart2-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
>  				 <STM32_PINMUX('A', 1, AF7)>; /* USART2_RTS */
> @@ -2567,6 +2762,7 @@ pins2 {
>  	};
>  
>  	usart2_sleep_pins_b: usart2-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('F', 5, ANALOG)>, /* USART2_TX */
>  				 <STM32_PINMUX('A', 1, ANALOG)>, /* USART2_RTS */
> @@ -2576,6 +2772,7 @@ pins {
>  	};
>  
>  	usart2_pins_c: usart2-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('D', 5, AF7)>, /* USART2_TX */
>  				 <STM32_PINMUX('D', 4, AF7)>; /* USART2_RTS */
> @@ -2591,6 +2788,7 @@ pins2 {
>  	};
>  
>  	usart2_idle_pins_c: usart2-idle-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('D', 5, ANALOG)>, /* USART2_TX */
>  				 <STM32_PINMUX('D', 3, ANALOG)>; /* USART2_CTS_NSS */
> @@ -2608,6 +2806,7 @@ pins3 {
>  	};
>  
>  	usart2_sleep_pins_c: usart2-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('D', 5, ANALOG)>, /* USART2_TX */
>  				 <STM32_PINMUX('D', 4, ANALOG)>, /* USART2_RTS */
> @@ -2617,6 +2816,7 @@ pins {
>  	};
>  
>  	usart3_pins_a: usart3-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
>  			bias-disable;
> @@ -2630,6 +2830,7 @@ pins2 {
>  	};
>  
>  	usart3_idle_pins_a: usart3-idle-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>; /* USART3_TX */
>  		};
> @@ -2640,6 +2841,7 @@ pins2 {
>  	};
>  
>  	usart3_sleep_pins_a: usart3-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('B', 12, ANALOG)>; /* USART3_RX */
> @@ -2647,6 +2849,7 @@ pins {
>  	};
>  
>  	usart3_pins_b: usart3-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> @@ -2662,6 +2865,7 @@ pins2 {
>  	};
>  
>  	usart3_idle_pins_b: usart3-idle-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('I', 10, ANALOG)>; /* USART3_CTS_NSS */
> @@ -2679,6 +2883,7 @@ pins3 {
>  	};
>  
>  	usart3_sleep_pins_b: usart3-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> @@ -2688,6 +2893,7 @@ pins {
>  	};
>  
>  	usart3_pins_c: usart3-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> @@ -2703,6 +2909,7 @@ pins2 {
>  	};
>  
>  	usart3_idle_pins_c: usart3-idle-2 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('B', 13, ANALOG)>; /* USART3_CTS_NSS */
> @@ -2720,6 +2927,7 @@ pins3 {
>  	};
>  
>  	usart3_sleep_pins_c: usart3-sleep-2 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> @@ -2729,6 +2937,7 @@ pins {
>  	};
>  
>  	usart3_pins_d: usart3-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> @@ -2744,6 +2953,7 @@ pins2 {
>  	};
>  
>  	usart3_idle_pins_d: usart3-idle-3 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> @@ -2756,6 +2966,7 @@ pins2 {
>  	};
>  
>  	usart3_sleep_pins_d: usart3-sleep-3 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> @@ -2765,6 +2976,7 @@ pins {
>  	};
>  
>  	usart3_pins_e: usart3-4 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> @@ -2780,6 +2992,7 @@ pins2 {
>  	};
>  
>  	usart3_idle_pins_e: usart3-idle-4 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('D', 11, ANALOG)>; /* USART3_CTS_NSS */
> @@ -2797,6 +3010,7 @@ pins3 {
>  	};
>  
>  	usart3_sleep_pins_e: usart3-sleep-4 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
>  				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> @@ -2806,6 +3020,7 @@ pins {
>  	};
>  
>  	usart3_pins_f: usart3-5 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
>  				 <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS */
> @@ -2821,12 +3036,14 @@ pins2 {
>  	};
>  
>  	usbotg_hs_pins_a: usbotg-hs-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 10, ANALOG)>; /* OTG_ID */
>  		};
>  	};
>  
>  	usbotg_fs_dp_dm_pins_a: usbotg-fs-dp-dm-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* OTG_FS_DM */
>  				 <STM32_PINMUX('A', 12, ANALOG)>; /* OTG_FS_DP */
> @@ -2836,6 +3053,7 @@ pins {
>  
>  &pinctrl_z {
>  	i2c2_pins_b2: i2c2-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 0, AF3)>; /* I2C2_SCL */
>  			bias-disable;
> @@ -2845,12 +3063,14 @@ pins {
>  	};
>  
>  	i2c2_sleep_pins_b2: i2c2-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 0, ANALOG)>; /* I2C2_SCL */
>  		};
>  	};
>  
>  	i2c4_pins_a: i2c4-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 4, AF6)>, /* I2C4_SCL */
>  				 <STM32_PINMUX('Z', 5, AF6)>; /* I2C4_SDA */
> @@ -2861,6 +3081,7 @@ pins {
>  	};
>  
>  	i2c4_sleep_pins_a: i2c4-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 4, ANALOG)>, /* I2C4_SCL */
>  				 <STM32_PINMUX('Z', 5, ANALOG)>; /* I2C4_SDA */
> @@ -2868,6 +3089,7 @@ pins {
>  	};
>  
>  	i2c6_pins_a: i2c6-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 6, AF2)>, /* I2C6_SCL */
>  				 <STM32_PINMUX('Z', 7, AF2)>; /* I2C6_SDA */
> @@ -2878,6 +3100,7 @@ pins {
>  	};
>  
>  	i2c6_sleep_pins_a: i2c6-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 6, ANALOG)>, /* I2C6_SCL */
>  				 <STM32_PINMUX('Z', 7, ANALOG)>; /* I2C6_SDA */
> @@ -2885,6 +3108,7 @@ pins {
>  	};
>  
>  	spi1_pins_a: spi1-0 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('Z', 0, AF5)>, /* SPI1_SCK */
>  				 <STM32_PINMUX('Z', 2, AF5)>; /* SPI1_MOSI */
> @@ -2900,6 +3124,7 @@ pins2 {
>  	};
>  
>  	spi1_sleep_pins_a: spi1-sleep-0 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 0, ANALOG)>, /* SPI1_SCK */
>  				 <STM32_PINMUX('Z', 1, ANALOG)>, /* SPI1_MISO */
> @@ -2908,6 +3133,7 @@ pins {
>  	};
>  
>  	usart1_pins_b: usart1-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('Z', 7, AF7)>; /* USART1_TX */
>  			bias-disable;
> @@ -2921,6 +3147,7 @@ pins2 {
>  	};
>  
>  	usart1_idle_pins_b: usart1-idle-1 {
> +		/omit-if-no-ref/
>  		pins1 {
>  			pinmux = <STM32_PINMUX('Z', 7, ANALOG)>; /* USART1_TX */
>  		};
> @@ -2931,6 +3158,7 @@ pins2 {
>  	};
>  
>  	usart1_sleep_pins_b: usart1-sleep-1 {
> +		/omit-if-no-ref/
>  		pins {
>  			pinmux = <STM32_PINMUX('Z', 7, ANALOG)>, /* USART1_TX */
>  				 <STM32_PINMUX('Z', 6, ANALOG)>; /* USART1_RX */

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

