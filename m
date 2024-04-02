Return-Path: <linux-kernel+bounces-127571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D39E894DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69801F21BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040F4778E;
	Tue,  2 Apr 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S28paQVY"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D126292;
	Tue,  2 Apr 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047294; cv=none; b=PePCMtsJh4SQNgUGfDYUglAfYAjNFNRAjVndrwszU7s5+Sjj2Gq4mq2bdU07ETt1IiUqDE+BlEz2DUpz2Qn3ZrPokUJl8gJ4be04HuQsYBWMeOkZi5Q5QxX/MMlIHR3bVK6HybN0Fw6DefmpuYxA+YsGopICotjE9x03yr6xYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047294; c=relaxed/simple;
	bh=LrphTuKV4ZIvZiuC5JKV4IKb7oZU17EWpzajzeuN4Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTbNf1+6jgCTDlVz5i/FMdiA/OTn8S0I9LjxHPWnXK/bbDmqRZga2QeuFS5/ev1ixI7wQ/snKIFrDfM4r33wbppFmFlZNDrb87t5RupOrF1+kqUc5UXQ6ajcExLLdkDQ3Ha2niBtpBbkBWLWdyo1FoGr70cjP4hKB4Wjeu/UJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S28paQVY; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=cys5+eM5CZq+KFTK926auz0DzKUjBIgHsX+A5iFp8mU=;
	b=S28paQVYMO1kFONPu9j8xhJulwMH9qZO+h7WELsKbdDqH9Jm8rq+gPbnZHg7B3
	Upk2HT9VaaHTKwIvJ9OnNOzNqQFcAg79RF1+LWcFStfCp9xZrsWgUbI09gZIK2RH
	NTDjWFzSDTM7/ybMMl+qoH2El9douD+qeHJ6ZOvPgNIms=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAD3X3JdxAtmjb2iAQ--.9262S3;
	Tue, 02 Apr 2024 16:39:59 +0800 (CST)
Date: Tue, 2 Apr 2024 16:39:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, peter.chen@kernel.org,
	jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/11] arm64: dts: imx93: add usb nodes
Message-ID: <ZgvEXZTOHUv+GGeH@dragon>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-8-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321081439.541799-8-xu.yang_2@nxp.com>
X-CM-TRANSID:ClUQrAD3X3JdxAtmjb2iAQ--.9262S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw17Gr15WrW3ur4DCw4fGrg_yoW5Kr4Upa
	srCrZ3GrWIqr1I9FWaqFnYk3yrJas5Ga929F42q340ywn3Wa42q3WxKFnxWr48Xr4fZw4a
	yF45Xr18K3ZFyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2JP_UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFR+0ZV6NnBk55AAAsQ

On Thu, Mar 21, 2024 at 04:14:36PM +0800, Xu Yang wrote:
> There are 2 USB controllers on i.MX93. Add them.
> 
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa9352LA/CA
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - fix format as suggested by Alexander
>  - change compatible from fsl,imx8mm-usb to fsl,imx93-usb
> Changes in v3:
>  - replace deprecated fsl,usbphy with phys as suggested by Alexander
>  - reorder nodes
> Changes in v4:
>  - fix the alignment
> Changes in v5:
>  - rename usb_wakeup_clk to usb_wakeup
> Changes in v6:
>  - rename usb_ctrl_root_clk to usb_ctrl_root
> Changes in v7:
>  - no changes
> Changes in v8:
>  - no changes
> Changes in v9:
>  - no changes
> Changes in v10:
>  - no changes
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 58 ++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 8f2e7c42ad6e..4a7efccb4f67 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -183,6 +183,20 @@ mqs2: mqs2 {
>  		status = "disabled";
>  	};
>  
> +	usbphynop1: usbphynop1 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
> +		clock-names = "main_clk";
> +	};
> +
> +	usbphynop2: usbphynop2 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
> +		clock-names = "main_clk";
> +	};
> +
>  	soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -1167,6 +1181,50 @@ media_blk_ctrl: system-controller@4ac10000 {
>  			status = "disabled";
>  		};
>  
> +		usbotg1: usb@4c100000 {
> +			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
> +			reg = <0x4c100000 0x200>;
> +			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
> +				 <&clk IMX93_CLK_HSIO_32K_GATE>;
> +			clock-names = "usb_ctrl_root", "usb_wakeup";
> +			assigned-clocks = <&clk IMX93_CLK_HSIO>;
> +			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> +			assigned-clock-rates = <133000000>;
> +			phys = <&usbphynop1>;
> +			fsl,usbmisc = <&usbmisc1 0>;
> +			status = "disabled";
> +		};
> +
> +		usbmisc1: usbmisc@4c100200 {
> +			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
> +				     "fsl,imx6q-usbmisc";
> +			reg = <0x4c100200 0x200>;
> +			#index-cells = <1>;

Do we still need this '#index-cells' property?  I see it's being marked
as deprecated in bindings doc.

Shawn

> +		};
> +
> +		usbotg2: usb@4c200000 {
> +			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
> +			reg = <0x4c200000 0x200>;
> +			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
> +				 <&clk IMX93_CLK_HSIO_32K_GATE>;
> +			clock-names = "usb_ctrl_root", "usb_wakeup";
> +			assigned-clocks = <&clk IMX93_CLK_HSIO>;
> +			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> +			assigned-clock-rates = <133000000>;
> +			phys = <&usbphynop2>;
> +			fsl,usbmisc = <&usbmisc2 0>;
> +			status = "disabled";
> +		};
> +
> +		usbmisc2: usbmisc@4c200200 {
> +			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
> +				     "fsl,imx6q-usbmisc";
> +			reg = <0x4c200200 0x200>;
> +			#index-cells = <1>;
> +		};
> +
>  		ddr-pmu@4e300dc0 {
>  			compatible = "fsl,imx93-ddr-pmu";
>  			reg = <0x4e300dc0 0x200>;
> -- 
> 2.34.1
> 


