Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA2777746
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjHJLiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjHJLhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:37:53 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641C2738;
        Thu, 10 Aug 2023 04:37:51 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37A7foLC008014;
        Thu, 10 Aug 2023 13:37:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=LGWUQDFoq0k+Yvp42HGxHlH78UJNLF3xltDQPEr71KE=; b=xN
        Dahq6C+GXGGITaUq8xQbace9vRZVyXHe1SKFObwhLHPdgIsiBDJ2I2fRpgeL+mEx
        t8wUeVeAlMy67HAMljHQjZxcvFZva/iO4RT5eDGZUjEAKkB+h9ZJ/EMDVQYstYC2
        dKp0WdfjCq0c+67vXyWQ/RAQQMYfht1ljn239QUZnhuWIy60NGSh3Qo6+S+kjI0O
        8ksf89DU+a1k4nQQepMrTjgyyEwzNcVMfWo8yyXWTRW8WCisbZ4KHUYZBOV6aGSH
        I5+knCvkqvhKBlaYC4a/1zyKqGAoytlmQE64iI5FDaC67eRav/FVOHwHF9k2ojSF
        4eINrE0bM4oxJQM5GUnQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3scdv7ns8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 13:37:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 219B8100053;
        Thu, 10 Aug 2023 13:37:26 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E9CD921512B;
        Thu, 10 Aug 2023 13:37:24 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 13:37:24 +0200
Message-ID: <3f94ec91-214c-cbd1-d113-bb9e6a89c7d3@foss.st.com>
Date:   Thu, 10 Aug 2023 13:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 9/9] ARM: dts: stm32: Add Octavo OSD32MP1-RED board
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>, <l.goehrs@pengutronix.de>,
        <a.fatoum@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <dantuguf14105@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230712124248.2400862-1-sean@geanix.com>
 <20230712124248.2400862-9-sean@geanix.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230712124248.2400862-9-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean

On 7/12/23 14:42, Sean Nyekjaer wrote:
> Add support for the Octavo OSD32MP1-RED development board.
> 
> General features:
>   - STM32MP157C
>   - 512MB DDR3
>   - CAN-FD
>   - HDMI
>   - USB-C OTG
>   - UART
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
> Changes since v1:
>   - Fixed comments from Ahmad
> 
> Changes since v2:
>   - Reordered phandles alfabetically
>   - Added devicetree to Makefile
> 
> Changes since v3:
>   - Explained the dma disable
>   - Removed the status ok for hdmi-transmitter
> 
>   arch/arm/boot/dts/st/Makefile                 |   3 +-
>   .../boot/dts/st/stm32mp157c-osd32mp1-red.dts  | 226 ++++++++++++++++++
>   2 files changed, 228 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
> 

Sorry for my late answer (just back from vacations). I got some build issue:

make W=1 st/stm32mp157c-osd32mp1-red.dtb

   DTC     arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts:138.4-14: Warning 
