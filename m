Return-Path: <linux-kernel+bounces-147939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71F8A7B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C290C1C2193B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A855026C;
	Wed, 17 Apr 2024 04:57:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B45680
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329864; cv=none; b=Au/UzzBhe6WR9Zc4Zo32S1OjsRQI/A6qbO66fhLNfx6kVFmWD5Li2N8LHrDJKzpwIg/aFEGCWGPl6WkUelblvrmT/VsRxRVdjqQ+8QDKmhQlyOfhrDdcD33GHsYOT58SoFIDQXHT3ylbpg9jW42pBe79mwaLXOMbxMR5RmtkIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329864; c=relaxed/simple;
	bh=Gz7JeDyKCo7wyll/YSOuGCHs56+MF71ICnHL00/yOJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEmc1t9psOUmE1+ldChcjuaIeHOHLcllcjxYKDbQ84ug1jC07yX+jQsmEqneLSSiYMz6sZ8VI6OPrdUmLfTgT0vNp5gaMNjMhjMEws3oX4ifcfdlM4hxc7BanXgy2b/t9lFzYPzUR8hckNVRxIZYt8JURqAY66IBMGeWTBvNjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rwxMI-0005Id-1E; Wed, 17 Apr 2024 06:57:22 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rwxMG-00CjGo-Qe; Wed, 17 Apr 2024 06:57:20 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rwxMG-00HNee-2L;
	Wed, 17 Apr 2024 06:57:20 +0200
Date: Wed, 17 Apr 2024 06:57:20 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Joy Zou <joy.zou@nxp.com>
Cc: frank.li@nxp.com, ping.bai@nxp.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131
 support
Message-ID: <20240417045720.hk3y6m6roiqtuvfz@pengutronix.de>
References: <20240417031455.3177778-1-joy.zou@nxp.com>
 <20240417031455.3177778-2-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417031455.3177778-2-joy.zou@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Joy,

On 24-04-17, Joy Zou wrote:
> Support rtc PCF2131 on imx93-11x11-evk.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v4:
> 1. remove the sleep from the pinctrl-names.
> 
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
> index 07e85a30a25f..bc3c9271d747 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -281,6 +281,23 @@ ldo5: LDO5 {
>  	};
>  };
>  
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

while reading your patch I also noticed that you had to specify these
cells here. It is very common to specify it within the base dtsi file
imx93.dtsi. Can you please provde an extra patch which adds this to the
base dtsi followed by this patch, which of course do need to specify it
again.

Thanks you,
  Marco

> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3>;
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

