Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7287802B69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjLDFnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjLDFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:43:36 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36902B3;
        Sun,  3 Dec 2023 21:43:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so2133379a12.2;
        Sun, 03 Dec 2023 21:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701668620; x=1702273420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+Lt2/w53QFhAeC2Gx6Xq11nv10LYTDt+AYI2ixh/rs=;
        b=ZNfik9DTxIpQBlaIeCTlr5EbYCJyRBApMKzncjnJP1K2o579HPr1S+iYp2xedkGlY2
         HKM96NpNqrdUh43AHIqFgaDudURret9zX8VitN50Xcn22t1XoTxdnGLOdkk0qU/iwexN
         nbwqG55ajom+wLq/kUbrzRoeYicqnsD5PnDI5VlXavcUOwY10L92yi9FUiNOowBJ1BmC
         35VprMB+syCm/llhbd/tl5uYQaKT514f9f2UTbA7UyFwswkzJm3PxjrG+aZTpfkcEzPu
         zJmD9ezjw/q65yn/WQZja6c7JroqU6M5QmqDt/z4RJExwfRHRANVLB4EA9JHCtiRIITy
         5g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701668620; x=1702273420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+Lt2/w53QFhAeC2Gx6Xq11nv10LYTDt+AYI2ixh/rs=;
        b=eSdsa3XfBw+GZoJnFLTIaghPaM/fV6HvvDMM2sPMZiQUih4HYo6gURoE64uxgxN1Xo
         jGPTejBUsAisO7bs/Jk1hI97DwGB8Nnm7DuzSFW2ku9WqMucDuOr+xtCFZLSBIV1fqb9
         0VhBTrm9JFJksbh8x/cWSwIGUiGGF5h4NajLD9JActi3YUfSN0T9TqeQhMpTerIdZvPn
         sYQUdWHwi+7KKypiq+crGU/PZ/8qR11OfOisWagPT0k1/PgLEd0glWCeC7LYWp+A0NVf
         pEl7Zh6mq4pQ19wcV5iKOwZ5z2yQA9mwF50Y8BUOdqtmM0UwoOXBYLUPU3wXpQJ309O/
         Ou7A==
X-Gm-Message-State: AOJu0YygZKU0oOfDDxvgpWaEwQYimSrNRPuTPrDbqGUz4lQQYeEuO0ne
        b64MOXVTe5YobH8ob4JOaAwB9zuRrTc=
X-Google-Smtp-Source: AGHT+IGwPPgA1vYV7inz4QMY8szcmSXBYZ0LTogUmxdFrOjQdSjaP7elTnNUq2N9eqyXsi12iIJblA==
X-Received: by 2002:a05:6a20:42a2:b0:18f:97c:8a27 with SMTP id o34-20020a056a2042a200b0018f097c8a27mr5482231pzj.82.1701668620558;
        Sun, 03 Dec 2023 21:43:40 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b24-20020aa78718000000b006cb60b188basm6706655pfo.206.2023.12.03.21.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:43:40 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
X-Google-Original-From: Peter Yin <peter.yin@quantatw.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] ARM: dts: aspeed: Minerva Harma: Add Facebook Minerva Harma (AST2600) BMC
Date:   Mon,  4 Dec 2023 13:41:31 +0800
Message-Id: <20231204054131.1845775-3-peter.yin@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204054131.1845775-1-peter.yin@quantatw.com>
References: <20231204054131.1845775-1-peter.yin@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Yin <peteryin.openbmc@gmail.com>

Add linux device tree entry related to
Minerva Harma specific devices connected to BMC SoC.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 595 ++++++++++++++++++
 2 files changed, 596 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 23cbc7203a8e..dfb4905cb14d 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-fuji.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-greatlakes.dtb \
