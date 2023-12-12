Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECBA80E604
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjLLIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346081AbjLLIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:22:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB31100
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 249FCC3277F;
        Tue, 12 Dec 2023 08:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369326;
        bh=QxXyV+4znc/zev1U+GCmM5SgxTS+tx1I8YHe7cbBQAM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=sjQDXjiASzSR1pEVXC6mGyj82DKX0FkGB7rRd9mr5zQFIaBEjKNcCBfeb+gn/sMf6
         MGVibE5Fa+D589e05wNJ6RxwyaR6EiBoSe5JOXvUorNW0QwaeyUc1CkAu9IO3bWJO0
         e1C7e/av9zyfJGYUKuX0tKuEfg1lpYM/NuGU5tIpDpe3ehdK3idk2zbXmcxZ61qvGr
         mvijQFp5oanf600m0ObOzS95Aq1HYKBLso8ALuIe5fgzPgXAeJ/+vHgky0GXHj/Wes
         xek0FMqvC2buc3czeY7ShZBebv6LNqEtWirdUQJToSJRmrvzkyoUSU8yBWuDmpZb10
         2GWu0G2+R3M9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 12E92C4167D;
        Tue, 12 Dec 2023 08:22:06 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:49 +0300
Subject: [PATCH v6 32/40] ARM: dts: ep93xx: add ts7250 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-32-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Andre Przywara <andre.przywara@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Michal Simek <michal.simek@amd.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=6189;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=nFAzcOth5DIkxc0/jY6Pz4HPUfRPm3ZyzaiBWKElNNs=; =?utf-8?q?b=3DMK48uEAlkDPd?=
 =?utf-8?q?NCqEZ3QLqZMfIxzFVOnheFT664mycDfwj/IY8gEP/2ydEnfhPQxACtB057R2WJBZ?=
 KkSAFqQTBPd+4/qmDlfQCEYX+taIY3xzybpi5k/e5fc9L9VpN7u6
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree file for Technologic Systems ts7250 board and
Liebherr bk3 board which have many in common, both are based on
ep9302 SoC variant.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/cirrus/Makefile          |   3 +
 arch/arm/boot/dts/cirrus/ep93xx-bk3.dts    | 126 +++++++++++++++++++++++++
 arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts | 145 +++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
index e944d3e2129d..211a7e2f2115 100644
--- a/arch/arm/boot/dts/cirrus/Makefile
+++ b/arch/arm/boot/dts/cirrus/Makefile
@@ -3,3 +3,6 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
 dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
+dtb-$(CONFIG_ARCH_EP93XX) += \
+	ep93xx-bk3.dtb \
+	ep93xx-ts7250.dtb
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
new file mode 100644
index 000000000000..5409a700cdfe
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Liebherr controller BK3.1 based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	model = "Liebherr controller BK3.1";
+	compatible = "liebherr,bk3", "cirrus,ep9301";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x00000000 0x02000000>,
+		      <0x000530c0 0x01fdd000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&ebi {
+	nand-controller@60000000 {
+		compatible = "technologic,ts7200-nand";
+		reg = <0x60000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand@0 {
+			reg = <0>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "System";
+					reg = <0x00000000 0x01e00000>;
+					read-only;
+				};
+
+				partition@1e00000 {
+					label = "Data";
+					reg = <0x01e00000 0x05f20000>;
+				};
+
+				partition@7d20000 {
+					label = "RedBoot";
+					reg = <0x07d20000 0x002e0000>;
+					read-only;
+				};
+			};
+		};
+	};
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&i2s {
+	dmas = <&dma0 0 1>, <&dma0 0 2>;
+	dma-names = "tx", "rx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_on_ac97_pins>;
+	status = "okay";
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&syscon 6 163 1>;
+};
+
+&gpio4 {
+	gpio-ranges = <&syscon 0 97 2>;
+	status = "okay";
+};
+
+&gpio6 {
+	gpio-ranges = <&syscon 0 87 2>;
+	status = "okay";
+};
+
+&gpio7 {
+	gpio-ranges = <&syscon 2 199 4>;
+	status = "okay";
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
new file mode 100644
index 000000000000..9e03f93d9fc8
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Technologic Systems ts7250 board based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	compatible = "technologic,ts7250", "cirrus,ep9301";
+	model = "TS-7250 SBC";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x00000000 0x02000000>,
+		      <0x000530c0 0x01fdd000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&ebi {
+	nand-controller@60000000 {
+		compatible = "technologic,ts7200-nand";
+		reg = <0x60000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand@0 {
+			reg = <0>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "TS-BOOTROM";
+					reg = <0x00000000 0x00020000>;
+					read-only;
+				};
+
+				partition@20000 {
+					label = "Linux";
+					reg = <0x00020000 0x07d00000>;
+				};
+
+				partition@7d20000 {
+					label = "RedBoot";
+					reg = <0x07d20000 0x002e0000>;
+					read-only;
+				};
+			};
+		};
+	};
+
+	rtc@10800000 {
+		compatible = "st,m48t86";
+		reg = <0x10800000 0x1>,
+			<0x11700000 0x1>;
+	};
+
+	watchdog@23800000 {
+		compatible = "technologic,ts7200-wdt";
+		reg = <0x23800000 0x01>,
+			<0x23c00000 0x01>;
+		timeout-sec = <30>;
+	};
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&syscon 6 163 1>;
+};
+
+/* ts7250 doesn't have GPIO Port D present */
+&gpio3 {
+	status = "disabled";
+};
+
+&gpio4 {
+	gpio-ranges = <&syscon 0 97 2>;
+};
+
+&gpio6 {
+	gpio-ranges = <&syscon 0 87 2>;
+};
+
+&gpio7 {
+	gpio-ranges = <&syscon 2 199 4>;
+};
+
+&spi0 {
+	cs-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+	dmas = <&dma1 10 2>, <&dma1 10 1>;
+	dma-names = "rx", "tx";
+	status = "okay";
+
+	tmp122: temperature-sensor@0 {
+		compatible = "ti,tmp122";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+	};
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};

-- 
2.41.0

