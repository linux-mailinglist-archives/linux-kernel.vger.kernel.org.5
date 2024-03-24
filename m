Return-Path: <linux-kernel+bounces-113004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516858880B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E131F25F35
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AA130AE0;
	Sun, 24 Mar 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgeOh++F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C368130AC8;
	Sun, 24 Mar 2024 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319815; cv=none; b=pjJS9CFRWz62PozR/Yw9VCBjNnliG59dGkRPtBBrYXBv2xutA6QcpoIMPu5/5YmVlqt8BZD5JJuiRbxM8x3u+RTz2lbNJfZA8uGZ8AvOw+pTcCGJsQXv6dzNwiApr6sg4MoBMtvY4yL+EAwJTXMjvUAMwa6+Br68QJXYwQUe3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319815; c=relaxed/simple;
	bh=EIbMxu/q2XMUhSWQMGGLvMeG00Row+WgL4DEBSSi048=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHWHO/x5cVJaYW/zaPr/BZLE/vNbS2/Nf2COQx+QAunk1ER3h169XdppqcEFnsY5GjnErxD9lKQnajGqK8jlg/s7PMWOThGqwGJgywzSU1+I4QbAEjtvfMeTJtFgaW2JRACZvulmB6cDkKER/WV1Hha8F+xvXCN5OKLO4hcx1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgeOh++F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8976BC43394;
	Sun, 24 Mar 2024 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319815;
	bh=EIbMxu/q2XMUhSWQMGGLvMeG00Row+WgL4DEBSSi048=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgeOh++FyCRiksr6g9S8uA536oLYmqFEycD4A6nP7YtKUVa7AEfZ318HUIMkz6GQ/
	 kQtbkCpDTOJseoe8rQhEkNAL81X2mfC5zzo7UnpdukK7j49A9AcTga9+ZMOBS8yAH/
	 Ti0l7mtXaiBkLywDbAIBs3jTgJqABs4CqG5a6DVMpKlnXzEL4i1tGO4zlbdMoTAUPj
	 s9ooSBpSKn4Vbrthh1F86ou3cMO53Gw+EFKKgqy+otvCiNh+MCNA7okQ+g9zqFG5GG
	 rUGQmW5bFJtIJLM7OZVugQVmX3m7FEbWkqNlLXTT6vpXZw2jvO7Xwn7W9xelRlMzTX
	 np/iwIb6KNWEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 117/715] arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numbers
Date: Sun, 24 Mar 2024 18:24:56 -0400
Message-ID: <20240324223455.1342824-118-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 453fabfd17b81..cafc1383115ab 100644
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


