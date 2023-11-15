Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C27EBFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjKOJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjKOJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:52:37 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2763132;
        Wed, 15 Nov 2023 01:52:29 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qGBj105013;
        Wed, 15 Nov 2023 03:52:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700041936;
        bh=mRAU8jI1AioMbrAdlPtsoL9voWGDmm90R0csjxrNMiU=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Eiz9mSNQjFDuSnR/wZ3nkrtMxA0edHUUpey+Wqzzuq3nPsFvtuYSWVWRpV6P0bhc6
         H3uhhIxAX4qWsgrTeWF7LX4ybgmLp6x5rXHdDTjkuCKoTwpbhS8LFsitoAkolieLR9
         LE0QL3kug0hDQcxSyyGRNL83wi+czL5KryrIOoGI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF9qGNr009537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 03:52:16 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 03:52:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 03:52:16 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qFAY015928;
        Wed, 15 Nov 2023 03:52:16 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 15 Nov 2023 15:21:14 +0530
Subject: [PATCH 6/8] arm64: dts: ti: k3-am62x: Add overlays for OV5640
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231115-csi_dts-v1-6-99fc535b2bde@ti.com>
References: <20231115-csi_dts-v1-0-99fc535b2bde@ti.com>
In-Reply-To: <20231115-csi_dts-v1-0-99fc535b2bde@ti.com>
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
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5592; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=eqhyf+uTzMZydQCtlSszufOlsILQBZP8e0W07wHu1xQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlVJS9af+KiODBJGNKHtclYi4BUTdj7gTzeN4AL
 ZqYNZ3BKZGJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZVSUvQAKCRBD3pH5JJpx
 RR+TD/4g3HZLufjMw2MIBfInj2SEXJQwupGuReGHTVN2roIXuOS5qKxmQbHRIgDbD/2XMS8XpU6
 v22J+Pruzcuv/AQd+TGXdZ2AkRUQ4rfSHoVblwnXi82JjPnM+QsgwPfrlE2MlxMuJ4pAd6iiCF/
 7yDpPbfJB3FMgd6PllcoNU0+LLKPT5KMr/nR5DLptEwz3uzO+G2tYnF7sF8OvUvb0G1sAtNGPTX
 Nfj02MLPtQo4KDKHL+VXynXpY8hDeGpjBtYNZBEjTy5QSFqXR+iCYpFal5DNZKA33Lm4nIgMc2F
 TAjLQIzqMx1KWaBQk26xnpDziLO8y6LcU9d3lksNmLGLK+iR+BoI19hb+BWPpK0NxhC4QUuVPDx
 psXTqSHeK4UZ4H/H8Rqo9QZP//3I7yqQ4i0KvNNon/WDsAtXIL1p9BGm4GWz8GUMiqcS3robs0+
 wGTRtJHkdHX7zVwmvVwS4VeU4hmIyFmkEwpnmEQH9XYWU/pyw2jk5PMxc/npxfbZxFP9khvdrjX
 dvH0gUOUDw63VpvbOEXajIVpA4sIaDMw1IF5IhFQGGbqXmrEJ9sN1EXzyubSvm1CYyAerz/Pkkw
 d6w26lyTAkSyMsj+7tSF6AtFhrdCe08h7RCeYRDhPCS/qdoslsvKD/2/6kCHSbJfZdqVvnXpkUX
 Ny850iU8XerDWbg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  6 ++
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso | 74 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso  | 74 ++++++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e49e32414560..a09b16cbefb4 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -13,6 +13,10 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
+	k3-am62x-sk-csi2-ov5640.dtbo
+k3-am625-sk-csi2-tevi-ov5640-dtbs := k3-am625-sk.dtb \
+	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am62-lp-sk-hdmi-audio-dtbs := k3-am62-lp-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
@@ -20,6 +24,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-sk-csi2-ov5640.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-sk-csi2-tevi-ov5640.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-yavia.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
new file mode 100644
index 000000000000..790340673094
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
@@ -0,0 +1,74 @@
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
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
new file mode 100644
index 000000000000..d7772767f49d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
@@ -0,0 +1,74 @@
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

-- 
2.42.1

