Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76A7FB6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbjK1KMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbjK1KKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:10:40 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EA131;
        Tue, 28 Nov 2023 02:10:45 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASAAXRo079833;
        Tue, 28 Nov 2023 04:10:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701166233;
        bh=3GYwtw59YCcor/NLf8ZP0vjymxatZ5xSsrnhTHTWfNg=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=VqvX2JiRwZ34MrSpy0yfYjsFJdmorGbW4T+WidyEka8AYb2q+6hUUZHrtsxpWbuKP
         R2IUqnVWZL7OBvCZTDhMeXQ/ARCXx7UMtLtcZGmq2efjLzodFCQjIViktRderpBbqV
         Adn3e6rv8YMKbEkTOW7olqHpX2Ao409YRhwEO6k4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASAAX4u108294
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Nov 2023 04:10:33 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 04:10:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 04:10:32 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASAAVfF070639;
        Tue, 28 Nov 2023 04:10:31 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Nov 2023 15:39:48 +0530
Subject: [PATCH v3 6/9] arm64: dts: ti: k3-am62x: Add overlays for OV5640
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231128-csi_dts-v3-6-0bb11cfa9d43@ti.com>
References: <20231128-csi_dts-v3-0-0bb11cfa9d43@ti.com>
In-Reply-To: <20231128-csi_dts-v3-0-0bb11cfa9d43@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6292; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=siE15amp7sBe0tqZO+R7dGdDyBuGj7LaqdT6TjKRyvc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlZbyDwiFUM/Sl7eGJP2eYSSLTSLkfLwORoqNYj
 bFH4ZVen5yJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZWW8gwAKCRBD3pH5JJpx
 RfFhD/4xy83j2GWyHUhSMRhMy6p8WNUDl1RF23Elez8LoMNkk2oXL/1I8XkWEJ4FPwx0jDvcA6H
 0+JTJObDmSY7nGFY+kPrROCW4NzC1Ar7vHcYgmUtnayCxJHJn63C8YcNxNsyJKdVyNtD33XmJX2
 SqDPAoIS1x0NzuGTXoPj1/XNWb4vuOXLhxZNhFm7PUx48HttzAbF5U90dcsmi6v2oCTdfyhCDU2
 HblXc/riapjw6OzMcKgCErCisxAW+cbKThJH8nviRwiB55q9uEo+vhbTbJtf/7ND6KRrW7gq/Sv
 aHVB/1OJiU/XxwKHsZApJJw73xZ9lQsU9UFRAp3yKDc8RXBnMlEVK/dwF9Nq+tQDGSQUvb6PlS4
 zwxnH4wq97PqN0OCKVq6li1exU7mgebcQJlCT54V8xZiabEQGQxTTbh5MAN1rxxpBNeqo/CJhLm
 twGZfeSAU6WutjFcH1Pame1AQvSD55If+IwH7OZfVUL+zqYMTCRoU1QLITVmT01Qic57LXDu+OE
 cunRlPQ+wc1nGcq5f+3Iw+EKkEdmdPDNN1KC1gc2iRJKqu77DkJlo6Be91DPZ53hvOPkTfcDI5z
 CYyEsFgWqQOaobdopgM7IUwPXr9IJnQOmJ/bsfWGf7PAf7129LiP+tDBy8szh0/TK1ve8JUG7RF
 yIJpuMby/A6a09A==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three different OV5640 modules are supported using the 15-pin FFC
connector on SK-AM62:
- Digilent PCam 5C
- ALINX AN5641
- TEVI-OV5640-*-RPI

The Digilent and ALINX modules supply a 12Mhz XCLK to the sensor, while
the TEVI module supplies a 24Mhz XCLK, thus requiring a separate
overlay.

These overlays can be used on other boards of the SK-AM62* family that
have a 15/22-pin FFC connector, so we name the overlays with the prefix
k3-am62x-.

Tested-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile                    | 19 ++++-
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso | 82 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso  | 82 ++++++++++++++++++++++
 3 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c6c7825b4cb2..f957b5f741ff 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -32,6 +32,10 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 
+# Common overlays for SK-AM62* family of boards
+dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-ov5640.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-tevi-ov5640.dtbo
+
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
@@ -87,13 +91,26 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
+	k3-am62x-sk-csi2-ov5640.dtbo
+k3-am625-sk-csi2-tevi-ov5640-dtbs := k3-am625-sk.dtb \
+	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
+	k3-am62x-sk-csi2-ov5640.dtbo
+k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
+	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
-	k3-am625-beagleplay-csi2-tevi-ov5640.dtb
+	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
+	k3-am625-sk-csi2-ov5640.dtb \
+	k3-am625-sk-csi2-tevi-ov5640.dtb \
+	k3-am62a7-sk-csi2-ov5640.dtb \
+	k3-am62a7-sk-csi2-tevi-ov5640.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
+DTC_FLAGS_k3-am62a7-sk += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
new file mode 100644
index 000000000000..1f3aebbc8df8
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALINX AN5641 & Digilent PCam 5C - OV5640 camera module
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	clk_ov5640_fixed: ov5640-xclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+};
+
+&main_i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	i2c-switch@71 {
+		compatible = "nxp,pca9543";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		/* CAM port */
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			ov5640: camera@3c {
+				compatible = "ovti,ov5640";
+				reg = <0x3c>;
+
+				clocks = <&clk_ov5640_fixed>;
+				clock-names = "xclk";
+				powerdown-gpios = <&exp1 13 GPIO_ACTIVE_LOW>;
+
+				port {
+					csi2_cam0: endpoint {
+						remote-endpoint = <&csi2rx0_in_sensor>;
+						clock-lanes = <0>;
+						data-lanes = <1 2>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&cdns_csi2rx0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi0_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx0_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam0>;
+				bus-type = <4>; /* CSI2 DPHY. */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&dphy0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
new file mode 100644
index 000000000000..6a367f13be63
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Technexion TEVI-OV5640-*-RPI - OV5640 camera module
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	clk_ov5640_fixed: ov5640-xclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+};
+
+&main_i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	i2c-switch@71 {
+		compatible = "nxp,pca9543";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		/* CAM port */
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			ov5640: camera@3c {
+				compatible = "ovti,ov5640";
+				reg = <0x3c>;
+
+				clocks = <&clk_ov5640_fixed>;
+				clock-names = "xclk";
+				powerdown-gpios = <&exp1 13 GPIO_ACTIVE_LOW>;
+
+				port {
+					csi2_cam0: endpoint {
+						remote-endpoint = <&csi2rx0_in_sensor>;
+						clock-lanes = <0>;
+						data-lanes = <1 2>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&cdns_csi2rx0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi0_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx0_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam0>;
+				bus-type = <4>; /* CSI2 DPHY. */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&dphy0 {
+	status = "okay";
+};

-- 
2.42.1

