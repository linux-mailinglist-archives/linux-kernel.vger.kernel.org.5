Return-Path: <linux-kernel+bounces-113145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24DE8881D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBE9284087
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0706129E67;
	Sun, 24 Mar 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTk+so1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7C16F8F4;
	Sun, 24 Mar 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319952; cv=none; b=QB240lkFu+Kk3aGRwH4F53vImoFjSJofzXeE286Gec2AYq37xWp1LaOHMP2L/s5feFS+mHqy7ia6Glfu7kp0YBfpJu6Y3jrKS73bRYb6ilDPaJwt2/wszsfnsPz37ToOZennT/+F6TnEDCkBr7NnXQQwUc0cYLtSZGY2BoJcTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319952; c=relaxed/simple;
	bh=UdODhsLqPh/+m5k338G4uLy8cOv40xr96gGPJ/2rmNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H894S9J2jdF/iCFORXDmk4QrM2r7j90Z7FNLRlLx0ofnsDrkGuJFsYy/3PmkvK7fFZ4yrDT2g+URl81aLI1qbWbp2QooWyV/1ixsDPULiaFE3G/wpSWfZE386mFh8vheCzomeSWIZP+bDR+rXBHf1pIZLaa5i1sxghcXBo43vdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTk+so1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8109BC433C7;
	Sun, 24 Mar 2024 22:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319951;
	bh=UdODhsLqPh/+m5k338G4uLy8cOv40xr96gGPJ/2rmNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTk+so1d+9s7DAPsWnRobkROLQdLHKg+nP5nEm+Ql9PHjxQbT9XIhcnh70ikRlXBT
	 BJDXAl2Ley/y47IRrwnSMJJsgdYBNzzccoO4+VGjC5XtbXIEIw67Cik9LDQ/Vebo/v
	 8WKR11acCVzY1nlWilUrBognR7hwNx8WbtKJlvXNPJUNTZR4pTyMPBJl4MVDRLAtzE
	 RbvnzJpM6OXfL2STLhGzbHvyqAOD39zXI9zFVO7QwpCBFeLH/a+EQ/D24mbAnONORT
	 TghoAiPXNo6izOkHW0dC88kqzHl+kt8UZtNrF1dE67tOZwLiaL9JwDNm6KNzofql7Z
	 tVPp51ayDSkdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 257/715] arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
Date: Sun, 24 Mar 2024 18:27:16 -0400
Message-ID: <20240324223455.1342824-258-sashal@kernel.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit bf7e37716d995c54630c30540db5642f58ea037a ]

The IRQC block on the RZ/G3S (R9A08G045) SoC supports ECCRAM error
interrupts too.  Add those missing interrupts to the IRQC node.

Fixes: 837918aa3fdd ("arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240205144421.51195-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 5facfad961583..6315ffa6c1bb9 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -152,7 +152,10 @@ irqc: interrupt-controller@11050000 {
 				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nmi",
 					  "irq0", "irq1", "irq2", "irq3",
 					  "irq4", "irq5", "irq6", "irq7",
@@ -164,7 +167,8 @@ irqc: interrupt-controller@11050000 {
 					  "tint20", "tint21", "tint22", "tint23",
 					  "tint24", "tint25", "tint26", "tint27",
 					  "tint28", "tint29", "tint30", "tint31",
-					  "bus-err";
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0";
 			clocks = <&cpg CPG_MOD R9A08G045_IA55_CLK>,
 				 <&cpg CPG_MOD R9A08G045_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-- 
2.43.0


