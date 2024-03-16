Return-Path: <linux-kernel+bounces-105214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF987DA9A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490B11F21412
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7AD1B974;
	Sat, 16 Mar 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="FjOTgcZA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="WvHvfakD"
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CB18E1E;
	Sat, 16 Mar 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710603935; cv=none; b=YklUT7QFXXT0S6udBHhLL0PG9hsxMoGzlwfJwXKIUW0LhTkhAPdqMZ7ZOaODydZpzyJygQ/jg5DCzOstCWEP/R54y0bIr1TJPZhT0a1/B3FypnM2TuW0XkOloqMGxtLikTL5y4jsR/+3IAAN5OeCzYzJeH/emHrmPiMvQxmB9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710603935; c=relaxed/simple;
	bh=JZ0NPwk2wfO+lE+1VF6zcoc6+PI5PcjdCz8yyDrI3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpsOqIeYRLWZAHs7NYAqKeK4vhLvIg6mXbEQ6q9S5GlGdVSNY3wKjqC54kflcL6NbNtXjeJR0vY1HVENu6UKA3hVOm1Ff6H5fIoc45q5pQHoQiVAnPMKDyoF80UDoEpjJD3R4yptnquZLSycdy6fCbmBfL5IEE5GIk7XTSW4ZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=FjOTgcZA; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=WvHvfakD; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=CN6JDfK7bX1I61jAYM86agulUbzQhbg+O95vc9JmBaw=;
	t=1710603931;x=1710693931; 
	b=FjOTgcZAI+Gj5bLpML0YgHZ4Wfe9e/3cRKQp+Y08LSNOQtMigm+H4dLtof4ToTDXzt7TddiyyvMbjrACO/CNVesa1Mpk8NH4rXrhaqmjTYV6qaexP6JzZyNrVvwnL59vcsHbO3S/c6/w2BmNyGYIrPbMeCRDdo7QmETBxen+uEbsL+63pVVP/29Pa3QcUXtcbK/1eXcA5utayhcRCaCOXUv2fj/s0QdJpy+XVRUCpe8bvu5jj7dhAKO9NOL0+fkW5rrhBmUdu16Lvm2jE0dV9hRAZJYSG2Qjf7Plyupphaiwf83yO2G+DdmaX+G2QGMWYoJa/iZV7NsSVeOXJgu9cA==;
Received: from [10.12.4.18] (port=38180 helo=smtp45.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rlVHz-00BlcX-Je; Sat, 16 Mar 2024 17:45:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=CN6JDfK7bX1I61jAYM86agulUbzQhbg+O95vc9JmBaw=; t=1710600335; x=1710690335; 
	b=WvHvfakDy4t/qEzZ0cC1cHpiIneqowXOkNL5SRIXMGF9INZNhQt4NAmdtB8yt5MNJQbdRRfXTbi
	9q42FsA8dHs4hgdRkLmi6fM6DBq9/BTkHvx0hSTWWsnbascGOfoWrhJhrgn09iEbUx7cPOwDFczO1
	4qsGHR2QWQIZ+atbEkJOfNP8WoeZErtmmObcGv7WmxEBV97KU5kQmLQdjZbn6krOHhQcoa0n9iAAu
	i3QYRI4Y+bkcuvDkG0PuPcl9Nidvc4S1+x8uzlMahP3iynZsZxB6hcMgL0OT29f/QX+RtGYT7gQ5O
	Q9BKJucNQEBAJ++yyIyBA9/2wmHZN8xvng0w==;
Received: by smtp45.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rlVHl-0000000FGH7-2BSG; Sat, 16 Mar 2024 17:45:22 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Denis Burkov <hitechshell@mail.ru>
Subject: [PATCH v2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Sat, 16 Mar 2024 19:39:18 +0500
Message-ID: <20240316144429.12529-1-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4203654.1IzOArtZ34@jernej-laptop>
References: <4203654.1IzOArtZ34@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D173D0CE202DA28435F3B31DD656B8ACF182A05F538085040D162DA69BB17355E411046492FDDF806924206B0082DB7FE8CC87B0B1383B58CA68FD0FC62998116
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE774A7370C81A54524EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E149C29A36E092738638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8BB349F7AA733664318169FAD750E6BF82C9C5F42FA69006520879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FA18204E546F3947C5FF72824B19451C6F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637BA939FD1B3BAB99B389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637CCC8F09102F0E6F5D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE73256386ABDC76C25EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE7A03E8F3C2D3812562EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7E55904F49B65B757731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A54286848837AFB73D5002B1117B3ED69607F1B93161B30208219207EC0A953D2C823CB91A9FED034534781492E4B8EEADC24E78AA85F86F6CC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFF6DFF5B2C10896D2926D612734AB7752A2E446071C564F2031C5C828B8DFAE3690383D67CF2F9DA86CD0533D1BDF67ED0E0DE018BEBCC37BDFF5B157DC72BAB7CC42D5113B75093142BF32D1DA1046D202C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcMdy5uj4iKOtg==
X-Mailru-Sender: 4504732FDC166E0E21A896EFB29DF0C959A9C5E3F1C34ADE411046492FDDF806924206B0082DB7FEA165F1893FAC5C757035CE191D947B125A92E71CC7C3152D68C1C4E17AB7C113897BD3F63E44C176075AE25EB8835B0E4F1F69ACE5C499A7A0577211E31DE16C327D77830F209D780D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F5F15B183966BAD3FC049FFFDB7839CE9E3B76AC3706630B51A8931CB841D9E281CF68063B2387D6932F7EA26CFC00C420
X-7FA49CB5: 0D63561A33F958A540D061EDEF697A5DD7F607F4CE713552DBE91C0D800243E4CACD7DF95DA8FC8BD5E8D9A59859A8B634143DAF28A1E3E7CC7F00164DA146DAFE8445B8C89999728AA50765F790063713EF0ED8E3D6D567389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC808214CF94FAA95E0F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7610223311226520F731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcP+1+cPCfwtkg==
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
 arch/arm/boot/dts/allwinner/Makefile          |   1 +
 .../sun5i-a13-pocketbook-614-plus.dts         | 215 ++++++++++++++++++
 2 files changed, 216 insertions(+)
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
index 000000000000..b5449301789a
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
@@ -0,0 +1,215 @@
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
+		led {
+			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
+			default-state = "on";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
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
2.43.0


