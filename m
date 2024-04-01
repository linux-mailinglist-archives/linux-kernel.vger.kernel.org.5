Return-Path: <linux-kernel+bounces-126726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318E893C01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAEC281CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACD4D5BF;
	Mon,  1 Apr 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL7KOISN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F04D5BD;
	Mon,  1 Apr 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980669; cv=none; b=cvEVy95N6KxAFvyheZ6kzZ4q6aNzUJpqfjCZ9a8uyVCdJwyiQgYt68hnamy6Dn/FmcbWk4D1785xBK2+WH3E3w5hEPGkgWiaLhUE98WSwtCyeHv5TZf4abd0EIYoGpnD91qF8haV704p+d8gjG9OS3c6o2KSibQFKQFgLqaS7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980669; c=relaxed/simple;
	bh=TWtkKBNKGQJXqiB2m6YLtgtLHHPPEXBxvQ265f0XEis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8eLzqvX7KHZmYzPhddScxxmAAkEw1kO3C21ymaA5vBDauWamA2ZY7U0ZqRNQmV61kxRA8MovufPWx+A22P9aShZ0O6uV7BiRJl5irto0nApAFKFIoDfK3oMk+d9/9W2kUVF6vZbSlMN0jIBfP82rSp9ShIq5HBROw+rdIZmoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL7KOISN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61227C43601;
	Mon,  1 Apr 2024 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980668;
	bh=TWtkKBNKGQJXqiB2m6YLtgtLHHPPEXBxvQ265f0XEis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AL7KOISNznBIC3hywBX3CJtAo23rZ9AzQRDp32X5VW4Z+yDvav1w0YKK8c5fP8cbX
	 R6UBs3xLxcWtf69f5adruRlOpDJF1qRCwaev7NWg4XUbh2DQktz/hjYkfgtbhb6bOF
	 Rpkvol15tzxKKj1uCHoHDvx3zkI2vtsae1trbBaxcDahoEKbsmg5+Nk+b48eVA/z88
	 lmrNAaEXreg6prMqNNXr9n7qezdYnNCYD2aLX0qVTFqI3ZTUUVydqUucVRWt2EC2S6
	 BAEsaFVsNNGuuPou5OEzo+FcmDhh91GwRbp6o22Lru2FUQWfd00NEkiHQCkHup+X3Y
	 8lR5E3X67TIQQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/6] arm64: dts: marvell: cn9130-db: drop wrong unit-addresses
