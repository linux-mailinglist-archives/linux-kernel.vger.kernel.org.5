Return-Path: <linux-kernel+bounces-120094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DFA88D179
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A29B259C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BA13E3E1;
	Tue, 26 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE2J5yTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742513E03F;
	Tue, 26 Mar 2024 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493065; cv=none; b=le+ArssWWn88zR9XncXltgDXxpOhECI7q5eAGyRxFX4mGcY/i6A4pdOPjpw55H42x3VNkoW+qKHAywXH+Sfz+PWfjd0mNr8dhLJ95A2GJMDVLs5sozO+MKhV0O3E/u1rtcWfvJxJ9gpVzPYClqS1UvsboEy3FTxIxW8A5Ihq40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493065; c=relaxed/simple;
	bh=RKPavX3hxaYKCj9tUK/416QH+KtTLt4VYZzYpioXnPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0F6E7Rwl9Yc7WLwH8xLTBTYeTbHQkdY2Db/463f9WIpoQQMICoZYbxv7eQIm5Wam3KwXbimeF3Dul88wvBFnjVLWCKaPEfnpvcCe4Fna0qdLLIDcVVMaoDFsopFNWuwlD0aYsAyDqfwBegzmgucM8PW3DtzsMxBCT/ypvm7xjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE2J5yTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D159C433B2;
	Tue, 26 Mar 2024 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711493065;
	bh=RKPavX3hxaYKCj9tUK/416QH+KtTLt4VYZzYpioXnPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oE2J5yTheAs9sJwt0SgUPSMcPoWqmMPRFjonat6WHdl+SQO2zW2CRlHY8JVYdQjS2
	 grHNsM2vS7IhB7Bhh+7PvsLDw5Ert/suuav0oUO4UFpiPRSbPnr6pK192eHOf2FYXx
	 2x2asZIIaZqESZ7ry8kFgs2plPf07A3/Rzn0OTan4dI88P0Yk5ulMdjSW6TC0Iv6R3
	 btoMh3hf/fky9jEQdw+5jXwHwv0I4o7/yrF1b27IaDE8Oe679MM8RmrBQZJnD+MgAF
	 53UcPSbIZDiCQnkZ+62Hsp75bPnHj3jQ+B/v18E8PTQHDHqbzknYPSxB0dgBRoTk2M
	 mFVX5TERllweA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 5.4.273
Date: Tue, 26 Mar 2024 18:44:20 -0400
Message-ID: <20240326224421.2650365-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326224421.2650365-1-sashal@kernel.org>
References: <20240326224421.2650365-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/media/kapi/v4l2-dev.rst b/Documentation/media/kapi/v4l2-dev.rst
index 4c5a15c53dbfb..63c064837c008 100644
--- a/Documentation/media/kapi/v4l2-dev.rst
+++ b/Documentation/media/kapi/v4l2-dev.rst
@@ -185,7 +185,7 @@ This will create the character device for you.
 
 .. code-block:: c
 
-	err = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (err) {
 		video_device_release(vdev); /* or kfree(my_vdev); */
 		return err;
@@ -201,7 +201,7 @@ types exist:
 ========================== ====================	 ==============================
 :c:type:`vfl_devnode_type` Device name		 Usage
 ========================== ====================	 ==============================
-``VFL_TYPE_GRABBER``       ``/dev/videoX``       for video input/output devices
+``VFL_TYPE_VIDEO``         ``/dev/videoX``       for video input/output devices
 ``VFL_TYPE_VBI``           ``/dev/vbiX``         for vertical blank data (i.e.
 						 closed captions, teletext)
 ``VFL_TYPE_RADIO``         ``/dev/radioX``       for radio tuners
diff --git a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
index 66c7c568bd866..9c39ee58ea507 100644
--- a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
+++ b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
@@ -649,7 +649,7 @@ video_device注册
 
 接下来你需要注册视频设备：这会为你创建一个字符设备。
 
-	err = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (err) {
 		video_device_release(vdev); /* or kfree(my_vdev); */
 		return err;
@@ -660,7 +660,7 @@ video_device注册
 
 注册哪种设备是根据类型（type）参数。存在以下类型：
 
-VFL_TYPE_GRABBER: 用于视频输入/输出设备的 videoX
+VFL_TYPE_VIDEO: 用于视频输入/输出设备的 videoX
 VFL_TYPE_VBI: 用于垂直消隐数据的 vbiX (例如，隐藏式字幕，图文电视)
 VFL_TYPE_RADIO: 用于广播调谐器的 radioX
 
diff --git a/Makefile b/Makefile
index 184b31e84b99c..bcf56ce1a7f8f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 272
+SUBLEVEL = 273
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 2625ce66f8e7e..673c6e5b2f565 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -435,7 +435,7 @@
 
 		/* Direct-mapped development chip ROM */
 		pb1176_rom@10200000 {
-			compatible = "direct-mapped";
+			compatible = "mtd-rom";
 			reg = <0x10200000 0x4000>;
 			bank-width = <1>;
 		};
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index ce4a5a8074422..68af441e78948 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -96,8 +96,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <20>;
 	phy-supply = <&sw2_reg>;
 	status = "okay";
 
@@ -110,17 +108,10 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy_port2: phy@1 {
-			reg = <1>;
-		};
-
-		phy_port3: phy@2 {
-			reg = <2>;
-		};
-
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
 				#address-cells = <1>;
@@ -141,15 +132,30 @@
 				port@2 {
 					reg = <2>;
 					label = "eth2";
+					phy-mode = "internal";
 					phy-handle = <&phy_port2>;
 				};
 
 				port@3 {
 					reg = <3>;
 					label = "eth1";
+					phy-mode = "internal";
 					phy-handle = <&phy_port3>;
 				};
 			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy_port2: ethernet-phy@1 {
+					reg = <1>;
+				};
+
+				phy_port3: ethernet-phy@2 {
+					reg = <2>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 4c6704e4c57ec..74d5732c412ba 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -62,6 +62,30 @@
 		states = <1100000 0>, <1300000 1>;
 	};
 
+	reg_vcc_dram: vcc-dram {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-dram";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		vin-supply = <&reg_vcc5v0>;
+	};
+
+	reg_vcc1v2: vcc1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		vin-supply = <&reg_vcc5v0>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index 215497f011f23..cb3be0c15a044 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -25,8 +25,8 @@
 
 #include "sha256_glue.h"
 
-asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
-					unsigned int num_blks);
+asmlinkage void sha256_block_data_order(struct sha256_state *state,
+					const u8 *data, int num_blks);
 
 int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
@@ -34,23 +34,20 @@ int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 	/* make sure casting to sha256_block_fn() is safe */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
-	return sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
+	return sha256_base_do_update(desc, data, len, sha256_block_data_order);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_update);
 
 static int crypto_sha256_arm_final(struct shash_desc *desc, u8 *out)
 {
-	sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_data_order);
+	sha256_base_do_finalize(desc, sha256_block_data_order);
 	return sha256_base_finish(desc, out);
 }
 
 int crypto_sha256_arm_finup(struct shash_desc *desc, const u8 *data,
 			    unsigned int len, u8 *out)
 {
-	sha256_base_do_update(desc, data, len,
-			      (sha256_block_fn *)sha256_block_data_order);
+	sha256_base_do_update(desc, data, len, sha256_block_data_order);
 	return crypto_sha256_arm_final(desc, out);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_finup);
diff --git a/arch/arm/crypto/sha512-glue.c b/arch/arm/crypto/sha512-glue.c
index 8775aa42bbbe8..1a16b98ec1085 100644
--- a/arch/arm/crypto/sha512-glue.c
+++ b/arch/arm/crypto/sha512-glue.c
@@ -25,27 +25,25 @@ MODULE_ALIAS_CRYPTO("sha512");
 MODULE_ALIAS_CRYPTO("sha384-arm");
 MODULE_ALIAS_CRYPTO("sha512-arm");
 
-asmlinkage void sha512_block_data_order(u64 *state, u8 const *src, int blocks);
+asmlinkage void sha512_block_data_order(struct sha512_state *state,
+					u8 const *src, int blocks);
 
 int sha512_arm_update(struct shash_desc *desc, const u8 *data,
 		      unsigned int len)
 {
-	return sha512_base_do_update(desc, data, len,
-		(sha512_block_fn *)sha512_block_data_order);
+	return sha512_base_do_update(desc, data, len, sha512_block_data_order);
 }
 
 static int sha512_arm_final(struct shash_desc *desc, u8 *out)
 {
-	sha512_base_do_finalize(desc,
-		(sha512_block_fn *)sha512_block_data_order);
+	sha512_base_do_finalize(desc, sha512_block_data_order);
 	return sha512_base_finish(desc, out);
 }
 
 int sha512_arm_finup(struct shash_desc *desc, const u8 *data,
 		     unsigned int len, u8 *out)
 {
-	sha512_base_do_update(desc, data, len,
-		(sha512_block_fn *)sha512_block_data_order);
+	sha512_base_do_update(desc, data, len, sha512_block_data_order);
 	return sha512_arm_final(desc, out);
 }
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 7b095378c96cd..eec9ec1db682a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -71,6 +71,7 @@
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index f586c1ee4a59e..ee57fccd489a3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -57,6 +57,7 @@
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index dba3488492f1b..21e029afb27bb 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -77,425 +77,427 @@
 			enable-gpios = <&pm8994_gpios 15 0>;
 		};
 	};
+};
 
-	soc {
-		serial@7570000 {
-			label = "BT-UART";
-			status = "okay";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp1_uart1_default>;
-			pinctrl-1 = <&blsp1_uart1_sleep>;
+&blsp1_uart1 {
+	label = "BT-UART";
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp1_uart1_default>;
+	pinctrl-1 = <&blsp1_uart1_sleep>;
 
-			bluetooth {
-				compatible = "qcom,qca6174-bt";
+	bluetooth {
+		compatible = "qcom,qca6174-bt";
 
-				/* bt_disable_n gpio */
-				enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+		/* bt_disable_n gpio */
+		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
 
-				clocks = <&divclk4>;
-			};
-		};
+		clocks = <&divclk4>;
+	};
+};
 
-		serial@75b0000 {
-			label = "LS-UART1";
-			status = "okay";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp2_uart1_2pins_default>;
-			pinctrl-1 = <&blsp2_uart1_2pins_sleep>;
-		};
+&blsp2_uart1 {
+	label = "LS-UART1";
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart1_2pins_default>;
+	pinctrl-1 = <&blsp2_uart1_2pins_sleep>;
+};
 
-		serial@75b1000 {
-			label = "LS-UART0";
-			status = "disabled";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp2_uart2_4pins_default>;
-			pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
-		};
+&blsp2_uart2 {
+	label = "LS-UART0";
+	status = "disabled";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart2_4pins_default>;
+	pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
+};
 
-		i2c@7577000 {
-		/* On Low speed expansion */
-			label = "LS-I2C0";
-			status = "okay";
-		};
+&blsp1_i2c2 {
+	/* On Low speed expansion */
+	label = "LS-I2C0";
+	status = "okay";
+};
 
-		i2c@75b6000 {
-		/* On Low speed expansion */
-			label = "LS-I2C1";
-			status = "okay";
-		};
+&blsp2_i2c1 {
+	/* On Low speed expansion */
+	label = "LS-I2C1";
+	status = "okay";
+};
 
-		spi@7575000 {
-		/* On Low speed expansion */
-			label = "LS-SPI0";
-			status = "okay";
-		};
+&blsp1_spi0 {
+	/* On Low speed expansion */
+	label = "LS-SPI0";
+	status = "okay";
+};
 
-		i2c@75b5000 {
-		/* On High speed expansion */
-			label = "HS-I2C2";
-			status = "okay";
-		};
+&blsp2_i2c0 {
+	/* On High speed expansion */
+	label = "HS-I2C2";
+	status = "okay";
+};
 
-		spi@75ba000{
-		/* On High speed expansion */
-			label = "HS-SPI1";
-			status = "okay";
-		};
+&blsp2_spi5 {
+	/* On High speed expansion */
+	label = "HS-SPI1";
+	status = "okay";
+};
 
-		sdhci@74a4900 {
-		/* External SD card */
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
-			cd-gpios = <&msmgpio 38 0x1>;
-			vmmc-supply = <&pm8994_l21>;
-			vqmmc-supply = <&pm8994_l13>;
-			status = "okay";
-		};
+&camss {
+	vdda-supply = <&pm8994_l2>;
+};
 
-		phy@627000 {
-			status = "okay";
-		};
+&sdhc2 {
+	/* External SD card */
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	cd-gpios = <&msmgpio 38 0x1>;
+	vmmc-supply = <&pm8994_l21>;
+	vqmmc-supply = <&pm8994_l13>;
+	status = "okay";
+};
 
-		ufshc@624000 {
-			status = "okay";
-		};
+&ufsphy {
+	status = "okay";
 
-		pinctrl@1010000 {
-			gpio-line-names =
-				"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
-				"[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
-				"[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
-				"[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
-				"[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
-				"[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
-				"[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
-				"[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
-				"GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
-				"TP93", /* GPIO_9 */
-				"GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
-				"[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
-				"NC", /* GPIO_12 */
-				"[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
-				"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
-				"[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
-				"TP99", /* GPIO_16 */
-				"[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
-				"[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
-				"[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
-				"[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
-				"FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
-				"FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
-				"GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
-				"GPIO-D", /* GPIO_24, LSEC pin 26 */
-				"GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
-				"GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
-				"BLSP6_I2C_SDA", /* GPIO_27 */
-				"BLSP6_I2C_SCL", /* GPIO_28 */
-				"GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
-				"GPIO30", /* GPIO_30, S HSEC pin 4 */
-				"HDMI_CEC", /* GPIO_31 */
-				"HDMI_DDC_CLOCK", /* GPIO_32 */
-				"HDMI_DDC_DATA", /* GPIO_33 */
-				"HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
-				"PCIE0_RST_N", /* GPIO_35 */
-				"PCIE0_CLKREQ_N", /* GPIO_36 */
-				"PCIE0_WAKE", /* GPIO_37 */
-				"SD_CARD_DET_N", /* GPIO_38 */
-				"TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
-				"W_DISABLE_N", /* GPIO_40 */
-				"[BLSP9_UART_TX]", /* GPIO_41 */
-				"[BLSP9_UART_RX]", /* GPIO_42 */
-				"[BLSP2_UART_CTS_N]", /* GPIO_43 */
-				"[BLSP2_UART_RFR_N]", /* GPIO_44 */
-				"[BLSP3_UART_TX]", /* GPIO_45 */
-				"[BLSP3_UART_RX]", /* GPIO_46 */
-				"[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
-				"[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
-				"[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
-				"[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
-				"[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
-				"[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
-				"[CODEC_INT1_N]", /* GPIO_53 */
-				"[CODEC_INT2_N]", /* GPIO_54 */
-				"[BLSP7_I2C_SDA]", /* GPIO_55 */
-				"[BLSP7_I2C_SCL]", /* GPIO_56 */
-				"MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
-				"[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
-				"[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
-				"[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
-				"[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
-				"GPIO-E", /* GPIO_62, LSEC pin 27 */
-				"TP87", /* GPIO_63 */
-				"[CODEC_RST_N]", /* GPIO_64 */
-				"[PCM1_CLK]", /* GPIO_65 */
-				"[PCM1_SYNC]", /* GPIO_66 */
-				"[PCM1_DIN]", /* GPIO_67 */
-				"[PCM1_DOUT]", /* GPIO_68 */
-				"AUDIO_REF_CLK", /* GPIO_69 */
-				"SLIMBUS_CLK", /* GPIO_70 */
-				"SLIMBUS_DATA0", /* GPIO_71 */
-				"SLIMBUS_DATA1", /* GPIO_72 */
-				"NC", /* GPIO_73 */
-				"NC", /* GPIO_74 */
-				"NC", /* GPIO_75 */
-				"NC", /* GPIO_76 */
-				"TP94", /* GPIO_77 */
-				"NC", /* GPIO_78 */
-				"TP95", /* GPIO_79 */
-				"GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
-				"TP88", /* GPIO_81 */
-				"TP89", /* GPIO_82 */
-				"TP90", /* GPIO_83 */
-				"TP91", /* GPIO_84 */
-				"[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
-				"[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
-				"[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
-				"[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
-				"TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
-				"TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
-				"TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
-				"NC", /* GPIO_92 */
-				"TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
-				"TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
-				"TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
-				"TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
-				"NC", /* GPIO_97 */
-				"CAM1_STANDBY_N", /* GPIO_98 */
-				"NC", /* GPIO_99 */
-				"NC", /* GPIO_100 */
-				"[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
-				"BOOT_CONFIG1", /* GPIO_102 */
-				"USB_HUB_RESET", /* GPIO_103 */
-				"CAM1_RST_N", /* GPIO_104 */
-				"NC", /* GPIO_105 */
-				"NC", /* GPIO_106 */
-				"NC", /* GPIO_107 */
-				"NC", /* GPIO_108 */
-				"NC", /* GPIO_109 */
-				"NC", /* GPIO_110 */
-				"NC", /* GPIO_111 */
-				"NC", /* GPIO_112 */
-				"PMI8994_BUA", /* GPIO_113 */
-				"PCIE2_RST_N", /* GPIO_114 */
-				"PCIE2_CLKREQ_N", /* GPIO_115 */
-				"PCIE2_WAKE", /* GPIO_116 */
-				"SSC_IRQ_0", /* GPIO_117 */
-				"SSC_IRQ_1", /* GPIO_118 */
-				"SSC_IRQ_2", /* GPIO_119 */
-				"NC", /* GPIO_120 */
-				"GPIO121", /* GPIO_121, S HSEC pin 2 */
-				"NC", /* GPIO_122 */
-				"SSC_IRQ_6", /* GPIO_123 */
-				"SSC_IRQ_7", /* GPIO_124 */
-				"GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
-				"BOOT_CONFIG5", /* GPIO_126 */
-				"NC", /* GPIO_127 */
-				"NC", /* GPIO_128 */
-				"BOOT_CONFIG7", /* GPIO_129 */
-				"PCIE1_RST_N", /* GPIO_130 */
-				"PCIE1_CLKREQ_N", /* GPIO_131 */
-				"PCIE1_WAKE", /* GPIO_132 */
-				"GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
-				"NC", /* GPIO_134 */
-				"NC", /* GPIO_135 */
-				"BOOT_CONFIG8", /* GPIO_136 */
-				"NC", /* GPIO_137 */
-				"NC", /* GPIO_138 */
-				"GPS_SSBI2", /* GPIO_139 */
-				"GPS_SSBI1", /* GPIO_140 */
-				"NC", /* GPIO_141 */
-				"NC", /* GPIO_142 */
-				"NC", /* GPIO_143 */
-				"BOOT_CONFIG6", /* GPIO_144 */
-				"NC", /* GPIO_145 */
-				"NC", /* GPIO_146 */
-				"NC", /* GPIO_147 */
-				"NC", /* GPIO_148 */
-				"NC"; /* GPIO_149 */
-		};
+	vdda-phy-supply = <&pm8994_l28>;
+	vdda-pll-supply = <&pm8994_l12>;
 
-		qcom,spmi@400f000 {
-			pmic@0 {
-				gpios@c000 {
-					gpio-line-names =
-						"NC",
-						"KEY_VOLP_N",
-						"NC",
-						"BL1_PWM",
-						"GPIO-F", /* BL0_PWM, LSEC pin 28 */
-						"BL1_EN",
-						"NC",
-						"WLAN_EN",
-						"NC",
-						"NC",
-						"NC",
-						"NC",
-						"NC",
-						"NC",
-						"DIVCLK1",
-						"DIVCLK2",
-						"DIVCLK3",
-						"DIVCLK4",
-						"BT_EN",
-						"PMIC_SLB",
-						"PMIC_BUA",
-						"USB_VBUS_DET";
-				};
-
-				mpps@a000 {
-					gpio-line-names =
-						"VDDPX_BIAS",
-						"WIFI_LED",
-						"NC",
-						"BT_LED",
-						"PM_MPP05",
-						"PM_MPP06",
-						"PM_MPP07",
-						"NC";
-				};
-			};
+	vdda-phy-max-microamp = <18380>;
+	vdda-pll-max-microamp = <9440>;
 
-			pmic@2 {
-				gpios@c000 {
-					gpio-line-names =
-						"NC",
-						"SPKR_AMP_EN1",
-						"SPKR_AMP_EN2",
-						"TP61",
-						"NC",
-						"USB2_VBUS_DET",
-						"NC",
-						"NC",
-						"NC",
-						"NC";
-				};
-			};
-		};
+	vddp-ref-clk-supply = <&pm8994_l25>;
+	vddp-ref-clk-max-microamp = <100>;
+	vddp-ref-clk-always-on;
+};
 
-		phy@34000 {
-			status = "okay";
-		};
+&ufshc {
+	status = "okay";
 
-		phy@7410000 {
-			status = "okay";
-		};
+	vcc-supply = <&pm8994_l20>;
+	vccq-supply = <&pm8994_l25>;
+	vccq2-supply = <&pm8994_s4>;
 
-		phy@7411000 {
-			status = "okay";
-		};
+	vcc-max-microamp = <600000>;
+	vccq-max-microamp = <450000>;
+	vccq2-max-microamp = <450000>;
+};
 
-		phy@7412000 {
-			status = "okay";
-		};
+&msmgpio {
+	gpio-line-names =
+		"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
+		"[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
+		"[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
+		"[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
+		"[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
+		"[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
+		"[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
+		"[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
+		"GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
+		"TP93", /* GPIO_9 */
+		"GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
+		"[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
+		"NC", /* GPIO_12 */
+		"[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
+		"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
+		"[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
+		"TP99", /* GPIO_16 */
+		"[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
+		"[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
+		"[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
+		"[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
+		"FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
+		"FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
+		"GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
+		"GPIO-D", /* GPIO_24, LSEC pin 26 */
+		"GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
+		"GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
+		"BLSP6_I2C_SDA", /* GPIO_27 */
+		"BLSP6_I2C_SCL", /* GPIO_28 */
+		"GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
+		"GPIO30", /* GPIO_30, S HSEC pin 4 */
+		"HDMI_CEC", /* GPIO_31 */
+		"HDMI_DDC_CLOCK", /* GPIO_32 */
+		"HDMI_DDC_DATA", /* GPIO_33 */
+		"HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
+		"PCIE0_RST_N", /* GPIO_35 */
+		"PCIE0_CLKREQ_N", /* GPIO_36 */
+		"PCIE0_WAKE", /* GPIO_37 */
+		"SD_CARD_DET_N", /* GPIO_38 */
+		"TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
+		"W_DISABLE_N", /* GPIO_40 */
+		"[BLSP9_UART_TX]", /* GPIO_41 */
+		"[BLSP9_UART_RX]", /* GPIO_42 */
+		"[BLSP2_UART_CTS_N]", /* GPIO_43 */
+		"[BLSP2_UART_RFR_N]", /* GPIO_44 */
+		"[BLSP3_UART_TX]", /* GPIO_45 */
+		"[BLSP3_UART_RX]", /* GPIO_46 */
+		"[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
+		"[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
+		"[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
+		"[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
+		"[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
+		"[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
+		"[CODEC_INT1_N]", /* GPIO_53 */
+		"[CODEC_INT2_N]", /* GPIO_54 */
+		"[BLSP7_I2C_SDA]", /* GPIO_55 */
+		"[BLSP7_I2C_SCL]", /* GPIO_56 */
+		"MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
+		"[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
+		"[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
+		"[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
+		"[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
+		"GPIO-E", /* GPIO_62, LSEC pin 27 */
+		"TP87", /* GPIO_63 */
+		"[CODEC_RST_N]", /* GPIO_64 */
+		"[PCM1_CLK]", /* GPIO_65 */
+		"[PCM1_SYNC]", /* GPIO_66 */
+		"[PCM1_DIN]", /* GPIO_67 */
+		"[PCM1_DOUT]", /* GPIO_68 */
+		"AUDIO_REF_CLK", /* GPIO_69 */
+		"SLIMBUS_CLK", /* GPIO_70 */
+		"SLIMBUS_DATA0", /* GPIO_71 */
+		"SLIMBUS_DATA1", /* GPIO_72 */
+		"NC", /* GPIO_73 */
+		"NC", /* GPIO_74 */
+		"NC", /* GPIO_75 */
+		"NC", /* GPIO_76 */
+		"TP94", /* GPIO_77 */
+		"NC", /* GPIO_78 */
+		"TP95", /* GPIO_79 */
+		"GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
+		"TP88", /* GPIO_81 */
+		"TP89", /* GPIO_82 */
+		"TP90", /* GPIO_83 */
+		"TP91", /* GPIO_84 */
+		"[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
+		"[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
+		"[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
+		"[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
+		"TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
+		"TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
+		"TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
+		"NC", /* GPIO_92 */
+		"TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
+		"TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
+		"TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
+		"TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
+		"NC", /* GPIO_97 */
+		"CAM1_STANDBY_N", /* GPIO_98 */
+		"NC", /* GPIO_99 */
+		"NC", /* GPIO_100 */
+		"[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
+		"BOOT_CONFIG1", /* GPIO_102 */
+		"USB_HUB_RESET", /* GPIO_103 */
+		"CAM1_RST_N", /* GPIO_104 */
+		"NC", /* GPIO_105 */
+		"NC", /* GPIO_106 */
+		"NC", /* GPIO_107 */
+		"NC", /* GPIO_108 */
+		"NC", /* GPIO_109 */
+		"NC", /* GPIO_110 */
+		"NC", /* GPIO_111 */
+		"NC", /* GPIO_112 */
+		"PMI8994_BUA", /* GPIO_113 */
+		"PCIE2_RST_N", /* GPIO_114 */
+		"PCIE2_CLKREQ_N", /* GPIO_115 */
+		"PCIE2_WAKE", /* GPIO_116 */
+		"SSC_IRQ_0", /* GPIO_117 */
+		"SSC_IRQ_1", /* GPIO_118 */
+		"SSC_IRQ_2", /* GPIO_119 */
+		"NC", /* GPIO_120 */
+		"GPIO121", /* GPIO_121, S HSEC pin 2 */
+		"NC", /* GPIO_122 */
+		"SSC_IRQ_6", /* GPIO_123 */
+		"SSC_IRQ_7", /* GPIO_124 */
+		"GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
+		"BOOT_CONFIG5", /* GPIO_126 */
+		"NC", /* GPIO_127 */
+		"NC", /* GPIO_128 */
+		"BOOT_CONFIG7", /* GPIO_129 */
+		"PCIE1_RST_N", /* GPIO_130 */
+		"PCIE1_CLKREQ_N", /* GPIO_131 */
+		"PCIE1_WAKE", /* GPIO_132 */
+		"GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
+		"NC", /* GPIO_134 */
+		"NC", /* GPIO_135 */
+		"BOOT_CONFIG8", /* GPIO_136 */
+		"NC", /* GPIO_137 */
+		"NC", /* GPIO_138 */
+		"GPS_SSBI2", /* GPIO_139 */
+		"GPS_SSBI1", /* GPIO_140 */
+		"NC", /* GPIO_141 */
+		"NC", /* GPIO_142 */
+		"NC", /* GPIO_143 */
+		"BOOT_CONFIG6", /* GPIO_144 */
+		"NC", /* GPIO_145 */
+		"NC", /* GPIO_146 */
+		"NC", /* GPIO_147 */
+		"NC", /* GPIO_148 */
+		"NC"; /* GPIO_149 */
+};
 
-		usb@6af8800 {
-			status = "okay";
-			extcon = <&usb3_id>;
+&pm8994_gpios {
+	gpio-line-names =
+		"NC",
+		"KEY_VOLP_N",
+		"NC",
+		"BL1_PWM",
+		"GPIO-F", /* BL0_PWM, LSEC pin 28 */
+		"BL1_EN",
+		"NC",
+		"WLAN_EN",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"DIVCLK1",
+		"DIVCLK2",
+		"DIVCLK3",
+		"DIVCLK4",
+		"BT_EN",
+		"PMIC_SLB",
+		"PMIC_BUA",
+		"USB_VBUS_DET";
+};
 
-			dwc3@6a00000 {
-				extcon = <&usb3_id>;
-				dr_mode = "otg";
-			};
-		};
+&pm8994_mpps {
+	gpio-line-names =
+		"VDDPX_BIAS",
+		"WIFI_LED",
+		"NC",
+		"BT_LED",
+		"PM_MPP05",
+		"PM_MPP06",
+		"PM_MPP07",
+		"NC";
+};
 
-		usb3_id: usb3-id {
-			compatible = "linux,extcon-usb-gpio";
-			id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb3_vbus_det_gpio>;
-		};
+&pmi8994_gpios {
+	gpio-line-names =
+		"NC",
+		"SPKR_AMP_EN1",
+		"SPKR_AMP_EN2",
+		"TP61",
+		"NC",
+		"USB2_VBUS_DET",
+		"NC",
+		"NC",
+		"NC",
+		"NC";
+};
 
-		usb@76f8800 {
-			status = "okay";
-			extcon = <&usb2_id>;
+&pcie_phy {
+	status = "okay";
 
-			dwc3@7600000 {
-				extcon = <&usb2_id>;
-				dr_mode = "otg";
-				maximum-speed = "high-speed";
-			};
-		};
+	vdda-phy-supply = <&pm8994_l28>;
+	vdda-pll-supply = <&pm8994_l12>;
+};
 
-		usb2_id: usb2-id {
-			compatible = "linux,extcon-usb-gpio";
-			id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb2_vbus_det_gpio>;
-		};
+&usb3phy {
+	status = "okay";
 
-		wlan_en: wlan-en-1-8v {
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_en_gpios>;
-			compatible = "regulator-fixed";
-			regulator-name = "wlan-en-regulator";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
+	vdda-phy-supply = <&pm8994_l28>;
+	vdda-pll-supply = <&pm8994_l12>;
 
-			gpio = <&pm8994_gpios 8 0>;
+};
 
-			/* WLAN card specific delay */
-			startup-delay-us = <70000>;
-			enable-active-high;
-		};
+&hsusb_phy1 {
+	status = "okay";
 
-		agnoc@0 {
-			pcie@600000 {
-				status = "okay";
-				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
-				vddpe-3v3-supply = <&wlan_en>;
-			};
+	vdda-pll-supply = <&pm8994_l12>;
+	vdda-phy-dpdm-supply = <&pm8994_l24>;
+};
 
-			pcie@608000 {
-				status = "okay";
-				perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
-			};
+&hsusb_phy2 {
+	status = "okay";
 
-			pcie@610000 {
-				status = "okay";
-				perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
-			};
-		};
+	vdda-pll-supply = <&pm8994_l12>;
+	vdda-phy-dpdm-supply = <&pm8994_l24>;
+};
 
-		slim_msm: slim@91c0000 {
-			ngd@1 {
-				wcd9335: codec@1{
-					clock-names = "mclk", "slimbus";
-					clocks = <&div1_mclk>,
-						 <&rpmcc RPM_SMD_BB_CLK1>;
-				};
-			};
-		};
+&usb3 {
+	status = "okay";
+	extcon = <&usb3_id>;
 
-		mdss@900000 {
-			status = "okay";
+	dwc3@6a00000 {
+		extcon = <&usb3_id>;
+		dr_mode = "otg";
+	};
+};
 
-			mdp@901000 {
-				status = "okay";
-			};
+&usb2 {
+	status = "okay";
+	extcon = <&usb2_id>;
 
-			hdmi-phy@9a0600 {
-				status = "okay";
+	dwc3@7600000 {
+		extcon = <&usb2_id>;
+		dr_mode = "otg";
+		maximum-speed = "high-speed";
+	};
+};
 
-				vddio-supply = <&pm8994_l12>;
-				vcca-supply = <&pm8994_l28>;
-				#phy-cells = <0>;
-			};
+&pcie0 {
+	status = "okay";
+	perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+	vddpe-3v3-supply = <&wlan_en>;
+	vdda-supply = <&pm8994_l28>;
+};
 
-			hdmi-tx@9a0000 {
-				status = "okay";
+&pcie1 {
+	status = "okay";
+	perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&pm8994_l28>;
+};
 
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
-				pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
+&pcie2 {
+	status = "okay";
+	perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&pm8994_l28>;
+};
 
-				core-vdda-supply = <&pm8994_l12>;
-				core-vcc-supply = <&pm8994_s4>;
-			};
-		};
-	};
+&wcd9335 {
+	clock-names = "mclk", "slimbus";
+	clocks = <&div1_mclk>,
+		 <&rpmcc RPM_SMD_BB_CLK1>;
 
+	vdd-buck-supply = <&pm8994_s4>;
+	vdd-buck-sido-supply = <&pm8994_s4>;
+	vdd-tx-supply = <&pm8994_s4>;
+	vdd-rx-supply = <&pm8994_s4>;
+	vdd-io-supply = <&pm8994_s4>;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdp {
+	status = "okay";
+};
+
+&hdmi_phy {
+	status = "okay";
+
+	vddio-supply = <&pm8994_l12>;
+	vcca-supply = <&pm8994_l28>;
+	#phy-cells = <0>;
+};
+
+&hdmi {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
+	pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
+
+	core-vdda-supply = <&pm8994_l12>;
+	core-vcc-supply = <&pm8994_s4>;
+};
 
+/ {
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -667,6 +669,35 @@
 			};
 		};
 	};
