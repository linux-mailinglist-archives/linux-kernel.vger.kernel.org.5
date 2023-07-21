Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E755F75BFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGUHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGUHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:35:34 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BC4273F;
        Fri, 21 Jul 2023 00:34:52 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 21 Jul 2023
 15:34:33 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 3/3] arm64: dts: Replace the IRQ number with the IRQID macro definition
Date:   Fri, 21 Jul 2023 15:32:14 +0800
Message-ID: <20230721073214.1876417-4-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing IRQ numbers with IRQID macro definitions makes node properties
easier to understand and also makes GPIO interrupts easier to use.

Associated platforms:
- Amlogic Meson-G12A
- Amlogic Meson-G12B
- Amlogic Meson-SM1

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi    |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 +-
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi    |  2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi |  2 +-
 .../boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts  |  4 ++--
 .../arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi |  2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi     |  2 +-
 .../boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi  |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts    |  2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi    |  2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts     | 12 ++++++------
 .../boot/dts/amlogic/meson-sm1-x96-air-gbit.dts      |  2 +-
 13 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0c49655cc90c..0142abfc930c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index b2bb94981838..c79f3e8d26b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -344,7 +344,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
index 97e522921b06..428b35e1d79c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
@@ -201,7 +201,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
index 83709787eb91..c69b0f803916 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
@@ -327,7 +327,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
index 276e95b34022..eed2a23047ca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -380,7 +380,7 @@ rk818: pmic@1c {
 		compatible = "rockchip,rk818";
 		reg = <0x1c>;
 		interrupt-parent = <&gpio_intc>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_7 */
+		interrupts = <IRQID_GPIOAO_7 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_7 */
 		#clock-cells = <1>;
 
 		vcc1-supply = <&vdd_sys>;
@@ -519,7 +519,7 @@ rk817: pmic@20 {
 		reg = <0x20>;
 		interrupt-parent = <&gpio_intc>;
 
-		interrupts = <5 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_5 */
+		interrupts = <IRQID_GPIOAO_5 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_5 */
 
 		vcc1-supply = <&vdd_sys>;
 		vcc2-supply = <&vdd_sys>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 24d0442dffb2..01aa970b2f8c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -185,7 +185,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
index b40d2c1002c9..ac8b7178257e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
@@ -269,7 +269,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
index d1debccdc1c2..95e03bb02af2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
@@ -100,7 +100,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
index 17045ff81c69..62404743e62d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
@@ -45,7 +45,7 @@ key {
 			linux,code = <BTN_1>;
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio_intc>;
-			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <IRQID_GPIOAO_3 IRQ_TYPE_EDGE_BOTH>;
 		};
 	};
 
@@ -217,7 +217,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
index 0f6660e68e72..ebda1dd30fa6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
@@ -100,7 +100,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index 2fce44939f45..86b90f44a4b3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -283,7 +283,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 9068a334ea57..4f07d6387bb1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -53,7 +53,7 @@ key-1 {
 			linux,code = <BTN_0>;
 			gpios = <&gpio GPIOH_6 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio_intc>;
-			interrupts = <34 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <IRQID_GPIOH_6 IRQ_TYPE_EDGE_BOTH>;
 		};
 
 		key-2 {
@@ -61,7 +61,7 @@ key-2 {
 			linux,code = <BTN_1>;
 			gpios = <&gpio GPIOH_7 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio_intc>;
-			interrupts = <35 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <IRQID_GPIOH_7 IRQ_TYPE_EDGE_BOTH>;
 		};
 
 		key-3 {
@@ -69,7 +69,7 @@ key-3 {
 			linux,code = <BTN_2>;
 			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio_intc>;
-			interrupts = <2 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <IRQID_GPIOAO_2 IRQ_TYPE_EDGE_BOTH>;
 		};
 
 		key-mic-mute {
@@ -78,7 +78,7 @@ key-mic-mute {
 			linux,input-type = <EV_SW>;
 			gpios = <&gpio_ao GPIOE_2 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio_intc>;
-			interrupts = <99 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <IRQID_GPIOE_2 IRQ_TYPE_EDGE_BOTH>;
 		};
 
 		key-power {
@@ -86,7 +86,7 @@ key-power {
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio_intc>;
-			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <IRQID_GPIOAO_3 IRQ_TYPE_EDGE_BOTH>;
 		};
 	};
 
@@ -583,7 +583,7 @@ &uart_A {
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		interrupt-parent = <&gpio_intc>;
-		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <IRQID_GPIOX_18 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wakeup";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
index 7e1a74046ba5..6ee406066ee0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
@@ -100,7 +100,7 @@ external_phy: ethernet-phy@0 {
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.37.1

