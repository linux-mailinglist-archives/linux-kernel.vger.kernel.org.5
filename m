Return-Path: <linux-kernel+bounces-154814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEFD8AE15A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944A7287AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422660DCF;
	Tue, 23 Apr 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di/JyNso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E55D8E4;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865860; cv=none; b=q9+gHU6Jljr9rnexsbQzmVgxUUspuwF3Q6eevltyST2pirp/KP4J9HuaSJChPUtfxIm79gOtcXhNAPuJO6HR8/7iZIfUXV+CQ/jR40BUsB1KHK+x/vPc9LCogvmtBEcvP/EFrLZVbzxSW1unNu1H4QoK2IHdkPIZnQM2wgFaw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865860; c=relaxed/simple;
	bh=RonRZhOuFd4FZR72ZlEGahew6p/6xifPhjtBZhvCVw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENGu9Qe/WG5AtfQPEJoKOLfK+qmtUrOtokSm22hWWDvqdI0yWsuXxwYvq8ceD20yoK+72IT+C0mVMMaJqlSZpoSpECXwN9HUSqCjBY5cvMwRramb3pcnNFh7J1S0YOVTYX2obmprZ6aZDGKWAUcjMIZ1bwZzuD1n4lG7zNB55FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di/JyNso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 313BBC4AF0F;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865860;
	bh=RonRZhOuFd4FZR72ZlEGahew6p/6xifPhjtBZhvCVw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=di/JyNsoxsIwgIOZTUCfH5Oc9I684En/J4R8V+inZmpuMhZbYVYZTsAqoewGy5mgx
	 8uah7YllM/TX5uVnToZB7oarz4PW/J3ySlPgYofuznuyp0gprrNcwwUtIPPjnZLXi7
	 Dfs3FM3pWpXBj4BIl0ksrzUJt2ex/+V+5LL9cLZqkz25GCL5FJXkp77LG5bwTiIzAI
	 lWInihCOPFugSkSHFU7HD1t6Dr139fjskLyCA6MKFL4warXEq6pc/1y844D8S1+dK0
	 As6Dg26oou6QwuNW0jcM5ebkhwyVP/gEq2WY4AMFbmhKqyBmLXLz2ddIlhwZWndp0c
	 WbbKwxkA+QrJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231CFC16B13;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 23 Apr 2024 12:50:49 +0300
Subject: [PATCH v3 5/5] ARM: dts: BCM5301X: Conform to DTS Coding Style on
 ASUS RT-AC3100 & AC88U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-5-23d33cfafe7a@arinc9.com>
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713865858; l=5167;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=7L5W/7z1WpF8NCI8e+TnYZn6sscmCDy3pZyH1HtB4TY=;
 b=4cWPEzSSJNXKt801p2f2aFZ9J2U7DbqJ4jQ8ThzSDmM9xJDRIqCbAwmOM0n2jKuiLGogoEkL7
 f2X06SHj9LLCKUxF+booXR8f0cfre9vQuL/W7a6fF8aEuW51Rqovoe8
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Reorder the nodes and properties to conform to the Devicetree Sources (DTS)
Coding Style.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi | 92 +++++++++++-----------
 .../boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts   | 69 ++++++++--------
 2 files changed, 80 insertions(+), 81 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
index 9c7efb1c44f1..2cfaaabc7a6a 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
@@ -10,9 +10,9 @@
 
 / {
 	memory@0 {
-		device_type = "memory";
 		reg = <0x00000000 0x08000000>,
 		      <0x88000000 0x18000000>;
+		device_type = "memory";
 	};
 
 	nvram@1c080000 {
@@ -20,6 +20,34 @@ nvram@1c080000 {
 		reg = <0x1c080000 0x00180000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-led {
+			label = "Backlight";
+			linux,code = <KEY_BRIGHTNESS_ZERO>;
+			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
+		};
+
+		button-reset {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wifi {
+			label = "Wi-Fi";
+			linux,code = <KEY_RFKILL>;
+			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -66,32 +94,29 @@ led-wps {
 			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
 		};
 	};
+};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		button-led {
-			label = "Backlight";
-			linux,code = <KEY_BRIGHTNESS_ZERO>;
-			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
-		};
+&nandcs {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-		button-reset {
-			label = "Reset";
-			linux,code = <KEY_RESTART>;
-			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		partition@0 {
+			reg = <0x00000000 0x00080000>;
+			label = "boot";
+			read-only;
 		};
 
-		button-wifi {
-			label = "Wi-Fi";
-			linux,code = <KEY_RFKILL>;
-			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
+		partition@80000 {
+			reg = <0x00080000 0x00180000>;
+			label = "nvram";
 		};
 
-		button-wps {
-			label = "WPS";
-			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
+		partition@200000 {
+			compatible = "brcm,trx";
+			reg = <0x00200000 0x07e00000>;
+			label = "firmware";
 		};
 	};
 };
@@ -141,28 +166,3 @@ &usb2 {
 &usb3_phy {
 	status = "okay";
 };
-
-&nandcs {
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			label = "boot";
-			reg = <0x00000000 0x00080000>;
-			read-only;
-		};
-
-		partition@80000 {
-			label = "nvram";
-			reg = <0x00080000 0x00180000>;
-		};
-
-		partition@200000 {
-			label = "firmware";
-			reg = <0x00200000 0x07e00000>;
-			compatible = "brcm,trx";
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
index c78f0c7b137d..a197f447fd97 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
@@ -19,13 +19,34 @@ et1macaddr: et1macaddr {
 
 	switch {
 		compatible = "realtek,rtl8365mb";
-		/* 7 = MDIO (has input reads), 6 = MDC (clock, output only) */
 		mdc-gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
 		mdio-gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 		realtek,disable-leds;
 		dsa,member = <1 0>;
 
+		mdio {
+			compatible = "realtek,smi-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethphy0: ethernet-phy@0 {
+				reg = <0>;
+			};
+
+			ethphy1: ethernet-phy@1 {
+				reg = <1>;
+			};
+
+			ethphy2: ethernet-phy@2 {
+				reg = <2>;
+			};
+
+			ethphy3: ethernet-phy@3 {
+				reg = <3>;
+			};
+		};
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -69,29 +90,21 @@ fixed-link {
 				};
 			};
 		};
+	};
+};
 
-		mdio {
-			compatible = "realtek,smi-mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			ethphy0: ethernet-phy@0 {
-				reg = <0>;
-			};
-
-			ethphy1: ethernet-phy@1 {
-				reg = <1>;
-			};
+&gmac0 {
+	status = "disabled";
+};
 
-			ethphy2: ethernet-phy@2 {
-				reg = <2>;
-			};
+&gmac1 {
+	nvmem-cells = <&et1macaddr 0>;
+	nvmem-cell-names = "mac-address";
+};
 
-			ethphy3: ethernet-phy@3 {
-				reg = <3>;
-			};
-		};
-	};
+&gmac2 {
+	nvmem-cells = <&et1macaddr 1>;
+	nvmem-cell-names = "mac-address";
 };
 
 &srab {
@@ -112,17 +125,3 @@ fixed-link {
 		};
 	};
 };
-
-&gmac0 {
-	status = "disabled";
-};
-
-&gmac1 {
-	nvmem-cells = <&et1macaddr 0>;
-	nvmem-cell-names = "mac-address";
-};
-
-&gmac2 {
-	nvmem-cells = <&et1macaddr 1>;
-	nvmem-cell-names = "mac-address";
-};

-- 
2.40.1



