Return-Path: <linux-kernel+bounces-82034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493B5867E04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0017D28C6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11576132C30;
	Mon, 26 Feb 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR7G7Z6V"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B16132481;
	Mon, 26 Feb 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967580; cv=none; b=ZNjWE2ObfrEtlQRvHTTEdnRwme4O/NNzRK1ndZwAeo5jUtMDjl1ldnclTNhyMb+Wl1PSgQ4jRdSHQoQEIzxP3DZHnq2cIVlj6BOZns7jLgO43L4iz7EYdkT9kt1SyyUvL3VQ8EXtU0+SasdkL6Y4t+NN9vXadLmiCawxOOxTfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967580; c=relaxed/simple;
	bh=N6jWta7hXGt7lnEM51fFRRLNfBV0dglHVGkU4nNUrXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQvi6EyXdQ7MZk0iT6SSByetAUzk6HEowiA0JxtyTgQXTS3Fa6kH9FF6FxdOWyoi/VH1fVR1ZJ6c3TxlBySw6AU3nMtI5XqtJKivaHxo07/XTQ18txHu8L1l5QedbxQk47MYGYz5RVkpwCenQ8kqUwxV1+BE2DIXzcoajmg3JrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR7G7Z6V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so307795066b.1;
        Mon, 26 Feb 2024 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708967577; x=1709572377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzbhKNoBKd1CmIg5ZSA3vFpdoQzjErc3J9RfUW01e4M=;
        b=HR7G7Z6VYw9XsJBDhrHy6nM5c1zZRfotrB2+vlIiIDE+mgrB3hCLVXZysqSiDsJhi1
         F08wfjT3wpnjHcKWEHycpGef9UtoWTOCtZk8zaSz34NKUOESpb4NhJs5JNdTbRKUoVhX
         UdYtP2z+zn7rf71MbgRqcfiTRK0X1Dt0r7Em7WVQq+hCc2BMbjDbXuNv0J6srhe7t/96
         0jhV8mviHkefYGI56izT96Ea9gsMc7JY2SvTBeigPpzSpYK0qyBwq9oXUz8OeVKv8K1W
         3BfE7enAQF4htUf5y2GWotrHtsxwpOEvkS9/WJvkgyd+3m1gezdX5kSE8Teo13nNC+ag
         28vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967577; x=1709572377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzbhKNoBKd1CmIg5ZSA3vFpdoQzjErc3J9RfUW01e4M=;
        b=XVozDc+vj/Bx+MU7IChg4sEW7STCGrmOdAOo9rx+ZT2xYz1ofO6JtGQfuUUvDdSc9V
         szcySTOCsrh+FZoF2SZ6i0bJr6U3a05pnNgQWaJAir1yrhB/VQkVJ5laQWmH58JamK3f
         wTOSBIactXLad4BOQrzESxJwHrLVSkWG1cR8HuGl++wVTxZDSICUJnhXp50Y/mDQOj1v
         ge/EjDnRHwIdrJ5420BUjLzR676sYi7iryNH2f7px1Sj8PFhnEa/9pn7dOmEDAo9FJGR
         j9Lsb1D91WDUs8PVPGxH8i4yy2ZG51aQ90tVlLUhHmkFnBN3HqHWVHyOMQBzYwzLGkV8
         BrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm4ClrY49kC2KV5tLgw5gSQCKL9DpmgpyXy3EWpMO1dTDRaOXeBzWMGpvYLfAVrwhtA1VFJmzCTZrH/6yR73at+6PrU2Ltw9qsncWuedmVQJMggIXIKq+xhyWa1RYnii/YKHa92ptJ0w==
X-Gm-Message-State: AOJu0YyZbXOFP8YDixDO8FOGNVZqFS3SUKTmWjPJQfVAd08cK+57Lmto
	JIvWUH6Ig1WToWpQexs4+1Slk1IFoISEDS//TDT10I2cFCKX0oIfDfcv4NaEmEA=
X-Google-Smtp-Source: AGHT+IGSexO5fkxfkjblD8T8X1QDLnuESp8KojqCaFYXXOyxE4hYGIfBQr00Gk2weVMYK9QCDYzRUA==
X-Received: by 2002:a17:906:2bcc:b0:a3e:e84b:232 with SMTP id n12-20020a1709062bcc00b00a3ee84b0232mr4918378ejg.75.1708967576685;
        Mon, 26 Feb 2024 09:12:56 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id ss3-20020a170907c00300b00a4396e930bdsm98989ejc.79.2024.02.26.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:12:56 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 26 Feb 2024 18:12:40 +0100
Subject: [PATCH v2 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-archer-ax55-v1-v2-2-3776eb61f432@gmail.com>
References: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
In-Reply-To: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
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
Changes in v2:
  - reorder the properties in TLMM pin configuration nodes to follow the
    usual order pointed out by Krzysztof
  - Link to v1: https://lore.kernel.org/all/20240223-archer-ax55-v1-v1-2-99f8fa2c3858@gmail.com
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 133 +++++++++++++++++++++
 2 files changed, 134 insertions(+)

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
index 0000000000000..10fff50bb8161
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
2.43.2


