Return-Path: <linux-kernel+bounces-133825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1674789A954
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F0F1F220FE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F1219EB;
	Sat,  6 Apr 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLOSuIio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB51803D;
	Sat,  6 Apr 2024 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712384916; cv=none; b=LZOsfP+kp+T2weAeHt9XTsCvpCz6WT6OMS8SrDU8suRjKynns6ZKCUecwZO90Bu0VD43/9ClAks8kHTCzi06tMhHiGW/gJVX7n3PJW2iOwr/aInHX7j38jwQF3uB3I5xHmvaMsuv5MOAwJQwGG9Za4db32OmoZ28cVDKCSKTP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712384916; c=relaxed/simple;
	bh=7/bYiwPy5DVoN65zNqAT7YHPjjFt5UCoXl4SUW2wvaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuzUONtr6VT0dPn0jPt9eJVp3moZUdQ2rIisd9f+1WeWWnSQQClOOMIW4WMosZDZS7Tx4j/1nRGBfWly8M+U04d12flnZj9UtKGKx7SC15iaNUG4tSRdrLq2sghRJLVBgmZ0I70wetLZhEpAgQIUsVbuI9IXG3dbekMv1zYEwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLOSuIio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B22BC433C7;
	Sat,  6 Apr 2024 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712384915;
	bh=7/bYiwPy5DVoN65zNqAT7YHPjjFt5UCoXl4SUW2wvaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLOSuIiosYM2nz9esvvTihiOhjk7oOlq2vR96fPttQj3cdcavXpNGAA4omLq//N1L
	 gNAziXwSF/do3XOsi7gWj0+XY6894daboMcv+5HiBDR7S/ZqNcFxbh05M/n+4I6yHe
	 0t2GI+yOrw1Uc8VBrR7JoCYgEqK4pFUhQsfdSw71rqaVCpk7nAjDlc7mOthe2cvhh2
	 Dnb47WUTjX2ECTj/DdmQ639d7csySmHHWTOLcIuYauwThtLNhvDlK4bQhYf/4GQ+Kh
	 JIry2zTzR+voLYowydTe9cwdaWbzSetLaGaU/Lbp7Yqf6JOjIe3ik3QThE6KU/lm6V
	 o5CxOvGDyHBhg==
Date: Sat, 6 Apr 2024 11:58:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>, linux-kernel@vger.kernel.org,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	Yang Li <yang.lee@linux.alibaba.com>, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/1] phy: freescale: imx8m-pcie: fix pcie link-up
 instability
Message-ID: <ZhDrjzNn5qxzXHiD@matsya>
References: <20240322130646.1016630-1-marcel@ziswiler.com>
 <20240322130646.1016630-2-marcel@ziswiler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322130646.1016630-2-marcel@ziswiler.com>

On 22-03-24, 14:06, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Leaving AUX_PLL_REFCLK_SEL at its reset default of AUX_IN (PLL clock)
> proves to be more stable on the i.MX 8M Mini.
> 
> Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> 

Please dont keep an empty line b/w Fixes and s-o-b line...

> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index b700f52b7b67..11fcb1867118 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -110,8 +110,10 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
>  		/* Source clock from SoC internal PLL */
>  		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
>  		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
> -		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
> -		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
> +		if (imx8_phy->drvdata->variant != IMX8MM) {
> +			writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
> +			       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
> +		}
>  		val = ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
>  		writel(val | ANA_AUX_RX_TERM_GND_EN,
>  		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
> --
> 2.44.0
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
~Vinod

