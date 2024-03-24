Return-Path: <linux-kernel+bounces-115901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F56889D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6B22A7400
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C1146015;
	Mon, 25 Mar 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1Hemmww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858841474B9;
	Sun, 24 Mar 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322094; cv=none; b=pL+aBZS9+ZTITdvzMTgWUtjk+gwgTVeIrgqY2S52r+w8sOZh4cyjrhLwVMwv0ueHAQrJHETkxQJsrhS2k9IkOgyubAzm2ZEstq6kBAYz8AtT2KQwuJB1VpNMjtPG5SZjgC0Kop2L/4JC31Dm8JVhpo2QhC7sQ23PnIxs7fUvzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322094; c=relaxed/simple;
	bh=D47bL5+zHFOA8tQxzCu0DBFc1MJ0x4OeNsh96LEUSKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLpjtfcqrTaUAmIKB3SL9eIrVlOC85jzCjryaiuEl4iPq0YzPhdnB2dLY/EaPLkRjPBrnOY+Si9WAjXgrdrJ90yLaWY1egCB5PBUKls4TffEhAmMTYgin3k/YNg7GBz40u3eUPsD7PfOAzXgkVLGwigd44XN04fV8QvmOHgzCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1Hemmww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AB8C43390;
	Sun, 24 Mar 2024 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322093;
	bh=D47bL5+zHFOA8tQxzCu0DBFc1MJ0x4OeNsh96LEUSKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1HemmwwjJ2SHUJFygV3Bexnlnu+fm4/ntpFdFXLN9VaQ3XjAbRAk7pgob/Ref+HX
	 ZIBX4Y2SU9DEMz5fzXO7hLNawBc2CLrOK20uzh0FArpZMrChu2eIJzaYAyKw0EbjBX
	 YVa3ZTF1RsOQ/0hTwi4MLM9EZjpdmhjpan3TqWv0fuDDMIjYw8quvK+B4MdmiPG92r
	 1wEMmO7Xwslz5pLcePKst2R/l1jgISN/A9qqidhXrCuOAffI1rC7gVo6kI8RSgjGTp
	 KTWzxlVWuWTJBV2OKO5MMV1OlTH+3hQPAgYS+YUgRfF9dbXhZaivwi7ZEdA9bnIUVx
	 vlCmzFMdGzs0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 167/451] arm64: dts: renesas: r9a07g043u: Add IRQC node
Date: Sun, 24 Mar 2024 19:07:23 -0400
Message-ID: <20240324231207.1351418-168-sashal@kernel.org>
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

[ Upstream commit 48ab6eddd8bbcf7e9c8ae27bf42d0b52a777aaba ]

Add IRQC node to R9A07G043 (RZ/G2UL) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230102221815.273719-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: 14fe225dd5fc ("arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 68 +++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index b8bf06b512351..a6e777aee02ee 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -51,6 +51,74 @@ timer {
 &soc {
 	interrupt-parent = <&gic>;
 
+	irqc: interrupt-controller@110a0000 {
+		compatible = "renesas,r9a07g043u-irqc",
+			     "renesas,rzg2l-irqc";
+		reg = <0 0x110a0000 0 0x10000>;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		interrupts = <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "nmi",
+				  "irq0", "irq1", "irq2", "irq3",
+				  "irq4", "irq5", "irq6", "irq7",
+				  "tint0", "tint1", "tint2", "tint3",
+				  "tint4", "tint5", "tint6", "tint7",
+				  "tint8", "tint9", "tint10", "tint11",
+				  "tint12", "tint13", "tint14", "tint15",
+				  "tint16", "tint17", "tint18", "tint19",
+				  "tint20", "tint21", "tint22", "tint23",
+				  "tint24", "tint25", "tint26", "tint27",
+				  "tint28", "tint29", "tint30", "tint31",
+				  "bus-err";
+		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
+			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
+		clock-names = "clk", "pclk";
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_IA55_RESETN>;
+	};
+
 	gic: interrupt-controller@11900000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
-- 
2.43.0


