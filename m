Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E4807191
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378854AbjLFOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378774AbjLFOBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:01:14 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3FD4B;
        Wed,  6 Dec 2023 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1701871278; x=1733407278;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jYMk20e6zsdcf2146arEHLH9eleRXIKIs54TB4rqVzk=;
  b=PTQCw7536JTrV0C2HWvpdLEo1t/VMJXfd/uPb/0jfJ/bPpAtEvC9acnT
   +3S1Hf3EF4aMDcGdrRxXtyHDpqKIUVzR1wjgAF8KKeYRtxCefELJ30Dpl
   f7BZ6Bv1rbkM9PU0qMfh9BE8Bfg8kFDS7sjC9QO7JM6rIYeVnaLGqTr3A
   hmEf3JvHllxqEuB664xADAaJxwnwWblCoXKR3K3rkCn3v7Ii6NrtONUdm
   Pzemp4ip38vO0bKtvI6iAGTX/GAki1oNleheHh2dTnSMCrEkv+OdBzV3V
   yg9Tb2UBoJf0fBj+LDqpt7yYzL8J4RXQsAnE3Sfvtlp7X3umJkzQ4Z1Yi
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,255,1695679200"; 
   d="scan'208";a="34361965"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Dec 2023 15:01:12 +0100
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DF51C280085;
        Wed,  6 Dec 2023 15:01:11 +0100 (CET)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date:   Wed, 06 Dec 2023 15:01:02 +0100
Subject: [PATCH 2/2] arm64: dts: freescale: add fsl-lx2160a-mblx2160a board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-for-ml-tqmlx2160a-v1-2-622e41ae4d8e@ew.tq-group.com>
References: <20231206-for-ml-tqmlx2160a-v1-0-622e41ae4d8e@ew.tq-group.com>
In-Reply-To: <20231206-for-ml-tqmlx2160a-v1-0-622e41ae4d8e@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701871271; l=16834;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=3chxoNecwdlddVZLZzw5CnJHOm5uBHpdgv2GieKkh3M=;
 b=iAisiivLI6oqhlk4Ze3QRnVLSwFXqaVjy5RAwW3Hxr6XNI6COvv4OyQCtPVQHTWpgpc9etANM
 52pxlipD4jsApP9VfGgKNHs6qL04uhYgQbRddJUb0H7KqITIQknNBui
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the different serdes configurations as overlays.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |  26 ++
 .../freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts | 338 +++++++++++++++++++++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtso   |  29 ++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtso   |  17 ++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtso   |  49 +++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtso    |  55 ++++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtso    |  47 +++
 .../boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi |  97 ++++++
 8 files changed, 658 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 300049037eb0..cc30e6dc9f64 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -53,6 +53,32 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-85bb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-899b.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-9999.dtb
 
