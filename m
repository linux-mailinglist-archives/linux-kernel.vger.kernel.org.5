Return-Path: <linux-kernel+bounces-154811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B192E8AE159
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59F01C222B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A526604CE;
	Tue, 23 Apr 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCUsaGjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5605914C;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865860; cv=none; b=iOIK0K7JhMRVRXzlswHXmFpL85Xn0l6JzCgtjxhNEPIwJEkArefXbakGTQ7GYExnKZnNbp4WOVPWXuezgW/QdOdTMcWDipkrY/wg2+zHoC12iXoVEfysjT9UDa3xnn52AkahqK3lbp4RzTip87kfH1CHvAOOWoGqkQ7pM/NMjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865860; c=relaxed/simple;
	bh=ZhqBEdEffOXsyEaHXhjd8E7KHJl7rrnb6Uh8uim8bp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivuUrSuUYKMbOXlTTgYXCTB9DLexNLntBjB0FIE3Y8G9H2FkMxUsgJGW252oXVAT8kx/fOzBDrfBupHbiIL/xwwr/WIVkct36raR+cwgLDXuRCM8wcLFFuBXfZzJeEFuY6yJwW7ag1e/Rp5Dgsh46PdQDwzKLZ1bLxvM5V3qfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCUsaGjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 114B3C4AF0A;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865860;
	bh=ZhqBEdEffOXsyEaHXhjd8E7KHJl7rrnb6Uh8uim8bp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aCUsaGjVquArZxfBKi2nTnxshdOWrCnpd3Evqy6pfvHskkz327Dev7P0hQaMDAdlG
	 MizmvrNhARxRC6hoTWDT0Zk4i0i45o8gw/Zicc2uAcyWZq40hngBX1Zk9x/6fH8Qi6
	 /l0D5bBcEFg0dcTpVCCTA/3t3TiMoS7uPKpE1Pm3MWK/vRFtnUXsuCTHWEgJZPrfrV
	 gLeHz8e6CBw+AQVxRfQXrwIlun9G3BoaGd9KfmMknKHeWORJi2MT03jHif1RJvYGMf
	 aMz3UEUudJr19EtCLrQClbUJp7J4q6cLbz+xb3u/flNB0r2H8p4RAUeUQKgU8GVffX
	 R6uwFcwQDtrVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E78C4345F;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 23 Apr 2024 12:50:47 +0300
Subject: [PATCH v3 3/5] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-3-23d33cfafe7a@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713865858; l=4241;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=rzvkGU8XYLFoJJLUOwkBJjuiHr53mnc39d+oLj0VaB8=;
 b=yVyNDxioUjfJOYcBXOy2mKFHErFQ4rTCTHIynhHmmls0VRE3UDq4IkfGsYsfcOB8qufib1dvd
 Egf2mpgcjTVDvlFew5hjnf1vSXm4pu/9l+mPNGSBCt0vXiWc9PmwxKn
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add the device tree for ASUS RT-AC3200 which is an AC3200 router featuring
5 Ethernet ports over the integrated Broadcom switch.

Hardware info:
* Processor: Broadcom BCM4709A0 dual-core @ 1.0 GHz
* Switch: BCM53012 in BCM4709A0
* DDR3 RAM: 256 MB
* Flash: 128 MB
* 2.4GHz: BCM43602 3x3 single chip 802.11b/g/n SoC
* 5GHz: BCM43602 3x3 two chips 802.11a/n/ac SoC
* Ports: 4 LAN Ports, 1 WAN Port

Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/Makefile                |   1 +
 .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 150 +++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/Makefile b/arch/arm/boot/dts/broadcom/Makefile
index 7099d9560033..c61fca514775 100644
--- a/arch/arm/boot/dts/broadcom/Makefile
+++ b/arch/arm/boot/dts/broadcom/Makefile
@@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm47081-luxul-xap-1410.dtb \
 	bcm47081-luxul-xwr-1200.dtb \
 	bcm47081-tplink-archer-c5-v2.dtb \
+	bcm4709-asus-rt-ac3200.dtb \
 	bcm4709-asus-rt-ac87u.dtb \
 	bcm4709-buffalo-wxr-1900dhp.dtb \
 	bcm4709-linksys-ea9200.dtb \
diff --git a/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
new file mode 100644
index 000000000000..53cb0c58f6d0
--- /dev/null
+++ b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Author: Tom Brautaset <tbrautaset@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm4709.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "asus,rt-ac3200", "brcm,bcm4709", "brcm,bcm4708";
+	model = "ASUS RT-AC3200";
+
+	memory@0 {
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
+		device_type = "memory";
+	};
+
+	nvram@1c080000 {
+		compatible = "brcm,nvram";
+		reg = <0x1c080000 0x00180000>;
+
+		et0macaddr: et0macaddr {
+			#nvmem-cell-cells = <1>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
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
+			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		led-wan-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-wps {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_WPS;
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&gmac0 {
+	nvmem-cells = <&et0macaddr 0>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac1 {
+	nvmem-cells = <&et0macaddr 1>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac2 {
+	nvmem-cells = <&et0macaddr 2>;
+	nvmem-cell-names = "mac-address";
+};
+
+&nandcs {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			reg = <0x00000000 0x00080000>;
+			label = "boot";
+			read-only;
+		};
+
+		partition@80000 {
+			reg = <0x00080000 0x00180000>;
+			label = "nvram";
+		};
+
+		partition@200000 {
+			compatible = "brcm,trx";
+			reg = <0x00200000 0x07e00000>;
+			label = "firmware";
+		};
+	};
+};
+
+&srab {
+	status = "okay";
+
+	ports {
+		port@0 {
+			label = "wan";
+		};
+
+		port@1 {
+			label = "lan1";
+		};
+
+		port@2 {
+			label = "lan2";
+		};
+
+		port@3 {
+			label = "lan3";
+		};
+
+		port@4 {
+			label = "lan4";
+		};
+	};
+};
+
+&usb2 {
+	vcc-gpio = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3_phy {
+	status = "okay";
+};

-- 
2.40.1



