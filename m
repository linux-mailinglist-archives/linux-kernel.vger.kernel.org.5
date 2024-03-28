Return-Path: <linux-kernel+bounces-122888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D7A88FF07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B76B23ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A5208B0;
	Thu, 28 Mar 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="BkDeYU+c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="2dN9LsL6"
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C167C0A4;
	Thu, 28 Mar 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629043; cv=none; b=W5RpoDq8CUD/Ej8zqJbHUI1xzFhPnXGkUYWYv1tlgFtiCZIUnWpbgDwyrsZRl8xqyiiPfokEkO/xuYplYyoU0p5DnpY9qyMoRzeJhGB7NlhKfS7O/LOXYYbj8g+EKaT75ocGJDskx/WPbD0qJFfb8J90lrBLYmFzTtLKq24I238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629043; c=relaxed/simple;
	bh=biByVBbkAZ68MYUQKdKCJ7gN7VvvprMsFkR7uyyLIek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8djdDkfcY/XDoE6fxiXgf7ZQm3Yr7pfV7az5k/8xVXaJMc568NXqy0jns0xnlSkTIIhvOoWYm7+j/J3z/wJnlljuavhnCXZuUOJLLxewmYYe+F3lTOFMrBxNOQfPdAncEQfSy3atAzOrgjih3856t2rIXgYJ0IRIPoM9ZpppJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=BkDeYU+c; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=2dN9LsL6; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=S+B/BwjKiFKvxR3npvOPf2lFSO7ikKYL7HdPiLZ7NvE=;
	t=1711629040;x=1711719040; 
	b=BkDeYU+cQsdDP2YL0kiTWxU81Uu4xbrT1xy081Y3w4L7urL8RJNH+rEmLqNB4iNv/E8HGB5k9kg/5VSqFMOfG3P2azw+X103zVrInp7A605dRxwxlIRGY8xweJPFzEqiw+F9dE7XmsMEWsXstfFGk7p99mcY1OLNx1zkcoXxDdjuyoOmHoQPj5rh2IDMlVUQ/SDwd3TK8JzzTZ1iduF3eGjmEBSc0Yy0WGr3NIWIVdPdAou/Z4Jd6AuFT6eqoR5se8dOTkC6YMKTwGr+lwCVNpUlmSGu7Ll7WksUtMWQ8CmyiPk1PvCI3L0e8iH2x9dsU48GnVV5q96Lg6+6o3io0Q==;
Received: from [10.12.4.12] (port=46620 helo=smtp37.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rpotr-009cPd-Vq; Thu, 28 Mar 2024 15:30:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=S+B/BwjKiFKvxR3npvOPf2lFSO7ikKYL7HdPiLZ7NvE=; t=1711629031; x=1711719031; 
	b=2dN9LsL6VAaupaLT5CSDgzLNPwnT1hlYRUwOTgjEKYCOsgngk6ZM8b/6sdZXBt4j7VxrNBayscR
	mGfSsM2tHVtOnx8zeyEfxSi/2KEMAFhjOEGHpQAe+4gg3IXex3z25xZGsZT0M2I9Umjc1H/vBh+ni
	zF7FIWdut7wIds4tcCWT6xYzBzX1an69htiTt6gyW+88geEOsfUIL4+laQvZk65cSwdj+AOUCGxOW
	7juI3dT/4ZinZ4axfAG/ckXk+DgRiE34E3H2LH4yU/O/bZjfVlv3vrZRYm1hwNHQEuPr5QUl9+1+j
	WGPYu14QCDeWVPU91BWapo9x0sbEqjkWZ7YQ==;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rpotc-0000000DGai-47UX; Thu, 28 Mar 2024 15:30:17 +0300
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
Subject: [PATCH v3 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Thu, 28 Mar 2024 17:29:22 +0500
Message-ID: <20240328122922.13796-2-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240328122922.13796-1-hitechshell@mail.ru>
References: <20240328122922.13796-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D135BF24EC7C3B84F4481F7E27D197A17FCA344EEC41F37C182A05F5380850402791018B19CE2E96AC8EDD30083ED68EABD0551671300EA9A8B9B88E922B8A01AC22AB14350DA595
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70D53446EB66A9CE1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FD60A286D0BA57028638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88578A348B1D428924079A55C0CA41286A022C9AC1DDEBF9820879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F79006370BDD70ABAC747F53389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6925688D23FC3BD32D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3EF25F2216630B8E3BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF27ED053E960B195E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C321525EBB4FD3283235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5C1586EE7632EB09E5002B1117B3ED69604ECF14F73EC5F79886DC9BC01168B20823CB91A9FED034534781492E4B8EEAD577AE849BCD98940C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF81E79B5ADD3CD23D14395E4B0397D0A5DB3E1AFF42BE5049811E580751B9A3269E78A6DB75C3D486F212F37558E72466F36FB4147D20F1DCFBB8295D55DB7E6D8A0D2736BFC7705542BF32D1DA1046D202C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojc7pp9Ls8Ei4WbW6POvQdzA==
X-Mailru-Sender: E694439511B4C78E046AD7819AB2A90AAEA6D0C4BD035DAC7FC47A557B39A39B8D857EAE377BB555C3E3B4F1A6D70A55A84BA7EF1BC9F5022BA6FC9A786ED693E9ED072CBE033FA67EDB6CE9DEC428A48BCC081D9D5610F38C953235E64445F45E74CC5237D64E8BE0FA792AE8F3C4805FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CD3D6EB06D23122212049FFFDB7839CE9E088A9832E85284855DCD599F0008ABCF0659094D96DC6C4463CD8C6E8DD2E82B
X-7FA49CB5: 0D63561A33F958A5344BC1D64A651F68718AE15BE506B39F67808BC4A932C333CACD7DF95DA8FC8BD5E8D9A59859A8B6E8E8DEC9ADB2F68ECC7F00164DA146DAFE8445B8C89999728AA50765F7900637A3E1607A70BC73F0389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8B6617C399FBFD4B4F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE791607F508E813406731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojc7pp9Ls8Ei5669jvLqPwTQ==
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


