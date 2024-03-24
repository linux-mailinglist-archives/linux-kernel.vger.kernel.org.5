Return-Path: <linux-kernel+bounces-114805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D5889162
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686B71F2D082
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E11B9C21;
	Mon, 25 Mar 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bueOf8fH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6732779C1;
	Sun, 24 Mar 2024 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323410; cv=none; b=evBAEbCIA6APVH70lP1HPTS2dsstvXDK5vC0CeupNZrhYIGAsRb0aOMwhBxfSo2JSKI9l19VgpVfXWKXH8vlK0DIj3HpA45BZGfKiGwbTZlgiS/+bRR1G7/wA8W0/qGgGXvdjmjUc9jDl9h/JMkjmnDlr0fMC8ITNunXadOFV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323410; c=relaxed/simple;
	bh=8x3RumNlyI5Nd+TDMBBANwg1SNN3LOs+F29m+HtTmqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1V1yNcIkaZHWn3LcfRmtm3Miq40h42YJKakATCGcdsQaFTpLtTvEJyfAE77wg6YgN1d/LvAoN2PJAD3Ndal0Gj+GWRLTaQn8oR/V6RNnZFrg20NKpbYRChOwg9Kqr2Ih/qAJlCNdihqJubpt2Q3TCM+b8tkUOUaaQh4a+HJDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bueOf8fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3F2C433A6;
	Sun, 24 Mar 2024 23:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323409;
	bh=8x3RumNlyI5Nd+TDMBBANwg1SNN3LOs+F29m+HtTmqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bueOf8fHUoDkcXl+Y1uL7RHHd0YZbnL3/ztk/PI72GLwSK1RJ65AwM8HrMkTpwmA4
	 umVERm3hzOt1MCyGd/m6HBLXTIUUHmTDEK0rolneaVESJolZh9bXmzvOoouuwvfHJJ
	 MKG1MWCZfntS0u3+FE30uOr7Th9gntqLd2b5dqw9xPD1NLgNoj3LHCQOI8r4FUPf2T
	 23qKOJxXR27T0FsZQ7GHJhOfeAg2fNEh7t2qPaCbYH+W0gIqw5evWjd6zvWAIrN8C7
	 MOqzqd4nwp/dz3UenCMYrKuLj82bauQsAM40FkPuL66+fRuJoVbc+FcozfA285eCyT
	 8XxvGDXJkapdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 110/317] arm64: dts: renesas: r8a779a0: Update to R-Car Gen4 compatible values
Date: Sun, 24 Mar 2024 19:31:30 -0400
Message-ID: <20240324233458.1352854-111-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a1721bbbdb5c6687d157f8b8714bba837f6028ac ]

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family.  Hence update the compatible properties in various device nodes
to include family-specific compatible values for R-Car Gen4 instead of
R-Car Gen3:
  - DMAC,
  - (H)SCIF,
  - I2C,
  - IPMMU,
  - WDT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/73cea9d5e1a6639422c67e4df4285042e31c9fd5.1651497071.git.geert+renesas@glider.be
Stable-dep-of: 0c51912331f8 ("arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index 26899fb768a73..c7d1b79692c11 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -583,7 +583,7 @@ hscif3: serial@e66a0000 {
 
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6800000 0 0x800>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
@@ -631,7 +631,7 @@ avb0: ethernet@e6800000 {
 
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6810000 0 0x800>;
 			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
@@ -679,7 +679,7 @@ avb1: ethernet@e6810000 {
 
 		avb2: ethernet@e6820000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6820000 0 0x1000>;
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
@@ -727,7 +727,7 @@ avb2: ethernet@e6820000 {
 
 		avb3: ethernet@e6830000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6830000 0 0x1000>;
 			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
@@ -775,7 +775,7 @@ avb3: ethernet@e6830000 {
 
 		avb4: ethernet@e6840000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6840000 0 0x1000>;
 			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
@@ -823,7 +823,7 @@ avb4: ethernet@e6840000 {
 
 		avb5: ethernet@e6850000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6850000 0 0x1000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
@@ -935,7 +935,7 @@ scif4: serial@e6c40000 {
 
 		msiof0: spi@e6e90000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6e90000 0 0x0064>;
 			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 618>;
@@ -950,7 +950,7 @@ msiof0: spi@e6e90000 {
 
 		msiof1: spi@e6ea0000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6ea0000 0 0x0064>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 619>;
@@ -965,7 +965,7 @@ msiof1: spi@e6ea0000 {
 
 		msiof2: spi@e6c00000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c00000 0 0x0064>;
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 620>;
@@ -980,7 +980,7 @@ msiof2: spi@e6c00000 {
 
 		msiof3: spi@e6c10000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c10000 0 0x0064>;
 			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
@@ -995,7 +995,7 @@ msiof3: spi@e6c10000 {
 
 		msiof4: spi@e6c20000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c20000 0 0x0064>;
 			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
@@ -1010,7 +1010,7 @@ msiof4: spi@e6c20000 {
 
 		msiof5: spi@e6c28000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c28000 0 0x0064>;
 			interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
-- 
2.43.0


