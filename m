Return-Path: <linux-kernel+bounces-133827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA4B89A957
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A60B284118
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C531210FB;
	Sat,  6 Apr 2024 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6NbXAd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91CFC19;
	Sat,  6 Apr 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712385027; cv=none; b=bMrWTOEAxoJHsTx5JNxFBzBEFh/0WgKw9EwGXI4YjQcAEI2Wbz2Ac2uzQAka+GaF+CmnCAdBIkJvrOX4kFArO+RfEVw82UdWKCanTitEgfeMmR+RIqtwuKFFhlr7VSHQ/wnCjc7QQcRIXS0bN7Trd/4lx4HLdD/nor3oQ5ne0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712385027; c=relaxed/simple;
	bh=qXd+uB2LXhHrOLHpe3rXD95we40I4nRn9suxums/L40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe9SVGaKMf5GmoUQ1IfXWx18aGjI7xifp7M3Q33VP+Q9NnlfEohyJw+NU4LvRFVOBrjS/rLmUw/plrLW1u/QR8BnxLh09URTPvnbd/oFvaCBY70WEgBzE6zgGDE2jJZ1qwI5Ehkm4spvO2bOxKQbiEqg0Bd07MX1CZp6EwASZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6NbXAd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A15FC433C7;
	Sat,  6 Apr 2024 06:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712385027;
	bh=qXd+uB2LXhHrOLHpe3rXD95we40I4nRn9suxums/L40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6NbXAd0eDSiyGzNC0SQnx76z2jb3UKAC2ex3djEdml5hlklPAIV27dudpoFbtrV3
	 JGiaBdGCXkA2286da4xuS7jQDCPpuNsrGw9JS0956hA56LTL9AIRaxib0WkPWYrsii
	 +05v+h55yn3LT1dA9FQxKyq4KstE/U/ZyIOg/E6FXeO6sCvBEvbhneW4C54yvBWi0U
	 zLql2asiuXjFPE1EvFxI0mzk0iKsNUITWmPXJVZigP0vGNKXM/QGcVxwqvhokLOQBX
	 o0SZq/aLpgRuA595ZY+NRmzpkBDstRzekxxIR2v00l/C8TB5JyKbr2p+MIkOiiO/cv
	 mT0HiVJTEKoYA==
Date: Sat, 6 Apr 2024 12:00:23 +0530
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
Message-ID: <ZhDr_yCBR_oAzD96@matsya>
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

This doesn't apply on phy/fixes

Please rebase

-- 
~Vinod

