Return-Path: <linux-kernel+bounces-105357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC1187DC9B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 09:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FAAB211BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65217551;
	Sun, 17 Mar 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="YNU1zbw4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="eve/zKq/"
Received: from fallback16.i.mail.ru (fallback16.i.mail.ru [79.137.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1463CF;
	Sun, 17 Mar 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664556; cv=none; b=c92jyb7eutfgYtx6zcwrqKbvlRQMBQAEUFMnhA1rQBWYXAPyFU2CSdmoRS4KsoOebEps9JAiBYA8K0Tyh+5y7p0Gh9UH/omT9l8jlKDzTCX9WFF5IGBOZg/WjcfIy5hLUB4yU9xjOCZ9UDPWiA2182akgUiad7LfPPt3e5urNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664556; c=relaxed/simple;
	bh=JZ0NPwk2wfO+lE+1VF6zcoc6+PI5PcjdCz8yyDrI3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbnEx1YFUAwDEvjKNX1VR2yR9N1NtzQZaQeIEzbq+6sGxD5xABYJRW0vxh325G1/FFVqvWD34Yeqlk6v+6Wsom4jWjtgFYJCPqlxclP2b6MLr1VBqlvumRoO5zlN31CtUlLhLOsHlMjhn8jiIy9iEfELEeVms6BOBX9sXrGRCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=YNU1zbw4; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=eve/zKq/; arc=none smtp.client-ip=79.137.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=CN6JDfK7bX1I61jAYM86agulUbzQhbg+O95vc9JmBaw=;
	t=1710664553;x=1710754553; 
	b=YNU1zbw4jDQjSYsXACX+U365y3J35LCHT3Y2ImxU9GWgTxCmfKtcqW5elR0sm4e++tCnrfFsmvnx2XEwT3chLkjB+/o7PvBHDqc4sGxwNqbh8WQQQgbsDCiATxuEE3L5nqmq05dCX8NJlU3pRb7qabeybSJf5CZAuKAqNMy9VzIv+lRKkHEi3JyrhNSBcI74qTHWYCcJyFhliuA4iyV44F6bxSDa6VYBV1SHYfoUMDjgh2NSrVekkLTtZpatXzrU22ewUPTjI5kO/NaRHr4MOC8jiq49C1R+ospbBH+lknWNsXKNQPfAf2G4aPmAf4cm8gdzgXAbJJBpI8GiwVDNEA==;
Received: from [10.12.4.21] (port=37158 helo=smtp42.i.mail.ru)
	by fallback16.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rllzi-0037Lu-OC; Sun, 17 Mar 2024 11:35:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=CN6JDfK7bX1I61jAYM86agulUbzQhbg+O95vc9JmBaw=; t=1710664550; x=1710754550; 
	b=eve/zKq/Czuo+XIYU76nrtIKAbRMOnqs7CVgD6pxj5qeRjZ7U76RbA6uCSvS1v+fu0zNCEC2Pst
	C1y174QC3mwaVtBoJOYawQ4by4x2bRjFSBgUds+Wf6VkNRy2+ORkBKwTtoS4cGvR084WqptdevviL
	JB34zUlPs/ak6nSXRJgPkjrrZTorEZEJpGaqpaPxhQvotildrnUw+ozDFO+ni/9rcqKNIHy2oEHcK
	DZarRDGEYXlhetsZ8vPdY7+qDQKwPSaQ5Ro1FP05xt1v9pyCxGCOnTJZfa2Uit47OORj9wEmyXD+G
	JbMy0G2nNSST//FPrboz62uZONfqYYCRDlTw==;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rllzT-00000003bZW-1hfl; Sun, 17 Mar 2024 11:35:36 +0300
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
Subject: [PATCH v2 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Sun, 17 Mar 2024 13:34:45 +0500
Message-ID: <20240317083445.4668-2-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240317083445.4668-1-hitechshell@mail.ru>
References: <20240317083445.4668-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D21AFE2E000C69B1FBAF020A234192257182A05F5380850408186B5AF5C767337A6D5EE0DB6E1EC8D66109C7074A708D1E73681F7A7D763F85872F0C4753F95D2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7904AD829351C4442EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375A514678F9DF65078638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D888B320BF4FEADB1FDF8A4F223E1135805FE60413F79975BA20879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F7900637FD2911E685725BF8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC878444BBB7636F62AF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4AB4081B6A6C2E07302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C371D45A410EF2C599BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE716460D1AD9DD20BC731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A50F0768B353E8B90E5002B1117B3ED6960D74BFDDB9A28BCFD57BAD45EC4C5DE1823CB91A9FED034534781492E4B8EEAD2F8D89FC5850081EC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF82FC99E1097F20B4C9B98C9F669F071A9CFDF5BB981B8AED8991A64345F09881C6BFA615E6C3782A6CD0533D1BDF67EDB7C6CA7B20F0E0161086B51C93BC5CDCC496DB9ED692F86642BF32D1DA1046D202C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcOf6QaFRKuSyQ==
X-Mailru-Sender: 4504732FDC166E0E21A896EFB29DF0C971F68148D753C922A6D5EE0DB6E1EC8D66109C7074A708D1A165F1893FAC5C757035CE191D947B125A92E71CC7C3152D68C1C4E17AB7C113897BD3F63E44C176075AE25EB8835B0E4F1F69ACE5C499A7A0577211E31DE16C327D77830F209D780D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F53731507968CA6C83049FFFDB7839CE9E3B76AC3706630B51EB99F5F6EF410ADD96B0C1C71F587F9FD09ECDC84A0898A1
X-7FA49CB5: 0D63561A33F958A552F256B2D4E1B822CD734CAACE7DB8500DF3FD768417D07BCACD7DF95DA8FC8BD5E8D9A59859A8B6A50BD5087FBFCDAACC7F00164DA146DAFE8445B8C89999728AA50765F790063713EF0ED8E3D6D567389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC808214CF94FAA95E0F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE75F273AA5B61CCB8C731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcN3FUw5bP4EFA==
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


