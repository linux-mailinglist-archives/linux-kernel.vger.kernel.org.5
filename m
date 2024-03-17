Return-Path: <linux-kernel+bounces-105529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A487DFC4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C11C2097F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C3921344;
	Sun, 17 Mar 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NizJg7cn"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102420323;
	Sun, 17 Mar 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704326; cv=none; b=Ub8RAI8PGC6m/RyBbJ07f7BwgWYnCDWypVmGSV1uXLv34RBEZTJxUdR+FJfesrTjvbA6FErfJ9wA+Y0i2JPCm7US5badHQar+o8WptqAo3dBEUM6sirmB5zqbwk8/o4ApnJdO/EgCQfg2EVMMjj6AvpWIm24hPq8adP0SGQToEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704326; c=relaxed/simple;
	bh=zde3M6Y1JOzRO5e3g2eBRl5mSIHaobfX2LHthOYLsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gW83p42zpTRAczTj/OqzVG/af+R82Hcc9VZ8Z+WsTfGlx0sA4HQGC83hYdjjpNn2qbCstbt7Ny9wDn2vCn20xJdPHL3DTgDloZ75D65WD9P84MfnuIz4OMw4vXF+nn6dedWi/v62lW43b7W8yt/kMi0+1Kh7oMBMLNs7YL0mUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NizJg7cn; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c37e87756dso1047542b6e.3;
        Sun, 17 Mar 2024 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704324; x=1711309124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT6hmngmg7LhsdhWQVbZrDuHFIRfbTgzLQihr9TF8as=;
        b=NizJg7cnyVai5S0GO+K4gBjYFqL620u6LKUW6bE6P1pGH0kvWObrYMqiL4RKudKO9s
         XTfEwkCpsFGHeoeFWusAdpuLHJje9pGMq9dC1tQzdN1u19mVSCBLwqkVSYEn1bekVbf5
         f4zKqIrZdYXgomlXcfhODq7EOCsOtCxjGredJScpRwhm6gWbsHyHqOGPix/TKu9/cXea
         ijXfbHfVQXMmBspnfE/ZGBV3vzr9H4nOwMaPX11nH/G1GLwn1AUo7Wm5UsqEgvyoWc7L
         bXtNDUWewDizE1OeicXWjRV69ncqKgmiQB/HEEXDfHx4zGRRKjcwD9q5Awn0nCrYaf3L
         uSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704324; x=1711309124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT6hmngmg7LhsdhWQVbZrDuHFIRfbTgzLQihr9TF8as=;
        b=Jwiz8sbezvjoMMFafieh1Pm+qjn1Wj4hnQdDuPEhCB5oUGfUcbK++4RE3vgiGw61rS
         OkEsGMR7NOBz6e73BoYSO6moH6kgulpuIrMt/+9KcKB4I+Gk9BHAppVw/buT5AA+V9iA
         95BG6byhkPZj3DsYPiqv3uKWZNfNsnscCS7UndV8EDMmbrG3Ot1njFAfVPAKmjSRUSX/
         +VScJtS+c0TWkxO2WZX96bPMMUVdD7e36Z50ZelLygwHSGFHEjRgmkso6GohTJRLGW2g
         UXvh+CTQO05d1HQFJXXaFj4knrCujgTbUfXZJDVEwQs////lzMe8V7rTMTxGVbey8/hV
         hHHA==
X-Forwarded-Encrypted: i=1; AJvYcCUgz48OcM8HaIEgT+Jf8CLz55NH8WfsEh29LohkTfGxRDqzEa8xFd/3IiqhaB426axdZLVPA70uIe96r7tF++1mQQN390XiGzQUtbGyEBJAobCrS7UEzsoxNbn04nyON8VBdGNvIg==
X-Gm-Message-State: AOJu0YzyaoKtOXmLWaTpXihZUDS6WqBzCJg9F01daZnpQ+y6J2jMY/Ey
	+HuCB1RbXpNgu4GPGySXxDxK8AFoxIqsyQtFfWNV4qC19Kwh58oupitaxOBylJk=
X-Google-Smtp-Source: AGHT+IFUpPTaU6PvOX+AKPaPFj4Fu6IdLBC3LDsxuIWxs0yZJKnWwhoTrKzOxe3YGH55CzjEL+bang==
X-Received: by 2002:a05:6358:7e92:b0:17c:1e63:d02e with SMTP id o18-20020a0563587e9200b0017c1e63d02emr13107142rwn.2.1710704323604;
        Sun, 17 Mar 2024 12:38:43 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6125995pjb.44.2024.03.17.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:38:43 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org (open list)
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH v4 5/5] dts: ti: k3-am625-beagleplay: Add mikroBUS
Date: Mon, 18 Mar 2024 01:07:13 +0530
Message-ID: <20240317193714.403132-6-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317193714.403132-1-ayushdevel1325@gmail.com>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DONOTMERGE

this patch depends on patch 1

Add mikroBUS connector support for Beagleplay.

Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 80 +++++++++++++++++--
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index a34e0df2ab86..e1dce1b80153 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -29,6 +29,7 @@ aliases {
 		i2c3 = &main_i2c3;
 		i2c4 = &wkup_i2c0;
 		i2c5 = &mcu_i2c0;
+		mikrobus0 = &mikrobus0;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 		mmc2 = &sdhci2;
@@ -230,6 +231,38 @@ simple-audio-card,codec {
 		};
 	};
 