+
+	usb2_id: usb2-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_vbus_det_gpio>;
+	};
+
+	usb3_id: usb3-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_vbus_det_gpio>;
+	};
+
+	wlan_en: wlan-en-1-8v {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en_gpios>;
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&pm8994_gpios 8 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &spmi_bus {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index fb9556f57f55b..8bfb897b0e81b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -584,7 +584,7 @@
 
 		rpm_msg_ram: memory@68000 {
 			compatible = "qcom,rpm-msg-ram";
-			reg = <0x68000 0x6000>;
+			reg = <0x00068000 0x6000>;
 		};
 
 		rng: rng@83000 {
@@ -596,28 +596,28 @@
 
 		tcsr_mutex_regs: syscon@740000 {
 			compatible = "syscon";
-			reg = <0x740000 0x20000>;
+			reg = <0x00740000 0x20000>;
 		};
 
 		tsens0: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4a9000 0x1000>, /* TM */
-			      <0x4a8000 0x1000>; /* SROT */
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
 			#thermal-sensor-cells = <1>;
 		};
 
 		tsens1: thermal-sensor@4ad000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4ad000 0x1000>, /* TM */
-			      <0x4ac000 0x1000>; /* SROT */
+			reg = <0x004ad000 0x1000>, /* TM */
+			      <0x004ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
 
 		tcsr: syscon@7a0000 {
 			compatible = "qcom,tcsr-msm8996", "syscon";
-			reg = <0x7a0000 0x18000>;
+			reg = <0x007a0000 0x18000>;
 		};
 
 		intc: interrupt-controller@9bc0000 {
@@ -633,7 +633,7 @@
 
 		apcs_glb: mailbox@9820000 {
 			compatible = "qcom,msm8996-apcs-hmss-global";
-			reg = <0x9820000 0x1000>;
+			reg = <0x09820000 0x1000>;
 
 			#mbox-cells = <1>;
 		};
@@ -643,7 +643,7 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			reg = <0x300000 0x90000>;
+			reg = <0x00300000 0x90000>;
 		};
 
 		stm@3002000 {
@@ -1124,7 +1124,7 @@
 
 		kryocc: clock-controller@6400000 {
 			compatible = "qcom,apcc-msm8996";
-			reg = <0x6400000 0x90000>;
+			reg = <0x06400000 0x90000>;
 			#clock-cells = <1>;
 		};
 
@@ -1170,7 +1170,7 @@
 
 		blsp2_uart1: serial@75b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x75b0000 0x1000>;
+			reg = <0x075b0000 0x1000>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
@@ -1236,7 +1236,7 @@
 		sdhc2: sdhci@74a4900 {
 			 status = "disabled";
 			 compatible = "qcom,sdhci-msm-v4";
-			 reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
+			 reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
 			 reg-names = "hc_mem", "core_mem";
 
 			 interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>,
@@ -1321,11 +1321,11 @@
 
 		spmi_bus: qcom,spmi@400f000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x400f000 0x1000>,
-			      <0x4400000 0x800000>,
-			      <0x4c00000 0x800000>,
-			      <0x5800000 0x200000>,
-			      <0x400a000 0x002100>;
+			reg = <0x0400f000 0x1000>,
+			      <0x04400000 0x800000>,
+			      <0x04c00000 0x800000>,
+			      <0x05800000 0x200000>,
+			      <0x0400a000 0x002100>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
@@ -1339,20 +1339,10 @@
 
 		ufsphy: phy@627000 {
 			compatible = "qcom,msm8996-ufs-phy-qmp-14nm";
-			reg = <0x627000 0xda8>;
+			reg = <0x00627000 0xda8>;
 			reg-names = "phy_mem";
 			#phy-cells = <0>;
 
-			vdda-phy-supply = <&pm8994_l28>;
-			vdda-pll-supply = <&pm8994_l12>;
-
-			vdda-phy-max-microamp = <18380>;
-			vdda-pll-max-microamp = <9440>;
-
-			vddp-ref-clk-supply = <&pm8994_l25>;
-			vddp-ref-clk-max-microamp = <100>;
-			vddp-ref-clk-always-on;
-
 			clock-names = "ref_clk_src", "ref_clk";
 			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
 				 <&gcc GCC_UFS_CLKREF_CLK>;
@@ -1362,20 +1352,12 @@
 
 		ufshc: ufshc@624000 {
 			compatible = "qcom,ufshc";
-			reg = <0x624000 0x2500>;
+			reg = <0x00624000 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 
 			phys = <&ufsphy>;
 			phy-names = "ufsphy";
 
-			vcc-supply = <&pm8994_l20>;
-			vccq-supply = <&pm8994_l25>;
-			vccq2-supply = <&pm8994_s4>;
-
-			vcc-max-microamp = <600000>;
-			vccq-max-microamp = <450000>;
-			vccq2-max-microamp = <450000>;
-
 			power-domains = <&gcc UFS_GDSC>;
 
 			clock-names =
@@ -1429,7 +1411,7 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			reg = <0x8c0000 0x40000>;
+			reg = <0x008c0000 0x40000>;
 			assigned-clocks = <&mmcc MMPLL9_PLL>,
 					  <&mmcc MMPLL1_PLL>,
 					  <&mmcc MMPLL3_PLL>,
@@ -1444,7 +1426,7 @@
 
 		qfprom@74000 {
 			compatible = "qcom,qfprom";
-			reg = <0x74000 0x8ff>;
+			reg = <0x00074000 0x8ff>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
@@ -1464,9 +1446,9 @@
 			};
 		};
 
-		phy@34000 {
+		pcie_phy: phy@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
-			reg = <0x34000 0x488>;
+			reg = <0x00034000 0x488>;
 			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1477,9 +1459,6 @@
 				<&gcc GCC_PCIE_CLKREF_CLK>;
 			clock-names = "aux", "cfg_ahb", "ref";
 
-			vdda-phy-supply = <&pm8994_l28>;
-			vdda-pll-supply = <&pm8994_l12>;
-
 			resets = <&gcc GCC_PCIE_PHY_BCR>,
 				<&gcc GCC_PCIE_PHY_COM_BCR>,
 				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
@@ -1487,9 +1466,9 @@
 			status = "disabled";
 
 			pciephy_0: lane@35000 {
-				reg = <0x035000 0x130>,
-					<0x035200 0x200>,
-					<0x035400 0x1dc>;
+				reg = <0x00035000 0x130>,
+				      <0x00035200 0x200>,
+				      <0x00035400 0x1dc>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_0_pipe_clk_src";
@@ -1500,9 +1479,9 @@
 			};
 
 			pciephy_1: lane@36000 {
-				reg = <0x036000 0x130>,
-					<0x036200 0x200>,
-					<0x036400 0x1dc>;
+				reg = <0x00036000 0x130>,
+				      <0x00036200 0x200>,
+				      <0x00036400 0x1dc>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_1_pipe_clk_src";
@@ -1513,9 +1492,9 @@
 			};
 
 			pciephy_2: lane@37000 {
-				reg = <0x037000 0x130>,
-					<0x037200 0x200>,
-					<0x037400 0x1dc>;
+				reg = <0x00037000 0x130>,
+				      <0x00037200 0x200>,
+				      <0x00037400 0x1dc>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_2_pipe_clk_src";
@@ -1526,9 +1505,9 @@
 			};
 		};
 
-		phy@7410000 {
+		usb3phy: phy@7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
-			reg = <0x7410000 0x1c4>;
+			reg = <0x07410000 0x1c4>;
 			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1539,18 +1518,15 @@
 				<&gcc GCC_USB3_CLKREF_CLK>;
 			clock-names = "aux", "cfg_ahb", "ref";
 
-			vdda-phy-supply = <&pm8994_l28>;
-			vdda-pll-supply = <&pm8994_l12>;
-
 			resets = <&gcc GCC_USB3_PHY_BCR>,
 				<&gcc GCC_USB3PHY_PHY_BCR>;
 			reset-names = "phy", "common";
 			status = "disabled";
 
 			ssusb_phy_0: lane@7410200 {
-				reg = <0x7410200 0x200>,
-					<0x7410400 0x130>,
-					<0x7410600 0x1a8>;
+				reg = <0x07410200 0x200>,
+				      <0x07410400 0x130>,
+				      <0x07410600 0x1a8>;
 				#phy-cells = <0>;
 
 				clock-output-names = "usb3_phy_pipe_clk_src";
@@ -1561,16 +1537,13 @@
 
 		hsusb_phy1: phy@7411000 {
 			compatible = "qcom,msm8996-qusb2-phy";
-			reg = <0x7411000 0x180>;
+			reg = <0x07411000 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
 				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
 			clock-names = "cfg_ahb", "ref";
 
-			vdda-pll-supply = <&pm8994_l12>;
-			vdda-phy-dpdm-supply = <&pm8994_l24>;
-
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 			nvmem-cells = <&qusb2p_hstx_trim>;
 			status = "disabled";
@@ -1578,16 +1551,13 @@
 
 		hsusb_phy2: phy@7412000 {
 			compatible = "qcom,msm8996-qusb2-phy";
-			reg = <0x7412000 0x180>;
+			reg = <0x07412000 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
 				<&gcc GCC_RX2_USB2_CLKREF_CLK>;
 			clock-names = "cfg_ahb", "ref";
 
-			vdda-pll-supply = <&pm8994_l12>;
-			vdda-phy-dpdm-supply = <&pm8994_l24>;
-
 			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
 			nvmem-cells = <&qusb2s_hstx_trim>;
 			status = "disabled";
@@ -1595,7 +1565,7 @@
 
 		usb2: usb@76f8800 {
 			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
-			reg = <0x76f8800 0x400>;
+			reg = <0x076f8800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1615,7 +1585,7 @@
 
 			dwc3@7600000 {
 				compatible = "snps,dwc3";
-				reg = <0x7600000 0xcc00>;
+				reg = <0x07600000 0xcc00>;
 				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy2>;
 				phy-names = "usb2-phy";
@@ -1626,7 +1596,7 @@
 
 		usb3: usb@6af8800 {
 			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
-			reg = <0x6af8800 0x400>;
+			reg = <0x06af8800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1647,7 +1617,7 @@
 
 			dwc3@6a00000 {
 				compatible = "snps,dwc3";
-				reg = <0x6a00000 0xcc00>;
+				reg = <0x06a00000 0xcc00>;
 				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
@@ -1658,7 +1628,7 @@
 
 		vfe_smmu: iommu@da0000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0xda0000 0x10000>;
+			reg = <0x00da0000 0x10000>;
 
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
@@ -1674,20 +1644,20 @@
 
 		camss: camss@a00000 {
 			compatible = "qcom,msm8996-camss";
-			reg = <0xa34000 0x1000>,
-				<0xa00030 0x4>,
-				<0xa35000 0x1000>,
-				<0xa00038 0x4>,
-				<0xa36000 0x1000>,
-				<0xa00040 0x4>,
-				<0xa30000 0x100>,
-				<0xa30400 0x100>,
-				<0xa30800 0x100>,
-				<0xa30c00 0x100>,
-				<0xa31000 0x500>,
-				<0xa00020 0x10>,
-				<0xa10000 0x1000>,
-				<0xa14000 0x1000>;
+			reg = <0x00a34000 0x1000>,
+			      <0x00a00030 0x4>,
+			      <0x00a35000 0x1000>,
+			      <0x00a00038 0x4>,
+			      <0x00a36000 0x1000>,
+			      <0x00a00040 0x4>,
+			      <0x00a30000 0x100>,
+			      <0x00a30400 0x100>,
+			      <0x00a30800 0x100>,
+			      <0x00a30c00 0x100>,
+			      <0x00a31000 0x500>,
+			      <0x00a00020 0x10>,
+			      <0x00a10000 0x1000>,
+			      <0x00a14000 0x1000>;
 			reg-names = "csiphy0",
 				"csiphy0_clk_mux",
 				"csiphy1",
@@ -1795,7 +1765,6 @@
 				"vfe1_stream",
 				"vfe_ahb",
 				"vfe_axi";
-			vdda-supply = <&pm8994_l2>;
 			iommus = <&vfe_smmu 0>,
 				 <&vfe_smmu 1>,
 				 <&vfe_smmu 2>,
@@ -1809,7 +1778,7 @@
 
 		adreno_smmu: iommu@b40000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0xb40000 0x10000>;
+			reg = <0x00b40000 0x10000>;
 
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
@@ -1826,7 +1795,7 @@
 
 		mdp_smmu: iommu@d00000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0xd00000 0x10000>;
+			reg = <0x00d00000 0x10000>;
 
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
@@ -1842,7 +1811,7 @@
 
 		lpass_q6_smmu: iommu@1600000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0x1600000 0x20000>;
+			reg = <0x01600000 0x20000>;
 			#iommu-cells = <1>;
 			power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
 
@@ -1907,9 +1876,6 @@
 				pinctrl-0 = <&pcie0_clkreq_default &pcie0_perst_default &pcie0_wake_default>;
 				pinctrl-1 = <&pcie0_clkreq_sleep &pcie0_perst_default &pcie0_wake_sleep>;
 
-
-				vdda-supply = <&pm8994_l28>;
-
 				linux,pci-domain = <0>;
 
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
@@ -1962,8 +1928,6 @@
 				pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
 				pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
 
-
-				vdda-supply = <&pm8994_l28>;
 				linux,pci-domain = <1>;
 
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
@@ -2015,8 +1979,6 @@
 				pinctrl-0 = <&pcie2_clkreq_default &pcie2_perst_default &pcie2_wake_default>;
 				pinctrl-1 = <&pcie2_clkreq_sleep &pcie2_perst_default &pcie2_wake_sleep >;
 
-				vdda-supply = <&pm8994_l28>;
-
 				linux,pci-domain = <2>;
 				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>,
 					<&gcc GCC_PCIE_2_AUX_CLK>,
@@ -2036,7 +1998,7 @@
 		{
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
-			reg = <0x9184000 0x32000>;
+			reg = <0x09184000 0x32000>;
 			num-channels  = <31>;
 			interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
@@ -2046,7 +2008,7 @@
 
 		slim_msm: slim@91c0000 {
 			compatible = "qcom,slim-ngd-v1.5.0";
-			reg = <0x91c0000 0x2C000>;
+			reg = <0x091c0000 0x2C000>;
 			reg-names = "ctrl";
 			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
 			dmas =	<&slimbam 3>, <&slimbam 4>,
@@ -2081,12 +2043,6 @@
 
 					slim-ifc-dev  = <&tasha_ifd>;
 
-					vdd-buck-supply = <&pm8994_s4>;
-					vdd-buck-sido-supply = <&pm8994_s4>;
-					vdd-tx-supply = <&pm8994_s4>;
-					vdd-rx-supply = <&pm8994_s4>;
-					vdd-io-supply = <&pm8994_s4>;
-
 					#sound-dai-cells = <1>;
 				};
 			};
@@ -2096,7 +2052,7 @@
 			compatible = "qcom,adreno-530.2", "qcom,adreno";
 			#stream-id-cells = <16>;
 
-			reg = <0xb00000 0x3f000>;
+			reg = <0x00b00000 0x3f000>;
 			reg-names = "kgsl_3d0_reg_memory";
 
 			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
@@ -2167,9 +2123,9 @@
 		mdss: mdss@900000 {
 			compatible = "qcom,mdss";
 
-			reg = <0x900000 0x1000>,
-			      <0x9b0000 0x1040>,
-			      <0x9b8000 0x1040>;
+			reg = <0x00900000 0x1000>,
+			      <0x009b0000 0x1040>,
+			      <0x009b8000 0x1040>;
 			reg-names = "mdss_phys",
 				    "vbif_phys",
 				    "vbif_nrt_phys";
@@ -2189,7 +2145,7 @@
 
 			mdp: mdp@901000 {
 				compatible = "qcom,mdp5";
-				reg = <0x901000 0x90000>;
+				reg = <0x00901000 0x90000>;
 				reg-names = "mdp_phys";
 
 				interrupt-parent = <&mdss>;
@@ -2265,12 +2221,12 @@
 			hdmi_phy: hdmi-phy@9a0600 {
 				#phy-cells = <0>;
 				compatible = "qcom,hdmi-phy-8996";
-				reg = <0x9a0600 0x1c4>,
-				      <0x9a0a00 0x124>,
-				      <0x9a0c00 0x124>,
-				      <0x9a0e00 0x124>,
-				      <0x9a1000 0x124>,
-				      <0x9a1200 0x0c8>;
+				reg = <0x009a0600 0x1c4>,
+				      <0x009a0a00 0x124>,
+				      <0x009a0c00 0x124>,
+				      <0x009a0e00 0x124>,
+				      <0x009a1000 0x124>,
+				      <0x009a1200 0x0c8>;
 				reg-names = "hdmi_pll",
 					    "hdmi_tx_l0",
 					    "hdmi_tx_l1",
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 1e76774b36ddf..2849a9b65a055 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -60,6 +60,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
 	regs->cp0_epc = val;
+	regs->cp0_cause &= ~CAUSEF_BD;
 }
 
 /* Query offset/name of register from its name/offset */
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index b836fc61a24f4..f3a5c5e480cf0 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -80,7 +80,7 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	return 0;
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index ac3f3df57fe39..e85f1962be024 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -153,6 +153,20 @@ static unsigned long single_gpci_request(u32 req, u32 starting_index,
 
 	ret = plpar_hcall_norets(H_GET_PERF_COUNTER_INFO,
 			virt_to_phys(arg), HGPCI_REQ_BUFFER_SIZE);
+
+	/*
+	 * ret value as 'H_PARAMETER' with detail_rc as 'GEN_BUF_TOO_SMALL',
+	 * specifies that the current buffer size cannot accommodate
+	 * all the information and a partial buffer returned.
+	 * Since in this function we are only accessing data for a given starting index,
+	 * we don't need to accommodate whole data and can get required count by
+	 * accessing first entry data.
+	 * Hence hcall fails only incase the ret value is other than H_SUCCESS or
+	 * H_PARAMETER with detail_rc value as GEN_BUF_TOO_SMALL(0x1B).
+	 */
+	if (ret == H_PARAMETER && be32_to_cpu(arg->params.detail_rc) == 0x1B)
+		ret = 0;
+
 	if (ret) {
 		pr_devel("hcall failed: 0x%lx\n", ret);
 		goto out;
@@ -217,6 +231,7 @@ static int h_gpci_event_init(struct perf_event *event)
 {
 	u64 count;
 	u8 length;
+	unsigned long ret;
 
 	/* Not our event */
 	if (event->attr.type != event->pmu->type)
@@ -247,13 +262,23 @@ static int h_gpci_event_init(struct perf_event *event)
 	}
 
 	/* check if the request works... */
-	if (single_gpci_request(event_get_request(event),
+	ret = single_gpci_request(event_get_request(event),
 				event_get_starting_index(event),
 				event_get_secondary_index(event),
 				event_get_counter_info_version(event),
 				event_get_offset(event),
 				length,
-				&count)) {
+				&count);
+
+	/*
+	 * ret value as H_AUTHORITY implies that partition is not permitted to retrieve
+	 * performance information, and required to set
+	 * "Enable Performance Information Collection" option.
+	 */
+	if (ret == H_AUTHORITY)
+		return -EPERM;
+
+	if (ret) {
 		pr_devel("gpci hcall failed\n");
 		return -EINVAL;
 	}
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index f514d5d28cd4f..3f3821eb4c36b 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -97,9 +97,6 @@ static void __init linkstation_init_IRQ(void)
 	mpic_init(mpic);
 }
 
-extern void avr_uart_configure(void);
-extern void avr_uart_send(const char);
-
 static void __noreturn linkstation_restart(char *cmd)
 {
 	local_irq_disable();
diff --git a/arch/powerpc/platforms/embedded6xx/mpc10x.h b/arch/powerpc/platforms/embedded6xx/mpc10x.h
index 5ad12023e5628..ebc258fa4858d 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc10x.h
+++ b/arch/powerpc/platforms/embedded6xx/mpc10x.h
@@ -156,4 +156,7 @@ int mpc10x_disable_store_gathering(struct pci_controller *hose);
 /* For MPC107 boards that use the built-in openpic */
 void mpc10x_set_openpic(void);
 
+void avr_uart_configure(void);
+void avr_uart_send(const char c);
+
 #endif	/* __PPC_KERNEL_MPC10X_H */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 6e60cc2443b2e..2c99de1cc92cb 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -214,13 +214,13 @@ void vtime_flush(struct task_struct *tsk)
 		virt_timer_expire();
 
 	steal = S390_lowcore.steal_timer;
-	avg_steal = S390_lowcore.avg_steal_timer / 2;
+	avg_steal = S390_lowcore.avg_steal_timer;
 	if ((s64) steal > 0) {
 		S390_lowcore.steal_timer = 0;
 		account_steal_time(cputime_to_nsecs(steal));
 		avg_steal += steal;
 	}
-	S390_lowcore.avg_steal_timer = avg_steal;
+	S390_lowcore.avg_steal_timer = avg_steal / 2;
 }
 
 /*
diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index e6935d0ac1ec9..c32590bdd3120 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -696,7 +696,7 @@ static int grpci1_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci1_of_match[] __initconst = {
+static const struct of_device_id grpci1_of_match[] = {
 	{
 	 .name = "GAISLER_PCIFBRG",
 	 },
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index ca22f93d90454..dd06abc61657f 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -887,7 +887,7 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci2_of_match[] __initconst = {
+static const struct of_device_id grpci2_of_match[] = {
 	{
 	 .name = "GAISLER_GRPCI2",
 	 },
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 1c3a1962cade6..0043fd374a62f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -596,6 +596,14 @@ static void print_absolute_relocs(void)
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+		/*
+		 * Do not perform relocations in .notes section; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+			continue;
+		}
 		sh_symtab  = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index a1cc855c539c1..a76ba342a6695 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -65,6 +65,8 @@ int xen_smp_intr_init(unsigned int cpu)
 	char *resched_name, *callfunc_name, *debug_name;
 
 	resched_name = kasprintf(GFP_KERNEL, "resched%d", cpu);
+	if (!resched_name)
+		goto fail_mem;
 	per_cpu(xen_resched_irq, cpu).name = resched_name;
 	rc = bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
 				    cpu,
@@ -77,6 +79,8 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_resched_irq, cpu).irq = rc;
 
 	callfunc_name = kasprintf(GFP_KERNEL, "callfunc%d", cpu);
+	if (!callfunc_name)
+		goto fail_mem;
 	per_cpu(xen_callfunc_irq, cpu).name = callfunc_name;
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_VECTOR,
 				    cpu,
@@ -90,6 +94,9 @@ int xen_smp_intr_init(unsigned int cpu)
 
 	if (!xen_fifo_events) {
 		debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
+		if (!debug_name)
+			goto fail_mem;
+
 		per_cpu(xen_debug_irq, cpu).name = debug_name;
 		rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu,
 					     xen_debug_interrupt,
@@ -101,6 +108,9 @@ int xen_smp_intr_init(unsigned int cpu)
 	}
 
 	callfunc_name = kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
+	if (!callfunc_name)
+		goto fail_mem;
+
 	per_cpu(xen_callfuncsingle_irq, cpu).name = callfunc_name;
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
 				    cpu,
@@ -114,6 +124,8 @@ int xen_smp_intr_init(unsigned int cpu)
 
 	return 0;
 
+ fail_mem:
+	rc = -ENOMEM;
  fail:
 	xen_smp_intr_free(cpu);
 	return rc;
diff --git a/block/opal_proto.h b/block/opal_proto.h
index 5532412d567c0..354b4e93bf63e 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -65,6 +65,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 401d33ae01580..1a08762515291 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -893,16 +893,20 @@ static int response_parse(const u8 *buf, size_t length,
 			token_length = response_parse_medium(iter, pos);
 		else if (pos[0] <= LONG_ATOM_BYTE) /* long atom */
 			token_length = response_parse_long(iter, pos);
+		else if (pos[0] == EMPTY_ATOM_BYTE) /* empty atom */
+			token_length = 1;
 		else /* TOKEN */
 			token_length = response_parse_token(iter, pos);
 
 		if (token_length < 0)
 			return token_length;
 
+		if (pos[0] != EMPTY_ATOM_BYTE)
+			num_entries++;
+
 		pos += token_length;
 		total -= token_length;
 		iter++;
-		num_entries++;
 	}
 
 	resp->num = num_entries;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0ea5e677f00ee..0aca77cb8301c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1531,6 +1531,8 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 		acpi_processor_registered--;
 		if (acpi_processor_registered == 0)
 			cpuidle_unregister_driver(&acpi_idle_driver);
+
+		kfree(dev);
 	}
 
 	pr->flags.power_setup_done = 0;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5d4be80ee6cb4..629e6044f6233 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -322,18 +322,14 @@ static int acpi_scan_device_check(struct acpi_device *adev)
 		 * again).
 		 */
 		if (adev->handler) {
-			dev_warn(&adev->dev, "Already enumerated\n");
-			return -EALREADY;
+			dev_dbg(&adev->dev, "Already enumerated\n");
+			return 0;
 		}
 		error = acpi_bus_scan(adev->handle);
 		if (error) {
 			dev_warn(&adev->dev, "Namespace scan failure\n");
 			return error;
 		}
-		if (!adev->handler) {
-			dev_warn(&adev->dev, "Enumeration failure\n");
-			error = -ENODEV;
-		}
 	} else {
 		error = acpi_scan_device_not_present(adev);
 	}
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6f580883c1973..aa9c6e0ff878d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1648,7 +1648,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 				 map->format.reg_bytes +
 				 map->format.pad_bytes +
 				 val_len);
-	else if (map->bus->gather_write)
+	else if (map->bus && map->bus->gather_write)
 		ret = map->bus->gather_write(map->bus_context, map->work_buf,
 					     map->format.reg_bytes +
 					     map->format.pad_bytes,
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 3cf9bc5d8d959..3d5117be57f9f 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -420,13 +420,16 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 	rcu_read_lock();
 	for_each_netdev_rcu(&init_net, ifp) {
 		dev_hold(ifp);
-		if (!is_aoe_netif(ifp))
-			goto cont;
+		if (!is_aoe_netif(ifp)) {
+			dev_put(ifp);
+			continue;
+		}
 
 		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
 			printk(KERN_INFO "aoe: skb alloc failure\n");
-			goto cont;
+			dev_put(ifp);
+			continue;
 		}
 		skb_put(skb, sizeof *h + sizeof *ch);
 		skb->dev = ifp;
@@ -441,9 +444,6 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 		h->major = cpu_to_be16(aoemajor);
 		h->minor = aoeminor;
 		h->cmd = AOECMD_CFG;
-
-cont:
-		dev_put(ifp);
 	}
 	rcu_read_unlock();
 }
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581dd..1e66c7a188a12 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -64,6 +64,7 @@ tx(int id) __must_hold(&txlock)
 			pr_warn("aoe: packet could not be sent on %s.  %s\n",
 				ifp ? ifp->name : "netif",
 				"consider increasing tx_queue_len");
+		dev_put(ifp);
 		spin_lock_irq(&txlock);
 	}
 	return 0;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 37994a7a1b6f4..f2d847ffcbc75 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2313,6 +2313,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 47c2bb444ab4a..072dc40e29a69 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -136,11 +136,12 @@ config SUNXI_RSB
 
 config TEGRA_ACONNECT
 	tristate "Tegra ACONNECT Bus Driver"
-	depends on ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA
 	depends on OF && PM
 	help
 	  Driver for the Tegra ACONNECT bus which is used to interface with
-	  the devices inside the Audio Processing Engine (APE) for Tegra210.
+	  the devices inside the Audio Processing Engine (APE) for
+	  Tegra210 and later.
 
 config TEGRA_GMI
 	tristate "Tegra Generic Memory Interface bus driver"
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 661d456fb0adf..67051ca60920a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -425,6 +425,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
+	if (!hw)
+		return NULL;
+
 	return hw->core;
 }
 
diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f350cf03..60d8a27a90824 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -130,7 +130,7 @@ static void hi3519_clk_unregister(struct platform_device *pdev)
 	of_clk_del_provider(pdev->dev.of_node);
 
 	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
+				ARRAY_SIZE(hi3519_gate_clks),
 				crg->clk_data);
 	hisi_clk_unregister_mux(hi3519_mux_clks,
 				ARRAY_SIZE(hi3519_mux_clks),
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 0cc4909b5dbef..cb7a2d9247b04 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -569,6 +569,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x3000,
+	.en_few_wait_val = 0x6,
+	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 819d194be8f7b..5a44dc8bd25f2 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -13,14 +13,16 @@
 
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+
 	rcdev->ops->assert(rcdev, id);
-	udelay(1);
+	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }
 
-static int
-qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
 	struct qcom_reset_controller *rst;
 	const struct qcom_reset_map *map;
@@ -28,23 +30,24 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
+
+	regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
+
+	/* Read back the register to ensure write completion, ignore the value */
+	regmap_read(rst->regmap, map->reg, &mask);
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
+	return 0;
 }
 
-static int
-qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	struct qcom_reset_controller *rst;
-	const struct qcom_reset_map *map;
-	u32 mask;
-
-	rst = to_qcom_reset_controller(rcdev);
-	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	return qcom_reset_set_assert(rcdev, id, true);
+}
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
+static int qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return qcom_reset_set_assert(rcdev, id, false);
 }
 
 const struct reset_control_ops qcom_reset_ops = {
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index 2a08b5e282c77..9a47c838d9b1b 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -11,6 +11,8 @@
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
+	u8 udelay;
+	u32 bitmask;
 };
 
 struct regmap;
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 66aad9dbd58c5..a7c156ce2c298 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -582,16 +582,16 @@ config TEGRA20_APB_DMA
 
 config TEGRA210_ADMA
 	tristate "NVIDIA Tegra210 ADMA support"
-	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST)
+	depends on (ARCH_TEGRA || COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Support for the NVIDIA Tegra210 ADMA controller driver. The
-	  DMA controller has multiple DMA channels and is used to service
-	  various audio clients in the Tegra210 audio processing engine
-	  (APE). This DMA controller transfers data from memory to
-	  peripheral and vice versa. It does not support memory to
-	  memory data transfer.
+	  Support for the NVIDIA Tegra210/Tegra186/Tegra194/Tegra234 ADMA
+	  controller driver. The DMA controller has multiple DMA channels
+	  and is used to service various audio clients in the Tegra210
+	  audio processing engine (APE). This DMA controller transfers
+	  data from memory to peripheral and vice versa. It does not
+	  support memory to memory data transfer.
 
 config TIMB_DMA
 	tristate "Timberdale FPGA DMA support"
diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index be195ba834632..d446a72629414 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -500,7 +500,19 @@ static void bm_work(struct work_struct *work)
 		fw_notice(card, "phy config: new root=%x, gap_count=%d\n",
 			  new_root_id, gap_count);
 		fw_send_phy_config(card, new_root_id, generation, gap_count);
-		reset_bus(card, true);
+		/*
+		 * Where possible, use a short bus reset to minimize
+		 * disruption to isochronous transfers. But in the event
+		 * of a gap count inconsistency, use a long bus reset.
+		 *
+		 * As noted in 1394a 8.4.6.2, nodes on a mixed 1394/1394a bus
+		 * may set different gap counts after a bus reset. On a mixed
+		 * 1394/1394a bus, a short bus reset can get doubled. Some
+		 * nodes may treat the double reset as one bus reset and others
+		 * may treat it as two, causing a gap count inconsistency
+		 * again. Using a long bus reset prevents this.
+		 */
+		reset_bus(card, card->gap_count != 0);
 		/* Will allocate broadcast channel after the reset. */
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index cae426c7c0863..e1503b52519a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -308,7 +308,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		return 0;
+		break;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c4c99bc7f2890..3059739695d8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1470,6 +1470,9 @@ dcn10_set_output_transfer_func(struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	if (!stream)
+		return false;
+
 	if (dpp == NULL)
 		return false;
 
@@ -1492,8 +1495,8 @@ dcn10_set_output_transfer_func(struct pipe_ctx *pipe_ctx,
 	} else
 		dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_BYPASS);
 
-	if (stream != NULL && stream->ctx != NULL &&
-			stream->out_transfer_func != NULL) {
+	if (stream->ctx &&
+	    stream->out_transfer_func) {
 		log_tf(stream->ctx,
 				stream->out_transfer_func,
 				dpp->regamma_params.hw_points_num);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index f370d41b3d041..9bbad33500691 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -73,11 +73,13 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
 	struct drm_crtc *crtc = &mtk_crtc->base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&crtc->dev->event_lock, flags);
-	drm_crtc_send_vblank_event(crtc, mtk_crtc->event);
-	drm_crtc_vblank_put(crtc);
-	mtk_crtc->event = NULL;
-	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+	if (mtk_crtc->event) {
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
+		drm_crtc_send_vblank_event(crtc, mtk_crtc->event);
+		drm_crtc_vblank_put(crtc);
+		mtk_crtc->event = NULL;
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+	}
 }
 
 static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index e82705a33acfd..9af900076dee4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -64,8 +64,8 @@
 #define DSI_PS_WC			0x3fff
 #define DSI_PS_SEL			(3 << 16)
 #define PACKED_PS_16BIT_RGB565		(0 << 16)
-#define LOOSELY_PS_18BIT_RGB666		(1 << 16)
-#define PACKED_PS_18BIT_RGB666		(2 << 16)
+#define PACKED_PS_18BIT_RGB666		(1 << 16)
+#define LOOSELY_PS_24BIT_RGB666		(2 << 16)
 #define PACKED_PS_24BIT_RGB888		(3 << 16)
 
 #define DSI_VSA_NL		0x20
@@ -321,10 +321,10 @@ static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
 		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
+		ps_bpp_mode |= LOOSELY_PS_24BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
+		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB565:
 		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
@@ -375,7 +375,7 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		tmp_reg = LOOSELY_PS_18BIT_RGB666;
+		tmp_reg = LOOSELY_PS_24BIT_RGB666;
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index b9c84fb4d4a1f..311863a05a6fa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -258,12 +258,14 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
 		mode.htotal >>= 1;
 		mode.hsync_start >>= 1;
 		mode.hsync_end >>= 1;
+		mode.hskew >>= 1;
 
 		DPU_DEBUG_VIDENC(phys_enc,
-			"split_role %d, halve horizontal %d %d %d %d\n",
+			"split_role %d, halve horizontal %d %d %d %d %d\n",
 			phys_enc->split_role,
 			mode.hdisplay, mode.htotal,
-			mode.hsync_start, mode.hsync_end);
+			mode.hsync_start, mode.hsync_end,
+			mode.hskew);
 	}
 
 	drm_mode_to_intf_timing_params(phys_enc, &mode, &timing_params);
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 410f626a39d43..1fa48853b54e4 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -826,7 +826,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 			err = 0;
 		} else if (rdev->smc_fw->size != smc_req_size) {
 			pr_err("ni_mc: Bogus length %zu in firmware \"%s\"\n",
-			       rdev->mc_fw->size, fw_name);
+			       rdev->smc_fw->size, fw_name);
 			err = -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f2e2cc66f4897..95888e64bd8bc 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -401,7 +401,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -416,7 +416,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 64aefa8568963..aa8212c721b10 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -366,7 +366,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_port;
 	} else if (ret) {
 		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
 		goto err_put_port;
 	}
 	if (lvds->panel)
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 13413d2b26028..03ccfb6ce8a89 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1451,9 +1451,11 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 	np = of_parse_phandle(dsi->dev->of_node, "nvidia,ganged-mode", 0);
 	if (np) {
 		struct platform_device *gangster = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!gangster)
+			return -EPROBE_DEFER;
 
 		dsi->slave = platform_get_drvdata(gangster);
-		of_node_put(np);
 
 		if (!dsi->slave) {
 			put_device(&gangster->dev);
@@ -1501,48 +1503,58 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 
 	if (!pdev->dev.pm_domain) {
 		dsi->rst = devm_reset_control_get(&pdev->dev, "dsi");
-		if (IS_ERR(dsi->rst))
-			return PTR_ERR(dsi->rst);
+		if (IS_ERR(dsi->rst)) {
+			err = PTR_ERR(dsi->rst);
+			goto remove;
+		}
 	}
 
 	dsi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dsi->clk)) {
-		dev_err(&pdev->dev, "cannot get DSI clock\n");
-		return PTR_ERR(dsi->clk);
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk),
+				    "cannot get DSI clock\n");
+		goto remove;
 	}
 
 	dsi->clk_lp = devm_clk_get(&pdev->dev, "lp");
 	if (IS_ERR(dsi->clk_lp)) {
-		dev_err(&pdev->dev, "cannot get low-power clock\n");
-		return PTR_ERR(dsi->clk_lp);
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_lp),
+				    "cannot get low-power clock\n");
+		goto remove;
 	}
 
 	dsi->clk_parent = devm_clk_get(&pdev->dev, "parent");
 	if (IS_ERR(dsi->clk_parent)) {
-		dev_err(&pdev->dev, "cannot get parent clock\n");
-		return PTR_ERR(dsi->clk_parent);
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->clk_parent),
+				    "cannot get parent clock\n");
+		goto remove;
 	}
 
 	dsi->vdd = devm_regulator_get(&pdev->dev, "avdd-dsi-csi");
 	if (IS_ERR(dsi->vdd)) {
-		dev_err(&pdev->dev, "cannot get VDD supply\n");
-		return PTR_ERR(dsi->vdd);
+		err = dev_err_probe(&pdev->dev, PTR_ERR(dsi->vdd),
+				    "cannot get VDD supply\n");
+		goto remove;
 	}
 
 	err = tegra_dsi_setup_clocks(dsi);
 	if (err < 0) {
 		dev_err(&pdev->dev, "cannot setup clocks\n");
-		return err;
+		goto remove;
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dsi->regs = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(dsi->regs))
-		return PTR_ERR(dsi->regs);
+	if (IS_ERR(dsi->regs)) {
+		err = PTR_ERR(dsi->regs);
+		goto remove;
+	}
 
