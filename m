Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AC8002E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377580AbjLAFLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377504AbjLAFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:10:32 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759771989;
        Thu, 30 Nov 2023 21:10:27 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B15AGg4046750;
        Thu, 30 Nov 2023 23:10:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701407416;
        bh=mOGju8jFGvhn3pPWAI2K8eBExjaLWFL6KaBuQrryyBc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gUcYOcV/bnWF4jM8YidHW7sLimbJB7eB0B9dYpjeboUpaPIky+BwisZjHhC82n9NN
         QtXo6fw5Cq+oktTlU5M6DNkmXCXcKjtZKRlv4umeORyagT65LZfc/hTpbWy93wTsdP
         lWWAkIM/8PP1WK1bYmChNWQtyQ6RJTZRSzVh89TY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B15AG8P016499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Nov 2023 23:10:16 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 23:10:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 23:10:16 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B15AF2b023632;
        Thu, 30 Nov 2023 23:10:15 -0600
From:   Jai Luthra <j-luthra@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Jai Luthra <j-luthra@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH RESEND v3 8/9] arm64: dts: ti: k3-am62x: Add overlay for IMX219
Date:   Fri, 1 Dec 2023 10:39:23 +0530
Message-ID: <20231201-csi_dts-v3-8-9f06f31080fe@ti.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
References: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3941; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=b6cpauaHGBPWOmaKZGQ9EpAhMDjQqtcqqV29zVSXG0Q=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlaWXxU9vu394ULENHgYi7CXFXA+oq7UEJkLkCr
 tynYUXpS5+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZWll8QAKCRBD3pH5JJpx
 RW4jEACD47Lag30YgCk+eY7dUYV6vyu9wWgnmCZ9W/1A6DHWwYqZNjzAnpdEFRiCfrT43KXE/4f
 SJnEWlhePhBFM/i05XdrBiZOPV9OBrxWMNQFQKp8VffxE1pQfR993eOwsjQAAE0qlaNc5SMKfQb
 E7gsZGXajfvHZa3ju4R5lylSUlZVNey98YCTp2yilunUs3U7At1mKctnQ4p9iLWrNWEseoo4116
 y/T3I+ZmvBTKPBLZikB49yod7sd3MVn/hVNmfqFi0kmvfgejoO01W736nLALv+ZCnHTyUagkX12
 9eOiJ+j4OlaHM2z4sDw136hCrrt5Y6Vkp1s3ERN/iX4xLgne4FY044a3U0NnsqSr+QW7MCPDbVT
 VtuhnbM2DUIJ5/9tA9J22o92hNnXxYmpHaihFCXfWKZPkd1U6DGFT9jShiZrhDFJg6zRcxMEd0w
 AmrNiIClOsM83BZMFEDV65X5KgKGcknf0BiEaF+FJdlFECUkiGqzw7Gcj/7f99ECVtmtmpncZmq
 YGLXMRoV78FMsissUkIwqhIrFlTrjfnXhsT4mqr9KaUcwGGrwZcUd7djOfB3sYNIR8yMo4j5saR
 L6yVN3HO2/cFDgfg8UD/KqOvwbba3I+HAxE5ZepOBhOKL1CUKw9UzAKPnSsdCkWDsjehcX8NXl2
 uCeq4y3MEDk7jCA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM62A
through the 22-pin CSI-RX connector.

Same overlay can be used across SK-AM62* boards that have a 15/22-pin
FFC connector, so we name it with the k3-am62x- prefix.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  7 ++
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso | 84 ++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index f957b5f741ff..fd9166497c32 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 # Common overlays for SK-AM62* family of boards
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-tevi-ov5640.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-imx219.dtbo
 
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
@@ -91,18 +92,24 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
+	k3-am62x-sk-csi2-imx219.dtbo
 k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am625-sk-csi2-tevi-ov5640-dtbs := k3-am625-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am62a7-sk-csi2-imx219-dtbs := k3-am62a7-sk.dtb \
+	k3-am62x-sk-csi2-imx219.dtbo
 k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
+	k3-am625-sk-csi2-imx219.dtb \
 	k3-am625-sk-csi2-ov5640.dtb \
 	k3-am625-sk-csi2-tevi-ov5640.dtb \
+	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
 	k3-am62a7-sk-csi2-tevi-ov5640.dtb
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
new file mode 100644
index 000000000000..6f4cd73c2f43
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IMX219 (RPi v2) Camera Module
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	clk_imx219_fixed: imx219-xclk {
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
+			ov5640: camera@10 {
+				compatible = "sony,imx219";
+				reg = <0x10>;
+
+				clocks = <&clk_imx219_fixed>;
+				clock-names = "xclk";
+
+				reset-gpios = <&exp1 13 GPIO_ACTIVE_HIGH>;
+
+				port {
+					csi2_cam0: endpoint {
+						remote-endpoint = <&csi2rx0_in_sensor>;
+						link-frequencies = /bits/ 64 <456000000>;
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

