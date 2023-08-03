Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9676E111
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjHCHPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjHCHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:15:39 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC02D5F;
        Thu,  3 Aug 2023 00:15:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5F9FE000B;
        Thu,  3 Aug 2023 07:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691046935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XILz7BzuqMmhMJMEGv0WsjwCB/JZmnCWnaiGU5L7kRw=;
        b=ZCpEy/rrFiAQY13OYyUrPEVnjWu+RDzXzyc5ClNUJAUj6r4mg6YsLwNRGCNZ6RJmkfMhEV
        CCUfQzWqw2i4r+tNkOE6SIRoJdys1Yuxg9qsBXgH5CbxyWOR8x/qm/n+ZLm7lSo5r6gFd/
        nHFbyTaV0p1f3p0GkSMCTw1LQYIemLFcViQ2iJ8CdkSyWbR2im6UtoQEiNkglUyucqRO58
        qXpfne7l5hP0UOTNMRng8mJsRS4+yj+o+NPTFFghh76Ar0e2+7fDv/8aTluSNdLd6qy662
        WyCv/KbYmivuXXRSXqvvbjvGfoloSWrj4rrE+8excLoa93rEvPx5wlhNKq/N5Q==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>, erkin.bozoglu@xeront.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3100
Date:   Thu,  3 Aug 2023 10:14:54 +0300
Message-Id: <20230803071454.5902-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803071454.5902-1-arinc.unal@arinc9.com>
References: <20230803071454.5902-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS RT-AC3100 is ASUS RT-AC88U without the external switch. Move the
shared bindings to bcm47094-asus-rt-ac3100.dtsi.

