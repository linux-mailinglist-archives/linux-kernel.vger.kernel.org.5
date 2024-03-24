Return-Path: <linux-kernel+bounces-115909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19C889899
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3BF29ECA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16DE38893D;
	Mon, 25 Mar 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGozU9n4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A6148301;
	Sun, 24 Mar 2024 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322105; cv=none; b=tEOoY6i/3r2cSvPtMm590WNYWytgNGGnL1McnfvHbQZfoZreM6HV2aErTscPJpn0RfV0DKHYFf7VLqPt6jv7nayaeZ6f2ovQUV+0SOjiY5elQz3rzIcOgQz25m0fn4/OiRxVKzWL/U+2blwZ4VqyFozKbWRygLAiWXxBUOB05FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322105; c=relaxed/simple;
	bh=5QHypYvv7lO4d7Abg3P4AAedmMuA2mFkZo5AS5AWX+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ko5tI5HtFRYubtHHVa2GnnDySr2eluPhgvSEcwqiE00IB+o5l2xCVUnUa+vSkHgHPV/GX+LfPtW8WBnfmZBcPdsl0vMxVf/7N9D7GHhwuo28kuyUQBaP43gJrg3N54Bmhzw/6XWbWMXFTmcO5dQzhaIHwQjo/DoKMa9jGQJYYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGozU9n4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6493C43390;
	Sun, 24 Mar 2024 23:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322104;
	bh=5QHypYvv7lO4d7Abg3P4AAedmMuA2mFkZo5AS5AWX+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGozU9n48TM+uCNC1iHbLEl0s9onPQPgYECA20tud5DXLc9ZbM2P8oOzt2Kz8urJa
	 JXk1luWf95GX3Cju+PrgmZWwt1MeRI9e0ngb97tz+vKwXGBRdI1QJwjB1fPRLClo5L
	 zXdbKzRRsAjwNj6vJ7nZ2PodKA+YCRJ7yhSLojPKeqzxSfrQB5/mjbLIixGdaOY8yC
	 5HCtPCfdY9zgo77jkn3vk/sJmVmThrb8UcoiSMhhq3cWspiaJE1E1e9KsPTBEIGLnu
	 kYvbgp71URLscy1JFlnPi2qQahMCcnZniWPJndIjfvYM4AWipweosBlrvbtRHly0pW
	 UgWB3hspfsgKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 179/451] arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
Date: Sun, 24 Mar 2024 19:07:35 -0400
Message-ID: <20240324231207.1351418-180-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index df152c72276b8..cd28e1c45b70a 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -426,14 +426,14 @@ xor11 {
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
index d6c0990a267d9..218c059b16d9c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -506,14 +506,14 @@ CP11X_LABEL(sdhci0): mmc@780000 {
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


