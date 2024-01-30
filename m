Return-Path: <linux-kernel+bounces-44516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10638842323
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC33A28B4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB666B5C;
	Tue, 30 Jan 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X1dbL0lf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01B679E2;
	Tue, 30 Jan 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614360; cv=none; b=YaH4q433VVIZE87JDDHncNSJQXMa3vLNpvFDTqe5pVb5oK2lgpvCILFWgnYfkIYDVbx76Edy0pXq4SFRHBuVKld/m4AhX9KCWFBs4kqOWhTwpvIQKK0guAXjYtG14BkSfHx7Xv6j6PYr5zwR+zxdBkDR5MpXuj5QzbrMgkpCC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614360; c=relaxed/simple;
	bh=2c3rpex/zB7h9HCUvPXodVCfRpwJO79GoYARME11Ky4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVxKxGLp7Bnd9f5buX/gP+7hEnjQuDImiMmMFSFxjX8HETod9g7I8tSVyUsUWfGqiS65vJPy4hY6sn6VHiPlePNVUQxTDBu70ByASYlQtP1C2LMN6IZ+wV7P3q9q8TXEBvEfgiKO0AoiCvd+1UjrQkzKUwXQ3Ch3fh7hjL+4/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X1dbL0lf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706614356;
	bh=2c3rpex/zB7h9HCUvPXodVCfRpwJO79GoYARME11Ky4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X1dbL0lfhVBFj5E3codYazedPAoZt6ugh1Fn+4vvwvbS0pshsJqJ5iNwwdRgtbSAT
	 5dmiU0PHaC7iWzj5QxEvtXREZqtWp98qGlmelg6j6avZp1II5JD/2cSfpiPfQqHqVf
	 im45pdGPRgRPAIPtA2nShOw9B+/ZcVYPop8LrV/ov+Y0FfdvPWbvlp/kWesA0Jh2GJ
	 oqa1rmIgWj2aZ127tyLy/AJqFf/3Oi5W2+KTZIIQYK5KV8El1A2BEE25t7eC3b8f45
	 ZL2AvHUzg+Hc1O5oBXH3ajqAqcV8Nqm6r6jNPRT/QD3LMsfjuGHQb4S3fBOivluyTD
	 YHNo/lpKGbLPQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E47E43782081;
	Tue, 30 Jan 2024 11:32:35 +0000 (UTC)
Message-ID: <a79fa347-f42d-49a3-9faf-40fbefb69998@collabora.com>
Date: Tue, 30 Jan 2024 12:32:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add MTU3 nodes and
 correctly describe USB
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wenst@chromium.org,
 kernel@collabora.com, matthias.bgg@gmail.com
References: <20240115084336.938426-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240115084336.938426-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/01/24 09:43, AngeloGioacchino Del Regno ha scritto:
> The MT8195 SoC has four USB controllers: only one is a direct path to
> a XHCI controller, while the other three (0, 2 and 3) are behind the
> MTU3 DRD controller instead!
> 
> Add the missing MTU3 nodes, default disabled, for controllers 0, 2 and
> 3 and move the related XHCI nodes to be children of their MTU3 DRD to
> correctly describe the SoC.
> 
> In order to retain USB functionality on all of the MT8195 and MT8395
> boards, also move the vusb33 supply and enable the relevant MTU3 nodes
> with special attention to the MT8195 Cherry Chromebook, where it was
> necessary to set the dr_mode of all MTU3 controllers to host to avoid
> interfering with the EC performing DRD on its own.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hello Chen-Yu,

even though I've carefully tested that on my MT8195 Chromebook, can you please
check this one?

Four eyes are better than two. :-)

P.S.: Sorry, I forgot to Cc you in the first submission....

Thanks,
Angelo

