Return-Path: <linux-kernel+bounces-118668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291988BDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAB4B26B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7271912DDA2;
	Tue, 26 Mar 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGeOGb+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A173168;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=PCaVaWDP6YePIaiiDRHNL7SP1ClA1ULdakLDvRSs/gXjI9qTUZwo4kkxahL84hwQHf2GWzAc0T83X/sBwWY6glEA8SIG80nEpjJXG9xnpESFFxPb5KpyADDLdWefUKXCr8MQkwNpwyiBTKWpD99AJGtg+mpdD2hQFtJUFYwFzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=ybgicixfvgIyf2nA0rMT+ZMSsUM/wG8tG6kjryEnsjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncIJkZqo91mm/X/ruprr2t+DjS3787zVlscfAH+HZwZ/iVOzYq2NWwYYj2YAq2lvFZX32GRwo/tIDykk3RhVRvp+LCkaNGysZnRrBEW4y89qHBeg4hoXHAS8LKdB8KAqhHpsXHSZws/QEeIXSomfxliG5f6/czEU8kOgmfK3s14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGeOGb+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EAD4C43609;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=ybgicixfvgIyf2nA0rMT+ZMSsUM/wG8tG6kjryEnsjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lGeOGb+gf78BrGl89BlMPjFJ9rNy2zzC03NCbPcE6Q2auB9iYPGVNLpv1YnzIHhIC
	 jdyzeRYJZGGUF0vJV+RNuCRPxOAuH58h9satbFON+AcFJnyTnD4ZwM1BCES+z0VTJM
	 ELXyDRvvRidPkX+cEL37i7mlrKZNfa/cdf+HdjoHrVn7inBgeBlTfOKNzgQXUYgrqY
	 Bzwm6a1FDG1afD5YopvAikP1FEou/H6KHUDmFoPzITGTmMEY/yhk+HcPIMZgeMdfou
	 xfRnejynr6OBv69Y4pFWXjY2mh+lJ0l5vZDgqJ2Vu8mcKg9XwdPdYpJv4OPUjQTwUq
	 M7B4GpiMg/Zqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CE5CD1284;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:58 +0300
Subject: [PATCH v9 31/38] ARM: dts: ep93xx: Add EDB9302 DT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-31-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Peter Rosin <peda@axentia.se>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=4425;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=MKdM8vhmNOKZirnboyQWFUuT0cV/ct9mBrNONV7yAdc=;
 b=Q/DpV8risrBMFtkJ6nMHHgKyBnUtuv7cJmXzizUyydG+O+WRnOKuxOmePkk79792xlc0PmgwEtYu
 us2lNSYFD8SWk24sUNUm1odyD/2o/3ruPgbMVtyunqzXSbFA1BN7
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Add device tree for Cirrus EDB9302.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/cirrus/Makefile           |   1 +
 arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts | 181 ++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
index 211a7e2f2115..e6015983e464 100644
--- a/arch/arm/boot/dts/cirrus/Makefile
+++ b/arch/arm/boot/dts/cirrus/Makefile
@@ -4,5 +4,6 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
 dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
 dtb-$(CONFIG_ARCH_EP93XX) += \
+	ep93xx-edb9302.dtb \
 	ep93xx-bk3.dtb \
 	ep93xx-ts7250.dtb
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts b/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts
new file mode 100644
index 000000000000..0bf10086f969
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/*
+ * Device Tree file for Cirrus Logic EDB9302 board based on EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "cirrus,edb9302", "cirrus,ep9301";
+	model = "cirrus,edb9302";
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x0000000 0x800000>,
+		      <0x1000000 0x800000>,
+		      <0x4000000 0x800000>,
+		      <0x5000000 0x800000>;
+	};
+
+	sound {
+		compatible = "audio-graph-card2";
+		label = "EDB93XX";
+		links = <&i2s_port>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&adc {
+	status = "okay";
+};
+
+&ebi {
+	flash@60000000 {
+		compatible = "cfi-flash";
+		reg = <0x60000000 0x1000000>;
+		bank-width = <2>;
+	};
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&gpio0 {
+	gpio-ranges = <&syscon 0 153 1>,
+		      <&syscon 1 152 1>,
+		      <&syscon 2 151 1>,
+		      <&syscon 3 148 1>,
+		      <&syscon 4 147 1>,
+		      <&syscon 5 146 1>,
+		      <&syscon 6 145 1>,
+		      <&syscon 7 144 1>;
+};
+
+&gpio1 {
+	gpio-ranges = <&syscon 0 143 1>,
+		      <&syscon 1 142 1>,
+		      <&syscon 2 141 1>,
+		      <&syscon 3 140 1>,
+		      <&syscon 4 165 1>,
+		      <&syscon 5 164 1>,
+		      <&syscon 6 163 1>,
+		      <&syscon 7 160 1>;
+};
+
+&gpio2 {
+	gpio-ranges = <&syscon 0 115 1>;
+};
+
+/* edb9302 doesn't have GPIO Port D present */
+&gpio3 {
+	status = "disabled";
+};
+
+&gpio4 {
+	gpio-ranges = <&syscon 0 97 2>;
+};
+
+&gpio5 {
+	gpio-ranges = <&syscon 1 170 1>,
+		      <&syscon 2 169 1>,
+		      <&syscon 3 168 1>;
+};
+
+&gpio6 {
+	gpio-ranges = <&syscon 0 87 2>;
+};
+
+&gpio7 {
+	gpio-ranges = <&syscon 2 199 4>;
+};
+
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_on_ac97_pins>;
+	status = "okay";
+	i2s_port: port {
+		i2s_ep: endpoint {
+			system-clock-direction-out;
+			frame-master;
+			bitclock-master;
+			mclk-fs = <256>;
+			dai-format = "i2s";
+			convert-channels = <2>;
+			convert-sample-format = "s32_le";
+			remote-endpoint = <&codec_ep>;
+		};
+	};
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&spi0 {
+	cs-gpios = <&gpio0 6 GPIO_ACTIVE_LOW
+		    &gpio0 7 GPIO_ACTIVE_LOW>;
+	dmas = <&dma1 10 2>, <&dma1 10 1>;
+	dma-names = "rx", "tx";
+	status = "okay";
+
+	cs4271: codec@0 {
+		compatible = "cirrus,cs4271";
+		reg = <0>;
+		#sound-dai-cells = <0>;
+		spi-max-frequency = <6000000>;
+		spi-cpol;
+		spi-cpha;
+		reset-gpio = <&gpio0 1 GPIO_ACTIVE_LOW>;
+		port {
+			codec_ep: endpoint {
+				remote-endpoint = <&i2s_ep>;
+			};
+		};
+	};
+
+	at25f1024: eeprom@1 {
+		compatible = "atmel,at25";
+		reg = <1>;
+		address-width = <8>;
+		size = <0x20000>;
+		pagesize = <256>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};

-- 
2.41.0



