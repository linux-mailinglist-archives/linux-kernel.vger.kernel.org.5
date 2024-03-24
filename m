Return-Path: <linux-kernel+bounces-114128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3E888892
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BAA1F278B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6D23FE81;
	Sun, 24 Mar 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIaAwB+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2E202B88;
	Sun, 24 Mar 2024 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321436; cv=none; b=ffy8veYIJ1y2p6RbkvPiQxBXpcwKtwnXhn/S8wjFlYX7uhkBbgPCwVk6jjNtFIwN45ROl3C3f2p1hunCEXlOBwmdV7c/2jcH5cEJ2YaHtilYZXNEdSNhJsmuH/BlaL9KaACIFBIrgzHlI4Pjm3ULLZ1MzhjHBuFqJg/lVtP3OW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321436; c=relaxed/simple;
	bh=37Zel5azHMMPsuJmvBbKgkaQSVhGNE8yCrKdKwCBDRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS3bcrETTfZyCr5tSdkm7NaZIMaTqvB3W75oGGdfEtuV+glH21yGJ7wz+MiBrRbtxSVfJEdvqh+80/PmPZJKgpqWu9e+33/R1uOq8Ut/RaASIKSvv8L8wfkEVKzEc/fX5COqTA20aaAZHVLZaIO0w9BZ31sILz35xq0p/Nw9HAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIaAwB+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA973C43399;
	Sun, 24 Mar 2024 23:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321435;
	bh=37Zel5azHMMPsuJmvBbKgkaQSVhGNE8yCrKdKwCBDRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIaAwB+4rz5EyUxmgxfpQuOml4axqccPgrGt4qT6VUmfmH3HjFlvTHO8RI2xpuIGR
	 bdpSPnEop8DU9NMum1jzKt0GZymqdC+rVKdbrdHtm9xHmorNRaAGMLQEqfNdcGHt5B
	 jCakCrsCvIeBCEcBDrMxc+H9Bc+yMiEJtbfP/iPAp/C7sLVw1xzPvLU0T4dr/MJeFV
	 65bmhyCJVSD5OG5dbcoi+8oIhq8vwqtN/gzD8KZMiTGDMhxhg45HtSpYgMpOSlTfb0
	 ZD1kd+vmfHG3AChBnWr+w6QrlRK+Epk9JWBNmbdcBuoMpkJCUUZ4PgNSLKXnZn845G
	 DquLsVZg5NVIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 159/638] arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL board
Date: Sun, 24 Mar 2024 18:53:16 -0400
Message-ID: <20240324230116.1348576-160-sashal@kernel.org>
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

[ Upstream commit 162aadaa0df8217b0cc49d919dd00022fef65e78 ]

These signals are actively driven by the SoC or by the onboard
transceiver. There's no need to enable the internal pull resistors
and due to silicon errata ERR050080 let's disable the internal ones
to prevent any unwanted behavior in case they wear out.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/freescale/imx8mm-kontron-bl.dts     | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index 5fd2e45258b11..ee93db11c0d06 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -292,19 +292,19 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
 
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