> ---
> 
> Depends on [1]
> 
> This patch was tested on a MT8395 board and on the MT8195 Cherry
> Tomato Chromebook.
> 
> [1]: https://lore.kernel.org/all/20240112133222.240038-1-angelogioacchino.delregno@collabora.com
> 
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |  26 +++-
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts  |  18 ++-
>   arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  12 ++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 125 +++++++++++-------
>   .../dts/mediatek/mt8395-genio-1200-evk.dts    |  17 ++-
>   5 files changed, 140 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index a136bea99d9c..e563a2dc4cce 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -1293,11 +1293,32 @@ &uart0 {
>   	status = "okay";
>   };
>   
> +/*
> + * For the USB Type-C ports the role and alternate modes switching is
> + * done by the EC so we set dr_mode to host to avoid interfering.
> + */
> +&ssusb0 {
> +	dr_mode = "host";
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&ssusb2 {
> +	dr_mode = "host";
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&ssusb3 {
> +	dr_mode = "host";
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
>   &xhci0 {
>   	status = "okay";
>   
>   	rx-fifo-depth = <3072>;
> -	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	vbus-supply = <&usb_vbus>;
>   };
>   
> @@ -1311,8 +1332,6 @@ &xhci1 {
>   
>   &xhci2 {
>   	status = "okay";
> -
> -	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	vbus-supply = <&usb_vbus>;
>   };
>   
> @@ -1321,7 +1340,6 @@ &xhci3 {
>   
>   	/* MT7921's USB Bluetooth has issues with USB2 LPM */
>   	usb2-lpm-disable;
> -	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	vbus-supply = <&usb_vbus>;
>   };
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> index 69c7f3954ae5..9872743f743f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> @@ -528,8 +528,22 @@ &u3phy3 {
>   	status = "okay";
>   };
>   
> -&xhci0 {
> +&ssusb0 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&ssusb2 {
>   	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&ssusb3 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&xhci0 {
>   	vbus-supply = <&otg_vbus_regulator>;
>   	status = "okay";
>   };
> @@ -540,11 +554,9 @@ &xhci1 {
>   };
>   
>   &xhci2 {
> -	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	status = "okay";
>   };
>   
>   &xhci3 {
> -	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> index 690dc7717f2c..341b6e074139 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> @@ -160,6 +160,18 @@ &uart0 {
>   	status = "okay";
>   };
>   
> +&ssusb0 {
> +	status = "okay";
> +};
> +
> +&ssusb2 {
> +	status = "okay";
> +};
> +
> +&ssusb3 {
> +	status = "okay";
> +};
> +
>   &xhci0 {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 152cc0b191bb..45f278efd946 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1349,29 +1349,40 @@ queue3 {
>   			};
>   		};
>   
> -		xhci0: usb@11200000 {
> -			compatible = "mediatek,mt8195-xhci",
> -				     "mediatek,mtk-xhci";
> -			reg = <0 0x11200000 0 0x1000>,
> -			      <0 0x11203e00 0 0x0100>;
> +		ssusb0: usb@11201000 {
> +			compatible = "mediatek,mt8195-mtu3", "mediatek,mtu3";
> +			reg = <0 0x11201000 0 0x2dff>, <0 0x11203e00 0 0x0100>;
>   			reg-names = "mac", "ippc";
> -			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
> -			phys = <&u2port0 PHY_TYPE_USB2>,
> -			       <&u3port0 PHY_TYPE_USB3>;
> -			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
> -					  <&topckgen CLK_TOP_SSUSB_XHCI>;
> -			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> -						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			ranges = <0 0 0 0x11200000 0 0x3f00>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
>   			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
>   				 <&topckgen CLK_TOP_SSUSB_REF>,
> -				 <&apmixedsys CLK_APMIXED_USB1PLL>,
> -				 <&clk26m>,
>   				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
> -			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
> -				      "xhci_ck";
> -			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck";
> +			phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
>   			wakeup-source;
> +			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
>   			status = "disabled";
> +
> +			xhci0: usb@0 {
> +				compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
> +				reg = <0 0 0 0x1000>;
> +				reg-names = "mac";
> +				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
> +				assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
> +						  <&topckgen CLK_TOP_SSUSB_XHCI>;
> +				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +							 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +				clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
> +					 <&topckgen CLK_TOP_SSUSB_REF>,
> +					 <&apmixedsys CLK_APMIXED_USB1PLL>,
> +					 <&clk26m>,
> +					 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
> +				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
> +				status = "disabled";
> +			};
>   		};
>   
>   		mmc0: mmc@11230000 {
> @@ -1452,52 +1463,68 @@ xhci1: usb@11290000 {
>   			status = "disabled";
>   		};
>   
> -		xhci2: usb@112a0000 {
> -			compatible = "mediatek,mt8195-xhci",
> -				     "mediatek,mtk-xhci";
> -			reg = <0 0x112a0000 0 0x1000>,
> -			      <0 0x112a3e00 0 0x0100>;
> +		ssusb2: usb@112a1000 {
> +			compatible = "mediatek,mt8195-mtu3", "mediatek,mtu3";
> +			reg = <0 0x112a1000 0 0x2dff>, <0 0x112a3e00 0 0x0100>;
>   			reg-names = "mac", "ippc";
> -			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
> -			phys = <&u2port2 PHY_TYPE_USB2>;
> -			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_2P>,
> -					  <&topckgen CLK_TOP_SSUSB_XHCI_2P>;
> -			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> -						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			ranges = <0 0 0 0x112a0000 0 0x3f00>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_2P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
>   			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
>   				 <&topckgen CLK_TOP_SSUSB_P2_REF>,
> -				 <&clk26m>,
> -				 <&clk26m>,
>   				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
> -			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
> -				      "xhci_ck";
> -			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck";
> +			phys = <&u2port2 PHY_TYPE_USB2>;
>   			wakeup-source;
> +			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
>   			status = "disabled";
> +
> +			xhci2: usb@0 {
> +				compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
> +				reg = <0 0 0 0x1000>;
> +				reg-names = "mac";
> +				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
> +				assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_2P>;
> +				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +				clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
> +				clock-names = "sys_ck";
> +				status = "disabled";
> +			};
>   		};
>   
> -		xhci3: usb@112b0000 {
> -			compatible = "mediatek,mt8195-xhci",
> -				     "mediatek,mtk-xhci";
> -			reg = <0 0x112b0000 0 0x1000>,
> -			      <0 0x112b3e00 0 0x0100>;
> +		ssusb3: usb@112b1000 {
> +			compatible = "mediatek,mt8195-mtu3", "mediatek,mtu3";
> +			reg = <0 0x112b1000 0 0x2dff>, <0 0x112b3e00 0 0x0100>;
>   			reg-names = "mac", "ippc";
> -			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
> -			phys = <&u2port3 PHY_TYPE_USB2>;
> -			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
> -					  <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
> -			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> -						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			ranges = <0 0 0 0x112b0000 0 0x3f00>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
>   			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
>   				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
> -				 <&clk26m>,
> -				 <&clk26m>,
>   				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
> -			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
> -				      "xhci_ck";
> -			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck";
> +			phys = <&u2port3 PHY_TYPE_USB2>;
>   			wakeup-source;
> +			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
>   			status = "disabled";
> +
> +			xhci3: usb@0 {
> +				compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
> +				reg = <0 0 0 0x1000>;
> +				reg-names = "mac";
> +				interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
> +				assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
> +				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +				clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
> +				clock-names = "sys_ck";
> +				status = "disabled";
> +			};
>   		};
>   
>   		pcie0: pcie@112f0000 {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> index 7fc515a07c65..1558649f633c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -880,6 +880,21 @@ &ufsphy {
>   	status = "disabled";
>   };
>   
> +&ssusb0 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&ssusb2 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&ssusb3 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
>   &xhci0 {
>   	status = "okay";
>   };
> @@ -890,11 +905,9 @@ &xhci1 {
>   };
>   
>   &xhci2 {
> -	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	status = "okay";
>   };
>   
>   &xhci3 {
> -	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	status = "okay";
>   };