-	dsi->mipi = tegra_mipi_request(&pdev->dev);
-	if (IS_ERR(dsi->mipi))
-		return PTR_ERR(dsi->mipi);
+	dsi->mipi = tegra_mipi_request(&pdev->dev, pdev->dev.of_node);
+	if (IS_ERR(dsi->mipi)) {
+		err = PTR_ERR(dsi->mipi);
+		goto remove;
+	}
 
 	dsi->host.ops = &tegra_dsi_host_ops;
 	dsi->host.dev = &pdev->dev;
@@ -1570,9 +1582,12 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
+remove:
+	tegra_output_remove(&dsi->output);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index e34325c83d28e..361e67e4cd984 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -155,6 +155,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index bdcaa4c7168cf..806249c0b7e85 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -127,8 +127,10 @@ int tegra_output_probe(struct tegra_output *output)
 						       GPIOD_IN,
 						       "HDMI hotplug detect");
 	if (IS_ERR(output->hpd_gpio)) {
-		if (PTR_ERR(output->hpd_gpio) != -ENOENT)
-			return PTR_ERR(output->hpd_gpio);
+		if (PTR_ERR(output->hpd_gpio) != -ENOENT) {
+			err = PTR_ERR(output->hpd_gpio);
+			goto put_i2c;
+		}
 
 		output->hpd_gpio = NULL;
 	}
