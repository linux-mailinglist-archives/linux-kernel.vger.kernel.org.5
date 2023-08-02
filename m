Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC476D900
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjHBUyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjHBUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:53:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A02D4B;
        Wed,  2 Aug 2023 13:53:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372KrGWF098050;
        Wed, 2 Aug 2023 15:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691009596;
        bh=aDI8cMXt39aKEhmixQlgMMFEmWazt299GyEFV9WZ+SQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xHAFM2bWkVglW7hRAqsta3MrFHSlfMCOUaVP7fJO9kVh0ImoHbNLszpjNw0Cru0F0
         WrfTO8ibfoH3ZgIiYOr6O7dSCG8PYdF8T+7QY1bL18PzhWAjEJjk+56jsGZxVy8cj9
         uihdrdqW3RJdoxylEHp0oRUCHXNdtNqCEwV4GZYw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372KrGkh071679
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 15:53:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 15:53:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 15:53:15 -0500
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372KrASF090834;
        Wed, 2 Aug 2023 15:53:15 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 08/13] arm64: dts: ti: k3-j721e: Enable GPIO nodes at the board level
Date:   Wed, 2 Aug 2023 15:53:04 -0500
Message-ID: <20230802205309.257392-9-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802205309.257392-1-afd@ti.com>
References: <20230802205309.257392-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO nodes defined in the top-level J721e SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux and
device information.

Disable the GPIO nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 42 ++++---------------
 .../dts/ti/k3-j721e-common-proc-board.dts     | 35 ++++------------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  8 ++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  2 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 31 +++-----------
 5 files changed, 31 insertions(+), 87 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 0b89977351c98..99536765939d9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -647,52 +647,24 @@ eeprom@50 {
 	};
 };
 
-&main_gpio2 {
-	/* Unused */
-	status = "disabled";
-};
-
-&main_gpio3 {
-	/* Unused */
-	status = "disabled";
-};
-
-&main_gpio4 {
-	/* Unused */
-	status = "disabled";
-};
-
-&main_gpio5 {
-	/* Unused */
-	status = "disabled";
-};
-
-&main_gpio6 {
-	/* Unused */
-	status = "disabled";
-};
-
-&main_gpio7 {
-	/* Unused */
-	status = "disabled";
-};
-
 &wkup_gpio0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_adc0_pins_default>, <&mcu_adc1_pins_default>,
 		    <&mikro_bus_pins_default>;
 };
 
-&wkup_gpio1 {
-	/* Unused */
-	status = "disabled";
-};
-
 &main_gpio0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&csi1_gpio_pins_default>, <&csi0_gpio_pins_default>;
 };
 
+&main_gpio1 {
+	status = "okay";
+	/* default pins */
+};
+
 &usb_serdes_mux {
 	idle-states = <1>, <1>; /* USB0 to SERDES3, USB1 to SERDES2 */
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index e9b84d2c64b26..2fd940893eb5f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -469,37 +469,20 @@ &main_uart4 {
 	pinctrl-0 = <&main_uart4_pins_default>;
 };
 
-&main_gpio2 {
-	status = "disabled";
-};
-
-&main_gpio3 {
-	status = "disabled";
-};
-
-&main_gpio4 {
-	status = "disabled";
-};
-
-&main_gpio5 {
-	status = "disabled";
-};
-
-&main_gpio6 {
-	status = "disabled";
-};
-
-&main_gpio7 {
-	status = "disabled";
-};
-
 &wkup_gpio0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_gpio_pins_default>;
 };
 
-&wkup_gpio1 {
-	status = "disabled";
+&main_gpio0 {
+	status = "okay";
+	/* default pins */
+};
+
+&main_gpio1 {
+	status = "okay";
+	/* default pins */
 };
 
 &main_sdhci0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0ca31186b9b74..7f663d9280b57 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1339,6 +1339,7 @@ main_gpio0: gpio@600000 {
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 105 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio1: gpio@601000 {
@@ -1355,6 +1356,7 @@ main_gpio1: gpio@601000 {
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 106 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio2: gpio@610000 {
@@ -1372,6 +1374,7 @@ main_gpio2: gpio@610000 {
 		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 107 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio3: gpio@611000 {
@@ -1388,6 +1391,7 @@ main_gpio3: gpio@611000 {
 		power-domains = <&k3_pds 108 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 108 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio4: gpio@620000 {
@@ -1405,6 +1409,7 @@ main_gpio4: gpio@620000 {
 		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 109 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio5: gpio@621000 {
@@ -1421,6 +1426,7 @@ main_gpio5: gpio@621000 {
 		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 110 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio6: gpio@630000 {
@@ -1438,6 +1444,7 @@ main_gpio6: gpio@630000 {
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 111 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio7: gpio@631000 {
@@ -1454,6 +1461,7 @@ main_gpio7: gpio@631000 {
 		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 112 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_sdhci0: mmc@4f80000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 0c01bdd9656f1..4d107eee9b341 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -281,6 +281,7 @@ wkup_gpio0: gpio@42110000 {
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 113 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	wkup_gpio1: gpio@42100000 {
@@ -297,6 +298,7 @@ wkup_gpio1: gpio@42100000 {
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 114 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	mcu_i2c0: i2c@40b00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 4cd5346f2dd59..dfb6af60482e7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -731,41 +731,20 @@ &main_i2c5 {
 };
 
 &main_gpio0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
 
 &main_gpio1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rpi_header_gpio1_pins_default>;
 };
 
-&main_gpio2 {
-	status = "disabled";
-};
-
-&main_gpio3 {
-	status = "disabled";
-};
-
-&main_gpio4 {
-	status = "disabled";
-};
-
-&main_gpio5 {
-	status = "disabled";
-};
-
-&main_gpio6 {
-	status = "disabled";
-};
-
-&main_gpio7 {
-	status = "disabled";
-};
-
-&wkup_gpio1 {
-	status = "disabled";
+&wkup_gpio0 {
+	status = "okay";
+	/* default pins */
 };
 
 &usb_serdes_mux {
-- 
2.39.2

