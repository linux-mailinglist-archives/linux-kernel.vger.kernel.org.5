Return-Path: <linux-kernel+bounces-103529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5387C0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857561F21C10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7373516;
	Thu, 14 Mar 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="QJYi0iCA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="VR5lhD16"
Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F973163;
	Thu, 14 Mar 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431649; cv=none; b=QBZ73J6/NiPYyGVrPAotW0yPBbXG89MEMZ2mtTb6jU0zTA2e5To/bz63gH/hwoOmwTG5P0JHmR1SVOWBkg4kWuBNy+TD3h0Q2xuSmLp+b7dDE801bjIDPaMeAMYxPGLwAKx6BlvepvdIYifqcLHayl9a1h+qOkza0ctRHbOWKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431649; c=relaxed/simple;
	bh=Mcb4jkmhJk+EHSfGl4ZTsIHzvYmYuM4Ok5EqCEXJmrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebgzbwWe0+O+LizzGr1RaJuKmvyFdoE/Cf3IOYzOHT9+vIFoIHBjLkAjCnsPIfwwm6MPVW18PHU8LiIXE5uspKz++peaXLRCvkpXyhUPqyYV9+N5Nf5oaqBBh+ZXTJrMjKD3qrHLfjGdC7jAb5j7VGq8gPZ/gR/QdhzihjJ7oFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=QJYi0iCA; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=VR5lhD16; arc=none smtp.client-ip=79.137.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=iF97vxV7BrgXpXlszlj7gJFTV57ZBbqlf6D+BsC1p+c=;
	t=1710431647;x=1710521647; 
	b=QJYi0iCAffCgFwDDmnp9xqo9DpHKwEQqGWr3B59C0aBXAA+KFJGUBcaVvodswxkQzAatFiP63kwC1A9wXHtTU0hTEZPrZmKTQMnaEqvCH4M/0gmH9mSAYS/UAegaK014Go3uQZph71m3G1qkXOUHpy6fB7d+gzx+/toUcRglJS0Ngce7Mi2lRqpqqEZKXHW8gAOP4lO/WKNlHGpcRxdogmdDTpV63a7nqCmfQsaaIzlExGxZ5lWQAl7yRZOI5k4T9/TZGP7YTBmcI5cQhlaaqlCMcROBLiXH5XA5xRrBxVeflBnO3EYftsrG889l5YcBPkqcZ6IyIfkKA7zcSSsypQ==;