@@ -137,7 +139,7 @@ int tegra_output_probe(struct tegra_output *output)
 		err = gpiod_to_irq(output->hpd_gpio);
 		if (err < 0) {
 			dev_err(output->dev, "gpiod_to_irq(): %d\n", err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->hpd_irq = err;
@@ -150,7 +152,7 @@ int tegra_output_probe(struct tegra_output *output)
 		if (err < 0) {
 			dev_err(output->dev, "failed to request IRQ#%u: %d\n",
 				output->hpd_irq, err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->connector.polled = DRM_CONNECTOR_POLL_HPD;
@@ -168,6 +170,12 @@ int tegra_output_probe(struct tegra_output *output)
 		return -ENOMEM;
 
 	return 0;
+
+put_i2c:
+	if (output->ddc)
+		i2c_put_adapter(output->ddc);
+
+	return err;
 }
 
 void tegra_output_remove(struct tegra_output *output)
diff --git a/drivers/gpu/host1x/mipi.c b/drivers/gpu/host1x/mipi.c
index e00809d996a29..762d349ad00f1 100644
--- a/drivers/gpu/host1x/mipi.c
+++ b/drivers/gpu/host1x/mipi.c
@@ -206,9 +206,9 @@ static int tegra_mipi_power_down(struct tegra_mipi *mipi)
 	return 0;
 }
 
-struct tegra_mipi_device *tegra_mipi_request(struct device *device)
+struct tegra_mipi_device *tegra_mipi_request(struct device *device,
+					     struct device_node *np)
 {
-	struct device_node *np = device->of_node;
 	struct tegra_mipi_device *dev;
 	struct of_phandle_args args;
 	int err;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c37399f61c67b..c3810e7140a55 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2090,6 +2090,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcddc) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a12ee8ef27a89..c7c3b9bae938c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1700,7 +1700,7 @@ static int assign_client_id(struct ib_client *client)
 {
 	int ret;
 
-	down_write(&clients_rwsem);
+	lockdep_assert_held(&clients_rwsem);
 	/*
 	 * The add/remove callbacks must be called in FIFO/LIFO order. To
 	 * achieve this we assign client_ids so they are sorted in
@@ -1709,14 +1709,11 @@ static int assign_client_id(struct ib_client *client)
 	client->client_id = highest_client_id;
 	ret = xa_insert(&clients, client->client_id, client, GFP_KERNEL);
 	if (ret)
-		goto out;
+		return ret;
 
 	highest_client_id++;
 	xa_set_mark(&clients, client->client_id, CLIENT_REGISTERED);
-
-out:
-	up_write(&clients_rwsem);
-	return ret;
+	return 0;
 }
 
 static void remove_client_id(struct ib_client *client)
@@ -1746,25 +1743,35 @@ int ib_register_client(struct ib_client *client)
 {
 	struct ib_device *device;
 	unsigned long index;
+	bool need_unreg = false;
 	int ret;
 
 	refcount_set(&client->uses, 1);
 	init_completion(&client->uses_zero);
+
+	/*
+	 * The devices_rwsem is held in write mode to ensure that a racing
+	 * ib_register_device() sees a consisent view of clients and devices.
+	 */
+	down_write(&devices_rwsem);
+	down_write(&clients_rwsem);
 	ret = assign_client_id(client);
 	if (ret)
-		return ret;
+		goto out;
 
-	down_read(&devices_rwsem);
+	need_unreg = true;
 	xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
 		ret = add_client_context(device, client);
-		if (ret) {
-			up_read(&devices_rwsem);
-			ib_unregister_client(client);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
-	up_read(&devices_rwsem);
-	return 0;
+	ret = 0;
+out:
+	up_write(&clients_rwsem);
+	up_write(&devices_rwsem);
+	if (need_unreg && ret)
+		ib_unregister_client(client);
+	return ret;
 }
 EXPORT_SYMBOL(ib_register_client);
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 26cc7bbcdfe6a..7a3b56c150799 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2811,7 +2811,7 @@ DECLARE_UVERBS_NAMED_METHOD(
 	MLX5_IB_METHOD_DEVX_OBJ_MODIFY,
 	UVERBS_ATTR_IDR(MLX5_IB_ATTR_DEVX_OBJ_MODIFY_HANDLE,
 			UVERBS_IDR_ANY_OBJECT,
-			UVERBS_ACCESS_WRITE,
+			UVERBS_ACCESS_READ,
 			UA_MANDATORY),
 	UVERBS_ATTR_PTR_IN(
 		MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN,
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 465eecfa6b3f0..825fff00e4f88 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -325,12 +325,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 			error = devm_gpio_request_one(dev, button->gpio,
 					flags, button->desc ? : DRV_NAME);
-			if (error) {
-				dev_err(dev,
-					"unable to claim gpio %u, err=%d\n",
-					button->gpio, error);
-				return error;
-			}
+			if (error)
+				return dev_err_probe(dev, error,
+						     "unable to claim gpio %u\n",
+						     button->gpio);
 
 			bdata->gpiod = gpio_to_desc(button->gpio);
 			if (!bdata->gpiod) {
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4a9feff340da7..15e25f712f393 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1745,6 +1745,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	/* Prevent binding other PCI device drivers to IOMMU devices */
 	iommu->dev->match_driver = false;
 
+	/* ACPI _PRT won't have an IRQ for IOMMU */
+	iommu->dev->irq_managed = 1;
+
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_RANGE_OFFSET,
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 6b4fb4e7506f8..6866aa2aade3b 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -46,11 +46,11 @@
 struct convert_context {
 	struct completion restart;
 	struct bio *bio_in;
-	struct bio *bio_out;
 	struct bvec_iter iter_in;
+	struct bio *bio_out;
 	struct bvec_iter iter_out;
-	u64 cc_sector;
 	atomic_t cc_pending;
+	u64 cc_sector;
 	union {
 		struct skcipher_request *req;
 		struct aead_request *req_aead;
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9f05ae2b90191..1ccd765fad938 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3343,14 +3343,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
 	struct mddev *mddev = &rs->md;
 
 	/*
-	 * If we're reshaping to add disk(s)), ti->len and
+	 * If we're reshaping to add disk(s), ti->len and
 	 * mddev->array_sectors will differ during the process
 	 * (ti->len > mddev->array_sectors), so we have to requeue
 	 * bios with addresses > mddev->array_sectors here or
 	 * there will occur accesses past EOD of the component
 	 * data images thus erroring the raid set.
 	 */
-	if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
+	if (unlikely(bio_has_data(bio) && bio_end_sector(bio) > mddev->array_sectors))
 		return DM_MAPIO_REQUEUE;
 
 	md_handle_request(mddev, bio);
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 74ad36b6dbf53..fee7c7a81ce4e 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -73,11 +73,11 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned n_blocks;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	/*
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 771167ee552cd..a7724ba45b437 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2809,6 +2809,9 @@ static void __dm_internal_suspend(struct mapped_device *md, unsigned suspend_fla
 
 static void __dm_internal_resume(struct mapped_device *md)
 {
+	int r;
+	struct dm_table *map;
+
 	BUG_ON(!md->internal_suspend_count);
 
 	if (--md->internal_suspend_count)
@@ -2817,12 +2820,23 @@ static void __dm_internal_resume(struct mapped_device *md)
 	if (dm_suspended_md(md))
 		goto done; /* resume from nested suspend */
 
-	/*
-	 * NOTE: existing callers don't need to call dm_table_resume_targets
-	 * (which may fail -- so best to avoid it for now by passing NULL map)
-	 */
-	(void) __dm_resume(md, NULL);
-
+	map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
+	r = __dm_resume(md, map);
+	if (r) {
+		/*
+		 * If a preresume method of some target failed, we are in a
+		 * tricky situation. We can't return an error to the caller. We
+		 * can't fake success because then the "resume" and
+		 * "postsuspend" methods would not be paired correctly, and it
+		 * would break various targets, for example it would cause list
+		 * corruption in the "origin" target.
+		 *
+		 * So, we fake normal suspend here, to make sure that the
+		 * "resume" and "postsuspend" methods will be paired correctly.
+		 */
+		DMERR("Preresume method failed: %d", r);
+		set_bit(DMF_SUSPENDED, &md->flags);
+	}
 done:
 	clear_bit(DMF_SUSPENDED_INTERNALLY, &md->flags);
 	smp_mb__after_atomic();
diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
index 50f1e0b28b250..a4d729a4f3301 100644
--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -113,6 +113,7 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
 {
 	unsigned pat;
 	unsigned plane;
+	int ret = 0;
 
 	tpg->max_line_width = max_w;
 	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++) {
@@ -121,14 +122,18 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
 
 			tpg->lines[pat][plane] =
 				vzalloc(array3_size(max_w, 2, pixelsz));
-			if (!tpg->lines[pat][plane])
-				return -ENOMEM;
+			if (!tpg->lines[pat][plane]) {
+				ret = -ENOMEM;
+				goto free_lines;
+			}
 			if (plane == 0)
 				continue;
 			tpg->downsampled_lines[pat][plane] =
 				vzalloc(array3_size(max_w, 2, pixelsz));
-			if (!tpg->downsampled_lines[pat][plane])
-				return -ENOMEM;
+			if (!tpg->downsampled_lines[pat][plane]) {
+				ret = -ENOMEM;
+				goto free_lines;
+			}
 		}
 	}
 	for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
@@ -136,18 +141,45 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
 
 		tpg->contrast_line[plane] =
 			vzalloc(array_size(pixelsz, max_w));
-		if (!tpg->contrast_line[plane])
-			return -ENOMEM;
+		if (!tpg->contrast_line[plane]) {
+			ret = -ENOMEM;
+			goto free_contrast_line;
+		}
 		tpg->black_line[plane] =
 			vzalloc(array_size(pixelsz, max_w));
-		if (!tpg->black_line[plane])
-			return -ENOMEM;
+		if (!tpg->black_line[plane]) {
+			ret = -ENOMEM;
+			goto free_contrast_line;
+		}
 		tpg->random_line[plane] =
 			vzalloc(array3_size(max_w, 2, pixelsz));
-		if (!tpg->random_line[plane])
-			return -ENOMEM;
+		if (!tpg->random_line[plane]) {
+			ret = -ENOMEM;
+			goto free_contrast_line;
+		}
 	}
 	return 0;
+
+free_contrast_line:
+	for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
+		vfree(tpg->contrast_line[plane]);
+		vfree(tpg->black_line[plane]);
+		vfree(tpg->random_line[plane]);
+		tpg->contrast_line[plane] = NULL;
+		tpg->black_line[plane] = NULL;
+		tpg->random_line[plane] = NULL;
+	}
+free_lines:
+	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++)
+		for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
+			vfree(tpg->lines[pat][plane]);
+			tpg->lines[pat][plane] = NULL;
+			if (plane == 0)
+				continue;
+			vfree(tpg->downsampled_lines[pat][plane]);
+			tpg->downsampled_lines[pat][plane] = NULL;
+		}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpg_alloc);
 
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index e7cd7b13fc28c..d4d903a9dc31e 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -504,6 +504,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
 		if (!dvbdevfops) {
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -512,6 +513,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		if (!new_node) {
 			kfree(dvbdevfops);
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -545,6 +547,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
 		return -EINVAL;
@@ -567,6 +570,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
@@ -585,6 +589,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-frontends/stv0367.c
index 0bfca1174e9e7..8cbae8235b174 100644
--- a/drivers/media/dvb-frontends/stv0367.c
+++ b/drivers/media/dvb-frontends/stv0367.c
@@ -118,50 +118,32 @@ static const s32 stv0367cab_RF_LookUp2[RF_LOOKUP_TABLE2_SIZE][RF_LOOKUP_TABLE2_S
 	}
 };
 
-static
-int stv0367_writeregs(struct stv0367_state *state, u16 reg, u8 *data, int len)
+static noinline_for_stack
+int stv0367_writereg(struct stv0367_state *state, u16 reg, u8 data)
 {
-	u8 buf[MAX_XFER_SIZE];
+	u8 buf[3] = { MSB(reg), LSB(reg), data };
 	struct i2c_msg msg = {
 		.addr = state->config->demod_address,
 		.flags = 0,
 		.buf = buf,
-		.len = len + 2
+		.len = 3,
 	};
 	int ret;
 
-	if (2 + len > sizeof(buf)) {
-		printk(KERN_WARNING
-		       "%s: i2c wr reg=%04x: len=%d is too big!\n",
-		       KBUILD_MODNAME, reg, len);
-		return -EINVAL;
-	}
-
-
-	buf[0] = MSB(reg);
-	buf[1] = LSB(reg);
-	memcpy(buf + 2, data, len);
-
 	if (i2cdebug)
 		printk(KERN_DEBUG "%s: [%02x] %02x: %02x\n", __func__,
-			state->config->demod_address, reg, buf[2]);
+			state->config->demod_address, reg, data);
 
 	ret = i2c_transfer(state->i2c, &msg, 1);
 	if (ret != 1)
 		printk(KERN_ERR "%s: i2c write error! ([%02x] %02x: %02x)\n",
-			__func__, state->config->demod_address, reg, buf[2]);
+			__func__, state->config->demod_address, reg, data);
 
 	return (ret != 1) ? -EREMOTEIO : 0;
 }
 
-static int stv0367_writereg(struct stv0367_state *state, u16 reg, u8 data)
-{
-	u8 tmp = data; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
-
-	return stv0367_writeregs(state, reg, &tmp, 1);
-}
-
-static u8 stv0367_readreg(struct stv0367_state *state, u16 reg)
+static noinline_for_stack
+u8 stv0367_readreg(struct stv0367_state *state, u16 reg)
 {
 	u8 b0[] = { 0, 0 };
 	u8 b1[] = { 0 };
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 76c443067ec2d..ef1460c61bea0 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2107,9 +2107,6 @@ static int tc358743_probe(struct i2c_client *client)
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2167,6 +2164,10 @@ static int tc358743_probe(struct i2c_client *client)
 	if (err)
 		goto err_work_queues;
 
+	err = v4l2_async_register_subdev(sd);
+	if (err < 0)
+		goto err_work_queues;
+
 	v4l2_info(sd, "%s found @ 0x%x (%s)\n", client->name,
 		  client->addr << 1, client->adapter->name);
 
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index a0be1ca89b29a..cdde56889fe2a 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -2964,7 +2964,7 @@ static int bttv_open(struct file *file)
 
 	dprintk("open dev=%s\n", video_device_node_name(vdev));
 
-	if (vdev->vfl_type == VFL_TYPE_GRABBER) {
+	if (vdev->vfl_type == VFL_TYPE_VIDEO) {
 		type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	} else if (vdev->vfl_type == VFL_TYPE_VBI) {
 		type = V4L2_BUF_TYPE_VBI_CAPTURE;
@@ -3905,7 +3905,7 @@ static int bttv_register_video(struct bttv *btv)
 	if (no_overlay <= 0)
 		btv->video_dev.device_caps |= V4L2_CAP_VIDEO_OVERLAY;
 
-	if (video_register_device(&btv->video_dev, VFL_TYPE_GRABBER,
+	if (video_register_device(&btv->video_dev, VFL_TYPE_VIDEO,
 				  video_nr[btv->c.nr]) < 0)
 		goto err;
 	pr_info("%d: registered device %s\n",
diff --git a/drivers/media/pci/cobalt/cobalt-v4l2.c b/drivers/media/pci/cobalt/cobalt-v4l2.c
index c5207501d5e03..0ff37496c9ab7 100644
--- a/drivers/media/pci/cobalt/cobalt-v4l2.c
+++ b/drivers/media/pci/cobalt/cobalt-v4l2.c
@@ -1272,7 +1272,7 @@ static int cobalt_node_register(struct cobalt *cobalt, int node)
 	video_set_drvdata(vdev, s);
 	ret = vb2_queue_init(q);
 	if (!s->is_audio && ret == 0)
-		ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	else if (!s->is_dummy)
 		ret = cobalt_alsa_init(s);
 
diff --git a/drivers/media/pci/cx18/cx18-streams.c b/drivers/media/pci/cx18/cx18-streams.c
index b79718519b9ba..3178df3c49224 100644
--- a/drivers/media/pci/cx18/cx18-streams.c
+++ b/drivers/media/pci/cx18/cx18-streams.c
@@ -48,19 +48,19 @@ static struct {
 } cx18_stream_info[] = {
 	{	/* CX18_ENC_STREAM_TYPE_MPG */
 		"encoder MPEG",
-		VFL_TYPE_GRABBER, 0,
+		VFL_TYPE_VIDEO, 0,
 		PCI_DMA_FROMDEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_AUDIO | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_TS */
 		"TS",
-		VFL_TYPE_GRABBER, -1,
+		VFL_TYPE_VIDEO, -1,
 		PCI_DMA_FROMDEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
-		VFL_TYPE_GRABBER, CX18_V4L2_ENC_YUV_OFFSET,
+		VFL_TYPE_VIDEO, CX18_V4L2_ENC_YUV_OFFSET,
 		PCI_DMA_FROMDEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_STREAMING | V4L2_CAP_AUDIO | V4L2_CAP_TUNER
@@ -74,13 +74,13 @@ static struct {
 	},
 	{	/* CX18_ENC_STREAM_TYPE_PCM */
 		"encoder PCM audio",
-		VFL_TYPE_GRABBER, CX18_V4L2_ENC_PCM_OFFSET,
+		VFL_TYPE_VIDEO, CX18_V4L2_ENC_PCM_OFFSET,
 		PCI_DMA_FROMDEVICE,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_IDX */
 		"encoder IDX",
-		VFL_TYPE_GRABBER, -1,
+		VFL_TYPE_VIDEO, -1,
 		PCI_DMA_FROMDEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_RAD */
@@ -434,7 +434,7 @@ static int cx18_reg_dev(struct cx18 *cx, int type)
 	name = video_device_node_name(&s->video_dev);
 
 	switch (vfl_type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		CX18_INFO("Registered device %s for %s (%d x %d.%02d kB)\n",
 			  name, s->name, cx->stream_buffers[type],
 			  cx->stream_buf_size[type] / 1024,
diff --git a/drivers/media/pci/cx23885/cx23885-417.c b/drivers/media/pci/cx23885/cx23885-417.c
index 2327fe6126102..434677bd4ad17 100644
--- a/drivers/media/pci/cx23885/cx23885-417.c
+++ b/drivers/media/pci/cx23885/cx23885-417.c
@@ -1545,7 +1545,7 @@ int cx23885_417_register(struct cx23885_dev *dev)
 	if (dev->tuner_type != TUNER_ABSENT)
 		dev->v4l_device->device_caps |= V4L2_CAP_TUNER;
 	err = video_register_device(dev->v4l_device,
-		VFL_TYPE_GRABBER, -1);
+		VFL_TYPE_VIDEO, -1);
 	if (err < 0) {
 		pr_info("%s: can't register mpeg device\n", dev->name);
 		return err;
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index f56b271db8bea..90224a9947022 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -1304,7 +1304,7 @@ int cx23885_video_register(struct cx23885_dev *dev)
 				      V4L2_CAP_AUDIO | V4L2_CAP_VIDEO_CAPTURE;
 	if (dev->tuner_type != TUNER_ABSENT)
 		dev->video_dev->device_caps |= V4L2_CAP_TUNER;
-	err = video_register_device(dev->video_dev, VFL_TYPE_GRABBER,
+	err = video_register_device(dev->video_dev, VFL_TYPE_VIDEO,
 				    video_nr[dev->nr]);
 	if (err < 0) {
 		pr_info("%s: can't register video device\n",
diff --git a/drivers/media/pci/cx25821/cx25821-video.c b/drivers/media/pci/cx25821/cx25821-video.c
index a10261da0db6e..1b80c990cb946 100644
--- a/drivers/media/pci/cx25821/cx25821-video.c
+++ b/drivers/media/pci/cx25821/cx25821-video.c
@@ -757,7 +757,7 @@ int cx25821_video_register(struct cx25821_dev *dev)
 		snprintf(vdev->name, sizeof(vdev->name), "%s #%d", dev->name, i);
 		video_set_drvdata(vdev, chan);
 
-		err = video_register_device(vdev, VFL_TYPE_GRABBER,
+		err = video_register_device(vdev, VFL_TYPE_VIDEO,
 					    video_nr[dev->nr]);
 
 		if (err < 0)
diff --git a/drivers/media/pci/cx88/cx88-blackbird.c b/drivers/media/pci/cx88/cx88-blackbird.c
index d3da7f4297af8..fa4ca002ed191 100644
--- a/drivers/media/pci/cx88/cx88-blackbird.c
+++ b/drivers/media/pci/cx88/cx88-blackbird.c
@@ -1138,7 +1138,7 @@ static int blackbird_register_video(struct cx8802_dev *dev)
 				    V4L2_CAP_VIDEO_CAPTURE;
 	if (dev->core->board.tuner_type != UNSET)
 		dev->mpeg_dev.device_caps |= V4L2_CAP_TUNER;
-	err = video_register_device(&dev->mpeg_dev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(&dev->mpeg_dev, VFL_TYPE_VIDEO, -1);
 	if (err < 0) {
 		pr_info("can't register mpeg device\n");
 		return err;
diff --git a/drivers/media/pci/cx88/cx88-video.c b/drivers/media/pci/cx88/cx88-video.c
index 547e18da1ad7d..151ffb5fd4042 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -1452,7 +1452,7 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 				     V4L2_CAP_VIDEO_CAPTURE;
 	if (core->board.tuner_type != UNSET)
 		dev->video_dev.device_caps |= V4L2_CAP_TUNER;
-	err = video_register_device(&dev->video_dev, VFL_TYPE_GRABBER,
+	err = video_register_device(&dev->video_dev, VFL_TYPE_VIDEO,
 				    video_nr[core->nr]);
 	if (err < 0) {
 		pr_err("can't register video device\n");
diff --git a/drivers/media/pci/dt3155/dt3155.c b/drivers/media/pci/dt3155/dt3155.c
index 7480f0d3ad0fa..82581aa5a2a39 100644
--- a/drivers/media/pci/dt3155/dt3155.c
+++ b/drivers/media/pci/dt3155/dt3155.c
@@ -550,7 +550,7 @@ static int dt3155_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 					IRQF_SHARED, DT3155_NAME, pd);
 	if (err)
 		goto err_iounmap;
-	err = video_register_device(&pd->vdev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(&pd->vdev, VFL_TYPE_VIDEO, -1);
 	if (err)
 		goto err_free_irq;
 	dev_info(&pdev->dev, "/dev/video%i is ready\n", pd->vdev.minor);
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 9c0d117e093b1..385b20b22ac35 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1651,7 +1651,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	vdev->queue = &q->vbq;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
 	video_set_drvdata(vdev, cio2);
-	r = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	r = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (r) {
 		dev_err(&cio2->pci_dev->dev,
 			"failed to register video device (%d)\n", r);
diff --git a/drivers/media/pci/ivtv/ivtv-streams.c b/drivers/media/pci/ivtv/ivtv-streams.c
index 200d2100dbffd..f9de5d1605fe3 100644
--- a/drivers/media/pci/ivtv/ivtv-streams.c
+++ b/drivers/media/pci/ivtv/ivtv-streams.c
@@ -99,7 +99,7 @@ static struct {
 } ivtv_stream_info[] = {
 	{	/* IVTV_ENC_STREAM_TYPE_MPG */
 		"encoder MPG",
-		VFL_TYPE_GRABBER, 0,
+		VFL_TYPE_VIDEO, 0,
 		PCI_DMA_FROMDEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
@@ -107,7 +107,7 @@ static struct {
 	},
 	{	/* IVTV_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
-		VFL_TYPE_GRABBER, IVTV_V4L2_ENC_YUV_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_YUV_OFFSET,
 		PCI_DMA_FROMDEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
@@ -123,7 +123,7 @@ static struct {
 	},
 	{	/* IVTV_ENC_STREAM_TYPE_PCM */
 		"encoder PCM",
-		VFL_TYPE_GRABBER, IVTV_V4L2_ENC_PCM_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_PCM_OFFSET,
 		PCI_DMA_FROMDEVICE, 0,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -137,7 +137,7 @@ static struct {
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_MPG */
 		"decoder MPG",
-		VFL_TYPE_GRABBER, IVTV_V4L2_DEC_MPG_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_MPG_OFFSET,
 		PCI_DMA_TODEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
@@ -158,7 +158,7 @@ static struct {
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_YUV */
 		"decoder YUV",
-		VFL_TYPE_GRABBER, IVTV_V4L2_DEC_YUV_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_YUV_OFFSET,
 		PCI_DMA_TODEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
@@ -315,7 +315,7 @@ static int ivtv_reg_dev(struct ivtv *itv, int type)
 	name = video_device_node_name(&s->vdev);
 
 	switch (vfl_type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		IVTV_INFO("Registered device %s for %s (%d kB)\n",
 			name, s->name, itv->options.kilobytes[type]);
 		break;
diff --git a/drivers/media/pci/meye/meye.c b/drivers/media/pci/meye/meye.c
index 0e61c81356ef5..c42e48bc5c1cb 100644
--- a/drivers/media/pci/meye/meye.c
+++ b/drivers/media/pci/meye/meye.c
@@ -1711,7 +1711,7 @@ static int meye_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	v4l2_ctrl_handler_setup(&meye.hdl);
 	meye.vdev.ctrl_handler = &meye.hdl;
 
-	if (video_register_device(&meye.vdev, VFL_TYPE_GRABBER,
+	if (video_register_device(&meye.vdev, VFL_TYPE_VIDEO,
 				  video_nr) < 0) {
 		v4l2_err(v4l2_dev, "video_register_device failed\n");
 		goto outvideoreg;
diff --git a/drivers/media/pci/saa7134/saa7134-core.c b/drivers/media/pci/saa7134/saa7134-core.c
index 2d582c02adbf9..e4623ed2f8319 100644
--- a/drivers/media/pci/saa7134/saa7134-core.c
+++ b/drivers/media/pci/saa7134/saa7134-core.c
@@ -1214,7 +1214,7 @@ static int saa7134_initdev(struct pci_dev *pci_dev,
 	if (saa7134_no_overlay <= 0)
 		dev->video_dev->device_caps |= V4L2_CAP_VIDEO_OVERLAY;
 
-	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
+	err = video_register_device(dev->video_dev,VFL_TYPE_VIDEO,
 				    video_nr[dev->nr]);
 	if (err < 0) {
 		pr_info("%s: can't register video device\n",
diff --git a/drivers/media/pci/saa7134/saa7134-empress.c b/drivers/media/pci/saa7134/saa7134-empress.c
index e2666d1c68964..141ee18ed827e 100644
--- a/drivers/media/pci/saa7134/saa7134-empress.c
+++ b/drivers/media/pci/saa7134/saa7134-empress.c
@@ -294,7 +294,7 @@ static int empress_init(struct saa7134_dev *dev)
 		dev->empress_dev->device_caps |= V4L2_CAP_TUNER;
 
 	video_set_drvdata(dev->empress_dev, dev);
-	err = video_register_device(dev->empress_dev,VFL_TYPE_GRABBER,
+	err = video_register_device(dev->empress_dev,VFL_TYPE_VIDEO,
 				    empress_nr[dev->nr]);
 	if (err < 0) {
 		pr_info("%s: can't register video device\n",
diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
index 86d4e2abed82a..3947701cd6c7e 100644
--- a/drivers/media/pci/saa7146/hexium_gemini.c
+++ b/drivers/media/pci/saa7146/hexium_gemini.c
@@ -294,7 +294,7 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 	vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
-	ret = saa7146_register_device(&hexium->video_dev, dev, "hexium gemini", VFL_TYPE_GRABBER);
+	ret = saa7146_register_device(&hexium->video_dev, dev, "hexium gemini", VFL_TYPE_VIDEO);
 	if (ret < 0) {
 		pr_err("cannot register capture v4l2 device. skipping.\n");
 		saa7146_vv_release(dev);
diff --git a/drivers/media/pci/saa7146/hexium_orion.c b/drivers/media/pci/saa7146/hexium_orion.c
index 31388597386aa..2eb4bee16b71f 100644
--- a/drivers/media/pci/saa7146/hexium_orion.c
+++ b/drivers/media/pci/saa7146/hexium_orion.c
@@ -368,7 +368,7 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 	vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
-	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium orion", VFL_TYPE_GRABBER)) {
+	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium orion", VFL_TYPE_VIDEO)) {
 		pr_err("cannot register capture v4l2 device. skipping.\n");
 		return -1;
 	}
diff --git a/drivers/media/pci/saa7146/mxb.c b/drivers/media/pci/saa7146/mxb.c
index 58fe4c1619eeb..bf0b9b0914cd5 100644
--- a/drivers/media/pci/saa7146/mxb.c
+++ b/drivers/media/pci/saa7146/mxb.c
@@ -714,7 +714,7 @@ static int mxb_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data
 	vv_data.vid_ops.vidioc_g_register = vidioc_g_register;
 	vv_data.vid_ops.vidioc_s_register = vidioc_s_register;
 #endif
-	if (saa7146_register_device(&mxb->video_dev, dev, "mxb", VFL_TYPE_GRABBER)) {
+	if (saa7146_register_device(&mxb->video_dev, dev, "mxb", VFL_TYPE_VIDEO)) {
 		ERR("cannot register capture v4l2 device. skipping.\n");
 		saa7146_vv_release(dev);
 		return -1;
diff --git a/drivers/media/pci/saa7164/saa7164-encoder.c b/drivers/media/pci/saa7164/saa7164-encoder.c
index df494644b5b64..1d1d32e043f16 100644
--- a/drivers/media/pci/saa7164/saa7164-encoder.c
+++ b/drivers/media/pci/saa7164/saa7164-encoder.c
@@ -1087,7 +1087,7 @@ int saa7164_encoder_register(struct saa7164_port *port)
 	v4l2_ctrl_handler_setup(hdl);
 	video_set_drvdata(port->v4l_device, port);
 	result = video_register_device(port->v4l_device,
-		VFL_TYPE_GRABBER, -1);
+		VFL_TYPE_VIDEO, -1);
 	if (result < 0) {
 		printk(KERN_INFO "%s: can't register mpeg device\n",
 			dev->name);
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
index 476d7f3b32d63..cbf85231b708f 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
@@ -1304,7 +1304,7 @@ static struct solo_enc_dev *solo_enc_alloc(struct solo_dev *solo_dev,
 	solo_enc->vfd->queue = &solo_enc->vidq;
 	solo_enc->vfd->lock = &solo_enc->lock;
 	video_set_drvdata(solo_enc->vfd, solo_enc);
-	ret = video_register_device(solo_enc->vfd, VFL_TYPE_GRABBER, nr);
+	ret = video_register_device(solo_enc->vfd, VFL_TYPE_VIDEO, nr);
 	if (ret < 0)
 		goto vdev_release;
 
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2.c b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
index 78792067e920f..54434f3c428d0 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
@@ -692,7 +692,7 @@ int solo_v4l2_init(struct solo_dev *solo_dev, unsigned nr)
 	while (erase_off(solo_dev))
 		/* Do nothing */;
 
-	ret = video_register_device(solo_dev->vfd, VFL_TYPE_GRABBER, nr);
+	ret = video_register_device(solo_dev->vfd, VFL_TYPE_VIDEO, nr);
 	if (ret < 0)
 		goto fail;
 
diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index fd3de3bb0c89b..798574cfad35e 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -1069,7 +1069,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 	vip->video_dev.lock = &vip->v4l_lock;
 	video_set_drvdata(&vip->video_dev, vip);
 
-	ret = video_register_device(&vip->video_dev, VFL_TYPE_GRABBER, -1);
+	ret = video_register_device(&vip->video_dev, VFL_TYPE_VIDEO, -1);
 	if (ret)
 		goto vrelease;
 
diff --git a/drivers/media/pci/ttpci/av7110_v4l.c b/drivers/media/pci/ttpci/av7110_v4l.c
index f3d6c3cdb8721..cabe006658ddb 100644
--- a/drivers/media/pci/ttpci/av7110_v4l.c
+++ b/drivers/media/pci/ttpci/av7110_v4l.c
@@ -831,7 +831,7 @@ int av7110_init_v4l(struct av7110 *av7110)
 	if (FW_VERSION(av7110->arm_app) < 0x2623)
 		vv_data->capabilities &= ~V4L2_CAP_SLICED_VBI_OUTPUT;
 
-	if (saa7146_register_device(&av7110->v4l_dev, dev, "av7110", VFL_TYPE_GRABBER)) {
+	if (saa7146_register_device(&av7110->v4l_dev, dev, "av7110", VFL_TYPE_VIDEO)) {
 		ERR("cannot register capture device. skipping\n");
 		saa7146_vv_release(dev);
 		return -ENODEV;
diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index e2d482af23677..3766c7aa96f44 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -1462,7 +1462,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		budget_av->has_saa7113 = 1;
 		err = saa7146_vv_init(dev, &vv_data);
 		if (err != 0) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot init vv subsystem\n");
 			return err;
 		}
@@ -1470,10 +1471,11 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
-		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_GRABBER))) {
-			/* fixme: proper cleanup here */
-			ERR("cannot register capture v4l2 device\n");
+		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
 			saa7146_vv_release(dev);
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
+			ERR("cannot register capture v4l2 device\n");
 			return err;
 		}
 
diff --git a/drivers/media/pci/tw5864/tw5864-video.c b/drivers/media/pci/tw5864/tw5864-video.c
index 656142c7a2cc7..a65114e7ca346 100644
--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -1162,7 +1162,7 @@ static int tw5864_video_input_init(struct tw5864_input *input, int video_nr)
 	input->gop = GOP_SIZE;
 	input->frame_interval = 1;
 
-	ret = video_register_device(&input->vdev, VFL_TYPE_GRABBER, video_nr);
+	ret = video_register_device(&input->vdev, VFL_TYPE_VIDEO, video_nr);
 	if (ret)
 		goto free_v4l2_hdl;
 
diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 2fb82d50c53e5..10986fcd66a55 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -962,7 +962,7 @@ int tw68_video_init2(struct tw68_dev *dev, int video_nr)
 	dev->vdev.lock = &dev->lock;
 	dev->vdev.queue = &dev->vidq;
 	video_set_drvdata(&dev->vdev, dev);
-	return video_register_device(&dev->vdev, VFL_TYPE_GRABBER, video_nr);
+	return video_register_device(&dev->vdev, VFL_TYPE_VIDEO, video_nr);
 }
 
 /*
diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
index 9be8c6e4fb693..1ced2b0ddb241 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -1282,7 +1282,7 @@ int tw686x_video_init(struct tw686x_dev *dev)
 		vc->device = vdev;
 		video_set_drvdata(vdev, vc);
 
-		err = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+		err = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 		if (err < 0)
 			goto error;
 		vc->num = vdev->num;
diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 5ae13ee9272d5..252e463cc13b4 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3989,6 +3989,10 @@ static int em28xx_usb_probe(struct usb_interface *intf,
 	 * topology will likely change after the load of the em28xx subdrivers.
 	 */
 #ifdef CONFIG_MEDIA_CONTROLLER
+	/*
+	 * No need to check the return value, the device will still be
+	 * usable without media controller API.
+	 */
 	retval = media_device_register(dev->media_dev);
 #endif
 
diff --git a/drivers/media/usb/go7007/go7007-driver.c b/drivers/media/usb/go7007/go7007-driver.c
index b9302d77d6c83..8ee0d5ea84157 100644
--- a/drivers/media/usb/go7007/go7007-driver.c
+++ b/drivers/media/usb/go7007/go7007-driver.c
@@ -80,7 +80,7 @@ static int go7007_load_encoder(struct go7007 *go)
 	const struct firmware *fw_entry;
 	char fw_name[] = "go7007/go7007fw.bin";
 	void *bounce;
-	int fw_len, rv = 0;
+	int fw_len;
 	u16 intr_val, intr_data;
 
 	if (go->boot_fw == NULL) {
@@ -109,9 +109,11 @@ static int go7007_load_encoder(struct go7007 *go)
 	    go7007_read_interrupt(go, &intr_val, &intr_data) < 0 ||
 			(intr_val & ~0x1) != 0x5a5a) {
 		v4l2_err(go, "error transferring firmware\n");
-		rv = -1;
+		kfree(go->boot_fw);
+		go->boot_fw = NULL;
+		return -1;
 	}
-	return rv;
+	return 0;
 }
 
 MODULE_FIRMWARE("go7007/go7007fw.bin");
diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go7007/go7007-usb.c
index f889c9d740cd1..1cfe8371511d0 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1198,7 +1198,9 @@ static int go7007_usb_probe(struct usb_interface *intf,
 				u16 channel;
 
 				/* read channel number from GPIO[1:0] */
-				go7007_read_addr(go, 0x3c81, &channel);
+				if (go7007_read_addr(go, 0x3c81, &channel))
+					goto allocfail;
+
 				channel &= 0x3;
 				go->board_id = GO7007_BOARDID_ADLINK_MPG24;
 				usb->board = board = &board_adlink_mpg24;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98bc..73c95ba2328a4 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -90,8 +90,10 @@ static void pvr2_context_destroy(struct pvr2_context *mp)
 }
 
 
-static void pvr2_context_notify(struct pvr2_context *mp)
+static void pvr2_context_notify(void *ptr)
 {
+	struct pvr2_context *mp = ptr;
+
 	pvr2_context_set_notify(mp,!0);
 }
 
@@ -106,9 +108,7 @@ static void pvr2_context_check(struct pvr2_context *mp)
 		pvr2_trace(PVR2_TRACE_CTXT,
 			   "pvr2_context %p (initialize)", mp);
 		/* Finish hardware initialization */
-		if (pvr2_hdw_initialize(mp->hdw,
-					(void (*)(void *))pvr2_context_notify,
-					mp)) {
+		if (pvr2_hdw_initialize(mp->hdw, pvr2_context_notify, mp)) {
 			mp->video_stream.stream =
 				pvr2_hdw_get_video_stream(mp->hdw);
 			/* Trigger interface initialization.  By doing this
@@ -267,9 +267,9 @@ static void pvr2_context_exit(struct pvr2_context *mp)
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
-	mp->disconnect_flag = !0;
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
+	mp->disconnect_flag = !0;
 }
 
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
index 6954584526a32..1b768e7466721 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
@@ -88,8 +88,10 @@ static int pvr2_dvb_feed_thread(void *data)
 	return stat;
 }
 
-static void pvr2_dvb_notify(struct pvr2_dvb_adapter *adap)
+static void pvr2_dvb_notify(void *ptr)
 {
+	struct pvr2_dvb_adapter *adap = ptr;
+
 	wake_up(&adap->buffer_wait_data);
 }
 
@@ -149,7 +151,7 @@ static int pvr2_dvb_stream_do_start(struct pvr2_dvb_adapter *adap)
 	}
 
 	pvr2_stream_set_callback(pvr->video_stream.stream,
-				 (pvr2_stream_callback) pvr2_dvb_notify, adap);
+				 pvr2_dvb_notify, adap);
 
 	ret = pvr2_stream_set_buffer_count(stream, PVR2_DVB_BUFFER_COUNT);
 	if (ret < 0) return ret;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index eaa08c7999d4f..f8da501689c32 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1037,8 +1037,10 @@ static int pvr2_v4l2_open(struct file *file)
 }
 
 
-static void pvr2_v4l2_notify(struct pvr2_v4l2_fh *fhp)
+static void pvr2_v4l2_notify(void *ptr)
 {
+	struct pvr2_v4l2_fh *fhp = ptr;
+
 	wake_up(&fhp->wait_data);
 }
 
@@ -1071,7 +1073,7 @@ static int pvr2_v4l2_iosetup(struct pvr2_v4l2_fh *fh)
 
 	hdw = fh->channel.mc_head->hdw;
 	sp = fh->pdi->stream->stream;
-	pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
+	pvr2_stream_set_callback(sp, pvr2_v4l2_notify, fh);
 	pvr2_hdw_set_stream_type(hdw,fh->pdi->config);
 	if ((ret = pvr2_hdw_set_streaming(hdw,!0)) < 0) return ret;
 	return pvr2_ioread_set_enabled(fh->rhp,!0);
@@ -1202,11 +1204,6 @@ static void pvr2_v4l2_dev_init(struct pvr2_v4l2_dev *dip,
 		dip->minor_type = pvr2_v4l_type_video;
 		nr_ptr = video_nr;
 		caps |= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_AUDIO;
-		if (!dip->stream) {
-			pr_err(KBUILD_MODNAME
-				": Failed to set up pvrusb2 v4l video dev due to missing stream instance\n");
-			return;
-		}
 		break;
 	case VFL_TYPE_VBI:
 		dip->config = pvr2_config_vbi;
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 4037689a945a5..ddc861868ce08 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -533,13 +533,23 @@ static int get_index(struct video_device *vdev)
  */
 static void determine_valid_ioctls(struct video_device *vdev)
 {
+	const u32 vid_caps = V4L2_CAP_VIDEO_CAPTURE |
+			     V4L2_CAP_VIDEO_CAPTURE_MPLANE |
+			     V4L2_CAP_VIDEO_OUTPUT |
+			     V4L2_CAP_VIDEO_OUTPUT_MPLANE |
+			     V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE;
+	const u32 meta_caps = V4L2_CAP_META_CAPTURE |
+			      V4L2_CAP_META_OUTPUT;
 	DECLARE_BITMAP(valid_ioctls, BASE_VIDIOC_PRIVATE);
 	const struct v4l2_ioctl_ops *ops = vdev->ioctl_ops;
-	bool is_vid = vdev->vfl_type == VFL_TYPE_GRABBER;
+	bool is_vid = vdev->vfl_type == VFL_TYPE_VIDEO &&
+		      (vdev->device_caps & vid_caps);
 	bool is_vbi = vdev->vfl_type == VFL_TYPE_VBI;
 	bool is_radio = vdev->vfl_type == VFL_TYPE_RADIO;
 	bool is_sdr = vdev->vfl_type == VFL_TYPE_SDR;
 	bool is_tch = vdev->vfl_type == VFL_TYPE_TOUCH;
+	bool is_meta = vdev->vfl_type == VFL_TYPE_VIDEO &&
+		       (vdev->device_caps & meta_caps);
 	bool is_rx = vdev->vfl_dir != VFL_DIR_TX;
 	bool is_tx = vdev->vfl_dir != VFL_DIR_RX;
 
@@ -587,39 +597,31 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		set_bit(_IOC_NR(VIDIOC_ENUM_FREQ_BANDS), valid_ioctls);
 
 	if (is_vid || is_tch) {
-		/* video and metadata specific ioctls */
+		/* video and touch specific ioctls */
 		if ((is_rx && (ops->vidioc_enum_fmt_vid_cap ||
-			       ops->vidioc_enum_fmt_vid_overlay ||
-			       ops->vidioc_enum_fmt_meta_cap)) ||
-		    (is_tx && (ops->vidioc_enum_fmt_vid_out ||
-			       ops->vidioc_enum_fmt_meta_out)))
+			       ops->vidioc_enum_fmt_vid_overlay)) ||
+		    (is_tx && ops->vidioc_enum_fmt_vid_out))
 			set_bit(_IOC_NR(VIDIOC_ENUM_FMT), valid_ioctls);
 		if ((is_rx && (ops->vidioc_g_fmt_vid_cap ||
 			       ops->vidioc_g_fmt_vid_cap_mplane ||
-			       ops->vidioc_g_fmt_vid_overlay ||
-			       ops->vidioc_g_fmt_meta_cap)) ||
+			       ops->vidioc_g_fmt_vid_overlay)) ||
 		    (is_tx && (ops->vidioc_g_fmt_vid_out ||
 			       ops->vidioc_g_fmt_vid_out_mplane ||
-			       ops->vidioc_g_fmt_vid_out_overlay ||
-			       ops->vidioc_g_fmt_meta_out)))
+			       ops->vidioc_g_fmt_vid_out_overlay)))
 			 set_bit(_IOC_NR(VIDIOC_G_FMT), valid_ioctls);
 		if ((is_rx && (ops->vidioc_s_fmt_vid_cap ||
 			       ops->vidioc_s_fmt_vid_cap_mplane ||
-			       ops->vidioc_s_fmt_vid_overlay ||
-			       ops->vidioc_s_fmt_meta_cap)) ||
+			       ops->vidioc_s_fmt_vid_overlay)) ||
 		    (is_tx && (ops->vidioc_s_fmt_vid_out ||
 			       ops->vidioc_s_fmt_vid_out_mplane ||
-			       ops->vidioc_s_fmt_vid_out_overlay ||
-			       ops->vidioc_s_fmt_meta_out)))
+			       ops->vidioc_s_fmt_vid_out_overlay)))
 			 set_bit(_IOC_NR(VIDIOC_S_FMT), valid_ioctls);
 		if ((is_rx && (ops->vidioc_try_fmt_vid_cap ||
 			       ops->vidioc_try_fmt_vid_cap_mplane ||
-			       ops->vidioc_try_fmt_vid_overlay ||
-			       ops->vidioc_try_fmt_meta_cap)) ||
+			       ops->vidioc_try_fmt_vid_overlay)) ||
 		    (is_tx && (ops->vidioc_try_fmt_vid_out ||
 			       ops->vidioc_try_fmt_vid_out_mplane ||
-			       ops->vidioc_try_fmt_vid_out_overlay ||
-			       ops->vidioc_try_fmt_meta_out)))
+			       ops->vidioc_try_fmt_vid_out_overlay)))
 			 set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
 		SET_VALID_IOCTL(ops, VIDIOC_OVERLAY, vidioc_overlay);
 		SET_VALID_IOCTL(ops, VIDIOC_G_FBUF, vidioc_g_fbuf);
@@ -641,7 +643,21 @@ static void determine_valid_ioctls(struct video_device *vdev)
 			set_bit(_IOC_NR(VIDIOC_S_CROP), valid_ioctls);
 		SET_VALID_IOCTL(ops, VIDIOC_G_SELECTION, vidioc_g_selection);
 		SET_VALID_IOCTL(ops, VIDIOC_S_SELECTION, vidioc_s_selection);
-	} else if (is_vbi) {
+	}
+	if (is_meta && is_rx) {
+		/* metadata capture specific ioctls */
+		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_meta_cap);
+		SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_meta_cap);
+		SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_meta_cap);
+		SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_meta_cap);
+	} else if (is_meta && is_tx) {
+		/* metadata output specific ioctls */
+		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_meta_out);
+		SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_meta_out);
+		SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_meta_out);
+		SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_meta_out);
+	}
+	if (is_vbi) {
 		/* vbi specific ioctls */
 		if ((is_rx && (ops->vidioc_g_fmt_vbi_cap ||
 			       ops->vidioc_g_fmt_sliced_vbi_cap)) ||
@@ -681,8 +697,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
 			set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
 	}
 
-	if (is_vid || is_vbi || is_sdr || is_tch) {
-		/* ioctls valid for video, metadata, vbi or sdr */
+	if (is_vid || is_vbi || is_sdr || is_tch || is_meta) {
+		/* ioctls valid for video, vbi, sdr, touch and metadata */
 		SET_VALID_IOCTL(ops, VIDIOC_REQBUFS, vidioc_reqbufs);
 		SET_VALID_IOCTL(ops, VIDIOC_QUERYBUF, vidioc_querybuf);
 		SET_VALID_IOCTL(ops, VIDIOC_QBUF, vidioc_qbuf);
@@ -694,8 +710,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, vidioc_streamoff);
 	}
 
-	if (is_vid || is_vbi || is_tch) {
-		/* ioctls valid for video or vbi */
+	if (is_vid || is_vbi || is_tch || is_meta) {
+		/* ioctls valid for video, vbi, touch and metadata */
 		if (ops->vidioc_s_std)
 			set_bit(_IOC_NR(VIDIOC_ENUMSTD), valid_ioctls);
 		SET_VALID_IOCTL(ops, VIDIOC_S_STD, vidioc_s_std);
@@ -761,7 +777,7 @@ static int video_register_media_controller(struct video_device *vdev)
 	vdev->entity.function = MEDIA_ENT_F_UNKNOWN;
 
 	switch (vdev->vfl_type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		intf_type = MEDIA_INTF_T_V4L_VIDEO;
 		vdev->entity.function = MEDIA_ENT_F_IO_V4L;
 		break;
@@ -869,7 +885,7 @@ int __video_register_device(struct video_device *vdev,
 
 	/* Part 1: check device type */
 	switch (type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		name_base = "video";
 		break;
 	case VFL_TYPE_VBI:
@@ -913,7 +929,7 @@ int __video_register_device(struct video_device *vdev,
 	 * of 128-191 and just pick the first free minor there
 	 * (new style). */
 	switch (type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		minor_offset = 0;
 		minor_cnt = 64;
 		break;
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 3012e8ecffb94..682ba53b1a7a7 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -950,12 +950,22 @@ static bool check_ext_ctrls(struct v4l2_ext_controls *c, unsigned long ioctl)
 
 static int check_fmt(struct file *file, enum v4l2_buf_type type)
 {
+	const u32 vid_caps = V4L2_CAP_VIDEO_CAPTURE |
+			     V4L2_CAP_VIDEO_CAPTURE_MPLANE |
+			     V4L2_CAP_VIDEO_OUTPUT |
+			     V4L2_CAP_VIDEO_OUTPUT_MPLANE |
+			     V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE;
+	const u32 meta_caps = V4L2_CAP_META_CAPTURE |
+			      V4L2_CAP_META_OUTPUT;
 	struct video_device *vfd = video_devdata(file);
 	const struct v4l2_ioctl_ops *ops = vfd->ioctl_ops;
-	bool is_vid = vfd->vfl_type == VFL_TYPE_GRABBER;
+	bool is_vid = vfd->vfl_type == VFL_TYPE_VIDEO &&
+		      (vfd->device_caps & vid_caps);
 	bool is_vbi = vfd->vfl_type == VFL_TYPE_VBI;
 	bool is_sdr = vfd->vfl_type == VFL_TYPE_SDR;
 	bool is_tch = vfd->vfl_type == VFL_TYPE_TOUCH;
+	bool is_meta = vfd->vfl_type == VFL_TYPE_VIDEO &&
+		       (vfd->device_caps & meta_caps);
 	bool is_rx = vfd->vfl_dir != VFL_DIR_TX;
 	bool is_tx = vfd->vfl_dir != VFL_DIR_RX;
 
@@ -1014,11 +1024,11 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
 			return 0;
 		break;
 	case V4L2_BUF_TYPE_META_CAPTURE:
-		if (is_vid && is_rx && ops->vidioc_g_fmt_meta_cap)
+		if (is_meta && is_rx && ops->vidioc_g_fmt_meta_cap)
 			return 0;
 		break;
 	case V4L2_BUF_TYPE_META_OUTPUT:
-		if (is_vid && is_tx && ops->vidioc_g_fmt_meta_out)
+		if (is_meta && is_tx && ops->vidioc_g_fmt_meta_out)
 			return 0;
 		break;
 	default:
diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index d56837c04a81a..b374c9fab4b9e 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -799,11 +799,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
 	entity->function = function;
 
 	ret = media_entity_pads_init(entity, num_pads, pads);
-	if (ret)
+	if (ret) {
+		kfree(entity->name);
+		entity->name = NULL;
 		return ret;
+	}
 	ret = media_device_register_entity(mdev, entity);
-	if (ret)
+	if (ret) {
+		kfree(entity->name);
+		entity->name = NULL;
 		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index d2a13a547a3ca..5610a5d9fad12 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -109,7 +109,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
 					    (void *)sysmgr_np);
-	of_node_put(sysmgr_np);
+	if (property)
+		of_node_put(sysmgr_np);
+
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 660723276481c..9ec90ce12f4d7 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -219,7 +219,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 
 	regmap = syscon_node_to_regmap(syscon_np);
-	of_node_put(syscon_np);
+
+	if (property)
+		of_node_put(syscon_np);
 
 	return regmap;
 }
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index b1e4199f82920..345b3c50f27dd 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -889,7 +889,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -917,9 +916,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index e4f72b2df8039..fa7e1c0b70c64 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -505,7 +505,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (!info->maps[i].phys)
 			info->maps[i].phys = res->start;
 
-		info->win_order = get_bitmask_order(resource_size(res)) - 1;
+		info->win_order = fls64(resource_size(res)) - 1;
 		info->maps[i].size = BIT(info->win_order +
 					 (info->gpios ?
 					  info->gpios->ndescs : 0));
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 78b31f845c50a..a7d0a76eee7f4 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -304,8 +304,9 @@ static int lpc32xx_nand_device_ready(struct nand_chip *nand_chip)
 	return 0;
 }
 
-static irqreturn_t lpc3xxx_nand_irq(int irq, struct lpc32xx_nand_host *host)
+static irqreturn_t lpc3xxx_nand_irq(int irq, void *data)
 {
+	struct lpc32xx_nand_host *host = data;
 	uint8_t sr;
 
 	/* Clear interrupt flag by reading status */
@@ -778,7 +779,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto release_dma_chan;
 	}
 
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+	if (request_irq(host->irq, &lpc3xxx_nand_irq,
 			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
 		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
 		res = -ENXIO;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 9225733f4fece..29700fee42e9d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -375,7 +375,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		io_sq->bounce_buf_ctrl.next_to_use = 0;
 
 		size = io_sq->bounce_buf_ctrl.buffer_size *
-			 io_sq->bounce_buf_ctrl.buffers_num;
+			io_sq->bounce_buf_ctrl.buffers_num;
 
 		dev_node = dev_to_node(ena_dev->dmadev);
 		set_dev_node(ena_dev->dmadev, ctx->numa_node);
@@ -702,8 +702,7 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 		/* The desc list entry size should be whole multiply of 8
 		 * This requirement comes from __iowrite64_copy()
 		 */
-		pr_err("illegal entry size %d\n",
-		       llq_info->desc_list_entry_size);
+		pr_err("illegal entry size %d\n", llq_info->desc_list_entry_size);
 		return -EINVAL;
 	}
 
@@ -2063,8 +2062,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *dev, void *data)
 
 	/* write the aenq doorbell after all AENQ descriptors were read */
 	mb();
-	writel_relaxed((u32)aenq->head,
-		       dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
+	writel_relaxed((u32)aenq->head, dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
 }
 
 int ena_com_dev_reset(struct ena_com_dev *ena_dev,
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 2e5348ec2a2e9..8e2e0c3bee0b9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2385,24 +2385,7 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static u16 ena_select_queue(struct net_device *dev, struct sk_buff *skb,
-			    struct net_device *sb_dev)
-{
-	u16 qid;
-	/* we suspect that this is good for in--kernel network services that
-	 * want to loop incoming skb rx to tx in normal user generated traffic,
-	 * most probably we will not get to this
-	 */
-	if (skb_rx_queue_recorded(skb))
-		qid = skb_get_rx_queue(skb);
-	else
-		qid = netdev_pick_tx(dev, skb, NULL);
-
-	return qid;
-}
-
-static void ena_config_host_info(struct ena_com_dev *ena_dev,
-				 struct pci_dev *pdev)
+static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pdev)
 {
 	struct ena_admin_host_info *host_info;
 	int rc;
@@ -2550,7 +2533,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_open		= ena_open,
 	.ndo_stop		= ena_close,
 	.ndo_start_xmit		= ena_start_xmit,
-	.ndo_select_queue	= ena_select_queue,
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 3f63ffd7561bf..d17731cae8634 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1004,9 +1004,6 @@ static inline void bnx2x_set_fw_mac_addr(__le16 *fw_hi, __le16 *fw_mid,
 static inline void bnx2x_free_rx_mem_pool(struct bnx2x *bp,
 					  struct bnx2x_alloc_pool *pool)
 {
-	if (!pool->page)
-		return;
-
 	put_page(pool->page);
 
 	pool->page = NULL;
@@ -1017,6 +1014,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6b2d54c972b7c..f5956977fe39a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2588,7 +2588,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	int ret;
 
 	hdev->support_sfp_query = true;
-	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
+	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
 	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
 					 hdev->hw.mac.duplex);
 	if (ret) {
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6638d314c811c..cceff1515ea1d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6479,77 +6479,75 @@ void igb_update_stats(struct igb_adapter *adapter)
 	}
 }
 
+static void igb_perout(struct igb_adapter *adapter, int tsintr_tt)
+{
+	int pin = ptp_find_pin(adapter->ptp_clock, PTP_PF_PEROUT, tsintr_tt);
+	struct e1000_hw *hw = &adapter->hw;
+	struct timespec64 ts;
+	u32 tsauxc;
+
+	if (pin < 0 || pin >= IGB_N_PEROUT)
+		return;
+
+	spin_lock(&adapter->tmreg_lock);
+	ts = timespec64_add(adapter->perout[pin].start,
+			    adapter->perout[pin].period);
+	/* u32 conversion of tv_sec is safe until y2106 */
+	wr32((tsintr_tt == 1) ? E1000_TRGTTIML1 : E1000_TRGTTIML0, ts.tv_nsec);
+	wr32((tsintr_tt == 1) ? E1000_TRGTTIMH1 : E1000_TRGTTIMH0, (u32)ts.tv_sec);
+	tsauxc = rd32(E1000_TSAUXC);
+	tsauxc |= TSAUXC_EN_TT0;
+	wr32(E1000_TSAUXC, tsauxc);
+	adapter->perout[pin].start = ts;
+	spin_unlock(&adapter->tmreg_lock);
+}
+
+static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
+{
+	int pin = ptp_find_pin(adapter->ptp_clock, PTP_PF_EXTTS, tsintr_tt);
+	struct e1000_hw *hw = &adapter->hw;
+	struct ptp_clock_event event;
+	u32 sec, nsec;
+
+	if (pin < 0 || pin >= IGB_N_EXTTS)
+		return;
+
+	nsec = rd32((tsintr_tt == 1) ? E1000_AUXSTMPL1 : E1000_AUXSTMPL0);
+	sec  = rd32((tsintr_tt == 1) ? E1000_AUXSTMPH1 : E1000_AUXSTMPH0);
+	event.type = PTP_CLOCK_EXTTS;
+	event.index = tsintr_tt;
+	event.timestamp = sec * 1000000000ULL + nsec;
+	ptp_clock_event(adapter->ptp_clock, &event);
+}
+
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
-	struct timespec64 ts;
-	u32 ack = 0, tsauxc, sec, nsec, tsicr = rd32(E1000_TSICR);
 
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
 			ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= TSINTR_SYS_WRAP;
 	}
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
 		schedule_work(&adapter->ptp_tx_work);
-		ack |= E1000_TSICR_TXTS;
-	}
-
-	if (tsicr & TSINTR_TT0) {
-		spin_lock(&adapter->tmreg_lock);
-		ts = timespec64_add(adapter->perout[0].start,
-				    adapter->perout[0].period);
-		/* u32 conversion of tv_sec is safe until y2106 */
-		wr32(E1000_TRGTTIML0, ts.tv_nsec);
-		wr32(E1000_TRGTTIMH0, (u32)ts.tv_sec);
-		tsauxc = rd32(E1000_TSAUXC);
-		tsauxc |= TSAUXC_EN_TT0;
-		wr32(E1000_TSAUXC, tsauxc);
-		adapter->perout[0].start = ts;
-		spin_unlock(&adapter->tmreg_lock);
-		ack |= TSINTR_TT0;
-	}
-
-	if (tsicr & TSINTR_TT1) {
-		spin_lock(&adapter->tmreg_lock);
-		ts = timespec64_add(adapter->perout[1].start,
-				    adapter->perout[1].period);
-		wr32(E1000_TRGTTIML1, ts.tv_nsec);
-		wr32(E1000_TRGTTIMH1, (u32)ts.tv_sec);
-		tsauxc = rd32(E1000_TSAUXC);
-		tsauxc |= TSAUXC_EN_TT1;
-		wr32(E1000_TSAUXC, tsauxc);
-		adapter->perout[1].start = ts;
-		spin_unlock(&adapter->tmreg_lock);
-		ack |= TSINTR_TT1;
-	}
-
-	if (tsicr & TSINTR_AUTT0) {
-		nsec = rd32(E1000_AUXSTMPL0);
-		sec  = rd32(E1000_AUXSTMPH0);
-		event.type = PTP_CLOCK_EXTTS;
-		event.index = 0;
-		event.timestamp = sec * 1000000000ULL + nsec;
-		ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= TSINTR_AUTT0;
-	}
-
-	if (tsicr & TSINTR_AUTT1) {
-		nsec = rd32(E1000_AUXSTMPL1);
-		sec  = rd32(E1000_AUXSTMPH1);
-		event.type = PTP_CLOCK_EXTTS;
-		event.index = 1;
-		event.timestamp = sec * 1000000000ULL + nsec;
-		ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= TSINTR_AUTT1;
-	}
-
-	/* acknowledge the interrupts */
-	wr32(E1000_TSICR, ack);
+	}
+
+	if (tsicr & TSINTR_TT0)
+		igb_perout(adapter, 0);
+
+	if (tsicr & TSINTR_TT1)
+		igb_perout(adapter, 1);
+
+	if (tsicr & TSINTR_AUTT0)
+		igb_extts(adapter, 0);
+
+	if (tsicr & TSINTR_AUTT1)
+		igb_extts(adapter, 1);
 }
 
 static irqreturn_t igb_msix_other(int irq, void *data)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 54e9f6dc24ea0..910ed148e827e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -582,7 +582,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 02b4620f7368a..9c6307186505a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1708,10 +1708,9 @@ static void rvu_queue_work(struct mbox_wq_info *mw, int first,
 	}
 }
 
-static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq)
 {
 	struct rvu *rvu = (struct rvu *)rvu_irq;
-	int vfs = rvu->vfs;
 	u64 intr;
 
 	intr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT);
@@ -1723,6 +1722,18 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 
 	rvu_queue_work(&rvu->afpf_wq_info, 0, rvu->hw->total_pfs, intr);
 
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	int vfs = rvu->vfs;
+	u64 intr;
+
+	/* Sync with mbox memory region */
+	rmb();
+
 	/* Handle VF interrupts */
 	if (vfs > 64) {
 		intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(1));
@@ -2035,7 +2046,7 @@ static int rvu_register_interrupts(struct rvu *rvu)
 	/* Register mailbox interrupt handler */
 	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
 	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu_mbox_intr_handler, 0,
+			  rvu_mbox_pf_intr_handler, 0,
 			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
 	if (ret) {
 		dev_err(rvu->dev,
diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 63907aeb3884e..3167f9675ae0f 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -308,6 +308,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work,
+					      NFP_FL_LAG_DELAY);
+			continue;
+		}
 
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 681e0def6356b..a5332e99102a5 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -736,7 +736,9 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	data->eeprom_len = SR9800_EEPROM_LEN;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* LED Setting Rule :
 	 * AABB:CCDD
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 315d20f5c8eb1..ee1c86bb5078b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -707,6 +707,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
 	}
 
 	ev = tb[WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return -EPROTO;
+	}
 
 	arg->desc_id = ev->desc_id;
 	arg->status = ev->status;
diff --git a/drivers/net/wireless/broadcom/b43/b43.h b/drivers/net/wireless/broadcom/b43/b43.h
index 67b4bac048e58..c0d8fc0b22fb2 100644
--- a/drivers/net/wireless/broadcom/b43/b43.h
+++ b/drivers/net/wireless/broadcom/b43/b43.h
@@ -1082,6 +1082,22 @@ static inline bool b43_using_pio_transfers(struct b43_wldev *dev)
 	return dev->__using_pio_transfers;
 }
 
+static inline void b43_wake_queue(struct b43_wldev *dev, int queue_prio)
+{
+	if (dev->qos_enabled)
+		ieee80211_wake_queue(dev->wl->hw, queue_prio);
+	else
+		ieee80211_wake_queue(dev->wl->hw, 0);
+}
+
+static inline void b43_stop_queue(struct b43_wldev *dev, int queue_prio)
+{
+	if (dev->qos_enabled)
+		ieee80211_stop_queue(dev->wl->hw, queue_prio);
+	else
+		ieee80211_stop_queue(dev->wl->hw, 0);
+}
+
 /* Message printing */
 __printf(2, 3) void b43info(struct b43_wl *wl, const char *fmt, ...);
 __printf(2, 3) void b43err(struct b43_wl *wl, const char *fmt, ...);
diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 72bf07540da39..19624133b64ad 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1399,8 +1399,8 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	    should_inject_overflow(ring)) {
 		/* This TX ring is full. */
 		unsigned int skb_mapping = skb_get_queue_mapping(skb);
-		ieee80211_stop_queue(dev->wl->hw, skb_mapping);
-		dev->wl->tx_queue_stopped[skb_mapping] = 1;
+		b43_stop_queue(dev, skb_mapping);
+		dev->wl->tx_queue_stopped[skb_mapping] = true;
 		ring->stopped = true;
 		if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
 			b43dbg(dev->wl, "Stopped TX ring %d\n", ring->index);
@@ -1566,11 +1566,11 @@ void b43_dma_handle_txstatus(struct b43_wldev *dev,
 	}
 
 	if (dev->wl->tx_queue_stopped[ring->queue_prio]) {
-		dev->wl->tx_queue_stopped[ring->queue_prio] = 0;
+		dev->wl->tx_queue_stopped[ring->queue_prio] = false;
 	} else {
 		/* If the driver queue is running wake the corresponding
 		 * mac80211 queue. */
-		ieee80211_wake_queue(dev->wl->hw, ring->queue_prio);
+		b43_wake_queue(dev, ring->queue_prio);
 		if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
 			b43dbg(dev->wl, "Woke up TX ring %d\n", ring->index);
 		}
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 3432dfe1ddb47..e466324a1fd24 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2585,7 +2585,8 @@ static void b43_request_firmware(struct work_struct *work)
 
 start_ieee80211:
 	wl->hw->queues = B43_QOS_QUEUE_NUM;
-	if (!modparam_qos || dev->fw.opensource)
+	if (!modparam_qos || dev->fw.opensource ||
+	    dev->dev->chip_id == BCMA_CHIP_ID_BCM4331)
 		wl->hw->queues = 1;
 
 	err = ieee80211_register_hw(wl->hw);
@@ -3600,8 +3601,8 @@ static void b43_tx_work(struct work_struct *work)
 			else
 				err = b43_dma_tx(dev, skb);
 			if (err == -ENOSPC) {
-				wl->tx_queue_stopped[queue_num] = 1;
-				ieee80211_stop_queue(wl->hw, queue_num);
+				wl->tx_queue_stopped[queue_num] = true;
+				b43_stop_queue(dev, queue_num);
 				skb_queue_head(&wl->tx_queue[queue_num], skb);
 				break;
 			}
@@ -3611,7 +3612,7 @@ static void b43_tx_work(struct work_struct *work)
 		}
 
 		if (!err)
-			wl->tx_queue_stopped[queue_num] = 0;
+			wl->tx_queue_stopped[queue_num] = false;
 	}
 
 #if B43_DEBUG
@@ -3625,6 +3626,7 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 		      struct sk_buff *skb)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
+	u16 skb_queue_mapping;
 
 	if (unlikely(skb->len < 2 + 2 + 6)) {
 		/* Too short, this can't be a valid frame. */
@@ -3633,12 +3635,12 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 	}
 	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
 
-	skb_queue_tail(&wl->tx_queue[skb->queue_mapping], skb);
-	if (!wl->tx_queue_stopped[skb->queue_mapping]) {
+	skb_queue_mapping = skb_get_queue_mapping(skb);
+	skb_queue_tail(&wl->tx_queue[skb_queue_mapping], skb);
+	if (!wl->tx_queue_stopped[skb_queue_mapping])
 		ieee80211_queue_work(wl->hw, &wl->tx_work);
-	} else {
-		ieee80211_stop_queue(wl->hw, skb->queue_mapping);
-	}
+	else
+		b43_stop_queue(wl->current_dev, skb_queue_mapping);
 }
 
 static void b43_qos_params_upload(struct b43_wldev *dev,
@@ -5603,7 +5605,7 @@ static struct b43_wl *b43_wireless_init(struct b43_bus_dev *dev)
 	/* Initialize queues and flags. */
 	for (queue_num = 0; queue_num < B43_QOS_QUEUE_NUM; queue_num++) {
 		skb_queue_head_init(&wl->tx_queue[queue_num]);
-		wl->tx_queue_stopped[queue_num] = 0;
+		wl->tx_queue_stopped[queue_num] = false;
 	}
 
 	snprintf(chip_name, ARRAY_SIZE(chip_name),
diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless/broadcom/b43/pio.c
index 69f8b46c90157..468fd647d0a08 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -525,7 +525,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	if (total_len > (q->buffer_size - q->buffer_used)) {
 		/* Not enough memory on the queue. */
 		err = -EBUSY;
-		ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+		b43_stop_queue(dev, skb_get_queue_mapping(skb));
 		q->stopped = true;
 		goto out;
 	}
@@ -552,7 +552,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	if (((q->buffer_size - q->buffer_used) < roundup(2 + 2 + 6, 4)) ||
 	    (q->free_packet_slots == 0)) {
 		/* The queue is full. */
-		ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+		b43_stop_queue(dev, skb_get_queue_mapping(skb));
 		q->stopped = true;
 	}
 
@@ -587,7 +587,7 @@ void b43_pio_handle_txstatus(struct b43_wldev *dev,
 	list_add(&pack->list, &q->packets_list);
 
 	if (q->stopped) {
-		ieee80211_wake_queue(dev->wl->hw, q->queue_prio);
+		b43_wake_queue(dev, q->queue_prio);
 		q->stopped = false;
 	}
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index 2441714169de1..849c8109b3982 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -383,8 +383,9 @@ struct shared_phy *wlc_phy_shared_attach(struct shared_phy_params *shp)
 	return sh;
 }
 
-static void wlc_phy_timercb_phycal(struct brcms_phy *pi)
+static void wlc_phy_timercb_phycal(void *ptr)
 {
+	struct brcms_phy *pi = ptr;
 	uint delay = 5;
 
 	if (PHY_PERICAL_MPHASE_PENDING(pi)) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
index a0de5db0cd646..b723817915365 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
@@ -57,12 +57,11 @@ void wlc_phy_shim_detach(struct phy_shim_info *physhim)
 }
 
 struct wlapi_timer *wlapi_init_timer(struct phy_shim_info *physhim,
-				     void (*fn)(struct brcms_phy *pi),
+				     void (*fn)(void *pi),
 				     void *arg, const char *name)
 {
 	return (struct wlapi_timer *)
-			brcms_init_timer(physhim->wl, (void (*)(void *))fn,
-					 arg, name);
+			brcms_init_timer(physhim->wl, fn, arg, name);
 }
 
 void wlapi_free_timer(struct wlapi_timer *t)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
index dd8774717adee..27d0934e600ed 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
@@ -131,7 +131,7 @@ void wlc_phy_shim_detach(struct phy_shim_info *physhim);
 
 /* PHY to WL utility functions */
 struct wlapi_timer *wlapi_init_timer(struct phy_shim_info *physhim,
-				     void (*fn)(struct brcms_phy *pi),
+				     void (*fn)(void *pi),
 				     void *arg, const char *name);
 void wlapi_free_timer(struct wlapi_timer *t);
 void wlapi_add_timer(struct wlapi_timer *t, uint ms, int periodic);
diff --git a/drivers/net/wireless/marvell/libertas/cmd.c b/drivers/net/wireless/marvell/libertas/cmd.c
index a4d9dd73b2588..db9a852fa58a3 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.c
+++ b/drivers/net/wireless/marvell/libertas/cmd.c
@@ -1133,7 +1133,7 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
 		if (!cmdarray[i].cmdbuf) {
 			lbs_deb_host("ALLOC_CMD_BUF: ptempvirtualaddr is NULL\n");
 			ret = -1;
-			goto done;
+			goto free_cmd_array;
 		}
 	}
 
@@ -1141,8 +1141,17 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
 		init_waitqueue_head(&cmdarray[i].cmdwait_q);
 		lbs_cleanup_and_insert_cmd(priv, &cmdarray[i]);
 	}
-	ret = 0;
+	return 0;
 
+free_cmd_array:
+	for (i = 0; i < LBS_NUM_CMD_BUFFERS; i++) {
+		if (cmdarray[i].cmdbuf) {
+			kfree(cmdarray[i].cmdbuf);
+			cmdarray[i].cmdbuf = NULL;
+		}
+	}
+	kfree(priv->cmd_array);
+	priv->cmd_array = NULL;
 done:
 	return ret;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index e4cb7ce1c8b85..a6f4655b301d6 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -976,9 +976,6 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
 	priv->dfs_dev_dir = debugfs_create_dir(priv->netdev->name,
 					       mwifiex_dfs_dir);
 
-	if (!priv->dfs_dev_dir)
-		return;
-
 	MWIFIEX_DFS_ADD_FILE(info);
 	MWIFIEX_DFS_ADD_FILE(debug);
 	MWIFIEX_DFS_ADD_FILE(getlog);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a32ec3487a8d0..d5734a83606fb 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -195,7 +195,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 
 	for (i = 0; i < dpc->rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 821e71a45849c..3bc7058404156 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5396,6 +5396,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 0037f368f62b9..0b83252358527 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1433,7 +1433,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1454,6 +1454,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 0ad8d84aeb339..22638878c9819 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1811,7 +1811,8 @@ config RTC_DRV_MOXART
 
 config RTC_DRV_MT6397
 	tristate "MediaTek PMIC based RTC"
-	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
+	depends on MFD_MT6397 || COMPILE_TEST
+	select IRQ_DOMAIN
 	help
 	  This selects the MediaTek(R) RTC driver. RTC is part of MediaTek
 	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select
diff --git a/drivers/scsi/bfa/bfa.h b/drivers/scsi/bfa/bfa.h
index 7bd2ba1ad4d11..f30fe324e6ecc 100644
--- a/drivers/scsi/bfa/bfa.h
+++ b/drivers/scsi/bfa/bfa.h
@@ -20,7 +20,6 @@
 struct bfa_s;
 
 typedef void (*bfa_isr_func_t) (struct bfa_s *bfa, struct bfi_msg_s *m);
-typedef void (*bfa_cb_cbfn_status_t) (void *cbarg, bfa_status_t status);
 
 /*
  * Interrupt message handlers
@@ -437,4 +436,12 @@ struct bfa_cb_pending_q_s {
 	(__qe)->data = (__data);				\
 } while (0)
 
+#define bfa_pending_q_init_status(__qe, __cbfn, __cbarg, __data) do {	\
+	bfa_q_qe_init(&((__qe)->hcb_qe.qe));			\
+	(__qe)->hcb_qe.cbfn_status = (__cbfn);			\
+	(__qe)->hcb_qe.cbarg = (__cbarg);			\
+	(__qe)->hcb_qe.pre_rmv = BFA_TRUE;			\
+	(__qe)->data = (__data);				\
+} while (0)
+
 #endif /* __BFA_H__ */
diff --git a/drivers/scsi/bfa/bfa_core.c b/drivers/scsi/bfa/bfa_core.c
index 0f554ebb8f2c6..09819f076699f 100644
--- a/drivers/scsi/bfa/bfa_core.c
+++ b/drivers/scsi/bfa/bfa_core.c
@@ -1907,15 +1907,13 @@ bfa_comp_process(struct bfa_s *bfa, struct list_head *comp_q)
 	struct list_head		*qe;
 	struct list_head		*qen;
 	struct bfa_cb_qe_s	*hcb_qe;
-	bfa_cb_cbfn_status_t	cbfn;
 
 	list_for_each_safe(qe, qen, comp_q) {
 		hcb_qe = (struct bfa_cb_qe_s *) qe;
 		if (hcb_qe->pre_rmv) {
 			/* qe is invalid after return, dequeue before cbfn() */
 			list_del(qe);
-			cbfn = (bfa_cb_cbfn_status_t)(hcb_qe->cbfn);
-			cbfn(hcb_qe->cbarg, hcb_qe->fw_status);
+			hcb_qe->cbfn_status(hcb_qe->cbarg, hcb_qe->fw_status);
 		} else
 			hcb_qe->cbfn(hcb_qe->cbarg, BFA_TRUE);
 	}
diff --git a/drivers/scsi/bfa/bfa_ioc.h b/drivers/scsi/bfa/bfa_ioc.h
index 933a1c3890ff5..5e568d6d7b261 100644
--- a/drivers/scsi/bfa/bfa_ioc.h
+++ b/drivers/scsi/bfa/bfa_ioc.h
@@ -361,14 +361,18 @@ struct bfa_reqq_wait_s {
 	void	*cbarg;
 };
 
-typedef void	(*bfa_cb_cbfn_t) (void *cbarg, bfa_boolean_t complete);
+typedef void (*bfa_cb_cbfn_t) (void *cbarg, bfa_boolean_t complete);
+typedef void (*bfa_cb_cbfn_status_t) (void *cbarg, bfa_status_t status);
 
 /*
  * Generic BFA callback element.
  */
 struct bfa_cb_qe_s {
 	struct list_head	qe;
-	bfa_cb_cbfn_t	cbfn;
+	union {
+		bfa_cb_cbfn_status_t	cbfn_status;
+		bfa_cb_cbfn_t		cbfn;
+	};
 	bfa_boolean_t	once;
 	bfa_boolean_t	pre_rmv;	/* set for stack based qe(s) */
 	bfa_status_t	fw_status;	/* to access fw status in comp proc */
diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index a76c968dbac59..9f5964944d787 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -2135,8 +2135,7 @@ bfad_iocmd_fcport_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_get_stats(&bfad->bfa, &cb_qe);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
@@ -2159,7 +2158,7 @@ bfad_iocmd_fcport_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp, &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_clear_stats(&bfad->bfa, &cb_qe);
@@ -2443,8 +2442,7 @@ bfad_iocmd_qos_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
@@ -2474,8 +2472,7 @@ bfad_iocmd_qos_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
diff --git a/drivers/scsi/csiostor/csio_defs.h b/drivers/scsi/csiostor/csio_defs.h
index c38017b4af982..e50e93e7fe5a1 100644
--- a/drivers/scsi/csiostor/csio_defs.h
+++ b/drivers/scsi/csiostor/csio_defs.h
@@ -73,7 +73,21 @@ csio_list_deleted(struct list_head *list)
 #define csio_list_prev(elem)	(((struct list_head *)(elem))->prev)
 
 /* State machine */
-typedef void (*csio_sm_state_t)(void *, uint32_t);
+struct csio_lnode;
+
+/* State machine evets */
+enum csio_ln_ev {
+	CSIO_LNE_NONE = (uint32_t)0,
+	CSIO_LNE_LINKUP,
+	CSIO_LNE_FAB_INIT_DONE,
+	CSIO_LNE_LINK_DOWN,
+	CSIO_LNE_DOWN_LINK,
+	CSIO_LNE_LOGO,
+	CSIO_LNE_CLOSE,
+	CSIO_LNE_MAX_EVENT,
+};
+
+typedef void (*csio_sm_state_t)(struct csio_lnode *ln, enum csio_ln_ev evt);
 
 struct csio_sm {
 	struct list_head	sm_list;
@@ -83,7 +97,7 @@ struct csio_sm {
 static inline void
 csio_set_state(void *smp, void *state)
 {
-	((struct csio_sm *)smp)->sm_state = (csio_sm_state_t)state;
+	((struct csio_sm *)smp)->sm_state = state;
 }
 
 static inline void
diff --git a/drivers/scsi/csiostor/csio_lnode.c b/drivers/scsi/csiostor/csio_lnode.c
index c3bf590f5d685..47803268b138f 100644
--- a/drivers/scsi/csiostor/csio_lnode.c
+++ b/drivers/scsi/csiostor/csio_lnode.c
@@ -1095,7 +1095,7 @@ csio_handle_link_down(struct csio_hw *hw, uint8_t portid, uint32_t fcfi,
 int
 csio_is_lnode_ready(struct csio_lnode *ln)
 {
-	return (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_ready));
+	return (csio_get_state(ln) == csio_lns_ready);
 }
 
 /*****************************************************************************/
@@ -1367,15 +1367,15 @@ csio_free_fcfinfo(struct kref *kref)
 void
 csio_lnode_state_to_str(struct csio_lnode *ln, int8_t *str)
 {
-	if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_uninit)) {
+	if (csio_get_state(ln) == csio_lns_uninit) {
 		strcpy(str, "UNINIT");
 		return;
 	}
-	if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_ready)) {
+	if (csio_get_state(ln) == csio_lns_ready) {
 		strcpy(str, "READY");
 		return;
 	}
-	if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_offline)) {
+	if (csio_get_state(ln) == csio_lns_offline) {
 		strcpy(str, "OFFLINE");
 		return;
 	}
diff --git a/drivers/scsi/csiostor/csio_lnode.h b/drivers/scsi/csiostor/csio_lnode.h
index 372a67d122d38..607698a0f0631 100644
--- a/drivers/scsi/csiostor/csio_lnode.h
+++ b/drivers/scsi/csiostor/csio_lnode.h
@@ -53,19 +53,6 @@
 extern int csio_fcoe_rnodes;
 extern int csio_fdmi_enable;
 
-/* State machine evets */
-enum csio_ln_ev {
-	CSIO_LNE_NONE = (uint32_t)0,
-	CSIO_LNE_LINKUP,
-	CSIO_LNE_FAB_INIT_DONE,
-	CSIO_LNE_LINK_DOWN,
-	CSIO_LNE_DOWN_LINK,
-	CSIO_LNE_LOGO,
-	CSIO_LNE_CLOSE,
-	CSIO_LNE_MAX_EVENT,
-};
-
-
 struct csio_fcf_info {
 	struct list_head	list;
 	uint8_t			priority;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index e72f1dbc91f7f..04fa7337cb1ef 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6040,7 +6040,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 29d44f5d5212c..8105b458d12f7 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -559,17 +559,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(master);
 
-		cnt = mdata->xfer_len / 4;
-		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
-				trans->tx_buf + mdata->num_xfered, cnt);
+		if (trans->tx_buf) {
+			cnt = mdata->xfer_len / 4;
+			iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
+					trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = mdata->xfer_len % 4;
-		if (remainder > 0) {
-			reg_val = 0;
-			memcpy(&reg_val,
-				trans->tx_buf + (cnt * 4) + mdata->num_xfered,
-				remainder);
-			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			remainder = mdata->xfer_len % 4;
+			if (remainder > 0) {
+				reg_val = 0;
+				memcpy(&reg_val,
+					trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+					remainder);
+				writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			}
 		}
 
 		mtk_spi_enable_transfer(master);
diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index d2672b65c3f49..e59bb27236b9f 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -100,15 +100,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
 static struct gb_channel *get_channel_from_mode(struct gb_light *light,
 						u32 mode)
 {
-	struct gb_channel *channel = NULL;
+	struct gb_channel *channel;
 	int i;
 
 	for (i = 0; i < light->channels_count; i++) {
 		channel = &light->channels[i];
-		if (channel && channel->mode == mode)
-			break;
+		if (channel->mode == mode)
+			return channel;
 	}
-	return channel;
+	return NULL;
 }
 
 static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
index a15d970adb983..135e1e64c2443 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -800,6 +800,7 @@ static int ipu_csc_scaler_release(struct file *file)
 
 	dev_dbg(priv->dev, "Releasing instance %p\n", ctx);
 
+	v4l2_ctrl_handler_free(&ctx->ctrl_hdlr);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000/wilc_hif.c
index 221e3d93db148..22e02fd068b4d 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -441,38 +441,49 @@ static void handle_connect_timeout(struct work_struct *work)
 void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				struct cfg80211_crypto_settings *crypto)
 {
-	struct wilc_join_bss_param *param;
-	struct ieee80211_p2p_noa_attr noa_attr;
-	u8 rates_len = 0;
-	const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
+	const u8 *ies_data, *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
 	const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
+	struct ieee80211_p2p_noa_attr noa_attr;
+	const struct cfg80211_bss_ies *ies;
+	struct wilc_join_bss_param *param;
+	u8 rates_len = 0, ies_len;
 	int ret;
-	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
 	if (!param)
 		return NULL;
 
+	rcu_read_lock();
+	ies = rcu_dereference(bss->ies);
+	ies_data = kmemdup(ies->data, ies->len, GFP_ATOMIC);
+	if (!ies_data) {
+		rcu_read_unlock();
+		kfree(param);
+		return NULL;
+	}
+	ies_len = ies->len;
+	rcu_read_unlock();
+
 	param->beacon_period = cpu_to_le16(bss->beacon_interval);
 	param->cap_info = cpu_to_le16(bss->capability);
 	param->bss_type = WILC_FW_BSS_TYPE_INFRA;
 	param->ch = ieee80211_frequency_to_channel(bss->channel->center_freq);
 	ether_addr_copy(param->bssid, bss->bssid);
 
-	ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies->data, ies->len);
+	ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies_data, ies_len);
 	if (ssid_elm) {
 		if (ssid_elm[1] <= IEEE80211_MAX_SSID_LEN)
 			memcpy(param->ssid, ssid_elm + 2, ssid_elm[1]);
 	}
 
-	tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies->data, ies->len);
+	tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies_data, ies_len);
 	if (tim_elm && tim_elm[1] >= 2)
 		param->dtim_period = tim_elm[3];
 
 	memset(param->p_suites, 0xFF, 3);
 	memset(param->akm_suites, 0xFF, 3);
 
-	rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies->data, ies->len);
+	rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies_data, ies_len);
 	if (rates_ie) {
 		rates_len = rates_ie[1];
 		if (rates_len > WILC_MAX_RATES_SUPPORTED)
@@ -483,7 +494,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 
 	if (rates_len < WILC_MAX_RATES_SUPPORTED) {
 		supp_rates_ie = cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
-						 ies->data, ies->len);
+						 ies_data, ies_len);
 		if (supp_rates_ie) {
 			u8 ext_rates = supp_rates_ie[1];
 
@@ -498,11 +509,11 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 		}
 	}
 
-	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies->data, ies->len);
+	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies_data, ies_len);
 	if (ht_ie)
 		param->ht_capable = true;
 
-	ret = cfg80211_get_p2p_attr(ies->data, ies->len,
+	ret = cfg80211_get_p2p_attr(ies_data, ies_len,
 				    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 				    (u8 *)&noa_attr, sizeof(noa_attr));
 	if (ret > 0) {
@@ -526,7 +537,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	}
 	wmm_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
 					 WLAN_OUI_TYPE_MICROSOFT_WMM,
-					 ies->data, ies->len);
+					 ies_data, ies_len);
 	if (wmm_ie) {
 		struct ieee80211_wmm_param_ie *ie;
 
@@ -541,13 +552,13 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 
 	wpa_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
 					 WLAN_OUI_TYPE_MICROSOFT_WPA,
-					 ies->data, ies->len);
+					 ies_data, ies_len);
 	if (wpa_ie) {
 		param->mode_802_11i = 1;
 		param->rsn_found = true;
 	}
 
-	rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies->data, ies->len);
+	rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies_data, ies_len);
 	if (rsn_ie) {
 		int offset = 8;
 
@@ -570,6 +581,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 			param->akm_suites[i] = crypto->akm_suites[i] & 0xFF;
 	}
 
