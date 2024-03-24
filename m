Return-Path: <linux-kernel+bounces-113161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E38881F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85506B23C94
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B891130484;
	Sun, 24 Mar 2024 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd50yhGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5B17334D;
	Sun, 24 Mar 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319963; cv=none; b=KsjRQu/X99CSU3pqRElEE4sevZSRKmg+5pp30yoCpj9Mi2+5TNN25jdiGbYzVZBY6RsyOMVoE/K1v3qu3iWfXRZDVqB9ONlLMxO3/cZHiDTayzYaTfK6yrUeu3iWMw7pXVfORgBRwXYY+hLMliZE+OkSDOouD4jnw1FmPWD+tUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319963; c=relaxed/simple;
	bh=SshzBxQWI3HSxD262UrFfxJZBE5bBzCQvEdLf58jmno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKyJ5umqQiLGE3CqDdXjTErQwc8Yg1y1fFyUfHaxzrckh6qsx1p/8B+S5G22GuJ8Y6L515SByKNqFl9iSgT6CvRHMLztIp2AvsJbNVgdTAHelWk30jrjfGapgGZXYKt/IPioIsnBXY6T4yf1610Enc8+I+kTZ19Rh4O1CUihFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd50yhGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B385AC433C7;
	Sun, 24 Mar 2024 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319963;
	bh=SshzBxQWI3HSxD262UrFfxJZBE5bBzCQvEdLf58jmno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sd50yhGgrZ8S3sn1ADOc+FRHtwyKAbU3H0kmZqsY835yZqAkDqVHtmUgnLioV9q0Y
	 IriFcFYQAYIb2GqKFZVmnzeHWmS5mdNzTcSjFTJDqM7kNI3nnmRYaOvpCsu5kXlOEl
	 sQgMPKhyDMYpcvKKVGCbzGXcBFNUMM2/mlLEM7rrrHKRpLAjozNueI4HjZPKE5XtmV
	 BCQsrE4R6VFFbaViSE5AdZT9M5y4iA/5DMwGb+/aRvAbX+WZD0nd/nvH3x2CjCOVR8
	 aTYGYH1KHDJdrWdZ3RK7lndzxL049Cr2rtomaIVlt7Cjmf2mm0oxsrcqJpbDlHr6Bq
	 kF5r95+HoNU5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 270/715] arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
Date: Sun, 24 Mar 2024 18:27:29 -0400
Message-ID: <20240324223455.1342824-271-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


