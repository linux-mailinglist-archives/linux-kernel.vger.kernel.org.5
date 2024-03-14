Return-Path: <linux-kernel+bounces-103230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905087BCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA031C214F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C06FE31;
	Thu, 14 Mar 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuRj+wpn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D66FE12;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418833; cv=none; b=ayeHBoypu3Zzf5RnqgYJAduM0CGevu8PZyOu9vm64No0aWeFQVj3HmXGGlRxzIO9xJWnpNs4CgIVJdkn3n8vARdiZA6PLee6+W9qA9Brs32CcPTYs+SwTLpvHyQPhC3RrIf33gYIpTCOnLJya8F6k428v0lv7/YYRqcSoWOfAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418833; c=relaxed/simple;
	bh=i5EDkw8J0JNnxVjPZWaIZE44QVEgnrAmclDKeQo2TNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoSeelK976aVsOOWFKHf2TDb42vp1GkDWAidh88NcOYpZwfrICH6zrK19jnbQT4AugvvN34xvj+NOXESgBKivqbB/aI320DOA9CwLjY+Y0ERNYsfoBvz6zu6d0odrC+uaF6Ei0gNyiJiJ4hUIKCZp0QHkD4mpRsPXJIxnx4jPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuRj+wpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 778E2C43390;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710418833;
	bh=i5EDkw8J0JNnxVjPZWaIZE44QVEgnrAmclDKeQo2TNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KuRj+wpnQOBxiXHfXnboOxKnAG1vLUyobhbk+NnGSQNhMu0+G7/itj/I/UnN8TmX1
	 r0iA+4BVnDiPczK+WPo6Vp8czWcNNPnhTslBuOZk3L94TQIwQ+NmNV+1pQ/4LKnbug
	 z/jiwm0YY6AUs0r0bvcNwxTyqgNQP4KsWgbBA4ZRCNrpzdFubE8baVDjHbQQsGlbUj
	 I6M+FkMHylV/XG4UpQfpppChm/uIkW2Q1uSXdZ0qve1oi6uNV3uMMZtx9gH6QvNCLW
	 wYog/IWnvC79ahPPy7mm7VCRRbWAL7pTJTkOK98/eENx3nzjlJxOSaxJqGJMT9n5gA
	 1P4uJ2mhqrTeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677B2C54E69;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 14 Mar 2024 15:20:05 +0300
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7986: set PHY address of
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
 <20240314-for-mediatek-mt7531-phy-address-v1-2-52f58db01acd@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710418818; l=2408;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=3Ww8r+vuHO472C8O6lVAWVIAZqqVc9BzJEESUiXjrfw=;
 b=ch+WqWFMCK7xwGGCM+rf1LHcsAnov6PeLDo0fzddIBRaE4gDy3EI57pnL9LBvIVKQyFlpQ2na
 +CHc4n8p9UXCpiTCroG3EL68Fh8UrCNoLERPyRKsgM0hTALp8lep1O2
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
switch. This is already the case on all MT7986 boards here, so use
hexadecimal numbering and align the switch node name with the reg value.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index e04b1c0c0ebb..2f92f8cfd8a3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -200,9 +200,9 @@ mdio: mdio-bus {
 };
 
 &mdio {
-	switch: switch@31 {
+	switch: switch@1f {
 		compatible = "mediatek,mt7531";
-		reg = <31>;
+		reg = <0x1f>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupts-extended = <&pio 66 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 5d8e3d3f6c20..47f75ece1872 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -84,9 +84,9 @@ mdio: mdio-bus {
 };
 
 &mdio {
-	switch: switch@0 {
+	switch: switch@1f {
 		compatible = "mediatek,mt7531";
-		reg = <31>;
+		reg = <0x1f>;
 		reset-gpios = <&pio 5 0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 58f77d932429..5148a69f4729 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -61,9 +61,9 @@ mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7531";
-			reg = <31>;
+			reg = <0x1f>;
 			reset-gpios = <&pio 5 0>;
 
 			ports {

-- 
2.40.1