Remove the fixed-link node on port@7 as commit ba4aebce23b2 ("ARM: dts:
BCM5301X: Describe switch ports in the main DTS") states it's not
necessary.

Replace the copyright notice with an author notice.

Rename the model name from Asus to ASUS on bcm47094-asus-rt-ac88u.dts.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/Makefile           |   1 +
 .../dts/broadcom/bcm47094-asus-rt-ac3100.dts  |  23 +++
 .../dts/broadcom/bcm47094-asus-rt-ac3100.dtsi | 163 ++++++++++++++++++
 .../dts/broadcom/bcm47094-asus-rt-ac88u.dts   | 155 +----------------
 4 files changed, 190 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts
 create mode 100644 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi

diff --git a/arch/arm/boot/dts/broadcom/Makefile b/arch/arm/boot/dts/broadcom/Makefile
index 95b0ef2a4215..7099d9560033 100644
--- a/arch/arm/boot/dts/broadcom/Makefile
+++ b/arch/arm/boot/dts/broadcom/Makefile
@@ -70,6 +70,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4709-netgear-r7000.dtb \
 	bcm4709-netgear-r8000.dtb \
 	bcm4709-tplink-archer-c9-v1.dtb \
+	bcm47094-asus-rt-ac3100.dtb \
 	bcm47094-asus-rt-ac88u.dtb \
 	bcm47094-dlink-dir-885l.dtb \
 	bcm47094-dlink-dir-890l.dtb \
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts
new file mode 100644
index 000000000000..5f089307cd8c
--- /dev/null
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Author: Arınç ÜNAL <arinc.unal@arinc9.com>
+ */
+
+/dts-v1/;
+
+#include "bcm47094-asus-rt-ac3100.dtsi"
+
+/ {
+	compatible = "asus,rt-ac3100", "brcm,bcm47094", "brcm,bcm4708";
+	model = "ASUS RT-AC3100";
+
+	nvram@1c080000 {
+		et0macaddr: et0macaddr {
+		};
+	};
+};
+
+&gmac0 {
+	nvmem-cells = <&et0macaddr>;
+	nvmem-cell-names = "mac-address";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
new file mode 100644
index 000000000000..09cefce27fb1
--- /dev/null
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Author: Arınç ÜNAL <arinc.unal@arinc9.com>
+ */
+
+#include "bcm47094.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+	chosen {
+		bootargs = "earlycon";
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
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power {
+			label = "white:power";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		led-wan-red {
+			label = "red:wan";
+			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-lan {
+			label = "white:lan";
+			gpios = <&chipcommon 21 GPIO_ACTIVE_LOW>;
+		};
+
+		led-usb2 {
+			label = "white:usb2";
+			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ehci_port2>;
+			linux,default-trigger = "usbport";
+		};
+
+		led-usb3 {
+			label = "white:usb3";
+			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ehci_port1>, <&xhci_port1>;
+			linux,default-trigger = "usbport";
+		};
+
+		led-wps {
+			label = "white:wps";
+			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
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
+		button-led {
+			label = "Backlight";
+			linux,code = <KEY_BRIGHTNESS_ZERO>;
+			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&srab {
+	compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
+	status = "okay";
+
+	ports {
+		port@0 {
+			label = "lan4";
+		};
+
+		port@1 {
+			label = "lan3";
+		};
+
+		port@2 {
+			label = "lan2";
+		};
+
+		port@3 {
+			label = "lan1";
+		};
+
+		port@4 {
+			label = "wan";
+		};
+
+		port@5 {
+			label = "cpu";
+		};
+
+		port@7 {
+			label = "cpu";
+		};
+
+		port@8 {
+			label = "cpu";
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
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
index 4d5747aa5dc8..fd344b55087e 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
@@ -1,102 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright (C) 2021-2022 Arınç ÜNAL <arinc.unal@arinc9.com>
+ * Author: Arınç ÜNAL <arinc.unal@arinc9.com>
  */
 
 /dts-v1/;
 
-#include "bcm47094.dtsi"
-#include "bcm5301x-nand-cs0-bch8.dtsi"
+#include "bcm47094-asus-rt-ac3100.dtsi"
 
 / {
 	compatible = "asus,rt-ac88u", "brcm,bcm47094", "brcm,bcm4708";
-	model = "Asus RT-AC88U";
-
-	chosen {
-		bootargs = "earlycon";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x08000000>,
-		      <0x88000000 0x18000000>;
-	};
+	model = "ASUS RT-AC88U";
 
 	nvram@1c080000 {
-		compatible = "brcm,nvram";
-		reg = <0x1c080000 0x00180000>;
-
 		et1macaddr: et1macaddr {
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
-
-		led-power {
-			label = "white:power";
-			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-on";
-		};
-
-		led-wan-red {
-			label = "red:wan";
-			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-lan {
-			label = "white:lan";
-			gpios = <&chipcommon 21 GPIO_ACTIVE_LOW>;
-		};
-
-		led-usb2 {
-			label = "white:usb2";
-			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
-			trigger-sources = <&ehci_port2>;
-			linux,default-trigger = "usbport";
-		};
-
-		led-usb3 {
-			label = "white:usb3";
-			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
-			trigger-sources = <&ehci_port1>, <&xhci_port1>;
-			linux,default-trigger = "usbport";
-		};
-
-		led-wps {
-			label = "white:wps";
-			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		button-wps {
-			label = "WPS";
-			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
-		};
-
-		button-reset {
-			label = "Reset";
-			linux,code = <KEY_RESTART>;
-			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
-		};
-
-		button-wifi {
-			label = "Wi-Fi";
-			linux,code = <KEY_RFKILL>;
-			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
-		};
-
-		button-led {
-			label = "Backlight";
-			linux,code = <KEY_BRIGHTNESS_ZERO>;
-			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	switch {
 		compatible = "realtek,rtl8365mb";
 		/* 7 = MDIO (has input reads), 6 = MDC (clock, output only) */
@@ -175,31 +94,9 @@ ethphy3: ethernet-phy@3 {
 };
 
 &srab {
-	compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
-	status = "okay";
 	dsa,member = <0 0>;
 
 	ports {
-		port@0 {
-			label = "lan4";
-		};
-
-		port@1 {
-			label = "lan3";
-		};
-
-		port@2 {
-			label = "lan2";
-		};
-
-		port@3 {
-			label = "lan1";
-		};
-
-		port@4 {
-			label = "wan";
-		};
-
 		sw0_p5: port@5 {
 			/delete-property/ethernet;
 
@@ -212,19 +109,6 @@ fixed-link {
 				pause;
 			};
 		};
-
-		port@7 {
-			label = "cpu";
-
-			fixed-link {
-				speed = <1000>;
-				full-duplex;
-			};
-		};
-
-		port@8 {
-			label = "cpu";
-		};
 	};
 };
 
@@ -236,36 +120,3 @@ &gmac1 {
 	nvmem-cells = <&et1macaddr>;
 	nvmem-cell-names = "mac-address";
 };
-
-&usb2 {
-	vcc-gpio = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
-};
-
-&usb3_phy {
-	status = "okay";
-};
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
-- 
2.39.2

