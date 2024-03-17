Return-Path: <linux-kernel+bounces-105466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1287DE49
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D821C20FEF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418AB1CD03;
	Sun, 17 Mar 2024 16:22:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9B1C695
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692548; cv=none; b=nrOdlGWQ7JJGSRuhHzQgeX9T/Go5bos8Q2kusf3UnxF4dR5+EbXLp2frcaM58Tm8l25PbeXEOU/m3cA8PPR4U7AHabKzmGuqdgIKW5gLmoyjfEKiqrn1DD6arO2g9vpbQsGsz3uxikedAZzU874tChm6oalrvYTuJc3/v2wdOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692548; c=relaxed/simple;
	bh=X/phk1QlmzaJ/XY//OQoNTV/C4BNG3QtbNfn9CHQIuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQCQf1GtiUOVfUuALO0TK+eYb/dyFlKZULcdn3QewUCLETpkIHcXMBbh28Ypexe9So5SImbhsGfM9L1+0AutqW4IIWXkmu/dfBGVpjwxDEz+eJ3GnQJfeGZjo3DfiP3NwD7P8UEg7Z/Ydvu1bp7KCixAucF+z75qmRue8x3Oo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rltH6-0007ME-4X; Sun, 17 Mar 2024 17:22:16 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rltH4-006ulO-3e; Sun, 17 Mar 2024 17:22:14 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rltH4-00417Q-03;
	Sun, 17 Mar 2024 17:22:14 +0100
Date: Sun, 17 Mar 2024 17:22:14 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/1] ARM: dts: imx6ul: tqma6ul + mba6ulx: Fix pinctrl
 node names
Message-ID: <20240317162214.ssspjf2xfpid32k6@pengutronix.de>
References: <20240314150054.2957840-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314150054.2957840-1-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Alexander,

just a minor, please see below.

On 24-03-14, Alexander Stein wrote:
> imx6ul pinctrl nodes end with 'grp'. Fix node names.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi | 2 +-
>  arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi               | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
> index 57e647fc3237..f04c6f71f538 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
> @@ -202,7 +202,7 @@ MX6UL_PAD_UART2_RX_DATA__GPIO1_IO21	0x4001b8b0
>  		>;
>  	};
>  
> -	pinctrl_pmic: pmic {
> +	pinctrl_pmic: grp {
			^
			pmicgrp

Regards,
  Marco
 
>  		fsl,pins = <
>  			/* PMIC irq */
>  			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x1b099
> diff --git a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
> index e78d0a7d8cd2..5258ef81e6c7 100644
> --- a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
> @@ -505,7 +505,7 @@ MX6UL_PAD_CSI_HSYNC__UART6_DCE_CTS	0x1b0b1
>  		>;
>  	};
>  
> -	pinctrl_uart6dte: uart6dte {
> +	pinctrl_uart6dte: uart6dtegrp {
>  		fsl,pins = <
>  			MX6UL_PAD_CSI_PIXCLK__UART6_DTE_TX	0x1b0b1
>  			MX6UL_PAD_CSI_MCLK__UART6_DTE_RX	0x1b0b1
> @@ -537,7 +537,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
>  		>;
>  	};
>  
> -	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
>  		fsl,pins = <
>  			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
>  			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170b9
> @@ -552,7 +552,7 @@ MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0001b099
>  		>;
>  	};
>  
> -	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
>  		fsl,pins = <
>  			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x00017069
>  			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x000170f9
> -- 
> 2.34.1
> 
> 
> 

