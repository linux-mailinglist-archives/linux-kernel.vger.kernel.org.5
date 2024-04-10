Return-Path: <linux-kernel+bounces-138082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0D89EC59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA651F22809
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9C13D280;
	Wed, 10 Apr 2024 07:40:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2E8BE8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734837; cv=none; b=ayG1ngoBSXYNuOYFhes2OtUtGL02H/YIwKLaMSjif/txYk8QcQdUOzvNXn15/yyZROC0vsAvKpimh4H6ZTsiQhzQl2bwfTcvVY79VK8OIUfD34xxEIqEmA51n1Rh7hsBGDeXG1gyjSRmVNt+u9KK4NL7EzWj9V+2CcT2WLopYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734837; c=relaxed/simple;
	bh=I0BoT/9aVltasDJkw4V9sgksz5cDIjXWVXEUgPrZOk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9JjktTCGZg5LG5NZXIIYlWzZWntTNCUYyELr+lq2a5cT/mhUPonx0b5eTHhYAIlO4uaoQ4PXulUf71epC6XKhkEPW6+llMMHy9rRTeIxUwk4R4VMMS2gFrgdvxq4FkCcSq06+dzeb54gbxPaEg8KrP9d7NGTm4+JUFan9iCiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ruSZH-0000CY-EH; Wed, 10 Apr 2024 09:40:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1ruSZG-00BS1z-KX; Wed, 10 Apr 2024 09:40:26 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ruSZG-0060ua-1j;
	Wed, 10 Apr 2024 09:40:26 +0200
Date: Wed, 10 Apr 2024 09:40:26 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Joy Zou <joy.zou@nxp.com>
Cc: ping.bai@nxp.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-imx@nxp.com,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131
 support
Message-ID: <20240410074026.qjpk3sjhtbb6sw7j@pengutronix.de>
References: <20240410070128.1506555-1-joy.zou@nxp.com>
 <20240410070128.1506555-2-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410070128.1506555-2-joy.zou@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-04-10, Joy Zou wrote:
> Support rtc PCF2131 on imx93-11x11-evk.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v3:
> 1.adjust the indentation.
> 
> Changes in v2:
> 1. remove unnecessary status property.
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 07e85a30a25f..73e0bca36b81 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -281,6 +281,23 @@ ldo5: LDO5 {
>  	};
>  };
>  
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3>;

Are both "default" and "sleep" pinctrl's required? It doesn't make any
sense to provde a sleep state which uses the same pinctrl state.

Regards,
  Marco

> +	status = "okay";
> +
> +	pcf2131: rtc@53 {
> +		compatible = "nxp,pcf2131";
> +		reg = <0x53>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
>  &iomuxc {
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins = <
> @@ -343,6 +360,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
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
>  	pinctrl_pcal6524: pcal6524grp {
>  		fsl,pins = <
>  			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
> -- 
> 2.37.1
> 
> 
> 

