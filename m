Return-Path: <linux-kernel+bounces-92411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C528871FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8DD1C2025B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905068593F;
	Tue,  5 Mar 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPV8xyeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAAB8564E;
	Tue,  5 Mar 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644539; cv=none; b=i97qzP5dtdmk1d9sl0lg2RYC+YOF9Pc8Eixm6L/Ll8pa9ay8fcSL/hx1lWIoAtIOD36ChxWrwWFlP2fDJQm8GYhO4SGeVuTTgN3CRAlxgALbbpGc0u53tM1cRcUuyFw/yQTcj+rluWsa/G4IUrL9QF6QOdnnFo9UJD6RJs47KfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644539; c=relaxed/simple;
	bh=8tP3wCMPCsdXXn25KkEtrRY7OMIA16TK2ToN5XCATSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aNP0e+rd0dFnWVq7cHtddDypZa1gYh4c4+CPo76Lh9Oq9J74siW1mVfl6jiYN1MLtMjo0JVmaNScaazJGx5WQBAZwcJhco+LX/ykKIAafCuLunRwNN+EMdGQafnpCkJiwh9U8sTjKZmaW+Yx8aBxiHFn8VgF3BPuej6g827AMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPV8xyeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F97C433C7;
	Tue,  5 Mar 2024 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709644539;
	bh=8tP3wCMPCsdXXn25KkEtrRY7OMIA16TK2ToN5XCATSo=;
	h=From:Date:Subject:To:Cc:From;
	b=VPV8xyeMLMmIJGduUhWpn0Mjz7d7p2Y9WUfVmCMQ4a5IMCg0lPiWt+CzAZFQFBKpV
	 oWcznsV5IpOMUOokrRVEd6M0VWyDXHd7ZLzvE81RMx5fqToOvQIty/BbuTA1xWUalc
	 LatrrogV+LrdWXkF/2FNRfOh4h9NVhw1qhKNdMxhrZWpFEN5NKHrAPIlRHgAkngbjU
	 ZTYWblkbap5PZGWQchlOJFV87x9OzSUq0As/ChIp8hgQCfSFX2ypBF878Y5w71qIwx
	 9zqORrlaQ4uQkaf+SMpi7CCHyMEtaXjttAqdjjcFnpmDctaXTqyBcEW9iuyMFERbNz
	 d7FESp1WvxytA==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 05 Mar 2024 15:15:32 +0200
Subject: [PATCH v2] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET
 GPIOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-b4-for-v6-9-am65-beagleplay-ethernet-reset-v2-1-2bf463a7bf13@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPMa52UC/52NSwqDMBRFtyIZ9xXz8TvqPoqDpL5oqDXyIqEi7
 r3RJXRy4dwL9+wsIDkMrM12RhhdcH5OIG4Ze416HhBcn5iJXKhciAaMAusJYgkN6E9ZgEE9TLh
 MegNcR6QZVyAMKfOmtqJS1lhesHS4EFr3vWTPLvHowuppu9yRn+1fmsiBg5GojJSyqk3/eJ/zd
 Pc0sO44jh8eEEt05QAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=8tP3wCMPCsdXXn25KkEtrRY7OMIA16TK2ToN5XCATSo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl5xr4Y1Wf/CKyiKt/McPopCDoLfwA/bR7/olM2
 +1LbVG2fc+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZeca+AAKCRDSWmvTvnYw
 k0jdD/9XyfwFTOU65Lg7qS2xN+1cjifVs6TkQ3yi+Oruu59Zb1BlglUJOYq2iEyShQHQNjJax0j
 EUGW6IyXydOsH+SpkQFY2zTI6npW8z0XLKrDGRmX976iaUV3/6WpBfO4wsGhMIS22kKApeoRn3H
 Zy09tVPOFVMla73kvnDbHbitV3NY1/S4azLaWdxeRorXr91OTP+GBj0j6rJ9xmYu7ywHv37Xbrl
 XEjMPt+AQoWNIV25mOpOY12gTpmZUhn/4WPUS6yfwQWOIjjN772t2Vyi+zU+kz42RGNcc4NfMSA
 TvOxhscyjD4T+KwNfieu6+WDdIxI8bHbdi3TKweDjmgwR8/yDTGZYUaPTRQIwpbAI9jrvC3/otO
 ulBetqJEJlhEETI4rSP6n2EtJBfJcxUg1xqtr+Ksq5gaLU8lYaRob8pgxuh9SF0a9zPnk32OCNa
 JKHhHGHmrlKHFnDQ1bh05DFUx/295HxnDVJcb/gXLPbszdXC/h8nO2M6No9NyzLCOL6TJh0/DdC
 2St4CCyXMDYkyu0Zz1zEw4kswTQQhOJwYrhL/xk65girmWLSqcig6j1GRlFpCHQs+fcJMx2sbeh
 80v8nAmkoZ/cmEilX2AlzfY2VJRa6HGSvxxuCcCGnP+32UW7uIkDiG8k+1RdnFP5TbUIE0diTmq
 zOExkrlyZeocAwQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The RESET GPIO pinmux should be part of MDIO bus node
so that they can be in the right state before the PHY
can be probed via MDIO bus scan.

The GPIO pin should be setup with PIN_INPUT so that
input circuitry is enabled in case software wants to
check pin status. Without this, incorrect status is shown
in /sys/kernel/debug/gpio.

Add GPIO reset for the Gigabit Ethernet PHY. As per
RTL8211F datasheet, reset assert width is 10ms and
PHY registers can be access accessed after 50ms of
reset deassert.

Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v2:
- Fix Subject to "arm64"
- Enable PIN_INPUT for SPE_RESET to fix GPIO status.
- Add Fixes tag.
- Link to v1: https://lore.kernel.org/r/20240229-b4-for-v6-9-am65-beagleplay-ethernet-reset-v1-1-b3e4b33378bd@kernel.org
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index a34e0df2ab86..8ab838f1697c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -292,6 +292,8 @@ mdio0_pins_default: mdio0-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
 			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
+			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */
+			AM62X_IOPAD(0x018c, PIN_INPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
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