+	kfree(ies_data);
 	return (void *)param;
 }
 
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 93367dea4d8a5..0dfe9ceb032a5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -639,6 +639,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -653,10 +654,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
 		if (priv->line[i] >= 0)
 			serial8250_suspend_port(priv->line[i]);
 
-	/* Ensure that every init quirk is properly torn down */
-	if (priv->board->exit)
-		priv->board->exit(pcidev);
-
 	return 0;
 }
 
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2f88eae8a55a1..5570fd3b84e15 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1460,7 +1460,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 24f9bd9101662..78d97dbfc18a8 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -800,11 +800,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 		if ((ufstat & info->tx_fifomask) != 0 ||
 		    (ufstat & info->tx_fifofull))
 			return 0;
-
-		return 1;
+		return TIOCSER_TEMT;
 	}
 
-	return s3c24xx_serial_txempty_nofifo(port);
+	return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;
 }
 
 /* no modem control lines */
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e00ebda492198..171e643cf200e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2508,7 +2508,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		}
 		return;
 	case EScsiignore:
-		if (c >= 20 && c <= 0x3f)
+		if (c >= 0x20 && c <= 0x3f)
 			return;
 		vc->vc_state = ESnormal;
 		return;
diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 5980540a8fff2..de7757260d6cc 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2632,7 +2632,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 882359dd288c0..aa00379392a0f 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -117,6 +117,7 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	wleds->led_reg = platform_get_device_id(pdev)->driver_data;
 	wleds->state = DA9052_WLEDS_OFF;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = DA9052_MAX_BRIGHTNESS;
 
diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8096202fbe5d5..8d22ba62d78b0 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -227,7 +227,7 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -238,11 +238,8 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 	rval = lm3630a_read(pchip, REG_BRT_A);
 	if (rval < 0)
 		goto out_i2c_err;
-	brightness = rval;
+	return rval;
 
-out:
-	bl->props.brightness = brightness;
-	return bl->props.brightness;
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access register\n");
 	return 0;
@@ -304,7 +301,7 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -315,11 +312,8 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
 	rval = lm3630a_read(pchip, REG_BRT_B);
 	if (rval < 0)
 		goto out_i2c_err;
-	brightness = rval;
+	return rval;
 
-out:
-	bl->props.brightness = brightness;
-	return bl->props.brightness;
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access register\n");
 	return 0;
@@ -337,6 +331,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	const char *label;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 48c04155a5f9d..bb617f4673e94 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -339,6 +339,7 @@ static int lm3639_probe(struct i2c_client *client,
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index ba42f3fe0c739..d9b95dbd40d30 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 25188d6bbe152..16dd1aab7c676 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -21,6 +21,8 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
+#define DEFAULT_TIMEOUT 10
+
 /* IWDG registers */
 #define IWDG_KR		0x00 /* Key register */
 #define IWDG_PR		0x04 /* Prescaler Register */
@@ -254,6 +256,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->parent = dev;
 	wdd->info = &stm32_iwdg_info;
 	wdd->ops = &stm32_iwdg_ops;
+	wdd->timeout = DEFAULT_TIMEOUT;
 	wdd->min_timeout = DIV_ROUND_UP((RLR_MIN + 1) * PR_MIN, wdt->rate);
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
 				    1000) / wdt->rate;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1ada9b9cb21ec..43f5b972fcead 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -421,16 +421,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 			continue;
 		}
 
