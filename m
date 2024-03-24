Return-Path: <linux-kernel+bounces-115646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091EE889D06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3292A4A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E6D2072DC;
	Mon, 25 Mar 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmMXv9nE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D2206CAA;
	Sun, 24 Mar 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321515; cv=none; b=gjgQ5swmdiZGxfhTZS/fny7xvVwh2mZClO6dfdA/CSGTtIEevWLdDKOpEYwMB0OE/awOwIuPCQsiscnkTLwDbUMuQ+SRx0gwvWIq7VIVyUMLnRr34cM3g18kFgkpF9Z1GsOPErd8SWNY4eTpMkNMAT6YP1m0WdiBR+N+ViwuodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321515; c=relaxed/simple;
	bh=kzg1twyd8x1xKB2wbJO5YxL9YZinLAhgSRISrH4vxlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8ucLWl6LYPnG1oWoM7y5MmpFZUli5xm8ULO/yYhNIU0YFBpWZzEXH9XUjd9pU486SA66amSWh9G6ACEypY48ctlVH0VQVkIhqlo47pGdizWwRdfCjW+rpAA+YfvWh/zy65WWu935kLKzfzJeTBKI6MlgrwQQLNDD8DEcGV+qmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmMXv9nE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7ECC433F1;
	Sun, 24 Mar 2024 23:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321514;
	bh=kzg1twyd8x1xKB2wbJO5YxL9YZinLAhgSRISrH4vxlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmMXv9nEkj2QOHEOQ3figCBwvRWFiFuqMxRnSOyVF/Iv2hzMD+5V8QX9BVL3eX3fH
	 kOd2ejVHNiKkKo0yd4KNk3jLtdP0TL1v0JSFjIIhC1vCG6iqL2JNG7D0c1ZvGtI8ZN
	 X68L4vdAjrVyU0LXI9C9yX9v+Ygz1dQ0l6Dor3CAtl4ZxMZXXKbC6i7T5BYteLX7gV
	 08oOTD/Ir5ccgLiVUF6fm6AbaITGb3LBL5wKLqxWQUAVrezEHxZEmqFSM1obswIIA+
	 Ii2zY4hGGVAze01oqe30KBP6igSdKuix1zpmC3vb48R+SC5JeFQ3++nikfkocyMTA5
	 2oR21903TzRrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 241/638] arm64: dts: ti: k3-am642-sk: Add boot phase tags marking
Date: Sun, 24 Mar 2024 18:54:38 -0400
Message-ID: <20240324230116.1348576-242-sashal@kernel.org>
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

From: Nishanth Menon <nm@ti.com>

[ Upstream commit 4669288219a7f77c6ff992d10ce6a20660863979 ]

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to describe various node usage during
boot phases with DT.

Describe the same for AM642-sk boot devices.

Signed-off-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20230911172902.1057417-4-nm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Stable-dep-of: 379c7752bbd0 ("arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 722fd285a34ec..f29c8a9b59ba7 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -34,6 +34,7 @@ aliases {
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -107,6 +108,7 @@ rtos_ipc_memory_region: ipc-memories@a5000000 {
 
 	vusb_main: regulator-0 {
 		/* USB MAIN INPUT 5V DC */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vusb_main5v0";
 		regulator-min-microvolt = <5000000>;
@@ -117,6 +119,7 @@ vusb_main: regulator-0 {
 
 	vcc_3v3_sys: regulator-1 {
 		/* output of LP8733xx */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -128,6 +131,7 @@ vcc_3v3_sys: regulator-1 {
 
 	vdd_mmc1: regulator-2 {
 		/* TPS2051BD */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -234,6 +238,7 @@ led-7 {
 
 &main_pmx0 {
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x029c, PIN_INPUT_PULLUP, 0) /* (C20) MMC1_SDWP */
 			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0) /* (D19) MMC1_SDCD */
@@ -248,6 +253,7 @@ AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0) /* (K18) MMC1_DAT3 */
 	};
 
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -257,6 +263,7 @@ AM64X_IOPAD(0x0234, PIN_OUTPUT, 0) /* (C16) UART0_TXD */
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0248, PIN_INPUT, 0) /* (D16) UART1_CTSn */
 			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0) /* (E16) UART1_RTSn */
@@ -266,12 +273,14 @@ AM64X_IOPAD(0x0244, PIN_OUTPUT, 0) /* (E14) UART1_TXD */
 	};
 
 	main_usb0_pins_default: main-usb0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
@@ -279,6 +288,7 @@ AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
@@ -367,6 +377,7 @@ AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -375,12 +386,14 @@ &main_uart0 {
 
 &main_uart1 {
 	/* main_uart1 is reserved for firmware usage */
+	bootph-pre-ram;
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -393,12 +406,14 @@ eeprom@51 {
 };
 
 &main_i2c1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 
 	exp1: gpio@70 {
+		bootph-all;
 		compatible = "nxp,pca9538";
 		reg = <0x70>;
 		gpio-controller;
@@ -445,6 +460,7 @@ wlcore: wlcore@2 {
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
@@ -454,11 +470,22 @@ &sdhci1 {
 };
 
 &serdes_ln_ctrl {
+	bootph-all;
 	idle-states = <AM64_SERDES0_LANE0_USB>;
 };
 
+&serdes_refclk {
+	bootph-all;
+};
+
+&serdes_wiz0 {
+	bootph-all;
+};
+
 &serdes0 {
+	bootph-all;
 	serdes0_usb_link: phy@0 {
+		bootph-all;
 		reg = <0>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
@@ -468,10 +495,12 @@ serdes0_usb_link: phy@0 {
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "host";
 	maximum-speed = "super-speed";
 	pinctrl-names = "default";
-- 
2.43.0


