Return-Path: <linux-kernel+bounces-119227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209788C5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484111C63AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB413C901;
	Tue, 26 Mar 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVA3JNh0"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEFA13C813;
	Tue, 26 Mar 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464769; cv=none; b=ijTBFOnp1JMBObj32EniNv2HvVprxPreHMVdl6921j/h1E3zIE16hqb8XkdSq0LbvDnHDaHcyq/2L21WXdeBKvpjRBfCHuPALPVeE5hUdZzIbyNDaPFr+5cAWzzIVSuAJ5bt8MUyuz/v79oAlDZc9LqBweJXNKa5g73Td06BzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464769; c=relaxed/simple;
	bh=JWJWSSqZAv4OBBTEj+CvzbsUGOlw2pfJrmvfZ4iJETc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAfBxBnENw+j4fIiUuT1pHXTBbpNmnOf7Cx2blvtflJAPdBzRNAL72hAY6qvQJbTc1rmv8OIcSTYLsBq+zHYCR8XySxiKV4reU/F8S0wIPipUuW6z9guXnaJBDWLHeMUSk/t7aOriGDGkgyUA3qlqJj7+anaT1f5QYyYEAssKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVA3JNh0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3416df43cabso3918177f8f.3;
        Tue, 26 Mar 2024 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464765; x=1712069565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vm+pXqQpZ6t0qViILPSWL7APStnvBHw6i2ClH09kCck=;
        b=bVA3JNh0E/eqlTfuC3Tf/SmriZL8UcrbxtqxvNopRrH9YdGenKBMyxNMquhaxM6ZQE
         eawEMwkleOxRClLS+KhSF0yBy+Th6IR7fhyTShxuYbwEuDbcpip63fveL9y/kre+WsTZ
         MniaWMb20P6XUTLiYQoYpJcMVAd8t/VUMrTpmck7JWwTxtDA/+/QyN4l/dZNezTWakAi
         eTHHIS+smmyi9gd/DvNisWHE111Jg+patPHmJ3eMzvZQPQkG5ZtOaqNOxZ1u0AmeaDrV
         JuhseiZ8As1L5Rvczn9Wc23QZrfWrybMPNOBlKUURKB2un25HaKuLThe1u4OqKwD5cD5
         4TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464765; x=1712069565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm+pXqQpZ6t0qViILPSWL7APStnvBHw6i2ClH09kCck=;
        b=SQfV+IZRDHQ7CV3mKULgoJjCrhMsWwOCF2+Lchh9iQgLol86VkSNeH6bseRUIMNhR9
         Rfn/Njr7oGVTVq4N+1QarZU5I27pI74ig4CiYw1yrUS7Ci1lR9fgzB6L75p7dTg40rRl
         6dT94n+E+UgXkFxhn4fukHhYQLDFeJ+tuFYoPDw8fS+wmF6vWxcad/IuEK33hZAChzoU
         eB8OzYjXO1HlC43RhcO3jKFrvlBZGDPuJFOFPVs3azp4MoCjWi3Y61ijIoo39aGrfzTt
         OQDhNLwGRBe8JNpWjP73tGz7/6Spl3N0EbBGgbV/h4sYGpJ8hT5Fnk8tQCtp8eYvAiz8
         9bng==
X-Forwarded-Encrypted: i=1; AJvYcCUnJGnFdUdN639612O2h1CMIW78IQOlyMKmaSOeHlIrYqn03E9yAsEOdrgjzIQMAzrIL2I9W6zyXcE+awZsb6mPKxGZjPgY5dxm8b33+7/qJV16EO9tO29XLMDAGHeF+hAZlWkBBE3TOQ==
X-Gm-Message-State: AOJu0Ywxlxd119w49fDZCZ+yOac6hCo3e/KcWiGPqlA3YmlRhgxwl/80
	Qmd+0Gf+dRR0GUs69u0cIePRnadvpXvKPoc2f5kZCR+a0Pm4k0WHxuvnDackM8o=
X-Google-Smtp-Source: AGHT+IFLN6dL48JkFezyVN548uxxZa0m+6M5lB95g05ji6AO98ljI7l5sAwddvHRuNbbfaEZAovuFg==
X-Received: by 2002:a5d:5601:0:b0:33e:818e:d076 with SMTP id l1-20020a5d5601000000b0033e818ed076mr1102752wrv.47.1711464765586;
        Tue, 26 Mar 2024 07:52:45 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id h8-20020a05600004c800b0033b66c2d61esm12281738wri.48.2024.03.26.07.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:52:45 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 15:52:28 +0100
Subject: [PATCH v4 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-archer-ax55-v1-v4-2-dc5b54a4bb00@gmail.com>
References: <20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com>
In-Reply-To: <20240326-archer-ax55-v1-v4-0-dc5b54a4bb00@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

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
Changes in v4:
  - change the orange WAN LED's function to use LED_FUNCTION_WAN_ONLINE
    definition introduced in v6.9-rc1
  - remove function-enumerator properties from the WLAN LEDs and change
    its' functions to use LED_FUNCTION_WLAN_[25]GHZ definitions introduced
    in v6.9-rc1
  - rebase on top of v6.9-rc1

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
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 128 +++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 7d40ec5e7d214..c934e3aab2f44 100644
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
index 0000000000000..5bb021cb29cd3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts
@@ -0,0 +1,128 @@
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
+			function = LED_FUNCTION_WAN_ONLINE;
+			gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN_2GHZ;
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
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN_5GHZ;
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


