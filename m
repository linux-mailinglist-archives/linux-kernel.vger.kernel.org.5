Return-Path: <linux-kernel+bounces-115902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42177889893
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E337229D94A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3238817E;
	Mon, 25 Mar 2024 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otBwovbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A01474C3;
	Sun, 24 Mar 2024 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322095; cv=none; b=SJwKkE2jFaV5Seup3RFhLNIVdSquKrn+SBPShJGTkQqYgqu9YBmTS0I5DjYGX2kTQA38YcJJ+n8NeCXzpEh7srGqdZj5TjKrS8XAOZkkzrStk815ZGytSbUMLJ59PBr1vk5P6JwUAwmz8phOZXXPAB/ZwEOPi85cani2DOrWt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322095; c=relaxed/simple;
	bh=ONQnGrsTBSKyqJBBANW/CB9L/aKeOMVYE0rpQPW02lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbUfnDx9vdLtvpXnaRR94bK1vguid7aIIO6gQPdjR5QO5+kQ3k0gpdff6+a5CGM3JZsU9fRW6Gk1mmWN/FibGv+ztqt42a44uN2fEtIGmh0nko9Oi2wOlP6ZoXG2ZNrsvRFf5haxFfJTL63T6bRMzidxp5tUphzjjO5YNGH3MSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otBwovbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9580C43399;
	Sun, 24 Mar 2024 23:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322094;
	bh=ONQnGrsTBSKyqJBBANW/CB9L/aKeOMVYE0rpQPW02lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otBwovbqqraLCHMQ4igniB0P4CB/YYOIkbvNSLlVXCguiZzI+U1jigvjT6q4jnBJ0
	 gEtyZSksr38WlyNOz/Ylxr5/s/lpkp4fhIeLMzMtlAJ8esuTXgKPsJ4/B+nkAAhJ0t
	 GAgn+l6WU3ycVqUOJsVnZMNvb5CDm+iOWGUc0aCxw7/jxij9crjfNK34mEXyqNF7Kw
	 QlJGSliH1Oe32t8Qa6K09YR3tk2o0GnGGlMnHdjNgnf9KgPFybjqtn3p/nh20yjMtv
	 0WcqrAFCSRMVSFy9sy7CiMDfQCRzLNDM85+DI993T5qQkY/0xFNDk3FUjlKlBydDVH
	 F4OG6DlReZsLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 168/451] arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
Date: Sun, 24 Mar 2024 19:07:24 -0400
Message-ID: <20240324231207.1351418-169-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index a6e777aee02ee..011d4c88f4ed9 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -99,7 +99,13 @@ irqc: interrupt-controller@110a0000 {
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
@@ -111,7 +117,9 @@ irqc: interrupt-controller@110a0000 {
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
index 7dbf6a6292f49..d26488b5a82df 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -698,7 +698,27 @@ irqc: interrupt-controller@110a0000 {
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
index e000510b90a42..b3d37ca942ee3 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -704,7 +704,27 @@ irqc: interrupt-controller@110a0000 {
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


