Return-Path: <linux-kernel+bounces-105535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723787DFD3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AAE1F21248
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3F219EB;
	Sun, 17 Mar 2024 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Iqp6WW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756B1F944;
	Sun, 17 Mar 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704879; cv=none; b=s+61/a/OlMPW/Y86CG7o4g3I+D707oYRkE28BFRmCxSH1yo5oMJOCqGd2o+dCRqanEv/ndL/IaxiXVn2gwe7pcgBLMMz6Bbf3VCQ70/vOsDCPXBtQ+kz2Sjjv7it0wydDXTFRynRKjkqfHXghbfZgz8WCTGOYnjpqooHBg6LTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704879; c=relaxed/simple;
	bh=bH5o0Ls9AOyqGduppu30qLhUqpfUYFjoHjQV2Ul1jzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAYT5mr1tgvTqPWfG1i+ld4E7W0uHE2O4rkGwJB3kVVXFPC3ELMcPfRr/EZjo1EToCBqWxv3DblBPiem4E69VpfzKz9+cTCTTwCrNpO+BOnAhiWrS1+N9cJeNHYtTIGIMUfBoNX0Vwjqi7UodRvlV3QC0QNQmMatI/tHkvFipYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Iqp6WW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-568a9c331a3so3148971a12.0;
        Sun, 17 Mar 2024 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704876; x=1711309676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRQCwW/nQLKmQ6pGsr6+Puw0CxHpioOxtWAo9XmoOKI=;
        b=V4Iqp6WWDsuwIZHR1lTxvGjDkRooo0r52RSWKMsipp9ybvdhP/tY/ZOnGAt7bpNwN9
         nHY3WNhCzS/egUKSE9LOt7SgUBFzh2T1N4AZakFcGdarhgt6on1lH7A9SzqezXftOu1Q
         RFW1CFP22xVamVVWnEStFqTtxqsnhVFOA75MFUeKZBEzlC93xaa4yZJKddkexq++Vzl4
         8fO07mzLO8gE2aLTBwJ1sV/ropTAq0jrqnTtU8dpY4MJYQGKD7U/bow8WUhcFArnH0zS
         ZT4kuwiDncOtVCU/DOkgkRiOZPVrrZzxgese9ypRQPuL4d1Zd7ONGRs2VUh07uxMJ1uA
         ZQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704876; x=1711309676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRQCwW/nQLKmQ6pGsr6+Puw0CxHpioOxtWAo9XmoOKI=;
        b=jZ4yjdes2QRzxNM0UbOdygePfUEepDEuyOZdM4Lt8OHlIQ1H8VPoAADQN/S08TmB8s
         xFGISZK22T330SSIqOvmcXmz9CZTosLAkpR7Sxgj55bPYqB5GhAxXDGGX0LPo+5mvgML
         L96d0ikXGbZICvmBYF50FVeBCSiemksAm+b8qY0vrJU4SSUYVQ/ybm+/wH0P+1kVlnIA
         mdNH/c6uSnU2Bm3zzPSHXaDoW4Xr/N+XWlIc0LerwN1cSRAR9zrnreAL5Qt07zKyM5cI
         g0E9Kh9DVZuCi0txWtWa4yIyStBrNXDYgQqukkZtNSR9HrZ4HJz+DEI+S8PzKC04bt+a
         d9yg==
X-Forwarded-Encrypted: i=1; AJvYcCXUy+JWn9c+tW06Yh8n38OXpbohqr5XBp5MHcRwd3M3bMrm2c0E2RqZRyIDRIAtnVryXw3XLKoBb7hqMTeOPMoOpAieI6Yvtmqov24A
X-Gm-Message-State: AOJu0YwhOLNAASTuNOjhjyxzxhwgOmPB9prEsk+R//QLk+IEtoVQuEi7
	eXUDe7v82rpH3W2P+OZ7xTF/mMOwRhFXNuyIzkjkBfEJZmrn73iw
X-Google-Smtp-Source: AGHT+IHlff9ykIwKw2Ily1s46V3oQWraesXYjGxDSDB1jS2e8r/dTUbFowzbEWJ8GI+BVLtACmtnMQ==
X-Received: by 2002:a05:6402:28ce:b0:565:e610:c358 with SMTP id ef14-20020a05640228ce00b00565e610c358mr6416071edb.38.1710704876166;
        Sun, 17 Mar 2024 12:47:56 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id i24-20020aa7dd18000000b0056ac092a7fasm8234edv.87.2024.03.17.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:47:55 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Sun, 17 Mar 2024 20:44:51 +0100
Subject: [PATCH v3 3/3] arm64: dts: allwinner: h616: add support for T95 tv
 boxes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-add-t95-axp313-support-v3-3-0d63f7c23d37@gmail.com>
References: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
In-Reply-To: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
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
 .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  85 ++++++++++++++++
 3 files changed, 195 insertions(+)

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
index 000000000000..815cf2dac24b
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
+	wifi_pwrseq: wifi-pwrseq {
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
index 000000000000..c8650aca2407
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
@@ -0,0 +1,85 @@
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
+		interrupt-parent = <&pio>;
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
+	vcc-pg-supply = <&reg_dldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};

-- 
2.34.1


