Return-Path: <linux-kernel+bounces-103229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966C87BCA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8943B22645
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8710B6FE30;
	Thu, 14 Mar 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilWTQOqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28286FE13;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418833; cv=none; b=dW+OfDctDifTKpgl9f5qkI+oOCndBh6ifwe7VC0c7FPUp9aoOaiTCJij683bGNyuaD8pYzLxbzzz32K+NDCtQTNuRBuWARLF/Zwcc1Ptu+ElvrprkIfPAcrk2mRCN8nZQt8Sm54sNhKEkm49fZfzSIVOU9Qfmjlmr8Ux7h0ghTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418833; c=relaxed/simple;
	bh=IXwjfXG0qJTi6SvXy2YJc8p2iUQs4kEjF2r+M9G6w38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgyiaKJUG1M2bX/r/uBLKp45H6VZ25gyCQZTuXUGknfNwVHsnE/05RkPtdzwaB19OKRhEg7uc9vxOvdzq+uhCCgqvKdpvfPdlGzmNJOjFMeQuK2+l20wAL4rqplXGcd+EiNcDLKMWkUN3bvn46Gcf8WTxEr/YKBz7TdAEBkDIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilWTQOqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68B0AC433F1;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710418833;
	bh=IXwjfXG0qJTi6SvXy2YJc8p2iUQs4kEjF2r+M9G6w38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ilWTQOqJCS0XZl06YmEiYlkl0uVFfItkJRPuN48+KseuhrBHloWj+8uvs2g3sch9N
	 zARb4qqxkcwwlkGtAmbfPr9KblhESLYIFhEgD7ZXQlQr5r6ig2qIlDAMt8yUO/8GXS
	 bSt5IGnSsDvJXQMWi1EIg3lTNXbTAnVxO5fUHmD0w/DaLxppbYvvQ9XEKmbLrMqkgG
	 xX4ntIwCzCiZKzhnv6EXtK1C86W2YOtsncAmDEfMKq70fVya6+XxwIBeQPTmP6dGfU
	 9bhfpFLOSKiGcbddJalArV0WRqWRM8zsRRJdK7UUjr3mSm0j05D2+GQlrCJS1UTlFA
	 Jdnn9QOrHhfQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B0C54E67;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 14 Mar 2024 15:20:04 +0300
Subject: [PATCH 1/2] arm64: dts: mediatek: mt7622: set PHY address of
 MT7531 switch to 0x1f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com>
References:
 <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
In-Reply-To:
 <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710418818; l=1766;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=MsMYU0TxWWTBU66KZyBJipAujGDLpPEL4caKiInP0uA=;
 b=bE8w4jzb7bYQAt6bDoKuVeYIQ298ZArPNyXnvaNKtmYEAdgOepcrRbnjuiqj8FRr3Uk/rrmyL
 geOZd1Sbuj9A8Ea0iWmdUuG4z5fEyLd8BsvREEhr7/BDP1N9ij0SF5X
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got two
findings that support this. There's no bootstrapping option to change the
PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
address of the switch. So the reg property on the device tree is currently
ignored by the Linux driver.

Therefore, describe the correct PHY address on boards that have this
switch.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 224bb289660c..811b227d6f50 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -149,9 +149,9 @@ mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7531";
-			reg = <0>;
+			reg = <0x1f>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupts-extended = <&pio 53 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 41629769bdc8..3c2423cb38fd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -134,9 +134,9 @@ mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7531";
-			reg = <0>;
+			reg = <0x1f>;
 			reset-gpios = <&pio 54 0>;
 
 			ports {

-- 
2.40.1


