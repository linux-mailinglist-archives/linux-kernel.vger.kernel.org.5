Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFFB7EBFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjKOJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjKOJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:52:44 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA418E;
        Wed, 15 Nov 2023 01:52:31 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qEi3100732;
        Wed, 15 Nov 2023 03:52:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700041934;
        bh=0egtVVfTMmKrQOnxNs4fOcJmVsBrZtzSGTcVwpwUzS0=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Vs3lrv+qJiu7wZzRjCtJ/nKQQIpG1lfpVoJ0AGhGdr65Uu6YN30dM4cwbuxUKBVM+
         ypgx7j3fhBYUeFWbPPgGxzitH0gcUuUa2qNIQi1Qai3rWNqZlZGK4IfYqoawxmZz68
         +ugLiFsE5ElvaDLfwQvl69LxtuQat+uGZ99dqJEY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF9qEZt101616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 03:52:14 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 03:52:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 03:52:13 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qCQP009743;
        Wed, 15 Nov 2023 03:52:13 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 15 Nov 2023 15:21:12 +0530
Subject: [PATCH 4/8] arm64: dts: ti: k3-am625-beagleplay: Add overlays for
 OV5640
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231115-csi_dts-v1-4-99fc535b2bde@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5305; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=qrgb8ErCemuQw6kO4MMScDp+qbZjHNTYyfKmJCDO+tY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlVJS71S0sZoUF0Zqgws5oCFaXuASw65z50x9In
 IYkU5mLKsOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZVSUuwAKCRBD3pH5JJpx
 RRlUD/9k7sSdh2NuqxLo6Rr16CxndXjTnFqbFI/Gt+TmPsra5SVhnsDBQpp9Do41IuZLrFLeljR
 f2HGpEtG2wZoUbqavAbSlShe1tRA7ureh1fTJe6grdLe8zS9mbLN7Ihwx9QYLQvyezcCuvMTeLF
 n+KKXTeWq9IzRtLmSN89xCkuNUx6NT/SXZNRAdDrFR/EEhEaxB/WVfP9rv/NfLVl8L5zw7XV7ly
 tw0kzyP6saSd2PkiOU1mKtnv1LgRCaZM7Kh7IVg2Hz9J1XsL5c6N+Sj0CfpoceagiA0nLb069R5
 ZuDDbB+YFwv8tZ5p7586PxS8HzVBRyWImIydS8YJR+k0cL1xmU1AN9/VEijPrsCmu9oQdjzVcj9
 0KQbJDqXBE4vBIRwDMaV9ncjQM7zlpNzH5kEh2u5bADCdqdW/e8ptafDNYexipTl43dJr0NLG4z
 4tSC0xkS4UBOIA+SnER87vzYNq2qTPJLv82ve28YzVCaG8umbm5lMo7fPu9FdYzxQyK3ec9bVO+
 frnR3nv5KDHb13XcLprIBTv/T1gcZVBhAlgKH5FYGSP48vH+/mm+m/pfAuxavZKXuF6oK47sg8y
 92cKxL6uqpi4Nql02rbHBhvP4ZkL9qvCi4XRDAY2Fkf12LQKkwIhhNyHwaBeuYYjPi5cQoFzY4W
 CL2GDR1X2ci167w==
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

Three different OV5640 modules are supported using the FFC connector on
BeaglePlay:
- Digilent PCam 5C
- ALINX AN5641
- TEVI-OV5640-*-RPI

The Digilent and ALINX modules supply a 12Mhz XCLK to the sensor, while
the TEVI module supplies a 24Mhz XCLK, thus requiring a separate
overlay.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  7 ++
 .../dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso    | 77 ++++++++++++++++++++++
 .../ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso   | 77 ++++++++++++++++++++++
 3 files changed, 161 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 77a347f9f47d..e49e32414560 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -9,9 +9,15 @@
 # alphabetically.
 
 # Boards with AM62x SoC
+k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
+	k3-am625-beagleplay-csi2-ov5640.dtbo
+k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
+	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
 k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am62-lp-sk-hdmi-audio-dtbs := k3-am62-lp-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
@@ -81,6 +87,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
+DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
new file mode 100644
index 000000000000..5e80ca7033ba
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALINX AN5641 & Digilent PCam 5C - OV5640 camera module
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
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
+&main_gpio0 {
+	p11-hog {
+		/* P11 - CSI2_CAMERA_GPIO1 */
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI2_CAMERA_GPIO1";
+	};
+};
+
+&wkup_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+
+		clocks = <&clk_ov5640_fixed>;
+		clock-names = "xclk";
+
+		port {
+			csi2_cam0: endpoint {
+				remote-endpoint = <&csi2rx0_in_sensor>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
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
+&dphy0 {
+	status = "okay";
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
new file mode 100644
index 000000000000..5e1cbbc27c8f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Technexion TEVI-OV5640-*-RPI - OV5640 camera module
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
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
+&main_gpio0 {
+	p11-hog {
+		/* P11 - CSI2_CAMERA_GPIO1 */
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "CSI2_CAMERA_GPIO1";
+	};
+};
+
+&wkup_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+
+		clocks = <&clk_ov5640_fixed>;
+		clock-names = "xclk";
+
+		port {
+			csi2_cam0: endpoint {
+				remote-endpoint = <&csi2rx0_in_sensor>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
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
+&dphy0 {
+	status = "okay";
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};

-- 
2.42.1

