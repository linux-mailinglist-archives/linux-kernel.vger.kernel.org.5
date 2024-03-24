Return-Path: <linux-kernel+bounces-114199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F288890E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387931F2D3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AA24E3A2;
	Sun, 24 Mar 2024 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7JyKRLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8ED137900;
	Sun, 24 Mar 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321534; cv=none; b=IhScYPa5t8uQo/2epinzW1Z7R6zJV6dVRm52GKUH0CDe5qorllXDuu6uFUJE7NVg2CkVPyA95jOFiz7eYCAguInWPBCILqLdiFK3LmBdAj4qt4f4GblqOz5Zl8hqZDVlBQsejuBXXfM1O6uom1L4WJIAZVIwRCjHX7MQbuhF2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321534; c=relaxed/simple;
	bh=iBV/5/Z+cGNqIANUq+vBJr418QFN4hXW/Rfok5Qg3Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMlNMO/t/kPPJ8sTohy9m5rglRPeTOnIStlluZeHN+YZLINl7HC781hNC3ey8y9dBO4sSXLicyJkkFDM93MLaO+NGzPzjcFIbcSTNmghh7IBX3E50ZJdfBtEgFhK7fd87zfb4ibAKEgThXU3jprRBsEmG3pa6jYSP3f5ezMouwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7JyKRLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4F7C43399;
	Sun, 24 Mar 2024 23:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321533;
	bh=iBV/5/Z+cGNqIANUq+vBJr418QFN4hXW/Rfok5Qg3Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7JyKRLP8FTIHcClqyzw4A/IyFR6tNq63sa4elPZlg3LpbbM/MmbTLlv8Vi+8AU6c
	 AqGtQw6iFElowght9IcAvOMZb8Zhzv98yKiFpKqW2/O9Q3U41Em3/DEAZZ4k62kwEi
	 VfHOqcXw1M8pRtV1674NC7B5GbBrUW23sRCI9MiefmRU5dh7COdd9LOkNgeHn9GPR4
	 kbqgZizzpR7X/tvjbO2Rcz/4k7oNwcSgmmZawDLszv9yyudvNRvF4J7YhEgA8+CFmQ
	 gDx8S3HRF7n4t0F8d2uY/l0cupXibt050kDny3vW8CNpcP1HEQ5yz1URb6J1AkZ5RN
	 r6osQU3qOgWzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 260/638] arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
Date: Sun, 24 Mar 2024 18:54:57 -0400
Message-ID: <20240324230116.1348576-261-sashal@kernel.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 14fe225dd5fcd5928583b0bcc34398a581f51602 ]

The IRQC IP block supports Bus error and ECCRAM interrupts on RZ/G2L and
alike SoC's (listed below).  Update the IRQC nodes with the missing
interrupts, and additionally, include the 'interrupt-names' properties
in the IRQC nodes so that the driver can parse interrupts by name.

  - R9A07G043U              - RZ/G2UL
  - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
  - R9A07G054               - RZ/V2L

Fixes: 5edc51af5b30 ("arm64: dts: renesas: r9a07g044: Add IRQC node")
Fixes: 48ab6eddd8bb ("arm64: dts: renesas: r9a07g043u: Add IRQC node")
Fixes: 379478ab09e0 ("arm64: dts: renesas: r9a07g054: Add IRQC node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240205144421.51195-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 12 +++++++++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 22 ++++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 22 ++++++++++++++++++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 2ab231572d95f..b3f83d0ebcbb5 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -109,7 +109,13 @@ irqc: interrupt-controller@110a0000 {
 			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
-			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
+			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(35) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(36) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(37) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(38) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(39) IRQ_TYPE_EDGE_RISING>;
 		interrupt-names = "nmi",
 				  "irq0", "irq1", "irq2", "irq3",
 				  "irq4", "irq5", "irq6", "irq7",
@@ -121,7 +127,9 @@ irqc: interrupt-controller@110a0000 {
 				  "tint20", "tint21", "tint22", "tint23",
 				  "tint24", "tint25", "tint26", "tint27",
 				  "tint28", "tint29", "tint30", "tint31",
-				  "bus-err";
+				  "bus-err", "ec7tie1-0", "ec7tie2-0",
+				  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+				  "ec7tiovf-1";
 		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
 			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
 		clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 66f68fc2b2411..081d8f49db879 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -905,7 +905,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
 			clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 1f1d481dc7830..0d327464d2baf 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -912,7 +912,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G054_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G054_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-- 
2.43.0


