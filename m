Return-Path: <linux-kernel+bounces-115411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC33889B64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292FD1C34579
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE9204E2C;
	Mon, 25 Mar 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+ed9qYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539B82D9F;
	Sun, 24 Mar 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320613; cv=none; b=Oey1wfh4hO82mEs6VGo7CvXRSEfQVcdTrNxWzVsd7ToYs7U85Lq/lQZo7bGoSMHofCyFT5vIZc6JtH9+0Gtud35mhHo3KFZAuuyaF3tUWIy/AddsMWTtkOTNQ0eCDsD9ZnMZNdNL9LuY5aF89VByfaZBu3vOZ7lbTdhEOqeqPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320613; c=relaxed/simple;
	bh=9Qq1iVEdw0G3vZVt9MiiXBeQOuukWCru2oMuL3av5NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4N4LEFhV9ZwGCvjuLxPGgJ2DpjXPJQOtZLL3f2DtYqRq5J/B0sEmiTOG+J2utOn3dppadAWqrBT1EAFxjRVxEb/SVBgij4W2kiQnlFGvpvm2NvRGQ4U9YW6NoOnmy+tP8Df9900Ke1AWWhkiAPr/yNA1uC0hOlazpLfBzNVe0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+ed9qYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB230C43394;
	Sun, 24 Mar 2024 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320611;
	bh=9Qq1iVEdw0G3vZVt9MiiXBeQOuukWCru2oMuL3av5NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+ed9qYt4x8gmmB42I/VcWjzOpyGLat5RUt3jXGlneEhfQHfoZqpQeG2qs6cZty81
	 ffN8F24ILeAhKB8z9nP14HgUS1dz3UxQFaaOXLYkwfGO+2nq7gwrpqU02clgnUJpOQ
	 M5fDZkiTUfGqlSav5Uh1ms6HDwzpnHGL+CCDhi/MLlhU39h77CBaS1Xtrak9YE4PLi
	 ls09PBz5IVsbFCa7/u2T2/re7uQelFOQnArQtr5T0AGfnJkLQiSP9OXqhPzdxofeek
	 HmFO6byZ1NhS1BQOSCjEw45MQTXxB0cMAHv2hUe1E487Fy13ApxhP4GSCdrvb8+R3v
	 TSTHtoqcoWOwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 172/713] arm64: dts: renesas: r8a779g0: Add missing SCIF_CLK2
Date: Sun, 24 Mar 2024 18:38:18 -0400
Message-ID: <20240324224720.1345309-173-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 08e799f6bce80dd63c174d8d0fc61d1a6149960b ]

R-Car V4H actually has two SCIF_CLK pins.
The second pin provides the SCIF_CLK signal for HSCIF2 and SCIF4.

Fixes: a4c31c56d2d35641 ("arm64: dts: renesas: r8a779g0: Add SCIF nodes")
Fixes: 39d9dfc6fbe1860e ("arm64: dts: renesas: r8a779g0: Add remaining HSCIF nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/72f20c1bf32187bd30a963cafe27252907d661f9.1705589612.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 3be1159982b20..0c83940b3d8a1 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -185,13 +185,19 @@ psci {
 		method = "smc";
 	};
 
-	/* External SCIF clock - to be overridden by boards that provide it */
+	/* External SCIF clocks - to be overridden by boards that provide them */
 	scif_clk: scif {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
 	};
 
+	scif_clk2: scif2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -681,7 +687,7 @@ hscif2: serial@e6560000 {
 			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 516>,
 				 <&cpg CPG_CORE R8A779G0_CLK_SASYNCPERD1>,
-				 <&scif_clk>;
+				 <&scif_clk2>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x35>, <&dmac0 0x34>,
 			       <&dmac1 0x35>, <&dmac1 0x34>;
@@ -1057,7 +1063,7 @@ scif4: serial@e6c40000 {
 			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 705>,
 				 <&cpg CPG_CORE R8A779G0_CLK_SASYNCPERD1>,
-				 <&scif_clk>;
+				 <&scif_clk2>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>,
 			       <&dmac1 0x59>, <&dmac1 0x58>;
-- 
2.43.0


