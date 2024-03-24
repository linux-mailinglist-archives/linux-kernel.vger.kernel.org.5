Return-Path: <linux-kernel+bounces-114124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6709E888F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991ED1C2B877
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853361607A8;
	Sun, 24 Mar 2024 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHnSEQtX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DBC13248B;
	Sun, 24 Mar 2024 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321435; cv=none; b=GTmwGHU4nODldoX5GGb9uL8QM5FGcUe8cS23bAWXm5aa1iL5KdLa1Wkd6PLlbKR6JHH0qeTkkzQa06rT63PcaTOK1WqhJrijF6UJibi6ORzRcJnnq7Yi8OtNYzYWN3oFtfyoX7Th9wArmntg+PjcQjk9lhsSjcajHeL2si69Sx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321435; c=relaxed/simple;
	bh=2diJNys690X5vuo8K0Z2rkLA90NikcwwPE7MwS9PceI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCsmFYN+x8mvPfBY2vjPCsLjL8qYfZ/JYXegEU+Aw5xZ2qaTiLaMMBoF2aviML3Yht9FOG5O2rcBmGIFmx8jySRJ/s/tQQ5cvpU4jmQAUCPmDz91zdjaEGRxk78dkPalc2rHH+78MdpHf7S8WbM+j0S7mN9X0z+z0Wtitk47LiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHnSEQtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2F0C43394;
	Sun, 24 Mar 2024 23:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321434;
	bh=2diJNys690X5vuo8K0Z2rkLA90NikcwwPE7MwS9PceI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHnSEQtXFcutg+muB6UYim6PlKL61sdGCj8R2WsXKSx/EpDAetzKD650ecZRbwV+W
	 vXNcQMb/gCplhKGLG+h6iT8gB++irJ1OQZAl5TGPcNBf808Mv2Wqvs6YxceIjvfQTo
	 /n5zMb9mdJ0qLl86vzF8SqthefxLlwNkaONFrYDrY8eO6wsz/EJC/j24I23B2UrQoN
	 g6CFZaTRkcuH7YaYfImf/RINGgEPoPDGafnApoJkCoCrbCGhqjqXhEfeibqltJCr2Y
	 +2iBjePlk7CjxARV/SVUAWQn4vATmGC3cbt9dJ0xR1WV88DI0PPAJMFIG17GE/GdHH
	 427gebtaCTPiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 158/638] arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL OSM-S board
Date: Sun, 24 Mar 2024 18:53:15 -0400
Message-ID: <20240324230116.1348576-159-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit c6d9b5672a0e2c4b1079a50d2fc8780c40cfd3eb ]

These signals are actively driven by the SoC or by the onboard
transceiver. There's no need to enable the internal pull resistors
and due to silicon errata ERR050080 let's disable the internal ones
to prevent any unwanted behavior in case they wear out.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 0730c22e5b6b9..1dd03ef0a7835 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -313,19 +313,19 @@ MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x0
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0
 		>;
 	};
 
-- 
2.43.0