Received: from [10.12.4.6] (port=33910 helo=smtp32.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rknPA-006iHH-E9; Thu, 14 Mar 2024 18:54:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=iF97vxV7BrgXpXlszlj7gJFTV57ZBbqlf6D+BsC1p+c=; t=1710431644; x=1710521644; 
	b=VR5lhD167lc1vM/cT7BkN8z0jPyf3t1xMOhIT7JDaARZ86LXoueln+echot8kKpFdSQTmlYVGlo
	vvFQnNcgaZeNkKBti9VZnsTg5XF+DXbJo2lFLuF4Ub41VP/7/irQEwStHUO30lH6a6ycxvZO4NfD4
	msJSniQF1rY0XP6qKEkGJxrxqHYhHN32BhSfKsDRTxdpQgWQJdZj6ul1HJ+EC9bD+xoaLGVMabC22
	sWUXjax84vT0THFAjDsFUP1IMp3WplMI5lw5tM9M9Xtul0JmV7LeFBdLu0nAGHhVsLOoVsooS1Qvh
	n20By6fPVl3FVkU9CK0OOftIse8kr6z9QzsA==;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rknOw-00000007WvT-2VKQ; Thu, 14 Mar 2024 18:53:51 +0300
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
Subject: [PATCH 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Thu, 14 Mar 2024 20:53:06 +0500
Message-ID: <20240314155306.11521-2-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240314155306.11521-1-hitechshell@mail.ru>
References: <20240314155306.11521-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DDF776407DD463AED7AC1984F64828CE8182A05F538085040DDA203CD7554BDCB91417EB218679B82066AEBC27A175451A626F5E7A5DB8502FE495290C33621F9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BBC4AF2A01A27A06EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379108F895B68B2FFD8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8093DF926811FC38C216C4BA03E6A86A55CEF1BFD8DE5DC2920879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F79006377C70927E34808485389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC821E93C0F2A571C7BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CE6BDB36F057AC83CC0837EA9F3D197644AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3CB22C283732751EBBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6957A4DEDD2346B4275ECD9A6C639B01B78DA827A17800CE74526E367E45555E8731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5D4F990E96E0547045002B1117B3ED696D5B231DD2FF3671BB74D9144D44E4FCF823CB91A9FED034534781492E4B8EEAD577AE849BCD98940C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD4083841D20A0C49064F5C9A34415F899B14B08E4F12A4A6F6A98EC6D592F36B4A7F0923522A066E7C77D8D956826D33DB8CF25F8449602BA570E4E846A1ABAD5DE028DDFF752A5242BF32D1DA1046D202C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzKE07ZeRNuCMQ==
X-Mailru-Sender: 7219FA8B682B638D379344632618B47A51E657991DB3E45466B41F5249512E91014BCD7CF731B1A1DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F55EC4B11F4A1BFD60049FFFDB7839CE9E436D59F16A22D1106D61213FF8B6AB9D881A0DBF0DC461E64A0FB364FA09D05E
X-7FA49CB5: 0D63561A33F958A50E6A4F8413C98D7EB8862340981031EE0A13EAB3D3821AC1CACD7DF95DA8FC8BD5E8D9A59859A8B68BFD6B1B042489ACCC7F00164DA146DAFE8445B8C89999728AA50765F79006371DD7586035AB81AE389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8893991AD1F2BFC6AF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7040597DFFE1F52DF731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzLYgCt4vsK0iQ==
X-Mailru-MI: 8000000000000800
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
 arch/arm/boot/dts/allwinner/Makefile          |   2 +
 .../sun5i-a13-pocketbook-614-plus.dts         | 254 ++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index 2d26c3397f14..fe321865beed 100644
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
@@ -82,6 +83,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
 	sun5i-a13-pocketbook-touch-lux-3.dtb \
+	sun5i-a13-pocketbook-614-plus.dtb \
 	sun5i-a13-q8-tablet.dtb \
 	sun5i-a13-utoo-p66.dtb \
 	sun5i-gr8-chip-pro.dtb \
diff --git a/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
new file mode 100644
index 000000000000..89898fa16ff7
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Denis Burkov <hitechshell@mail.ru>
+ */
+
+/dts-v1/;
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "PocketBook 614 Plus";
+	compatible = "pocketbook,614-plus", "allwinner,sun5i-a13";
+
+	aliases {
+		serial0 = &uart1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		rtc0 = &pcf8563;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_pocketbook>;
+
+		led {
+			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
+			default-state = "on";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		label = "GPIO Keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pocketbook_btn_pins>;
+
+		key-right {
+			label = "Right";
+			linux,code = <KEY_NEXT>;
+			gpios = <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
+		};
+
+		key-left {
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
+		pinctrl-names = "default";
+		pinctrl-0 = <&pocketbook_reg_mmc0_pins>;
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
+&i2c2 {
+	status = "okay";
+
+	/* Touchpanel is connected here. */
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
+&pio {
+	led_pins_pocketbook: led-pin {
+		pins = "PE8";
+		function = "gpio_out";
+	};
+	pocketbook_btn_pins: btn-pins {
+		pins = "PG9", "PG10";
+		function = "gpio_in";
+		bias-pull-up;
+	};
+	pocketbook_reg_mmc0_pins: reg-mmc0-pins {
+		pins = "PE4";
+		function = "gpio_out";
+	};
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
+&reg_ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
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
+	usb0_id_det-gpios = <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG2 */
+	usb0_vbus_det-gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.43.0


