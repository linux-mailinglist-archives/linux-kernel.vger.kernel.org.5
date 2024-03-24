Return-Path: <linux-kernel+bounces-114810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE92889259
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278491F2E966
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B2226EF47;
	Mon, 25 Mar 2024 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plwHa4wP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27042779DF;
	Sun, 24 Mar 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323414; cv=none; b=JP50/lZs6SZAmKkC5xtd/Dt+ubVTXs34mhCyyiewW7fhBV/2O5bxVzEyckO3yo74HNYezbLkexSmnXvDpqZoDkfdJCuv2CuTE0mqigi4j66PhOT5bhFvrkK90O6m/nChrrEBgu4crTuFJHnjXtS1LFNCmubWDi7e9w8y4nqe2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323414; c=relaxed/simple;
	bh=JhEEWSKSgsBQevJuZJkvePvPOhReXJaVKUgv87VQtGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZEsE2ZVOs3vLKMedrkl9im/K5Ma2RxFzxKxXgEatqMi+kS90T/FRGlZ7KlYq/RIBbFu3zaWOj4BRU4pfDrWizS7/tb4TKTHXxe2fcl8287RsnF+MS9fXJS9wvqbFF4xh4wkoKR+apIsGqQEKZ2BOX0hqiksBsTjG05Ax6hi/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plwHa4wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB89C43394;
	Sun, 24 Mar 2024 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323413;
	bh=JhEEWSKSgsBQevJuZJkvePvPOhReXJaVKUgv87VQtGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plwHa4wPdgDHZ9Bf1fSYWpeByqJ2L1mvIfqsaleWkhm5/VJ6TcLNY+xiJPrCHd3jp
	 cjMlz33OIg/iKVBQ11C/DIWOXJh5NOOYNDOIvJSzBVD8sy4yAmnkG5bQD07hzkf9nJ
	 t5pwKZ08f1inwJrPD4j7VplsSN85BY0uJ63t3e6lFtt24Sc/GgdDVHAEzEejO1swXB
	 0g+0KksdQuFYTazuMFCtBKpVqbD6ffaxrN3Db9dAK21qA+gG+xPp4mmrK/bv+OhcA2
	 M7qb9k7wkp8Z1xawIsmZVLc447ewr7DW3A1O73b2uvdwdep61+MJ25y3H4WV8Tdbxe
	 O7itdu4jcbxPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 115/317] arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
Date: Sun, 24 Mar 2024 19:31:35 -0400
Message-ID: <20240324233458.1352854-116-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit ec55a22149d64f9ac41845d923b884d4a666bf4d ]

Match order specified in binding documentation. It says "mem" should be
the last interrupt.

This fixes:
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:0: 'ring0' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:1: 'ring1' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:2: 'ring2' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:3: 'ring3' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:4: 'eip' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/marvell/armada-3720-db.dtb: crypto@90000: interrupt-names:5: 'mem' was expected
        from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 0adc194e46d15..9d147af115831 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -414,14 +414,14 @@ xor11 {
 			crypto: crypto@90000 {
 				compatible = "inside-secure,safexcel-eip97ies";
 				reg = <0x90000 0x20000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "mem", "ring0", "ring1",
-						  "ring2", "ring3", "eip";
+					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "ring0", "ring1", "ring2",
+						  "ring3", "eip", "mem";
 				clocks = <&nb_periph_clk 15>;
 			};
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 3bd2182817fb8..408fc9bfc9627 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -506,14 +506,14 @@ CP11X_LABEL(sdhci0): sdhci@780000 {
 		CP11X_LABEL(crypto): crypto@800000 {
 			compatible = "inside-secure,safexcel-eip197b";
 			reg = <0x800000 0x200000>;
-			interrupts = <87 IRQ_TYPE_LEVEL_HIGH>,
-				<88 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <88 IRQ_TYPE_LEVEL_HIGH>,
 				<89 IRQ_TYPE_LEVEL_HIGH>,
 				<90 IRQ_TYPE_LEVEL_HIGH>,
 				<91 IRQ_TYPE_LEVEL_HIGH>,
-				<92 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mem", "ring0", "ring1",
-				"ring2", "ring3", "eip";
+				<92 IRQ_TYPE_LEVEL_HIGH>,
+				<87 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ring0", "ring1", "ring2", "ring3",
+					  "eip", "mem";
 			clock-names = "core", "reg";
 			clocks = <&CP11X_LABEL(clk) 1 26>,
 				 <&CP11X_LABEL(clk) 1 17>;
-- 
2.43.0


