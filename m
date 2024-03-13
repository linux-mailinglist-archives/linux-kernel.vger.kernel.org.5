Return-Path: <linux-kernel+bounces-102360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196287B124
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182F628D546
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DEF7352E;
	Wed, 13 Mar 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1DTXCtt"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36C73191;
	Wed, 13 Mar 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354355; cv=none; b=cQo+W+6hFslGuvGIdI5O5ojHQhlauwxtPzvrXrO8HnHbIlu1gh/Gp5pKGCp+Aj8ZXjC5SGf2OWFh1M+V5CsYX5sDmSSArk2SRXUP9A7j5ioVCQdxrm6+pLRdZm2eXrQB11OgSwZ1hynkRMYtDt2hSyZLnxT1zmaCyZ1r378aRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354355; c=relaxed/simple;
	bh=BSlu7N/By/qd/oV4zudA//pQ796/J/j/cYkZmFtnckI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRHMBylJrWAF2zmQ9ibTysMQkWe07JJdZec7+D+BdRlfhtYH/zpTwrXVK/uqxKSUl1+csip/lWMDAtbRWiqLshQcuGrxWWieOdCGqGcHrWi3nqmm5f6s6WpvymrbaM39PW6iov+pXSD0qXq1WcIYBChMjy+VBiz1rJNHrKPxSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1DTXCtt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so180272a12.2;
        Wed, 13 Mar 2024 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710354351; x=1710959151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krJhQP8CYJbvRc+buIXM8H7mfu3rhUay6+eJJ/PMl4U=;
        b=h1DTXCttagZXyTAG5AIm9ftJzphmLG8I58dS9ejIZ0eJJ0I+4wkpUxbkFjC25xhFcX
         Ir6KVEwJUZLR0RlVE653qJQ2klSNbgETgsGZQ7Ze10qjo7rzwzSpe6IWbWRCcM4UkxKh
         RxizvcFH9m9i+3ZrZVbRiFbrz2CfCMMyJg8XEByJloLXdcLnCTDOfx4/oIGLJMptpKEA
         Dj1/D6q7sWvrLcGoihOuEZY/4/zBpqHNPQRLS3EWI91Au4nu6nHkAQ67CxTc9Gr0G4UV
         4F7oDEX/P9CsgQXQbFxT1auj6I8lvH0kB63raZ2mXhPeGFG9ISi2CmvWzwBK8p+B/nna
         4wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354351; x=1710959151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krJhQP8CYJbvRc+buIXM8H7mfu3rhUay6+eJJ/PMl4U=;
        b=JoyG4sIrT28yPjBlDTUIWUuIV4+osyLFIVFzvb+aP63jrncDNlo23c1L5SXnVZp7RM
         FGk1H/Bgwb6+VTiGKqWzVoCjVAgUYj+1ufyUoq+hEH1FzPgKSmXTg3BER2FnU4OAem5H
         9SWIrNLNK48y1BLr9UTkEw3CODxAblq0eLwrUpurJWUsnBVKtwszkClE1drbP8DclGd2
         pbW8ka6jnK/S6pK0UP7fP6hJzpkz/gbPPLPjfeXOMGw4HMOa2IWlZEHrS5mypJvK7cp9
         wgcrF7vpRBFTXZQvweVbIToWdYz5bKl4i141D32hitkhRCNB475SIeFeyNYXANqltmLV
         ikoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeVyxMMt8wPRlgjVZA3E6vog8tYtCARq83ZAlcFwPWQeolJ20BRGOgKUG1o7QgJZtdbmGLSswUW4sKT1X7R12x2UZ+qqCDRpPBcNhD/UaNo6kWVlG1dA84KSfiCao6rU91z957SVbDgQ==
X-Gm-Message-State: AOJu0Yw0L5v5pzsfsDfyo7609q4EyAeNL2MuCQ4UABi9fz/VGlflLIgs
	Yzj7/bQ8Ix3qtpQqvqSamDT8f43tBdmf9uGAGTwkyhkqvo3Z1JBP
X-Google-Smtp-Source: AGHT+IH2U5cTE+i+kA73zu2Vyzgg0h0ylQCU/WoC6SuXaLnWqo/WiU0lOFHT542UxJ/TDxlp8MlTlw==
X-Received: by 2002:a50:d495:0:b0:568:3004:c611 with SMTP id s21-20020a50d495000000b005683004c611mr7418877edi.42.1710354351357;
        Wed, 13 Mar 2024 11:25:51 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id k15-20020aa7c04f000000b0056864cde14dsm2827390edo.68.2024.03.13.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:25:50 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 13 Mar 2024 19:25:40 +0100
Subject: [PATCH v3 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-archer-ax55-v1-v3-2-cd9402efab59@gmail.com>
References: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
In-Reply-To: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
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
Changes in v3:
  - change pin configuration to use "gpio20" and "gpio21" for UART pins
  - rebase on top of v6.8.
  - Link to v2: https://lore.kernel.org/r/20240226-archer-ax55-v1-v2-2-3776eb61f432@gmail.com

Changes in v2:
  - reorder the properties in TLMM pin configuration nodes to follow the
    usual order pointed out by Krzysztof
  - Link to v1: https://lore.kernel.org/all/20240223-archer-ax55-v1-v1-2-99f8fa2c3858@gmail.com

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
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 132 +++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 39889d5f8e123..d3ba1e22d6ddd 100644
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
index 0000000000000..15fcb5693545d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts
@@ -0,0 +1,132 @@
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
+	pinctrl-0 = <&uart_pins>;
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
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	led_pins: led-pins-state {
+		pins = "gpio10", "gpio11", "gpio13", "gpio18", "gpio22",
+		       "gpio38", "gpio39";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	uart_pins: uart-pins-state {
+		pins = "gpio20", "gpio21";
+		function = "blsp0_uart0";
+		drive-strength = <8>;
+		bias-disable;
+	};
+};
+
+&xo_board_clk {
+	clock-frequency = <24000000>;
+};

-- 
2.44.0


