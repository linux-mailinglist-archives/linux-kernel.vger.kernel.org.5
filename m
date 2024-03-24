Return-Path: <linux-kernel+bounces-115904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0E889890
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF531C279CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88B238816C;
	Mon, 25 Mar 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1Rnj3r3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AB1474CB;
	Sun, 24 Mar 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322096; cv=none; b=tIdYvnBwgROHXiQGFTZ7kCD/v98ug0pfF4f70kg9OnT7EuT41qlXf1n0MlPqCCM/vdx3kT5P71ucgjkeOnG/9dLPHsUKz2d7xBxE4pipWsrB8H4h/UQwTVb3Sg9V3KYwVqm2T2jA05QmDC36Be/Bb6vK03S97OfHRzuuEkjayYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322096; c=relaxed/simple;
	bh=tK4EoWVctIE2m5gj1wcV4WEA29k+3//FMtxpCWEEEHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN6XMJN74afyi55XJbsXMsh0tn8mc3JcjekI1X1Xi44p+44NsIxF3XNmDVbCkSFjQ0FqNuNVX1SViF9pvQVCl6tSWi75k/ux7X8O0yZIVjdmcpkrS2fZEzbZfUEa2hLnFeJzZiLMMiMec7pAb6ubJZBkUP1JPUBgVGJFV660ebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1Rnj3r3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926E4C433C7;
	Sun, 24 Mar 2024 23:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322095;
	bh=tK4EoWVctIE2m5gj1wcV4WEA29k+3//FMtxpCWEEEHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1Rnj3r38O8MOppKm8TziwO3YDFVudNFSBM9cenxoY6VeI+Xv/SIrRf3KhGCI8K3v
	 TRKnW9FRRTzSp7o49WUgaUjFfTlp4mwjrPEocFvZqw0RyTgNmZWVHT7Y6E2i8cVTJF
	 SFhvT8gFRLkIt/EctmCDjbnNSNOlIUQKVSQmjKDNt0m3dncasyyLD9gQTCPjF+q8sY
	 Nqf8ZAK7Sd69Upgp9+6u+7Z1C7EcGwoYpz94Jl/5dJgi97z8bLjh7pciAvnan2cxQm
	 j9G0MQjK3K+nWigdnsjYqIOIOVAVX31i7y25Njiehv89DFMOKJsYhP4fnioVnKE2Lj
	 En/ikmdl3D/Rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 169/451] arm64: dts: renesas: r8a779a0: Update to R-Car Gen4 compatible values
Date: Sun, 24 Mar 2024 19:07:25 -0400
Message-ID: <20240324231207.1351418-170-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a1ca409cc050166a9e8ed183c1d4192f511cf6a2 ]

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family.  Hence update the compatible properties in various device nodes
to include family-specific compatible values for R-Car Gen4 instead of
R-Car Gen3:
  - EtherAVB,
  - MSIOF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/387168aef20d399d4f4318f4ecab9c3b016fd6f2.1666605756.git.geert+renesas@glider.be
Stable-dep-of: 0c51912331f8 ("arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index ed9400f903c9e..41fbb9998cf82 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -656,7 +656,7 @@ channel7 {
 
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6800000 0 0x800>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
@@ -704,7 +704,7 @@ avb0: ethernet@e6800000 {
 
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6810000 0 0x800>;
 			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
@@ -752,7 +752,7 @@ avb1: ethernet@e6810000 {
 
 		avb2: ethernet@e6820000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6820000 0 0x1000>;
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
@@ -800,7 +800,7 @@ avb2: ethernet@e6820000 {
 
 		avb3: ethernet@e6830000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6830000 0 0x1000>;
 			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
@@ -848,7 +848,7 @@ avb3: ethernet@e6830000 {
 
 		avb4: ethernet@e6840000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6840000 0 0x1000>;
 			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
@@ -896,7 +896,7 @@ avb4: ethernet@e6840000 {
 
 		avb5: ethernet@e6850000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6850000 0 0x1000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
@@ -1019,7 +1019,7 @@ tpu: pwm@e6e80000 {
 
 		msiof0: spi@e6e90000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6e90000 0 0x0064>;
 			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 618>;
@@ -1034,7 +1034,7 @@ msiof0: spi@e6e90000 {
 
 		msiof1: spi@e6ea0000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6ea0000 0 0x0064>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 619>;
@@ -1049,7 +1049,7 @@ msiof1: spi@e6ea0000 {
 
 		msiof2: spi@e6c00000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c00000 0 0x0064>;
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 620>;
@@ -1064,7 +1064,7 @@ msiof2: spi@e6c00000 {
 
 		msiof3: spi@e6c10000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c10000 0 0x0064>;
 			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
@@ -1079,7 +1079,7 @@ msiof3: spi@e6c10000 {
 
 		msiof4: spi@e6c20000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c20000 0 0x0064>;
 			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
@@ -1094,7 +1094,7 @@ msiof4: spi@e6c20000 {
 
 		msiof5: spi@e6c28000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c28000 0 0x0064>;
 			interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
-- 
2.43.0


