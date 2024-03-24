Return-Path: <linux-kernel+bounces-114143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0F8888B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF771F29D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605024340F;
	Sun, 24 Mar 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp45FfEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6165203711;
	Sun, 24 Mar 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321453; cv=none; b=hjlVBhHUP5+1DqvSHbbx33dHuaiBs6yMDiiwROJkwT6DcBvD5zRb3N3pM21atHhdI5Kh+WSs9B2NILMqtCbnQ+9oqTk4MF9a4YyOG35nB5juo02WU1sC9XbWAQN2Wk+2IldTYapxkH+tB+yzJq0XeXawui9+jjhUUM7ipFry+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321453; c=relaxed/simple;
	bh=zEegwztfvavh3excM3TsgOKOv2GUzxn/1hJX6yd3sK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ta07rrpfmiLefoWNWr2zE6PQ14DCk6qzjAGFhVDmWetkMK9Af3kkAQIWnC82P/0u2IK1KzRX26vbxaHEIJuSqLEwOuTDYS2cpCiwYAHP3FFqVDbuog0YJQ6YOQC9UdLWs4VXt+JX3ERwlNlfitL7r5zqFQUdtk7mYZCSAa1tSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp45FfEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20491C433F1;
	Sun, 24 Mar 2024 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321452;
	bh=zEegwztfvavh3excM3TsgOKOv2GUzxn/1hJX6yd3sK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sp45FfEvaADq7VASkhJ+vSkg5IsRQd7FynjLTDTBaHlz3amekWzNEINxQoKg3IzuL
	 x1mz2XCaZNC+zYiHXWdjjg3y9WA6sqw4vmmPSF3jev6h1/14DLcFzRiQdvfGWfR92j
	 WbpGpWlz16il8CsPDdNDdfaFKDnxnmCs2lQTJFvh/3JP1OZdGZ7iHjuUHpUrUGdsJA
	 51iZor/MdTWm+cYiVl0aGm8Z4LUThenrkRKq5LcUZASXtX9EFezOkMnomtSQdKF+Zw
	 mudMQnyMAvSAo90T18FyiCQd8Y2nX95y2ck5rMLQMcwU21e/nlDoRr00NG2fMPNtQC
	 ZSpAzG37ytciw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 177/638] arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
Date: Sun, 24 Mar 2024 18:53:34 -0400
Message-ID: <20240324230116.1348576-178-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tim Harvey <tharvey@gateworks.com>

[ Upstream commit ec2cb52fcfef5d58574f2cfbc9a99ffc20ae5a9d ]

The GW71xx does not have a gpio controlled vbus regulator but it does
require some pinctrl. Remove the regulator and move the valid pinctrl
into the usbotg1 node.

Fixes: bd306fdb4e60 ("arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   | 29 ++++++-------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
index 0ce60ad9c7d50..26d4afdbca6f4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -47,17 +47,6 @@ pps {
 		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb1_en>;
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg1_vbus";
-		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
 };
 
 /* off-board header */
@@ -145,9 +134,10 @@ &uart3 {
 };
 
 &usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	dr_mode = "otg";
 	over-current-active-low;
-	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
 };
 
@@ -205,14 +195,6 @@ MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
 		>;
 	};
 
-	pinctrl_reg_usb1_en: regusb1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10	0x41
-			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x141
-			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
-		>;
-	};
-
 	pinctrl_spi2: spi2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
@@ -235,4 +217,11 @@ MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
 			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
 		>;
 	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x141
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
+		>;
+	};
 };
-- 
2.43.0