+	mikrobus0: mikrobus-connector {
+		compatible = "mikrobus-connector";
+		pinctrl-names = "default", "pwm_default", "pwm_gpio",
+				"uart_default", "uart_gpio", "i2c_default",
+				"i2c_gpio", "spi_default", "spi_gpio";
+		pinctrl-0 = <&mikrobus_gpio_pins_default>;
+		pinctrl-1 = <&mikrobus_pwm_pins_default>;
+		pinctrl-2 = <&mikrobus_pwm_pins_gpio>;
+		pinctrl-3 = <&mikrobus_uart_pins_default>;
+		pinctrl-4 = <&mikrobus_uart_pins_gpio>;
+		pinctrl-5 = <&mikrobus_i2c_pins_default>;
+		pinctrl-6 = <&mikrobus_i2c_pins_gpio>;
+		pinctrl-7 = <&mikrobus_spi_pins_default>;
+		pinctrl-8 = <&mikrobus_spi_pins_gpio>;
+		pwms = <&ecap2 0 500000 0>;
+		i2c-adapter = <&main_i2c3>;
+		spi-controller = <&main_spi2>;
+		uart = <&main_uart5>;
+		spi-cs = <0 1>;
+		mikrobus-gpios = <&main_gpio1 11 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 9 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 24 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 25 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 22 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 7 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 14 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 12 GPIO_ACTIVE_HIGH>,
+				 <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &main_pmx0 {
@@ -389,6 +422,18 @@ AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
 		>;
 	};
 
+	mikrobus_pwm_pins_default: mikrobus-pwm-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01a4, PIN_INPUT, 2) /* (B20) MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
+		>;
+	};
+
+	mikrobus_pwm_pins_gpio: mikrobus-pwm-gpio-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01a4, PIN_INPUT, 7) /* (B20) MCASP0_ACLKX.GPIO1_11 */
+		>;
+	};
+
 	mikrobus_i2c_pins_default: mikrobus-i2c-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A15) UART0_CTSn.I2C3_SCL */
@@ -396,6 +441,13 @@ AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (B15) UART0_RTSn.I2C3_SDA */
 		>;
 	};
 
+	mikrobus_i2c_pins_gpio: mikrobus-i2c-gpio-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d0, PIN_INPUT, 7) /* (A15) UART0_CTSn.GPIO1_22 */
+			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
+		>;
+	};
+
 	mikrobus_uart_pins_default: mikrobus-uart-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d8, PIN_INPUT, 1) /* (C15) MCAN0_TX.UART5_RXD */
@@ -403,6 +455,13 @@ AM62X_IOPAD(0x01dc, PIN_OUTPUT, 1) /* (E15) MCAN0_RX.UART5_TXD */
 		>;
 	};
 
+	mikrobus_uart_pins_gpio: mikrobus-uart-gpio-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d8, PIN_INPUT, 7) /* (C15) MCAN0_TX.GPIO1_24 */
+			AM62X_IOPAD(0x01dc, PIN_INPUT, 7) /* (E15) MCAN0_RX.GPIO1_25 */
+		>;
+	};
+
 	mikrobus_spi_pins_default: mikrobus-spi-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01b0, PIN_INPUT, 1) /* (A20) MCASP0_ACLKR.SPI2_CLK */
@@ -412,6 +471,15 @@ AM62X_IOPAD(0x0198, PIN_INPUT, 1) /* (A19) MCASP0_AXR2.SPI2_D1 */
 		>;
 	};
 
+	mikrobus_spi_pins_gpio: mikrobus-spi-gpio-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0194, PIN_INPUT, 7) /* (B19) MCASP0_AXR3.GPIO1_7 */
+			AM62X_IOPAD(0x0198, PIN_INPUT, 7) /* (A19) MCASP0_AXR2.GPIO1_8 */
+			AM62X_IOPAD(0x01ac, PIN_INPUT, 7) /* (E19) MCASP0_AFSR.GPIO1_13 */
+			AM62X_IOPAD(0x01b0, PIN_INPUT, 7) /* (A20) MCASP0_ACLKR.GPIO1_14 */
+		>;
+	};
+
 	mikrobus_gpio_pins_default: mikrobus-gpio-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -629,8 +697,6 @@ &main_gpio0 {
 
 &main_gpio1 {
 	bootph-all;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_gpio_pins_default>;
 	gpio-line-names = "", "", "", "", "",			/* 0-4 */
 		"SPE_RSTN", "SPE_INTN", "MIKROBUS_GPIO1_7",	/* 5-7 */
 		"MIKROBUS_GPIO1_8", "MIKROBUS_GPIO1_9",		/* 8-9 */
@@ -803,15 +869,11 @@ it66121_out: endpoint {
 };
 
 &main_i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_i2c_pins_default>;
 	clock-frequency = <400000>;
 	status = "okay";
 };
 
 &main_spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_spi_pins_default>;
 	status = "okay";
 };
 
@@ -875,8 +937,6 @@ &main_uart1 {
 };
 
 &main_uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_uart_pins_default>;
 	status = "okay";
 };
 
@@ -926,3 +986,7 @@ &mcasp1 {
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&ecap2 {
+	status = "okay";
+};
-- 
2.44.0