+	aspeed-bmc-facebook-minerva-harma.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
new file mode 100644
index 000000000000..5a1c14412458
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2023 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Minerva Harma";
+	compatible = "facebook,minerva-harma", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart6;
+		serial2 = &uart2;
+		serial4 = &uart5;
+
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 2>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "fp_id_amber ";
+			default-state = "off";
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+// HOST BIOS Debug
+&uart1 {
+	status = "okay";
+};
+
+// SOL Host Console
+&uart2 {
+	status = "okay";
+	pinctrl-0 = <>;
+};
+
+// SOL BMC Console
+&uart4 {
+	status = "okay";
+	pinctrl-0 = <>;
+};
+
+// BMC Debug Console
+&uart5 {
+	status = "okay";
+};
+
+// MTIA
+&uart6 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+	virtual;
+	port=<0x3e8>;
+	sirq = <7>;
+	sirq-polarity = <0>;
+	dma-mode;
+	dma-channel = <12>;
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	no-hw-checksum;
+	use-ncsi;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	mlx,multi-host;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+// BIOS Flash
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <12000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	max31790@30{
+		compatible = "max31790";
+		reg = <0x30>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	tmp75@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	max31790@30{
+		compatible = "max31790";
+		reg = <0x30>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux21: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	// PDB FRU
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
+
+	delta_brick@69 {
+		compatible = "pmbus";
+		reg = <0x69>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux22: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux23: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+
+	gpio@30 {
+		compatible = "nxp,pca9555";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+	gpio@31 {
+		compatible = "nxp,pca9555";
+		reg = <0x31>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+	// PTTV FRU
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9545";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			//MB FRU
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+		};
+		imux30: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		imux31: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+// To Debug card
+&i2c14 {
+	status = "okay";
+	multi-master;
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c15 {
+	status = "okay";
+
+	// SCM FRU
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	// BSM FRU
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&adc0 {
+	aspeed,int-vref-microvolt = <2500000>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	aspeed,int-vref-microvolt = <2500000>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc10_default>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","",
+			"FM_BMC_MUX_CS_SPI_SEL_0","FM_ID_LED_N","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","SOL_UART_SET","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
+			"LED_POSTCODE_2","LED_POSTCODE_3",
+			"LED_POSTCODE_4","LED_POSTCODE_5",
+			"LED_POSTCODE_6","LED_POSTCODE_7",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"FP_SYS_PWRBTN_IN_N","BMC_SYS_PWRBTN_OUT_N",
+			"FP_RST_BTN_IN_N","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","BAT_DETECT","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&sgpiom0 {
+	status = "okay";
+	max-ngpios = <128>;
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+	gpio-line-names =
+	/*in - out - in - out */
+	/*A0-A3 line 0-7*/
+	"FM_SCM_CABLE_PRSNT_N","FM_PWRDIS_E1S_0",
+	"FM_EXP_AUX_PWR_EN","",
+	"FM_EXP_MAIN_PWR_EN","FM_PWRDIS_E1S_1",
+	"PWRGD_EXP_PWR","",
+	/*A4-A7 line 8-15*/
+	"PWRGD_P12V_MEM","FM_MODULE_PWR_EN",
+	"PWRGD_P3V3_STBY","FM_HOST_PWRGD",
+	"PWRGD_P1V8","FM_CRD_PWRGD_L",
+	"FM_PRSNT_CPU_N","FM_SMI_ACTIVE_N",
+	/*B0-B3 line 16-23*/
+	"FM_PVDD33_S5_EN","BMC_CPU_NMI_N",
+	"RGD_PVDD33_S5","NMI_SYNC_FLOOD_N",
+	"FM_PVDD18_S5_EN","",
+	"PWRGD_PVDD18_S5","",
+	/*B4-B7 line 24-31*/
+	"PWRGD_SB_STBY_PWROK","FM_CPU_SP5R1",
+	"RST_RSMRST_PLD_N","FM_CPU_SP5R2",
+	"SYS_SCM_PWRBTN_N","FM_CPU_SP5R3",
+	"SYS_PWRBTN_N","FM_CPU_SP5R4",
+	/*C0-C3 line 32-39*/
+	"FM_SLPS5_PLD_N","FM_CPU0_SA0",
+	"FM_SLPS3_PLD_N","FM_CPU0_SA1",
+	"FM_PVDD11_S3_EN","FM_RT_CPU0_P0_LVS_EN",
+	"PWRGD_CHGK","FM_RT_CPU0_P1_LVS_EN",
+	/*C4-C7 line 40-47*/
+	"PWRGD_CHAE","FM_SMB_RT_ROM_P0_SEL",
+	"PWRGD_PVDD11_S3","FM_SMB_RT_ROM_P1_SEL",
+	"PVDDCR_CPU0_EN","FM_I3C_CPU_MUX0_OE_N",
+	"PWRGD_PVDDCR_CPU0","FM_I3C_CPU_MUX0_SEL",
+	/*D0-D3 line 48-55*/
+	"PVDDCR_CPU1_EN","FM_I3C_CPU_MUX1_OE_N",
+	"PWRGD_PVDDCR_CPU1","FM_I3C_CPU_MUX1_SEL",
+	"PVDDCR_SOC_EN","RST_BMC_N",
+	"PWRGD_PVDDCR_SOC","RST_MUX_CPU0_P0_N",
+	/*D4-D7 line 56-63*/
+	"PVDDIO_EN","RST_MUX_CPU0_P1_N",
+	"PWRGD_PVDDIO","RST_MUX_E1S_N",
+	"PLD_SYS_POWER_GOOD","RST_MUX_MB_N",
+	"FM_CPU_PWR_GOOD","RST_SMB_E1S_0_N",
+	/*E0-E3 line 64-71*/
+	"FM_PWRGD_CPU_PWROK","RST_SMB_E1S_1_N",
+	"PLD_BIOS_POST_CMPLT_N","RST_SRST_CPLD_SCM_N",
+	"FM_PRSNT_E1S_0_N","RST_USB_HUB_R_N",
+	"FM_E1S_0_EN","BMC_RST_BTN_OUT_N",
+	/*E4-E7 line 72-79*/
+	"FM_PRSNT_E1S_1_N","RST_CPU_KBRST_N",
+	"FM_E1S_1_EN","RST_PLTRST_SCM_N",
+	"FM_P0V9_RT_EN1","BMC_JTAG_MUX_SEL_0",
+	"PWRGD_P0V9_RT1","BMC_JTAG_MUX_SEL_1",
+	/*F0-F3 line 80-87*/
+	"FM_P0V9_RT_EN2","BMC_JTAG_SEL",
+	"PWRGD_P0V9_RT2","BMC_READY_N",
+	"FM_P1V8_CPU1_RT_EN","BMC_SGPIO_READY",
+	"PWRGD_P1V8_CPU1_RT","FM_RT_CPU0_P0_LVS_EN_FORCE",
+	/*F4-F7 line 88-95*/
+	"FM_MODULES_0_PRSNT1_N","FM_RT_CPU0_P1_LVS_EN_FORCE",
+	"FM_MODULES_1_PRSNT1_N","FM_BIOS_MRC_DEBUG_MSG_DIS",
+	"FM_PWRGD_MODULE","",
+	"FM_CMM_PRS_L","",
+	/*G0-G3 line 96-103*/
+	"FM_CPU_CORETYPE2","",
+	"FM_CPU_CORETYPE1","",
+	"FM_CPU_CORETYPE0","",
+	"FM_BOARD_REV_ID5","",
+	/*G4-G7 line 104-111*/
+	"FM_BOARD_REV_ID4","",
+	"FM_BOARD_REV_ID3","",
+	"FM_BOARD_REV_ID2","",
+	"FM_BOARD_REV_ID1","",
+	/*H0-H3 line 112-119*/
+	"FM_BOARD_REV_ID0","",
+	"FM_FAN_0_PWRGD_L","",
+	"FM_FAN_1_PWRGD_L","",
+	"FM_UART_SCM_BUF_0_EN","",
+	/*H4-H7 line 120-127*/
+	"FM_UART_SCM_BUF_1_EN","",
+	"FM_EXP_PRSNT3_N","",
+	"FM_EXP_PRSNT2_N","",
+	"FM_EXP_PRSNT1_N","",
+	/*I0-I3 line 128-135*/
+	"FM_EXP_PRSNT0_N","",
+	"FM_EXP_SLOT_ID1","",
+	"FM_EXP_SLOT_ID0","",
+	"FM_FORCE_POWERON_N","",
+	/*I4-I7 line 136-143*/
+	"FM_P5V_USB_SW_EN_N","",
+	"FM_JTAG_SCM_SEL","",
+	"FM_RST_CPU_RESET_N","",
+	"FM_SOL_UART_CH_SEL","",
+	/*J0-J3 line 144-151*/
+	"RST_MB_STBY_SCM_N","",
+	"","",
+	"RST_PCIE_MODULES_PERST0","",
+	"RST_ROT_CPU","",
+	/*J4-J7 line 152-159*/
+	"SLOT_ID_BCB_0","",
+	"SLOT_ID_BCB_1","",
+	"SLOT_ID_BCB_2","",
+	"SLOT_ID_BCB_3","",
+	/*K0-K3 line 160-167*/
+	"FM_RT_CPU0_P0_LVS_EN_R","",
+	"FM_RT_CPU0_P1_LVS_EN_R","",
+	"","","","",
+	/*K4-K7 line 168-175*/
+	"","","","","","","","",
+	/*L0-L3 line 176-183*/
+	"","","","","","","","",
+	/*L4-L7 line 184-191*/
+	"","","","","","","","",
+	/*M0-M3 line 192-199*/
+	"","","","","","","","",
+	/*M4-M7 line 200-207*/
+	"","","","","","","","",
+	/*N0-N3 line 208-215*/
+	"","","","","","","","",
+	/*N4-N7 line 216-223*/
+	"","","","","","","","",
+	/*O0-O3 line 224-231*/
+	"","","","","","","","",
+	/*O4-O7 line 232-239*/
+	"","","","","","","","",
+	/*P0-P3 line 240-247*/
+	"","","","","","","","",
+	/*P4-P7 line 248-255*/
+	"","","","","","","","";
+};
-- 
2.25.1

