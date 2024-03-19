Return-Path: <linux-kernel+bounces-107948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89448803E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E7DB23E75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745A2B9C9;
	Tue, 19 Mar 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx7+h/Ui"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82B286AC;
	Tue, 19 Mar 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870632; cv=none; b=fHEVEvCs4W8ld0Z9nJZ5Z6GD85zdtn6PeIsgyM9sX7NHL85HYN2BkqvxKScb388CHdNOgaNDo+9Lx490yylhjcCKL7KqNAw/QD6OmSyPxjx291R98y3af+3ek6klum+Nv/Z/fzXdWsLjSQ7zgpSMjQeqvbEZXaUdOsa2VI2Qgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870632; c=relaxed/simple;
	bh=2srAD5ClkT3dKxDgxCvfkFQLhGt9MLkwM22uuag/53w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Po0wOTEdvbra7J3jWOt/u23xZyt2JFGw9SSBbHCmo55aRt/LLRe5vfNH/E2w6rwlCNHIDtUBB6Z1N7wuQZNNW7n/fsiABwLD5/16d6kS/5izZlb1uR8sw2oCRpNIW2695hNStURv97fwS1B3YWBf+B9UQrixOz/aVAi0gPwgcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx7+h/Ui; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56b93b45779so1427591a12.1;
        Tue, 19 Mar 2024 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710870628; x=1711475428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4h88E15TbnHDt476ZSp+9Jvp1kaoXpMk+VIBAfvxeU=;
        b=Zx7+h/UigiSkspRkmZSmMrD8SskW0HFHqvqCf3i0BR1jjkTrW/Q03ysnEQ3YQES6Dt
         ekXQ0Ctfds1gv9Trx+DcVTuRJovkh+nOLJCh9vR/hEVyDelUqKs+9YXjwA6fKECoxY0+
         PTb34SoiW16gPOo1d7wX2VZWzybN5XEvY2ZIZD+Mi6l19lAI3z8egEpCMOjIn9/z0Wn/
         zVLXi+23/eAvP3nBHIQswCiDvXuA6gD4MPmZjzWgxSQzKMNImqaU/aILDTLv4eIIV5Ye
         TRpInRMbbAREnXwo6LWgJczhsW8Ce08vFMf7m2uGNWtvxLC5WvbHKJtR2TZc+1rLoX/G
         2PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870628; x=1711475428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4h88E15TbnHDt476ZSp+9Jvp1kaoXpMk+VIBAfvxeU=;
        b=PsEzI6p1WNIlBMaxB7KJ2Y6oFPkSDPibGqWIY31V4zKAkVf+8LST7RQTgg7orVZPT+
         /3tnYvgtxoqn+tSdA//Z4gEnF67sFTcs99aEl5a/pOadDYtMhgW88gUESRLrJskiMi4B
         oSlqwM1WmGdGSbPm1nsIRlxtTmVLtS4/4p5cRyrmo4GC/mxAdPse348YPa9x1d64qQk+
         BrGexc3E3+wJ8jQMNR8Fu6vxi7hcAQIL5ibZx9WwFdlZhAnG3srtsARgsJNlitk5FLUt
         subKik0NncUEj0F1gdoIK0FQaquP/uswmDlsTgLL2tLLN8eV198XBAYwO4PXn3Vx+Qd3
         VA+g==
X-Forwarded-Encrypted: i=1; AJvYcCWyrhSKbwbOZ7fwMQ0bpqxG/pJPKEOtPrglzoQ6ODUIFIkGxTp/WDchIvshUmLGC2t5wXj47RRVdjLUQCMxABI4ycJ0588lNpNH1wNj
X-Gm-Message-State: AOJu0YzQZIRqdSCC/wMrTLXHmuG1A9V50p5sFxrFCZ33couROLL1PxUE
	F9GlvR+Q/G2BEWfl9L4kIHJduinYFbPhvcE5fu9cuERMJ+Djoogr
X-Google-Smtp-Source: AGHT+IGUxW7sLCdPNkkhZgR3NWA+XFmNyD07eHPGxgXx/8PSxWImUGKO+3nXDlH3LLPOVG8k4GqxQw==
X-Received: by 2002:a50:c04a:0:b0:567:45e2:c4db with SMTP id u10-20020a50c04a000000b0056745e2c4dbmr11207171edd.39.1710870628405;
        Tue, 19 Mar 2024 10:50:28 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id et5-20020a056402378500b0056ba8b68505sm84329edb.92.2024.03.19.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:50:28 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Tue, 19 Mar 2024 18:50:24 +0100
Subject: [PATCH v4 3/3] arm64: dts: allwinner: h616: add support for T95 tv
 boxes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-add-t95-axp313-support-v4-3-6204b6d23229@gmail.com>
References: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
In-Reply-To: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>
X-Mailer: b4 0.13.0

Add dtsi file for T95 tv boxes and add initial support for T95 5G AXP313A
variant with a board name H616-T95MAX-AXP313A-v3.0 Internal storage is not
accessible due to lack of support for H616 NAND controller.

Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  84 ++++++++++++++++
 3 files changed, 194 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 21149b346a60..294921f12b73 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-t95max-axp313.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
new file mode 100644
index 000000000000..4c02408733bc
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
+ *
+ * Common DT nodes for H616-based T95 TV boxes
+ * There are two versions reported with different PMIC variants.
+ */
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	aliases {
+		ethernet1 = &sdio_wifi;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		/* discrete 3.3V regulator */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wifi_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+		pinctrl-0 = <&x32clk_fanout_pin>;
+		pinctrl-names = "default";
+		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc0 {
+	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	sdio_wifi: wifi@1 {
+		reg = <1>;
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "host";	/* USB A type receptable */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
new file mode 100644
index 000000000000..08a6b4fcc235
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
+ *
+ * Configuration for T95 TV box with board label H616-T95MAX-AXP313A-v3.0
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616-t95.dtsi"
+
+/ {
+	model = "T95 5G (AXP313)";
+	compatible = "t95,t95max-axp313", "allwinner,sun50i-h616";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dldo1>;
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&pio {
+	vcc-pc-supply = <&reg_aldo1>;
+	vcc-pf-supply = <&reg_dldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};

-- 
2.34.1


