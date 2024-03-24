Return-Path: <linux-kernel+bounces-113666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F8888E62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475BC1C267FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6B1DE115;
	Sun, 24 Mar 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4TW+guR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018514386E;
	Sun, 24 Mar 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320622; cv=none; b=F1HEwgP2fAmErjoBmnRWmU1Cj1fJyNuPwIphoHE1mdmpaRhegQYqs1xk8dDVFtjYk+RfMYbjxqM0tiqOX8e0ktiKqRin/EYYaGVu1Mi0rvdeg70EyLLD6EqDgoRQJ4+90RzfAUL85RkH/SfJjqfpeeaMiHznydnxoS8cycaimVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320622; c=relaxed/simple;
	bh=GXTcAYX6lOI3PiRgWjbfvwwRmvviEhte5M/IeEcYe28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjtr0deVXls/qahD9ccZjyezrMpy0KtNi1ZRPUVmarzlXXpLZgriVNxZjO2vmx74vgv4LUHA4Yvff7HTOGXVDJP0Qt8EFjL90O8mfWKB0ZQXBHx5URw/Qr9E1mQAtPYlFMFcXZjtzWuYIrWInPg0fTzZ+mXISgkNDGwx6GlicJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4TW+guR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29897C433B2;
	Sun, 24 Mar 2024 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320620;
	bh=GXTcAYX6lOI3PiRgWjbfvwwRmvviEhte5M/IeEcYe28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4TW+guReooib1HNBT0F2JZxM2KZFpXEGvbLrodNOX0A7m+DYJlKrkReL7GxFxHZ7
	 cyuRtu+vd70Pjbn8gGYzWfnPzkP/s5Nz3JBQ3LFprPpDFUg0XR/bumIEPGuFWWasBg
	 tGV48VGrhck/oi4FWVUYWOB9D2HFckBs4UOr7aYZZpDwGXYnYH7gFjgo4l5pHLc+LN
	 aapQwU1UeWEVbQHTmIFZ3jqlUrTc4qWZL+Z9CVp0qG/WjtwI+t2WMTMIpQ3o/ASO+T
	 L+a/P4y5In/QufAfYhA5IAMm4AjWrGf868XFv2W33AlLUsRgJddBu2HoGjyU541LmU
	 bnjXuWxNxNZcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 182/713] arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numbers
Date: Sun, 24 Mar 2024 18:38:28 -0400
Message-ID: <20240324224720.1345309-183-sashal@kernel.org>
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

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 5136ea6b109de66b1327a3069f88ad8f5efb37b2 ]

It is eDMA1 at QM, which have the same register with eDMA3 at qxp.

The below commit fix panic problem.
commit b37e75bddc35 ("arm64: dts: imx8qm: Add imx8qm's own pm to avoid panic during startup")

This fixes the IRQ and DMA channel numbers. While QM eDMA1 technically has
32 channels, only 10 channels are likely used for I2C. The exact IRQ
numbers for the remaining channels were unclear in the reference manual.

Fixes: e4d7a330fb7a ("arm64: dts: imx8: add edma[0..3]")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 13a3531873401..459ba2b9b7f31 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -96,7 +96,20 @@ &edma2 {
 	status = "okay";
 };
 
+/* It is eDMA1 in 8QM RM, but 8QXP it is eDMA3 */
 &edma3 {
+	reg = <0x5a9f0000 0x210000>;
+	dma-channels = <10>;
+	interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
 	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
 			<&pd IMX_SC_R_DMA_1_CH1>,
 			<&pd IMX_SC_R_DMA_1_CH2>,
@@ -104,7 +117,9 @@ &edma3 {
 			<&pd IMX_SC_R_DMA_1_CH4>,
 			<&pd IMX_SC_R_DMA_1_CH5>,
 			<&pd IMX_SC_R_DMA_1_CH6>,
-			<&pd IMX_SC_R_DMA_1_CH7>;
+			<&pd IMX_SC_R_DMA_1_CH7>,
+			<&pd IMX_SC_R_DMA_1_CH8>,
+			<&pd IMX_SC_R_DMA_1_CH9>;
 };
 
 &flexcan1 {
-- 
2.43.0


