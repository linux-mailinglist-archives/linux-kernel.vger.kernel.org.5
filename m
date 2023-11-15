Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F87EBFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjKOJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjKOJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:52:44 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE1194;
        Wed, 15 Nov 2023 01:52:31 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qJ2Q105032;
        Wed, 15 Nov 2023 03:52:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700041939;
        bh=wqiNtajspM2Vcwa3njm3c9Igmlpl9oNUS/rMg4Wqd8g=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=bfbg7JGJ0/Xoclvgv5i/ZrcyWoYsQfgURUBH6fMrSicLunvfNESEUq1V7ChZQSKkO
         /KyruPnoOFUdnd5ifJ6oFvydux2EXPCFhDG6h5uQTYuxYTGNjARbDENg6pVdeqx+Sk
         2tuwfiu1GYM554TBBvNVc0q8CEB5/ZQ1Wnrtn5SI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF9qJcm101669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 03:52:19 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 03:52:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 03:52:19 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qI9o009800;
        Wed, 15 Nov 2023 03:52:19 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 15 Nov 2023 15:21:16 +0530
Subject: [PATCH 8/8] arm64: dts: ti: k3-am62x: Add overlay for IMX219
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231115-csi_dts-v1-8-99fc535b2bde@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=R4Pz6G6ZrGv5Qkr/jjdVZhmrMN2R5FPJxbqhP5Eaai0=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlVJS/gXlpcY1OXa45nzruOPwgoa2cibCigIosR
 jzoIrj03ACJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZVSUvwAKCRBD3pH5JJpx
 RUSkEACbCUIe52YaC5hFb01EK//gREfgKm0vNpRr7k0cREWxzwlVIGTa4hr3RlIj8hV6ScHAlBU
 J1H/a9NQ+oLi5gqov0tKDHd30bubuS4+9Mx2mLx8TH415QSv6z9upgXkELIE8eCjvW5Q4ig9unp
 sz2496uve83ylwKHnrJvi6uZPABlTLjAGxPa21QloenTR7SSVq1Fu32k0RZgRK9GWxdcBWYClKa
 GFbOreZg05sOIc6LseLACK/NhSbzW5b3TTxaJqCQiCJbR4EERLSDxZnNk6b9LJ0ty4n6iBzZqVc
 LSBUnDB86SeqPDlXCkc2rsx0WU+IQNZ+YwA2IvNquQOK9mEhD0h0G/guyObIKvuN7URr/0Eka9e
 fDcWHQarY8hdCzsylHSV34SsAViSuzOR9JG1B5GAexXlqPNF/XxlqxsIMgMtOgmMW9uelVzBsM8
 Vl9MzQPFkp8zu37baPMSFzj/Bm3B1TuY7cidA42n4sLz1tOT/sDE+AQM6dola6uhKsaFBcnXPvi
 JIwUif4Yhzgiux7ekwnzqJUEEvedQbEAfpNYPLcHF4KL/xD0VbU+I/3yCAwBE4S8KkatjrvVD3E
 i5mM5XLRiK7ylZ+jL9EVddikygH0mXxTEHSUC0bSvLiiLWWwaUK1kwwpafyOXVS9sLdDgpJMiFa
 MS0k7ARfHTg4JRw==
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

RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM62A
through the 22-pin CSI-RX connector.

Same overlay can be used across SK-AM62* boards that have a 15/22-pin
FFC connector, so we name it with the k3-am62x- prefix.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  4 ++
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso | 76 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index a09b16cbefb4..f89dcbe3c635 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -37,7 +37,10 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-sk-hdmi-audio.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-hdmi-audio.dtb
 
 # Boards with AM62Ax SoC
+k3-am62a7-sk-csi2-imx219-dtbs := k3-am62a7-sk.dtb \
+	k3-am62x-sk-csi2-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk-csi2-imx219.dtb
 
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
@@ -96,6 +99,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
+DTC_FLAGS_k3-am62a7-sk += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
new file mode 100644
index 000000000000..84d08bfda469
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
@@ -0,0 +1,76 @@
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

-- 
2.42.1

