Return-Path: <linux-kernel+bounces-77908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDCE860C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD781F26BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775D175B9;
	Fri, 23 Feb 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOhbRt14"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB717BAC;
	Fri, 23 Feb 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676307; cv=none; b=CaUao+TKabBUjjcXdEEaHOx1Xw5rE+RMEB0nhthUSqWlxEQDmlpe8g5EaxyXkkMwaVwpkNmQbTVJ1tUkzx15geQuClSL8UgSZ+X+KdN9LcrlHOBzDPycDPPg0ytBl1VPgt2tm98qY6H4ivNVMh/YovS+9GrFFV2X4AirBn+3Zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676307; c=relaxed/simple;
	bh=4I6OZOlOj+HIdeauCtLby14X5Kskp3I8zfKg0UXk/n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q89UkvHgdNFSfI4DDcCT+nhTYcdF0siJGkqDyJI+uDbEkuhyGTqV6V2/+amH3a6eWoeagluBNOJxuD0QLCzhpVgq7IPokSD8MuSuHPC70f2tJ/sGB+oM22YSTXqqtk5bH85WMJH9UoAI1nkdoRQWPmqC7lP9bh/JoSPcM3Dw7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOhbRt14; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3f1bf03722so13233966b.1;
        Fri, 23 Feb 2024 00:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676304; x=1709281104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKIik/RQMNSPLGet0W6OaCPG7/aADm0oTMdBWOLBjFo=;
        b=iOhbRt14t5z2GIHU53GRu/d9otQ2P7QQGBjINciP17vIACsFzibQKlgjCEVkxm03+x
         nxeQTG0ZRXSUUoiAnBJqfU/eGldBc0ECqgCHcON6Q3fyYRPuVCluklHOQTkeBjCOY7ja
         Lox69IP01EGT7F41G58Csrht7SI/nBaksoXPOTWe6EYoWxxQrXne68Z6oSLX4LuD8NOV
         Y5om1Bdt7x7CKstme0CX+oDeqCWVypnDVDUFgHFNbn0/PR1RknCx8VlBH4m/zcIbqOwl
         ZDLsVLC4ZuxO479u5q4wdoDiv3AKZW3q2zuuGjGjn66IBFFb2emzPmdVZQTB0gvqmKlg
         i4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676304; x=1709281104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKIik/RQMNSPLGet0W6OaCPG7/aADm0oTMdBWOLBjFo=;
        b=I5eg0VjHIEKVO9PZI3RjD6ptXIrM65+tTqmcCkjUATAyRZEC1TDC+oeTtaPlMXndyM
         7Zfh9mZWcv8lzGMJlVSD8zkLnfa9rtfnLoEYcFELwirbC2UEjoRBUSA02PjDIPe1ui1o
         bhSRjzMviiL7jxRwAGwd+smIZ1eH/46ZeZ6Uh+W1pLJHqRj26BfHvYwcHxMjuLug8NpO
         ezcStblJyY4GrE8YobCdvMkAXlpZtjrnfIKqLRMM4TjOVw0N0fd7uchF+6C7cZ6yJLR9
         EjUVtveA8Pcw5844JiP+AJchJOC9TSsMcAvxxlYeSw1AU4OQvJ+GS7DuN5c4WROA6z54
         9ogg==
X-Forwarded-Encrypted: i=1; AJvYcCXoarbVywF/nUK4dhK5ZS0Ns1AmaDVyOSHut5wSyUrNVqZ6rN5k9HNVFOfQnfjUGuIg+G7oSIyZ1rbFoecm6jo8B3vPhmJ+mnjv82AjUtmRWDiPCAp3cJT8Km+C5LnrxL3rh+0Lcv4lag==
X-Gm-Message-State: AOJu0YzG+2ARLQYT8CPQgbaljZ1qwJzfzO1EQqwY8GCYYCeEd8gRbqlw
	QlvTPnqKPHGhFdYrD/ETpAl1FM3BJyTA3gmGk0MebO9FrqgmqH78
X-Google-Smtp-Source: AGHT+IFVX+HnIlQdQQXpmqwWffZYECK++FSTWmlVVr9hTsRXXAULtPza3tRm/RT/TqpH3XgdcrSBmw==
X-Received: by 2002:a17:906:65c2:b0:a3f:5104:dabb with SMTP id z2-20020a17090665c200b00a3f5104dabbmr740905ejn.63.1708676304102;
        Fri, 23 Feb 2024 00:18:24 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n16-20020a170906379000b00a3f6c5bf929sm1633346ejc.18.2024.02.23.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:18:23 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 23 Feb 2024 09:17:45 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-archer-ax55-v1-v1-2-99f8fa2c3858@gmail.com>
References: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
In-Reply-To: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Add device tree source for the TP-Link Archer AX55 v1 [1]
which is a dual-band WiFi router based on the IPQ5018 SoC.

At the moment, only the UART, the GPIO LEDs and buttons
are usable, but it makes it possible to boot an initramfs
image on the device.

The device tree can be extended in the future, once support
for other periherals will be available for the platform.

1. https://www.tp-link.com/en/home-networking/wifi-router/archer-ax55/v1/

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Note: running 'make CHECK_DTBS=y qcom/ipq5018-tplink-archer-ax55-v1.dtb'
shows the following:

    DTC_CHK arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb
  <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
  	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
  <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
  	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
  <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
  	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
  <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names:0: 'pwr_event' was expected
  	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
  <...>/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
  	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#

This is not caused by the new device tree per se but comes from
the usb@8af8800 node defined in ipq5018.dtsi. Running the check
on 'qcom/ipq5018-rdp432-c2.dtb' shows the same.
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 133 +++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 39889d5f8e12..d3ba1e22d6dd 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts b/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts
new file mode 100644
index 000000000000..1b30d4bc781e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "ipq5018.dtsi"
+
+/ {
+	model = "TP-Link Archer AX55 v1";
+	compatible = "tplink,archer-ax55-v1", "qcom,ipq5018";
+
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&led_pins>;
+		pinctrl-names = "default";
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			/* WLAN 2.4GHz */
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			function-enumerator = <0>;
+			gpios = <&tlmm 13 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&tlmm 22 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-5 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_USB;
+			gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-6 {
+			/* WLAN 5GHz */
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			function-enumerator = <1>;
+			gpios = <&tlmm 39 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	buttons {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&button_pins>;
+		pinctrl-names = "default";
+
+		button-reset {
+			debounce-interval = <60>;
+			gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+		};
+
+		button-wps {
+			debounce-interval = <60>;
+			gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+		};
+	};
+};
+
+&blsp1_uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&tlmm {
+	button_pins: button-pins-state {
+		pins = "gpio25", "gpio31";
+		bias-pull-up;
+		drive-strength = <8>;
+		function = "gpio";
+	};
+
+	led_pins: led-pins-state {
+		pins = "gpio10", "gpio11", "gpio13", "gpio18", "gpio22",
+		       "gpio38", "gpio39";
+		bias-disable;
+		drive-strength = <2>;
+		function = "gpio";
+	};
+};
+
+&uart1_pins {
+	/*
+	 * Remove "gpio31" from the default pins in order to be able
+	 * to use that for the WPS button.
+	 */
+	pins = "gpio32", "gpio33", "gpio34";
+};
+
+&xo_board_clk {
+	clock-frequency = <24000000>;
+};

-- 
2.43.0


