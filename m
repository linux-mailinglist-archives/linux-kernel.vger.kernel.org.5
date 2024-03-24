Return-Path: <linux-kernel+bounces-115368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33A8893BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8E5297780
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A151F10A1;
	Mon, 25 Mar 2024 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAq8PvwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C314386D;
	Sun, 24 Mar 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320621; cv=none; b=BMbnyYdPrw9OGX9IOrBNZ2+u5MG476lU7rWJL7F21e4QLfhw1ByjVVgVWY5zUCQB4wxdm/5/1iBtwdOSjy2GgOxdeql4AZ0OQ2fMAwCPay7s9x+0GkdfgaCBX1ZteZwrzLo3jPciLrejY9l8ideX8mmw7Zjbf2I38deNOIVoyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320621; c=relaxed/simple;
	bh=5wfng/s2DhfKcXbjgEZ62QFxd9CeNrVqaQKaNQoR5/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4QdN/hTW304Uxw74E/zbQ1eB//sHe9BUKE3WhOLKfyelUzxTQ8ZlHzIfqXZ4bbaqy8VZH5OerOakwqF+DWaPWFMy7lSwXax2xJXL3RIL2F/UoUWk1OQInlHdsK1j5Rb3VSLiUEJvd2G5VH29GNehto3aaH/ap60Ca9wGHJ2vH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAq8PvwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43601C43390;
	Sun, 24 Mar 2024 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320619;
	bh=5wfng/s2DhfKcXbjgEZ62QFxd9CeNrVqaQKaNQoR5/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAq8PvwY0GGXP/hnHqvGmEhfHFznaasG4B5/3jcA6uWjC/V9+z6YeEV8x93XzePe0
	 s10zu0TNfMNOozaGUoleBzymJ7nRbp9tLk19Qf6Xh5bqbwvffQoHpHGfClQxx3Asop
	 nNdN4DHoHqwviIGUBNbgj2kc2zzZFmx0Tqu1DGaWghgbH8Vg8lQ53HysDedealcQJo
	 Pv1CtsgdzV/hGMwA0UXCVzwJhGzR1K+f7f1ENl7EG6/rf60vzGT+2vgN0nVBfKMdc1
	 KYAhwyPFVQuo5ZMWdXQB+QBL4+Xy5zuaZdKXbYMtworndJucAMmuSS0tyvzPSpDC8V
	 oZFyjGa3CQqvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 181/713] arm64: dts: imx8qm: Align edma3 power-domains resources indentation
Date: Sun, 24 Mar 2024 18:38:27 -0400
Message-ID: <20240324224720.1345309-182-sashal@kernel.org>
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

[ Upstream commit 7edee2b297e5a4f805e5b945c0c0e6f4f8f719b5 ]

<&pd IMX_SC_R_DMA_1_CH*> is now properly aligned with the previous line
for improved code readability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 5136ea6b109d ("arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numbers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 8439dd6b39353..13a3531873401 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -98,13 +98,13 @@ &edma2 {
 
 &edma3 {
 	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
-		     <&pd IMX_SC_R_DMA_1_CH1>,
-		     <&pd IMX_SC_R_DMA_1_CH2>,
-		     <&pd IMX_SC_R_DMA_1_CH3>,
-		     <&pd IMX_SC_R_DMA_1_CH4>,
-		     <&pd IMX_SC_R_DMA_1_CH5>,
-		     <&pd IMX_SC_R_DMA_1_CH6>,
-		     <&pd IMX_SC_R_DMA_1_CH7>;
+			<&pd IMX_SC_R_DMA_1_CH1>,
+			<&pd IMX_SC_R_DMA_1_CH2>,
+			<&pd IMX_SC_R_DMA_1_CH3>,
+			<&pd IMX_SC_R_DMA_1_CH4>,
+			<&pd IMX_SC_R_DMA_1_CH5>,
+			<&pd IMX_SC_R_DMA_1_CH6>,
+			<&pd IMX_SC_R_DMA_1_CH7>;
 };
 
 &flexcan1 {
-- 
2.43.0


