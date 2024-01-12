Return-Path: <linux-kernel+bounces-24711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D91782C126
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF73B23486
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE66D1BC;
	Fri, 12 Jan 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MoMDc32t"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC16BB40;
	Fri, 12 Jan 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C8bMSh014558;
	Fri, 12 Jan 2024 14:52:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=bQDWIGEUgxPtuigdQYbYpc8qQmx6+NnBxK0RzcsvHAk=; b=Mo
	MDc32tNZ2bdXNePfuK2gQh17PuuNs5HDWkF7eC0e2Bp0QqQ4Fi9D3QoweqBAgHb7
	5BwkGP5Ay1SVvg7oacZ4M6P09cD48CmFExeA8AM1n+G7rqU8chGQhz8+o3D4aZyU
	32AoO6RFggFYb6q8fC0WqLeDYm2gy6deaScB8KdCaauewtSqx2mFApN0wvsEn35t
	gG8UYxfdCR1nqK1Wh5XGv5QbWSqp5mp2/cCjBagOHFAzW68qsamp9/59kZoXPT8C
	B/4nzc3m2m73SomaMBXTlfdSMibFVJeIkar3P0GIfhad8G3LaZh1izZZs/i+g1ru
	HbFdBGkEFOLhjveIPeFQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vk22w9ab1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:52:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BCC1410002A;
	Fri, 12 Jan 2024 14:52:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA420215159;
	Fri, 12 Jan 2024 14:52:27 +0100 (CET)
Received: from [10.129.178.37] (10.129.178.37) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Jan
 2024 14:52:24 +0100
Message-ID: <3552f3e5-01cc-4e95-a055-f7aea0f8dc4b@foss.st.com>
Date: Fri, 12 Jan 2024 14:52:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] ARM: dts: stm32: add display support on
 stm32f769-disco
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-amarula@amarulasolutions.com>, Lee Jones <lee@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240111113146.16011-1-dario.binacchi@amarulasolutions.com>
 <20240111113146.16011-5-dario.binacchi@amarulasolutions.com>
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240111113146.16011-5-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02


On 1/11/24 12:31, Dario Binacchi wrote:
> The patch adds display support on the stm32f769-disco board.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  arch/arm/boot/dts/st/stm32f769-disco.dts | 72 +++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
> index 8632bd866272..d1eb5f9c78bf 100644
> --- a/arch/arm/boot/dts/st/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
> @@ -41,7 +41,7 @@
>   */
>  
>  /dts-v1/;
> -#include "stm32f746.dtsi"
> +#include "stm32f769.dtsi"
>  #include "stm32f769-pinctrl.dtsi"
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
> @@ -60,6 +60,19 @@ memory@c0000000 {
>  		reg = <0xC0000000 0x1000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			linux,dma-default;
> +			no-map;
> +			size = <0x100000>;
> +		};
> +	};
> +
>  	aliases {
>  		serial0 = &usart1;
>  	};
> @@ -85,6 +98,13 @@ button-0 {
>  		};
>  	};
>  
> +	panel_backlight: panel-backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpioi 14 GPIO_ACTIVE_HIGH>;
> +		default-on;
> +		status = "okay";
> +	};
> +
>  	usbotg_hs_phy: usb-phy {
>  		#phy-cells = <0>;
>  		compatible = "usb-nop-xceiv";
> @@ -114,6 +134,46 @@ &clk_hse {
>  	clock-frequency = <25000000>;
>  };
>  
> +&dsi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			dsi_in: endpoint {
> +				remote-endpoint = <&ltdc_out_dsi>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			dsi_out: endpoint {
> +				remote-endpoint = <&dsi_panel_in>;
> +			};
> +		};
> +	};
> +
> +	panel0: panel-dsi@0 {
> +		compatible = "orisetech,otm8009a";
> +		reg = <0>; /* dsi virtual channel (0..3) */
> +		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
> +		power-supply = <&vcc_3v3>;
> +		backlight = <&panel_backlight>;
> +		status = "okay";
> +
> +		port {
> +			dsi_panel_in: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +};
> +
>  &i2c1 {
>  	pinctrl-0 = <&i2c1_pins_b>;
>  	pinctrl-names = "default";
> @@ -122,6 +182,16 @@ &i2c1 {
>  	status = "okay";
>  };
>  
> +&ltdc {
> +	status = "okay";
> +
> +	port {
> +		ltdc_out_dsi: endpoint@0 {

Hi Dario,

There is no need for unit name on this endpoint since it is alone.

Otherwise it triggers this warning at build time :

../arch/arm/boot/dts/st/stm32f769-disco.dts:189.28-191.5: Warning
(unit_address_vs_reg): /soc/display-controller@40016800/port/endpoint@0: node
has a unit name, but no reg or ranges property

../arch/arm/boot/dts/st/stm32f769-disco.dts:189.28-191.5: Warning
(unit_address_vs_reg): /soc/display-controller@40016800/port/endpoint@0: node
has a unit name, but no reg or ranges property


Regards,

Raphaël

> +			remote-endpoint = <&dsi_in>;
> +		};
> +	};
> +};
> +
>  &rtc {
>  	status = "okay";
>  };

