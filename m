Return-Path: <linux-kernel+bounces-113663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA488907A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D557FB2B031
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C21DD2A6;
	Sun, 24 Mar 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/0gPNnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1A1CF8D7;
	Sun, 24 Mar 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320617; cv=none; b=cfZl8UtiO7SB9dBOwgFFtSnzNXy2me7snS7JQjhQ9pO0L+avpU1U0klQooNd8wPwm/deTFKiNZ2Tfyf/z2+camPclmzgeC8j8efwx1buuV1C8JX4kr9Zn5LBmMtQ+0AjVH7h32fRv9GzzMidFtH/DNbYTUk7nrqHNe7sjXxGpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320617; c=relaxed/simple;
	bh=37Zel5azHMMPsuJmvBbKgkaQSVhGNE8yCrKdKwCBDRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDwHI/EPfzoZKKSzG3frr1beV/nQc0PDohF5wkDIPiYmxex9mKEjza4qEkmgOInrKHCF63wSpPx5PC0q8XZ0kL0ra3qK77aGReJTnMo+o4WtG506xq+BlGtzWGjLpr6dunoq51A2aIN7BDwCJyaxdIfZdPdAFmnF7ro3Ub1KQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/0gPNnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96DFC43394;
	Sun, 24 Mar 2024 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320616;
	bh=37Zel5azHMMPsuJmvBbKgkaQSVhGNE8yCrKdKwCBDRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/0gPNnNv1+pM6qwV+JRoHcZPKA0UiuqKP7P+rTYeEHUv3OILFlle9al2AK5tEnms
	 lBdTdaSmYUloGaN8Vy8f/9mLa9zY+H+8a9kxf8WwyC/prgKKbiXA3pwxYRK6x9KnOk
	 20EGBC8iEl7zAdYoOmBc3CEBILTd82X7R5sRPHPc8N1WrIDtFwJg6aosslfl/hDXx0
	 iXQl80OuaHY6IkhKHcBFSGs5Mh5skvFOF4J5JMr04GWFqatMDH3deHjULZLEF74yRc
	 r4J2DtmcWJnROlI5geQrMbjfjEUa0DLy2t3e1s+pnEd2pe4RygSRVq6j3QQgJhwTQL
	 Bj6xbVBlsiYAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 177/713] arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL board
Date: Sun, 24 Mar 2024 18:38:23 -0400
Message-ID: <20240324224720.1345309-178-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