-		/* Don't expose silly rename entries to userspace. */
-		if (nlen > 6 &&
-		    dire->u.name[0] == '.' &&
-		    ctx->actor != afs_lookup_filldir &&
-		    ctx->actor != afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) == 0) {
-			ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
-			continue;
-		}
-
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 36ef3228bac86..63205d2f4d84c 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -392,7 +392,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 
 	block_rsv = get_block_rsv(trans, root);
 
-	if (unlikely(block_rsv->size == 0))
+	if (unlikely(btrfs_block_rsv_size(block_rsv) == 0))
 		goto try_reserve;
 again:
 	ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index d1428bb73fc5a..69770360917cb 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -98,4 +98,20 @@ static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
 	btrfs_block_rsv_release(fs_info, block_rsv, 0);
 }
 
+/*
+ * Get the size of a block reserve in a context where getting a stale value is
+ * acceptable, instead of accessing it directly and trigger data race warning
+ * from KCSAN.
+ */
+static inline u64 btrfs_block_rsv_size(struct btrfs_block_rsv *rsv)
+{
+	u64 ret;
+
+	spin_lock(&rsv->lock);
+	ret = rsv->size;
+	spin_unlock(&rsv->lock);
+
+	return ret;
+}
+
 #endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 01263ffbc4c08..9a5f153c8919e 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -37,7 +37,7 @@ static long do_sys_name_to_handle(struct path *path,
 	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
 		return -EINVAL;
 
-	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9de8961763b06..2c793e4ccf096 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -63,7 +63,6 @@
 #include <linux/net.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
-#include <net/scm.h>
 #include <linux/anon_inodes.h>
 #include <linux/sched/mm.h>
 #include <linux/uaccess.h>
@@ -264,10 +263,6 @@ struct io_ring_ctx {
 
 	struct async_list	pending_async[2];
 
-#if defined(CONFIG_UNIX)
-	struct socket		*ring_sock;
-#endif
-
 	struct list_head	task_list;
 	spinlock_t		task_lock;
 };
@@ -381,19 +376,6 @@ static struct kmem_cache *req_cachep;
 
 static const struct file_operations io_uring_fops;
 
-struct sock *io_uring_get_socket(struct file *file)
-{
-#if defined(CONFIG_UNIX)
-	if (file->f_op == &io_uring_fops) {
-		struct io_ring_ctx *ctx = file->private_data;
-
-		return ctx->ring_sock->sk;
-	}
-#endif
-	return NULL;
-}
-EXPORT_SYMBOL(io_uring_get_socket);
-
 static void io_ring_ctx_ref_free(struct percpu_ref *ref)
 {
 	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
@@ -3080,20 +3062,10 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 
 static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		struct sock *sock = ctx->ring_sock->sk;
-		struct sk_buff *skb;
-
-		while ((skb = skb_dequeue(&sock->sk_receive_queue)) != NULL)
-			kfree_skb(skb);
-	}
-#else
 	int i;
 
 	for (i = 0; i < ctx->nr_user_files; i++)
 		fput(ctx->user_files[i]);
-#endif
 }
 
 static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
@@ -3588,13 +3560,6 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sqe_files_unregister(ctx);
 	io_eventfd_unregister(ctx);
 
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		ctx->ring_sock->file = NULL; /* so that iput() is called */
-		sock_release(ctx->ring_sock);
-	}
-#endif
-
 	io_mem_free(ctx->rings);
 	io_mem_free(ctx->sq_sqes);
 
@@ -3794,6 +3759,11 @@ static const struct file_operations io_uring_fops = {
 	.fasync		= io_uring_fasync,
 };
 
+bool io_is_uring_fops(struct file *file)
+{
+	return file->f_op == &io_uring_fops;
+}
+
 static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 				  struct io_uring_params *p)
 {
@@ -3841,45 +3811,26 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 /*
  * Allocate an anonymous fd, this is what constitutes the application
  * visible backing of an io_uring instance. The application mmaps this
- * fd to gain access to the SQ/CQ ring details. If UNIX sockets are enabled,
- * we have to tie this fd to a socket for file garbage collection purposes.
+ * fd to gain access to the SQ/CQ ring details.
  */
 static int io_uring_get_fd(struct io_ring_ctx *ctx)
 {
 	struct file *file;
 	int ret;
 
-#if defined(CONFIG_UNIX)
-	ret = sock_create_kern(&init_net, PF_UNIX, SOCK_RAW, IPPROTO_IP,
-				&ctx->ring_sock);
-	if (ret)
-		return ret;
-#endif
-
 	ret = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	file = anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
 					O_RDWR | O_CLOEXEC);
 	if (IS_ERR(file)) {
 		put_unused_fd(ret);
-		ret = PTR_ERR(file);
-		goto err;
+		return PTR_ERR(file);
 	}
 
-#if defined(CONFIG_UNIX)
-	ctx->ring_sock->file = file;
-	ctx->ring_sock->sk->sk_user_data = ctx;
-#endif
 	fd_install(ret, file);
 	return ret;
-err:
-#if defined(CONFIG_UNIX)
-	sock_release(ctx->ring_sock);
-	ctx->ring_sock = NULL;
-#endif
-	return ret;
 }
 
 static int io_uring_create(unsigned entries, struct io_uring_params *p)
diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index effaa4247b912..c0f2e1751c33e 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -169,10 +169,10 @@ static int __init root_nfs_cat(char *dest, const char *src,
 	size_t len = strlen(dest);
 
 	if (len && dest[len - 1] != ',')
-		if (strlcat(dest, ",", destlen) > destlen)
+		if (strlcat(dest, ",", destlen) >= destlen)
 			return -1;
 
-	if (strlcat(dest, src, destlen) > destlen)
+	if (strlcat(dest, src, destlen) >= destlen)
 		return -1;
 	return 0;
 }
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index d9da4a8c4317c..a7ddb874912d4 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -399,15 +399,17 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 EXPORT_SYMBOL(dquot_mark_dquot_dirty);
 
 /* Dirtify all the dquots - this can block when journalling */
-static inline int mark_all_dquot_dirty(struct dquot * const *dquot)
+static inline int mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
 {
 	int ret, err, cnt;
+	struct dquot *dquot;
 
 	ret = err = 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquot[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot)
 			/* Even in case of error we have to continue */
-			ret = mark_dquot_dirty(dquot[cnt]);
+			ret = mark_dquot_dirty(dquot);
 		if (!err)
 			err = ret;
 	}
@@ -995,14 +997,15 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 }
 EXPORT_SYMBOL(dqget);
 
-static inline struct dquot **i_dquot(struct inode *inode)
+static inline struct dquot __rcu **i_dquot(struct inode *inode)
 {
-	return inode->i_sb->s_op->get_dquots(inode);
+	/* Force __rcu for now until filesystems are fixed */
+	return (struct dquot __rcu **)inode->i_sb->s_op->get_dquots(inode);
 }
 
 static int dqinit_needed(struct inode *inode, int type)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1075,59 +1078,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	return err;
 }
 
-/*
- * Remove references to dquots from inode and add dquot to list for freeing
- * if we have the last reference to dquot
- */
-static void remove_inode_dquot_ref(struct inode *inode, int type,
-				   struct list_head *tofree_head)
-{
-	struct dquot **dquots = i_dquot(inode);
-	struct dquot *dquot = dquots[type];
-
-	if (!dquot)
-		return;
-
-	dquots[type] = NULL;
-	if (list_empty(&dquot->dq_free)) {
-		/*
-		 * The inode still has reference to dquot so it can't be in the
-		 * free list
-		 */
-		spin_lock(&dq_list_lock);
-		list_add(&dquot->dq_free, tofree_head);
-		spin_unlock(&dq_list_lock);
-	} else {
-		/*
-		 * Dquot is already in a list to put so we won't drop the last
-		 * reference here.
-		 */
-		dqput(dquot);
-	}
-}
-
-/*
- * Free list of dquots
- * Dquots are removed from inodes and no new references can be got so we are
- * the only ones holding reference
- */
-static void put_dquot_list(struct list_head *tofree_head)
-{
-	struct list_head *act_head;
-	struct dquot *dquot;
-
-	act_head = tofree_head->next;
-	while (act_head != tofree_head) {
-		dquot = list_entry(act_head, struct dquot, dq_free);
-		act_head = act_head->next;
-		/* Remove dquot from the list so we won't have problems... */
-		list_del_init(&dquot->dq_free);
-		dqput(dquot);
-	}
-}
-
-static void remove_dquot_ref(struct super_block *sb, int type,
-		struct list_head *tofree_head)
+static void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
 #ifdef CONFIG_QUOTA_DEBUG
@@ -1144,11 +1095,18 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 		 */
 		spin_lock(&dq_data_lock);
 		if (!IS_NOQUOTA(inode)) {
+			struct dquot __rcu **dquots = i_dquot(inode);
+			struct dquot *dquot = srcu_dereference_check(
+				dquots[type], &dquot_srcu,
+				lockdep_is_held(&dq_data_lock));
+
 #ifdef CONFIG_QUOTA_DEBUG
 			if (unlikely(inode_get_rsv_space(inode) > 0))
 				reserved = 1;
 #endif
-			remove_inode_dquot_ref(inode, type, tofree_head);
+			rcu_assign_pointer(dquots[type], NULL);
+			if (dquot)
+				dqput(dquot);
 		}
 		spin_unlock(&dq_data_lock);
 	}
@@ -1165,13 +1123,8 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 /* Gather all references from inodes and drop them */
 static void drop_dquot_ref(struct super_block *sb, int type)
 {
-	LIST_HEAD(tofree_head);
-
-	if (sb->dq_op) {
-		remove_dquot_ref(sb, type, &tofree_head);
-		synchronize_srcu(&dquot_srcu);
-		put_dquot_list(&tofree_head);
-	}
+	if (sb->dq_op)
+		remove_dquot_ref(sb, type);
 }
 
 static inline
@@ -1504,7 +1457,8 @@ static int inode_quota_active(const struct inode *inode)
 static int __dquot_initialize(struct inode *inode, int type)
 {
 	int cnt, init_needed = 0;
-	struct dquot **dquots, *got[MAXQUOTAS] = {};
+	struct dquot __rcu **dquots;
+	struct dquot *got[MAXQUOTAS] = {};
 	struct super_block *sb = inode->i_sb;
 	qsize_t rsv;
 	int ret = 0;
@@ -1579,7 +1533,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 		if (!got[cnt])
 			continue;
 		if (!dquots[cnt]) {
-			dquots[cnt] = got[cnt];
+			rcu_assign_pointer(dquots[cnt], got[cnt]);
 			got[cnt] = NULL;
 			/*
 			 * Make quota reservation system happy if someone
@@ -1587,12 +1541,16 @@ static int __dquot_initialize(struct inode *inode, int type)
 			 */
 			rsv = inode_get_rsv_space(inode);
 			if (unlikely(rsv)) {
+				struct dquot *dquot = srcu_dereference_check(
+					dquots[cnt], &dquot_srcu,
+					lockdep_is_held(&dq_data_lock));
+
 				spin_lock(&inode->i_lock);
 				/* Get reservation again under proper lock */
 				rsv = __inode_get_rsv_space(inode);
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquots[cnt]->dq_dqb.dqb_rsvspace += rsv;
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
+				dquot->dq_dqb.dqb_rsvspace += rsv;
+				spin_unlock(&dquot->dq_dqb_lock);
 				spin_unlock(&inode->i_lock);
 			}
 		}
@@ -1614,7 +1572,7 @@ EXPORT_SYMBOL(dquot_initialize);
 
 bool dquot_initialize_needed(struct inode *inode)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	int i;
 
 	if (!inode_quota_active(inode))
@@ -1639,13 +1597,14 @@ EXPORT_SYMBOL(dquot_initialize_needed);
 static void __dquot_drop(struct inode *inode)
 {
 	int cnt;
-	struct dquot **dquots = i_dquot(inode);
+	struct dquot __rcu **dquots = i_dquot(inode);
 	struct dquot *put[MAXQUOTAS];
 
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		put[cnt] = dquots[cnt];
-		dquots[cnt] = NULL;
+		put[cnt] = srcu_dereference_check(dquots[cnt], &dquot_srcu,
+					lockdep_is_held(&dq_data_lock));
+		rcu_assign_pointer(dquots[cnt], NULL);
 	}
 	spin_unlock(&dq_data_lock);
 	dqput_all(put);
@@ -1653,7 +1612,7 @@ static void __dquot_drop(struct inode *inode)
 
 void dquot_drop(struct inode *inode)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1726,7 +1685,8 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
 		if (reserve) {
@@ -1746,27 +1706,26 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	index = srcu_read_lock(&dquot_srcu);
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
 		if (reserve) {
-			ret = dquot_add_space(dquots[cnt], 0, number, flags,
-					      &warn[cnt]);
+			ret = dquot_add_space(dquot, 0, number, flags, &warn[cnt]);
 		} else {
-			ret = dquot_add_space(dquots[cnt], number, 0, flags,
-					      &warn[cnt]);
+			ret = dquot_add_space(dquot, number, 0, flags, &warn[cnt]);
 		}
 		if (ret) {
 			/* Back out changes we already did */
 			for (cnt--; cnt >= 0; cnt--) {
-				if (!dquots[cnt])
+				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+				if (!dquot)
 					continue;
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
 				if (reserve)
-					dquot_free_reserved_space(dquots[cnt],
-								  number);
+					dquot_free_reserved_space(dquot, number);
 				else
-					dquot_decr_space(dquots[cnt], number);
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+					dquot_decr_space(dquot, number);
+				spin_unlock(&dquot->dq_dqb_lock);
 			}
 			spin_unlock(&inode->i_lock);
 			goto out_flush_warn;
@@ -1796,7 +1755,8 @@ int dquot_alloc_inode(struct inode *inode)
 {
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
 		return 0;
@@ -1807,17 +1767,19 @@ int dquot_alloc_inode(struct inode *inode)
 	index = srcu_read_lock(&dquot_srcu);
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		ret = dquot_add_inodes(dquots[cnt], 1, &warn[cnt]);
+		ret = dquot_add_inodes(dquot, 1, &warn[cnt]);
 		if (ret) {
 			for (cnt--; cnt >= 0; cnt--) {
-				if (!dquots[cnt])
+				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+				if (!dquot)
 					continue;
 				/* Back out changes we already did */
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquot_decr_inodes(dquots[cnt], 1);
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
+				dquot_decr_inodes(dquot, 1);
+				spin_unlock(&dquot->dq_dqb_lock);
 			}
 			goto warn_put_all;
 		}
@@ -1838,7 +1800,8 @@ EXPORT_SYMBOL(dquot_alloc_inode);
  */
 int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1854,9 +1817,8 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	spin_lock(&inode->i_lock);
 	/* Claim reserved quotas to allocated quotas */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquots[cnt]) {
-			struct dquot *dquot = dquots[cnt];
-
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot) {
 			spin_lock(&dquot->dq_dqb_lock);
 			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_rsvspace < number))
 				number = dquot->dq_dqb.dqb_rsvspace;
@@ -1880,7 +1842,8 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
  */
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1896,9 +1859,8 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	spin_lock(&inode->i_lock);
 	/* Claim reserved quotas to allocated quotas */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquots[cnt]) {
-			struct dquot *dquot = dquots[cnt];
-
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot) {
 			spin_lock(&dquot->dq_dqb_lock);
 			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_curspace < number))
 				number = dquot->dq_dqb.dqb_curspace;
@@ -1924,7 +1886,8 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1945,17 +1908,18 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 		int wtype;
 
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		spin_lock(&dquots[cnt]->dq_dqb_lock);
-		wtype = info_bdq_free(dquots[cnt], number);
+		spin_lock(&dquot->dq_dqb_lock);
+		wtype = info_bdq_free(dquot, number);
 		if (wtype != QUOTA_NL_NOWARN)
-			prepare_warning(&warn[cnt], dquots[cnt], wtype);
+			prepare_warning(&warn[cnt], dquot, wtype);
 		if (reserve)
-			dquot_free_reserved_space(dquots[cnt], number);
+			dquot_free_reserved_space(dquot, number);
 		else
-			dquot_decr_space(dquots[cnt], number);
-		spin_unlock(&dquots[cnt]->dq_dqb_lock);
+			dquot_decr_space(dquot, number);
+		spin_unlock(&dquot->dq_dqb_lock);
 	}
 	if (reserve)
 		*inode_reserved_space(inode) -= number;
@@ -1979,7 +1943,8 @@ void dquot_free_inode(struct inode *inode)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
+	struct dquot *dquot;
 	int index;
 
 	if (!inode_quota_active(inode))
@@ -1990,16 +1955,16 @@ void dquot_free_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		int wtype;
-
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		spin_lock(&dquots[cnt]->dq_dqb_lock);
-		wtype = info_idq_free(dquots[cnt], 1);
+		spin_lock(&dquot->dq_dqb_lock);
+		wtype = info_idq_free(dquot, 1);
 		if (wtype != QUOTA_NL_NOWARN)
-			prepare_warning(&warn[cnt], dquots[cnt], wtype);
-		dquot_decr_inodes(dquots[cnt], 1);
-		spin_unlock(&dquots[cnt]->dq_dqb_lock);
+			prepare_warning(&warn[cnt], dquot, wtype);
+		dquot_decr_inodes(dquot, 1);
+		spin_unlock(&dquot->dq_dqb_lock);
 	}
 	spin_unlock(&inode->i_lock);
 	mark_all_dquot_dirty(dquots);
@@ -2025,8 +1990,9 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t cur_space;
 	qsize_t rsv_space = 0;
 	qsize_t inode_usage = 1;
+	struct dquot __rcu **dquots;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
-	int cnt, ret = 0;
+	int cnt, index, ret = 0;
 	char is_valid[MAXQUOTAS] = {};
 	struct dquot_warn warn_to[MAXQUOTAS];
 	struct dquot_warn warn_from_inodes[MAXQUOTAS];
@@ -2057,6 +2023,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	}
 	cur_space = __inode_get_bytes(inode);
 	rsv_space = __inode_get_rsv_space(inode);
+	dquots = i_dquot(inode);
 	/*
 	 * Build the transfer_from list, check limits, and update usage in
 	 * the target structures.
@@ -2071,7 +2038,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 		if (!sb_has_quota_active(inode->i_sb, cnt))
 			continue;
 		is_valid[cnt] = 1;
-		transfer_from[cnt] = i_dquot(inode)[cnt];
+		transfer_from[cnt] = srcu_dereference_check(dquots[cnt],
+				&dquot_srcu, lockdep_is_held(&dq_data_lock));
 		ret = dquot_add_inodes(transfer_to[cnt], inode_usage,
 				       &warn_to[cnt]);
 		if (ret)
@@ -2110,13 +2078,21 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 						  rsv_space);
 			spin_unlock(&transfer_from[cnt]->dq_dqb_lock);
 		}
-		i_dquot(inode)[cnt] = transfer_to[cnt];
+		rcu_assign_pointer(dquots[cnt], transfer_to[cnt]);
 	}
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&dq_data_lock);
 
-	mark_all_dquot_dirty(transfer_from);
-	mark_all_dquot_dirty(transfer_to);
+	/*
+	 * These arrays are local and we hold dquot references so we don't need
+	 * the srcu protection but still take dquot_srcu to avoid warning in
+	 * mark_all_dquot_dirty().
+	 */
+	index = srcu_read_lock(&dquot_srcu);
+	mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
+	mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
+	srcu_read_unlock(&dquot_srcu, index);
+
 	flush_warnings(warn_to);
 	flush_warnings(warn_from_inodes);
 	flush_warnings(warn_from_space);
diff --git a/fs/select.c b/fs/select.c
index 7716d9d5be1e8..f405dc5adf3ca 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -475,7 +475,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
 		wait->_key |= POLLOUT_SET;
 }
 
-static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
+static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 {
 	ktime_t expire, *to = NULL;
 	struct poll_wqueues table;
diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 553210c02ee0f..627efa56e59fb 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -88,7 +88,7 @@ static inline int drm_fixp2int(s64 a)
 
 static inline int drm_fixp2int_ceil(s64 a)
 {
-	if (a > 0)
+	if (a >= 0)
 		return drm_fixp2int(a + DRM_FIXED_ALMOST_ONE);
 	else
 		return drm_fixp2int(a - DRM_FIXED_ALMOST_ONE);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 440014875acf4..0bec300b2e516 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -476,23 +476,27 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 	__BPF_MAP(n, __BPF_DECL_ARGS, __BPF_N, u64, __ur_1, u64, __ur_2,       \
 		  u64, __ur_3, u64, __ur_4, u64, __ur_5)
 
-#define BPF_CALL_x(x, name, ...)					       \
+#define BPF_CALL_x(x, attr, name, ...)					       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
+	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));    \
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))     \
 	{								       \
-		return ____##name(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
+		return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
 	}								       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
 
-#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, name, __VA_ARGS__)
-#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, name, __VA_ARGS__)
-#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, name, __VA_ARGS__)
-#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, name, __VA_ARGS__)
-#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, name, __VA_ARGS__)
-#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, name, __VA_ARGS__)
+#define __NOATTR
+#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, __NOATTR, name, __VA_ARGS__)
+
+#define NOTRACE_BPF_CALL_1(name, ...)	BPF_CALL_x(1, notrace, name, __VA_ARGS__)
 
 #define bpf_ctx_range(TYPE, MEMBER)						\
 	offsetof(TYPE, MEMBER) ... offsetofend(TYPE, MEMBER) - 1
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e009b52ab6b0d..272f261894b17 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3614,11 +3614,11 @@ extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
 #if defined(CONFIG_IO_URING)
-extern struct sock *io_uring_get_socket(struct file *file);
+bool io_is_uring_fops(struct file *file);
 #else
-static inline struct sock *io_uring_get_socket(struct file *file)
+static inline bool io_is_uring_fops(struct file *file)
 {
-	return NULL;
+	return false;
 }
 #endif
 
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e6eea45e11549..0b9d59807e5e2 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -314,7 +314,8 @@ int host1x_client_unregister(struct host1x_client *client);
 
 struct tegra_mipi_device;
 
-struct tegra_mipi_device *tegra_mipi_request(struct device *device);
+struct tegra_mipi_device *tegra_mipi_request(struct device *device,
+					     struct device_node *np);
 void tegra_mipi_free(struct tegra_mipi_device *device);
 int tegra_mipi_enable(struct tegra_mipi_device *device);
 int tegra_mipi_disable(struct tegra_mipi_device *device);
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 1cdc32b1f1b08..7e0fdcf905d2e 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -16,11 +16,7 @@
 extern struct ctl_table epoll_table[]; /* for sysctl */
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
-#ifdef __clang__
-#define MAX_STACK_ALLOC 768
-#else
 #define MAX_STACK_ALLOC 832
-#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c75b38ba4a728..bc4b5c905a602 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -164,6 +164,37 @@ do { \
 	cond_resched(); \
 } while (0)
 
