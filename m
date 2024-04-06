Return-Path: <linux-kernel+bounces-133864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24789AA13
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3901B22A8D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40372C6B7;
	Sat,  6 Apr 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPLRPBoU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E858B2C6AE;
	Sat,  6 Apr 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395131; cv=none; b=ZUEcMwVsTqBR8Ku+XoE02/RLxyYVQLpwubpgVODuPgOd5nPRtLNlnYr1CQgdTAOzgZi00hsaCZl5iIEMMPiVbmT2Q893L823cnTRCWAu8PSQxq45ilMAYvShVnN9UM2wCwWqCxvX79XQrZP3IYcvGskouZOvDfEtsp2sMzF3Z2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395131; c=relaxed/simple;
	bh=OUXrlxpdyrcqJqLEifsJYtil4okGD8qGZToyOExWkJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EuP0Hp4Dg1xln8OjiTv80xOI/HqUsYhyHvNyQ3r2WuhDM2u44rVtMxyPCKRiEn2TNPgZjW960Dni5KYOFYvknGLNgzrvGD+umpXCKVSA4Nk+uGqLZ/rtpnxWbKPQ6mfhcFkMRAvP3URmkUJ5hkkhrXv+Rhy6lVpi7cDA23G4c3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPLRPBoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2D1C433C7;
	Sat,  6 Apr 2024 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395130;
	bh=OUXrlxpdyrcqJqLEifsJYtil4okGD8qGZToyOExWkJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IPLRPBoUJTIz64lSs0ulj5jKGWUCP3opeZWNl1GU18wdX6jdXieYh4EYwUZhqDr+4
	 xEiGH4QXOS5BqiNuo0eQK76RJbaGs2l+X3jIESEOUvA94MhhygBaZ4cy2UV3bqMVHs
	 65VtuyFD2txH7ZDT5rPRACeIraIQmEn8XFTyxKXlDvA3Nu7d/EFn793Nr5RK60AjIw
	 BCUqzKJOJBmRV+IyK39P0JPbw92FVfa5QlKj9YkJH38Z+M3HZynMP9SL1+BQxEPNCY
	 dTwv2hGhmmDC1d5/ULOVqE0nmaFbsq9WrHZhdzmuvFZS1kMtXzyqJ43qNpoLr3Qr85
	 y7eoSicBuEBTA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-imx@nxp.com, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Yang Li <yang.lee@linux.alibaba.com>, imx@lists.linux.dev
In-Reply-To: <20240327071946.8869-1-marcel@ziswiler.com>
References: <20240327071946.8869-1-marcel@ziswiler.com>
Subject: Re: [PATCH v2] phy: freescale: imx8m-pcie: fix pcie link-up
 instability
Message-Id: <171239512402.352254.17030670986383011631.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:48:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 27 Mar 2024 08:19:37 +0100, Marcel Ziswiler wrote:
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
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: imx8m-pcie: fix pcie link-up instability
      commit: 3a161017f1de55cc48be81f6156004c151f32677

Best regards,
-- 
~Vinod



