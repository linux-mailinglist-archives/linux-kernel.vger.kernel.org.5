Return-Path: <linux-kernel+bounces-165877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1718B92CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7582841AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44E171A4;
	Thu,  2 May 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="nw9XPRtH"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056B290F;
	Thu,  2 May 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609761; cv=none; b=p3PM96JwSVCUJzVHUVbXgEeBfqH1DTr1JtHLpbv5vvNi7scNuEPOTDj9m/Yr4zZ7fbjsRRW2ZpChRqX2TtJ0CZAALt/ODf9eYu9Iwh9I6cbOawX18qnlG6ONHLafKrssvwFHjtEiBpHybUEw/tomyTAOiE9qsyIya4xwKSzGk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609761; c=relaxed/simple;
	bh=5qRy7a3IslFdALZquRF0rHqjpVRo8zplgpUqUxvmvn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+zI74s82ZUuO67QrFdA6X/uMWqMPAsvl/A7N3d36LE2y71z0IWiSVlMSBTmgKbpVY0pc/mZhhLw/SCutRuUUS2s5bUfSNPH1W3r1O7liAztRb5zfEgrHFmT3rdVK7ZmeqEpxHLtW1kQ8fU2ZcweC8G9KvZ3PTyorVZw5PVI19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=nw9XPRtH; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 7EF9B43FA;
	Wed,  1 May 2024 17:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1714609759;
	bh=45Dv04icT8AaPzWT2HEdAqaXcoII+i9PD1RJizAq29k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nw9XPRtHMXKSrU/GyiR98Qav579JQCp0WPhZVl11rHKHYwi5e3gYw1Myb8OLCTf5o
	 vObdO3MmORAyleIdEAw5qVK87X51mYar5CVIacIALnhXYXd429aEzkhd0D21YedCym
	 y4ngFeRz94g/qkidaM2kFxk0+Ddhl3vqosZmSrpU=
From: Zev Weiss <zev@bewilderbeest.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v3 3/3] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
Date: Wed,  1 May 2024 17:28:33 -0700
Message-ID: <20240502002836.17862-8-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502002836.17862-5-zev@bewilderbeest.net>
References: <20240502002836.17862-5-zev@bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the E3C246D4I, this is a reasonably affordable off-the-shelf
mini-ITX AST2500/Xeon motherboard with good potential as an OpenBMC
development platform.  Booting the host requires a modicum of eSPI
support that's not yet in the mainline kernel, but most other basic
BMC functionality is available with this device-tree.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-asrock-e3c256d4i.dts    | 322 ++++++++++++++++++
 2 files changed, 323 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index d3ac20e316d0..3398ee53f034 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ampere-mtmitchell.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
