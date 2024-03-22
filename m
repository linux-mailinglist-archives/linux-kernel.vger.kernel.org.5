Return-Path: <linux-kernel+bounces-111464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282F886CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1DE2824F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F545BF9;
	Fri, 22 Mar 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="dgyFZNZ4"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367B20DDB;
	Fri, 22 Mar 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113682; cv=none; b=c9cOWD7ALqsgQ91AmygMkqNUykkEwCEF8Xhl5PuclftakjmI3d8ve4Qrutf+Dvpuj98nlxnkYK9rDe9V5/Yx3hRB3wZsFwdQCETuuWWq4bfxY3t/nxlw22LHfUlZgyosk7HeR04StmKRF4sPVjBHEb7xRtR4vkkUH8Ul+TePApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113682; c=relaxed/simple;
	bh=vROTGMXAef2SCrNTcU9M/lwkJYt9xS0mXDtrjGJpCow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcvvYl7rFeT9B2IrXRHcUiO3Wwh54OqEGAeMDfqXdFVv+KShIqN4FopZko+zPa5XUdsofFkEE44w9iSNRBx3Fb04l6rwixJWo30nuwBq1jFYX4F9BFS4TZV++A/jq2QG7hKtc++77XUo1CgAys73V8hJsm03bwRWp/ThmPa0Itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com; spf=pass smtp.mailfrom=ziswiler.com; dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b=dgyFZNZ4; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
	s=s1-ionos; t=1711113677; x=1711718477; i=marcel@ziswiler.com;
	bh=eDcvJPYLU8aoGBtgte1WWvaJ3vzttS1IgG9REDM5l68=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=dgyFZNZ4ryfrE1O+EcYZrdjgJyogGivPvtzHxhlKjmnOZRKsaYjyBsxF4AgJ0n+9
	 AB2kdCHvaMQpeKvbK8ld+lflllzh0ZDH5e1MwsIIFoN0DVlIY8b9vVgtHsd6bIsN6
	 afSYxMomUaqx8hm8PgRZBDOLbqVfO+CiRzZiFCq2sWcYfZWH0X8VJieMUpiBzeGRU
	 W2ZcAVY281jzuR13mKPsxUr0vukfVJm+MFlasjGHMbuH7CkhyCnwXhmZeqN3TBWRh
	 z6zDokH51NKOwemFVBb6FhMBgfMe6vxJbBIObP6vYveyUJ/LbvgIarku1kbR8GBmi
	 oNAelR14klB9W5C4Fw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([84.227.227.254]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lpu1h-1r97C30djL-00flO6;
 Fri, 22 Mar 2024 14:07:04 +0100
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-phy@lists.infradead.org
Cc: linux-imx@nxp.com,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>,
	linux-kernel@vger.kernel.org,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Vinod Koul <vkoul@kernel.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	imx@lists.linux.dev
Subject: [PATCH v1 1/1] phy: freescale: imx8m-pcie: fix pcie link-up instability
Date: Fri, 22 Mar 2024 14:06:32 +0100
Message-ID: <20240322130646.1016630-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322130646.1016630-1-marcel@ziswiler.com>
References: <20240322130646.1016630-1-marcel@ziswiler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hSP/Rc8v7m9d5HZM7O8bF6SvRxTvUu72KJswzi+HlbsLFXLs2bK
 eLpJzjfRHpiST6zEqcYF962ELDUUJBDUV3nm0y8mVIdvj6RWC9q7cGGmNmvOtuFB+lJzW1x
 OdiQ7GnUNfjeWY6i7hd1m6fNwsTppZGQvSv9kifwA7IU0xfr8+xSBbQOKQrDD32PmM9wphB
 RyQOYxk9uZRALvsWq78Mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:17SVORTKpos=;U0W2lvFRNhalJipd/FHK44+bm91
 nH7hgqwKWexGipjK8gJQFFtTTENgCjjuTQrS2vITn67mshry5Inou/J8t2uEq79nZkEH5liky
 wSB4nEQegZRK3gVd/LNHf7qCS8Zl9CGPMtEedPjAYMe4jUS6DPm2Sf75mwWdex78WdERo3ZPt
 taj7vcLTvzMB9LzVLH/FkJOWT7n9wZ8Qk+T/VCw1c17BFNZIiM3tedJwyLB8F0SInjXcPn8oD
 whVOSmAU5m7QFWxdHjwMRF1BNQxb0Sderux4x8xmJ1SIIPZjbeuNCPfgAVH4wujqO3mr7ZWw5
 iDp8x9y2CS3LhH+4zqf9bdIuSVsQCFMvk8JaFeWursO8XyK76ojs9kZ2N/DDGmOfnwbtFhxqC
 IVTo9e2mqoWmODuGNcn3F5UG5XqCOvGCPY9JwjJohJUHJ8XeHB/mBk9Yqxv/zJC5MlFAoofar
 8giprW83E3+Ny9fHRXD2D62vg98pQA6dgA2FwC8MZAbTgFKomlKL+ywOjAtd2mmddWKNmORaV
 sUDKMENTwceOX/gTzls3obb4JoChJTm/SgE+o3FZfaImR0IT8bbZmn11qRibyTA5cd4WsdNEE
 dD6zb/uJ8pcHCc4tswALZXN+infmJJsIsw1sFQ0XWh0kDa26SWa4N1oZOi4igwWK8uYIFRyV7
 Cs4NoFLrU3c2/nOVcXwAUMnJKm9c1OohbyVXe2efxXOUGQW5JFhEvGUGRjZ46XhR/hHviBfS9
 qlohkhuyKBsrD4dh4l2YTVgNcJYKEjl7YFBjT0qPLcErNcbKnDsFIQ=

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Leaving AUX_PLL_REFCLK_SEL at its reset default of AUX_IN (PLL clock)
proves to be more stable on the i.MX 8M Mini.

Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie stand=
alone phy driver")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
=2D--

 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/free=
scale/phy-fsl-imx8m-pcie.c
index b700f52b7b67..11fcb1867118 100644
=2D-- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -110,8 +110,10 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 		/* Source clock from SoC internal PLL */
 		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
 		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
-		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
-		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
+		if (imx8_phy->drvdata->variant !=3D IMX8MM) {
+			writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
+			       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
+		}
 		val =3D ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
 		writel(val | ANA_AUX_RX_TERM_GND_EN,
 		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
=2D-
2.44.0


