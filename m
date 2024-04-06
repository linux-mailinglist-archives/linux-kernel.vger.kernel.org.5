Return-Path: <linux-kernel+bounces-133836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D746289A98B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D9C1C21D3E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1771C697;
	Sat,  6 Apr 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea6S6N6K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656C2110F;
	Sat,  6 Apr 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387894; cv=none; b=PmaWRBAm5Rzcq1LIphWjxnpv4O6awHoHJAt1fItSqZ/xzkXytAB52FxJY3RHuCu7WLTKGk5tR4TW/fu6/qV5drvhJp24VE867kQjar9JNL4pCwlmyUHKUi1adqQGhtptJOXhgOA4KLHvT57Quw/Qc03NPxtdfwmcZ0ly08BNpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387894; c=relaxed/simple;
	bh=dS8bADZziQoLtHlnkHj0dQ2paJIGjWmIuNewalgbWUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxKlxYxHIrwIVL+Nwp4mC8soeo9AtoOcL/bi0MfnIJI5EVzSsQd9u8daatZw+xdzdYDiP7Ny7VnHDZoPsQN/Y9knOBLDGAfSBnp8N7Pp+TCPvJrSfGmQuZVLycZgsGKBV6/IB2EfCzF/qEAzGfyQyOH1dPK+lZfeP5V6QLgR2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea6S6N6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DA8C433C7;
	Sat,  6 Apr 2024 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712387893;
	bh=dS8bADZziQoLtHlnkHj0dQ2paJIGjWmIuNewalgbWUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ea6S6N6KseF8FYU91uMYJN7GD6yzmV7gab0MK5qCOM9EoxQmArIK+Qf4SmrVk7wWd
	 w4XXWVDPPOYHHZv3evO6BMbfX4VxnqR46iifX3EPm2YW1Dotyn0Z+UrRWpPLayVoIj
	 WKMckBsbZZVR2Azg9mLn9kc6wee9HAP7/p7lvdSggO5kzf8s8yplkVQXxU6qyMQclo
	 hSdF9W6liKlu+0CsLtUDcVuJqsrZxKyA6LHu7IsCpPTRaYEe8NzCHJhG7GB+S3w8Ye
	 ptA0UggHfPqrixdz4A5ghcTFtERIWFgc6L2T1QHsXRcikxX+L11f46KBcCk7g+So27
	 mCktSUaE1/xGQ==
Date: Sat, 6 Apr 2024 12:48:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	Yang Li <yang.lee@linux.alibaba.com>, imx@lists.linux.dev
Subject: Re: [PATCH v2] phy: freescale: imx8m-pcie: fix pcie link-up
 instability
Message-ID: <ZhD3MfXe8rhkQ_3l@matsya>
References: <20240327071946.8869-1-marcel@ziswiler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327071946.8869-1-marcel@ziswiler.com>

On 27-03-24, 08:19, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> On the i.MX 8M Mini, the AUX_PLL_REFCLK_SEL has to be left at its reset
> default of AUX_IN (PLL clock).
> 
> Background Information:
> In our automated testing setup, we use Delock Mini-PCIe SATA cards [1].
> While this setup has proven very stable overall we noticed upstream on
> the i.MX 8M Mini fails quite regularly (about 50/50) to bring up the
> PCIe link while with NXP's downstream BSP 5.15.71_2.2.2 it always works.
> As that old downstream stuff was quite different, I first also tried
> NXP's latest downstream BSP 6.1.55_2.2.0 which from a PCIe point of view
> is fairly vanilla, however, also there the PCIe link-up was not stable.
> Comparing and debugging I noticed that upstream explicitly configures
> the AUX_PLL_REFCLK_SEL to I_PLL_REFCLK_FROM_SYSPLL while working
> downstream [2] leaving it at reset defaults of AUX_IN (PLL clock).
> Unfortunately, the TRM does not mention any further details about this
> register (both for the i.MX 8M Mini as well as the Plus).
> NXP confirmed their validation codes for the i.MX8MM PCIe doesn't
> configure cmn_reg063 (offset: 0x18C).
> BTW: On the i.MX 8M Plus we have not seen any issues with PCIe with the
> exact same setup which is why I left it unchanged.

This does not apply on phy/fixes, pls rebase

-- 
~Vinod

