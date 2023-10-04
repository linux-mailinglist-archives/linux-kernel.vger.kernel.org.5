Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5B7B7DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbjJDLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbjJDLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:12:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181DCA6;
        Wed,  4 Oct 2023 04:12:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394BCh0O015582;
        Wed, 4 Oct 2023 06:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696417963;
        bh=ysgksL1LXn3FvdtwuJVC0V85TqhLXo4rQ01frRy6LIs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YVh+7tlLbDrChUQX3uPM1pwt0Bb527S9GILIkwEIi+TA4HUonwsrCLX5aUE0uOZnC
         bPpHh3DRB8j7vUiQLF8SCLyNRjaJB9ti2iwhHQ5CAulyuYv9h/FZD+COXVYiWvdQkN
         ZT+vIIB/fOaWrNh6DqUs9WG2P/Kdzye9McMRCuh4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394BChAe024262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Oct 2023 06:12:43 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 06:12:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 06:12:43 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394BCgJ8022763;
        Wed, 4 Oct 2023 06:12:43 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <rogerq@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] arm64: dts: ti: Add overlay for NAND daughter card
Date:   Wed, 4 Oct 2023 16:42:37 +0530
Message-ID: <20231004111238.3968984-3-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004111238.3968984-1-n-yadav@ti.com>
References: <20231004111238.3968984-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce k3-am62-lp-sk-nand.dtso overlay file to support
the X8 NAND EXPANSION BOARD card (PROC143E1) for AM62x LP SK
board. NAND has partitions for different boot components as
below:

0x000000000000-0x000000200000 : "NAND.tiboot3
0x000000200000-0x000000400000 : "NAND.tispl
0x000000400000-0x000000600000 : "NAND.tiboot3.backup
0x000000600000-0x000000a00000 : "NAND.u-boot
0x000000a00000-0x000000a40000 : "NAND.u-boot-env
0x000000a40000-0x000000a80000 : "NAND.u-boot-env.backup
0x000000a80000-0x000040000000 : "NAND.file-system

Disable mcasp1 node in DT to avoid pinmux conflict. Update
Makefile to include k3-am62-lp-sk-nand.dtso.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso | 119 ++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index b3516419f95d..9aea8bdea44f 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -19,6 +19,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
+k3-am62-lp-sk-nand-dtbs := k3-am62-lp-sk.dtb k3-am62-lp-sk-nand.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM62Ax SoC
diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
new file mode 100644
index 000000000000..0f4e26db534b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "k3-pinctrl.h"
+
+&mcasp1 {
+	status = "disabled";
+};
+
+&main_pmx0 {
+	gpmc0_pins_default: gpmc0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x003c, PIN_INPUT, 0) /* (M25) GPMC0_AD0 */
+			AM62X_IOPAD(0x0040, PIN_INPUT, 0) /* (N23) GPMC0_AD1 */
+			AM62X_IOPAD(0x0044, PIN_INPUT, 0) /* (N24) GPMC0_AD2 */
+			AM62X_IOPAD(0x0048, PIN_INPUT, 0) /* (N25) GPMC0_AD3 */
+			AM62X_IOPAD(0x004c, PIN_INPUT, 0) /* (P24) GPMC0_AD4 */
+			AM62X_IOPAD(0x0050, PIN_INPUT, 0) /* (P22) GPMC0_AD5 */
+			AM62X_IOPAD(0x0054, PIN_INPUT, 0) /* (P21) GPMC0_AD6 */
+			AM62X_IOPAD(0x0058, PIN_INPUT, 0) /* (R23) GPMC0_AD7 */
+			AM62X_IOPAD(0x0084, PIN_OUTPUT, 0) /* (L23) GPMC0_ADVn_ALE */
+			AM62X_IOPAD(0x0088, PIN_OUTPUT, 0) /* (L24) GPMC0_OEn_REn */
+			AM62X_IOPAD(0x008c, PIN_OUTPUT, 0) /* (L25) GPMC0_WEn */
+			AM62X_IOPAD(0x0090, PIN_OUTPUT, 0) /* (M24) GPMC0_BE0n_CLE */
+			AM62X_IOPAD(0x00a8, PIN_OUTPUT, 0) /* (M21) GPMC0_CSn0 */
+			AM62X_IOPAD(0x0098, PIN_INPUT, 0) /* (U23) GPMC0_WAIT0 */
+		>;
+	};
+};
+
+&gpmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpmc0_pins_default>;
+	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	nand0_0: nand@0,0 {
+		compatible = "ti,am64-nand";
+		reg = <0 0 64>;         /* device IO registers */
+		interrupt-parent = <&gpmc0>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>; /* termcount */
+		rb-gpios = <&gpmc0 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
+		ti,nand-xfer-type = "prefetch-polled";
+		ti,nand-ecc-opt = "bch8";       /* BCH8: Bootrom limitation */
+		ti,elm-id = <&elm0>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <40>;
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <25>;
+		gpmc,adv-wr-off-ns = <25>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <20>;
+		gpmc,oe-on-ns = <3>;
+		gpmc,oe-off-ns = <30>;
+		gpmc,access-ns = <30>;
+		gpmc,rd-cycle-ns = <40>;
+		gpmc,wr-cycle-ns = <40>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "NAND.tiboot3";
+				reg = <0x00000000 0x00200000>;  /* 2M */
+			};
+			partition@200000 {
+				label = "NAND.tispl";
+				reg = <0x00200000 0x00200000>;  /* 2M */
+			};
+			partition@400000 {
+				label = "NAND.tiboot3.backup";  /* 2M */
+				reg = <0x00400000 0x00200000>;  /* BootROM looks at 4M */
+			};
+			partition@600000 {
+				label = "NAND.u-boot";
+				reg = <0x00600000 0x00400000>;  /* 4M */
+			};
+			partition@a00000 {
+				label = "NAND.u-boot-env";
+				reg = <0x00a00000 0x00040000>;  /* 256K */
+			};
+			partition@a40000 {
+				label = "NAND.u-boot-env.backup";
+				reg = <0x00a40000 0x00040000>;  /* 256K */
+			};
+			partition@a80000 {
+				label = "NAND.file-system";
+				reg = <0x00a80000 0x3f580000>;
+			};
+		};
+	};
+};
+
+&elm0{
+	status = "okay";
+};
-- 
2.25.1

