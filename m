Return-Path: <linux-kernel+bounces-113752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768E888668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D846C1F24700
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562921EF7E1;
	Sun, 24 Mar 2024 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDEuS4QI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A981D8DDC;
	Sun, 24 Mar 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320755; cv=none; b=s4P9yJ/G/8fD32HuQh1BKhzjPFUBaUxr5TCys/p+pyYdf0lMmwGIXqVtQ92+BrurasoCieG4VlNZUhX2dBNH9w2ZYsz0oGcgamt8E8advKQU9xbYI4kfbd1lPk8BhysfzOByJ+MH7/qY4DLJzFXxEPZZNJvKfCqmcU/h1t5b0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320755; c=relaxed/simple;
	bh=SshzBxQWI3HSxD262UrFfxJZBE5bBzCQvEdLf58jmno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj4ckwRxCxUtPLVfpbAXgXebwJGHuRnlCZpBpTYKHD8MbE+6X9gxn2pTqjPu86f1rL7TXeS2C5JUoGGYj0bzVhENYqYmvmTkwuMkhNxo4AgN1sPNJ27QDbajNwAAbgi0iT2cqmWGO9P5G0kaC45538rXfaJkzLyLB+xmzrrgpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDEuS4QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F790C433C7;
	Sun, 24 Mar 2024 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320754;
	bh=SshzBxQWI3HSxD262UrFfxJZBE5bBzCQvEdLf58jmno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDEuS4QIXaqvSNHOr2BSodwlFEL+8Pvufnw1aE1l5ZCW9580R3GY90XUYl9WTKePU
	 OaRlsWJqbYtUQcmNJGOZZnv74PpxfvtujZPNjr4C6ACd/Vq0Qa7nsWnoiDcSU0fEms
	 sPZv0c6zALzQQJX8OnfUUdT8n5OxMSYq2V/KKHS54uz9RjE0WZvcqy0EmqtHvmEc8M
	 C32uUCu50zsBlmvTGp3db5Vlx28qfzb09CaVoaLY4ISyyzYjI1JVs8coXyIYIgd9R3
	 XumA8RT4dNwu8PEc100VVxDuoeUrIh3JpVPJHPKHToVkbLd2gL9Tn5AG2ugrNWxwps
	 qf8K4UgZWwfRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 318/713] arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
Date: Sun, 24 Mar 2024 18:40:44 -0400
Message-ID: <20240324224720.1345309-319-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index e300145ad1a6f..1cc3fa1c354de 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -431,14 +431,14 @@ xor11 {
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
index 4ec1aae0a3a9c..7e595ac80043a 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -511,14 +511,14 @@ CP11X_LABEL(sdhci0): mmc@780000 {
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


