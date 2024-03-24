Return-Path: <linux-kernel+bounces-114123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3654A888893
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0B41F278BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E615351F;
	Sun, 24 Mar 2024 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgWoFn+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CA20239E;
	Sun, 24 Mar 2024 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321430; cv=none; b=PhaNefMK4nFMR1SymcJiSFGe1g7RuwMpmcLudGp4UVfw/r1t6SNCF8tZnFpSIWuD02U0GMJeuv1U+4xSCiBYXAEyUdJIPNXIup1Cpx60a636VSzqDKxHQ2zoHMANubDqloTlQz/CD3Wm5GD/ST6v7cn/YuG+bcLywq97wnSFbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321430; c=relaxed/simple;
	bh=+4AiABqnksxNdiMVZMOXIxNcwiZbJbOVBDo6C4zJjWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxTKy4O6OuA7q/edSEDLjgIjfZOmAtQSs29ezNjKt0XiGgU5qqK8SNrhClZebPRdksPVGeZbCrPVCIymVIOWMvmSENAsHRk011rzKs+Y7ZHnwZXYbjLxO1DPidfbM1E6TvhY8w6G+Iida9sQBY6iwgGE14ba8Zz3oS+pivgb4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgWoFn+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B839C433F1;
	Sun, 24 Mar 2024 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321429;
	bh=+4AiABqnksxNdiMVZMOXIxNcwiZbJbOVBDo6C4zJjWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgWoFn+JtYkrsie3Iim3VBF9Lsh1sAxZ3gxTYCbG3NRmUBeE9MLpYBUjgzCoDiOob
	 4rD8qP0kP1ajpf0icrGefosSIpCEADsGBec+hG4kqEkB9RrWpDwUcNx93nRQJkMozl
	 +VI3Y8Cqw1xCgJg6Ddh7mw8u8qMwxPhKNc9JsYezwZUKLJ6Y9dnBLU5dTcGPxcPTQN
	 vAoEC+VVKivvJzAuGxD30FGrKrlwn4VFqMh3N4fQkaOgOVNuZfxCWSjdPEJ1m/LM8w
	 rW4T2icgQhn6HzivQgUk6Ac35NLdv1WfQrGFXb7bFGtcg5N8kjAX7wdbTB7xuWpDLu
	 XOxvVxDLnzBxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 153/638] arm64: dts: renesas: r8a779g0: Restore sort order
Date: Sun, 24 Mar 2024 18:53:10 -0400
Message-ID: <20240324230116.1348576-154-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 8b93657c976a61726d7ffbe8d019b84b4abfb673 ]

Numerical by unit address, alphabetical by node name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/f00ef274a73c8fd60f940a1649423a8927b9ae8a.1705324708.git.geert+renesas@glider.be
Stable-dep-of: 08e799f6bce8 ("arm64: dts: renesas: r8a779g0: Add missing SCIF_CLK2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 72 +++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index d3d25e077c5d5..3be1159982b20 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -161,11 +161,6 @@ L3_CA76_1: cache-controller-1 {
 		};
 	};
 
-	psci {
-		compatible = "arm,psci-1.0", "arm,psci-0.2";
-		method = "smc";
-	};
-
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -185,6 +180,11 @@ pmu_a76 {
 		interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
 	/* External SCIF clock - to be overridden by boards that provide it */
 	scif_clk: scif {
 		compatible = "fixed-clock";
@@ -1777,6 +1777,37 @@ ssi0: ssi-0 {
 			};
 		};
 
+		mmc0: mmc@ee140000 {
+			compatible = "renesas,sdhi-r8a779g0",
+				     "renesas,rcar-gen4-sdhi";
+			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 706>,
+				 <&cpg CPG_CORE R8A779G0_CLK_SD0H>;
+			clock-names = "core", "clkh";
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 706>;
+			max-frequency = <200000000>;
+			iommus = <&ipmmu_ds0 32>;
+			status = "disabled";
+		};
+
+		rpc: spi@ee200000 {
+			compatible = "renesas,r8a779g0-rpc-if",
+				     "renesas,rcar-gen4-rpc-if";
+			reg = <0 0xee200000 0 0x200>,
+			      <0 0x08000000 0 0x04000000>,
+			      <0 0xee208000 0 0x100>;
+			reg-names = "regs", "dirmap", "wbuf";
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 629>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 629>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		ipmmu_rt0: iommu@ee480000 {
 			compatible = "renesas,ipmmu-r8a779g0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
@@ -1886,37 +1917,6 @@ ipmmu_mm: iommu@eefc0000 {
 			#iommu-cells = <1>;
 		};
 
-		mmc0: mmc@ee140000 {
-			compatible = "renesas,sdhi-r8a779g0",
-				     "renesas,rcar-gen4-sdhi";
-			reg = <0 0xee140000 0 0x2000>;
-			interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 706>,
-				 <&cpg CPG_CORE R8A779G0_CLK_SD0H>;
-			clock-names = "core", "clkh";
-			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-			resets = <&cpg 706>;
-			max-frequency = <200000000>;
-			iommus = <&ipmmu_ds0 32>;
-			status = "disabled";
-		};
-
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a779g0-rpc-if",
-				     "renesas,rcar-gen4-rpc-if";
-			reg = <0 0xee200000 0 0x200>,
-			      <0 0x08000000 0 0x04000000>,
-			      <0 0xee208000 0 0x100>;
-			reg-names = "regs", "dirmap", "wbuf";
-			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 629>;
-			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-			resets = <&cpg 629>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
 		gic: interrupt-controller@f1000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.43.0


