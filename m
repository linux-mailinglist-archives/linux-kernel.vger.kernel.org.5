Return-Path: <linux-kernel+bounces-145667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A88A593A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533391C21120
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783368565A;
	Mon, 15 Apr 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="TZubt6uX"
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44983CA1;
	Mon, 15 Apr 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202575; cv=none; b=DpT9d34PemW2nebrf7xjGwl5MkEVmVGOFzT1qtYq+XhT8GXPbBAbNPK2vZCZfO3wY5glw9DmyRDmn/d22H5hm4KeIWBrAgt08eOKqpwnyB2QODyMhvbg576n+GlbDJjtzg4VNGY6I1qTdAUdTBJmkKs3ATrgo/u94VMC+BSreN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202575; c=relaxed/simple;
	bh=biByVBbkAZ68MYUQKdKCJ7gN7VvvprMsFkR7uyyLIek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDG9HxtOWy/i3z8LzsuINxIsU7X7NCboN+p/iu6R2p/kIMCeJm2+8Ehib0N7Vf3ZNe+zckQKq5Vg6Iqt7ZuyzEQ6ubuwtHFY62rHiQuwTKTcN0eUpwuZW2t9hbpGFawioJk1Yt1stg5nx65GarWxg/BqeXoS6i98Irp5gt/JHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=TZubt6uX; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=S+B/BwjKiFKvxR3npvOPf2lFSO7ikKYL7HdPiLZ7NvE=; t=1713202572; x=1713292572; 
	b=TZubt6uXqc+noNhDwnLEd+MNF91yk/UyOlRwlWMu7R0gkjrTjPs6GU1SfKy2XXgLOAfAUqZDqoG
	PvU1x5rynJEhpfBmjJvgSXfffVY7YHOSgBvyN/V19OU9HjT0pM7Rykb8FWAIrU6bB01Z5t9PdMeJE
	2cShqKA9xyoyVr5MJGv9M80yoDaWQTuO1M2Z/ejHq8MS+O7/upr4PS/32NInyzd+zQ/X547olYkvW
	3OgPIt96Lt8iQ97TH2YsZpVrmWmIs/56Fr4/Md21d1289S94dHmC+AE1c3JbXj3yS+sgnaBqRkMZk
	3+SA8EqctWcRfDB19vi3IeO+tM+Y3UHh3Jsw==;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rwQFP-00000001pHD-2K85; Mon, 15 Apr 2024 20:36:04 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: [RESEND v3 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Mon, 15 Apr 2024 22:34:16 +0500
Message-ID: <20240415173416.13838-2-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415173416.13838-1-hitechshell@mail.ru>
References: <20240415173416.13838-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp39.i.mail.ru; auth=pass smtp.auth=hitechshell@mail.ru smtp.mailfrom=hitechshell@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D327F0ED0D500BEE3D0D2DC2898190C0A0182A05F53808504014CFB1B9BF9E27819487ABAC94A94B5478D5026272203F09C58EB4712ED216F00B100F9AFB84C8EA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E1F5C7CA1DBFB751EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F97367C191A19EB28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86B014C1E5BC497E6FAF0B375F22606B55439867D2771A95620879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0998E19D2343267C68941B15DA834481FA18204E546F3947C78444BBB7636F62AF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375FFD5C25497261569FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE7AD4864ECBC8F74AED32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED629923F8577A6DFFEA7CF35F20856D7AD7DECD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6F412240F52665EC775ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A558C7B75AD1E9E9125002B1117B3ED6969F48491B480DD30AFB820E9FE7BD014C823CB91A9FED034534781492E4B8EEAD39B22F2BA948E1C8C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF3C6677A6DD9AF0182C10748690CBDD90CF1EA8853CA540E6C89EFFABE4D24CBBA30287D0F4871F18C84F44966DD9651B7C7D60259EA92F6D14A4B3107F7B67BAF09185E0332749FB42BF32D1DA1046D202C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwhzzK0WJvz0oU7XiYwvldQ==
X-Mailru-Sender: 7219FA8B682B638D379344632618B47AE8B4682377218437578FE190226AD4C0B8BA3287037AF2F5DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok

What works:

- Serial console
- mmc0, mmc2 (both microSD card slots on the board)
- All buttons (gpio and lradc based)
- Power LED
- PMIC
- RTC
- USB OTG/gadgets mode

Signed-off-by: Denis Burkov <hitechshell@mail.ru>
---
 arch/arm/boot/dts/allwinner/Makefile          |   1 +
 .../sun5i-a13-pocketbook-614-plus.dts         | 218 ++++++++++++++++++
 2 files changed, 219 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index 5fbb44ddacd0..6209243ad975 100644
--- a/arch/arm/boot/dts/allwinner/Makefile
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -61,6 +61,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
 	sun5i-a13-pocketbook-touch-lux-3.dtb \
+	sun5i-a13-pocketbook-614-plus.dtb \
 	sun5i-a13-q8-tablet.dtb \
 	sun5i-a13-utoo-p66.dtb \
 	sun5i-gr8-chip-pro.dtb \
diff --git a/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
new file mode 100644
index 000000000000..ab8d138dc11d
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Denis Burkov <hitechshell@mail.ru>
+ */
+
+/dts-v1/;
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "PocketBook 614 Plus";
+	compatible = "pocketbook,614-plus", "allwinner,sun5i-a13";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
+			linux,default-trigger = "default-on";
+			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-0 {
+			label = "Right";
+			linux,code = <KEY_NEXT>;
+			gpios = <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
+		};
+
+		key-1 {
+			label = "Left";
+			linux,code = <KEY_PREVIOUS>;
+			gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
+		};
+	};
+
+	reg_3v3_mmc0: regulator-mmc0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-mmc0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 4 4 GPIO_ACTIVE_LOW>; /* PE4 */
+		vin-supply = <&reg_vcc3v3>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupts = <0>;
+	};
+};
+
+#include "axp209.dtsi"
+
+&i2c1 {
+	status = "okay";
+
+	pcf8563: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_ldo2>;
+	status = "okay";
+
+	button-300 {
+		label = "Down";
+		linux,code = <KEY_DOWN>;
+		channel = <0>;
+		voltage = <300000>;
+	};
+
+	button-700 {
+		label = "Up";
+		linux,code = <KEY_UP>;
+		channel = <0>;
+		voltage = <700000>;
+	};
+
+	button-1000 {
+		label = "Left";
+		linux,code = <KEY_LEFT>;
+		channel = <0>;
+		voltage = <1000000>;
+	};
+
+	button-1200 {
+		label = "Menu";
+		linux,code = <KEY_MENU>;
+		channel = <0>;
+		voltage = <1200000>;
+	};
+
+	button-1500 {
+		label = "Right";
+		linux,code = <KEY_RIGHT>;
+		channel = <0>;
+		voltage = <1500000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_3v3_mmc0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_4bit_pc_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_usb0_vbus {
+	status = "okay";
+	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+};
+
+&reg_usb1_vbus {
+	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pg_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
+	usb0_vbus_det-gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.43.2


