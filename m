Return-Path: <linux-kernel+bounces-127607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864F5894E54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C461C2224E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DDC5731E;
	Tue,  2 Apr 2024 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="i71bd1oB"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E0D17C7C;
	Tue,  2 Apr 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048854; cv=none; b=H2KPJc4ArfWlywywBpiK5fXZT/ywu5/OdV173FMnzUUsm6fJGb4DmXNmpFOHq/ABnSlEhSG3bfNYxahyhDCWzaX/zixaaYJ9IP11ueX1AcosZgulAaNb7gHIw5piYpj21GhdfQI+ZNWWMzmw55sOBaxCEjHU9za3GIdkMmifP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048854; c=relaxed/simple;
	bh=D6WrjkDPoDGOGRdjF9W8yG6nCD7d5fEpEm8TrvcfTFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8QHvE/k0T4ionf6WF5jY6ICOopuXlt2e6T00J8UaNVDiVcQpWEfEfpCx/n++28Y5eFdjn5e3gt25w5If524pZCj90OF13TkDf5+ju7YRPtmyLKmdTmL7MMq5i1CLHFEYzcawo7O/8jLZTtIhDAOAUaznomcN5lwc9pTWUVzd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=i71bd1oB; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=v7Irp6bBJXCNebn36Vh9yPqqXllV/JsIy2dz+cR9M1U=;
	b=i71bd1oBVnbF2weU2rijlRWhD80QnleM+MIkGvEuKtUZ0fiSSP1mr6DnM7Jruk
	5ZVPZVq9CmyjchKiLVd3k4jlC/UBPbafA1tdsuqOu2pbx/iZbbgGtcLSxuyfSPOl
	XahU3ZEsKYmpjll6AxDnGAPOgRzkRPNwLUA5Y5Yqi8y2s=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrABHrxi1ygtm5xGoAg--.42276S3;
	Tue, 02 Apr 2024 17:07:02 +0800 (CST)
Date: Tue, 2 Apr 2024 17:07:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, peter.chen@kernel.org,
	jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 09/11] arm64: dts: imx93-11x11-evk: enable usb and
 typec nodes
Message-ID: <ZgvKteCEZJxShA/j@dragon>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-9-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321081439.541799-9-xu.yang_2@nxp.com>
X-CM-TRANSID:C1UQrABHrxi1ygtm5xGoAg--.42276S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr17Jw4kuF4DGF1ktrW7XFb_yoWrAF4DpF
	ZxC395Xr4xXr13Aa98JF17GF93C3ZYgFy09rnFg343A39ruwsxJr45Kr1Ygr1qkFsrXw4a
	qFWv9rWIgwnFgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqlksUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDha0ZVszYdVKJwAAs4

On Thu, Mar 21, 2024 at 04:14:37PM +0800, Xu Yang wrote:
> There are 2 Type-C ports and 2 USB controllers on i.MX93. Enable them.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - remove status property in ptn5110 nodes
>  - fix dt-schema warnings
> Changes in v3:
>  - no changes
> Changes in v4:
>  - no changes
> Changes in v5:
>  - no changes
> Changes in v6:
>  - no changes
> Changes in v7:
>  - no changes
> Changes in v8:
>  - no changes
> Changes in v9:
>  - use compatible "nxp,ptn5110", "tcpci"
> Changes in v10:
>  - no changes
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 9921ea13ab48..ecc01d872e95 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/usb/pd.h>
>  #include "imx93.dtsi"
>  
>  / {
> @@ -104,6 +105,80 @@ &mu2 {
>  	status = "okay";
>  };
>  
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3>;

Do you really need "sleep" pinctrl state?

> +	status = "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x50>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +
> +		typec1_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;

Have a newline between properties and child node.

Shawn

> +					typec1_dr_sw: endpoint {
> +						remote-endpoint = <&usb1_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ptn5110_2: tcpc@51 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x51>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +
> +		typec2_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					typec2_dr_sw: endpoint {
> +						remote-endpoint = <&usb2_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &eqos {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_eqos>;
> @@ -156,6 +231,42 @@ &lpuart5 {
>  	status = "okay";
>  };
>  
> +&usbotg1 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb2_drd_sw: endpoint {
> +			remote-endpoint = <&typec2_dr_sw>;
> +		};
> +	};
> +};
> +
>  &usdhc1 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc1>;
> @@ -222,6 +333,13 @@ MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
>  		>;
>  	};
>  
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
> -- 
> 2.34.1
> 


