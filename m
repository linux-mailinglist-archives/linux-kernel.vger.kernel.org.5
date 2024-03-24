Return-Path: <linux-kernel+bounces-114970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B60888C46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67061C29C88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCE1BF53C;
	Mon, 25 Mar 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezFbTXUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFE1311A6;
	Sun, 24 Mar 2024 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323703; cv=none; b=L+5diZMC7HztgLqkttKQC4x8oH+GWIWOsFnN2wV/jSnmyWf35kBH41Nu310MJnCFDGvfzwtFTWC+0tNkT6f+Hkp0UeX3qdEOUyPXM1quM4PKZNQmaIvDz4DSEwmhVb3bawwXA1vGUHGMaF1l9VCFxH+cMvMQlXSi2g1k0XjhlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323703; c=relaxed/simple;
	bh=fxBXclm5odU7MS1XP/p5zvVRiI/LKuoAIK+l4yHfNVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeJvD51fbKYjfRb9B13G8fA+8qlEu4h455RS4Vk9jYiy4NxYGa55b6mYCBWlLzgEWNLV6Syh07jNotfPAW1IYb/J2fn7+lotoskf+7ZGXQ8QSm3aZtBXWw4dzGjBn8d1bTWZWXb+AS/ROM1os1sMibHjU6qOcYQA8UFa7fi+8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezFbTXUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A169C433F1;
	Sun, 24 Mar 2024 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323703;
	bh=fxBXclm5odU7MS1XP/p5zvVRiI/LKuoAIK+l4yHfNVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezFbTXUJqfuHL9mvr82WCSEeTtV4toPH90Cw6RidElE36NveteNm0R+EuU9pRIZHi
	 DTgZ7IzGX3ixroBA2sGKgg/gcJD4XjOYvUFOD0qZJh365LqkUxKJ054WefyDDpj90w
	 omwWhZZVWsfKpdtJLTWDnAxfQH8TiUTxn3tAXfvS90RzvBDP383UUDFwGo5g/NqH5F
	 hOhKRQE0Uwd4m3/syNAVCw8W4l+Br4HUiH9JEOPBAvBkF4C3qMisG8COq8rNuPgDTH
	 9vWaIBu/9k9M9fLkBT/lR/YeWGfe0g9h/t90Oh5GbW6nOfle7KpfQCv/jO+VudLXIQ
	 Gmcx0qj3BqRMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 076/238] arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
Date: Sun, 24 Mar 2024 19:37:44 -0400
Message-ID: <20240324234027.1354210-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 0f4bcd15d8580..086c3cc7d055c 100644
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
index 9dcf16beabf5d..da83bfdbe8432 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -477,14 +477,14 @@ CP11X_LABEL(sdhci0): sdhci@780000 {
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


