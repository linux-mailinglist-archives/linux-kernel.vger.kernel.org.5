Return-Path: <linux-kernel+bounces-87072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97E86CF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0390828683E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9863113;
	Thu, 29 Feb 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZLgHfHd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F26CBF7;
	Thu, 29 Feb 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223933; cv=none; b=for3YRKMW2tTI9C7DE/lyDmcs0d67qoHul+28CVEkBzABa+tarCSWbnHfRcuGNpVvTIchm0OqEIuu4T4dmu60bGEvyFCLZayk+Ck5GV/OFxEzrH5j2h+sb+uGQaJqmYCodWDs9AWyV0ryVDVo+po+x7UaOd16DuOrcsFGwG1a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223933; c=relaxed/simple;
	bh=4V6OlYJLg2D2ADjTGoW0ZIdepDQib6cN9BnQe1KUkgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JCo52qIJePbn8e2k6faIoPGlqAO590WulPvjPx/SDbNogLiLSDimBy8CV17JbixL486G6nlRPScD9lPSadZHWkAI3haQu8g9xltuLC6684kDsjpDNWlIwcc+KiQ4M2/6koW8d048H23Q2nOGf0esH0T+bE10Qa7SUsr87M5jgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZLgHfHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AC6C43390;
	Thu, 29 Feb 2024 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709223932;
	bh=4V6OlYJLg2D2ADjTGoW0ZIdepDQib6cN9BnQe1KUkgs=;
	h=From:Date:Subject:To:Cc:From;
	b=GZLgHfHdzSDZATOabNXnku51/DMdtbXNqg834eIQlRHMbJQpyTu6bJ0it32ln7Czg
	 L05lK4XjI5X4JlUOw13U9MsSSddCRxXuNu1mFijtMjYA6QMf26fWcR44aYpKnFUEft
	 +O5itxPPnZy1pM3Nf3/V04FkkolCy/vhv2lY9OPlNORMnvte+FWgVDJCiZ85TvgqZz
	 xPX8FAQcIGtYdOYBKG4PWvaxXI1qPqoLvwStoGVw5X+Rz3th/LsfwuGM5W6IeX+9PW
	 pfoCnrnCDf4UZqwXi7Npfyv2vJYmTFhPUEddeEV0AjWcUya6DQQ1g8Ju3k3FxraEe2
	 u0sv5w3ZU+xAQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 29 Feb 2024 18:25:15 +0200
Subject: [PATCH] arm: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOqv4GUC/x2NwQqDMBAFf0X23IUYom36K8VD0r7ogo2yEWkR/
 72hl4G5zBxUoIJC9+YgxS5FllylvTT0nEIewfKqTtZYZ6z1HB2nRXnv2XN49x1HhHHGOocvY5u
 gGRsrSqXxt2SvLsXUdlSDqyLJ5z97DOf5A+0w5wt8AAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=4V6OlYJLg2D2ADjTGoW0ZIdepDQib6cN9BnQe1KUkgs=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl4K/5VGgg0Szc8M2O7/ORpqD/Is7v/MAK0hNAO
 yZN9iblCjmJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZeCv+QAKCRDSWmvTvnYw
 kzl2D/9BPFAtmkgiacpXSs1V3058PyDLc+ehcKlCemroF4/f1teoqbZVV617xHmdgtCQgmlstNC
 JBAlD2bzSDeM3X+Lb5/6X1bVqDripAj6Co8mhJAE9BumkI0Vdi2kVel/H+tqQkwlCnzOHYT/Gfj
 9sYYYXxP+IBJSkIqTw+QzLNqD24ya0wDNEj4LrYeqoBqsslyDKNN/tc4qyi6dWx0MH940sg2PUX
 qi/1pBxm7Cj0t5ddFkOeI7T2wsyGWfV2LrnnBSKvx0tht9DV0R1oWlPqL131uIv6oMpfuh0RB2M
 E+JFpytxkdL5YEpQKSLTWt+GRYDUWKBgvUW6w0LeGKvAAlgH2qdsmebSwQZ5NdIiHbJm8eAsfbJ
 9sIuvLQAwk05bXyoJLPJKj5ja68OCqoPF2hxU0qQ9PY9JoXi+MJ2wMxdIePPzn/M/bW6kESnb5B
 3qSD8/A6blQhAmwMEX0V356MuSYYN/dbl3jlWH/HNh9+37GELCz5QLwmodKlJKiHCDvJ1UVhOD/
 PLrIhVWmFyB5OMTbCRQYvRG3qsORdw3b9ORDhtU6qlXsClRfmazCqcD0OmdJ3Gkf/EJw+LcJjJv
 Ox55dQtwV+5Y9KJvkc2MUj17IaEaSQTKI9sxhegOortp/djLKE/z8oXQgGHOaHD2lf0NIV1Hg4k
 4gJ84c1Rye+34fg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The RESET GPIO pinmux should be part of MDIO bus node
so that they can be in the right state before the PHY
can be probed via MDIO bus scan.

Add GPIO reset for the Gigabit Ethernet PHY. As per
RTL8211F datasheet, reset assert width is 10ms and
PHY registers can be access accessed after 50ms of
reset deassert.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index a34e0df2ab86..77240cf3ae4d 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -292,6 +292,8 @@ mdio0_pins_default: mdio0-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
 			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
+			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */
+			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
 		>;
 	};
 
@@ -383,7 +385,6 @@ AM62X_IOPAD(0x017c, PIN_INPUT, 1) /* (AD22) RGMII2_RX_CTL.RMII2_RX_ER */
 			AM62X_IOPAD(0x016c, PIN_INPUT, 1) /* (Y18) RGMII2_TD0.RMII2_TXD0 */
 			AM62X_IOPAD(0x0170, PIN_INPUT, 1) /* (AA18) RGMII2_TD1.RMII2_TXD1 */
 			AM62X_IOPAD(0x0164, PIN_INPUT, 1) /* (AA19) RGMII2_TX_CTL.RMII2_TX_EN */
-			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
 			AM62X_IOPAD(0x0190, PIN_INPUT, 7) /* (AE22) RGMII2_RD3.GPIO1_6 */
 			AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
 		>;
@@ -597,6 +598,9 @@ &cpsw3g_mdio {
 
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
+		reset-gpios = <&main_gpio0 15 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <50000>;
 	};
 
 	cpsw3g_phy1: ethernet-phy@1 {
@@ -615,7 +619,7 @@ &main_gpio0 {
 		"USR0", "USR1", "USR2", "USR3", "", "", "USR4",	/* 3-9 */
 		"EEPROM_WP",					/* 10 */
 		"CSI2_CAMERA_GPIO1", "CSI2_CAMERA_GPIO2",	/* 11-12 */
-		"CC1352P7_BOOT", "CC1352P7_RSTN", "", "", "",	/* 13-17 */
+		"CC1352P7_BOOT", "CC1352P7_RSTN", "GBE_RSTN", "", "",	/* 13-17 */
 		"USR_BUTTON", "", "", "", "", "", "", "", "",	/* 18-26 */
 		"", "", "", "", "", "", "", "", "", "HDMI_INT",	/* 27-36 */
 		"", "VDD_WLAN_EN", "", "", "WL_IRQ", "GBE_INTN",/* 37-42 */

---
base-commit: bbef42084cc170cbfc035bf784f2ff055c939d7e
change-id: 20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-098f274fbf15

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


