Return-Path: <linux-kernel+bounces-144293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44E8A4442
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF30282039
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2A135A75;
	Sun, 14 Apr 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuYp7gPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1231DDD1;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114091; cv=none; b=QiGo6LPsokTucibOY3BQRcpRgHwtsQFXzzmxxlke6eWUeIYk/hu7/Uvl0/phZlVS/Awt5LN0ttPfibQA1uRcqQAK0bfIfuuQ690XkPvP5AqKNVpYx4ldRCYQrgAFNOfewzlRXYsXc7jESrCM+xmCVa/taVPLr5HggiKISaxRaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114091; c=relaxed/simple;
	bh=mhFeLCrwatal82689J4BD2+lCXaeDYEtzPYrA+v7zR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxvnYIag3af72KAMJgsk02R57HDj3OU3iMooZFi9qYB3O9bGPRqlmr6u/LmxRY6aacqUsbL913u9vsIAMapiQMpejt1ugIkbVymH1+kxj7/5p+DxHWfX6/gHwAgJfp/Z1OHCKBaXheS7ZLaOjI7QZpIYwX0bC/JVghoUpic9Bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuYp7gPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3495C3277B;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114091;
	bh=mhFeLCrwatal82689J4BD2+lCXaeDYEtzPYrA+v7zR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BuYp7gPDWys0rWglDsXPBM4wdGQQDuwrUqpeG5Y7U96+R9DCoo4au+FyYvvPD8vae
	 BtKJNqiEueTf3RwW2V+jrXJXDawtg67s5tNCdE80fVDg+hTdkpNKFqFgl31lLMmYKL
	 P0h8eFAIepKtXffUYVkiZ7XExMJQvHq5QaZnv5lSUwrqc/JdqqNBkH03bqwYrfgNXd
	 khSkXkO6QxukjA3IbEPvEcSlOgiAH7bNpf3Nb8/wN7csI0k8fMGeZqx8tYiT6zzGSu
	 TEe0Cfl4qaTm5csguQM8ivaHcrO3udQezW2fEa07U54zc5yp10oRRPlFNkmLnVkc0F
	 jzhMYZ1nYZRag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935D2C001CC;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 20:01:21 +0300
Subject: [PATCH 1/4] ARM: dts: BCM5301X: use color and function on ASUS
 RT-AC3100 and RT-AC88U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-soc-asus-rt-ac3100-improvements-v1-1-0e40caf1a70a@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com>
In-Reply-To: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713114081; l=3138;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=j9b3dbJqMcoEoUpOpDrZC6RI+SBn+VmxLPPihPauC6w=;
 b=dD1ZOzdlA2FdEjfj/blWyiR/jrYHXQVbhcbLmo9OJWnsXb+SgNxhUE+jqYxsbp75APsfsTFYD
 922V+xD+gSLDMv/SkPO1LNq+RY91bN9YmtFsRBl6O0+HNN4cHsNgjYn
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

As the label property for LEDs is deprecated, use the color and function
properties to describe the LEDs on the device tree file for ASUS RT-AC3100
and ASUS RT-AC88U. Reorder the LED and button nodes in alphabetical order.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi | 54 +++++++++++++---------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
index 09cefce27fb1..9271792a9e44 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
@@ -6,6 +6,8 @@
 #include "bcm47094.dtsi"
 #include "bcm5301x-nand-cs0-bch8.dtsi"
 
+#include <dt-bindings/leds/common.h>
+
 / {
 	chosen {
 		bootargs = "earlycon";
@@ -25,38 +27,46 @@ nvram@1c080000 {
 	leds {
 		compatible = "gpio-leds";
 
+		led-lan {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&chipcommon 21 GPIO_ACTIVE_LOW>;
+		};
+
 		led-power {
-			label = "white:power";
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		led-wan-red {
-			label = "red:wan";
-			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-lan {
-			label = "white:lan";
-			gpios = <&chipcommon 21 GPIO_ACTIVE_LOW>;
-		};
-
 		led-usb2 {
-			label = "white:usb2";
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_USB;
+			function-enumerator = <1>;
 			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ehci_port2>;
 			linux,default-trigger = "usbport";
 		};
 
 		led-usb3 {
-			label = "white:usb3";
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_USB;
+			function-enumerator = <2>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ehci_port1>, <&xhci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
+		led-wan-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
 		led-wps {
-			label = "white:wps";
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_WPS;
 			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
 		};
 	};
@@ -64,10 +74,10 @@ led-wps {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		button-wps {
-			label = "WPS";
-			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
+		button-led {
+			label = "Backlight";
+			linux,code = <KEY_BRIGHTNESS_ZERO>;
+			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 		};
 
 		button-reset {
@@ -82,10 +92,10 @@ button-wifi {
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 		};
 
-		button-led {
-			label = "Backlight";
-			linux,code = <KEY_BRIGHTNESS_ZERO>;
-			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
+		button-wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
 		};
 	};
 };

-- 
2.40.1