+	aspeed-bmc-asrock-e3c256d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
new file mode 100644
index 000000000000..9d00ce9475f2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/watchdog/aspeed-wdt.h>
+
+/{
+	model = "ASRock E3C256D4I BMC";
+	compatible = "asrock,e3c256d4i-bmc", "aspeed,ast2500";
+
+	aliases {
+		serial4 = &uart5;
+
+		i2c20 = &i2c2mux0ch0;
+		i2c21 = &i2c2mux0ch1;
+		i2c22 = &i2c2mux0ch2;
+		i2c23 = &i2c2mux0ch3;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* BMC heartbeat */
+		led-0 {
+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
+			linux,default-trigger = "timer";
+		};
+
+		/* system fault */
+		led-1 {
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			function = LED_FUNCTION_FAULT;
+			color = <LED_COLOR_ID_RED>;
+			panic-indicator;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+			<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
+			<&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
+			<&adc 12>, <&adc 13>, <&adc 14>, <&adc 15>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <100000000>; /* 100 MHz */
+#include "openbmc-flash-layout-64.dtsi"
+	};
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
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9545";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c2mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c2mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c2mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c2mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+
+	vrm@60 {
+		compatible = "isil,isl69269";
+		reg = <0x60>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	/* FRU eeprom */
+	eeprom@57 {
+		compatible = "st,24c128", "atmel,24c128";
+		reg = <0x57>;
+		pagesize = <16>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth0_macaddress: macaddress@3f80 {
+			reg = <0x3f80 6>;
+		};
+	};
+};
+
+&video {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&wdt1 {
+	aspeed,reset-mask = <(AST2500_WDT_RESET_DEFAULT & ~AST2500_WDT_RESET_LPC)>;
+};
+
+&wdt2 {
+	aspeed,reset-mask = <(AST2500_WDT_RESET_DEFAULT & ~AST2500_WDT_RESET_LPC)>;
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default /* CPU */
+		&pinctrl_pwm2_default      /* rear */
+		&pinctrl_pwm4_default>;    /* front */
+
+	/* CPU */
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	/* rear */
+	fan@2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	/* front */
+	fan@4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+		/*  A */ "", "", "NMI_BTN_N", "BMC_NMI", "", "", "", "",
+		/*  B */ "", "", "", "", "", "", "", "",
+		/*  C */ "", "", "", "", "", "", "", "",
+		/*  D */ "BMC_PSIN", "BMC_PSOUT", "BMC_RESETCON", "RESETCON",
+			"", "", "", "",
+		/*  E */ "", "", "", "", "", "", "", "",
+		/*  F */ "LOCATORLED_STATUS_N", "LOCATORBTN", "", "",
+			"", "", "BMC_PCH_SCI_LPC", "BMC_NCSI_MUX_CTL",
+		/*  G */ "HWM_BAT_EN", "CHASSIS_ID0", "CHASSIS_ID1", "CHASSIS_ID2",
+			"", "", "", "",
+		/*  H */ "FM_ME_RCVR_N", "O_PWROK", "", "D4_DIMM_EVENT_3V_N",
+			"MFG_MODE_N", "BMC_RTCRST", "BMC_HB_LED_N", "BMC_CASEOPEN",
+		/*  I */ "", "", "", "", "", "", "", "",
+		/*  J */ "BMC_READY", "BMC_PCH_BIOS_CS_N", "BMC_SMI", "", "", "", "", "",
+		/*  K */ "", "", "", "", "", "", "", "",
+		/*  L */ "", "", "", "", "", "", "", "",
+		/*  M */ "", "", "", "", "", "", "", "",
+		/*  N */ "", "", "", "", "", "", "", "",
+		/*  O */ "", "", "", "", "", "", "", "",
+		/*  P */ "", "", "", "", "", "", "", "",
+		/*  Q */ "", "", "", "", "", "", "", "",
+		/*  R */ "", "", "", "", "", "", "", "",
+		/*  S */ "PCHHOT_BMC_N", "", "RSMRST", "", "", "", "", "",
+		/*  T */ "", "", "", "", "", "", "", "",
+		/*  U */ "", "", "", "", "", "", "", "",
+		/*  V */ "", "", "", "", "", "", "", "",
+		/*  W */ "", "", "", "", "", "", "", "",
+		/*  X */ "", "", "", "", "", "", "", "",
+		/*  Y */ "SLP_S3", "SLP_S5", "", "", "", "", "", "",
+		/*  Z */ "CPU_CATERR_BMC_N", "", "SYSTEM_FAULT_LED_N", "BMC_THROTTLE_N",
+			"", "", "", "",
+		/* AA */ "CPU1_THERMTRIP_LATCH_N", "", "CPU1_PROCHOT_N", "",
+			"", "", "IRQ_SMI_ACTIVE_N", "FM_BIOS_POST_CMPLT_N",
+		/* AB */ "", "", "ME_OVERRIDE", "BMC_DMI_MODIFY", "", "", "", "",
+		/* AC */ "", "", "", "", "", "", "", "";
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default /* 3VSB */
+		&pinctrl_adc1_default	   /* 5VSB */
+		&pinctrl_adc2_default	   /* CPU1 */
+		&pinctrl_adc3_default	   /* VCCSA */
+		&pinctrl_adc4_default	   /* VCCM */
+		&pinctrl_adc5_default	   /* V10M */
+		&pinctrl_adc6_default	   /* VCCIO */
+		&pinctrl_adc7_default	   /* VCCGT */
+		&pinctrl_adc8_default	   /* VPPM */
+		&pinctrl_adc9_default	   /* BAT */
+		&pinctrl_adc10_default	   /* 3V */
+		&pinctrl_adc11_default	   /* 5V */
+		&pinctrl_adc12_default	   /* 12V */
+		&pinctrl_adc13_default	   /* GND */
+		&pinctrl_adc14_default	   /* GND */
+		&pinctrl_adc15_default>;   /* GND */
+};
-- 
2.44.0