+fsl-lx2160a-tqmlx2160a-mblx2160a-12-11-x-dtbs := fsl-lx2160a-tqmlx2160a-mblx2160a.dtb \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtbo \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtbo
+fsl-lx2160a-tqmlx2160a-mblx2160a-12-7-x-dtbs := fsl-lx2160a-tqmlx2160a-mblx2160a.dtb \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtbo \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtbo
+fsl-lx2160a-tqmlx2160a-mblx2160a-12-8-x-dtbs := fsl-lx2160a-tqmlx2160a-mblx2160a.dtb \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtbo \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtbo
+fsl-lx2160a-tqmlx2160a-mblx2160a-14-7-x-dtbs := fsl-lx2160a-tqmlx2160a-mblx2160a.dtb \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtbo \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtbo
+fsl-lx2160a-tqmlx2160a-mblx2160a-14-8-x-dtbs := fsl-lx2160a-tqmlx2160a-mblx2160a.dtb \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtbo \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtbo
+fsl-lx2160a-tqmlx2160a-mblx2160a-14-11-x-dtbs := fsl-lx2160a-tqmlx2160a-mblx2160a.dtb \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtbo \
+	fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtbo
+
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-12-11-x.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-12-8-x.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-12-7-x.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-14-11-x.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-14-8-x.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-tqmlx2160a-mblx2160a-14-7-x.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
new file mode 100644
index 000000000000..da0f58e26b9a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+#include "fsl-lx2160a-tqmlx2160a.dtsi"
+
+/ {
+	model = "TQ Systems GmbH MBLX2160A Starterkit";
+	compatible = "tq,lx2160a-tqmlx2160a-mblx2160a", "tq,lx2160a-tqmlx2160a",
+		     "fsl,lx2160a";
+
+	aliases {
+		mmc0 = &esdhc0;
+		mmc1 = &esdhc1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-user1 {
+			label = "button:user1";
+			gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_F1>;
+		};
+
+		button-user2 {
+			label = "button:user2";
+			gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_F2>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-user1 {
+			gpios = <&gpioex1 15 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_HEARTBEAT;
+			function-enumerator = <0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-user2 {
+			gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_HEARTBEAT;
+			function-enumerator = <1>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	sfp_xfi1: sfp-xfi1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&xfi1_i2c>;
+		mod-def0-gpios = <&gpioex2 2 GPIO_ACTIVE_LOW>;
+		los-gpios = <&gpioex2 3 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpioex2 0 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpioex2 1 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	sfp_xfi2: sfp-xfi2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&xfi2_i2c>;
+		mod-def0-gpios = <&gpioex2 6 GPIO_ACTIVE_LOW>;
+		los-gpios = <&gpioex2 7 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpioex2 4 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpioex2 5 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&dpmac17 {
+	phy-handle = <&dp83867_2_3>;
+	phy-connection-type = "rgmii-id";
+};
+
+&dpmac18 {
+	phy-handle = <&dp83867_2_4>;
+	phy-connection-type = "rgmii-id";
+};
+
+&emdio1 {
+	status = "okay";
+
+	dp83867_1_1: ethernet-phy@1 {
+		reg = <1>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_1_2: ethernet-phy@2 {
+		reg = <2>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_1_3: ethernet-phy@3 {
+		reg = <3>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_1_4: ethernet-phy@4 {
+		reg = <4>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_1_5: ethernet-phy@5 {
+		reg = <5>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_1_6: ethernet-phy@6 {
+		reg = <6>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+};
+
+&emdio2 {
+	status = "okay";
+
+	dp83867_2_1: ethernet-phy@1 {
+		reg = <1>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_2_2: ethernet-phy@2 {
+		reg = <2>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_2_3: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	dp83867_2_4: ethernet-phy@4 {
+		reg = <4>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+};
+
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	no-mmc;
+	no-sdio;
+	wp-gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&i2c0 {
+	gpioex3: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		vcc-supply = <&reg_vcc3v3>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	mux@70 {
+		compatible = "nxp,pca9544";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&reg_vcc3v3>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpioex0: gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				vcc-supply = <&reg_vcc3v3>;
+			};
+
+			gpioex1: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				vcc-supply = <&reg_vcc3v3>;
+			};
+
+			gpioex2: gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				vcc-supply = <&reg_vcc3v3>;
+			};
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	mux@70 {
+		compatible = "nxp,pca9544";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&reg_vcc3v3>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		xfi1_i2c: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		xfi2_i2c: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&pcs_mdio17 {
+	status = "okay";
+};
+
+&pcs_mdio18 {
+	status = "okay";
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
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usb0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb451,8142";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpioex1 0 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&reg_vcc3v3>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb451,8140";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpioex1 0 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&reg_vcc3v3>;
+	};
+};
+
+&usb1 {
+	dr_mode = "otg";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtso b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtso
new file mode 100644
index 000000000000..8284a564e20d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtso
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger
+ */
+
+/dts-v1/;
+/plugin/;
+
+&dpmac9 {
+	phy-handle = <&dp83867_2_1>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&dpmac10 {
+	phy-handle = <&dp83867_2_2>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&pcs_mdio9 {
+	status = "okay";
+};
+
+&pcs_mdio10 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtso b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtso
new file mode 100644
index 000000000000..636b17a383ed
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtso
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger
+ */
+
+/dts-v1/;
+/plugin/;
+
+&dpmac1 {
+	managed = "in-band-status";
+};
+
+&pcs_mdio1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtso b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtso
new file mode 100644
index 000000000000..6d0c808cd840
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtso
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger
+ */
+
+/dts-v1/;
+/plugin/;
+
+&dpmac12 {
+	phy-handle = <&dp83867_1_1>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&dpmac13 {
+	phy-handle = <&dp83867_1_5>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&dpmac14 {
+	phy-handle = <&dp83867_1_6>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&dpmac16 {
+	phy-handle = <&dp83867_1_4>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&pcs_mdio12 {
+	status = "okay";
+};
+
+&pcs_mdio13 {
+	status = "okay";
+};
+
+&pcs_mdio14 {
+	status = "okay";
+};
+
+&pcs_mdio16 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtso b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtso
new file mode 100644
index 000000000000..db88a86ff69c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtso
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger
+ */
+
+/dts-v1/;
+/plugin/;
+
+&dpmac12 {
+	phy-handle = <&dp83867_1_1>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&dpmac13 {
+	sfp = <&sfp_xfi1>;
+	managed = "in-band-status";
+};
+
+&dpmac14 {
+	sfp = <&sfp_xfi2>;
+	managed = "in-band-status";
+};
+
+&dpmac16 {
+	phy-handle = <&dp83867_1_4>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+};
+
+&pcs_mdio12 {
+	status = "okay";
+};
+
+&pcs_mdio13 {
+	status = "okay";
+};
+
+&pcs_mdio14 {
+	status = "okay";
+};
+
+&pcs_mdio16 {
+	status = "okay";
+};
+
+&sfp_xfi1 {
+	status = "okay";
+};
+
+&sfp_xfi2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtso b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtso
new file mode 100644
index 000000000000..f6dfa76aa0e7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtso
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger
+ */
+
+/dts-v1/;
+/plugin/;
+
+&dpmac13 {
+	sfp = <&sfp_xfi1>;
+	managed = "in-band-status";
+};
+
+&dpmac14 {
+	sfp = <&sfp_xfi2>;
+	managed = "in-band-status";
+};
+
+&pcs_mdio13 {
+	status = "okay";
+};
+
+&pcs_mdio14 {
+	status = "okay";
+};
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sfp_xfi1 {
+	status = "okay";
+};
+
+&sfp_xfi2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
new file mode 100644
index 000000000000..89a4765737b4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger
+ */
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	reg_vcc3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+
+&emdio1 {
+	status = "okay";
+};
+
+&emdio2 {
+	status = "okay";
+};
+
+&esdhc1 {
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&fspi {
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <10000000>;
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+
+	flash1: flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <10000000>;
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&i2c0 {
+	scl-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	sensor0: temperature-sensor@1f {
+		compatible = "nxp,se97", "jedec,jc-42.4-temp";
+		reg = <0x1f>;
+	};
+
+	eeprom1: eeprom@57 {
+		compatible = "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+		read-only;
+		vcc-supply = <&reg_vcc3v3>;
+	};
+
+	rtc: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
+	};
+
+	eeprom2: eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+		vcc-supply = <&reg_vcc3v3>;
+	};
+};

-- 
2.34.1

