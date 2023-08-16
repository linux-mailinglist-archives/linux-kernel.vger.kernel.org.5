Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB777E193
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbjHPM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245149AbjHPMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:25:22 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD526B8;
        Wed, 16 Aug 2023 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Z6bfjfoJhk4P9zQ+Hri48B3wgfIIzvzxvfHi2AL4Fdw=; b=kdy+FVdHjrZUfsToIy5tMLlmZn
        GVPrdifM/ybSl6ztexnLDSBA/c4jLehbt7DOaGbvB+iKOkvNNSwYgOCFSt7dh+taFAjgeuV8yh+HB
        W/DVu+FCRdIFLQ6sbybN/mPm6uMjUqnj8zIIyWdr0HaGexE3Xr0rt78shGR81V+alzyryqnE7lwMa
        NA/AsQ8DRM6B9jZOvRjl2nvLX+8dzYTrIzoPW0ytFlR5YJWbCM4PbgskwQPHuRL9kkrlIZrjoloOK
        aIyZJuZP6g6wh3mWS+1tHAj+SoI46ajkqcuUl4Rh8GZ2njwOLlYBXfUmY8PRc3y41SFO67eoQ+LnL
        rqawRorQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qWFaM-000NCJ-CJ; Wed, 16 Aug 2023 14:25:14 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qWFaL-000HIl-Kh; Wed, 16 Aug 2023 14:25:13 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     l.goehrs@pengutronix.de, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 9/9] ARM: dts: stm32: Add Octavo OSD32MP1-RED board
Date:   Wed, 16 Aug 2023 14:24:29 +0200
Message-ID: <20230816122435.3153513-9-sean@geanix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816122435.3153513-1-sean@geanix.com>
References: <20230816122435.3153513-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Octavo OSD32MP1-RED development board.

General features:
 - STM32MP157C
 - 512MB DDR3
 - CAN-FD
 - HDMI
 - USB-C OTG
 - UART

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
Changes since v4:
 - Fixed compile warnings

 arch/arm/boot/dts/st/Makefile                 |   3 +-
 .../boot/dts/st/stm32mp157c-osd32mp1-red.dts  | 225 ++++++++++++++++++
 2 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts

diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
index 44b264c399ec..94feb1f1d569 100644
--- a/arch/arm/boot/dts/st/Makefile
+++ b/arch/arm/boot/dts/st/Makefile
@@ -59,7 +59,8 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp157c-lxa-tac-gen1.dtb \
 	stm32mp157c-lxa-tac-gen2.dtb \
 	stm32mp157c-odyssey.dtb \
-	stm32mp157c-phycore-stm32mp1-3.dtb
+	stm32mp157c-phycore-stm32mp1-3.dtb \
+	stm32mp157c-osd32mp1-red.dtb
 dtb-$(CONFIG_ARCH_U8500) += \
 	ste-snowball.dtb \
 	ste-hrefprev60-stuib.dtb \
diff --git a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
new file mode 100644
index 000000000000..bd67a1db9122
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) Geanix ApS 2023 - All Rights Reserved
+ * Author: Sean Nyekjaer <sean@geanix.com>
+ */
+
+/dts-v1/;
+
+#include "stm32mp157.dtsi"
+#include "stm32mp15xc.dtsi"
+#include "stm32mp15xx-osd32.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+
+/ {
+	model = "Octavo OSD32MP1 RED board";
+	compatible = "oct,stm32mp157c-osd32-red", "oct,stm32mp15xx-osd32", "st,stm32mp157";
+
+	aliases {
+		serial0 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	led-controller-0 {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "heartbeat";
+			gpios = <&gpiod 11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&crc1 {
+	status = "okay";
+};
+
+&dts {
+	status = "okay";
+};
+
+&ethernet0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
+	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_a>;
+	phy-mode = "rgmii-id";
+	max-speed = <1000>;
+	phy-handle = <&phy0>;
+	st,eth-clk-sel;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@3 {
+			reg = <3>;
+		};
+	};
+};
+
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	status = "okay";
+	i2c-scl-rising-time-ns = <100>;
+	i2c-scl-falling-time-ns = <7>;
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	hdmi-transmitter@39 {
+		compatible = "sil,sii9022";
+		reg = <0x39>;
+		reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpiog>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ltdc_pins_e>;
+		pinctrl-1 = <&ltdc_sleep_pins_e>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				sii9022_in: endpoint {
+					remote-endpoint = <&ltdc_ep0_out>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				sii9022_tx_endpoint: endpoint {
+					remote-endpoint = <&i2s2_endpoint>;
+				};
+			};
+		};
+	};
+};
+
+&i2s2 {
+	clocks = <&rcc SPI2>, <&rcc SPI2_K>, <&rcc CK_PER>, <&rcc PLL3_R>;
+	clock-names = "pclk", "i2sclk", "x8k", "x11k";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2s2_pins_b>;
+	pinctrl-1 = <&i2s2_sleep_pins_b>;
+	status = "okay";
+
+	i2s2_port: port {
+		i2s2_endpoint: endpoint {
+			remote-endpoint = <&sii9022_tx_endpoint>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+		};
+	};
+};
+
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_ep0_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
+
+&m_can1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&m_can1_pins_d>;
+	pinctrl-1 = <&m_can1_sleep_pins_d>;
+	status = "okay";
+};
+
+&pwr_regulators {
+	vdd-supply = <&vdd>;
+	vdd_3v3_usbfs-supply = <&vdd_usb>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	cd-gpios = <&gpioe 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	disable-wp;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_d>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_d>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+	bus-width = <8>;
+	vmmc-supply = <&v3v3>;
+	vqmmc-supply = <&vdd>;
+	mmc-ddr-3_3v;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-1 = <&uart4_sleep_pins_a>;
+	pinctrl-2 = <&uart4_idle_pins_a>;
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+};
+
+&usbh_ehci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+	status = "okay";
+};
+
+&usbh_ohci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+	status = "okay";
+};
+
+&usbotg_hs {
+	vbus-supply = <&vbus_otg>;
+};
+
+&usbphyc {
+	status = "okay";
+};
+
+&usbphyc_port0 {
+	phy-supply = <&vdd_usb>;
+};
+
+&usbphyc_port1 {
+	phy-supply = <&vdd_usb>;
+};
-- 
2.41.0