(reg_format): /soc/display-controller@5a001000/port/endpoint@0:reg: 
property has invalid length (4 bytes) (#address-cells == 2, #size-cells 
== 1)
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: Warning 
(pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: Warning 
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: Warning 
(simple_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: Warning 
(i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: Warning 
(spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts:137.28-140.5: Warning 
(avoid_default_addr_size): 
/soc/display-controller@5a001000/port/endpoint@0: Relying on default 
#address-cells value
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts:137.28-140.5: Warning 
(avoid_default_addr_size): 
/soc/display-controller@5a001000/port/endpoint@0: Relying on default 
#size-cells value
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: Warning 
(avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: Warning 
(unique_unit_address_if_enabled): Failed prerequisite 
'avoid_default_addr_size'
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts:137.28-140.5: Warning 
(graph_endpoint): /soc/display-controller@5a001000/port/endpoint@0: 
graph node '#address-cells' is -1, must be 1
arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts:137.28-140.5: Warning 
(graph_endpoint): /soc/display-controller@5a001000/port/endpoint@0: 
graph node '#size-cells' is -1, must be 0


And Yaml verification issue:


  make CHECK_DTBS=y st/stm32mp157c-osd32mp1-red.dtb

   UPD     include/config/kernel.release
   LINT    Documentation/devicetree/bindings
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
/local/home/frq08678/STLINUX/kernel/my-kernel/stm32/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml: 
properties:adi,ext1-burnout-current-nanoamp: '$ref' should not be valid 
under {'const': '$ref'}
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/local/home/frq08678/STLINUX/kernel/my-kernel/stm32/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml: 
properties:adi,ext2-burnout-current-nanoamp: '$ref' should not be valid 
under {'const': '$ref'}
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/local/home/frq08678/STLINUX/kernel/my-kernel/stm32/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml: 
properties:adi,viout-burnout-current-nanoamp: '$ref' should not be valid 
under {'const': '$ref'}
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTC_CHK arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb

/local/home/frq08678/STLINUX/kernel/my-kernel/stm32/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: 
audio-controller@4000b000: port:endpoint: Unevaluated properties are not 
allowed ('format' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/st,stm32-i2s.yaml#
/local/home/frq08678/STLINUX/kernel/my-kernel/stm32/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dtb: 
audio-controller@4000b000: Unevaluated properties are not allowed 
('port' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/st,stm32-i2s.yaml#


I think we recently fixed some of them for ST boards, you could have a 
look on correction we did.

Regards
Alex


> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
> index 44b264c399ec..94feb1f1d569 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -59,7 +59,8 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32mp157c-lxa-tac-gen1.dtb \
>   	stm32mp157c-lxa-tac-gen2.dtb \
>   	stm32mp157c-odyssey.dtb \
> -	stm32mp157c-phycore-stm32mp1-3.dtb
> +	stm32mp157c-phycore-stm32mp1-3.dtb \
> +	stm32mp157c-osd32mp1-red.dtb
>   dtb-$(CONFIG_ARCH_U8500) += \
>   	ste-snowball.dtb \
>   	ste-hrefprev60-stuib.dtb \
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
> new file mode 100644
> index 000000000000..2e2751a62aaf
> --- /dev/null
> +++ b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Geanix ApS 2023 - All Rights Reserved
> + * Author: Sean Nyekjaer <sean@geanix.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "stm32mp157.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15xx-osd32.dtsi"
> +#include "stm32mp15xxac-pinctrl.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> +
> +/ {
> +	model = "Octavo OSD32MP1 RED board";
> +	compatible = "oct,stm32mp157c-osd32-red", "oct,stm32mp15xx-osd32", "st,stm32mp157";
> +
> +	aliases {
> +		serial0 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	led-controller-0 {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			label = "heartbeat";
> +			gpios = <&gpiod 11 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&crc1 {
> +	status = "okay";
> +};
> +
> +&dts {
> +	status = "okay";
> +};
> +
> +&ethernet0 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> +	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_a>;
> +	phy-mode = "rgmii-id";
> +	max-speed = <1000>;
> +	phy-handle = <&phy0>;
> +	st,eth-clk-sel;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy@3 {
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	pinctrl-1 = <&i2c1_sleep_pins_a>;
> +	status = "okay";
> +	i2c-scl-rising-time-ns = <100>;
> +	i2c-scl-falling-time-ns = <7>;
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	hdmi-transmitter@39 {
> +		compatible = "sil,sii9022";
> +		reg = <0x39>;
> +		reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&gpiog>;
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ltdc_pins_e>;
> +		pinctrl-1 = <&ltdc_sleep_pins_e>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				sii9022_in: endpoint {
> +					remote-endpoint = <&ltdc_ep0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				sii9022_tx_endpoint: endpoint {
> +					remote-endpoint = <&i2s2_endpoint>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2s2 {
> +	clocks = <&rcc SPI2>, <&rcc SPI2_K>, <&rcc CK_PER>, <&rcc PLL3_R>;
> +	clock-names = "pclk", "i2sclk", "x8k", "x11k";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2s2_pins_b>;
> +	pinctrl-1 = <&i2s2_sleep_pins_b>;
> +	status = "okay";
> +
> +	i2s2_port: port {
> +		i2s2_endpoint: endpoint {
> +			remote-endpoint = <&sii9022_tx_endpoint>;
> +			format = "i2s";
> +			mclk-fs = <256>;
> +		};
> +	};
> +};
> +
> +&ltdc {
> +	status = "okay";
> +
> +	port {
> +		ltdc_ep0_out: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&sii9022_in>;
> +		};
> +	};
> +};
> +
> +&m_can1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&m_can1_pins_d>;
> +	pinctrl-1 = <&m_can1_sleep_pins_d>;
> +	status = "okay";
> +};
> +
> +&pwr_regulators {
> +	vdd-supply = <&vdd>;
> +	vdd_3v3_usbfs-supply = <&vdd_usb>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> +	cd-gpios = <&gpioe 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	disable-wp;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	status = "okay";
> +};
> +
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_d>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_d>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	st,neg-edge;
> +	bus-width = <8>;
> +	vmmc-supply = <&v3v3>;
> +	vqmmc-supply = <&vdd>;
> +	mmc-ddr-3_3v;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart4_pins_a>;
> +	pinctrl-1 = <&uart4_sleep_pins_a>;
> +	pinctrl-2 = <&uart4_idle_pins_a>;
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +};
> +
> +&usbh_ehci {
> +	phys = <&usbphyc_port0>;
> +	phy-names = "usb";
> +	status = "okay";
> +};
> +
> +&usbh_ohci {
> +	phys = <&usbphyc_port0>;
> +	phy-names = "usb";
> +	status = "okay";
> +};
> +
> +&usbotg_hs {
> +	vbus-supply = <&vbus_otg>;
> +};
> +
> +&usbphyc {
> +	status = "okay";
> +};
> +
> +&usbphyc_port0 {
> +	phy-supply = <&vdd_usb>;
> +};
> +
> +&usbphyc_port1 {
> +	phy-supply = <&vdd_usb>;
> +};

