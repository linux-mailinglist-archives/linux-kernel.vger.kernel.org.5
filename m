Return-Path: <linux-kernel+bounces-144123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2148A4222
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E42D281F4D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCAF44C89;
	Sun, 14 Apr 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi93Dh7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2A3613D;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095180; cv=none; b=aZDn5JF806aG1WnFCXFCwnqfxS8A1SGB09+5Q49BdavykoD+z5A5jtTP0eQRWyzf3XGiIs8wLkeuj1pyGArfUiyy0HGgztk69UN/CX24TojQ7QP2kWLqtwEPIyPKXBkvx+mvYQC6LZm7U6M0VeCKvGSJnDGoG6B3UddMLi8WXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095180; c=relaxed/simple;
	bh=iOTbMvh8oo8qfCdUhfbJs9sLC03dXhPCXmOTbb7K93o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jonq6PcImQk1NohhoaPZL/xbSUVppfpOEGBzkR36RRy3E9WNiSRbwdA+yu+bhNEu/S8AilCJEcMYGov0L3RnWmTtGyKozkl5cxYsYc++zmZNr6/Fvq4I4EODUd34YyfTIK2O1K9PYBBIIL7EO8EXiO57P84GTjPNTufdhp5RfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi93Dh7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C8C1C4AF0A;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713095180;
	bh=iOTbMvh8oo8qfCdUhfbJs9sLC03dXhPCXmOTbb7K93o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vi93Dh7pqiV62TLmnkl5pjC6ixAoTE2eEiY4fJ4Mq7131zJ2rgIrMjixLGB/ei/Li
	 ninoLsGd6HT4QAHkETwG2eTDtFB/BOrGkJKgZ4RwEq/dQ9RjrmN6FrYluQudHY0yMk
	 BDdFs4zZrdkz+c3UjxGIhCfC5dk2SzKxIPX18zbTkya7hNJPM303oMCnQAppQ3rVPL
	 j29CvjfEs3VrydUO0QV4awGwPVWyDEEwwx/6xKnvWbfRJArd4/YgTsX65Yej4Py8YI
	 IcF5CL1NmqTwWdGWAMNYEm5QG9E+EowPHTpKTQlJWHCiXZY4UZub36L05/eILSHXji
	 x5muPU0Zyu3CQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F967C05024;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 14:46:03 +0300
Subject: [PATCH 4/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-4-118c90bae6e5@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
In-Reply-To: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713095170; l=4826;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=c/8HaPqKjp8S34BaI+MyH3eEMu3y9Wkl8uy/jpRF7IU=;
 b=oeOazBKHkZuyczClozvfl62Fuv/byhjHgqlTqXWQVV0zoK/ShxrfEE2bHePajqRHli1NGJ6c2
 CAocWOtD0G2BJh/noJ38ZuFL7d8ldKfwgBBZ0+61QnwmNelbT1141qc
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add the device tree for ASUS RT-AC5300 which is an AC5300 router featuring
5 Ethernet ports over the integrated Broadcom switch.

Hardware info:
* Processor: Broadcom BCM4709C0 dual-core @ 1.4 GHz
* Switch: BCM53012 in BCM4709C0
* DDR3 RAM: 512 MB
* Flash: 128 MB
* 2.4GHz: BCM4366 4x4 single chip 802.11b/g/n SoC
* 5GHz: BCM4366 4x4 two chips 802.11a/n/ac SoC
* Ports: 4 LAN Ports, 1 WAN Port

Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/Makefile                |   1 +
 .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 170 +++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/Makefile b/arch/arm/boot/dts/broadcom/Makefile
index c61fca514775..5881bcc95eba 100644
--- a/arch/arm/boot/dts/broadcom/Makefile
+++ b/arch/arm/boot/dts/broadcom/Makefile
@@ -72,6 +72,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4709-netgear-r8000.dtb \
 	bcm4709-tplink-archer-c9-v1.dtb \
 	bcm47094-asus-rt-ac3100.dtb \
+	bcm47094-asus-rt-ac5300.dtb \
 	bcm47094-asus-rt-ac88u.dtb \
 	bcm47094-dlink-dir-885l.dtb \
 	bcm47094-dlink-dir-890l.dtb \
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
new file mode 100644
index 000000000000..b7e55d4ce999
--- /dev/null
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Author: Tom Brautaset <tbrautaset@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm47094.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "asus,rt-ac5300", "brcm,bcm47094", "brcm,bcm4708";
+	model = "ASUS RT-AC5300";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x18000000>;
+	};
+
+	nvram@1c080000 {
+		compatible = "brcm,nvram";
+		reg = <0x1c080000 0x00180000>;
+
+		et1macaddr: et1macaddr {
+			#nvmem-cell-cells = <1>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-lan {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&chipcommon 21 GPIO_ACTIVE_LOW>;
+		};
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
+			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
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
+			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
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
+
+&gmac0 {
+	nvmem-cells = <&et1macaddr 0>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac1 {
+	nvmem-cells = <&et1macaddr 1>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac2 {
+	nvmem-cells = <&et1macaddr 2>;
+	nvmem-cell-names = "mac-address";
+};
+
+&srab {
+	status = "okay";
+
+	ports {
+		port@0 {
+			label = "lan4";
+			nvmem-cells = <&et1macaddr 0>;
+			nvmem-cell-names = "mac-address";
+		};
+
+		port@1 {
+			label = "lan3";
+			nvmem-cells = <&et1macaddr 1>;
+			nvmem-cell-names = "mac-address";
+		};
+
+		port@2 {
+			label = "lan2";
+			nvmem-cells = <&et1macaddr 2>;
+			nvmem-cell-names = "mac-address";
+		};
+
+		port@3 {
+			label = "lan1";
+			nvmem-cells = <&et1macaddr 3>;
+			nvmem-cell-names = "mac-address";
+		};
+
+		port@4 {
+			label = "wan";
+			nvmem-cells = <&et1macaddr 4>;
+			nvmem-cell-names = "mac-address";
+		};
+	};
+};
+
+&nandcs {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "boot";
+			reg = <0x00000000 0x00080000>;
+			read-only;
+		};
+
+		partition@80000 {
+			label = "nvram";
+			reg = <0x00080000 0x00180000>;
+		};
+
+		partition@200000 {
+			label = "firmware";
+			reg = <0x00200000 0x07e00000>;
+			compatible = "brcm,trx";
+		};
+	};
+};

-- 
2.40.1