Date: Mon,  1 Apr 2024 16:10:49 +0200
Message-Id: <20240401141051.98233-4-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141051.98233-1-krzk@kernel.org>
References: <20240401141051.98233-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Top-level nodes, not being on MMIO bus, do not have "reg" properties and
should not have unit addresses.  Correct their name as well to match
"Generic node names" recommendation from Devicetree specification.
This also fixes dtc W=1 warnings:

  cn9130-db.dtsi:28.11-31.4: Warning (unique_unit_address_if_enabled): /memory@0: duplicate unit-address (also used in node /ap0_sd_vccq@0)
  cn9130-db.dtsi:28.11-31.4: Warning (unique_unit_address_if_enabled): /memory@0: duplicate unit-address (also used in node /cp0_usb3_vbus@0)
  cn9130-db.dtsi:33.33-40.4: Warning (unique_unit_address_if_enabled): /ap0_sd_vccq@0: duplicate unit-address (also used in node /cp0_usb3_vbus@0)
  cn9130-db.dtsi:28.11-31.4: Warning (unique_unit_address_if_enabled): /memory@0: duplicate unit-address (also used in node /cp0_usb3_phy@0)
  cn9130-db.dtsi:33.33-40.4: Warning (unit_address_vs_reg): /ap0_sd_vccq@0: node has a unit name, but no reg or ranges property
  cn9130-db.dtsi:42.38-49.4: Warning (unit_address_vs_reg): /cp0_usb3_vbus@0: node has a unit name, but no reg or ranges property
  cn9130-db.dtsi:51.34-54.4: Warning (unit_address_vs_reg): /cp0_usb3_phy@0: node has a unit name, but no reg or ranges property
  cn9130-db.dtsi:56.38-63.4: Warning (unit_address_vs_reg): /cp0_usb3_vbus@1: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi |  6 +++---
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi | 12 ++++++------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index 01d6645ddba7..be56a2336265 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -30,7 +30,7 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	ap0_reg_sd_vccq: ap0_sd_vccq@0 {
+	ap0_reg_sd_vccq: regulator-1 {
 		compatible = "regulator-gpio";
 		regulator-name = "ap0_sd_vccq";
 		regulator-min-microvolt = <1800000>;
@@ -39,7 +39,7 @@ ap0_reg_sd_vccq: ap0_sd_vccq@0 {
 		states = <1800000 0x1 3300000 0x0>;
 	};
 
-	cp0_reg_usb3_vbus0: cp0_usb3_vbus@0 {
+	cp0_reg_usb3_vbus0: regulator-2 {
 		compatible = "regulator-fixed";
 		regulator-name = "cp0-xhci0-vbus";
 		regulator-min-microvolt = <5000000>;
@@ -48,12 +48,12 @@ cp0_reg_usb3_vbus0: cp0_usb3_vbus@0 {
 		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	cp0_usb3_0_phy0: cp0_usb3_phy@0 {
+	cp0_usb3_0_phy0: usb-phy-1 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp0_reg_usb3_vbus0>;
 	};
 
-	cp0_reg_usb3_vbus1: cp0_usb3_vbus@1 {
+	cp0_reg_usb3_vbus1: regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "cp0-xhci1-vbus";
 		regulator-min-microvolt = <5000000>;
@@ -62,12 +62,12 @@ cp0_reg_usb3_vbus1: cp0_usb3_vbus@1 {
 		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
 	};
 
-	cp0_usb3_0_phy1: cp0_usb3_phy@1 {
+	cp0_usb3_0_phy1: usb-phy-2 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp0_reg_usb3_vbus1>;
 	};
 
-	cp0_reg_sd_vccq: cp0_sd_vccq@0 {
+	cp0_reg_sd_vccq: regulator-4 {
 		compatible = "regulator-gpio";
 		regulator-name = "cp0_sd_vccq";
 		regulator-min-microvolt = <1800000>;
@@ -77,7 +77,7 @@ cp0_reg_sd_vccq: cp0_sd_vccq@0 {
 			  3300000 0x0>;
 	};
 
-	cp0_reg_sd_vcc: cp0_sd_vcc@0 {
+	cp0_reg_sd_vcc: regulator-5 {
 		compatible = "regulator-fixed";
 		regulator-name = "cp0_sd_vcc";
 		regulator-min-microvolt = <3300000>;
@@ -87,7 +87,7 @@ cp0_reg_sd_vcc: cp0_sd_vcc@0 {
 		regulator-always-on;
 	};
 
-	cp0_sfp_eth0: sfp-eth@0 {
+	cp0_sfp_eth0: sfp-eth-1 {
 		compatible = "sff,sfp";
 		i2c-bus = <&cp0_sfpp0_i2c>;
 		los-gpios = <&cp0_module_expander1 11 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
index 8f2523786cfb..ad7360c83048 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -18,7 +18,7 @@ aliases {
 		ethernet4 = &cp1_eth1;
 	};
 
-	cp1_reg_usb3_vbus0: cp1_usb3_vbus@0 {
+	cp1_reg_usb3_vbus0: regulator-6 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&cp1_xhci0_vbus_pins>;
@@ -29,12 +29,12 @@ cp1_reg_usb3_vbus0: cp1_usb3_vbus@0 {
 		gpio = <&cp1_gpio1 3 GPIO_ACTIVE_HIGH>;
 	};
 
-	cp1_usb3_0_phy0: cp1_usb3_phy0 {
+	cp1_usb3_0_phy0: usb-phy-3 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp1_reg_usb3_vbus0>;
 	};
 
-	cp1_sfp_eth1: sfp-eth1 {
+	cp1_sfp_eth1: sfp-eth-2 {
 		compatible = "sff,sfp";
 		i2c-bus = <&cp1_i2c0>;
 		los-gpios = <&cp1_gpio1 11 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
index 512a4fa2861e..e753cfdac697 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
@@ -17,7 +17,7 @@ aliases {
 		ethernet5 = &cp2_eth0;
 	};
 
-	cp2_reg_usb3_vbus0: cp2_usb3_vbus@0 {
+	cp2_reg_usb3_vbus0: regulator-7 {
 		compatible = "regulator-fixed";
 		regulator-name = "cp2-xhci0-vbus";
 		regulator-min-microvolt = <5000000>;
@@ -26,12 +26,12 @@ cp2_reg_usb3_vbus0: cp2_usb3_vbus@0 {
 		gpio = <&cp2_gpio1 2 GPIO_ACTIVE_HIGH>;
 	};
 
-	cp2_usb3_0_phy0: cp2_usb3_phy0 {
+	cp2_usb3_0_phy0: usb-phy-4 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp2_reg_usb3_vbus0>;
 	};
 
-	cp2_reg_usb3_vbus1: cp2_usb3_vbus@1 {
+	cp2_reg_usb3_vbus1: regulator-8 {
 		compatible = "regulator-fixed";
 		regulator-name = "cp2-xhci1-vbus";
 		regulator-min-microvolt = <5000000>;
@@ -40,12 +40,12 @@ cp2_reg_usb3_vbus1: cp2_usb3_vbus@1 {
 		gpio = <&cp2_gpio1 3 GPIO_ACTIVE_HIGH>;
 	};
 
-	cp2_usb3_0_phy1: cp2_usb3_phy1 {
+	cp2_usb3_0_phy1: usb-phy-5 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp2_reg_usb3_vbus1>;
 	};
 
-	cp2_reg_sd_vccq: cp2_sd_vccq@0 {
+	cp2_reg_sd_vccq: regulator-9 {
 		compatible = "regulator-gpio";
 		regulator-name = "cp2_sd_vcc";
 		regulator-min-microvolt = <1800000>;
@@ -54,7 +54,7 @@ cp2_reg_sd_vccq: cp2_sd_vccq@0 {
 		states = <1800000 0x1 3300000 0x0>;
 	};
 
-	cp2_sfp_eth0: sfp-eth0 {
+	cp2_sfp_eth0: sfp-eth-3 {
 		compatible = "sff,sfp";
 		i2c-bus = <&cp2_sfpp0_i2c>;
 		los-gpios = <&cp2_module_expander1 11 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


