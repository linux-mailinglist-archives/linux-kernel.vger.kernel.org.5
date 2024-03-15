Return-Path: <linux-kernel+bounces-104813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE187D411
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3780C1F2123D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F0524A5;
	Fri, 15 Mar 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX6IKO5d"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7C2E40B;
	Fri, 15 Mar 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528639; cv=none; b=uSAEUjNaZlIEIMXm3s16N/z08xpptTCGVc9txPWV/XWldLIGQVGplSexoeHAX54y/wC9QdD8EMj6DW928ze1/Ee0UObKZYikdKWS/1G4q9wxx1p09/abMHcd0Zink2zLTP+Q9pNaRSfvxLVZ0yl1jbCXl2nvnUbe/E63SdlQuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528639; c=relaxed/simple;
	bh=rVU0yTHzoawvSWHOs5Wf/V9UpgYrvdMriNWcW+QQ5KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohNfyecN6yUZ4wz25s5MuTlYMzMONjK8Mnlgj/BH3+1MUH7HchstHm7khRNl73J5wz5zNnqCY0opGwNGAG4+zRPtOfYNTq4D9WCm9F/ZphgVUnpJEVzRF7R9v3JYOyve18XoA+OXfvvL8QsUaPo2GIZqRZ0ZxYS0u2ZTUZdeP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX6IKO5d; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1847943a12.2;
        Fri, 15 Mar 2024 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528636; x=1711133436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCkB7IphGBPGl1w/S0psqC8P5Um5bt65HZvq4RRR00Y=;
        b=KX6IKO5ddDxaIn785XdGSc1F02svYZckm0Sa0r67QrwXb2Z2L0zlVP1kBCuhEdArHz
         yo48ZoahLMElYEqzimyepbfb6gAVwNg7KdaZrTIoD0sFJMlasvmFFpAW4WrN4++xtorF
         wIaU2aF9DSlYSnAJ4JVqy1S9/IBQfAVmxq2Fx6Bqw70dCVhMK35ag02i/JXCemsXYjUK
         0ldUN4XNRLIUcVWZkpqGDcMCn+saiKpgaKKRZDQ71D63Ucw6WeKhk7Jzry8giAG8cjVX
         mgsAeNa/BPgTsjZYZ6F26Lj7h2MYr//X92N9BQgE5L9BInf66eISX2SsR9iJx1f8uHJ5
         y3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528636; x=1711133436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCkB7IphGBPGl1w/S0psqC8P5Um5bt65HZvq4RRR00Y=;
        b=ns8L0rSppByn5HMOMQNTowPAHjNpxM9E4zKT5L4edADwVIAJEn+p8AGJIrrLN4RmbF
         XdJFxOFOLyI/eeY0hObJu6ScWVb8YTyJGmdM0xuEl03QK+mDBRzHb3Gxzf52oPFWsqRu
         GRqebKvb8xdzas8ZuLEGkDlk+207xkyuv/pzlwyn6P5AKwdpCxzKRi9lSa/+m5PlBexi
         tE/67SbmT6r2cdBB7rlsw9ffiWxvpAPAB8bcLCh+W6UbtjMUhg8F1Y9+IYx6Ovg48RCm
         1svTMTW6xP99+FSRZNL9rID4prEYklu1vvScIDofuA8g75fl9Q2kXJj1ySx0tq0D94dR
         qJjA==
X-Forwarded-Encrypted: i=1; AJvYcCW/DXocrUC+FLNQzWP6rRQ8tv873IMVAjFIjMGy/exGMPx9q+E2yGXA1fb9PQ4XXO8XeNbeeV3JYcSf6Ig8Q8Wt5ksqzDqWS2NadxGJJl7izCjit045g0U3dqT+wj+s0FvBKqEQEQiBLDhfyanlKG9gxbqw1bmqf2TTryGHH8/9INL9zA==
X-Gm-Message-State: AOJu0YxbeQB9xZnSz6xNRlM891lmy5HzQr5x5MawPjNcfqbGZb5yJh7f
	vTj5KIM9hvXyj3KS3ONsW4wdLAg0NV56wL6VZb7gJEEYJG08t+6KyVY+Z+ip+a1mUQ==
X-Google-Smtp-Source: AGHT+IFR9Rz9QYZm4Zrmj3QCj98EeqjLoIF4d8U8fx/cYS6Sv51WOwxOGnn90k4PIrka569oMmxqXw==
X-Received: by 2002:a05:6a20:2585:b0:1a3:504d:c064 with SMTP id k5-20020a056a20258500b001a3504dc064mr2238027pzd.55.1710528636650;
        Fri, 15 Mar 2024 11:50:36 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:50:36 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH v3 8/8] dts: ti: k3-am625-beagleplay: Add mikroBUS
Date: Sat, 16 Mar 2024 00:19:06 +0530
Message-ID: <20240315184908.500352-9-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mikroBUS connector support for Beagleplay.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 76 +++++++++++++++++--
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index a34e0df2ab86..886308f99d1a 100644
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
@@ -230,6 +231,33 @@ simple-audio-card,codec {
 		};
 	};
 
+	mikrobus0: linux-mikrobus {
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
+		i2c-adapter = <&main_i2c3>;
+		spi-controller = <&main_spi2>;
+		spi-cs = <0 1>;
+		uart = <&main_uart5>;
+		pwms = <&ecap2 0 500000 0>;
+		mikrobus-gpios =
+		<&main_gpio1 11 GPIO_ACTIVE_HIGH>, <&main_gpio1 9 GPIO_ACTIVE_HIGH>,
+		<&main_gpio1 24 GPIO_ACTIVE_HIGH>, <&main_gpio1 25 GPIO_ACTIVE_HIGH>,
+		<&main_gpio1 22 GPIO_ACTIVE_HIGH>, <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
+		<&main_gpio1 7 GPIO_ACTIVE_HIGH>, <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
+		<&main_gpio1 14 GPIO_ACTIVE_HIGH>, <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
+		<&main_gpio1 12 GPIO_ACTIVE_HIGH>, <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &main_pmx0 {
@@ -389,6 +417,18 @@ AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
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
@@ -396,6 +436,13 @@ AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (B15) UART0_RTSn.I2C3_SDA */
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
@@ -403,6 +450,13 @@ AM62X_IOPAD(0x01dc, PIN_OUTPUT, 1) /* (E15) MCAN0_RX.UART5_TXD */
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
@@ -412,6 +466,15 @@ AM62X_IOPAD(0x0198, PIN_INPUT, 1) /* (A19) MCASP0_AXR2.SPI2_D1 */
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
@@ -629,8 +692,6 @@ &main_gpio0 {
 
 &main_gpio1 {
 	bootph-all;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_gpio_pins_default>;
 	gpio-line-names = "", "", "", "", "",			/* 0-4 */
 		"SPE_RSTN", "SPE_INTN", "MIKROBUS_GPIO1_7",	/* 5-7 */
 		"MIKROBUS_GPIO1_8", "MIKROBUS_GPIO1_9",		/* 8-9 */
@@ -803,15 +864,11 @@ it66121_out: endpoint {
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
 
@@ -875,9 +932,8 @@ &main_uart1 {
 };
 
 &main_uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_uart_pins_default>;
 	status = "okay";
+	force-empty-serdev-controller;
 };
 
 &main_uart6 {
@@ -926,3 +982,7 @@ &mcasp1 {
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&ecap2 {
+	status = "okay";
+};
-- 
2.44.0