+/**
+ * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
+ * @old_ts: jiffies at start of processing.
+ *
+ * This helper is for long-running softirq handlers, such as NAPI threads in
+ * networking. The caller should initialize the variable passed in as @old_ts
+ * at the beginning of the softirq handler. When invoked frequently, this macro
+ * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, which will
+ * provide both RCU and RCU-Tasks quiescent states. Note that this macro
+ * modifies its old_ts argument.
+ *
+ * Because regions of code that have disabled softirq act as RCU read-side
+ * critical sections, this macro should be invoked with softirq (and
+ * preemption) enabled.
+ *
+ * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
+ * have more chance to invoke schedule() calls and provide necessary quiescent
+ * states. As a contrast, calling cond_resched() only won't achieve the same
+ * effect because cond_resched() does not provide RCU-Tasks quiescent states.
+ */
+#define rcu_softirq_qs_periodic(old_ts) \
+do { \
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
+	    time_after(jiffies, (old_ts) + HZ / 10)) { \
+		preempt_disable(); \
+		rcu_softirq_qs(); \
+		preempt_enable(); \
+		(old_ts) = jiffies; \
+	} \
+} while (0)
+
 /*
  * Infrastructure to implement the synchronize_() primitives in
  * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index 48531e57cc5a8..5e7c0f8acd054 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -24,7 +24,8 @@
 /**
  * enum vfl_devnode_type - type of V4L2 device node
  *
- * @VFL_TYPE_GRABBER:	for video input/output devices
+ * @VFL_TYPE_VIDEO:	for video input/output devices
+ * @VFL_TYPE_GRABBER:	deprecated, same as VFL_TYPE_VIDEO
  * @VFL_TYPE_VBI:	for vertical blank data (i.e. closed captions, teletext)
  * @VFL_TYPE_RADIO:	for radio tuners
  * @VFL_TYPE_SUBDEV:	for V4L2 subdevices
@@ -33,7 +34,8 @@
  * @VFL_TYPE_MAX:	number of VFL types, must always be last in the enum
  */
 enum vfl_devnode_type {
-	VFL_TYPE_GRABBER	= 0,
+	VFL_TYPE_VIDEO,
+	VFL_TYPE_GRABBER = VFL_TYPE_VIDEO,
 	VFL_TYPE_VBI,
 	VFL_TYPE_RADIO,
 	VFL_TYPE_SUBDEV,
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a367fc8503933..19be747f4e5ab 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -249,6 +249,7 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -271,10 +272,12 @@ static int cpu_map_kthread_run(void *data)
 			if (__ptr_ring_empty(rcpu->queue)) {
 				schedule();
 				sched = 1;
+				last_qs = jiffies;
 			} else {
 				__set_current_state(TASK_RUNNING);
 			}
 		} else {
+			rcu_softirq_qs_periodic(last_qs);
 			sched = cond_resched();
 		}
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f1dec90f3a522..34c4f709b1ede 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -327,7 +327,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 							  num_possible_cpus());
 	}
 
-	/* hash table size must be power of 2 */
+	/* hash table size must be power of 2; roundup_pow_of_two() can overflow
+	 * into UB on 32-bit arches, so check that first
+	 */
+	err = -E2BIG;
+	if (htab->map.max_entries > 1UL << 31)
+		goto free_htab;
+
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
 	htab->elem_size = sizeof(struct htab_elem) +
@@ -337,10 +343,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
-	err = -E2BIG;
-	/* prevent zero size kmalloc and check for u32 overflow */
-	if (htab->n_buckets == 0 ||
-	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
+	/* check for u32 overflow */
+	if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
 		goto free_htab;
 
 	cost = (u64) htab->n_buckets * sizeof(struct bucket) +
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a77d2814cac5d..9bfb4685d0684 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -262,13 +262,18 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
 
 static DEFINE_PER_CPU(unsigned long, irqsave_flags);
 
-notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	__bpf_spin_lock(lock);
 	__this_cpu_write(irqsave_flags, flags);
+}
+
+NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+{
+	__bpf_spin_lock_irqsave(lock);
 	return 0;
 }
 
@@ -279,13 +284,18 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
 };
 
-notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
 
 	flags = __this_cpu_read(irqsave_flags);
 	__bpf_spin_unlock(lock);
 	local_irq_restore(flags);
+}
+
+NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+{
+	__bpf_spin_unlock_irqrestore(lock);
 	return 0;
 }
 
@@ -306,9 +316,9 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 	else
 		lock = dst + map->spin_lock_off;
 	preempt_disable();
-	____bpf_spin_lock(lock);
+	__bpf_spin_lock_irqsave(lock);
 	copy_map_value(map, dst, src);
-	____bpf_spin_unlock(lock);
+	__bpf_spin_unlock_irqrestore(lock);
 	preempt_enable();
 }
 
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 811071c227f11..bd8516d967453 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -111,11 +111,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	} else if (value_size / 8 > sysctl_perf_event_max_stack)
 		return ERR_PTR(-EINVAL);
 
-	/* hash table size must be power of 2 */
-	n_buckets = roundup_pow_of_two(attr->max_entries);
-	if (!n_buckets)
+	/* hash table size must be power of 2; roundup_pow_of_two() can overflow
+	 * into UB on 32-bit arches, so check that first
+	 */
+	if (attr->max_entries > 1UL << 31)
 		return ERR_PTR(-E2BIG);
 
+	n_buckets = roundup_pow_of_two(attr->max_entries);
+
 	cost = n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap);
 	err = bpf_map_charge_init(&mem, cost + attr->max_entries *
 			   (sizeof(struct stack_map_bucket) + (u64)value_size));
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 105dd0b663291..c202dbd87860c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1093,13 +1093,15 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 }
 
 /*
- * cycle_between - true if test occurs chronologically between before and after
+ * timestamp_in_interval - true if ts is chronologically in [start, end]
+ *
+ * True if ts occurs chronologically at or after start, and before or at end.
  */
-static bool cycle_between(u64 before, u64 test, u64 after)
+static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 {
-	if (test > before && test < after)
+	if (ts >= start && ts <= end)
 		return true;
-	if (test < before && before > after)
+	if (start > end && (ts >= start || ts <= end))
 		return true;
 	return false;
 }
@@ -1159,7 +1161,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now = tk_clock_read(&tk->tkr_mono);
 		interval_start = tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!timestamp_in_interval(interval_start, now, cycles)) {
 			clock_was_set_seq = tk->clock_was_set_seq;
 			cs_was_changed_seq = tk->cs_was_changed_seq;
 			cycles = interval_start;
@@ -1172,10 +1174,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				      tk_core.timekeeper.offs_real);
 		base_raw = tk->tkr_raw.base;
 
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono,
-						     system_counterval.cycles);
-		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw,
-						    system_counterval.cycles);
+		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
+		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);
@@ -1190,13 +1190,13 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		bool discontinuity;
 
 		/*
-		 * Check that the counter value occurs after the provided
+		 * Check that the counter value is not before the provided
 		 * history reference and that the history doesn't cross a
 		 * clocksource change
 		 */
 		if (!history_begin ||
-		    !cycle_between(history_begin->cycles,
-				   system_counterval.cycles, cycles) ||
+		    !timestamp_in_interval(history_begin->cycles,
+					   cycles, system_counterval.cycles) ||
 		    history_begin->cs_was_changed_seq != cs_was_changed_seq)
 			return -EINVAL;
 		partial_history_cycles = cycles - system_counterval.cycles;
diff --git a/lib/test_blackhole_dev.c b/lib/test_blackhole_dev.c
index 4c40580a99a36..f247089d63c08 100644
--- a/lib/test_blackhole_dev.c
+++ b/lib/test_blackhole_dev.c
@@ -29,7 +29,6 @@ static int __init test_blackholedev_init(void)
 {
 	struct ipv6hdr *ip6h;
 	struct sk_buff *skb;
-	struct ethhdr *ethh;
 	struct udphdr *uh;
 	int data_len;
 	int ret;
@@ -61,7 +60,7 @@ static int __init test_blackholedev_init(void)
 	ip6h->saddr = in6addr_loopback;
 	ip6h->daddr = in6addr_loopback;
 	/* Ether */
-	ethh = (struct ethhdr *)skb_push(skb, sizeof(struct ethhdr));
+	skb_push(skb, sizeof(struct ethhdr));
 	skb_set_mac_header(skb, 0);
 
 	skb->protocol = htons(ETH_P_IPV6);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 289fb28529f8c..c60204b639ab7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2129,7 +2129,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32793d22ba61c..2125421ad7465 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2861,8 +2861,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 2db9e285215c5..596fa3172642b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1940,7 +1940,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
 	/* Get data directly from socket receive queue without copying it. */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
-		if (!skb_linearize(skb)) {
+		if (!skb_linearize(skb) && sk->sk_state != BT_CLOSED) {
 			s = rfcomm_recv_frame(s, skb);
 			if (!s)
 				break;
diff --git a/net/core/dev.c b/net/core/dev.c
index 5e043e6f09476..4f39d97209811 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1940,7 +1940,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(ptype, ptype_list, list) {
-		if (ptype->ignore_outgoing)
+		if (READ_ONCE(ptype->ignore_outgoing))
 			continue;
 
 		/* Never send packets back to the socket
diff --git a/net/core/scm.c b/net/core/scm.c
index 5525c14f33f1e..a442bf63cd480 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -105,7 +105,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		if (fd < 0 || !(file = fget_raw(fd)))
 			return -EBADF;
 		/* don't allow io_uring files */
-		if (io_uring_get_socket(file)) {
+		if (io_is_uring_fops(file)) {
 			fput(file);
 			return -EINVAL;
 		}
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index c13ffbd33d8d6..315a5200d170b 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -188,7 +188,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -204,7 +204,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	WRITE_ONCE(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
@@ -222,7 +222,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (sock_diag_handlers[req->sdiag_family] == NULL)
+	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
 
 	mutex_lock(&sock_diag_table_mutex);
@@ -281,12 +281,12 @@ static int sock_diag_bind(struct net *net, int group)
 	switch (group) {
 	case SKNLGRP_INET_TCP_DESTROY:
 	case SKNLGRP_INET_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET])
+		if (!READ_ONCE(sock_diag_handlers[AF_INET]))
 			sock_load_diag_module(AF_INET, 0);
 		break;
 	case SKNLGRP_INET6_TCP_DESTROY:
 	case SKNLGRP_INET6_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET6])
+		if (!READ_ONCE(sock_diag_handlers[AF_INET6]))
 			sock_load_diag_module(AF_INET6, 0);
 		break;
 	}
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 783e741491ec3..1a0f447113f24 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -198,6 +198,10 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
+		/* Check if skb contains hsr_ethhdr */
+		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+			return NULL;
+
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 9e389accbfc7e..ea627e532aab8 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -113,14 +113,21 @@ static struct notifier_block hsr_nb = {
 
 static int __init hsr_init(void)
 {
-	int res;
+	int err;
 
 	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
 
-	register_netdevice_notifier(&hsr_nb);
-	res = hsr_netlink_init();
+	err = register_netdevice_notifier(&hsr_nb);
+	if (err)
+		return err;
+
+	err = hsr_netlink_init();
+	if (err) {
+		unregister_netdevice_notifier(&hsr_nb);
+		return err;
+	}
 
-	return res;
+	return 0;
 }
 
 static void __exit hsr_exit(void)
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index ba1decf81fe32..906c37c7f80d5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -365,7 +365,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 {
 	struct pcpu_sw_netstats *tstats;
 	const struct iphdr *iph = ip_hdr(skb);
-	int err;
+	int nh, err;
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 	if (ipv4_is_multicast(iph->daddr)) {
@@ -391,8 +391,21 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
 	}
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_set_network_header(skb, (tunnel->dev->type == ARPHRD_ETHER) ? ETH_HLEN : 0);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(tunnel->dev, rx_length_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
+		goto drop;
+	}
+	iph = (struct iphdr *)(skb->head + nh);
+
 	err = IP_ECN_decapsulate(iph, skb);
 	if (unlikely(err)) {
 		if (log_ecn_error)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8d7933989de0e..8ebcff40bc5ac 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3451,11 +3451,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a6f982b2d32af..3b3f944798850 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2679,11 +2679,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case UDP_CORK:
 		val = READ_ONCE(up->corkflag);
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 1727269396523..cdc8a49d7fc34 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -437,6 +437,11 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
 	       + nla_total_size(16); /* src */
 }
 
+static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
+{
+	rt_genid_bump_ipv6(ops->fro_net);
+}
+
 static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.family			= AF_INET6,
 	.rule_size		= sizeof(struct fib6_rule),
@@ -449,6 +454,7 @@ static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.compare		= fib6_rule_compare,
 	.fill			= fib6_rule_fill,
 	.nlmsg_payload		= fib6_rule_nlmsg_payload,
+	.flush_cache		= fib6_rule_flush_cache,
 	.nlgroup		= RTNLGRP_IPV6_RULE,
 	.policy			= fib6_rule_policy,
 	.owner			= THIS_MODULE,
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 392f8ddf97191..8b5b8cc93ff8b 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -179,7 +179,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -590,7 +590,7 @@ static int iucv_enable(void)
 
 	get_online_cpus();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 8a8ea7e6774d5..920b0ebf1cb80 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1277,10 +1277,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case KCM_RECV_DISABLE:
 		val = kcm->rx_disabled;
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index c54cb59593ef8..7d3c782e5ab1e 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1375,11 +1375,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	err = -ENOTCONN;
 	if (sk->sk_user_data == NULL)
 		goto end;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c5dbb950822fd..2d372d5fcbfaa 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -916,7 +916,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_DORMANT)
 		return -EINVAL;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	/* No dormant off/on/off/on games in single transaction */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 451f9c43b34b8..9fc020fd7ecc1 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3921,7 +3921,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (val < 0 || val > 1)
 			return -EINVAL;
 
-		po->prot_hook.ignore_outgoing = !!val;
+		WRITE_ONCE(po->prot_hook.ignore_outgoing, !!val);
 		return 0;
 	}
 	case PACKET_TX_HAS_OFF:
@@ -4053,7 +4053,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		       0);
 		break;
 	case PACKET_IGNORE_OUTGOING:
-		val = po->prot_hook.ignore_outgoing;
+		val = READ_ONCE(po->prot_hook.ignore_outgoing);
 		break;
 	case PACKET_ROLLOVER_STATS:
 		if (!po->rollover)
diff --git a/net/rds/send.c b/net/rds/send.c
index 6c2c5667e3a39..c0cebf4b4fe56 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(rds_send_path_reset);
 
 static int acquire_in_xmit(struct rds_conn_path *cp)
 {
-	return test_and_set_bit(RDS_IN_XMIT, &cp->cp_flags) == 0;
+	return test_and_set_bit_lock(RDS_IN_XMIT, &cp->cp_flags) == 0;
 }
 
 static void release_in_xmit(struct rds_conn_path *cp)
 {
-	clear_bit(RDS_IN_XMIT, &cp->cp_flags);
-	smp_mb__after_atomic();
+	clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
 	/*
 	 * We don't use wait_on_bit()/wake_up_bit() because our waking is in a
 	 * hot path and finding waiters is very rare.  We don't want to walk
diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 0d4a2bb09589c..be2fc88f5bde1 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -288,10 +288,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
 	}
 
 	if (snprintf(portbuf, sizeof(portbuf),
-		     ".%u.%u", port >> 8, port & 0xff) > (int)sizeof(portbuf))
+		     ".%u.%u", port >> 8, port & 0xff) >= (int)sizeof(portbuf))
 		return NULL;
 
-	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) > sizeof(addrbuf))
+	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) >= sizeof(addrbuf))
 		return NULL;
 
 	return kstrdup(addrbuf, gfp_flags);
diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index 2ff7b7083ebab..e265b8d38aa14 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -250,8 +250,8 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 
 	creds = kzalloc(sizeof(struct svc_cred), GFP_KERNEL);
 	if (!creds) {
-		kfree(oa->data);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_oa;
 	}
 
 	oa->data[0].option.data = CREDS_VALUE;
@@ -265,29 +265,40 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 
 		/* option buffer */
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			return -ENOSPC;
+		if (unlikely(p == NULL)) {
+			err = -ENOSPC;
+			goto free_creds;
+		}
 
 		length = be32_to_cpup(p);
 		p = xdr_inline_decode(xdr, length);
-		if (unlikely(p == NULL))
-			return -ENOSPC;
+		if (unlikely(p == NULL)) {
+			err = -ENOSPC;
+			goto free_creds;
+		}
 
 		if (length == sizeof(CREDS_VALUE) &&
 		    memcmp(p, CREDS_VALUE, sizeof(CREDS_VALUE)) == 0) {
 			/* We have creds here. parse them */
 			err = gssx_dec_linux_creds(xdr, creds);
 			if (err)
-				return err;
+				goto free_creds;
 			oa->data[0].value.len = 1; /* presence */
 		} else {
 			/* consume uninteresting buffer */
 			err = gssx_dec_buffer(xdr, &dummy);
 			if (err)
-				return err;
+				goto free_creds;
 		}
 	}
 	return 0;
+
+free_creds:
+	kfree(creds);
+free_oa:
+	kfree(oa->data);
+	oa->data = NULL;
+	return err;
 }
 
 static int gssx_dec_status(struct xdr_stream *xdr,
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index dc27635403932..9121a4d5436d5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -198,7 +198,7 @@ void wait_for_unix_gc(void)
 	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
 	    !READ_ONCE(gc_in_progress))
 		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
 }
 
 /* The external entry point: unix_gc() */
diff --git a/net/unix/scm.c b/net/unix/scm.c
index e881a6e78af53..51b623de3be5f 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -33,10 +33,8 @@ struct sock *unix_get_socket(struct file *filp)
 		/* PF_UNIX ? */
 		if (s && sock->ops && sock->ops->family == PF_UNIX)
 			u_sock = s;
-	} else {
-		/* Could be an io_uring instance */
-		u_sock = io_uring_get_socket(filp);
 	}
+
 	return u_sock;
 }
 EXPORT_SYMBOL(unix_get_socket);
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 43dd489ad6db9..851096110b4d4 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -470,12 +470,12 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		goto out;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	rc = -EINVAL;
 	if (len < 0)
 		goto out;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	rc = -EFAULT;
 	if (put_user(len, optlen))
 		goto out;
diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index f6a551bd57ef1..3fa6582b4a689 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -879,7 +879,7 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	vdev->tvnorms = SKEL_TVNORMS;
 	video_set_drvdata(vdev, skel);
 
-	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (ret)
 		goto free_hdl;
 
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 6354c905b006f..3bf90d01c39f9 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -305,8 +305,11 @@ static char *expand_token(const char *in, size_t n)
 	new_string();
 	append_string(in, n);
 
-	/* get the whole line because we do not know the end of token. */
-	while ((c = input()) != EOF) {
+	/*
+	 * get the whole line because we do not know the end of token.
+	 * input() returns 0 (not EOF!) when it reachs the end of file.
+	 */
+	while ((c = input()) != 0) {
 		if (c == '\n') {
 			unput(c);
 			break;
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 6825940ea2cf8..a741d1ae6639a 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -111,6 +111,12 @@ static int dump_midi(struct snd_rawmidi_substream *substream, const char *buf, i
 	return 0;
 }
 
+/* callback for snd_seq_dump_var_event(), bridging to dump_midi() */
+static int __dump_midi(void *ptr, void *buf, int count)
+{
+	return dump_midi(ptr, buf, count);
+}
+
 static int event_process_midi(struct snd_seq_event *ev, int direct,
 			      void *private_data, int atomic, int hop)
 {
@@ -130,7 +136,7 @@ static int event_process_midi(struct snd_seq_event *ev, int direct,
 			pr_debug("ALSA: seq_midi: invalid sysex event flags = 0x%x\n", ev->flags);
 			return 0;
 		}
-		snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
+		snd_seq_dump_var_event(ev, __dump_midi, substream);
 		snd_midi_event_reset_decode(msynth->parser);
 	} else {
 		if (msynth->parser == NULL)
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 77d7037d1476f..82396b8c885a5 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -62,6 +62,13 @@ static void snd_virmidi_init_event(struct snd_virmidi *vmidi,
 /*
  * decode input event and put to read buffer of each opened file
  */
+
+/* callback for snd_seq_dump_var_event(), bridging to snd_rawmidi_receive() */
+static int dump_to_rawmidi(void *ptr, void *buf, int count)
+{
+	return snd_rawmidi_receive(ptr, buf, count);
+}
+
 static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 					 struct snd_seq_event *ev,
 					 bool atomic)
@@ -80,7 +87,7 @@ static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 		if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 			if ((ev->flags & SNDRV_SEQ_EVENT_LENGTH_MASK) != SNDRV_SEQ_EVENT_LENGTH_VARIABLE)
 				continue;
-			snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
+			snd_seq_dump_var_event(ev, dump_to_rawmidi, vmidi->substream);
 			snd_midi_event_reset_decode(vmidi->parser);
 		} else {
 			len = snd_midi_event_decode(vmidi->parser, msg, sizeof(msg), ev);
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 88093e58dd845..c78d5833c9cd9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3766,6 +3766,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 		  DMI_EXACT_MATCH(DMI_BOARD_VERSION, "Default string"),
+		  /*
+		   * Above strings are too generic, LattePanda BIOS versions for
+		   * all 4 hw revisions are:
+		   * DF-BI-7-S70CR100-*
+		   * DF-BI-7-S70CR110-*
+		   * DF-BI-7-S70CR200-*
+		   * LP-BS-7-S70CR700-*
+		   * Do a partial match for S70CR to avoid false positive matches.
+		   */
+		  DMI_MATCH(DMI_BIOS_VERSION, "S70CR"),
 		},
 		.driver_data = (void *)&lattepanda_board_platform_data,
 	},
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c384ca3681e9b..15828ae62f9de 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2218,6 +2218,9 @@ SND_SOC_DAPM_PGA_E("HPOUT", SND_SOC_NOPM, 0, 0, NULL, 0, hp_event,
 
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
 SND_SOC_DAPM_OUTPUT("HPOUTR"),
+
+SND_SOC_DAPM_PGA("SPKOUTL Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
+SND_SOC_DAPM_PGA("SPKOUTR Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_widget wm8962_dapm_spk_mono_widgets[] = {
@@ -2225,7 +2228,6 @@ SND_SOC_DAPM_MIXER("Speaker Mixer", WM8962_MIXER_ENABLES, 1, 0,
 		   spkmixl, ARRAY_SIZE(spkmixl)),
 SND_SOC_DAPM_MUX_E("Speaker PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
 		   out_pga_event, SND_SOC_DAPM_POST_PMU),
-SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
 SND_SOC_DAPM_OUTPUT("SPKOUT"),
 };
 
@@ -2240,9 +2242,6 @@ SND_SOC_DAPM_MUX_E("SPKOUTL PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
 SND_SOC_DAPM_MUX_E("SPKOUTR PGA", WM8962_PWR_MGMT_2, 3, 0, &spkoutr_mux,
 		   out_pga_event, SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_PGA("SPKOUTR Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
-SND_SOC_DAPM_PGA("SPKOUTL Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
-
 SND_SOC_DAPM_OUTPUT("SPKOUTL"),
 SND_SOC_DAPM_OUTPUT("SPKOUTR"),
 };
@@ -2352,12 +2351,18 @@ static const struct snd_soc_dapm_route wm8962_spk_mono_intercon[] = {
 	{ "Speaker PGA", "Mixer", "Speaker Mixer" },
 	{ "Speaker PGA", "DAC", "DACL" },
 
-	{ "Speaker Output", NULL, "Speaker PGA" },
-	{ "Speaker Output", NULL, "SYSCLK" },
-	{ "Speaker Output", NULL, "TOCLK" },
-	{ "Speaker Output", NULL, "TEMP_SPK" },
+	{ "SPKOUTL Output", NULL, "Speaker PGA" },
+	{ "SPKOUTL Output", NULL, "SYSCLK" },
+	{ "SPKOUTL Output", NULL, "TOCLK" },
+	{ "SPKOUTL Output", NULL, "TEMP_SPK" },
 
-	{ "SPKOUT", NULL, "Speaker Output" },
+	{ "SPKOUTR Output", NULL, "Speaker PGA" },
+	{ "SPKOUTR Output", NULL, "SYSCLK" },
+	{ "SPKOUTR Output", NULL, "TOCLK" },
+	{ "SPKOUTR Output", NULL, "TEMP_SPK" },
+
+	{ "SPKOUT", NULL, "SPKOUTL Output" },
+	{ "SPKOUT", NULL, "SPKOUTR Output" },
 };
 
 static const struct snd_soc_dapm_route wm8962_spk_stereo_intercon[] = {
@@ -2889,8 +2894,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
@@ -2899,7 +2908,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index df3b370fe7292..c740dec00f83b 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -526,6 +526,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Chuwi Vi8 dual-boot (CWI506) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
+			/* The above are too generic, also match BIOS info */
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		/* Chuwi Vi10 (CWI505) */
 		.matches = {
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index f5a431b8de6c3..34aff050caf25 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -266,8 +266,8 @@ static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
 	srate = iface->slots * iface->slot_width * params_rate(params);
 
 	if (!iface->mclk_rate) {
-		/* If no specific mclk is requested, default to bit clock * 4 */
-		clk_set_rate(iface->mclk, 4 * srate);
+		/* If no specific mclk is requested, default to bit clock * 2 */
+		clk_set_rate(iface->mclk, 2 * srate);
 	} else {
 		/* Check if we can actually get the bit clock from mclk */
 		if (iface->mclk_rate % srate) {
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d35684e5f07f0..967f05d7e205f 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -301,9 +301,12 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 	c = 0;
 
 	if (bits) {
-		for (; bits && *maps; maps++, bits >>= 1)
+		for (; bits && *maps; maps++, bits >>= 1) {
 			if (bits & 1)
 				chmap->map[c++] = *maps;
+			if (c == chmap->channels)
+				break;
+		}
 	} else {
 		/* If we're missing wChannelConfig, then guess something
 		    to make sure the channel map is not skipped entirely */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a9891c9fe94d5..9c03f67398cb2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1110,8 +1110,8 @@ static int
 record__switch_output(struct record *rec, bool at_exit)
 {
 	struct perf_data *data = &rec->data;
+	char *new_filename = NULL;
 	int fd, err;
-	char *new_filename;
 
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9dd9e3f4ef591..cd1eddf0ab371 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1955,7 +1955,6 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e18c26501a7fe..70612ec583f35 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -263,7 +263,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 }
 
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c9bfe4696943b..cee7fc3b5bb0c 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -279,13 +279,13 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 		threads->nr = ntasks;
 	}
 out:
+	strlist__delete(slist);
 	if (threads)
 		refcount_set(&threads->refcnt, 1);
 	return threads;
 
 out_free_threads:
 	zfree(&threads);
-	strlist__delete(slist);
 	goto out;
 }
 
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 837206dbe5d6e..81bb3cc6704f8 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -580,12 +580,12 @@ TEST_F(tls, recv_partial)
 
 	memset(recv_mem, 0, sizeof(recv_mem));
 	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
-	EXPECT_NE(recv(self->cfd, recv_mem, strlen(test_str_first),
-		       MSG_WAITALL), -1);
+	EXPECT_EQ(recv(self->cfd, recv_mem, strlen(test_str_first),
+		       MSG_WAITALL), strlen(test_str_first));
 	EXPECT_EQ(memcmp(test_str_first, recv_mem, strlen(test_str_first)), 0);
 	memset(recv_mem, 0, sizeof(recv_mem));
-	EXPECT_NE(recv(self->cfd, recv_mem, strlen(test_str_second),
-		       MSG_WAITALL), -1);
+	EXPECT_EQ(recv(self->cfd, recv_mem, strlen(test_str_second),
+		       MSG_WAITALL), strlen(test_str_second));
 	EXPECT_EQ(memcmp(test_str_second, recv_mem, strlen(test_str_second)),
 		  0);
 }

