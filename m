Return-Path: <linux-kernel+bounces-120083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8C88D15B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670D6B25041
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1113FD9B;
	Tue, 26 Mar 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNwqKTHR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309313E6A0;
	Tue, 26 Mar 2024 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492844; cv=none; b=ZIQl+g7b4/VZCgXnNsi6Cwz7lKuxnuHD7FN40A2EHylPvgHLHoIufCyaQlnZL/reN5CsQY+jUbvB874APlcEMQY6czaeX90dge7v5lZ9fsHnquQOYCpAlcjZJXUGgEq47th6ztVVMp/BD7annSK1HMLjvFgsQTaEoTxui6hzz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492844; c=relaxed/simple;
	bh=tQse4PoY13MkqtXj1OkkDnWkTuw3IW3qkT06CpqCxeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bzt5cEzSbEMRRpR8ZPai5ewgfDpAWv/vLKgv1EdeHFM0evJDecfGdGU1HjOqdB9cwwLiHtjCSE0QKxyQ47QqNBLvD/QYmUKE5rhOxKg4OI8PX+bkXbuJya+AXuHp824sOglZt/Lhpc/+qzahQtUwtKDEDZT0VPfQu4jsa66vB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNwqKTHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C7C433C7;
	Tue, 26 Mar 2024 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492844;
	bh=tQse4PoY13MkqtXj1OkkDnWkTuw3IW3qkT06CpqCxeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNwqKTHRIN5XO3yTCX/xqoiKdwnAkLKTHaqx1SQ4OMFm92QdC08oHvEsgf+j/FCWC
	 NT4qBTSdo8ywO5Stsn0vyg0/gv+OQaPe4FwsyXL6uA8lBleGqhBCoz+5ozEtZtqn3Y
	 FVOvkT96enxMc/YfU5cIkWPnUAe/IFt/dlW/AsRs20HAXVJMG7XNm11+gNUgGID56k
	 Jw8lGKiwrc1aNeif/zV+UHHIosHxLj6P+PyP86rA+JxivVyw2GeOn0tRv/L7qt3yiz
	 A2SEAP2hl2REXASXdhVWkk1hV5+tPfU5t2TrAit+EzvMgjx9KqwQ5oaWIjbpKQ3vb1
	 h1DaACFX3A8BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 5.15.153
Date: Tue, 26 Mar 2024 18:40:38 -0400
Message-ID: <20240326224040.2648718-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326224040.2648718-1-sashal@kernel.org>
References: <20240326224040.2648718-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 34b093e7f8910..c4c7273419bda 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1084,8 +1084,12 @@
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
 
-	<module>.async_probe [KNL]
-			Enable asynchronous probe on this module.
+	<module>.async_probe[=<bool>] [KNL]
+			If no <bool> value is specified or if the value
+			specified is not a valid <bool>, enable asynchronous
+			probe on this module.  Otherwise, enable/disable
+			asynchronous probe on this module as indicated by the
+			<bool> value. See also: module.async_probe
 
 	early_ioremap_debug [KNL]
 			Enable debug messages in early_ioremap support. This
@@ -3137,6 +3141,15 @@
 			For details see:
 			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
 
+	module.async_probe=<bool>
+			[KNL] When set to true, modules will use async probing
+			by default. To enable/disable async probing for a
+			specific module, use the module specific control that
+			is documented under <module>.async_probe. When both
+			module.async_probe and <module>.async_probe are
+			specified, <module>.async_probe takes precedence for
+			the specific module.
+
 	module.sig_enforce
 			[KNL] When CONFIG_MODULE_SIG is set, this means that
 			modules without (valid) signatures will fail to load.
diff --git a/Makefile b/Makefile
index 918a73d3976f9..07a0f520f2df7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 152
+SUBLEVEL = 153
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 366687fb1ee39..e794a4bb8f1f2 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -435,7 +435,7 @@ pb1176_serial3: serial@1010f000 {
 
 		/* Direct-mapped development chip ROM */
 		pb1176_rom@10200000 {
-			compatible = "direct-mapped";
+			compatible = "mtd-rom";
 			reg = <0x10200000 0x4000>;
 			bank-width = <1>;
 		};
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index e5c4dc65fbabf..69ad1f198fa71 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -105,8 +105,6 @@ &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <20>;
 	phy-supply = <&sw2_reg>;
 	status = "okay";
 
@@ -119,17 +117,10 @@ mdio {
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
@@ -150,15 +141,30 @@ fixed-link {
 				eth2: port@2 {
 					reg = <2>;
 					label = "eth2";
+					phy-mode = "internal";
 					phy-handle = <&phy_port2>;
 				};
 
 				eth1: port@3 {
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
diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index 433ee4ddce6c8..f85933fdec75f 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -24,8 +24,8 @@
 
 #include "sha256_glue.h"
 
-asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
-					unsigned int num_blks);
+asmlinkage void sha256_block_data_order(struct sha256_state *state,
+					const u8 *data, int num_blks);
 
 int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
@@ -33,23 +33,20 @@ int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
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
index 0635a65aa488b..1be5bd498af36 100644
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
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index b7db95ce0bbf2..d8e5796509fc9 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -180,9 +180,6 @@ ethernet-switch@0 {
 				brcm,num-gphy = <5>;
 				brcm,num-rgmii-ports = <2>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports: ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 49d7470812eef..134192b749942 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -191,8 +191,10 @@ usbnet: usbether@1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	vmmc-supply = <&reg_vdd_3v3>;
 	vqmmc-supply = <&reg_nvcc_sd>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
@@ -275,8 +277,8 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
 		>;
 	};
 
@@ -288,19 +290,19 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x0
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0
 		>;
 	};
 
@@ -312,13 +314,40 @@ MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x90
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
 			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
 			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x94
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x96
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 42bbbb3f532bc..646615ca4b48b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -220,8 +220,8 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000083
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
index 7ea909a4c1d5e..6de00c9dcd349 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -40,17 +40,6 @@ pps {
 		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb1_en>;
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg1_vbus";
-		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
 };
 
 /* off-board header */
@@ -102,9 +91,10 @@ &uart3 {
 };
 
 &usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	dr_mode = "otg";
 	over-current-active-low;
-	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
 };
 
@@ -156,14 +146,6 @@ MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
 		>;
 	};
 
-	pinctrl_reg_usb1_en: regusb1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10	0x41
-			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x141
-			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
-		>;
-	};
-
 	pinctrl_spi2: spi2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
@@ -186,4 +168,11 @@ MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
 			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
 		>;
 	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x141
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
+		>;
+	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 0adc194e46d15..9d147af115831 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -414,14 +414,14 @@ xor11 {
 			crypto: crypto@90000 {
 				compatible = "inside-secure,safexcel-eip97ies";
 				reg = <0x90000 0x20000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "mem", "ring0", "ring1",
-						  "ring2", "ring3", "eip";
+					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "ring0", "ring1", "ring2",
+						  "ring3", "eip", "mem";
 				clocks = <&nb_periph_clk 15>;
 			};
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 3bd2182817fb8..408fc9bfc9627 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -506,14 +506,14 @@ CP11X_LABEL(sdhci0): sdhci@780000 {
 		CP11X_LABEL(crypto): crypto@800000 {
 			compatible = "inside-secure,safexcel-eip197b";
 			reg = <0x800000 0x200000>;
-			interrupts = <87 IRQ_TYPE_LEVEL_HIGH>,
-				<88 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <88 IRQ_TYPE_LEVEL_HIGH>,
 				<89 IRQ_TYPE_LEVEL_HIGH>,
 				<90 IRQ_TYPE_LEVEL_HIGH>,
 				<91 IRQ_TYPE_LEVEL_HIGH>,
-				<92 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mem", "ring0", "ring1",
-				"ring2", "ring3", "eip";
+				<92 IRQ_TYPE_LEVEL_HIGH>,
+				<87 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ring0", "ring1", "ring2", "ring3",
+					  "eip", "mem";
 			clock-names = "core", "reg";
 			clocks = <&CP11X_LABEL(clk) 1 26>,
 				 <&CP11X_LABEL(clk) 1 17>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index cdbd70bf5dd9b..483f7ab4f31c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -71,6 +71,7 @@ red {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index ee454a26b4597..28e17a7e2a5a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -57,6 +57,7 @@ wps {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index c1153580ef958..88fca67dead01 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include "mt8183-kukui.dtsi"
+/* Must come after mt8183-kukui.dtsi to modify cros_ec */
+#include <arm/cros-ec-keyboard.dtsi>
 
 / {
 	panel: panel {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
index 28966a65391b0..fa90708956945 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -372,6 +372,16 @@ pen_eject {
 	};
 };
 
+&cros_ec {
+	cbas {
+		compatible = "google,cros-cbas";
+	};
+
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_KAKADU";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
index 3aa79403c0c2c..03724c80c0804 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -338,6 +338,16 @@ touch_pin_reset: pin_reset {
 	};
 };
 
+&cros_ec {
+	cbas {
+		compatible = "google,cros-cbas";
+	};
+
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_KODAMA";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
index 30c183c96a54c..be0ac786bcbc9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -342,6 +342,16 @@ rst_pin {
 	};
 };
 
+&cros_ec {
+	cbas {
+		compatible = "google,cros-cbas";
+	};
+
+	keyboard-controller {
+		compatible = "google,cros-ec-keyb-switches";
+	};
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "LE_Krane";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6b7a42c5d5153..22a1c66325c29 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -828,8 +828,18 @@ usbc_extcon: extcon0 {
 			google,usb-port-id = <0>;
 		};
 
-		cbas {
-			compatible = "google,cros-cbas";
+		typec {
+			compatible = "google,cros-ec-typec";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "sink";
+			};
 		};
 	};
 };
@@ -917,5 +927,4 @@ hub@1 {
 	};
 };
 
-#include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index 26899fb768a73..ed71a10d023ee 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -583,8 +583,8 @@ hscif3: serial@e66a0000 {
 
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
-			reg = <0 0xe6800000 0 0x800>;
+				     "renesas,etheravb-rcar-gen4";
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
@@ -631,8 +631,8 @@ avb0: ethernet@e6800000 {
 
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
-			reg = <0 0xe6810000 0 0x800>;
+				     "renesas,etheravb-rcar-gen4";
+			reg = <0 0xe6810000 0 0x1000>;
 			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
@@ -679,7 +679,7 @@ avb1: ethernet@e6810000 {
 
 		avb2: ethernet@e6820000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6820000 0 0x1000>;
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
@@ -727,7 +727,7 @@ avb2: ethernet@e6820000 {
 
 		avb3: ethernet@e6830000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6830000 0 0x1000>;
 			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
@@ -775,7 +775,7 @@ avb3: ethernet@e6830000 {
 
 		avb4: ethernet@e6840000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6840000 0 0x1000>;
 			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
@@ -823,7 +823,7 @@ avb4: ethernet@e6840000 {
 
 		avb5: ethernet@e6850000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6850000 0 0x1000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
@@ -935,7 +935,7 @@ scif4: serial@e6c40000 {
 
 		msiof0: spi@e6e90000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6e90000 0 0x0064>;
 			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 618>;
@@ -950,7 +950,7 @@ msiof0: spi@e6e90000 {
 
 		msiof1: spi@e6ea0000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6ea0000 0 0x0064>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 619>;
@@ -965,7 +965,7 @@ msiof1: spi@e6ea0000 {
 
 		msiof2: spi@e6c00000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c00000 0 0x0064>;
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 620>;
@@ -980,7 +980,7 @@ msiof2: spi@e6c00000 {
 
 		msiof3: spi@e6c10000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c10000 0 0x0064>;
 			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
@@ -995,7 +995,7 @@ msiof3: spi@e6c10000 {
 
 		msiof4: spi@e6c20000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c20000 0 0x0064>;
 			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
@@ -1010,7 +1010,7 @@ msiof4: spi@e6c20000 {
 
 		msiof5: spi@e6c28000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c28000 0 0x0064>;
 			interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index daf3cf244ea97..b3e4dd6be7e20 100644
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
index 0a1e75af5382d..44d70fc30aae5 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -81,7 +81,7 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	return 0;
diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 4c69ece52a31e..59ed89890c902 100644
--- a/arch/powerpc/include/asm/vmalloc.h
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -7,14 +7,14 @@
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
 #define arch_vmap_pud_supported arch_vmap_pud_supported
-static inline bool arch_vmap_pud_supported(pgprot_t prot)
+static __always_inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/* HPT does not cope with large pages in the vmalloc area */
 	return radix_enabled();
 }
 
 #define arch_vmap_pmd_supported arch_vmap_pmd_supported
-static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+static __always_inline bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return radix_enabled();
 }
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 28b770bbc10b4..2a054de80e50b 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -164,6 +164,20 @@ static unsigned long single_gpci_request(u32 req, u32 starting_index,
 
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
@@ -228,6 +242,7 @@ static int h_gpci_event_init(struct perf_event *event)
 {
 	u64 count;
 	u8 length;
+	unsigned long ret;
 
 	/* Not our event */
 	if (event->attr.type != event->pmu->type)
@@ -258,13 +273,23 @@ static int h_gpci_event_init(struct perf_event *event)
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
index eb8342e7f84e9..ac3bd4a3216ce 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -100,9 +100,6 @@ static void __init linkstation_init_IRQ(void)
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
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index b40990210fb50..3c621f31b5fd2 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -70,6 +70,7 @@ pmic@58 {
 		interrupt-parent = <&gpio>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		regulators {
 			vdd_bcore1: bcore1 {
diff --git a/arch/s390/include/uapi/asm/dasd.h b/arch/s390/include/uapi/asm/dasd.h
index 9ec86fae99805..188d17fc5f0c1 100644
--- a/arch/s390/include/uapi/asm/dasd.h
+++ b/arch/s390/include/uapi/asm/dasd.h
@@ -78,6 +78,7 @@ typedef struct dasd_information2_t {
  * 0x040: give access to raw eckd data
  * 0x080: enable discard support
  * 0x100: enable autodisable for IFCC errors (default)
+ * 0x200: enable requeue of all requests on autoquiesce
  */
 #define DASD_FEATURE_READONLY	      0x001
 #define DASD_FEATURE_USEDIAG	      0x002
@@ -88,6 +89,7 @@ typedef struct dasd_information2_t {
 #define DASD_FEATURE_USERAW	      0x040
 #define DASD_FEATURE_DISCARD	      0x080
 #define DASD_FEATURE_PATH_AUTODISABLE 0x100
+#define DASD_FEATURE_REQUEUEQUIESCE   0x200
 #define DASD_FEATURE_DEFAULT	      DASD_FEATURE_PATH_AUTODISABLE
 
 #define DASD_PARTN_BITS 2
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 245bddfe9bc0e..cc513add48eb5 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_32 += -m31 -s
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin
 
-LDFLAGS_vdso32.so.dbg += -fPIC -shared -soname=linux-vdso32.so.1 \
+LDFLAGS_vdso32.so.dbg += -shared -soname=linux-vdso32.so.1 \
 	--hash-style=both --build-id=sha1 -melf_s390 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 1605ba45ac4c0..42d918d50a1ff 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -26,7 +26,7 @@ KBUILD_AFLAGS_64 += -m64 -s
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin
-ldflags-y := -fPIC -shared -soname=linux-vdso64.so.1 \
+ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index f216a1b2f8257..86137029235ac 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -211,13 +211,13 @@ void vtime_flush(struct task_struct *tsk)
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
 
 static u64 vtime_delta(void)
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
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index ab60a71a8dcb9..472f0263dbc61 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -4,6 +4,7 @@
 
 #include <linux/seqlock.h>
 #include <uapi/asm/vsyscall.h>
+#include <asm/page_types.h>
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 extern void map_vsyscall(void);
@@ -24,4 +25,13 @@ static inline bool emulate_vsyscall(unsigned long error_code,
 }
 #endif
 
+/*
+ * The (legacy) vsyscall page is the long page in the kernel portion
+ * of the address space that has user-accessible permissions.
+ */
+static inline bool is_vsyscall_vaddr(unsigned long vaddr)
+{
+	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
+}
+
 #endif /* _ASM_X86_VSYSCALL_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4bfed53e210ec..abc6fbc3d5f21 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -787,15 +787,6 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 	show_opcodes(regs, loglvl);
 }
 
-/*
- * The (legacy) vsyscall page is the long page in the kernel portion
- * of the address space that has user-accessible permissions.
- */
-static bool is_vsyscall_vaddr(unsigned long vaddr)
-{
-	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
-}
-
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, u32 pkey, int si_code)
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 6993f026adec9..42115ac079cfe 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -3,6 +3,8 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
+#include <asm/vsyscall.h>
+
 #ifdef CONFIG_X86_64
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
@@ -15,6 +17,14 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
 		return false;
 
+	/*
+	 * Reading from the vsyscall page may cause an unhandled fault in
+	 * certain cases.  Though it is at an address above TASK_SIZE_MAX, it is
+	 * usually considered as a user space address.
+	 */
+	if (is_vsyscall_vaddr(vaddr))
+		return false;
+
 	/*
 	 * Allow everything during early boot before 'x86_virt_bits'
 	 * is initialized.  Needed for instruction decoding in early
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27c82207d3878..3167228ca1746 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -599,6 +599,14 @@ static void print_absolute_relocs(void)
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
index cdec892b28e2e..a641e0d452194 100644
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
index b486b3ec7dc41..a50191bddbc26 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -66,6 +66,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 0ac5a4f3f2261..00e4d23ac49e7 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -895,16 +895,20 @@ static int response_parse(const u8 *buf, size_t length,
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
index e9116db1e3527..4cb44d80bf520 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1424,6 +1424,8 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 		acpi_processor_registered--;
 		if (acpi_processor_registered == 0)
 			cpuidle_unregister_driver(&acpi_idle_driver);
+
+		kfree(dev);
 	}
 
 	pr->flags.power_setup_done = 0;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a364cb07c5578..0f533aff23a17 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -546,6 +546,39 @@ static const struct dmi_system_id lg_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
 		},
 	},
+	{
+		/* Infinity E15-5A165-BM */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
+		},
+	},
+	{
+		/* Infinity E15-5A305-1M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
+		},
+	},
+	{
+		/* Lunnen Ground 15 / AMD Ryzen 5 5500U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LLL5DAW"),
+		},
+	},
+	{
+		/* Lunnen Ground 16 / AMD Ryzen 7 5800U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LL6FA"),
+		},
+	},
+	{
+		/* MAIBENBEN X577 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
+			DMI_MATCH(DMI_BOARD_NAME, "X577"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ae74720888dbf..2393cd993b3cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -315,18 +315,14 @@ static int acpi_scan_device_check(struct acpi_device *adev)
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
index 6adb345866610..893b0615935e9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1836,7 +1836,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 				 map->format.reg_bytes +
 				 map->format.pad_bytes +
 				 val_len);
-	else if (map->bus->gather_write)
+	else if (map->bus && map->bus->gather_write)
 		ret = map->bus->gather_write(map->bus_context, map->work_buf,
 					     map->format.reg_bytes +
 					     map->format.pad_bytes,
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 588889bea7c30..a6e5306f725b3 100644
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
index d379a047d4273..d12e9f1721c8e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2344,6 +2344,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
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
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index be04d74037d20..0f3943ac54179 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -566,6 +566,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		config.type = ELF_TYPE_PATCH;
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/msbtfw%02x.mbn", rom_ver);
+	} else if (soc_type == QCA_WCN6855) {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hpbtfw%02x.tlv", rom_ver);
 	} else {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/rampatch_%08x.bin", soc_ver);
@@ -600,6 +603,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	else if (soc_type == QCA_WCN6750)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/msnv%02x.bin", rom_ver);
+	else if (soc_type == QCA_WCN6855)
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hpnv%02x.bin", rom_ver);
 	else
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/nvm_%08x.bin", soc_ver);
@@ -637,11 +643,17 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		return err;
 	}
 
-	if (soc_type == QCA_WCN3991 || soc_type == QCA_WCN6750) {
+	switch (soc_type) {
+	case QCA_WCN3991:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
 		/* get fw build info */
 		err = qca_read_fw_build_info(hdev);
 		if (err < 0)
 			return err;
+		break;
+	default:
+		break;
 	}
 
 	bt_dev_info(hdev, "QCA setup on UART is completed");
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 30afa7703afd3..b83bf202ea604 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -145,6 +145,7 @@ enum qca_btsoc_type {
 	QCA_WCN3991,
 	QCA_QCA6390,
 	QCA_WCN6750,
+	QCA_WCN6855,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
@@ -166,6 +167,10 @@ static inline bool qca_is_wcn6750(enum qca_btsoc_type soc_type)
 {
 	return soc_type == QCA_WCN6750;
 }
+static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
+{
+	return soc_type == QCA_WCN6855;
+}
 
 #else
 
@@ -204,6 +209,11 @@ static inline bool qca_is_wcn6750(enum qca_btsoc_type soc_type)
 	return false;
 }
 
+static inline bool qca_is_wcn6855(enum qca_btsoc_type soc_type)
+{
+	return false;
+}
+
 static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d10f1fe0f5fa8..d5f408851a005 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1315,7 +1315,8 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	/* Give the controller time to process the request */
 	if (qca_is_wcn399x(qca_soc_type(hu)) ||
-	    qca_is_wcn6750(qca_soc_type(hu)))
+	    qca_is_wcn6750(qca_soc_type(hu)) ||
+	    qca_is_wcn6855(qca_soc_type(hu)))
 		usleep_range(1000, 10000);
 	else
 		msleep(300);
@@ -1392,7 +1393,8 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 static int qca_check_speeds(struct hci_uart *hu)
 {
 	if (qca_is_wcn399x(qca_soc_type(hu)) ||
-	    qca_is_wcn6750(qca_soc_type(hu))) {
+	    qca_is_wcn6750(qca_soc_type(hu)) ||
+	    qca_is_wcn6855(qca_soc_type(hu))) {
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
 		    !qca_get_speed(hu, QCA_OPER_SPEED))
 			return -EINVAL;
@@ -1426,7 +1428,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		 * changing the baudrate of chip and host.
 		 */
 		if (qca_is_wcn399x(soc_type) ||
-		    qca_is_wcn6750(soc_type))
+		    qca_is_wcn6750(soc_type) ||
+		    qca_is_wcn6855(soc_type))
 			hci_uart_set_flow_control(hu, true);
 
 		if (soc_type == QCA_WCN3990) {
@@ -1444,7 +1447,8 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 error:
 		if (qca_is_wcn399x(soc_type) ||
-		    qca_is_wcn6750(soc_type))
+		    qca_is_wcn6750(soc_type) ||
+		    qca_is_wcn6855(soc_type))
 			hci_uart_set_flow_control(hu, false);
 
 		if (soc_type == QCA_WCN3990) {
@@ -1680,7 +1684,8 @@ static int qca_power_on(struct hci_dev *hdev)
 		return 0;
 
 	if (qca_is_wcn399x(soc_type) ||
-	    qca_is_wcn6750(soc_type)) {
+	    qca_is_wcn6750(soc_type) ||
+	    qca_is_wcn6855(soc_type)) {
 		ret = qca_regulator_init(hu);
 	} else {
 		qcadev = serdev_device_get_drvdata(hu->serdev);
@@ -1721,7 +1726,8 @@ static int qca_setup(struct hci_uart *hu)
 
 	bt_dev_info(hdev, "setting up %s",
 		qca_is_wcn399x(soc_type) ? "wcn399x" :
-		(soc_type == QCA_WCN6750) ? "wcn6750" : "ROME/QCA6390");
+		(soc_type == QCA_WCN6750) ? "wcn6750" :
+		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
 
 	qca->memdump_state = QCA_MEMDUMP_IDLE;
 
@@ -1733,7 +1739,8 @@ static int qca_setup(struct hci_uart *hu)
 	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
 
 	if (qca_is_wcn399x(soc_type) ||
-	    qca_is_wcn6750(soc_type)) {
+	    qca_is_wcn6750(soc_type) ||
+	    qca_is_wcn6855(soc_type)) {
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
@@ -1754,7 +1761,8 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	if (!(qca_is_wcn399x(soc_type) ||
-	     qca_is_wcn6750(soc_type))) {
+	      qca_is_wcn6750(soc_type) ||
+	      qca_is_wcn6855(soc_type))) {
 		/* Get QCA version information */
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
@@ -1880,6 +1888,20 @@ static const struct qca_device_data qca_soc_data_wcn6750 = {
 	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
+static const struct qca_device_data qca_soc_data_wcn6855 = {
+	.soc_type = QCA_WCN6855,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 5000 },
+		{ "vddbtcxmx", 126000 },
+		{ "vddrfacmn", 12500 },
+		{ "vddrfa0p8", 102000 },
+		{ "vddrfa1p7", 302000 },
+		{ "vddrfa1p2", 257000 },
+	},
+	.num_vregs = 6,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+};
+
 static void qca_power_shutdown(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
@@ -1909,7 +1931,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		host_set_baudrate(hu, 2400);
 		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
-	} else if (soc_type == QCA_WCN6750) {
+	} else if (soc_type == QCA_WCN6750 || soc_type == QCA_WCN6855) {
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
 		qca_regulator_disable(qcadev);
@@ -2044,7 +2066,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	if (data &&
 	    (qca_is_wcn399x(data->soc_type) ||
-	    qca_is_wcn6750(data->soc_type))) {
+	     qca_is_wcn6750(data->soc_type) ||
+	     qca_is_wcn6855(data->soc_type))) {
 		qcadev->btsoc_type = data->soc_type;
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
@@ -2064,14 +2087,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en) && data->soc_type == QCA_WCN6750) {
+		if (IS_ERR(qcadev->bt_en) &&
+		    (data->soc_type == QCA_WCN6750 ||
+		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
 			power_ctrl_enabled = false;
 		}
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) && data->soc_type == QCA_WCN6750)
+		if (IS_ERR(qcadev->sw_ctrl) &&
+		    (data->soc_type == QCA_WCN6750 ||
+		     data->soc_type == QCA_WCN6855))
 			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
@@ -2093,7 +2120,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
@@ -2147,8 +2174,9 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_power *power = qcadev->bt_power;
 
 	if ((qca_is_wcn399x(qcadev->btsoc_type) ||
-	     qca_is_wcn6750(qcadev->btsoc_type)) &&
-	     power->vregs_on)
+	     qca_is_wcn6750(qcadev->btsoc_type) ||
+	     qca_is_wcn6855(qcadev->btsoc_type)) &&
+	    power->vregs_on)
 		qca_power_shutdown(&qcadev->serdev_hu);
 	else if (qcadev->susclk)
 		clk_disable_unprepare(qcadev->susclk);
@@ -2332,6 +2360,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
+	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index a4cf3d692dc30..d224f5f7a7405 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -175,11 +175,12 @@ config SUNXI_RSB
 
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
index bf9057a8fbf06..84397af4fb336 100644
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
diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 9ea1a80acbe8b..0272276550ff1 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -491,7 +491,6 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 
 		clk = clk_register(NULL, &p_clk->hw);
 		if (IS_ERR(clk)) {
-			devm_kfree(dev, p_clk);
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 2ad3801398dc1..7802dabb26f6d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -2144,7 +2144,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_vclk_input,
 	&axg_vclk2_input,
 	&axg_vclk_div,
+	&axg_vclk_div1,
 	&axg_vclk2_div,
+	&axg_vclk2_div1,
 	&axg_vclk_div2_en,
 	&axg_vclk_div4_en,
 	&axg_vclk_div6_en,
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 735adfefc3798..e792e0b130d33 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -759,6 +759,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x3000,
+	.en_few_wait_val = 0x6,
+	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index e45e32804d2c7..d96c96a9089f4 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -22,8 +22,8 @@ static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 	return 0;
 }
 
-static int
-qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
 	struct qcom_reset_controller *rst;
 	const struct qcom_reset_map *map;
@@ -33,21 +33,22 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 	map = &rst->reset_map[id];
 	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
+	regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
+
+	/* Read back the register to ensure write completion, ignore the value */
+	regmap_read(rst->regmap, map->reg, &mask);
+
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
-	mask = map->bitmask ? map->bitmask : BIT(map->bit);
+	return qcom_reset_set_assert(rcdev, id, true);
+}
 
-	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
+static int qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return qcom_reset_set_assert(rcdev, id, false);
 }
 
 const struct reset_control_ops qcom_reset_ops = {
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 204b83d911b90..c615664505a55 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -42,6 +42,7 @@ static void __iomem *zynq_clkc_base;
 #define SLCR_SWDT_CLK_SEL		(zynq_clkc_base + 0x204)
 
 #define NUM_MIO_PINS	54
+#define CLK_NAME_LEN	16
 
 #define DBG_CLK_CTRL_CLKACT_TRC		BIT(0)
 #define DBG_CLK_CTRL_CPU_1XCLKACT	BIT(1)
@@ -215,7 +216,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	int i;
 	u32 tmp;
 	int ret;
-	char *clk_name;
+	char clk_name[CLK_NAME_LEN];
 	unsigned int fclk_enable = 0;
 	const char *clk_output_name[clk_max];
 	const char *cpu_parents[4];
@@ -425,12 +426,10 @@ static void __init zynq_clk_setup(struct device_node *np)
 			"gem1_emio_mux", CLK_SET_RATE_PARENT,
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
 
-	tmp = strlen("mio_clk_00x");
-	clk_name = kmalloc(tmp, GFP_KERNEL);
 	for (i = 0; i < NUM_MIO_PINS; i++) {
 		int idx;
 
-		snprintf(clk_name, tmp, "mio_clk_%2.2d", i);
+		snprintf(clk_name, CLK_NAME_LEN, "mio_clk_%2.2d", i);
 		idx = of_property_match_string(np, "clock-names", clk_name);
 		if (idx >= 0)
 			can_mio_mux_parents[i] = of_clk_get_parent_name(np,
@@ -438,7 +437,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 		else
 			can_mio_mux_parents[i] = dummy_nm;
 	}
-	kfree(clk_name);
 	clk_register_mux(NULL, "can_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
 			&canclk_lock);
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index cbc225eb19918..bea9a3adf08c8 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -87,6 +87,8 @@ struct waveform_private {
 	struct comedi_device *dev;	/* parent comedi device */
 	u64 ao_last_scan_time;		/* time of previous AO scan in usec */
 	unsigned int ao_scan_period;	/* AO scan period in usec */
+	bool ai_timer_enable:1;		/* should AI timer be running? */
+	bool ao_timer_enable:1;		/* should AO timer be running? */
 	unsigned short ao_loopbacks[N_CHANS];
 };
 
@@ -236,8 +238,12 @@ static void waveform_ai_timer(struct timer_list *t)
 			time_increment = devpriv->ai_convert_time - now;
 		else
 			time_increment = 1;
-		mod_timer(&devpriv->ai_timer,
-			  jiffies + usecs_to_jiffies(time_increment));
+		spin_lock(&dev->spinlock);
+		if (devpriv->ai_timer_enable) {
+			mod_timer(&devpriv->ai_timer,
+				  jiffies + usecs_to_jiffies(time_increment));
+		}
+		spin_unlock(&dev->spinlock);
 	}
 
 overrun:
@@ -393,9 +399,12 @@ static int waveform_ai_cmd(struct comedi_device *dev,
 	 * Seem to need an extra jiffy here, otherwise timer expires slightly
 	 * early!
 	 */
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ai_timer_enable = true;
 	devpriv->ai_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ai_convert_period) + 1;
 	add_timer(&devpriv->ai_timer);
+	spin_unlock_bh(&dev->spinlock);
 	return 0;
 }
 
@@ -404,6 +413,9 @@ static int waveform_ai_cancel(struct comedi_device *dev,
 {
 	struct waveform_private *devpriv = dev->private;
 
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ai_timer_enable = false;
+	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ai_timer);
@@ -495,8 +507,12 @@ static void waveform_ao_timer(struct timer_list *t)
 		unsigned int time_inc = devpriv->ao_last_scan_time +
 					devpriv->ao_scan_period - now;
 
-		mod_timer(&devpriv->ao_timer,
-			  jiffies + usecs_to_jiffies(time_inc));
+		spin_lock(&dev->spinlock);
+		if (devpriv->ao_timer_enable) {
+			mod_timer(&devpriv->ao_timer,
+				  jiffies + usecs_to_jiffies(time_inc));
+		}
+		spin_unlock(&dev->spinlock);
 	}
 
 underrun:
@@ -517,9 +533,12 @@ static int waveform_ao_inttrig_start(struct comedi_device *dev,
 	async->inttrig = NULL;
 
 	devpriv->ao_last_scan_time = ktime_to_us(ktime_get());
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ao_timer_enable = true;
 	devpriv->ao_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ao_scan_period);
 	add_timer(&devpriv->ao_timer);
+	spin_unlock_bh(&dev->spinlock);
 
 	return 1;
 }
@@ -604,6 +623,9 @@ static int waveform_ao_cancel(struct comedi_device *dev,
 	struct waveform_private *devpriv = dev->private;
 
 	s->async->inttrig = NULL;
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ao_timer_enable = false;
+	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ao_timer);
diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b74289a95a171..bea41ccabf1f0 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -14,10 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index f644c5e325fb2..38ec0fedb247f 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,6 +481,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return 0;
 	struct private_data *priv = policy->driver_data;
 
 	cpufreq_cpu_put(policy);
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 0cf18dd46b923..314c1cb6e8f4d 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -10,8 +10,10 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define LUT_MAX_ENTRIES			32U
@@ -267,7 +269,23 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {
 static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
 	const void *data;
-	int ret;
+	int ret, cpu;
+	struct device *cpu_dev;
+	struct regulator *cpu_reg;
+
+	/* Make sure that all CPU supplies are available before proceeding. */
+	for_each_possible_cpu(cpu) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev)
+			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+					     "Failed to get cpu%d device\n", cpu);
+
+		cpu_reg = devm_regulator_get(cpu_dev, "cpu");
+		if (IS_ERR(cpu_reg))
+			return dev_err_probe(&pdev->dev, PTR_ERR(cpu_reg),
+					     "CPU%d regulator get failed\n", cpu);
+	}
+
 
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data)
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index c58abb4cca3a2..acaa8db57812d 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -9,7 +9,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 037fe23bc6ed0..e85fa0f41991c 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
 #include <linux/pm_qos.h>
 
 #include <asm/processor.h>
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 6e011e8bfb6a9..63fc879e23096 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index bda3e7d429647..763692e327b18 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -22,7 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index fdb0a722d8812..f1cde44670689 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 8f9fdd864391a..88bffa0bd0139 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index d295f405c4bb0..865e501648034 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -18,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
diff --git a/drivers/crypto/xilinx/zynqmp-aes-gcm.c b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
index bf1f421e05f25..74bd3eb63734d 100644
--- a/drivers/crypto/xilinx/zynqmp-aes-gcm.c
+++ b/drivers/crypto/xilinx/zynqmp-aes-gcm.c
@@ -231,7 +231,10 @@ static int zynqmp_handle_aes_req(struct crypto_engine *engine,
 		err = zynqmp_aes_aead_cipher(areq);
 	}
 
+	local_bh_disable();
 	crypto_finalize_aead_request(engine, areq, err);
+	local_bh_enable();
+
 	return 0;
 }
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e1beddcc8c84a..143fb0f8c07fa 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -645,16 +645,16 @@ config TEGRA20_APB_DMA
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 675a72ef305da..ea5470c8c9212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -169,6 +169,7 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
 	return 0;
 
 err_free:
+	ttm_resource_fini(man, &node->base.base);
 	kfree(node);
 
 err_out:
@@ -200,6 +201,7 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
 	if (!(res->placement & TTM_PL_FLAG_TEMPORARY))
 		atomic64_sub(res->num_pages, &mgr->used);
 
+	ttm_resource_fini(man, res);
 	kfree(node);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index d02c8637f909f..ffddec08e931f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -95,6 +95,7 @@ static void amdgpu_preempt_mgr_del(struct ttm_resource_manager *man,
 	struct amdgpu_preempt_mgr *mgr = to_preempt_mgr(man);
 
 	atomic64_sub(res->num_pages, &mgr->used);
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7b2b0980ec412..55d68408951d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -476,6 +476,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	while (i--)
 		drm_mm_remove_node(&node->mm_nodes[i]);
 	spin_unlock(&mgr->lock);
+	ttm_resource_fini(man, &node->base);
 	kvfree(node);
 
 error_sub:
@@ -515,6 +516,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 	atomic64_sub(usage, &mgr->usage);
 	atomic64_sub(vis_usage, &mgr->vis_usage);
 
+	ttm_resource_fini(man, res);
 	kvfree(node);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 6fa2229b72292..c279718d22fba 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -311,7 +311,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		return 0;
+		break;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 6a3486f52d698..ef5b3eedc8615 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -605,11 +605,34 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		return AMD_RESET_METHOD_MODE1;
 }
 
+static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
+	 * 2) S3 suspend abort and TOS already launched.
+	 */
+	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
+			!adev->suspend_complete &&
+			sol_reg)
+		return true;
+
+	return false;
+}
+
 static int soc15_asic_reset(struct amdgpu_device *adev)
 {
 	/* original raven doesn't have full asic reset */
-	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
-	    (adev->apu_flags & AMD_APU_IS_RAVEN2))
+	/* On the latest Raven, the GPU reset can be performed
+	 * successfully. So now, temporarily enable it for the
+	 * S3 suspend abort case.
+	 */
+	if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
+	    (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
+		!soc15_need_reset_on_resume(adev))
 		return 0;
 
 	switch (soc15_asic_reset_method(adev)) {
@@ -1490,24 +1513,6 @@ static int soc15_common_suspend(void *handle)
 	return soc15_common_hw_fini(adev);
 }
 
-static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
-{
-	u32 sol_reg;
-
-	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
-
-	/* Will reset for the following suspend abort cases.
-	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
-	 * 2) S3 suspend abort and TOS already launched.
-	 */
-	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!adev->suspend_complete &&
-			sol_reg)
-		return true;
-
-	return false;
-}
-
 static int soc15_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6d694cea24201..ed2f6802b0e20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1304,7 +1304,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
-	int i, r, str_len = 30;
+	int i, r, str_len = 10;
 
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index aa5a1fa68da05..bc603c8af3b66 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1745,6 +1745,9 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	if (!stream)
+		return false;
+
 	if (dpp == NULL)
 		return false;
 
@@ -1767,8 +1770,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	} else
 		dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_BYPASS);
 
-	if (stream != NULL && stream->ctx != NULL &&
-			stream->out_transfer_func != NULL) {
+	if (stream->ctx &&
+	    stream->out_transfer_func) {
 		log_tf(stream->ctx,
 				stream->out_transfer_func,
 				dpp->regamma_params.hw_points_num);
diff --git a/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c b/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
index 6877362f6b85f..5740087f9ce93 100644
--- a/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
+++ b/drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
@@ -109,6 +109,7 @@ static int i915_ttm_buddy_man_alloc(struct ttm_resource_manager *man,
 	i915_buddy_free_list(mm, &bman_res->blocks);
 	mutex_unlock(&bman->lock);
 err_free_res:
+	ttm_resource_fini(man, &bman_res->base);
 	kfree(bman_res);
 	return err;
 }
@@ -123,6 +124,7 @@ static void i915_ttm_buddy_man_free(struct ttm_resource_manager *man,
 	i915_buddy_free_list(&bman->mm, &bman_res->blocks);
 	mutex_unlock(&bman->lock);
 
+	ttm_resource_fini(man, res);
 	kfree(bman_res);
 }
 
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 09ea621a4806c..65c4327b6d10c 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -74,29 +74,34 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 	} else {
 		bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
 		if (!bo->base.sgt) {
-			sg_free_table(&sgt);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_out0;
 		}
 	}
 
 	ret = dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
-	if (ret) {
-		sg_free_table(&sgt);
-		kfree(bo->base.sgt);
-		bo->base.sgt = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_out1;
 
 	*bo->base.sgt = sgt;
 
 	if (vm) {
 		ret = lima_vm_map_bo(vm, bo, old_size >> PAGE_SHIFT);
 		if (ret)
-			return ret;
+			goto err_out2;
 	}
 
 	bo->heap_size = new_size;
 	return 0;
+
+err_out2:
+	dma_unmap_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
+err_out1:
+	kfree(bo->base.sgt);
+	bo->base.sgt = NULL;
+err_out0:
+	sg_free_table(&sgt);
+	return ret;
 }
 
 int lima_gem_create_handle(struct drm_device *dev, struct drm_file *file,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index d6781e54b3356..1a038fa004668 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -92,11 +92,13 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
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
index 57eaf111b6a8a..3b55a83b7cdff 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -70,8 +70,8 @@
 #define DSI_PS_WC			0x3fff
 #define DSI_PS_SEL			(3 << 16)
 #define PACKED_PS_16BIT_RGB565		(0 << 16)
-#define LOOSELY_PS_18BIT_RGB666		(1 << 16)
-#define PACKED_PS_18BIT_RGB666		(2 << 16)
+#define PACKED_PS_18BIT_RGB666		(1 << 16)
+#define LOOSELY_PS_24BIT_RGB666		(2 << 16)
 #define PACKED_PS_24BIT_RGB888		(3 << 16)
 
 #define DSI_VSA_NL		0x20
@@ -366,10 +366,10 @@ static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
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
@@ -423,7 +423,7 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		tmp_reg = LOOSELY_PS_18BIT_RGB666;
+		tmp_reg = LOOSELY_PS_24BIT_RGB666;
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 185379b185725..7c58e9ba71b77 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -267,12 +267,14 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
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
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index da58230bcb1fc..2048eac841ddf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1186,6 +1186,8 @@ nouveau_ttm_io_mem_reserve(struct ttm_device *bdev, struct ttm_resource *reg)
 			drm_vma_node_unmap(&nvbo->bo.base.vma_node,
 					   bdev->dev_mapping);
 			nouveau_ttm_io_mem_free_locked(drm, nvbo->bo.resource);
+			nvbo->bo.resource->bus.offset = 0;
+			nvbo->bo.resource->bus.addr = NULL;
 			goto retry;
 		}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_mem.c b/drivers/gpu/drm/nouveau/nouveau_mem.c
index 2ca3207c13fcd..2e517cdc24c9c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_mem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_mem.c
@@ -162,11 +162,12 @@ nouveau_mem_vram(struct ttm_resource *reg, bool contig, u8 page)
 }
 
 void
-nouveau_mem_del(struct ttm_resource *reg)
+nouveau_mem_del(struct ttm_resource_manager *man, struct ttm_resource *reg)
 {
 	struct nouveau_mem *mem = nouveau_mem(reg);
 
 	nouveau_mem_fini(mem);
+	ttm_resource_fini(man, reg);
 	kfree(mem);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_mem.h b/drivers/gpu/drm/nouveau/nouveau_mem.h
index 2c01166a90f25..325551eba5cd4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_mem.h
+++ b/drivers/gpu/drm/nouveau/nouveau_mem.h
@@ -23,7 +23,8 @@ nouveau_mem(struct ttm_resource *reg)
 
 int nouveau_mem_new(struct nouveau_cli *, u8 kind, u8 comp,
 		    struct ttm_resource **);
-void nouveau_mem_del(struct ttm_resource *);
+void nouveau_mem_del(struct ttm_resource_manager *man,
+		     struct ttm_resource *);
 int nouveau_mem_vram(struct ttm_resource *, bool contig, u8 page);
 int nouveau_mem_host(struct ttm_resource *, struct ttm_tt *);
 void nouveau_mem_fini(struct nouveau_mem *);
diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index 2ca9d9a9e5d5e..91ef33f8f22cb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -36,9 +36,10 @@
 #include <core/tegra.h>
 
 static void
-nouveau_manager_del(struct ttm_resource_manager *man, struct ttm_resource *reg)
+nouveau_manager_del(struct ttm_resource_manager *man,
+		    struct ttm_resource *reg)
 {
-	nouveau_mem_del(reg);
+	nouveau_mem_del(man, reg);
 }
 
 static int
@@ -62,7 +63,7 @@ nouveau_vram_manager_new(struct ttm_resource_manager *man,
 
 	ret = nouveau_mem_vram(*res, nvbo->contig, nvbo->page);
 	if (ret) {
-		nouveau_mem_del(*res);
+		nouveau_mem_del(man, *res);
 		return ret;
 	}
 
@@ -118,7 +119,7 @@ nv04_gart_manager_new(struct ttm_resource_manager *man,
 	ret = nvif_vmm_get(&mem->cli->vmm.vmm, PTES, false, 12, 0,
 			   (long)(*res)->num_pages << PAGE_SHIFT, &mem->vma[0]);
 	if (ret) {
-		nouveau_mem_del(*res);
+		nouveau_mem_del(man, *res);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 4a364ca7a1be7..b041b6bfaeca6 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -813,7 +813,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 			err = 0;
 		} else if (rdev->smc_fw->size != smc_req_size) {
 			pr_err("ni_mc: Bogus length %zu in firmware \"%s\"\n",
-			       rdev->mc_fw->size, fw_name);
+			       rdev->smc_fw->size, fw_name);
 			err = -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 78120da5e63aa..27540d308ccb9 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -402,7 +402,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -417,7 +417,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 2550429df49fe..d3a7f8d94b781 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -572,8 +572,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		ret = -EINVAL;
 		goto err_put_port;
 	} else if (ret) {
-		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
-		ret = -EPROBE_DEFER;
+		dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
 		goto err_put_port;
 	}
 	if (lvds->panel)
diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 1650a448eabd6..b09a500934f73 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -5,6 +5,7 @@ config DRM_TEGRA
 	depends on COMMON_CLK
 	depends on DRM
 	depends on OF
+	select DRM_DP_AUX_BUS
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index abb409b08bc64..f44a64e896587 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1762,10 +1762,9 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 	return 0;
 }
 
-static void tegra_dc_commit_state(struct tegra_dc *dc,
-				  struct tegra_dc_state *state)
+static void tegra_dc_set_clock_rate(struct tegra_dc *dc,
+				    struct tegra_dc_state *state)
 {
-	u32 value;
 	int err;
 
 	err = clk_set_parent(dc->clk, state->clk);
@@ -1796,11 +1795,6 @@ static void tegra_dc_commit_state(struct tegra_dc *dc,
 	DRM_DEBUG_KMS("rate: %lu, div: %u\n", clk_get_rate(dc->clk),
 		      state->div);
 	DRM_DEBUG_KMS("pclk: %lu\n", state->pclk);
-
-	if (!dc->soc->has_nvdisplay) {
-		value = SHIFT_CLK_DIVIDER(state->div) | PIXEL_CLK_DIVIDER_PCD1;
-		tegra_dc_writel(dc, value, DC_DISP_DISP_CLOCK_CONTROL);
-	}
 }
 
 static void tegra_dc_stop(struct tegra_dc *dc)
@@ -2002,6 +1996,9 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 	u32 value;
 	int err;
 
+	/* apply PLL changes */
+	tegra_dc_set_clock_rate(dc, crtc_state);
+
 	err = host1x_client_resume(&dc->client);
 	if (err < 0) {
 		dev_err(dc->dev, "failed to resume: %d\n", err);
@@ -2076,8 +2073,11 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 	else
 		tegra_dc_writel(dc, 0, DC_DISP_BORDER_COLOR);
 
-	/* apply PLL and pixel clock changes */
-	tegra_dc_commit_state(dc, crtc_state);
+	/* apply pixel clock changes */
+	if (!dc->soc->has_nvdisplay) {
+		value = SHIFT_CLK_DIVIDER(crtc_state->div) | PIXEL_CLK_DIVIDER_PCD1;
+		tegra_dc_writel(dc, value, DC_DISP_DISP_CLOCK_CONTROL);
+	}
 
 	/* program display mode */
 	tegra_dc_set_timings(dc, mode);
@@ -2685,6 +2685,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = true,
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -2707,6 +2708,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = true,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2729,6 +2731,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = true,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2751,6 +2754,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2773,6 +2777,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
@@ -2823,6 +2828,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.wgrps = tegra186_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra186_dc_wgrps),
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = false,
 };
 
 static const struct tegra_windowgroup_soc tegra194_dc_wgrps[] = {
@@ -2873,6 +2879,7 @@ static const struct tegra_dc_soc_info tegra194_dc_soc_info = {
 	.wgrps = tegra194_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra194_dc_wgrps),
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = false,
 };
 
 static const struct of_device_id tegra_dc_of_match[] = {
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 40378308d527a..c9c4c45c05183 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -76,6 +76,7 @@ struct tegra_dc_soc_info {
 	bool has_win_b_vfilter_mem_client;
 	bool has_win_c_without_vert_filter;
 	bool plane_tiled_memory_bandwidth_x2;
+	bool has_pll_d2_out0;
 };
 
 struct tegra_dc {
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index c96c07c6458c3..a99f82dc7e6f7 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 
 #include <drm/drm_dp_helper.h>
+#include <drm/drm_dp_aux_bus.h>
 #include <drm/drm_panel.h>
 
 #include "dp.h"
@@ -524,7 +525,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(dpaux->dev, "failed to request IRQ#%u: %d\n",
 			dpaux->irq, err);
-		return err;
+		goto err_pm_disable;
 	}
 
 	disable_irq(dpaux->irq);
@@ -544,7 +545,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	 */
 	err = tegra_dpaux_pad_config(dpaux, DPAUX_PADCTL_FUNC_I2C);
 	if (err < 0)
-		return err;
+		goto err_pm_disable;
 
 #ifdef CONFIG_GENERIC_PINCONF
 	dpaux->desc.name = dev_name(&pdev->dev);
@@ -557,7 +558,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	dpaux->pinctrl = devm_pinctrl_register(&pdev->dev, &dpaux->desc, dpaux);
 	if (IS_ERR(dpaux->pinctrl)) {
 		dev_err(&pdev->dev, "failed to register pincontrol\n");
-		return PTR_ERR(dpaux->pinctrl);
+		err = PTR_ERR(dpaux->pinctrl);
+		goto err_pm_disable;
 	}
 #endif
 	/* enable and clear all interrupts */
@@ -570,7 +572,18 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	list_add_tail(&dpaux->list, &dpaux_list);
 	mutex_unlock(&dpaux_lock);
 
+	err = devm_of_dp_aux_populate_ep_devices(&dpaux->aux);
+	if (err < 0) {
+		dev_err(dpaux->dev, "failed to populate AUX bus: %d\n", err);
+		goto err_pm_disable;
+	}
+
 	return 0;
+
+err_pm_disable:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return err;
 }
 
 static int tegra_dpaux_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index de1333dc0d867..7bb26655cb3cc 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1534,9 +1534,11 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
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
@@ -1584,48 +1586,58 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 
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
 
 	dsi->mipi = tegra_mipi_request(&pdev->dev, pdev->dev.of_node);
-	if (IS_ERR(dsi->mipi))
-		return PTR_ERR(dsi->mipi);
+	if (IS_ERR(dsi->mipi)) {
+		err = PTR_ERR(dsi->mipi);
+		goto remove;
+	}
 
 	dsi->host.ops = &tegra_dsi_host_ops;
 	dsi->host.dev = &pdev->dev;
@@ -1653,9 +1665,12 @@ static int tegra_dsi_probe(struct platform_device *pdev)
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
index cae8b8cbe9dd0..6e35c7951dfb2 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -165,6 +165,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 47d26b5d99456..7ccd010a821b7 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -139,8 +139,10 @@ int tegra_output_probe(struct tegra_output *output)
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
@@ -149,7 +151,7 @@ int tegra_output_probe(struct tegra_output *output)
 		err = gpiod_to_irq(output->hpd_gpio);
 		if (err < 0) {
 			dev_err(output->dev, "gpiod_to_irq(): %d\n", err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->hpd_irq = err;
@@ -162,7 +164,7 @@ int tegra_output_probe(struct tegra_output *output)
 		if (err < 0) {
 			dev_err(output->dev, "failed to request IRQ#%u: %d\n",
 				output->hpd_irq, err);
-			return err;
+			goto put_i2c;
 		}
 
 		output->connector.polled = DRM_CONNECTOR_POLL_HPD;
@@ -176,6 +178,12 @@ int tegra_output_probe(struct tegra_output *output)
 	}
 
 	return 0;
+
+put_i2c:
+	if (output->ddc)
+		i2c_put_adapter(output->ddc);
+
+	return err;
 }
 
 void tegra_output_remove(struct tegra_output *output)
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 606c78a2b988f..761cfd49c4876 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -17,6 +17,8 @@ struct tegra_rgb {
 	struct tegra_output output;
 	struct tegra_dc *dc;
 
+	struct clk *pll_d_out0;
+	struct clk *pll_d2_out0;
 	struct clk *clk_parent;
 	struct clk *clk;
 };
@@ -123,6 +125,18 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	tegra_dc_commit(rgb->dc);
 }
 
+static bool tegra_rgb_pll_rate_change_allowed(struct tegra_rgb *rgb)
+{
+	if (!rgb->pll_d2_out0)
+		return false;
+
+	if (!clk_is_match(rgb->clk_parent, rgb->pll_d_out0) &&
+	    !clk_is_match(rgb->clk_parent, rgb->pll_d2_out0))
+		return false;
+
+	return true;
+}
+
 static int
 tegra_rgb_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_crtc_state *crtc_state,
@@ -151,8 +165,17 @@ tegra_rgb_encoder_atomic_check(struct drm_encoder *encoder,
 	 * and hope that the desired frequency can be matched (or at least
 	 * matched sufficiently close that the panel will still work).
 	 */
-	div = ((clk_get_rate(rgb->clk) * 2) / pclk) - 2;
-	pclk = 0;
+	if (tegra_rgb_pll_rate_change_allowed(rgb)) {
+		/*
+		 * Set display controller clock to x2 of PCLK in order to
+		 * produce higher resolution pulse positions.
+		 */
+		div = 2;
+		pclk *= 2;
+	} else {
+		div = ((clk_get_rate(rgb->clk) * 2) / pclk) - 2;
+		pclk = 0;
+	}
 
 	err = tegra_dc_state_setup_clock(dc, crtc_state, rgb->clk_parent,
 					 pclk, div);
@@ -195,31 +218,61 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 	rgb->clk = devm_clk_get(dc->dev, NULL);
 	if (IS_ERR(rgb->clk)) {
 		dev_err(dc->dev, "failed to get clock\n");
-		return PTR_ERR(rgb->clk);
+		err = PTR_ERR(rgb->clk);
+		goto remove;
 	}
 
 	rgb->clk_parent = devm_clk_get(dc->dev, "parent");
 	if (IS_ERR(rgb->clk_parent)) {
 		dev_err(dc->dev, "failed to get parent clock\n");
-		return PTR_ERR(rgb->clk_parent);
+		err = PTR_ERR(rgb->clk_parent);
+		goto remove;
 	}
 
 	err = clk_set_parent(rgb->clk, rgb->clk_parent);
 	if (err < 0) {
 		dev_err(dc->dev, "failed to set parent clock: %d\n", err);
-		return err;
+		goto remove;
+	}
+
+	rgb->pll_d_out0 = clk_get_sys(NULL, "pll_d_out0");
+	if (IS_ERR(rgb->pll_d_out0)) {
+		err = PTR_ERR(rgb->pll_d_out0);
+		dev_err(dc->dev, "failed to get pll_d_out0: %d\n", err);
+		goto remove;
+	}
+
+	if (dc->soc->has_pll_d2_out0) {
+		rgb->pll_d2_out0 = clk_get_sys(NULL, "pll_d2_out0");
+		if (IS_ERR(rgb->pll_d2_out0)) {
+			err = PTR_ERR(rgb->pll_d2_out0);
+			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
+			goto put_pll;
+		}
 	}
 
 	dc->rgb = &rgb->output;
 
 	return 0;
+
+put_pll:
+	clk_put(rgb->pll_d_out0);
+remove:
+	tegra_output_remove(&rgb->output);
+	return err;
 }
 
 int tegra_dc_rgb_remove(struct tegra_dc *dc)
 {
+	struct tegra_rgb *rgb;
+
 	if (!dc->rgb)
 		return 0;
 
+	rgb = to_rgb(dc->rgb);
+	clk_put(rgb->pll_d2_out0);
+	clk_put(rgb->pll_d_out0);
+
 	tegra_output_remove(dc->rgb);
 	dc->rgb = NULL;
 
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 217415ec8eea1..8ccd7d31c01b3 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -210,7 +210,7 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
 
 	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
 
-	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
+	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
 				       num_planes - 1);
 
 	ret = drm_plane_create_color_properties(&tplane->plane,
diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
index f4b08a8705b32..69962b5769c54 100644
--- a/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -89,6 +89,7 @@ static int ttm_range_man_alloc(struct ttm_resource_manager *man,
 	spin_unlock(&rman->lock);
 
 	if (unlikely(ret)) {
+		ttm_resource_fini(man, *res);
 		kfree(node);
 		return ret;
 	}
@@ -108,6 +109,7 @@ static void ttm_range_man_free(struct ttm_resource_manager *man,
 	drm_mm_remove_node(&node->mm_nodes[0]);
 	spin_unlock(&rman->lock);
 
+	ttm_resource_fini(man, res);
 	kfree(node);
 }
 
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 2431717376e70..2c590b4c46cb7 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -29,6 +29,14 @@
 #include <drm/ttm/ttm_resource.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
+/**
+ * ttm_resource_init - resource object constructure
+ * @bo: buffer object this resources is allocated for
+ * @place: placement of the resource
+ * @res: the resource object to inistilize
+ *
+ * Initialize a new resource object. Counterpart of &ttm_resource_fini.
+ */
 void ttm_resource_init(struct ttm_buffer_object *bo,
                        const struct ttm_place *place,
                        struct ttm_resource *res)
@@ -44,6 +52,21 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_resource_init);
 
+/**
+ * ttm_resource_fini - resource destructor
+ * @man: the resource manager this resource belongs to
+ * @res: the resource to clean up
+ *
+ * Should be used by resource manager backends to clean up the TTM resource
+ * objects before freeing the underlying structure. Counterpart of
+ * &ttm_resource_init
+ */
+void ttm_resource_fini(struct ttm_resource_manager *man,
+		       struct ttm_resource *res)
+{
+}
+EXPORT_SYMBOL(ttm_resource_fini);
+
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res_ptr)
diff --git a/drivers/gpu/drm/ttm/ttm_sys_manager.c b/drivers/gpu/drm/ttm/ttm_sys_manager.c
index 63aca52f75e12..135394dcca95a 100644
--- a/drivers/gpu/drm/ttm/ttm_sys_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_sys_manager.c
@@ -23,6 +23,7 @@ static int ttm_sys_man_alloc(struct ttm_resource_manager *man,
 static void ttm_sys_man_free(struct ttm_resource_manager *man,
 			     struct ttm_resource *res)
 {
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
index b2c4af331c9d5..eef7bab8bc3a6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -64,8 +64,11 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 	ttm_resource_init(bo, place, *res);
 
 	id = ida_alloc_max(&gman->gmr_ida, gman->max_gmr_ids - 1, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ttm_resource_fini(man, *res);
+		kfree(*res);
 		return id;
+	}
 
 	spin_lock(&gman->lock);
 
@@ -116,6 +119,7 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 	gman->used_gmr_pages -= (*res)->num_pages;
 	spin_unlock(&gman->lock);
 	ida_free(&gman->gmr_ida, id);
+	ttm_resource_fini(man, *res);
 	kfree(*res);
 	return -ENOSPC;
 }
@@ -129,6 +133,7 @@ static void vmw_gmrid_man_put_node(struct ttm_resource_manager *man,
 	spin_lock(&gman->lock);
 	gman->used_gmr_pages -= res->num_pages;
 	spin_unlock(&gman->lock);
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c
index b0005b03a6174..a64188c7268d5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_system_manager.c
@@ -49,6 +49,7 @@ static int vmw_sys_man_alloc(struct ttm_resource_manager *man,
 static void vmw_sys_man_free(struct ttm_resource_manager *man,
 			     struct ttm_resource *res)
 {
+	ttm_resource_fini(man, res);
 	kfree(res);
 }
 
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 2d3203d3daeb3..90f39bfe8050e 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -119,10 +119,10 @@ enum mem_use_type {
 struct hpd_status {
 	union {
 		struct {
-			u32 human_presence_report : 4;
-			u32 human_presence_actual : 4;
-			u32 probablity		  : 8;
 			u32 object_distance       : 16;
+			u32 probablity		  : 8;
+			u32 human_presence_actual : 4;
+			u32 human_presence_report : 4;
 		} shpd;
 		u32 val;
 	};
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 965bddaa90aee..44fd4a05ace38 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -53,10 +53,10 @@ struct lenovo_drvdata {
 	/* 0: Up
 	 * 1: Down (undecided)
 	 * 2: Scrolling
-	 * 3: Patched firmware, disable workaround
 	 */
 	u8 middlebutton_state;
 	bool fn_lock;
+	bool middleclick_workaround_cptkbd;
 };
 
 #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
@@ -469,6 +469,36 @@ static ssize_t attr_sensitivity_store_cptkbd(struct device *dev,
 	return count;
 }
 
+static ssize_t attr_middleclick_workaround_show_cptkbd(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+		cptkbd_data->middleclick_workaround_cptkbd);
+}
+
+static ssize_t attr_middleclick_workaround_store_cptkbd(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
+	int value;
+
+	if (kstrtoint(buf, 10, &value))
+		return -EINVAL;
+	if (value < 0 || value > 1)
+		return -EINVAL;
+
+	cptkbd_data->middleclick_workaround_cptkbd = !!value;
+
+	return count;
+}
+
 
 static struct device_attribute dev_attr_fn_lock =
 	__ATTR(fn_lock, S_IWUSR | S_IRUGO,
@@ -480,10 +510,16 @@ static struct device_attribute dev_attr_sensitivity_cptkbd =
 			attr_sensitivity_show_cptkbd,
 			attr_sensitivity_store_cptkbd);
 
+static struct device_attribute dev_attr_middleclick_workaround_cptkbd =
+	__ATTR(middleclick_workaround, S_IWUSR | S_IRUGO,
+			attr_middleclick_workaround_show_cptkbd,
+			attr_middleclick_workaround_store_cptkbd);
+
 
 static struct attribute *lenovo_attributes_cptkbd[] = {
 	&dev_attr_fn_lock.attr,
 	&dev_attr_sensitivity_cptkbd.attr,
+	&dev_attr_middleclick_workaround_cptkbd.attr,
 	NULL
 };
 
@@ -534,23 +570,7 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 {
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	if (cptkbd_data->middlebutton_state != 3) {
-		/* REL_X and REL_Y events during middle button pressed
-		 * are only possible on patched, bug-free firmware
-		 * so set middlebutton_state to 3
-		 * to never apply workaround anymore
-		 */
-		if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD &&
-				cptkbd_data->middlebutton_state == 1 &&
-				usage->type == EV_REL &&
-				(usage->code == REL_X || usage->code == REL_Y)) {
-			cptkbd_data->middlebutton_state = 3;
-			/* send middle button press which was hold before */
-			input_event(field->hidinput->input,
-				EV_KEY, BTN_MIDDLE, 1);
-			input_sync(field->hidinput->input);
-		}
-
+	if (cptkbd_data->middleclick_workaround_cptkbd) {
 		/* "wheel" scroll events */
 		if (usage->type == EV_REL && (usage->code == REL_WHEEL ||
 				usage->code == REL_HWHEEL)) {
@@ -1015,6 +1035,7 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 	cptkbd_data->middlebutton_state = 0;
 	cptkbd_data->fn_lock = true;
 	cptkbd_data->sensitivity = 0x05;
+	cptkbd_data->middleclick_workaround_cptkbd = true;
 	lenovo_features_set_cptkbd(hdev);
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_cptkbd);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fc04538d93cbb..2e14e3071aa69 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2151,6 +2151,10 @@ static const struct hid_device_id mt_devices[] = {
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
index 2c2ac63b39c42..725f2719132fb 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1729,7 +1729,7 @@ static int assign_client_id(struct ib_client *client)
 {
 	int ret;
 
-	down_write(&clients_rwsem);
+	lockdep_assert_held(&clients_rwsem);
 	/*
 	 * The add/remove callbacks must be called in FIFO/LIFO order. To
 	 * achieve this we assign client_ids so they are sorted in
@@ -1738,14 +1738,11 @@ static int assign_client_id(struct ib_client *client)
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
@@ -1775,25 +1772,35 @@ int ib_register_client(struct ib_client *client)
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
index 104e5cbba066b..ef3585af40263 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2922,7 +2922,7 @@ DECLARE_UVERBS_NAMED_METHOD(
 	MLX5_IB_METHOD_DEVX_OBJ_MODIFY,
 	UVERBS_ATTR_IDR(MLX5_IB_ATTR_DEVX_OBJ_MODIFY_HANDLE,
 			UVERBS_IDR_ANY_OBJECT,
-			UVERBS_ACCESS_WRITE,
+			UVERBS_ACCESS_READ,
 			UA_MANDATORY),
 	UVERBS_ATTR_PTR_IN(
 		MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN,
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 8841620af82f1..b81d282fb0d52 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -128,7 +128,7 @@ static void set_eth_seg(const struct ib_send_wr *wr, struct mlx5_ib_qp *qp,
 		 */
 		copysz = min_t(u64, *cur_edge - (void *)eseg->inline_hdr.start,
 			       left);
-		memcpy(eseg->inline_hdr.start, pdata, copysz);
+		memcpy(eseg->inline_hdr.data, pdata, copysz);
 		stride = ALIGN(sizeof(struct mlx5_wqe_eth_seg) -
 			       sizeof(eseg->inline_hdr.start) + copysz, 16);
 		*size += stride / 16;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index dbf9a778c3bd7..583c38eb04326 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -131,7 +131,7 @@ static ssize_t mpath_policy_store(struct device *dev,
 
 	/* distinguish "mi" and "min-latency" with length */
 	len = strnlen(buf, NAME_MAX);
-	if (buf[len - 1] == '\n')
+	if (len && buf[len - 1] == '\n')
 		len--;
 
 	if (!strncasecmp(buf, "round-robin", 11) ||
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 60f9c612eb3c3..1b44ce0ac991c 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3209,7 +3209,6 @@ static int srpt_add_one(struct ib_device *device)
 
 	INIT_IB_EVENT_HANDLER(&sdev->event_handler, sdev->device,
 			      srpt_event_handler);
-	ib_register_event_handler(&sdev->event_handler);
 
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
@@ -3232,6 +3231,7 @@ static int srpt_add_one(struct ib_device *device)
 		}
 	}
 
+	ib_register_event_handler(&sdev->event_handler);
 	spin_lock(&srpt_dev_lock);
 	list_add_tail(&sdev->list, &srpt_dev_list);
 	spin_unlock(&srpt_dev_lock);
@@ -3242,7 +3242,6 @@ static int srpt_add_one(struct ib_device *device)
 
 err_port:
 	srpt_unregister_mad_agent(sdev, i);
-	ib_unregister_event_handler(&sdev->event_handler);
 err_cm:
 	if (sdev->cm_id)
 		ib_destroy_cm_id(sdev->cm_id);
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index c3937d2fc7446..a0f9978c68f55 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -319,12 +319,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
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
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 50ea582be5910..ef855495c210e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1821,6 +1821,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	/* Prevent binding other PCI device drivers to IOMMU devices */
 	iommu->dev->match_driver = false;
 
+	/* ACPI _PRT won't have an IRQ for IOMMU */
+	iommu->dev->irq_managed = 1;
+
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index dc9d665d7365c..589b97ff5433c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -508,6 +508,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (!info || !info->ats_enabled)
 		return;
 
+	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+		return;
+
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index f4f831570f11c..e72017b11098b 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -114,8 +114,11 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 				"failed to enable regulator: %d\n", ret);
 			return ret;
 		}
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
 	} else {
+		del_timer_sync(&priv->powerdown_timer);
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
 		if (ret) {
diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 80d937454aeef..f7d9795ce5e1f 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -397,6 +397,7 @@ static int aw2013_probe(struct i2c_client *client)
 	regulator_disable(chip->vcc_regulator);
 
 error:
+	mutex_unlock(&chip->mutex);
 	mutex_destroy(&chip->mutex);
 	return ret;
 }
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5904af05f6057..a3db76dcdb3ec 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -49,11 +49,11 @@
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
index 8d489933d5792..04769fb20cf7f 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3329,14 +3329,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
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
index 78d1e51195ada..f61c89c79cf5b 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -74,11 +74,11 @@ struct dm_verity_io {
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
index d6285a23dc3ed..fd9bb8b53219a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2641,6 +2641,9 @@ static void __dm_internal_suspend(struct mapped_device *md, unsigned suspend_fla
 
 static void __dm_internal_resume(struct mapped_device *md)
 {
+	int r;
+	struct dm_table *map;
+
 	BUG_ON(!md->internal_suspend_count);
 
 	if (--md->internal_suspend_count)
@@ -2649,12 +2652,23 @@ static void __dm_internal_resume(struct mapped_device *md)
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
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a17f2f725822a..c937ad7f6b73a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6230,7 +6230,15 @@ static void md_clean(struct mddev *mddev)
 	mddev->persistent = 0;
 	mddev->level = LEVEL_NONE;
 	mddev->clevel[0] = 0;
-	mddev->flags = 0;
+	/*
+	 * Don't clear MD_CLOSING, or mddev can be opened again.
+	 * 'hold_active != 0' means mddev is still in the creation
+	 * process and will be used later.
+	 */
+	if (mddev->hold_active)
+		mddev->flags = 0;
+	else
+		mddev->flags &= BIT_ULL_MASK(MD_CLOSING);
 	mddev->sb_flags = 0;
 	mddev->ro = MD_RDWR;
 	mddev->metadata_type[0] = 0;
@@ -7550,7 +7558,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
 		return -ENOTTY;
@@ -7637,7 +7644,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 			err = -EBUSY;
 			goto out;
 		}
-		did_set_md_closing = true;
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
@@ -7800,7 +7806,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 		mddev->hold_active = 0;
 	mddev_unlock(mddev);
 out:
-	if(did_set_md_closing)
+	if (cmd == STOP_ARRAY_RO || (err && cmd == STOP_ARRAY))
 		clear_bit(MD_CLOSING, &mddev->flags);
 	return err;
 }
diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
index 7607b516a7c43..68968bfa2edc1 100644
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
index 3a83e8e092568..23a0c209744dc 100644
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
index 3205cd8298dd8..4c6852dc40a90 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2108,9 +2108,6 @@ static int tc358743_probe(struct i2c_client *client)
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2168,6 +2165,10 @@ static int tc358743_probe(struct i2c_client *client)
 	if (err)
 		goto err_work_queues;
 
+	err = v4l2_async_register_subdev(sd);
+	if (err < 0)
+		goto err_work_queues;
+
 	v4l2_info(sd, "%s found @ 0x%x (%s)\n", client->name,
 		  client->addr << 1, client->adapter->name);
 
diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index 3cb83005cf09b..519f85e0a397d 100644
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
@@ -1471,9 +1472,10 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
 		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
-			/* fixme: proper cleanup here */
-			ERR("cannot register capture v4l2 device\n");
 			saa7146_vv_release(dev);
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
+			ERR("cannot register capture v4l2 device\n");
 			return err;
 		}
 
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c b/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c
index b065ccd069140..378a1cba0144f 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_vpu.c
@@ -26,7 +26,7 @@ static void mtk_mdp_vpu_handle_init_ack(const struct mdp_ipi_comm_ack *msg)
 	vpu->inst_addr = msg->vpu_inst_addr;
 }
 
-static void mtk_mdp_vpu_ipi_handler(const void *data, unsigned int len,
+static void mtk_mdp_vpu_ipi_handler(void *data, unsigned int len,
 				    void *priv)
 {
 	const struct mdp_ipi_comm_ack *msg = data;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
index cfc7ebed8fb7a..1ec29f1b163a1 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
@@ -29,15 +29,7 @@ static int mtk_vcodec_vpu_set_ipi_register(struct mtk_vcodec_fw *fw, int id,
 					   mtk_vcodec_ipi_handler handler,
 					   const char *name, void *priv)
 {
-	/*
-	 * The handler we receive takes a void * as its first argument. We
-	 * cannot change this because it needs to be passed down to the rproc
-	 * subsystem when SCP is used. VPU takes a const argument, which is
-	 * more constrained, so the conversion below is safe.
-	 */
-	ipi_handler_t handler_const = (ipi_handler_t)handler;
-
-	return vpu_ipi_register(fw->pdev, id, handler_const, name, priv);
+	return vpu_ipi_register(fw->pdev, id, handler, name, priv);
 }
 
 static int mtk_vcodec_vpu_ipi_send(struct mtk_vcodec_fw *fw, int id, void *buf,
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index af59cc52fdd73..e282bbae8f668 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -635,7 +635,7 @@ int vpu_load_firmware(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(vpu_load_firmware);
 
-static void vpu_init_ipi_handler(const void *data, unsigned int len, void *priv)
+static void vpu_init_ipi_handler(void *data, unsigned int len, void *priv)
 {
 	struct mtk_vpu *vpu = priv;
 	const struct vpu_run *run = data;
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.h b/drivers/media/platform/mtk-vpu/mtk_vpu.h
index a56053ff135af..da05f3e740810 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.h
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.h
@@ -17,7 +17,7 @@
  * VPU interfaces with other blocks by share memory and interrupt.
  */
 
-typedef void (*ipi_handler_t) (const void *data,
+typedef void (*ipi_handler_t) (void *data,
 			       unsigned int len,
 			       void *priv);
 
diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index 671e4a928993d..dd289c7c93bc2 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -66,6 +66,7 @@ static void deinterlace_device_run(void *priv)
 	struct vb2_v4l2_buffer *src, *dst;
 	unsigned int hstep, vstep;
 	dma_addr_t addr;
+	int i;
 
 	src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
@@ -160,6 +161,26 @@ static void deinterlace_device_run(void *priv)
 	deinterlace_write(dev, DEINTERLACE_CH1_HORZ_FACT, hstep);
 	deinterlace_write(dev, DEINTERLACE_CH1_VERT_FACT, vstep);
 
+	/* neutral filter coefficients */
+	deinterlace_set_bits(dev, DEINTERLACE_FRM_CTRL,
+			     DEINTERLACE_FRM_CTRL_COEF_ACCESS);
+	readl_poll_timeout(dev->base + DEINTERLACE_STATUS, val,
+			   val & DEINTERLACE_STATUS_COEF_STATUS, 2, 40);
+
+	for (i = 0; i < 32; i++) {
+		deinterlace_write(dev, DEINTERLACE_CH0_HORZ_COEF0 + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH0_VERT_COEF + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH1_HORZ_COEF0 + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH1_VERT_COEF + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+	}
+
+	deinterlace_clr_set_bits(dev, DEINTERLACE_FRM_CTRL,
+				 DEINTERLACE_FRM_CTRL_COEF_ACCESS, 0);
+
 	deinterlace_clr_set_bits(dev, DEINTERLACE_FIELD_CTRL,
 				 DEINTERLACE_FIELD_CTRL_FIELD_CNT_MSK,
 				 DEINTERLACE_FIELD_CTRL_FIELD_CNT(ctx->field));
@@ -248,7 +269,6 @@ static irqreturn_t deinterlace_irq(int irq, void *data)
 static void deinterlace_init(struct deinterlace_dev *dev)
 {
 	u32 val;
-	int i;
 
 	deinterlace_write(dev, DEINTERLACE_BYPASS,
 			  DEINTERLACE_BYPASS_CSC);
@@ -284,27 +304,7 @@ static void deinterlace_init(struct deinterlace_dev *dev)
 
 	deinterlace_clr_set_bits(dev, DEINTERLACE_CHROMA_DIFF,
 				 DEINTERLACE_CHROMA_DIFF_TH_MSK,
-				 DEINTERLACE_CHROMA_DIFF_TH(5));
-
-	/* neutral filter coefficients */
-	deinterlace_set_bits(dev, DEINTERLACE_FRM_CTRL,
-			     DEINTERLACE_FRM_CTRL_COEF_ACCESS);
-	readl_poll_timeout(dev->base + DEINTERLACE_STATUS, val,
-			   val & DEINTERLACE_STATUS_COEF_STATUS, 2, 40);
-
-	for (i = 0; i < 32; i++) {
-		deinterlace_write(dev, DEINTERLACE_CH0_HORZ_COEF0 + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH0_VERT_COEF + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH1_HORZ_COEF0 + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH1_VERT_COEF + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-	}
-
-	deinterlace_clr_set_bits(dev, DEINTERLACE_FRM_CTRL,
-				 DEINTERLACE_FRM_CTRL_COEF_ACCESS, 0);
+				 DEINTERLACE_CHROMA_DIFF_TH(31));
 }
 
 static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
@@ -933,11 +933,18 @@ static int deinterlace_runtime_resume(struct device *device)
 		return ret;
 	}
 
+	ret = reset_control_deassert(dev->rstc);
+	if (ret) {
+		dev_err(dev->dev, "Failed to apply reset\n");
+
+		goto err_exclusive_rate;
+	}
+
 	ret = clk_prepare_enable(dev->bus_clk);
 	if (ret) {
 		dev_err(dev->dev, "Failed to enable bus clock\n");
 
-		goto err_exclusive_rate;
+		goto err_rst;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
@@ -954,23 +961,16 @@ static int deinterlace_runtime_resume(struct device *device)
 		goto err_mod_clk;
 	}
 
-	ret = reset_control_deassert(dev->rstc);
-	if (ret) {
-		dev_err(dev->dev, "Failed to apply reset\n");
-
-		goto err_ram_clk;
-	}
-
 	deinterlace_init(dev);
 
 	return 0;
 
-err_ram_clk:
-	clk_disable_unprepare(dev->ram_clk);
 err_mod_clk:
 	clk_disable_unprepare(dev->mod_clk);
 err_bus_clk:
 	clk_disable_unprepare(dev->bus_clk);
+err_rst:
+	reset_control_assert(dev->rstc);
 err_exclusive_rate:
 	clk_rate_exclusive_put(dev->mod_clk);
 
@@ -981,11 +981,12 @@ static int deinterlace_runtime_suspend(struct device *device)
 {
 	struct deinterlace_dev *dev = dev_get_drvdata(device);
 
-	reset_control_assert(dev->rstc);
-
 	clk_disable_unprepare(dev->ram_clk);
 	clk_disable_unprepare(dev->mod_clk);
 	clk_disable_unprepare(dev->bus_clk);
+
+	reset_control_assert(dev->rstc);
+
 	clk_rate_exclusive_put(dev->mod_clk);
 
 	return 0;
diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 92d867fc519c4..8ab10518957c4 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -4099,6 +4099,10 @@ static int em28xx_usb_probe(struct usb_interface *intf,
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
index 6650eab913d81..3c66542ce284a 100644
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
index eeb85981e02b6..762c13e49bfa5 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1201,7 +1201,9 @@ static int go7007_usb_probe(struct usb_interface *intf,
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
index 9657c18833116..29f2e767f236f 100644
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
diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 8aeed39c415f2..5677bccd583e9 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1062,11 +1062,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
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
index 5d3715a28b28e..dbe1009943718 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -110,7 +110,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
 					    (void *)sysmgr_np);
-	of_node_put(sysmgr_np);
+	if (property)
+		of_node_put(sysmgr_np);
+
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 552b1861adad4..75c732ee9ed6e 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -224,7 +224,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 
 	regmap = syscon_node_to_regmap(syscon_np);
-	of_node_put(syscon_np);
+
+	if (property)
+		of_node_put(syscon_np);
 
 	return regmap;
 }
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 3933195488575..3fcc81e48ad66 100644
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
index 9ab795f03c546..e5552093585e2 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -528,7 +528,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (!info->maps[i].phys)
 			info->maps[i].phys = res->start;
 
-		info->win_order = get_bitmask_order(resource_size(res)) - 1;
+		info->win_order = fls64(resource_size(res)) - 1;
 		info->maps[i].size = BIT(info->win_order +
 					 (info->gpios ?
 					  info->gpios->ndescs : 0));
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 452ecaf7775ac..1cfe3dd0bad4d 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -303,8 +303,9 @@ static int lpc32xx_nand_device_ready(struct nand_chip *nand_chip)
 	return 0;
 }
 
-static irqreturn_t lpc3xxx_nand_irq(int irq, struct lpc32xx_nand_host *host)
+static irqreturn_t lpc3xxx_nand_irq(int irq, void *data)
 {
+	struct lpc32xx_nand_host *host = data;
 	uint8_t sr;
 
 	/* Clear interrupt flag by reading status */
@@ -779,7 +780,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto release_dma_chan;
 	}
 
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+	if (request_irq(host->irq, &lpc3xxx_nand_irq,
 			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
 		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
 		res = -ENXIO;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f74d9fbd08178..14c47e614d337 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/bitfield.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <net/dsa.h>
@@ -993,11 +994,55 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
+/* On page 205, section "8.6.3 Frame filtering" of the active standard, IEEE Std
+ * 802.1Q™-2022, it is stated that frames with 01:80:C2:00:00:00-0F as MAC DA
+ * must only be propagated to C-VLAN and MAC Bridge components. That means
+ * VLAN-aware and VLAN-unaware bridges. On the switch designs with CPU ports,
+ * these frames are supposed to be processed by the CPU (software). So we make
+ * the switch only forward them to the CPU port. And if received from a CPU
+ * port, forward to a single port. The software is responsible of making the
+ * switch conform to the latter by setting a single port as destination port on
+ * the special tag.
+ *
+ * This switch intellectual property cannot conform to this part of the standard
+ * fully. Whilst the REV_UN frame tag covers the remaining :04-0D and :0F MAC
+ * DAs, it also includes :22-FF which the scope of propagation is not supposed
+ * to be restricted for these MAC DAs.
+ */
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
 {
-	/* Trap BPDUs to the CPU port(s) */
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress them
+	 * VLAN-untagged.
+	 */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_EG_TAG_MASK |
+		   MT753X_PAE_PORT_FW_MASK | MT753X_BPDU_EG_TAG_MASK |
+		   MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	mt7530_rmw(priv, MT753X_RGAC1, MT753X_R02_EG_TAG_MASK |
+		   MT753X_R02_PORT_FW_MASK | MT753X_R01_EG_TAG_MASK |
+		   MT753X_R01_PORT_FW_MASK,
+		   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_EG_TAG_MASK |
+		   MT753X_R0E_PORT_FW_MASK | MT753X_R03_EG_TAG_MASK |
+		   MT753X_R03_PORT_FW_MASK,
+		   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
 		   MT753X_BPDU_CPU_ONLY);
 }
 
@@ -2154,11 +2199,11 @@ mt7530_setup(struct dsa_switch *ds)
 	 */
 	if (priv->mcm) {
 		reset_control_assert(priv->rstc);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
 		gpiod_set_value_cansleep(priv->reset, 0);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		gpiod_set_value_cansleep(priv->reset, 1);
 	}
 
@@ -2368,11 +2413,11 @@ mt7531_setup(struct dsa_switch *ds)
 	 */
 	if (priv->mcm) {
 		reset_control_assert(priv->rstc);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
 		gpiod_set_value_cansleep(priv->reset, 0);
-		usleep_range(1000, 1100);
+		usleep_range(5000, 5100);
 		gpiod_set_value_cansleep(priv->reset, 1);
 	}
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 91508e2feef95..03598f9ae288c 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -64,8 +64,34 @@ enum mt753x_id {
 
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
+#define  MT753X_PAE_EG_TAG_MASK		GENMASK(24, 22)
+#define  MT753X_PAE_EG_TAG(x)		FIELD_PREP(MT753X_PAE_EG_TAG_MASK, x)
+#define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_PAE_PORT_FW(x)		FIELD_PREP(MT753X_PAE_PORT_FW_MASK, x)
+#define  MT753X_BPDU_EG_TAG_MASK	GENMASK(8, 6)
+#define  MT753X_BPDU_EG_TAG(x)		FIELD_PREP(MT753X_BPDU_EG_TAG_MASK, x)
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
 
+/* Register for :01 and :02 MAC DA frame control */
+#define MT753X_RGAC1			0x28
+#define  MT753X_R02_EG_TAG_MASK		GENMASK(24, 22)
+#define  MT753X_R02_EG_TAG(x)		FIELD_PREP(MT753X_R02_EG_TAG_MASK, x)
+#define  MT753X_R02_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_R02_PORT_FW(x)		FIELD_PREP(MT753X_R02_PORT_FW_MASK, x)
+#define  MT753X_R01_EG_TAG_MASK		GENMASK(8, 6)
+#define  MT753X_R01_EG_TAG(x)		FIELD_PREP(MT753X_R01_EG_TAG_MASK, x)
+#define  MT753X_R01_PORT_FW_MASK	GENMASK(2, 0)
+
+/* Register for :03 and :0E MAC DA frame control */
+#define MT753X_RGAC2			0x2c
+#define  MT753X_R0E_EG_TAG_MASK		GENMASK(24, 22)
+#define  MT753X_R0E_EG_TAG(x)		FIELD_PREP(MT753X_R0E_EG_TAG_MASK, x)
+#define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
+#define  MT753X_R03_EG_TAG_MASK		GENMASK(8, 6)
+#define  MT753X_R03_EG_TAG(x)		FIELD_PREP(MT753X_R03_EG_TAG_MASK, x)
+#define  MT753X_R03_PORT_FW_MASK	GENMASK(2, 0)
+
 enum mt753x_bpdu_port_fw {
 	MT753X_BPDU_FOLLOW_MFC,
 	MT753X_BPDU_CPU_EXCLUDE = 4,
@@ -245,6 +271,7 @@ enum mt7530_port_mode {
 enum mt7530_vlan_port_eg_tag {
 	MT7530_VLAN_EG_DISABLED = 0,
 	MT7530_VLAN_EG_CONSISTENT = 1,
+	MT7530_VLAN_EG_UNTAGGED = 4,
 };
 
 enum mt7530_vlan_port_attr {
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 7d4b862be783d..43c099141e211 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3187,22 +3187,6 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
 static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -3372,7 +3356,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_open		= ena_open,
 	.ndo_stop		= ena_close,
 	.ndo_start_xmit		= ena_start_xmit,
-	.ndo_select_queue	= ena_select_queue,
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index d8b1824c334d3..0bc1367fd6492 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1002,9 +1002,6 @@ static inline void bnx2x_set_fw_mac_addr(__le16 *fw_hi, __le16 *fw_mid,
 static inline void bnx2x_free_rx_mem_pool(struct bnx2x *bp,
 					  struct bnx2x_alloc_pool *pool)
 {
-	if (!pool->page)
-		return;
-
 	put_page(pool->page);
 
 	pool->page = NULL;
@@ -1015,6 +1012,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 12274c2b9feab..598da1be22ebe 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2803,7 +2803,10 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	int ret;
 
 	hdev->support_sfp_query = true;
-	hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
+	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
+
 	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
 					 hdev->hw.mac.duplex);
 	if (ret)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index befa9bcc2f2f2..dd0750f6daa6c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -120,7 +120,7 @@ void hclge_ptp_get_rx_hwts(struct hnae3_handle *handle, struct sk_buff *skb,
 	u64 ns = nsec;
 	u32 sec_h;
 
-	if (!test_bit(HCLGE_PTP_FLAG_RX_EN, &hdev->ptp->flags))
+	if (!hdev->ptp || !test_bit(HCLGE_PTP_FLAG_RX_EN, &hdev->ptp->flags))
 		return;
 
 	/* Since the BD does not have enough space for the higher 16 bits of
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7c42a99be5065..03a4da6a14478 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6756,77 +6756,75 @@ void igb_update_stats(struct igb_adapter *adapter)
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
index 1a269a2e61fdb..3ade1a6e2f1e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1205,7 +1205,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index f64509b1d120c..bac42e0065c6c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2435,10 +2435,9 @@ static void rvu_queue_work(struct mbox_wq_info *mw, int first,
 	}
 }
 
-static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq)
 {
 	struct rvu *rvu = (struct rvu *)rvu_irq;
-	int vfs = rvu->vfs;
 	u64 intr;
 
 	intr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT);
@@ -2452,6 +2451,18 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 
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
@@ -2779,7 +2790,7 @@ static int rvu_register_interrupts(struct rvu *rvu)
 	/* Register mailbox interrupt handler */
 	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
 	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu_mbox_intr_handler, 0,
+			  rvu_mbox_pf_intr_handler, 0,
 			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
 	if (ret) {
 		dev_err(rvu->dev,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 139dfdb1e58bd..711acc6059a4f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -223,8 +223,8 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 	struct mtk_mac *mac = container_of(config, struct mtk_mac,
 					   phylink_config);
 	struct mtk_eth *eth = mac->hw;
-	u32 mcr_cur, mcr_new, sid, i;
 	int val, ge_mode, err = 0;
+	u32 sid, i;
 
 	/* MT76x8 has no hardware settings between for the MAC */
 	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) &&
@@ -359,17 +359,6 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		return;
 	}
 
-	/* Setup gmac */
-	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
-	mcr_new = mcr_cur;
-	mcr_new |= MAC_MCR_IPG_CFG | MAC_MCR_FORCE_MODE |
-		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_FORCE_LINK |
-		   MAC_MCR_RX_FIFO_CLR_DIS;
-
-	/* Only update control register when needed! */
-	if (mcr_new != mcr_cur)
-		mtk_w32(mac->hw, mcr_new, MTK_MAC_MCR(mac->id));
-
 	return;
 
 err_phy:
@@ -382,6 +371,26 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		mac->id, phy_modes(state->interface), err);
 }
 
+static int mtk_mac_finish(struct phylink_config *config, unsigned int mode,
+			  phy_interface_t interface)
+{
+	struct mtk_mac *mac = container_of(config, struct mtk_mac,
+					   phylink_config);
+	u32 mcr_cur, mcr_new;
+
+	/* Setup gmac */
+	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
+	mcr_new = mcr_cur;
+	mcr_new |= MAC_MCR_IPG_CFG | MAC_MCR_FORCE_MODE |
+		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_RX_FIFO_CLR_DIS;
+
+	/* Only update control register when needed! */
+	if (mcr_new != mcr_cur)
+		mtk_w32(mac->hw, mcr_new, MTK_MAC_MCR(mac->id));
+
+	return 0;
+}
+
 static void mtk_mac_pcs_get_state(struct phylink_config *config,
 				  struct phylink_link_state *state)
 {
@@ -429,7 +438,7 @@ static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 					   phylink_config);
 	u32 mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 
-	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN);
+	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK);
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
@@ -467,7 +476,7 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	if (rx_pause)
 		mcr |= MAC_MCR_FORCE_RX_FC;
 
-	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN;
+	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK;
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
@@ -562,6 +571,7 @@ static const struct phylink_mac_ops mtk_phylink_ops = {
 	.mac_pcs_get_state = mtk_mac_pcs_get_state,
 	.mac_an_restart = mtk_mac_an_restart,
 	.mac_config = mtk_mac_config,
+	.mac_finish = mtk_mac_finish,
 	.mac_link_down = mtk_mac_link_down,
 	.mac_link_up = mtk_mac_link_up,
 };
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 66298e2235c91..5e7b66846791d 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -425,7 +425,7 @@ int mtk_ppe_start(struct mtk_ppe *ppe)
 			 MTK_PPE_KEEPALIVE_DISABLE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_HASH_MODE, 1) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_SCAN_MODE,
-			 MTK_PPE_SCAN_MODE_KEEPALIVE_AGE) |
+			 MTK_PPE_SCAN_MODE_CHECK_AGE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_ENTRY_NUM,
 			 MTK_PPE_ENTRIES_SHIFT);
 	ppe_w32(ppe, MTK_PPE_TB_CFG, val);
@@ -493,17 +493,21 @@ int mtk_ppe_stop(struct mtk_ppe *ppe)
 
 	mtk_ppe_cache_enable(ppe, false);
 
-	/* disable offload engine */
-	ppe_clear(ppe, MTK_PPE_GLO_CFG, MTK_PPE_GLO_CFG_EN);
-	ppe_w32(ppe, MTK_PPE_FLOW_CFG, 0);
-
 	/* disable aging */
 	val = MTK_PPE_TB_CFG_AGE_NON_L4 |
 	      MTK_PPE_TB_CFG_AGE_UNBIND |
 	      MTK_PPE_TB_CFG_AGE_TCP |
 	      MTK_PPE_TB_CFG_AGE_UDP |
-	      MTK_PPE_TB_CFG_AGE_TCP_FIN;
+	      MTK_PPE_TB_CFG_AGE_TCP_FIN |
+		  MTK_PPE_TB_CFG_SCAN_MODE;
 	ppe_clear(ppe, MTK_PPE_TB_CFG, val);
 
-	return mtk_ppe_wait_busy(ppe);
+	if (mtk_ppe_wait_busy(ppe))
+		return -ETIMEDOUT;
+
+	/* disable offload engine */
+	ppe_clear(ppe, MTK_PPE_GLO_CFG, MTK_PPE_GLO_CFG_EN);
+	ppe_w32(ppe, MTK_PPE_FLOW_CFG, 0);
+
+	return 0;
 }
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
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index f070aa97c77b4..57411ee1d8374 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -94,7 +94,8 @@
 #define DP83822_WOL_INDICATION_SEL BIT(8)
 #define DP83822_WOL_CLR_INDICATION BIT(11)
 
-/* RSCR bits */
+/* RCSR bits */
+#define DP83822_RGMII_MODE_EN	BIT(9)
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
 
@@ -379,7 +380,7 @@ static int dp83822_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
-	int rgmii_delay;
+	int rgmii_delay = 0;
 	s32 rx_int_delay;
 	s32 tx_int_delay;
 	int err = 0;
@@ -389,24 +390,33 @@ static int dp83822_config_init(struct phy_device *phydev)
 		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      true);
 
-		if (rx_int_delay <= 0)
-			rgmii_delay = 0;
-		else
-			rgmii_delay = DP83822_RX_CLK_SHIFT;
+		/* Set DP83822_RX_CLK_SHIFT to enable rx clk internal delay */
+		if (rx_int_delay > 0)
+			rgmii_delay |= DP83822_RX_CLK_SHIFT;
 
 		tx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      false);
+
+		/* Set DP83822_TX_CLK_SHIFT to disable tx clk internal delay */
 		if (tx_int_delay <= 0)
-			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;
-		else
 			rgmii_delay |= DP83822_TX_CLK_SHIFT;
 
-		if (rgmii_delay) {
-			err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					       MII_DP83822_RCSR, rgmii_delay);
-			if (err)
-				return err;
-		}
+		err = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+				     DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT, rgmii_delay);
+		if (err)
+			return err;
+
+		err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
+				       MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+
+		if (err)
+			return err;
+	} else {
+		err = phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
+					 MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+
+		if (err)
+			return err;
 	}
 
 	if (dp83822->fx_enabled) {
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0429825a7179d..523436690adef 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2645,8 +2645,8 @@ EXPORT_SYMBOL(genphy_resume);
 int genphy_loopback(struct phy_device *phydev, bool enable)
 {
 	if (enable) {
-		u16 val, ctl = BMCR_LOOPBACK;
-		int ret;
+		u16 ctl = BMCR_LOOPBACK;
+		int ret, val;
 
 		if (phydev->speed == SPEED_1000)
 			ctl |= BMCR_SPEED1000;
@@ -2904,7 +2904,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 	if (delay < 0)
 		return delay;
 
-	if (delay && size == 0)
+	if (size == 0)
 		return delay;
 
 	if (delay < delay_values[0] || delay > delay_values[size - 1]) {
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 576401c8b1bee..79358369c4565 100644
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
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0102f86d48676..cfacf8965bc59 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1388,8 +1388,6 @@ static netdev_features_t veth_fix_features(struct net_device *dev,
 		if (peer_priv->_xdp_prog)
 			features &= ~NETIF_F_GSO_SOFTWARE;
 	}
-	if (priv->_xdp_prog)
-		features |= NETIF_F_GRO;
 
 	return features;
 }
@@ -1481,14 +1479,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 
 		if (!old_prog) {
-			if (!veth_gro_requested(dev)) {
-				/* user-space did not require GRO, but adding
-				 * XDP is supposed to get GRO working
-				 */
-				dev->features |= NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
-
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 			peer->max_mtu = max_mtu;
 		}
@@ -1499,14 +1489,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			if (dev->flags & IFF_UP)
 				veth_disable_xdp(dev);
 
-			/* if user-space did not require GRO, since adding XDP
-			 * enabled it, clear it now
-			 */
-			if (!veth_gro_requested(dev)) {
-				dev->features &= ~NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
-
 			if (peer) {
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
 				peer->max_mtu = ETH_MAX_MTU;
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index d38b24339a1f9..ed274e9bdf3ce 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -258,7 +258,7 @@ static bool decrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 
 	if (unlikely(!READ_ONCE(keypair->receiving.is_valid) ||
 		  wg_birthdate_has_expired(keypair->receiving.birthdate, REJECT_AFTER_TIME) ||
-		  keypair->receiving_counter.counter >= REJECT_AFTER_MESSAGES)) {
+		  READ_ONCE(keypair->receiving_counter.counter) >= REJECT_AFTER_MESSAGES)) {
 		WRITE_ONCE(keypair->receiving.is_valid, false);
 		return false;
 	}
@@ -325,7 +325,7 @@ static bool counter_validate(struct noise_replay_counter *counter, u64 their_cou
 		for (i = 1; i <= top; ++i)
 			counter->backtrack[(i + index_current) &
 				((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1)] = 0;
-		counter->counter = their_counter;
+		WRITE_ONCE(counter->counter, their_counter);
 	}
 
 	index &= (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;
@@ -470,7 +470,7 @@ int wg_packet_rx_poll(struct napi_struct *napi, int budget)
 			net_dbg_ratelimited("%s: Packet has invalid nonce %llu (max %llu)\n",
 					    peer->device->dev->name,
 					    PACKET_CB(skb)->nonce,
-					    keypair->receiving_counter.counter);
+					    READ_ONCE(keypair->receiving_counter.counter));
 			goto next;
 		}
 
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 58e86e662ab83..eca24a61165ee 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3544,13 +3544,10 @@ EXPORT_SYMBOL(ath10k_core_create);
 
 void ath10k_core_destroy(struct ath10k *ar)
 {
-	flush_workqueue(ar->workqueue);
 	destroy_workqueue(ar->workqueue);
 
-	flush_workqueue(ar->workqueue_aux);
 	destroy_workqueue(ar->workqueue_aux);
 
-	flush_workqueue(ar->workqueue_tx_complete);
 	destroy_workqueue(ar->workqueue_tx_complete);
 
 	ath10k_debug_destroy(ar);
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index eb705214f3f0a..63e1c2d783c5f 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2650,7 +2650,6 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	ath10k_core_destroy(ar);
 
-	flush_workqueue(ar_sdio->workqueue);
 	destroy_workqueue(ar_sdio->workqueue);
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 7efbe03fbca82..d5dafbecc1845 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -844,6 +844,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
 	}
 
 	ev = tb[WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return -EPROTO;
+	}
 
 	arg->desc_id = ev->desc_id;
 	arg->status = ev->status;
diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 237f4ec2cffd7..6c33e898b3000 100644
--- a/drivers/net/wireless/ath/ath9k/htc.h
+++ b/drivers/net/wireless/ath/ath9k/htc.h
@@ -306,7 +306,6 @@ struct ath9k_htc_tx {
 	DECLARE_BITMAP(tx_slot, MAX_TX_BUF_NUM);
 	struct timer_list cleanup_timer;
 	spinlock_t tx_lock;
-	bool initialized;
 };
 
 struct ath9k_htc_tx_ctl {
@@ -515,6 +514,7 @@ struct ath9k_htc_priv {
 	unsigned long ps_usecount;
 	bool ps_enabled;
 	bool ps_idle;
+	bool initialized;
 
 #ifdef CONFIG_MAC80211_LEDS
 	enum led_brightness brightness;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 96a3185a96d75..b014185373f34 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -966,6 +966,10 @@ int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 
 	htc_handle->drv_priv = priv;
 
+	/* Allow ath9k_wmi_event_tasklet() to operate. */
+	smp_wmb();
+	priv->initialized = true;
+
 	return 0;
 
 err_init:
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index d6a3f001dacb9..2fdd27885f543 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -815,10 +815,6 @@ int ath9k_tx_init(struct ath9k_htc_priv *priv)
 	skb_queue_head_init(&priv->tx.data_vo_queue);
 	skb_queue_head_init(&priv->tx.tx_failed);
 
-	/* Allow ath9k_wmi_event_tasklet(WMI_TXSTATUS_EVENTID) to operate. */
-	smp_wmb();
-	priv->tx.initialized = true;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 1476b42b52a91..805ad31edba2b 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -155,6 +155,12 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 		}
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
+		/* Check if ath9k_htc_probe_device() completed. */
+		if (!data_race(priv->initialized)) {
+			kfree_skb(skb);
+			continue;
+		}
+
 		hdr = (struct wmi_cmd_hdr *) skb->data;
 		cmd_id = be16_to_cpu(hdr->command_id);
 		wmi_event = skb_pull(skb, sizeof(struct wmi_cmd_hdr));
@@ -169,10 +175,6 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 					     &wmi->drv_priv->fatal_work);
 			break;
 		case WMI_TXSTATUS_EVENTID:
-			/* Check if ath9k_tx_init() completed. */
-			if (!data_race(priv->tx.initialized))
-				break;
-
 			spin_lock_bh(&priv->tx.tx_lock);
 			if (priv->tx.flags & ATH9K_HTC_OP_TX_DRAIN) {
 				spin_unlock_bh(&priv->tx.tx_lock);
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
index 9a7c62bd5e431..cfaf2f9d67b22 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1399,7 +1399,7 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	    should_inject_overflow(ring)) {
 		/* This TX ring is full. */
 		unsigned int skb_mapping = skb_get_queue_mapping(skb);
-		ieee80211_stop_queue(dev->wl->hw, skb_mapping);
+		b43_stop_queue(dev, skb_mapping);
 		dev->wl->tx_queue_stopped[skb_mapping] = true;
 		ring->stopped = true;
 		if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
@@ -1570,7 +1570,7 @@ void b43_dma_handle_txstatus(struct b43_wldev *dev,
 	} else {
 		/* If the driver queue is running wake the corresponding
 		 * mac80211 queue. */
-		ieee80211_wake_queue(dev->wl->hw, ring->queue_prio);
+		b43_wake_queue(dev, ring->queue_prio);
 		if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
 			b43dbg(dev->wl, "Woke up TX ring %d\n", ring->index);
 		}
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 17bcec5f3ff75..e6e4a18d817a0 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2587,7 +2587,8 @@ static void b43_request_firmware(struct work_struct *work)
 
 start_ieee80211:
 	wl->hw->queues = B43_QOS_QUEUE_NUM;
-	if (!modparam_qos || dev->fw.opensource)
+	if (!modparam_qos || dev->fw.opensource ||
+	    dev->dev->chip_id == BCMA_CHIP_ID_BCM4331)
 		wl->hw->queues = 1;
 
 	err = ieee80211_register_hw(wl->hw);
@@ -3603,7 +3604,7 @@ static void b43_tx_work(struct work_struct *work)
 				err = b43_dma_tx(dev, skb);
 			if (err == -ENOSPC) {
 				wl->tx_queue_stopped[queue_num] = true;
-				ieee80211_stop_queue(wl->hw, queue_num);
+				b43_stop_queue(dev, queue_num);
 				skb_queue_head(&wl->tx_queue[queue_num], skb);
 				break;
 			}
@@ -3627,6 +3628,7 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 		      struct sk_buff *skb)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
+	u16 skb_queue_mapping;
 
 	if (unlikely(skb->len < 2 + 2 + 6)) {
 		/* Too short, this can't be a valid frame. */
@@ -3635,12 +3637,12 @@ static void b43_op_tx(struct ieee80211_hw *hw,
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
diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless/broadcom/b43/pio.c
index 8c28a9250cd19..cc19b589fa70d 100644
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
index ccc621b8ed9f2..4a1fe982a948e 100644
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
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 04c149ff745e9..dea0012fcdc79 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3827,7 +3827,6 @@ il3945_pci_remove(struct pci_dev *pdev)
 	il3945_unset_hw_params(il);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(il->workqueue);
 
 	/* ieee80211_unregister_hw calls il3945_mac_stop, which flushes
 	 * il->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index ff04282e3db03..ceab7704897de 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -6739,7 +6739,6 @@ il4965_pci_remove(struct pci_dev *pdev)
 	il_eeprom_free(il);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(il->workqueue);
 
 	/* ieee80211_unregister_hw calls il_mac_stop, which flushes
 	 * il->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index cc7b69fd14d37..69d1aae96bbb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1525,7 +1525,6 @@ static void iwl_op_mode_dvm_stop(struct iwl_op_mode *op_mode)
 	kfree(priv->nvm_data);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(priv->workqueue);
 
 	/* ieee80211_unregister_hw calls iwlagn_mac_stop, which flushes
 	 * priv->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index f0e0d4ccbc091..0b1c6bf729c3e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -674,7 +674,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	 * from index 1, so the maximum value allowed here is
 	 * ACPI_SAR_PROFILES_NUM - 1.
 	 */
-	if (n_profiles <= 0 || n_profiles >= ACPI_SAR_PROFILE_NUM) {
+	if (n_profiles >= ACPI_SAR_PROFILE_NUM) {
 		ret = -EINVAL;
 		goto out_free;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 8a610c518082a..fe3239c4607e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -99,6 +99,12 @@ static int iwl_dbg_tlv_alloc_debug_info(struct iwl_trans *trans,
 	if (le32_to_cpu(tlv->length) != sizeof(*debug_info))
 		return -EINVAL;
 
+	/* we use this as a string, ensure input was NUL terminated */
+	if (strnlen(debug_info->debug_cfg_name,
+		    sizeof(debug_info->debug_cfg_name)) ==
+			sizeof(debug_info->debug_cfg_name))
+		return -EINVAL;
+
 	IWL_DEBUG_FW(trans, "WRT: Loading debug cfg: %s\n",
 		     debug_info->debug_cfg_name);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 27756e47f7caf..c4c62bcbe67de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -462,12 +462,10 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		struct wowlan_key_rsc_v5_data data = {};
 		int i;
 
-		data.rsc = kmalloc(sizeof(*data.rsc), GFP_KERNEL);
+		data.rsc = kzalloc(sizeof(*data.rsc), GFP_KERNEL);
 		if (!data.rsc)
 			return -ENOMEM;
 
-		memset(data.rsc, 0xff, sizeof(*data.rsc));
-
 		for (i = 0; i < ARRAY_SIZE(data.rsc->mcast_key_id_map); i++)
 			data.rsc->mcast_key_id_map[i] =
 				IWL_MCAST_KEY_MAP_INVALID;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 2e3eb7402197f..e1d0c79212311 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -305,6 +305,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 				u32 status,
 				struct ieee80211_rx_status *stats)
 {
+	struct wireless_dev *wdev;
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_vif *mvmvif;
 	u8 keyid;
@@ -326,9 +327,15 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 	if (!ieee80211_is_beacon(hdr->frame_control))
 		return 0;
 
+	if (!sta)
+		return -1;
+
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
+
 	/* key mismatch - will also report !MIC_OK but we shouldn't count it */
 	if (!(status & IWL_RX_MPDU_STATUS_KEY_VALID))
-		return -1;
+		goto report;
 
 	/* good cases */
 	if (likely(status & IWL_RX_MPDU_STATUS_MIC_OK &&
@@ -337,13 +344,6 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 		return 0;
 	}
 
-	if (!sta)
-		return -1;
-
-	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
-	mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
-
 	/*
 	 * both keys will have the same cipher and MIC length, use
 	 * whichever one is available
@@ -352,11 +352,11 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 	if (!key) {
 		key = rcu_dereference(mvmvif->bcn_prot.keys[1]);
 		if (!key)
-			return -1;
+			goto report;
 	}
 
 	if (len < key->icv_len + IEEE80211_GMAC_PN_LEN + 2)
-		return -1;
+		goto report;
 
 	/* get the real key ID */
 	keyid = frame[len - key->icv_len - IEEE80211_GMAC_PN_LEN - 2];
@@ -370,7 +370,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 			return -1;
 		key = rcu_dereference(mvmvif->bcn_prot.keys[keyid - 6]);
 		if (!key)
-			return -1;
+			goto report;
 	}
 
 	/* Report status to mac80211 */
@@ -378,6 +378,10 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 		ieee80211_key_mic_failure(key);
 	else if (status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)
 		ieee80211_key_replay(key);
+report:
+	wdev = ieee80211_vif_to_wdev(mvmsta->vif);
+	if (wdev->netdev)
+		cfg80211_rx_unprot_mlme_mgmt(wdev->netdev, (void *)hdr, len);
 
 	return -1;
 }
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
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 109b1bef4c707..017d9e03d652d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3169,13 +3169,11 @@ int mwifiex_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 		cfg80211_unregister_netdevice(wdev->netdev);
 
 	if (priv->dfs_cac_workqueue) {
-		flush_workqueue(priv->dfs_cac_workqueue);
 		destroy_workqueue(priv->dfs_cac_workqueue);
 		priv->dfs_cac_workqueue = NULL;
 	}
 
 	if (priv->dfs_chan_sw_workqueue) {
-		flush_workqueue(priv->dfs_chan_sw_workqueue);
 		destroy_workqueue(priv->dfs_chan_sw_workqueue);
 		priv->dfs_chan_sw_workqueue = NULL;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 1e7dc724c6a94..d48a3e0b36060 100644
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
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 17399d4aa1290..7943fd3b3058d 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -498,13 +498,11 @@ static void mwifiex_free_adapter(struct mwifiex_adapter *adapter)
 static void mwifiex_terminate_workqueue(struct mwifiex_adapter *adapter)
 {
 	if (adapter->workqueue) {
-		flush_workqueue(adapter->workqueue);
 		destroy_workqueue(adapter->workqueue);
 		adapter->workqueue = NULL;
 	}
 
 	if (adapter->rx_workqueue) {
-		flush_workqueue(adapter->rx_workqueue);
 		destroy_workqueue(adapter->rx_workqueue);
 		adapter->rx_workqueue = NULL;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 1688144d78475..0f48204e6e0e4 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1562,7 +1562,6 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	cfg80211_unregister_netdevice(vif->ndev);
 	vif->monitor_flag = 0;
 
-	wilc_set_operation_mode(vif, 0, 0, 0);
 	mutex_lock(&wl->vif_mutex);
 	list_del_rcu(&vif->list);
 	wl->vif_num--;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index a7bca0475e1ee..fe95a6201a679 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -359,38 +359,49 @@ static void handle_connect_timeout(struct work_struct *work)
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
@@ -401,7 +412,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 
 	if (rates_len < WILC_MAX_RATES_SUPPORTED) {
 		supp_rates_ie = cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
-						 ies->data, ies->len);
+						 ies_data, ies_len);
 		if (supp_rates_ie) {
 			u8 ext_rates = supp_rates_ie[1];
 
@@ -416,11 +427,11 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
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
@@ -444,7 +455,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	}
 	wmm_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
 					 WLAN_OUI_TYPE_MICROSOFT_WMM,
-					 ies->data, ies->len);
+					 ies_data, ies_len);
 	if (wmm_ie) {
 		struct ieee80211_wmm_param_ie *ie;
 
@@ -459,13 +470,13 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 
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
 		int rsn_ie_len = sizeof(struct element) + rsn_ie[1];
 		int offset = 8;
@@ -499,6 +510,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 			param->akm_suites[i] = crypto->akm_suites[i] & 0xFF;
 	}
 
+	kfree(ies_data);
 	return (void *)param;
 }
 
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 5e3ec20e24dad..0cf9e123d8c7d 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -862,8 +862,7 @@ static const struct net_device_ops wilc_netdev_ops = {
 
 void wilc_netdev_cleanup(struct wilc *wilc)
 {
-	struct wilc_vif *vif;
-	int srcu_idx, ifc_cnt = 0;
+	struct wilc_vif *vif, *vif_tmp;
 
 	if (!wilc)
 		return;
@@ -873,33 +872,19 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 		wilc->firmware = NULL;
 	}
 
-	srcu_idx = srcu_read_lock(&wilc->srcu);
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+	list_for_each_entry_safe(vif, vif_tmp, &wilc->vif_list, list) {
+		mutex_lock(&wilc->vif_mutex);
+		list_del_rcu(&vif->list);
+		wilc->vif_num--;
+		mutex_unlock(&wilc->vif_mutex);
+		synchronize_srcu(&wilc->srcu);
 		if (vif->ndev)
 			unregister_netdev(vif->ndev);
 	}
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
 
 	wilc_wfi_deinit_mon_interface(wilc, false);
-	flush_workqueue(wilc->hif_workqueue);
 	destroy_workqueue(wilc->hif_workqueue);
 
-	while (ifc_cnt < WILC_NUM_CONCURRENT_IFC) {
-		mutex_lock(&wilc->vif_mutex);
-		if (wilc->vif_num <= 0) {
-			mutex_unlock(&wilc->vif_mutex);
-			break;
-		}
-		vif = wilc_get_wl_to_vif(wilc);
-		if (!IS_ERR(vif))
-			list_del_rcu(&vif->list);
-
-		wilc->vif_num--;
-		mutex_unlock(&wilc->vif_mutex);
-		synchronize_srcu(&wilc->srcu);
-		ifc_cnt++;
-	}
-
 	wilc_wlan_cfg_deinit(wilc);
 	wlan_deinit_locks(wilc);
 	wiphy_unregister(wilc->wiphy);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index b4dd60b2ebc90..01725237836e8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -811,13 +811,11 @@ void qtnf_core_detach(struct qtnf_bus *bus)
 	bus->fw_state = QTNF_FW_STATE_DETACHED;
 
 	if (bus->workqueue) {
-		flush_workqueue(bus->workqueue);
 		destroy_workqueue(bus->workqueue);
 		bus->workqueue = NULL;
 	}
 
 	if (bus->hprio_workqueue) {
-		flush_workqueue(bus->hprio_workqueue);
 		destroy_workqueue(bus->hprio_workqueue);
 		bus->hprio_workqueue = NULL;
 	}
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index 5d93c874d6669..9ad4c120fa287 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -387,7 +387,6 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 error:
-	flush_workqueue(pcie_priv->workqueue);
 	destroy_workqueue(pcie_priv->workqueue);
 	pci_set_drvdata(pdev, NULL);
 	return ret;
@@ -416,7 +415,6 @@ static void qtnf_pcie_remove(struct pci_dev *dev)
 		qtnf_core_detach(bus);
 
 	netif_napi_del(&bus->mux_napi);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 	tasklet_kill(&priv->reclaim_tq);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 30d9a195c6fb5..3536b9f8470f4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6484,6 +6484,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	if (priv->usb_interrupts)
 		rtl8xxxu_write32(priv, REG_USB_HIMR, 0);
 
+	cancel_work_sync(&priv->c2hcmd_work);
 	cancel_delayed_work_sync(&priv->ra_watchdog);
 
 	rtl8xxxu_free_rx_resources(priv);
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 679ae786cf450..6d9f2a6233a21 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1704,7 +1704,6 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
 	tasklet_kill(&rtlpriv->works.irq_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
 
-	flush_workqueue(rtlpriv->works.rtl_wq);
 	destroy_workqueue(rtlpriv->works.rtl_wq);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 280602a34fe67..eb66f494382ae 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -667,9 +667,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 	dm_info->cck_fa_cnt = cck_fa_cnt;
 	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	if (cck_enable)
 		dm_info->total_fa_cnt += cck_fa_cnt;
-	dm_info->total_fa_cnt = ofdm_fa_cnt;
 
 	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
 	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index 70841d131d724..c35e9f5c2897e 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3494,7 +3494,6 @@ static int rndis_wlan_bind(struct usbnet *usbdev, struct usb_interface *intf)
 	cancel_delayed_work_sync(&priv->dev_poller_work);
 	cancel_delayed_work_sync(&priv->scan_work);
 	cancel_work_sync(&priv->work);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 
 	wiphy_free(wiphy);
@@ -3511,7 +3510,6 @@ static void rndis_wlan_unbind(struct usbnet *usbdev, struct usb_interface *intf)
 	cancel_delayed_work_sync(&priv->dev_poller_work);
 	cancel_delayed_work_sync(&priv->scan_work);
 	cancel_work_sync(&priv->work);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 
 	rndis_unbind(usbdev, intf);
diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 8bade5d89f12f..10e019cddcc65 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -85,8 +85,6 @@ void cw1200_unregister_bh(struct cw1200_common *priv)
 	atomic_inc(&priv->bh_term);
 	wake_up(&priv->bh_wq);
 
-	flush_workqueue(priv->bh_workqueue);
-
 	destroy_workqueue(priv->bh_workqueue);
 	priv->bh_workqueue = NULL;
 
diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index 27dd93deff6e5..d702bee780826 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
 
 int ntb_register_device(struct ntb_dev *ntb)
 {
+	int ret;
+
 	if (!ntb)
 		return -EINVAL;
 	if (!ntb->pdev)
@@ -120,7 +122,11 @@ int ntb_register_device(struct ntb_dev *ntb)
 	ntb->ctx_ops = NULL;
 	spin_lock_init(&ntb->ctx_lock);
 
-	return device_register(&ntb->dev);
+	ret = device_register(&ntb->dev);
+	if (ret)
+		put_device(&ntb->dev);
+
+	return ret;
 }
 EXPORT_SYMBOL(ntb_register_device);
 
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 9eb71f47487b2..1c9d039edb26b 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -37,10 +37,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
 			    size_t count, loff_t *ppos)
 {
 	struct icc_path *path = fp->private_data;
+	const char *name = icc_get_name(path);
 	char buf[64];
-	int i;
+	int i = 0;
 
-	i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
+	if (name)
+		i = scnprintf(buf, sizeof(buf), "%.62s\n", name);
 
 	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
 }
diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 5f1242ca2f4e4..65217428d17b9 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -25,3 +25,14 @@ config PCI_EPF_NTB
 	  device tree.
 
 	  If in doubt, say "N" to disable Endpoint NTB driver.
+
+config PCI_EPF_VNTB
+        tristate "PCI Endpoint NTB driver"
+        depends on PCI_ENDPOINT
+        select CONFIGFS_FS
+        help
+          Select this configuration option to enable the Non-Transparent
+          Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
+          between PCI Root Port and PCIe Endpoint.
+
+          If in doubt, say "N" to disable Endpoint NTB driver.
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 96ab932a537a2..5c13001deaba1 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
+obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
new file mode 100644
index 0000000000000..d4cd4bd4a0881
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -0,0 +1,1421 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Endpoint Function Driver to implement Non-Transparent Bridge functionality
+ * Between PCI RC and EP
+ *
+ * Copyright (C) 2020 Texas Instruments
+ * Copyright (C) 2022 NXP
+ *
+ * Based on pci-epf-ntb.c
+ * Author: Frank Li <Frank.Li@nxp.com>
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+/**
+ * +------------+         +---------------------------------------+
+ * |            |         |                                       |
+ * +------------+         |                        +--------------+
+ * | NTB        |         |                        | NTB          |
+ * | NetDev     |         |                        | NetDev       |
+ * +------------+         |                        +--------------+
+ * | NTB        |         |                        | NTB          |
+ * | Transfer   |         |                        | Transfer     |
+ * +------------+         |                        +--------------+
+ * |            |         |                        |              |
+ * |  PCI NTB   |         |                        |              |
+ * |    EPF     |         |                        |              |
+ * |   Driver   |         |                        | PCI Virtual  |
+ * |            |         +---------------+        | NTB Driver   |
+ * |            |         | PCI EP NTB    |<------>|              |
+ * |            |         |  FN Driver    |        |              |
+ * +------------+         +---------------+        +--------------+
+ * |            |         |               |        |              |
+ * |  PCI Bus   | <-----> |  PCI EP Bus   |        |  Virtual PCI |
+ * |            |  PCI    |               |        |     Bus      |
+ * +------------+         +---------------+--------+--------------+
+ * PCIe Root Port                        PCI EP
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/ntb.h>
+
+static struct workqueue_struct *kpcintb_workqueue;
+
+#define COMMAND_CONFIGURE_DOORBELL	1
+#define COMMAND_TEARDOWN_DOORBELL	2
+#define COMMAND_CONFIGURE_MW		3
+#define COMMAND_TEARDOWN_MW		4
+#define COMMAND_LINK_UP			5
+#define COMMAND_LINK_DOWN		6
+
+#define COMMAND_STATUS_OK		1
+#define COMMAND_STATUS_ERROR		2
+
+#define LINK_STATUS_UP			BIT(0)
+
+#define SPAD_COUNT			64
+#define DB_COUNT			4
+#define NTB_MW_OFFSET			2
+#define DB_COUNT_MASK			GENMASK(15, 0)
+#define MSIX_ENABLE			BIT(16)
+#define MAX_DB_COUNT			32
+#define MAX_MW				4
+
+enum epf_ntb_bar {
+	BAR_CONFIG,
+	BAR_DB,
+	BAR_MW0,
+	BAR_MW1,
+	BAR_MW2,
+};
+
+/*
+ * +--------------------------------------------------+ Base
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * |          Common Control Register                 |
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * +-----------------------+--------------------------+ Base+span_offset
+ * |                       |                          |
+ * |    Peer Span Space    |    Span Space            |
+ * |                       |                          |
+ * |                       |                          |
+ * +-----------------------+--------------------------+ Base+span_offset
+ * |                       |                          |     +span_count * 4
+ * |                       |                          |
+ * |     Span Space        |   Peer Span Space        |
+ * |                       |                          |
+ * +-----------------------+--------------------------+
+ *       Virtual PCI             PCIe Endpoint
+ *       NTB Driver               NTB Driver
+ */
+struct epf_ntb_ctrl {
+	u32     command;
+	u32     argument;
+	u16     command_status;
+	u16     link_status;
+	u32     topology;
+	u64     addr;
+	u64     size;
+	u32     num_mws;
+	u32	reserved;
+	u32     spad_offset;
+	u32     spad_count;
+	u32	db_entry_size;
+	u32     db_data[MAX_DB_COUNT];
+	u32     db_offset[MAX_DB_COUNT];
+} __packed;
+
+struct epf_ntb {
+	struct ntb_dev ntb;
+	struct pci_epf *epf;
+	struct config_group group;
+
+	u32 num_mws;
+	u32 db_count;
+	u32 spad_count;
+	u64 mws_size[MAX_MW];
+	u64 db;
+	u32 vbus_number;
+	u16 vntb_pid;
+	u16 vntb_vid;
+
+	bool linkup;
+	u32 spad_size;
+
+	enum pci_barno epf_ntb_bar[6];
+
+	struct epf_ntb_ctrl *reg;
+
+	phys_addr_t epf_db_phy;
+	void __iomem *epf_db;
+
+	phys_addr_t vpci_mw_phy[MAX_MW];
+	void __iomem *vpci_mw_addr[MAX_MW];
+
+	struct delayed_work cmd_handler;
+};
+
+#define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
+#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
+
+static struct pci_epf_header epf_ntb_header = {
+	.vendorid	= PCI_ANY_ID,
+	.deviceid	= PCI_ANY_ID,
+	.baseclass_code	= PCI_BASE_CLASS_MEMORY,
+	.interrupt_pin	= PCI_INTERRUPT_INTA,
+};
+
+/**
+ * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @link_up: true or false indicating Link is UP or Down
+ *
+ * Once NTB function in HOST invoke ntb_link_enable(),
+ * this NTB function driver will trigger a link event to vhost.
+ */
+static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
+{
+	if (link_up)
+		ntb->reg->link_status |= LINK_STATUS_UP;
+	else
+		ntb->reg->link_status &= ~LINK_STATUS_UP;
+
+	ntb_link_event(&ntb->ntb);
+	return 0;
+}
+
+/**
+ * epf_ntb_configure_mw() - Configure the Outbound Address Space for vhost
+ *   to access the memory window of host
+ * @ntb: NTB device that facilitates communication between host and vhost
+ * @mw: Index of the memory window (either 0, 1, 2 or 3)
+ *
+ *                          EP Outbound Window
+ * +--------+              +-----------+
+ * |        |              |           |
+ * |        |              |           |
+ * |        |              |           |
+ * |        |              |           |
+ * |        |              +-----------+
+ * | Virtual|              | Memory Win|
+ * | NTB    | -----------> |           |
+ * | Driver |              |           |
+ * |        |              +-----------+
+ * |        |              |           |
+ * |        |              |           |
+ * +--------+              +-----------+
+ *  VHost                   PCI EP
+ */
+static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
+{
+	phys_addr_t phys_addr;
+	u8 func_no, vfunc_no;
+	u64 addr, size;
+	int ret = 0;
+
+	phys_addr = ntb->vpci_mw_phy[mw];
+	addr = ntb->reg->addr;
+	size = ntb->reg->size;
+
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+
+	ret = pci_epc_map_addr(ntb->epf->epc, func_no, vfunc_no, phys_addr, addr, size);
+	if (ret)
+		dev_err(&ntb->epf->epc->dev,
+			"Failed to map memory window %d address\n", mw);
+	return ret;
+}
+
+/**
+ * epf_ntb_teardown_mw() - Teardown the configured OB ATU
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @mw: Index of the memory window (either 0, 1, 2 or 3)
+ *
+ * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
+ * pci_epc_unmap_addr()
+ */
+static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
+{
+	pci_epc_unmap_addr(ntb->epf->epc,
+			   ntb->epf->func_no,
+			   ntb->epf->vfunc_no,
+			   ntb->vpci_mw_phy[mw]);
+}
+
+/**
+ * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
+ * @work: work_struct for the epf_ntb_epc
+ *
+ * Workqueue function that gets invoked for the two epf_ntb_epc
+ * periodically (once every 5ms) to see if it has received any commands
+ * from NTB host. The host can send commands to configure doorbell or
+ * configure memory window or to update link status.
+ */
+static void epf_ntb_cmd_handler(struct work_struct *work)
+{
+	struct epf_ntb_ctrl *ctrl;
+	u32 command, argument;
+	struct epf_ntb *ntb;
+	struct device *dev;
+	int ret;
+	int i;
+
+	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
+
+	for (i = 1; i < ntb->db_count; i++) {
+		if (readl(ntb->epf_db + i * 4)) {
+			if (readl(ntb->epf_db + i * 4))
+				ntb->db |= 1 << (i - 1);
+
+			ntb_db_event(&ntb->ntb, i);
+			writel(0, ntb->epf_db + i * 4);
+		}
+	}
+
+	ctrl = ntb->reg;
+	command = ctrl->command;
+	if (!command)
+		goto reset_handler;
+	argument = ctrl->argument;
+
+	ctrl->command = 0;
+	ctrl->argument = 0;
+
+	ctrl = ntb->reg;
+	dev = &ntb->epf->dev;
+
+	switch (command) {
+	case COMMAND_CONFIGURE_DOORBELL:
+		ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_TEARDOWN_DOORBELL:
+		ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_CONFIGURE_MW:
+		ret = epf_ntb_configure_mw(ntb, argument);
+		if (ret < 0)
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+		else
+			ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_TEARDOWN_MW:
+		epf_ntb_teardown_mw(ntb, argument);
+		ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_LINK_UP:
+		ntb->linkup = true;
+		ret = epf_ntb_link_up(ntb, true);
+		if (ret < 0)
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+		else
+			ctrl->command_status = COMMAND_STATUS_OK;
+		goto reset_handler;
+	case COMMAND_LINK_DOWN:
+		ntb->linkup = false;
+		ret = epf_ntb_link_up(ntb, false);
+		if (ret < 0)
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+		else
+			ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	default:
+		dev_err(dev, "UNKNOWN command: %d\n", command);
+		break;
+	}
+
+reset_handler:
+	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
+			   msecs_to_jiffies(5));
+}
+
+/**
+ * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
+ * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
+ *	     address.
+ *
+ * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
+ * self scratchpad region (removes inbound ATU configuration). While BAR0 is
+ * the default self scratchpad BAR, an NTB could have other BARs for self
+ * scratchpad (because of reserved BARs). This function can get the exact BAR
+ * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
+ *
+ * Please note the self scratchpad region and config region is combined to
+ * a single region and mapped using the same BAR. Also note HOST2's peer
+ * scratchpad is HOST1's self scratchpad.
+ */
+static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
+{
+	struct pci_epf_bar *epf_bar;
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	epf_bar = &ntb->epf->bar[barno];
+
+	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+}
+
+/**
+ * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
+ * self scratchpad region.
+ *
+ * Please note the self scratchpad region and config region is combined to
+ * a single region and mapped using the same BAR.
+ */
+static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
+{
+	struct pci_epf_bar *epf_bar;
+	enum pci_barno barno;
+	u8 func_no, vfunc_no;
+	struct device *dev;
+	int ret;
+
+	dev = &ntb->epf->dev;
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	epf_bar = &ntb->epf->bar[barno];
+
+	ret = pci_epc_set_bar(ntb->epf->epc, func_no, vfunc_no, epf_bar);
+	if (ret) {
+		dev_err(dev, "inft: Config/Status/SPAD BAR set failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+/**
+ * epf_ntb_config_spad_bar_free() - Free the physical memory associated with
+ *   config + scratchpad region
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ */
+static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	pci_epf_free_space(ntb->epf, ntb->reg, barno, 0);
+}
+
+/**
+ * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scratchpad
+ *   region
+ * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ *
+ * Allocate the Local Memory mentioned in the above diagram. The size of
+ * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
+ * is obtained from "spad-count" configfs entry.
+ */
+static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
+{
+	size_t align;
+	enum pci_barno barno;
+	struct epf_ntb_ctrl *ctrl;
+	u32 spad_size, ctrl_size;
+	u64 size;
+	struct pci_epf *epf = ntb->epf;
+	struct device *dev = &epf->dev;
+	u32 spad_count;
+	void *base;
+	int i;
+	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
+								epf->func_no,
+								epf->vfunc_no);
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	size = epc_features->bar_fixed_size[barno];
+	align = epc_features->align;
+
+	if ((!IS_ALIGNED(size, align)))
+		return -EINVAL;
+
+	spad_count = ntb->spad_count;
+
+	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	spad_size = 2 * spad_count * 4;
+
+	if (!align) {
+		ctrl_size = roundup_pow_of_two(ctrl_size);
+		spad_size = roundup_pow_of_two(spad_size);
+	} else {
+		ctrl_size = ALIGN(ctrl_size, align);
+		spad_size = ALIGN(spad_size, align);
+	}
+
+	if (!size)
+		size = ctrl_size + spad_size;
+	else if (size < ctrl_size + spad_size)
+		return -EINVAL;
+
+	base = pci_epf_alloc_space(epf, size, barno, align, 0);
+	if (!base) {
+		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
+		return -ENOMEM;
+	}
+
+	ntb->reg = base;
+
+	ctrl = ntb->reg;
+	ctrl->spad_offset = ctrl_size;
+
+	ctrl->spad_count = spad_count;
+	ctrl->num_mws = ntb->num_mws;
+	ntb->spad_size = spad_size;
+
+	ctrl->db_entry_size = 4;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		ntb->reg->db_data[i] = 1 + i;
+		ntb->reg->db_offset[i] = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ * Configure MSI/MSI-X capability for each interface with number of
+ * interrupts equal to "db_count" configfs entry.
+ */
+static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	struct device *dev;
+	u32 db_count;
+	int ret;
+
+	dev = &ntb->epf->dev;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+
+	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
+		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
+		return -EINVAL;
+	}
+
+	db_count = ntb->db_count;
+	if (db_count > MAX_DB_COUNT) {
+		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
+		return -EINVAL;
+	}
+
+	ntb->db_count = db_count;
+
+	if (epc_features->msi_capable) {
+		ret = pci_epc_set_msi(ntb->epf->epc,
+				      ntb->epf->func_no,
+				      ntb->epf->vfunc_no,
+				      16);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * epf_ntb_db_bar_init() - Configure Doorbell window BARs
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ */
+static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	u32 align;
+	struct device *dev = &ntb->epf->dev;
+	int ret;
+	struct pci_epf_bar *epf_bar;
+	void __iomem *mw_addr;
+	enum pci_barno barno;
+	size_t size = 4 * ntb->db_count;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+	align = epc_features->align;
+
+	if (size < 128)
+		size = 128;
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
+
+	barno = ntb->epf_ntb_bar[BAR_DB];
+
+	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+	if (!mw_addr) {
+		dev_err(dev, "Failed to allocate OB address\n");
+		return -ENOMEM;
+	}
+
+	ntb->epf_db = mw_addr;
+
+	epf_bar = &ntb->epf->bar[barno];
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+	if (ret) {
+		dev_err(dev, "Doorbell BAR set failed\n");
+			goto err_alloc_peer_mem;
+	}
+	return ret;
+
+err_alloc_peer_mem:
+	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
+	return -1;
+}
+
+/**
+ * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
+ *   allocated in peer's outbound address space
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ */
+static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_DB];
+	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
+	pci_epc_clear_bar(ntb->epf->epc,
+			  ntb->epf->func_no,
+			  ntb->epf->vfunc_no,
+			  &ntb->epf->bar[barno]);
+}
+
+/**
+ * epf_ntb_mw_bar_init() - Configure Memory window BARs
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ */
+static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
+{
+	int ret = 0;
+	int i;
+	u64 size;
+	enum pci_barno barno;
+	struct device *dev = &ntb->epf->dev;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		size = ntb->mws_size[i];
+		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+
+		ntb->epf->bar[barno].barno = barno;
+		ntb->epf->bar[barno].size = size;
+		ntb->epf->bar[barno].addr = 0;
+		ntb->epf->bar[barno].phys_addr = 0;
+		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+				PCI_BASE_ADDRESS_MEM_TYPE_64 :
+				PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+		ret = pci_epc_set_bar(ntb->epf->epc,
+				      ntb->epf->func_no,
+				      ntb->epf->vfunc_no,
+				      &ntb->epf->bar[barno]);
+		if (ret) {
+			dev_err(dev, "MW set failed\n");
+			goto err_alloc_mem;
+		}
+
+		/* Allocate EPC outbound memory windows to vpci vntb device */
+		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
+							      &ntb->vpci_mw_phy[i],
+							      size);
+		if (!ntb->vpci_mw_addr[i]) {
+			dev_err(dev, "Failed to allocate source address\n");
+			goto err_alloc_mem;
+		}
+	}
+
+	return ret;
+err_alloc_mem:
+	return ret;
+}
+
+/**
+ * epf_ntb_mw_bar_clear() - Clear Memory window BARs
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ */
+static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+	int i;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		pci_epc_clear_bar(ntb->epf->epc,
+				  ntb->epf->func_no,
+				  ntb->epf->vfunc_no,
+				  &ntb->epf->bar[barno]);
+
+		pci_epc_mem_free_addr(ntb->epf->epc,
+				      ntb->vpci_mw_phy[i],
+				      ntb->vpci_mw_addr[i],
+				      ntb->mws_size[i]);
+	}
+}
+
+/**
+ * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
+ */
+static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
+{
+	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
+	pci_epc_put(ntb->epf->epc);
+}
+
+/**
+ * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
+ * constructs (scratchpad region, doorbell, memorywindow)
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ */
+static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	enum pci_barno barno;
+	enum epf_ntb_bar bar;
+	struct device *dev;
+	u32 num_mws;
+	int i;
+
+	barno = BAR_0;
+	num_mws = ntb->num_mws;
+	dev = &ntb->epf->dev;
+	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+
+	/* These are required BARs which are mandatory for NTB functionality */
+	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
+		barno = pci_epc_get_next_free_bar(epc_features, barno);
+		if (barno < 0) {
+			dev_err(dev, "Fail to get NTB function BAR\n");
+			return barno;
+		}
+		ntb->epf_ntb_bar[bar] = barno;
+	}
+
+	/* These are optional BARs which don't impact NTB functionality */
+	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, barno++, i++) {
+		barno = pci_epc_get_next_free_bar(epc_features, barno);
+		if (barno < 0) {
+			ntb->num_mws = i;
+			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
+		}
+		ntb->epf_ntb_bar[bar] = barno;
+	}
+
+	return 0;
+}
+
+/**
+ * epf_ntb_epc_init() - Initialize NTB interface
+ * @ntb: NTB device that facilitates communication between HOST and vHOST2
+ *
+ * Wrapper to initialize a particular EPC interface and start the workqueue
+ * to check for commands from host. This function will write to the
+ * EP controller HW for configuring it.
+ */
+static int epf_ntb_epc_init(struct epf_ntb *ntb)
+{
+	u8 func_no, vfunc_no;
+	struct pci_epc *epc;
+	struct pci_epf *epf;
+	struct device *dev;
+	int ret;
+
+	epf = ntb->epf;
+	dev = &epf->dev;
+	epc = epf->epc;
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+
+	ret = epf_ntb_config_sspad_bar_set(ntb);
+	if (ret) {
+		dev_err(dev, "Config/self SPAD BAR init failed");
+		return ret;
+	}
+
+	ret = epf_ntb_configure_interrupt(ntb);
+	if (ret) {
+		dev_err(dev, "Interrupt configuration failed\n");
+		goto err_config_interrupt;
+	}
+
+	ret = epf_ntb_db_bar_init(ntb);
+	if (ret) {
+		dev_err(dev, "DB BAR init failed\n");
+		goto err_db_bar_init;
+	}
+
+	ret = epf_ntb_mw_bar_init(ntb);
+	if (ret) {
+		dev_err(dev, "MW BAR init failed\n");
+		goto err_mw_bar_init;
+	}
+
+	if (vfunc_no <= 1) {
+		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
+		if (ret) {
+			dev_err(dev, "Configuration header write failed\n");
+			goto err_write_header;
+		}
+	}
+
+	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
+	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
+
+	return 0;
+
+err_write_header:
+	epf_ntb_mw_bar_clear(ntb);
+err_mw_bar_init:
+	epf_ntb_db_bar_clear(ntb);
+err_db_bar_init:
+err_config_interrupt:
+	epf_ntb_config_sspad_bar_clear(ntb);
+
+	return ret;
+}
+
+
+/**
+ * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
+ * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ *
+ * Wrapper to cleanup all NTB interfaces.
+ */
+static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
+{
+	epf_ntb_db_bar_clear(ntb);
+	epf_ntb_mw_bar_clear(ntb);
+}
+
+#define EPF_NTB_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+									\
+	return sprintf(page, "%d\n", ntb->_name);			\
+}
+
+#define EPF_NTB_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	u32 val;							\
+	int ret;							\
+									\
+	ret = kstrtou32(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	ntb->_name = val;						\
+									\
+	return len;							\
+}
+
+#define EPF_NTB_MW_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	int win_no;							\
+									\
+	sscanf(#_name, "mw%d", &win_no);				\
+									\
+	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
+}
+
+#define EPF_NTB_MW_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no;							\
+	u64 val;							\
+	int ret;							\
+									\
+	ret = kstrtou64(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
+		return -EINVAL;						\
+									\
+	if (ntb->num_mws < win_no) {					\
+		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+		return -EINVAL;						\
+	}								\
+									\
+	ntb->mws_size[win_no - 1] = val;				\
+									\
+	return len;							\
+}
+
+static ssize_t epf_ntb_num_mws_store(struct config_item *item,
+				     const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct epf_ntb *ntb = to_epf_ntb(group);
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(page, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > MAX_MW)
+		return -EINVAL;
+
+	ntb->num_mws = val;
+
+	return len;
+}
+
+EPF_NTB_R(spad_count)
+EPF_NTB_W(spad_count)
+EPF_NTB_R(db_count)
+EPF_NTB_W(db_count)
+EPF_NTB_R(num_mws)
+EPF_NTB_R(vbus_number)
+EPF_NTB_W(vbus_number)
+EPF_NTB_R(vntb_pid)
+EPF_NTB_W(vntb_pid)
+EPF_NTB_R(vntb_vid)
+EPF_NTB_W(vntb_vid)
+EPF_NTB_MW_R(mw1)
+EPF_NTB_MW_W(mw1)
+EPF_NTB_MW_R(mw2)
+EPF_NTB_MW_W(mw2)
+EPF_NTB_MW_R(mw3)
+EPF_NTB_MW_W(mw3)
+EPF_NTB_MW_R(mw4)
+EPF_NTB_MW_W(mw4)
+
+CONFIGFS_ATTR(epf_ntb_, spad_count);
+CONFIGFS_ATTR(epf_ntb_, db_count);
+CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, mw1);
+CONFIGFS_ATTR(epf_ntb_, mw2);
+CONFIGFS_ATTR(epf_ntb_, mw3);
+CONFIGFS_ATTR(epf_ntb_, mw4);
+CONFIGFS_ATTR(epf_ntb_, vbus_number);
+CONFIGFS_ATTR(epf_ntb_, vntb_pid);
+CONFIGFS_ATTR(epf_ntb_, vntb_vid);
+
+static struct configfs_attribute *epf_ntb_attrs[] = {
+	&epf_ntb_attr_spad_count,
+	&epf_ntb_attr_db_count,
+	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_mw1,
+	&epf_ntb_attr_mw2,
+	&epf_ntb_attr_mw3,
+	&epf_ntb_attr_mw4,
+	&epf_ntb_attr_vbus_number,
+	&epf_ntb_attr_vntb_pid,
+	&epf_ntb_attr_vntb_vid,
+	NULL,
+};
+
+static const struct config_item_type ntb_group_type = {
+	.ct_attrs	= epf_ntb_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+/**
+ * epf_ntb_add_cfs() - Add configfs directory specific to NTB
+ * @epf: NTB endpoint function device
+ * @group: A pointer to the config_group structure referencing a group of
+ *	   config_items of a specific type that belong to a specific sub-system.
+ *
+ * Add configfs directory specific to NTB. This directory will hold
+ * NTB specific properties like db_count, spad_count, num_mws etc.,
+ */
+static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
+					    struct config_group *group)
+{
+	struct epf_ntb *ntb = epf_get_drvdata(epf);
+	struct config_group *ntb_group = &ntb->group;
+	struct device *dev = &epf->dev;
+
+	config_group_init_type_name(ntb_group, dev_name(dev), &ntb_group_type);
+
+	return ntb_group;
+}
+
+/*==== virtual PCI bus driver, which only load virtual NTB PCI driver ====*/
+
+static u32 pci_space[] = {
+	0xffffffff,	/*DeviceID, Vendor ID*/
+	0,		/*Status, Command*/
+	0xffffffff,	/*Class code, subclass, prog if, revision id*/
+	0x40,		/*bist, header type, latency Timer, cache line size*/
+	0,		/*BAR 0*/
+	0,		/*BAR 1*/
+	0,		/*BAR 2*/
+	0,		/*BAR 3*/
+	0,		/*BAR 4*/
+	0,		/*BAR 5*/
+	0,		/*Cardbus cis point*/
+	0,		/*Subsystem ID Subystem vendor id*/
+	0,		/*ROM Base Address*/
+	0,		/*Reserved, Cap. Point*/
+	0,		/*Reserved,*/
+	0,		/*Max Lat, Min Gnt, interrupt pin, interrupt line*/
+};
+
+int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
+{
+	if (devfn == 0) {
+		memcpy(val, ((u8 *)pci_space) + where, size);
+		return PCIBIOS_SUCCESSFUL;
+	}
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
+{
+	return 0;
+}
+
+struct pci_ops vpci_ops = {
+	.read = pci_read,
+	.write = pci_write,
+};
+
+static int vpci_scan_bus(void *sysdata)
+{
+	struct pci_bus *vpci_bus;
+	struct epf_ntb *ndev = sysdata;
+
+	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
+	if (vpci_bus)
+		pr_err("create pci bus\n");
+
+	pci_bus_add_devices(vpci_bus);
+
+	return 0;
+}
+
+/*==================== Virtual PCIe NTB driver ==========================*/
+
+static int vntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	return ndev->num_mws;
+}
+
+static int vntb_epf_spad_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->spad_count;
+}
+
+static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->num_mws;
+}
+
+static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
+{
+	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
+}
+
+static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	return 0;
+}
+
+static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
+		dma_addr_t addr, resource_size_t size)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct pci_epf_bar *epf_bar;
+	enum pci_barno barno;
+	int ret;
+	struct device *dev;
+
+	dev = &ntb->ntb.dev;
+	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
+	epf_bar = &ntb->epf->bar[barno];
+	epf_bar->phys_addr = addr;
+	epf_bar->barno = barno;
+	epf_bar->size = size;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
+	if (ret) {
+		dev_err(dev, "failure set mw trans\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
+{
+	return 0;
+}
+
+static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
+				phys_addr_t *base, resource_size_t *size)
+{
+
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	if (base)
+		*base = ntb->vpci_mw_phy[idx];
+
+	if (size)
+		*size = ntb->mws_size[idx];
+
+	return 0;
+}
+
+static int vntb_epf_link_enable(struct ntb_dev *ntb,
+			enum ntb_speed max_speed,
+			enum ntb_width max_width)
+{
+	return 0;
+}
+
+static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * 4;
+	u32 val;
+	void __iomem *base = ntb->reg;
+
+	val = readl(base + off + ct + idx * 4);
+	return val;
+}
+
+static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct epf_ntb_ctrl *ctrl = ntb->reg;
+	int off = ctrl->spad_offset, ct = ctrl->spad_count * 4;
+	void __iomem *base = ntb->reg;
+
+	writel(val, base + off + ct + idx * 4);
+	return 0;
+}
+
+static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct epf_ntb_ctrl *ctrl = ntb->reg;
+	int off = ctrl->spad_offset;
+	void __iomem *base = ntb->reg;
+	u32 val;
+
+	val = readl(base + off + idx * 4);
+	return val;
+}
+
+static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32 val)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct epf_ntb_ctrl *ctrl = ntb->reg;
+	int off = ctrl->spad_offset;
+	void __iomem *base = ntb->reg;
+
+	writel(val, base + off + idx * 4);
+	return 0;
+}
+
+static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
+{
+	u32 interrupt_num = ffs(db_bits) + 1;
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	u8 func_no, vfunc_no;
+	int ret;
+
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+
+	ret = pci_epc_raise_irq(ntb->epf->epc,
+				func_no,
+				vfunc_no,
+				PCI_EPC_IRQ_MSI,
+				interrupt_num + 1);
+	if (ret)
+		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+
+	return ret;
+}
+
+static u64 vntb_epf_db_read(struct ntb_dev *ndev)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	return ntb->db;
+}
+
+static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
+			resource_size_t *addr_align,
+			resource_size_t *size_align,
+			resource_size_t *size_max)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	if (addr_align)
+		*addr_align = SZ_4K;
+
+	if (size_align)
+		*size_align = 1;
+
+	if (size_max)
+		*size_max = ntb->mws_size[idx];
+
+	return 0;
+}
+
+static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
+			enum ntb_speed *speed,
+			enum ntb_width *width)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	return ntb->reg->link_status;
+}
+
+static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
+{
+	return 0;
+}
+
+static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	ntb->db &= ~db_bits;
+	return 0;
+}
+
+static int vntb_epf_link_disable(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static const struct ntb_dev_ops vntb_epf_ops = {
+	.mw_count		= vntb_epf_mw_count,
+	.spad_count		= vntb_epf_spad_count,
+	.peer_mw_count		= vntb_epf_peer_mw_count,
+	.db_valid_mask		= vntb_epf_db_valid_mask,
+	.db_set_mask		= vntb_epf_db_set_mask,
+	.mw_set_trans		= vntb_epf_mw_set_trans,
+	.mw_clear_trans		= vntb_epf_mw_clear_trans,
+	.peer_mw_get_addr	= vntb_epf_peer_mw_get_addr,
+	.link_enable		= vntb_epf_link_enable,
+	.spad_read		= vntb_epf_spad_read,
+	.spad_write		= vntb_epf_spad_write,
+	.peer_spad_read		= vntb_epf_peer_spad_read,
+	.peer_spad_write	= vntb_epf_peer_spad_write,
+	.peer_db_set		= vntb_epf_peer_db_set,
+	.db_read		= vntb_epf_db_read,
+	.mw_get_align		= vntb_epf_mw_get_align,
+	.link_is_up		= vntb_epf_link_is_up,
+	.db_clear_mask		= vntb_epf_db_clear_mask,
+	.db_clear		= vntb_epf_db_clear,
+	.link_disable		= vntb_epf_link_disable,
+};
+
+static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
+	struct device *dev = &pdev->dev;
+
+	ndev->ntb.pdev = pdev;
+	ndev->ntb.topo = NTB_TOPO_NONE;
+	ndev->ntb.ops =  &vntb_epf_ops;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(dev, "Cannot set DMA mask\n");
+		return -EINVAL;
+	}
+
+	ret = ntb_register_device(&ndev->ntb);
+	if (ret) {
+		dev_err(dev, "Failed to register NTB device\n");
+		return ret;
+	}
+
+	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
+	return 0;
+}
+
+static struct pci_device_id pci_vntb_table[] = {
+	{
+		PCI_DEVICE(0xffff, 0xffff),
+	},
+	{},
+};
+
+static struct pci_driver vntb_pci_driver = {
+	.name           = "pci-vntb",
+	.id_table       = pci_vntb_table,
+	.probe          = pci_vntb_probe,
+};
+
+/* ============ PCIe EPF Driver Bind ====================*/
+
+/**
+ * epf_ntb_bind() - Initialize endpoint controller to provide NTB functionality
+ * @epf: NTB endpoint function device
+ *
+ * Initialize both the endpoint controllers associated with NTB function device.
+ * Invoked when a primary interface or secondary interface is bound to EPC
+ * device. This function will succeed only when EPC is bound to both the
+ * interfaces.
+ */
+static int epf_ntb_bind(struct pci_epf *epf)
+{
+	struct epf_ntb *ntb = epf_get_drvdata(epf);
+	struct device *dev = &epf->dev;
+	int ret;
+
+	if (!epf->epc) {
+		dev_dbg(dev, "PRIMARY EPC interface not yet bound\n");
+		return 0;
+	}
+
+	ret = epf_ntb_init_epc_bar(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to create NTB EPC\n");
+		goto err_bar_init;
+	}
+
+	ret = epf_ntb_config_spad_bar_alloc(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to allocate BAR memory\n");
+		goto err_bar_alloc;
+	}
+
+	ret = epf_ntb_epc_init(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to initialize EPC\n");
+		goto err_bar_alloc;
+	}
+
+	epf_set_drvdata(epf, ntb);
+
+	pci_space[0] = (ntb->vntb_pid << 16) | ntb->vntb_vid;
+	pci_vntb_table[0].vendor = ntb->vntb_vid;
+	pci_vntb_table[0].device = ntb->vntb_pid;
+
+	if (pci_register_driver(&vntb_pci_driver)) {
+		dev_err(dev, "failure register vntb pci driver\n");
+		goto err_bar_alloc;
+	}
+
+	vpci_scan_bus(ntb);
+
+	return 0;
+
+err_bar_alloc:
+	epf_ntb_config_spad_bar_free(ntb);
+
+err_bar_init:
+	epf_ntb_epc_destroy(ntb);
+
+	return ret;
+}
+
+/**
+ * epf_ntb_unbind() - Cleanup the initialization from epf_ntb_bind()
+ * @epf: NTB endpoint function device
+ *
+ * Cleanup the initialization from epf_ntb_bind()
+ */
+static void epf_ntb_unbind(struct pci_epf *epf)
+{
+	struct epf_ntb *ntb = epf_get_drvdata(epf);
+
+	epf_ntb_epc_cleanup(ntb);
+	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_epc_destroy(ntb);
+
+	pci_unregister_driver(&vntb_pci_driver);
+}
+
+// EPF driver probe
+static struct pci_epf_ops epf_ntb_ops = {
+	.bind   = epf_ntb_bind,
+	.unbind = epf_ntb_unbind,
+	.add_cfs = epf_ntb_add_cfs,
+};
+
+/**
+ * epf_ntb_probe() - Probe NTB function driver
+ * @epf: NTB endpoint function device
+ *
+ * Probe NTB function driver when endpoint function bus detects a NTB
+ * endpoint function.
+ */
+static int epf_ntb_probe(struct pci_epf *epf)
+{
+	struct epf_ntb *ntb;
+	struct device *dev;
+
+	dev = &epf->dev;
+
+	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
+	if (!ntb)
+		return -ENOMEM;
+
+	epf->header = &epf_ntb_header;
+	ntb->epf = epf;
+	ntb->vbus_number = 0xff;
+	epf_set_drvdata(epf, ntb);
+
+	dev_info(dev, "pci-ep epf driver loaded\n");
+	return 0;
+}
+
+static const struct pci_epf_device_id epf_ntb_ids[] = {
+	{
+		.name = "pci_epf_vntb",
+	},
+	{},
+};
+
+static struct pci_epf_driver epf_ntb_driver = {
+	.driver.name    = "pci_epf_vntb",
+	.probe          = epf_ntb_probe,
+	.id_table       = epf_ntb_ids,
+	.ops            = &epf_ntb_ops,
+	.owner          = THIS_MODULE,
+};
+
+static int __init epf_ntb_init(void)
+{
+	int ret;
+
+	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
+					    WQ_HIGHPRI, 0);
+	ret = pci_epf_register_driver(&epf_ntb_driver);
+	if (ret) {
+		destroy_workqueue(kpcintb_workqueue);
+		pr_err("Failed to register pci epf ntb driver --> %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(epf_ntb_init);
+
+static void __exit epf_ntb_exit(void)
+{
+	pci_epf_unregister_driver(&epf_ntb_driver);
+	destroy_workqueue(kpcintb_workqueue);
+}
+module_exit(epf_ntb_exit);
+
+MODULE_DESCRIPTION("PCI EPF NTB DRIVER");
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 316fd2f44df45..57654c82b08e8 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -536,7 +536,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	p2pdma = rcu_dereference(provider->p2pdma);
 	if (p2pdma)
 		xa_store(&p2pdma->map_types, map_types_idx(client),
-			 xa_mk_value(map_type), GFP_KERNEL);
+			 xa_mk_value(map_type), GFP_ATOMIC);
 	rcu_read_unlock();
 	return map_type;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2b5337980da7d..ec968b14aa2a2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -395,11 +395,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	return 0;
 }
 
-static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
-{
-	return dev->error_state == pci_channel_io_perm_failure;
-}
-
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DPC_RECOVERED 1
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f21d64ae4ffcc..cf0d4ba2e157a 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -231,7 +231,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fcdc17bbcc8ee..1b6484c906094 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5390,6 +5390,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 2a026183f06b3..bc14386ba440c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1614,7 +1614,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1635,6 +1635,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 0c16b2c756bf3..f3020e3c8533b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1346,7 +1346,6 @@ static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8192_pin_di_range),
 	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt8192_pin_do_range),
-	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt8192_pin_smt_range),
 	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt8192_pin_ies_range),
 	[PINCTRL_PIN_REG_PU] = MTK_RANGE(mt8192_pin_pu_range),
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index a43b2babc8093..3e9c94a8d7f72 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -38,11 +38,11 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 	return container_of(chip, struct atmel_hlcdc_pwm, chip);
 }
 
-static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
+static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				 const struct pwm_state *state)
 {
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
+	struct atmel_hlcdc *hlcdc = atmel->hlcdc;
 	unsigned int status;
 	int ret;
 
@@ -54,7 +54,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		u32 pwmcfg;
 		int pres;
 
-		if (!chip->errata || !chip->errata->slow_clk_erratum) {
+		if (!atmel->errata || !atmel->errata->slow_clk_erratum) {
 			clk_freq = clk_get_rate(new_clk);
 			if (!clk_freq)
 				return -EINVAL;
@@ -64,7 +64,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		}
 
 		/* Errata: cannot use slow clk on some IP revisions */
-		if ((chip->errata && chip->errata->slow_clk_erratum) ||
+		if ((atmel->errata && atmel->errata->slow_clk_erratum) ||
 		    clk_period_ns > state->period) {
 			new_clk = hlcdc->sys_clk;
 			clk_freq = clk_get_rate(new_clk);
@@ -77,8 +77,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 
 		for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
 		/* Errata: cannot divide by 1 on some IP revisions */
-			if (!pres && chip->errata &&
-			    chip->errata->div1_clk_erratum)
+			if (!pres && atmel->errata &&
+			    atmel->errata->div1_clk_erratum)
 				continue;
 
 			if ((clk_period_ns << pres) >= state->period)
@@ -90,7 +90,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 
 		pwmcfg = ATMEL_HLCDC_PWMPS(pres);
 
-		if (new_clk != chip->cur_clk) {
+		if (new_clk != atmel->cur_clk) {
 			u32 gencfg = 0;
 			int ret;
 
@@ -98,8 +98,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 			if (ret)
 				return ret;
 
-			clk_disable_unprepare(chip->cur_clk);
-			chip->cur_clk = new_clk;
+			clk_disable_unprepare(atmel->cur_clk);
+			atmel->cur_clk = new_clk;
 
 			if (new_clk == hlcdc->sys_clk)
 				gencfg = ATMEL_HLCDC_CLKPWMSEL;
@@ -160,8 +160,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		clk_disable_unprepare(chip->cur_clk);
-		chip->cur_clk = NULL;
+		clk_disable_unprepare(atmel->cur_clk);
+		atmel->cur_clk = NULL;
 	}
 
 	return 0;
@@ -183,31 +183,32 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 #ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&chip->chip.pwms[0]))
-		clk_disable_unprepare(chip->hlcdc->periph_clk);
+	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
+		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
 }
 
 static int atmel_hlcdc_pwm_resume(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 	struct pwm_state state;
 	int ret;
 
-	pwm_get_state(&chip->chip.pwms[0], &state);
+	pwm_get_state(&atmel->chip.pwms[0], &state);
 
 	/* Re-enable the periph clock it was stopped during suspend. */
 	if (!state.enabled) {
-		ret = clk_prepare_enable(chip->hlcdc->periph_clk);
+		ret = clk_prepare_enable(atmel->hlcdc->periph_clk);
 		if (ret)
 			return ret;
 	}
 
-	return atmel_hlcdc_pwm_apply(&chip->chip, &chip->chip.pwms[0], &state);
+	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
+				     &state);
 }
 #endif
 
@@ -244,14 +245,14 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
-	struct atmel_hlcdc_pwm *chip;
+	struct atmel_hlcdc_pwm *atmel;
 	struct atmel_hlcdc *hlcdc;
 	int ret;
 
 	hlcdc = dev_get_drvdata(dev->parent);
 
-	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
+	atmel = devm_kzalloc(dev, sizeof(*atmel), GFP_KERNEL);
+	if (!atmel)
 		return -ENOMEM;
 
 	ret = clk_prepare_enable(hlcdc->periph_clk);
@@ -260,33 +261,31 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 
 	match = of_match_node(atmel_hlcdc_dt_ids, dev->parent->of_node);
 	if (match)
-		chip->errata = match->data;
+		atmel->errata = match->data;
 
-	chip->hlcdc = hlcdc;
-	chip->chip.ops = &atmel_hlcdc_pwm_ops;
-	chip->chip.dev = dev;
-	chip->chip.npwm = 1;
+	atmel->hlcdc = hlcdc;
+	atmel->chip.ops = &atmel_hlcdc_pwm_ops;
+	atmel->chip.dev = dev;
+	atmel->chip.npwm = 1;
 
-	ret = pwmchip_add(&chip->chip);
+	ret = pwmchip_add(&atmel->chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, chip);
+	platform_set_drvdata(pdev, atmel);
 
 	return 0;
 }
 
-static int atmel_hlcdc_pwm_remove(struct platform_device *pdev)
+static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_hlcdc_pwm *chip = platform_get_drvdata(pdev);
+	struct atmel_hlcdc_pwm *atmel = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&chip->chip);
+	pwmchip_remove(&atmel->chip);
 
-	clk_disable_unprepare(chip->hlcdc->periph_clk);
-
-	return 0;
+	clk_disable_unprepare(atmel->hlcdc->periph_clk);
 }
 
 static const struct of_device_id atmel_hlcdc_pwm_dt_ids[] = {
@@ -301,7 +300,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
 		.pm = &atmel_hlcdc_pwm_pm_ops,
 	},
 	.probe = atmel_hlcdc_pwm_probe,
-	.remove = atmel_hlcdc_pwm_remove,
+	.remove_new = atmel_hlcdc_pwm_remove,
 };
 module_platform_driver(atmel_hlcdc_pwm_driver);
 
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index f8a3f30e54dd5..0a7920cbd4949 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -392,11 +392,43 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	struct sti_pwm_compat_data *cdata = pc->cdata;
+	struct device *dev = pc->dev;
+	int err;
+
+	if (pwm->hwpwm >= cdata->pwm_num_devs) {
+		dev_err(dev, "device %u is not valid for pwm mode\n",
+			pwm->hwpwm);
+		return -EINVAL;
+	}
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			sti_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = sti_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = sti_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops sti_pwm_ops = {
 	.capture = sti_pwm_capture,
-	.config = sti_pwm_config,
-	.enable = sti_pwm_enable,
-	.disable = sti_pwm_disable,
+	.apply = sti_pwm_apply,
 	.free = sti_pwm_free,
 	.owner = THIS_MODULE,
 };
@@ -624,7 +656,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	pc->chip.npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 9a6eedc3994a5..d89460429257e 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -276,7 +276,7 @@ config ST_SLIM_REMOTEPROC
 
 config STM32_RPROC
 	tristate "STM32 remoteproc support"
-	depends on ARCH_STM32
+	depends on ARCH_STM32 || COMPILE_TEST
 	depends on REMOTEPROC
 	select MAILBOX
 	help
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index aba3df1d1bf52..9a29285246f4b 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -118,10 +118,10 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
 	struct device *dev = rproc->dev.parent;
 	void *va;
 
-	dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
-	va = ioremap_wc(mem->dma, mem->len);
+	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
+	va = (__force void *)ioremap_wc(mem->dma, mem->len);
 	if (IS_ERR_OR_NULL(va)) {
-		dev_err(dev, "Unable to map memory region: %pa+%x\n",
+		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
 			&mem->dma, mem->len);
 		return -ENOMEM;
 	}
@@ -136,7 +136,7 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
 				   struct rproc_mem_entry *mem)
 {
 	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
-	iounmap(mem->va);
+	iounmap((__force __iomem void *)mem->va);
 
 	return 0;
 }
@@ -627,7 +627,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 
 	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
 	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
-		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+		dev_err(dev, "Unable to map memory region: %pa+%x\n",
 			&rsc_pa, RSC_TBL_SIZE);
 		ddata->rsc_va = NULL;
 		return ERR_PTR(-ENOMEM);
@@ -641,7 +641,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 	 * entire area by overwriting it with the initial values stored in rproc->clean_table.
 	 */
 	*table_sz = RSC_TBL_SIZE;
-	return (struct resource_table *)ddata->rsc_va;
+	return (__force struct resource_table *)ddata->rsc_va;
 }
 
 static const struct rproc_ops st_rproc_ops = {
@@ -889,7 +889,7 @@ static int stm32_rproc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_rproc_suspend(struct device *dev)
+static int stm32_rproc_suspend(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	struct stm32_rproc *ddata = rproc->priv;
@@ -900,7 +900,7 @@ static int __maybe_unused stm32_rproc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_rproc_resume(struct device *dev)
+static int stm32_rproc_resume(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	struct stm32_rproc *ddata = rproc->priv;
@@ -911,16 +911,16 @@ static int __maybe_unused stm32_rproc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
-			 stm32_rproc_suspend, stm32_rproc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
+				stm32_rproc_suspend, stm32_rproc_resume);
 
 static struct platform_driver stm32_rproc_driver = {
 	.probe = stm32_rproc_probe,
 	.remove = stm32_rproc_remove,
 	.driver = {
 		.name = "stm32-rproc",
-		.pm = &stm32_rproc_pm_ops,
-		.of_match_table = of_match_ptr(stm32_rproc_match),
+		.pm = pm_ptr(&stm32_rproc_pm_ops),
+		.of_match_table = stm32_rproc_match,
 	},
 };
 module_platform_driver(stm32_rproc_driver);
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e1bc5214494e2..ee59c82f9df18 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1814,7 +1814,8 @@ config RTC_DRV_MT2712
 
 config RTC_DRV_MT6397
 	tristate "MediaTek PMIC based RTC"
-	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
+	depends on MFD_MT6397 || COMPILE_TEST
+	select IRQ_DOMAIN
 	help
 	  This selects the MediaTek(R) RTC driver. RTC is part of MediaTek
 	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select
diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
index d5caf36c56cdc..225c859d6da55 100644
--- a/drivers/rtc/lib_test.c
+++ b/drivers/rtc/lib_test.c
@@ -54,7 +54,7 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%d/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%d/%02d/%02d (%2d) : %lld", \
 			year, month, mday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index dc73b20e7424f..fc33474271115 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -8,9 +8,6 @@
  * Copyright IBM Corp. 1999, 2009
  */
 
-#define KMSG_COMPONENT "dasd"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
-
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -84,7 +81,8 @@ static void dasd_profile_init(struct dasd_profile *, struct dentry *);
 static void dasd_profile_exit(struct dasd_profile *);
 static void dasd_hosts_init(struct dentry *, struct dasd_device *);
 static void dasd_hosts_exit(struct dasd_device *);
-
+static int dasd_handle_autoquiesce(struct dasd_device *, struct dasd_ccw_req *,
+				   unsigned int);
 /*
  * SECTION: Operations on the device structure.
  */
@@ -2349,7 +2347,7 @@ static int _dasd_sleep_on(struct dasd_ccw_req *maincqr, int interruptible)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (device->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(device))) {
+		    !dasd_eer_enabled(device) && device->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			continue;
@@ -2825,20 +2823,18 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 			dasd_log_sense(cqr, &cqr->irb);
 		}
 
-		/* First of all call extended error reporting. */
-		if (dasd_eer_enabled(base) &&
-		    cqr->status == DASD_CQR_FAILED) {
-			dasd_eer_write(base, cqr, DASD_EER_FATALERROR);
-
-			/* restart request  */
+		/*
+		 * First call extended error reporting and check for autoquiesce
+		 */
+		spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
+		if (cqr->status == DASD_CQR_FAILED &&
+		    dasd_handle_autoquiesce(base, cqr, DASD_EER_FATALERROR)) {
 			cqr->status = DASD_CQR_FILLED;
 			cqr->retries = 255;
-			spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
-			dasd_device_set_stop_bits(base, DASD_STOPPED_QUIESCE);
-			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
-					       flags);
+			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 			goto restart;
 		}
+		spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 		/* Process finished ERP request. */
 		if (cqr->refers) {
@@ -2880,7 +2876,7 @@ static void __dasd_block_start_head(struct dasd_block *block)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (block->base->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(block->base))) {
+		    !dasd_eer_enabled(block->base) && block->base->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			dasd_schedule_block_bh(block);
@@ -3452,8 +3448,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
 
 	ret = ccw_device_set_online(cdev);
 	if (ret)
-		pr_warn("%s: Setting the DASD online failed with rc=%d\n",
-			dev_name(&cdev->dev), ret);
+		dev_warn(&cdev->dev, "Setting the DASD online failed with rc=%d\n", ret);
 }
 
 /*
@@ -3540,8 +3535,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 {
 	struct dasd_discipline *discipline;
 	struct dasd_device *device;
+	struct device *dev;
 	int rc;
 
+	dev = &cdev->dev;
+
 	/* first online clears initial online feature flag */
 	dasd_set_feature(cdev, DASD_FEATURE_INITIAL_ONLINE, 0);
 	device = dasd_create_device(cdev);
@@ -3554,11 +3552,10 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 			/* Try to load the required module. */
 			rc = request_module(DASD_DIAG_MOD);
 			if (rc) {
-				pr_warn("%s Setting the DASD online failed "
-					"because the required module %s "
-					"could not be loaded (rc=%d)\n",
-					dev_name(&cdev->dev), DASD_DIAG_MOD,
-					rc);
+				dev_warn(dev, "Setting the DASD online failed "
+					 "because the required module %s "
+					 "could not be loaded (rc=%d)\n",
+					 DASD_DIAG_MOD, rc);
 				dasd_delete_device(device);
 				return -ENODEV;
 			}
@@ -3566,8 +3563,7 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		/* Module init could have failed, so check again here after
 		 * request_module(). */
 		if (!dasd_diag_discipline_pointer) {
-			pr_warn("%s Setting the DASD online failed because of missing DIAG discipline\n",
-				dev_name(&cdev->dev));
+			dev_warn(dev, "Setting the DASD online failed because of missing DIAG discipline\n");
 			dasd_delete_device(device);
 			return -ENODEV;
 		}
@@ -3577,37 +3573,33 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
+	device->base_discipline = base_discipline;
 	if (!try_module_get(discipline->owner)) {
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
-	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
 	/* check_device will allocate block device if necessary */
 	rc = discipline->check_device(device);
 	if (rc) {
-		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
-			dev_name(&cdev->dev), discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
+		dev_warn(dev, "Setting the DASD online with discipline %s failed with rc=%i\n",
+			 discipline->name, rc);
 		dasd_delete_device(device);
 		return rc;
 	}
 
 	dasd_set_target_state(device, DASD_STATE_ONLINE);
 	if (device->state <= DASD_STATE_KNOWN) {
-		pr_warn("%s Setting the DASD online failed because of a missing discipline\n",
-			dev_name(&cdev->dev));
+		dev_warn(dev, "Setting the DASD online failed because of a missing discipline\n");
 		rc = -ENODEV;
 		dasd_set_target_state(device, DASD_STATE_NEW);
 		if (device->block)
 			dasd_free_block(device->block);
 		dasd_delete_device(device);
-	} else
-		pr_debug("dasd_generic device %s found\n",
-				dev_name(&cdev->dev));
+	} else {
+		dev_dbg(dev, "dasd_generic device found\n");
+	}
 
 	wait_event(dasd_init_waitq, _wait_for_device(device));
 
@@ -3618,10 +3610,13 @@ EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 
 int dasd_generic_set_offline(struct ccw_device *cdev)
 {
+	int max_count, open_count, rc;
 	struct dasd_device *device;
 	struct dasd_block *block;
-	int max_count, open_count, rc;
 	unsigned long flags;
+	struct device *dev;
+
+	dev = &cdev->dev;
 
 	rc = 0;
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
@@ -3642,11 +3637,10 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
-				pr_warn("%s: The DASD cannot be set offline with open count %i\n",
-					dev_name(&cdev->dev), open_count);
+				dev_warn(dev, "The DASD cannot be set offline with open count %i\n",
+					 open_count);
 			else
-				pr_warn("%s: The DASD cannot be set offline while it is in use\n",
-					dev_name(&cdev->dev));
+				dev_warn(dev, "The DASD cannot be set offline while it is in use\n");
 			rc = -EBUSY;
 			goto out_err;
 		}
@@ -3743,8 +3737,8 @@ int dasd_generic_last_path_gone(struct dasd_device *device)
 	dev_warn(&device->cdev->dev, "No operational channel path is left "
 		 "for the device\n");
 	DBF_DEV_EVENT(DBF_WARNING, device, "%s", "last path gone");
-	/* First of all call extended error reporting. */
-	dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 
 	if (device->state < DASD_STATE_BASIC)
 		return 0;
@@ -3877,7 +3871,8 @@ void dasd_generic_path_event(struct ccw_device *cdev, int *path_event)
 			 "No verified channel paths remain for the device\n");
 		DBF_DEV_EVENT(DBF_WARNING, device,
 			      "%s", "last verified path gone");
-		dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+		/* First call extended error reporting and check for autoquiesce. */
+		dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 		dasd_device_set_stop_bits(device,
 					  DASD_STOPPED_DC_WAIT);
 	}
@@ -3899,7 +3894,8 @@ EXPORT_SYMBOL_GPL(dasd_generic_verify_path);
 void dasd_generic_space_exhaust(struct dasd_device *device,
 				struct dasd_ccw_req *cqr)
 {
-	dasd_eer_write(device, NULL, DASD_EER_NOSPC);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOSPC);
 
 	if (device->state < DASD_STATE_BASIC)
 		return;
@@ -3992,6 +3988,31 @@ void dasd_schedule_requeue(struct dasd_device *device)
 }
 EXPORT_SYMBOL(dasd_schedule_requeue);
 
+static int dasd_handle_autoquiesce(struct dasd_device *device,
+				   struct dasd_ccw_req *cqr,
+				   unsigned int reason)
+{
+	/* in any case write eer message with reason */
+	if (dasd_eer_enabled(device))
+		dasd_eer_write(device, cqr, reason);
+
+	if (!test_bit(reason, &device->aq_mask))
+		return 0;
+
+	/* notify eer about autoquiesce */
+	if (dasd_eer_enabled(device))
+		dasd_eer_write(device, NULL, DASD_EER_AUTOQUIESCE);
+
+	dev_info(&device->cdev->dev,
+		 "The DASD has been put in the quiesce state\n");
+	dasd_device_set_stop_bits(device, DASD_STOPPED_QUIESCE);
+
+	if (device->features & DASD_FEATURE_REQUEUEQUIESCE)
+		dasd_schedule_requeue(device);
+
+	return 1;
+}
+
 static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 						   int rdc_buffer_size,
 						   int magic)
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 2c40fe15da552..6f9f7a0723128 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -26,7 +26,6 @@
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd_devmap:"
-#define DASD_BUS_ID_SIZE 20
 #define DASD_MAX_PARAMS 256
 
 #include "dasd_int.h"
@@ -50,6 +49,7 @@ struct dasd_devmap {
         unsigned int devindex;
         unsigned short features;
 	struct dasd_device *device;
+	struct dasd_copy_relation *copy;
 };
 
 /*
@@ -130,7 +130,7 @@ __setup ("dasd=", dasd_call_setup);
 /*
  * Read a device busid/devno from a string.
  */
-static int __init dasd_busid(char *str, int *id0, int *id1, int *devno)
+static int dasd_busid(char *str, int *id0, int *id1, int *devno)
 {
 	unsigned int val;
 	char *tok;
@@ -438,16 +438,12 @@ dasd_add_busid(const char *bus_id, int features)
 	return devmap;
 }
 
-/*
- * Find devmap for device with given bus_id.
- */
 static struct dasd_devmap *
-dasd_find_busid(const char *bus_id)
+dasd_find_busid_locked(const char *bus_id)
 {
 	struct dasd_devmap *devmap, *tmp;
 	int hash;
 
-	spin_lock(&dasd_devmap_lock);
 	devmap = ERR_PTR(-ENODEV);
 	hash = dasd_hash_busid(bus_id);
 	list_for_each_entry(tmp, &dasd_hashlists[hash], list) {
@@ -456,6 +452,19 @@ dasd_find_busid(const char *bus_id)
 			break;
 		}
 	}
+	return devmap;
+}
+
+/*
+ * Find devmap for device with given bus_id.
+ */
+static struct dasd_devmap *
+dasd_find_busid(const char *bus_id)
+{
+	struct dasd_devmap *devmap;
+
+	spin_lock(&dasd_devmap_lock);
+	devmap = dasd_find_busid_locked(bus_id);
 	spin_unlock(&dasd_devmap_lock);
 	return devmap;
 }
@@ -584,6 +593,238 @@ dasd_create_device(struct ccw_device *cdev)
 	return device;
 }
 
+/*
+ * allocate a PPRC data structure and call the discipline function to fill
+ */
+static int dasd_devmap_get_pprc_status(struct dasd_device *device,
+				       struct dasd_pprc_data_sc4 **data)
+{
+	struct dasd_pprc_data_sc4 *temp;
+
+	if (!device->discipline || !device->discipline->pprc_status) {
+		dev_warn(&device->cdev->dev, "Unable to query copy relation status\n");
+		return -EOPNOTSUPP;
+	}
+	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	/* get PPRC information from storage */
+	if (device->discipline->pprc_status(device, temp)) {
+		dev_warn(&device->cdev->dev, "Error during copy relation status query\n");
+		kfree(temp);
+		return -EINVAL;
+	}
+	*data = temp;
+
+	return 0;
+}
+
+/*
+ * find an entry in a PPRC device_info array by a given UID
+ * depending on the primary/secondary state of the device it has to be
+ * matched with the respective fields
+ */
+static int dasd_devmap_entry_from_pprc_data(struct dasd_pprc_data_sc4 *data,
+					    struct dasd_uid uid,
+					    bool primary)
+{
+	int i;
+
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (primary) {
+			if (data->dev_info[i].prim_cu_ssid == uid.ssid &&
+			    data->dev_info[i].primary == uid.real_unit_addr)
+				return i;
+		} else {
+			if (data->dev_info[i].sec_cu_ssid == uid.ssid &&
+			    data->dev_info[i].secondary == uid.real_unit_addr)
+				return i;
+		}
+	}
+	return -1;
+}
+
+/*
+ * check the consistency of a specified copy relation by checking
+ * the following things:
+ *
+ *   - is the given device part of a copy pair setup
+ *   - does the state of the device match the state in the PPRC status data
+ *   - does the device UID match with the UID in the PPRC status data
+ *   - to prevent misrouted IO check if the given device is present in all
+ *     related PPRC status data
+ */
+static int dasd_devmap_check_copy_relation(struct dasd_device *device,
+					   struct dasd_copy_entry *entry,
+					   struct dasd_pprc_data_sc4 *data,
+					   struct dasd_copy_relation *copy)
+{
+	struct dasd_pprc_data_sc4 *tmp_dat;
+	struct dasd_device *tmp_dev;
+	struct dasd_uid uid;
+	int i, j;
+
+	if (!device->discipline || !device->discipline->get_uid ||
+	    device->discipline->get_uid(device, &uid))
+		return 1;
+
+	i = dasd_devmap_entry_from_pprc_data(data, uid, entry->primary);
+	if (i < 0) {
+		dev_warn(&device->cdev->dev, "Device not part of a copy relation\n");
+		return 1;
+	}
+
+	/* double check which role the current device has */
+	if (entry->primary) {
+		if (data->dev_info[i].flags & 0x80) {
+			dev_warn(&device->cdev->dev, "Copy pair secondary is setup as primary\n");
+			return 1;
+		}
+		if (data->dev_info[i].prim_cu_ssid != uid.ssid ||
+		    data->dev_info[i].primary != uid.real_unit_addr) {
+			dev_warn(&device->cdev->dev,
+				 "Primary device %s does not match copy pair status primary device %04x\n",
+				 dev_name(&device->cdev->dev),
+				 data->dev_info[i].prim_cu_ssid |
+				 data->dev_info[i].primary);
+			return 1;
+		}
+	} else {
+		if (!(data->dev_info[i].flags & 0x80)) {
+			dev_warn(&device->cdev->dev, "Copy pair primary is setup as secondary\n");
+			return 1;
+		}
+		if (data->dev_info[i].sec_cu_ssid != uid.ssid ||
+		    data->dev_info[i].secondary != uid.real_unit_addr) {
+			dev_warn(&device->cdev->dev,
+				 "Secondary device %s does not match copy pair status secondary device %04x\n",
+				 dev_name(&device->cdev->dev),
+				 data->dev_info[i].sec_cu_ssid |
+				 data->dev_info[i].secondary);
+			return 1;
+		}
+	}
+
+	/*
+	 * the current device has to be part of the copy relation of all
+	 * entries to prevent misrouted IO to another copy pair
+	 */
+	for (j = 0; j < DASD_CP_ENTRIES; j++) {
+		if (entry == &copy->entry[j])
+			tmp_dev = device;
+		else
+			tmp_dev = copy->entry[j].device;
+
+		if (!tmp_dev)
+			continue;
+
+		if (dasd_devmap_get_pprc_status(tmp_dev, &tmp_dat))
+			return 1;
+
+		if (dasd_devmap_entry_from_pprc_data(tmp_dat, uid, entry->primary) < 0) {
+			dev_warn(&tmp_dev->cdev->dev,
+				 "Copy pair relation does not contain device: %s\n",
+				 dev_name(&device->cdev->dev));
+			kfree(tmp_dat);
+			return 1;
+		}
+		kfree(tmp_dat);
+	}
+	return 0;
+}
+
+/* delete device from copy relation entry */
+static void dasd_devmap_delete_copy_relation_device(struct dasd_device *device)
+{
+	struct dasd_copy_relation *copy;
+	int i;
+
+	if (!device->copy)
+		return;
+
+	copy = device->copy;
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].device == device)
+			copy->entry[i].device = NULL;
+	}
+	dasd_put_device(device);
+	device->copy = NULL;
+}
+
+/*
+ * read all required information for a copy relation setup and setup the device
+ * accordingly
+ */
+int dasd_devmap_set_device_copy_relation(struct ccw_device *cdev,
+					 bool pprc_enabled)
+{
+	struct dasd_pprc_data_sc4 *data = NULL;
+	struct dasd_copy_entry *entry = NULL;
+	struct dasd_copy_relation *copy;
+	struct dasd_devmap *devmap;
+	struct dasd_device *device;
+	int i, rc = 0;
+
+	devmap = dasd_devmap_from_cdev(cdev);
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+
+	device = devmap->device;
+	if (!device)
+		return -ENODEV;
+
+	copy = devmap->copy;
+	/* no copy pair setup for this device */
+	if (!copy)
+		goto out;
+
+	rc = dasd_devmap_get_pprc_status(device, &data);
+	if (rc)
+		return rc;
+
+	/* print error if PPRC is requested but not enabled on storage server */
+	if (!pprc_enabled) {
+		dev_err(&cdev->dev, "Copy relation not enabled on storage server\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (!data->dev_info[0].state) {
+		dev_warn(&device->cdev->dev, "Copy pair setup requested for device not in copy relation\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	/* find entry */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured &&
+		    strncmp(dev_name(&cdev->dev),
+			    copy->entry[i].busid, DASD_BUS_ID_SIZE) == 0) {
+			entry = &copy->entry[i];
+			break;
+		}
+	}
+	if (!entry) {
+		dev_warn(&device->cdev->dev, "Copy relation entry not found\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	/* check if the copy relation is valid */
+	if (dasd_devmap_check_copy_relation(device, entry, data, copy)) {
+		dev_warn(&device->cdev->dev, "Copy relation faulty\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dasd_get_device(device);
+	copy->entry[i].device = device;
+	device->copy = copy;
+out:
+	kfree(data);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dasd_devmap_set_device_copy_relation);
+
 /*
  * Wait queue for dasd_delete_device waits.
  */
@@ -617,6 +858,8 @@ dasd_delete_device(struct dasd_device *device)
 	dev_set_drvdata(&device->cdev->dev, NULL);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 
+	/* Removve copy relation */
+	dasd_devmap_delete_copy_relation_device(device);
 	/*
 	 * Drop ref_count by 3, one for the devmap reference, one for
 	 * the cdev reference and one for the passed reference.
@@ -1683,6 +1926,313 @@ dasd_path_fcs_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 static struct kobj_attribute path_fcs_attribute =
 	__ATTR(fc_security, 0444, dasd_path_fcs_show, NULL);
 
+/*
+ * print copy relation in the form
+ * primary,secondary[1] primary,secondary[2], ...
+ */
+static ssize_t
+dasd_copy_pair_show(struct device *dev,
+		    struct device_attribute *attr, char *buf)
+{
+	char prim_busid[DASD_BUS_ID_SIZE];
+	struct dasd_copy_relation *copy;
+	struct dasd_devmap *devmap;
+	int len = 0;
+	int i;
+
+	devmap = dasd_find_busid(dev_name(dev));
+	if (IS_ERR(devmap))
+		return -ENODEV;
+
+	if (!devmap->copy)
+		return -ENODEV;
+
+	copy = devmap->copy;
+	/* find primary */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured && copy->entry[i].primary) {
+			strscpy(prim_busid, copy->entry[i].busid,
+				DASD_BUS_ID_SIZE);
+			break;
+		}
+	}
+	if (!copy->entry[i].primary)
+		goto out;
+
+	/* print all secondary */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured && !copy->entry[i].primary)
+			len += sysfs_emit_at(buf, len, "%s,%s ", prim_busid,
+					     copy->entry[i].busid);
+	}
+
+	len += sysfs_emit_at(buf, len, "\n");
+out:
+	return len;
+}
+
+static int dasd_devmap_set_copy_relation(struct dasd_devmap *devmap,
+					 struct dasd_copy_relation *copy,
+					 char *busid, bool primary)
+{
+	int i;
+
+	/* find free entry */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		/* current bus_id already included, nothing to do */
+		if (copy->entry[i].configured &&
+		    strncmp(copy->entry[i].busid, busid, DASD_BUS_ID_SIZE) == 0)
+			return 0;
+
+		if (!copy->entry[i].configured)
+			break;
+	}
+	if (i == DASD_CP_ENTRIES)
+		return -EINVAL;
+
+	copy->entry[i].configured = true;
+	strscpy(copy->entry[i].busid, busid, DASD_BUS_ID_SIZE);
+	if (primary) {
+		copy->active = &copy->entry[i];
+		copy->entry[i].primary = true;
+	}
+	if (!devmap->copy)
+		devmap->copy = copy;
+
+	return 0;
+}
+
+static void dasd_devmap_del_copy_relation(struct dasd_copy_relation *copy,
+					  char *busid)
+{
+	int i;
+
+	spin_lock(&dasd_devmap_lock);
+	/* find entry */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured &&
+		    strncmp(copy->entry[i].busid, busid, DASD_BUS_ID_SIZE) == 0)
+			break;
+	}
+	if (i == DASD_CP_ENTRIES || !copy->entry[i].configured) {
+		spin_unlock(&dasd_devmap_lock);
+		return;
+	}
+
+	copy->entry[i].configured = false;
+	memset(copy->entry[i].busid, 0, DASD_BUS_ID_SIZE);
+	if (copy->active == &copy->entry[i]) {
+		copy->active = NULL;
+		copy->entry[i].primary = false;
+	}
+	spin_unlock(&dasd_devmap_lock);
+}
+
+static int dasd_devmap_clear_copy_relation(struct device *dev)
+{
+	struct dasd_copy_relation *copy;
+	struct dasd_devmap *devmap;
+	int i, rc = 1;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(devmap))
+		return 1;
+
+	spin_lock(&dasd_devmap_lock);
+	if (!devmap->copy)
+		goto out;
+
+	copy = devmap->copy;
+	/* first check if all secondary devices are offline*/
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (!copy->entry[i].configured)
+			continue;
+
+		if (copy->entry[i].device == copy->active->device)
+			continue;
+
+		if (copy->entry[i].device)
+			goto out;
+	}
+	/* clear all devmap entries */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (strlen(copy->entry[i].busid) == 0)
+			continue;
+		if (copy->entry[i].device) {
+			dasd_put_device(copy->entry[i].device);
+			copy->entry[i].device->copy = NULL;
+			copy->entry[i].device = NULL;
+		}
+		devmap = dasd_find_busid_locked(copy->entry[i].busid);
+		devmap->copy = NULL;
+		memset(copy->entry[i].busid, 0, DASD_BUS_ID_SIZE);
+	}
+	kfree(copy);
+	rc = 0;
+out:
+	spin_unlock(&dasd_devmap_lock);
+	return rc;
+}
+
+/*
+ * parse BUSIDs from a copy pair
+ */
+static int dasd_devmap_parse_busid(const char *buf, char *prim_busid,
+				   char *sec_busid)
+{
+	char *primary, *secondary, *tmp, *pt;
+	int id0, id1, id2;
+
+	pt =  kstrdup(buf, GFP_KERNEL);
+	tmp = pt;
+	if (!tmp)
+		return -ENOMEM;
+
+	primary = strsep(&tmp, ",");
+	if (!primary) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	secondary = strsep(&tmp, ",");
+	if (!secondary) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	if (dasd_busid(primary, &id0, &id1, &id2)) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	sprintf(prim_busid, "%01x.%01x.%04x", id0, id1, id2);
+	if (dasd_busid(secondary, &id0, &id1, &id2)) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	sprintf(sec_busid, "%01x.%01x.%04x", id0, id1, id2);
+	kfree(pt);
+
+	return 0;
+}
+
+static ssize_t dasd_copy_pair_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct dasd_devmap *prim_devmap, *sec_devmap;
+	char prim_busid[DASD_BUS_ID_SIZE];
+	char sec_busid[DASD_BUS_ID_SIZE];
+	struct dasd_copy_relation *copy;
+	struct dasd_device *device;
+	bool pprc_enabled;
+	int rc;
+
+	if (strncmp(buf, "clear", strlen("clear")) == 0) {
+		if (dasd_devmap_clear_copy_relation(dev))
+			return -EINVAL;
+		return count;
+	}
+
+	rc = dasd_devmap_parse_busid(buf, prim_busid, sec_busid);
+	if (rc)
+		return rc;
+
+	if (strncmp(dev_name(dev), prim_busid, DASD_BUS_ID_SIZE) != 0 &&
+	    strncmp(dev_name(dev), sec_busid, DASD_BUS_ID_SIZE) != 0)
+		return -EINVAL;
+
+	/* allocate primary devmap if needed */
+	prim_devmap = dasd_find_busid(prim_busid);
+	if (IS_ERR(prim_devmap))
+		prim_devmap = dasd_add_busid(prim_busid, DASD_FEATURE_DEFAULT);
+
+	/* allocate secondary devmap if needed */
+	sec_devmap = dasd_find_busid(sec_busid);
+	if (IS_ERR(sec_devmap))
+		sec_devmap = dasd_add_busid(sec_busid, DASD_FEATURE_DEFAULT);
+
+	/* setting copy relation is only allowed for offline secondary */
+	if (sec_devmap->device)
+		return -EINVAL;
+
+	if (prim_devmap->copy) {
+		copy = prim_devmap->copy;
+	} else if (sec_devmap->copy) {
+		copy = sec_devmap->copy;
+	} else {
+		copy = kzalloc(sizeof(*copy), GFP_KERNEL);
+		if (!copy)
+			return -ENOMEM;
+	}
+	spin_lock(&dasd_devmap_lock);
+	rc = dasd_devmap_set_copy_relation(prim_devmap, copy, prim_busid, true);
+	if (rc) {
+		spin_unlock(&dasd_devmap_lock);
+		return rc;
+	}
+	rc = dasd_devmap_set_copy_relation(sec_devmap, copy, sec_busid, false);
+	if (rc) {
+		spin_unlock(&dasd_devmap_lock);
+		return rc;
+	}
+	spin_unlock(&dasd_devmap_lock);
+
+	/* if primary device is already online call device setup directly */
+	if (prim_devmap->device && !prim_devmap->device->copy) {
+		device = prim_devmap->device;
+		if (device->discipline->pprc_enabled) {
+			pprc_enabled = device->discipline->pprc_enabled(device);
+			rc = dasd_devmap_set_device_copy_relation(device->cdev,
+								  pprc_enabled);
+		} else {
+			rc = -EOPNOTSUPP;
+		}
+	}
+	if (rc) {
+		dasd_devmap_del_copy_relation(copy, prim_busid);
+		dasd_devmap_del_copy_relation(copy, sec_busid);
+		count = rc;
+	}
+
+	return count;
+}
+static DEVICE_ATTR(copy_pair, 0644, dasd_copy_pair_show,
+		   dasd_copy_pair_store);
+
+static ssize_t
+dasd_copy_role_show(struct device *dev,
+		    struct device_attribute *attr, char *buf)
+{
+	struct dasd_copy_relation *copy;
+	struct dasd_device *device;
+	int len, i;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+
+	if (!device->copy) {
+		len = sysfs_emit(buf, "none\n");
+		goto out;
+	}
+	copy = device->copy;
+	/* only the active device is primary */
+	if (copy->active->device == device) {
+		len = sysfs_emit(buf, "primary\n");
+		goto out;
+	}
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].device == device) {
+			len = sysfs_emit(buf, "secondary\n");
+			goto out;
+		}
+	}
+	/* not in the list, no COPY role */
+	len = sysfs_emit(buf, "none\n");
+out:
+	dasd_put_device(device);
+	return len;
+}
+static DEVICE_ATTR(copy_role, 0444, dasd_copy_role_show, NULL);
+
 #define DASD_DEFINE_ATTR(_name, _func)					\
 static ssize_t dasd_##_name##_show(struct device *dev,			\
 				   struct device_attribute *attr,	\
@@ -1739,6 +2289,8 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_hpf.attr,
 	&dev_attr_ese.attr,
 	&dev_attr_fc_security.attr,
+	&dev_attr_copy_pair.attr,
+	&dev_attr_copy_role.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 56ab74aa07f42..59b11950fb60c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2028,6 +2028,49 @@ static void dasd_eckd_kick_validate_server(struct dasd_device *device)
 		dasd_put_device(device);
 }
 
+/*
+ * return if the device is the copy relation primary if a copy relation is active
+ */
+static int dasd_device_is_primary(struct dasd_device *device)
+{
+	if (!device->copy)
+		return 1;
+
+	if (device->copy->active->device == device)
+		return 1;
+
+	return 0;
+}
+
+static int dasd_eckd_alloc_block(struct dasd_device *device)
+{
+	struct dasd_block *block;
+	struct dasd_uid temp_uid;
+
+	if (!dasd_device_is_primary(device))
+		return 0;
+
+	dasd_eckd_get_uid(device, &temp_uid);
+	if (temp_uid.type == UA_BASE_DEVICE) {
+		block = dasd_alloc_block();
+		if (IS_ERR(block)) {
+			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+					"could not allocate dasd block structure");
+			return PTR_ERR(block);
+		}
+		device->block = block;
+		block->base = device;
+	}
+	return 0;
+}
+
+static bool dasd_eckd_pprc_enabled(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private = device->private;
+
+	return private->rdc_data.facilities.PPRC_enabled;
+}
+
 /*
  * Check device characteristics.
  * If the device is accessible using ECKD discipline, the device is enabled.
@@ -2036,8 +2079,6 @@ static int
 dasd_eckd_check_characteristics(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	struct dasd_block *block;
-	struct dasd_uid temp_uid;
 	int rc, i;
 	int readonly;
 	unsigned long value;
@@ -2095,20 +2136,29 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 			device->default_expires = value;
 	}
 
-	dasd_eckd_get_uid(device, &temp_uid);
-	if (temp_uid.type == UA_BASE_DEVICE) {
-		block = dasd_alloc_block();
-		if (IS_ERR(block)) {
-			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
-					"could not allocate dasd "
-					"block structure");
-			rc = PTR_ERR(block);
-			goto out_err1;
-		}
-		device->block = block;
-		block->base = device;
+	/* Read Device Characteristics */
+	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
+					 &private->rdc_data, 64);
+	if (rc) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Read device characteristic failed, rc=%d", rc);
+		goto out_err1;
+	}
+
+	/* setup PPRC for device from devmap */
+	rc = dasd_devmap_set_device_copy_relation(device->cdev,
+						  dasd_eckd_pprc_enabled(device));
+	if (rc) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"copy relation setup failed, rc=%d", rc);
+		goto out_err1;
 	}
 
+	/* check if block device is needed and allocate in case */
+	rc = dasd_eckd_alloc_block(device);
+	if (rc)
+		goto out_err1;
+
 	/* register lcu with alias handling, enable PAV */
 	rc = dasd_alias_make_device_known_to_lcu(device);
 	if (rc)
@@ -2132,15 +2182,6 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	/* Read Extent Pool Information */
 	dasd_eckd_read_ext_pool_info(device);
 
-	/* Read Device Characteristics */
-	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
-					 &private->rdc_data, 64);
-	if (rc) {
-		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
-				"Read device characteristic failed, rc=%d", rc);
-		goto out_err3;
-	}
-
 	if ((device->features & DASD_FEATURE_USERAW) &&
 	    !(private->rdc_data.facilities.RT_in_LR)) {
 		dev_err(&device->cdev->dev, "The storage server does not "
@@ -6097,6 +6138,71 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 	return 0;
 }
 
+/*
+ * Perform Subsystem Function - Peer-to-Peer Remote Copy Extended Query
+ */
+static int dasd_eckd_query_pprc_status(struct dasd_device *device,
+				       struct dasd_pprc_data_sc4 *data)
+{
+	struct dasd_pprc_data_sc4 *pprc_data;
+	struct dasd_psf_prssd_data *prssdp;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
+				   sizeof(*prssdp) + sizeof(*pprc_data) + 1,
+				   device, NULL);
+	if (IS_ERR(cqr)) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate query PPRC status request");
+		return PTR_ERR(cqr);
+	}
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->retries = 256;
+	cqr->expires = 10 * HZ;
+
+	/* Prepare for Read Subsystem Data */
+	prssdp = (struct dasd_psf_prssd_data *)cqr->data;
+	memset(prssdp, 0, sizeof(struct dasd_psf_prssd_data));
+	prssdp->order = PSF_ORDER_PRSSD;
+	prssdp->suborder = PSF_SUBORDER_PPRCEQ;
+	prssdp->varies[0] = PPRCEQ_SCOPE_4;
+	pprc_data = (struct dasd_pprc_data_sc4 *)(prssdp + 1);
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->count = sizeof(struct dasd_psf_prssd_data);
+	ccw->flags |= CCW_FLAG_CC;
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t)prssdp;
+
+	/* Read Subsystem Data - query host access */
+	ccw++;
+	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
+	ccw->count = sizeof(*pprc_data);
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t)pprc_data;
+
+	cqr->buildclk = get_tod_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	rc = dasd_sleep_on_interruptible(cqr);
+	if (rc == 0) {
+		*data = *pprc_data;
+	} else {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"PPRC Extended Query failed with rc=%d\n",
+				rc);
+		rc = -EOPNOTSUPP;
+	}
+
+	dasd_sfree_request(cqr, cqr->memdev);
+	return rc;
+}
+
 /*
  * Perform Subsystem Function - CUIR response
  */
@@ -6715,6 +6821,8 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.ext_pool_exhaust = dasd_eckd_ext_pool_exhaust,
 	.ese_format = dasd_eckd_ese_format,
 	.ese_read = dasd_eckd_ese_read,
+	.pprc_status = dasd_eckd_query_pprc_status,
+	.pprc_enabled = dasd_eckd_pprc_enabled,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 65e4630ad2aea..4b869c2bd5195 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -66,9 +66,15 @@
  * Perform Subsystem Function / Sub-Orders
  */
 #define PSF_SUBORDER_QHA		 0x1C /* Query Host Access */
+#define PSF_SUBORDER_PPRCEQ		 0x50 /* PPRC Extended Query */
 #define PSF_SUBORDER_VSQ		 0x52 /* Volume Storage Query */
 #define PSF_SUBORDER_LCQ		 0x53 /* Logical Configuration Query */
 
+/*
+ * PPRC Extended Query Scopes
+ */
+#define PPRCEQ_SCOPE_4			 0x04 /* Scope 4 for PPRC Extended Query */
+
 /*
  * CUIR response condition codes
  */
@@ -261,7 +267,7 @@ struct dasd_eckd_characteristics {
 		unsigned char reserved3:8;
 		unsigned char defect_wr:1;
 		unsigned char XRC_supported:1;
-		unsigned char reserved4:1;
+		unsigned char PPRC_enabled:1;
 		unsigned char striping:1;
 		unsigned char reserved5:4;
 		unsigned char cfw:1;
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 5ae64af9ccea3..22338033e6bfb 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -387,6 +387,7 @@ void dasd_eer_write(struct dasd_device *device, struct dasd_ccw_req *cqr,
 		break;
 	case DASD_EER_NOPATH:
 	case DASD_EER_NOSPC:
+	case DASD_EER_AUTOQUIESCE:
 		dasd_eer_write_standard_trigger(device, NULL, id);
 		break;
 	case DASD_EER_STATECHANGE:
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index d94ae067f085e..744e14a81cc48 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -260,6 +260,55 @@ struct dasd_uid {
 	char vduit[33];
 };
 
+/*
+ * PPRC Status data
+ */
+struct dasd_pprc_header {
+	__u8 entries;		/* 0     Number of device entries */
+	__u8 unused;		/* 1     unused */
+	__u16 entry_length;	/* 2-3   Length of device entry */
+	__u32 unused2;		/* 4-7   unused */
+} __packed;
+
+struct dasd_pprc_dev_info {
+	__u8 state;		/* 0       Copy State */
+	__u8 flags;		/* 1       Flags */
+	__u8 reserved1[2];	/* 2-3     reserved */
+	__u8 prim_lss;		/* 4       Primary device LSS */
+	__u8 primary;		/* 5       Primary device address */
+	__u8 sec_lss;		/* 6       Secondary device LSS */
+	__u8 secondary;		/* 7       Secondary device address */
+	__u16 pprc_id;		/* 8-9     Peer-to-Peer Remote Copy ID */
+	__u8 reserved2[12];	/* 10-21   reserved */
+	__u16 prim_cu_ssid;	/* 22-23   Pimary Control Unit SSID */
+	__u8 reserved3[12];	/* 24-35   reserved */
+	__u16 sec_cu_ssid;	/* 36-37   Secondary Control Unit SSID */
+	__u8 reserved4[90];	/* 38-127  reserved */
+} __packed;
+
+struct dasd_pprc_data_sc4 {
+	struct dasd_pprc_header header;
+	struct dasd_pprc_dev_info dev_info[5];
+} __packed;
+
+#define DASD_BUS_ID_SIZE 20
+#define DASD_CP_ENTRIES 5
+
+struct dasd_copy_entry {
+	char busid[DASD_BUS_ID_SIZE];
+	struct dasd_device *device;
+	bool primary;
+	bool configured;
+};
+
+struct dasd_copy_relation {
+	struct dasd_copy_entry entry[DASD_CP_ENTRIES];
+	struct dasd_copy_entry *active;
+};
+
+int dasd_devmap_set_device_copy_relation(struct ccw_device *,
+					 bool pprc_enabled);
+
 /*
  * the struct dasd_discipline is
  * sth like a table of virtual functions, if you think of dasd_eckd
@@ -388,6 +437,8 @@ struct dasd_discipline {
 	struct dasd_ccw_req *(*ese_format)(struct dasd_device *,
 					   struct dasd_ccw_req *, struct irb *);
 	int (*ese_read)(struct dasd_ccw_req *, struct irb *);
+	int (*pprc_status)(struct dasd_device *, struct	dasd_pprc_data_sc4 *);
+	bool (*pprc_enabled)(struct dasd_device *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
@@ -408,6 +459,7 @@ extern struct dasd_discipline *dasd_diag_discipline_pointer;
 #define DASD_EER_STATECHANGE 3
 #define DASD_EER_PPRCSUSPEND 4
 #define DASD_EER_NOSPC	     5
+#define DASD_EER_AUTOQUIESCE 31
 
 /* DASD path handling */
 
@@ -584,6 +636,8 @@ struct dasd_device {
 	struct dasd_profile profile;
 	struct dasd_format_entry format_entry;
 	struct kset *paths_info;
+	struct dasd_copy_relation *copy;
+	unsigned long aq_mask;
 };
 
 struct dasd_block {
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
index 6846ca8f7313c..3438d0b8ba062 100644
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
index be8dfbe13e904..524e4e6979c9f 100644
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
index d5ac938970232..5b3ffefae476d 100644
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
@@ -1366,15 +1366,15 @@ csio_free_fcfinfo(struct kref *kref)
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
index e524e1fc53fa3..8325875bfc4ed 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7238,7 +7238,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }
diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 779c319a4b820..6cdd2c517ba68 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -485,7 +485,7 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 	struct qbman_eq_desc *ed;
 	int i, ret;
 
-	ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
+	ed = kcalloc(32, sizeof(struct qbman_eq_desc), GFP_KERNEL);
 	if (!ed)
 		return -ENOMEM;
 
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 49acba1dea1e7..30aac6f093b21 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -659,17 +659,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
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
index 87d36948c6106..c6bd86a5335ab 100644
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
index eb6da9b9d8ba8..c29a950639e46 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -803,6 +803,7 @@ static int ipu_csc_scaler_release(struct file *file)
 
 	dev_dbg(priv->dev, "Releasing instance %p\n", ctx);
 
+	v4l2_ctrl_handler_free(&ctx->ctrl_hdlr);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ada9666f59889..48769e059772a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -715,6 +715,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -729,10 +730,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
 		if (priv->line[i] >= 0)
 			serial8250_suspend_port(priv->line[i]);
 
-	/* Ensure that every init quirk is properly torn down */
-	if (priv->board->exit)
-		priv->board->exit(pcidev);
-
 	return 0;
 }
 
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c122e7e90fc89..714c23f9504fc 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1433,7 +1433,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 09b2b40b63c4d..7d3630ddebb39 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -991,11 +991,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
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
index b8f5bc19416d9..442579f087c7c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2515,7 +2515,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		}
 		return;
 	case EScsiignore:
-		if (c >= 20 && c <= 0x3f)
+		if (c >= 0x20 && c <= 0x3f)
 			return;
 		vc->vc_state = ESnormal;
 		return;
diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 7c38057dcb4ab..e5402e05e7393 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2650,7 +2650,7 @@ net2272_plat_probe(struct platform_device *pdev)
 		goto err_req;
 	}
 
-	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
+	ret = net2272_probe_fin(dev, irqflags);
 	if (ret)
 		goto err_io;
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 46c72e6d3a29b..d9e4a949129a0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -173,8 +173,6 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
 
-#define MLX5_CVQ_MAX_ENT 16
-
 #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
 	do {                                                                                       \
 		if (features & BIT_ULL(_feature))                                                  \
@@ -1685,9 +1683,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
 
-	if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
+	if (!is_index_valid(mvdev, idx))
 		return;
 
+        if (is_ctrl_vq_idx(mvdev, idx)) {
+                struct mlx5_control_vq *cvq = &mvdev->cvq;
+
+                cvq->vring.vring.num = num;
+                return;
+        }
+
 	mvq = &ndev->vqs[idx];
 	mvq->num_ent = num;
 }
@@ -2182,7 +2187,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 		u16 idx = cvq->vring.last_avail_idx;
 
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
-					MLX5_CVQ_MAX_ENT, false,
+					cvq->vring.vring.num, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
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
index e8b185bb6f5ee..a15102bf21365 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -231,7 +231,7 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -242,11 +242,8 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
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
@@ -306,7 +303,7 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -317,11 +314,8 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
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
@@ -339,6 +333,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
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
index a3436c296c97b..8a7b1279a3130 100644
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
@@ -251,6 +253,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->parent = dev;
 	wdd->info = &stm32_iwdg_info;
 	wdd->ops = &stm32_iwdg_ops;
+	wdd->timeout = DEFAULT_TIMEOUT;
 	wdd->min_timeout = DIV_ROUND_UP((RLR_MIN + 1) * PR_MIN, wdt->rate);
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
 				    1000) / wdt->rate;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c4e22e9f7a666..cec18f9f8bd7a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -492,16 +492,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
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
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d6ae6de35af20..7d3e7418d8fd5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -66,7 +66,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
-		.is_por = !is_meta,
+		.is_por = !is_meta ? 1 : 0,
 	};
 	int err;
 
@@ -229,8 +229,8 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.op = REQ_OP_READ,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.is_por = (type == META_POR),
+		.in_list = 0,
+		.is_por = (type == META_POR) ? 1 : 0,
 	};
 	struct blk_plug plug;
 	int err;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7b4479d5b5315..88799c6ebd7de 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1233,10 +1233,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.page = NULL,
 		.encrypted_page = NULL,
 		.compressed_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
-		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode),
+		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
+									1 : 0,
 	};
 	struct dnode_of_data dn;
 	struct node_info ni;
@@ -1444,12 +1445,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
-					int *submitted,
+					int *submitted_p,
 					struct writeback_control *wbc,
 					enum iostat_type io_type)
 {
 	struct address_space *mapping = cc->inode->i_mapping;
-	int _submitted, compr_blocks, ret, i;
+	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	int submitted, compr_blocks, i;
+	int ret = 0;
 
 	compr_blocks = f2fs_compressed_blocks(cc);
 
@@ -1464,6 +1467,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks < 0)
 		return compr_blocks;
 
+	/* overwrite compressed cluster w/ normal cluster */
+	if (compr_blocks > 0)
+		f2fs_lock_op(sbi);
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1488,7 +1495,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
+		ret = f2fs_write_single_data_page(cc->rpages[i], &submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
@@ -1496,28 +1503,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				unlock_page(cc->rpages[i]);
 				ret = 0;
 			} else if (ret == -EAGAIN) {
+				ret = 0;
 				/*
 				 * for quota file, just redirty left pages to
 				 * avoid deadlock caused by cluster update race
 				 * from foreground operation.
 				 */
 				if (IS_NOQUOTA(cc->inode))
-					return 0;
-				ret = 0;
-				cond_resched();
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+					goto out;
+				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 				goto retry_write;
 			}
-			return ret;
+			goto out;
 		}
 
-		*submitted += _submitted;
+		*submitted_p += submitted;
 	}
 
-	f2fs_balance_fs(F2FS_M_SB(mapping), true);
+out:
+	if (compr_blocks > 0)
+		f2fs_unlock_op(sbi);
 
-	return 0;
+	f2fs_balance_fs(sbi, true);
+	return ret;
 }
 
 int f2fs_write_multi_pages(struct compress_ctx *cc,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 73a7906a49b1e..a8e99da8edc1f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -932,7 +932,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		bio_page = fio->page;
 
 	/* set submitted = true as a return value */
-	fio->submitted = true;
+	fio->submitted = 1;
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
@@ -948,7 +948,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 				(fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
-			fio->retry = true;
+			fio->retry = 1;
 			goto skip;
 		}
 		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
@@ -1467,10 +1467,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	struct extent_info ei = {0, };
 	block_t blkaddr;
 	unsigned int start_pgofs;
+	int bidx = 0;
 
 	if (!maxblocks)
 		return 0;
 
+	map->m_bdev = inode->i_sb->s_bdev;
+	map->m_multidev_dio =
+		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
+
 	map->m_len = 0;
 	map->m_flags = 0;
 
@@ -1493,6 +1498,21 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		if (flag == F2FS_GET_BLOCK_DIO)
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+
+		if (map->m_multidev_dio) {
+			block_t blk_addr = map->m_pblk;
+
+			bidx = f2fs_target_device_index(sbi, map->m_pblk);
+
+			map->m_bdev = FDEV(bidx).bdev;
+			map->m_pblk -= FDEV(bidx).start_blk;
+			map->m_len = min(map->m_len,
+				FDEV(bidx).end_blk + 1 - map->m_pblk);
+
+			if (map->m_may_create)
+				f2fs_update_device_state(sbi, inode->i_ino,
+							blk_addr, map->m_len);
+		}
 		goto out;
 	}
 
@@ -1611,6 +1631,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	if (flag == F2FS_GET_BLOCK_PRE_AIO)
 		goto skip;
 
+	if (map->m_multidev_dio)
+		bidx = f2fs_target_device_index(sbi, blkaddr);
+
 	if (map->m_len == 0) {
 		/* preallocated unwritten block should be mapped for fiemap. */
 		if (blkaddr == NEW_ADDR)
@@ -1619,10 +1642,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
+
+		if (map->m_multidev_dio)
+			map->m_bdev = FDEV(bidx).bdev;
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
 			flag == F2FS_GET_BLOCK_PRE_DIO) {
+		if (map->m_multidev_dio && map->m_bdev != FDEV(bidx).bdev)
+			goto sync_out;
 		ofs++;
 		map->m_len++;
 	} else {
@@ -1675,11 +1703,31 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 sync_out:
 
-	/* for hardware encryption, but to avoid potential issue in future */
-	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED)
+	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED) {
+		/*
+		 * for hardware encryption, but to avoid potential issue
+		 * in future
+		 */
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
 
+		if (map->m_multidev_dio) {
+			block_t blk_addr = map->m_pblk;
+
+			bidx = f2fs_target_device_index(sbi, map->m_pblk);
+
+			map->m_bdev = FDEV(bidx).bdev;
+			map->m_pblk -= FDEV(bidx).start_blk;
+
+			if (map->m_may_create)
+				f2fs_update_device_state(sbi, inode->i_ino,
+							blk_addr, map->m_len);
+
+			f2fs_bug_on(sbi, blk_addr + map->m_len >
+						FDEV(bidx).end_blk + 1);
+		}
+	}
+
 	if (flag == F2FS_GET_BLOCK_PRECACHE) {
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
@@ -1698,7 +1746,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
-	trace_f2fs_map_blocks(inode, map, err);
+	trace_f2fs_map_blocks(inode, map, create, flag, err);
 	return err;
 }
 
@@ -1757,6 +1805,9 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
 		bh->b_size = blks_to_bytes(inode, map.m_len);
+
+		if (map.m_multidev_dio)
+			bh->b_bdev = map.m_bdev;
 	}
 	return err;
 }
@@ -2748,9 +2799,10 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.old_blkaddr = NULL_ADDR,
 		.page = page,
 		.encrypted_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.compr_blocks = compr_blocks,
-		.need_lock = LOCK_RETRY,
+		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
+		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.bio = bio,
@@ -2834,6 +2886,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (err == -EAGAIN) {
 		err = f2fs_do_write_data_page(&fio);
 		if (err == -EAGAIN) {
+			f2fs_bug_on(sbi, compr_blocks);
 			fio.need_lock = LOCK_REQ;
 			err = f2fs_do_write_data_page(&fio);
 		}
@@ -2878,7 +2931,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	}
 
 	if (submitted)
-		*submitted = fio.submitted ? 1 : 0;
+		*submitted = fio.submitted;
 
 	return 0;
 
@@ -3104,8 +3157,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret == -EAGAIN) {
 					ret = 0;
 					if (wbc->sync_mode == WB_SYNC_ALL) {
-						cond_resched();
-						congestion_wait(BLK_RW_ASYNC,
+						f2fs_io_schedule_timeout(
 							DEFAULT_IO_TIMEOUT);
 						goto retry_write;
 					}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 835ef98643bd4..647d53df6a3de 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -622,6 +622,7 @@ struct extent_tree {
 				F2FS_MAP_UNWRITTEN)
 
 struct f2fs_map_blocks {
+	struct block_device *m_bdev;	/* for multi-device dio */
 	block_t m_pblk;
 	block_t m_lblk;
 	unsigned int m_len;
@@ -630,6 +631,7 @@ struct f2fs_map_blocks {
 	pgoff_t *m_next_extent;		/* point to next possible extent */
 	int m_seg_type;
 	bool m_may_create;		/* indicate it is from write path */
+	bool m_multidev_dio;		/* indicate it allows multi-device dio */
 };
 
 /* for flag in get_data_block */
@@ -1168,18 +1170,19 @@ struct f2fs_io_info {
 	struct page *encrypted_page;	/* encrypted page */
 	struct page *compressed_page;	/* compressed page */
 	struct list_head list;		/* serialize IOs */
-	bool submitted;		/* indicate IO submission */
-	int need_lock;		/* indicate we need to lock cp_rwsem */
-	bool in_list;		/* indicate fio is in io_list */
-	bool is_por;		/* indicate IO is from recovery or not */
-	bool retry;		/* need to reallocate block address */
-	int compr_blocks;	/* # of compressed block addresses */
-	bool encrypted;		/* indicate file is encrypted */
+	unsigned int compr_blocks;	/* # of compressed block addresses */
+	unsigned int need_lock:8;	/* indicate we need to lock cp_rwsem */
+	unsigned int version:8;		/* version of the node */
+	unsigned int submitted:1;	/* indicate IO submission */
+	unsigned int in_list:1;		/* indicate fio is in io_list */
+	unsigned int is_por:1;		/* indicate IO is from recovery or not */
+	unsigned int retry:1;		/* need to reallocate block address */
+	unsigned int encrypted:1;	/* indicate file is encrypted */
+	unsigned int post_read:1;	/* require post read */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
 	sector_t *last_block;		/* last block number in bio */
-	unsigned char version;		/* version of the node */
 };
 
 struct bio_entry {
@@ -1736,12 +1739,15 @@ struct f2fs_sb_info {
 
 	/* For shrinker support */
 	struct list_head s_list;
+	struct mutex umount_mutex;
+	unsigned int shrinker_run_no;
+
+	/* For multi devices */
 	int s_ndevs;				/* number of devices */
 	struct f2fs_dev_info *devs;		/* for device list */
 	unsigned int dirty_device;		/* for checkpoint data flush */
 	spinlock_t dev_lock;			/* protect dirty_device */
-	struct mutex umount_mutex;
-	unsigned int shrinker_run_no;
+	bool aligned_blksize;			/* all devices has the same logical blksize */
 
 	/* For write statistics */
 	u64 sectors_written_start;
@@ -3517,6 +3523,8 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
 			struct f2fs_io_info *fio);
+void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
+					block_t blkaddr, unsigned int blkcnt);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered, bool locked);
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
@@ -4334,6 +4342,16 @@ static inline int block_unaligned_IO(struct inode *inode,
 	return align & blocksize_mask;
 }
 
+static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
+								int flag)
+{
+	if (!f2fs_is_multi_device(sbi))
+		return false;
+	if (flag != F2FS_GET_BLOCK_DIO)
+		return false;
+	return sbi->aligned_blksize;
+}
+
 static inline bool f2fs_force_buffered_io(struct inode *inode,
 				struct kiocb *iocb, struct iov_iter *iter)
 {
@@ -4342,7 +4360,9 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 
 	if (f2fs_post_read_required(inode))
 		return true;
-	if (f2fs_is_multi_device(sbi))
+
+	/* disallow direct IO if any of devices has unaligned blksize */
+	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
 		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
@@ -4393,6 +4413,12 @@ static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
 }
 
+static inline void f2fs_io_schedule_timeout(long timeout)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	io_schedule_timeout(timeout);
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 489854d841e75..378ab6bd1b8d8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3532,10 +3532,10 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
+		unsigned int *reserved_blocks)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	unsigned int reserved_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	block_t blkaddr;
 	int i;
@@ -3566,7 +3566,13 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				goto next;
 			}
 
-			if (__is_valid_data_blkaddr(blkaddr)) {
+			/*
+			 * compressed cluster was not released due to it
+			 * fails in release_compress_blocks(), so NEW_ADDR
+			 * is a possible case.
+			 */
+			if (blkaddr == NEW_ADDR ||
+				__is_valid_data_blkaddr(blkaddr)) {
 				compr_blocks++;
 				continue;
 			}
@@ -3576,6 +3582,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		}
 
 		reserved = cluster_size - compr_blocks;
+
+		/* for the case all blocks in cluster were reserved */
+		if (reserved == 1)
+			goto next;
+
 		ret = inc_valid_block_count(sbi, dn->inode, &reserved);
 		if (ret)
 			return ret;
@@ -3585,12 +3596,12 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
 
-		reserved_blocks += reserved;
+		*reserved_blocks += reserved;
 next:
 		count -= cluster_size;
 	}
 
-	return reserved_blocks;
+	return 0;
 }
 
 static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
@@ -3651,7 +3662,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
 		count = round_up(count, F2FS_I(inode)->i_cluster_size);
 
-		ret = reserve_compress_blocks(&dn, count);
+		ret = reserve_compress_blocks(&dn, count, &reserved_blocks);
 
 		f2fs_put_dnode(&dn);
 
@@ -3659,13 +3670,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 			break;
 
 		page_idx += count;
-		reserved_blocks += ret;
 	}
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
-	if (ret >= 0) {
+	if (!ret) {
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
 		inode->i_ctime = current_time(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
@@ -3675,7 +3685,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 out:
 	mnt_drop_write_file(filp);
 
-	if (ret >= 0) {
+	if (!ret) {
 		ret = put_user(reserved_blocks, (u64 __user *)arg);
 	} else if (reserved_blocks &&
 			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2c13f308c74e3..9a57754e6e0c1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1080,8 +1080,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.retry = false,
+		.in_list = 0,
+		.retry = 0,
 	};
 	int err;
 
@@ -1167,8 +1167,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.retry = false,
+		.in_list = 0,
+		.retry = 0,
 	};
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 195658263f0a4..dc85dd55314cc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1583,7 +1583,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		.op_flags = wbc_to_write_flags(wbc),
 		.page = page,
 		.encrypted_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 	};
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 79ad696cddec0..b454496ca67a1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -313,8 +313,7 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 skip:
 		iput(inode);
 	}
-	congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
-	cond_resched();
+	f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	if (gc_failure) {
 		if (++looped >= count)
 			return;
@@ -789,8 +788,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 		do {
 			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
 			if (ret)
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 		} while (ret && --count);
 
 		if (ret) {
@@ -3106,7 +3104,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
-			congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 			goto next;
 		}
 skip:
@@ -3475,10 +3473,10 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		struct f2fs_bio_info *io;
 
 		if (F2FS_IO_ALIGNED(sbi))
-			fio->retry = false;
+			fio->retry = 0;
 
 		INIT_LIST_HEAD(&fio->list);
-		fio->in_list = true;
+		fio->in_list = 1;
 		io = sbi->write_io[fio->type] + fio->temp;
 		spin_lock(&io->io_lock);
 		list_add_tail(&fio->list, &io->io_list);
@@ -3490,24 +3488,30 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	up_read(&SM_I(sbi)->curseg_lock);
 }
 
-static void update_device_state(struct f2fs_io_info *fio)
+void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
+					block_t blkaddr, unsigned int blkcnt)
 {
-	struct f2fs_sb_info *sbi = fio->sbi;
-	unsigned int devidx;
-
 	if (!f2fs_is_multi_device(sbi))
 		return;
 
-	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
+	while (1) {
+		unsigned int devidx = f2fs_target_device_index(sbi, blkaddr);
+		unsigned int blks = FDEV(devidx).end_blk - blkaddr + 1;
 
-	/* update device state for fsync */
-	f2fs_set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
+		/* update device state for fsync */
+		f2fs_set_dirty_device(sbi, ino, devidx, FLUSH_INO);
 
-	/* update device state for checkpoint */
-	if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
-		spin_lock(&sbi->dev_lock);
-		f2fs_set_bit(devidx, (char *)&sbi->dirty_device);
-		spin_unlock(&sbi->dev_lock);
+		/* update device state for checkpoint */
+		if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
+			spin_lock(&sbi->dev_lock);
+			f2fs_set_bit(devidx, (char *)&sbi->dirty_device);
+			spin_unlock(&sbi->dev_lock);
+		}
+
+		if (blkcnt <= blks)
+			break;
+		blkcnt -= blks;
+		blkaddr += blks;
 	}
 }
 
@@ -3534,7 +3538,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		goto reallocate;
 	}
 
-	update_device_state(fio);
+	f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
 
 	if (keep_order)
 		up_read(&fio->sbi->io_order_lock);
@@ -3553,7 +3557,7 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 		.new_blkaddr = page->index,
 		.page = page,
 		.encrypted_page = NULL,
-		.in_list = false,
+		.in_list = 0,
 	};
 
 	if (unlikely(page->index >= MAIN_BLKADDR(sbi)))
@@ -3616,6 +3620,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
+	if (fio->post_read)
+		invalidate_mapping_pages(META_MAPPING(sbi),
+				fio->new_blkaddr, fio->new_blkaddr);
+
 	stat_inc_inplace_blocks(fio->sbi);
 
 	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
@@ -3623,7 +3631,8 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	else
 		err = f2fs_submit_page_bio(fio);
 	if (!err) {
-		update_device_state(fio);
+		f2fs_update_device_state(fio->sbi, fio->ino,
+						fio->new_blkaddr, 1);
 		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 	}
 
@@ -3795,10 +3804,16 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
+	if (!f2fs_post_read_required(inode))
+		return;
+
 	for (i = 0; i < len; i++)
 		f2fs_wait_on_block_writeback(inode, blkaddr + i);
+
+	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr + len - 1);
 }
 
 static int read_compacted_summaries(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d4a76c2deb806..df1e5496352c2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2168,8 +2168,7 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	/* we should flush all the data to keep data consistency */
 	do {
 		sync_inodes_sb(sbi->sb);
-		cond_resched();
-		congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+		f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
 
 	if (unlikely(retry < 0))
@@ -2540,8 +2539,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 							&page, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 				goto retry;
 			}
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
@@ -3831,6 +3829,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	unsigned int max_devices = MAX_DEVICES;
+	unsigned int logical_blksize;
 	int i;
 
 	/* Initialize single device information */
@@ -3851,6 +3850,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	if (!sbi->devs)
 		return -ENOMEM;
 
+	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
+	sbi->aligned_blksize = true;
+
 	for (i = 0; i < max_devices; i++) {
 
 		if (i > 0 && !RDEV(i).path[0])
@@ -3887,6 +3889,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 		/* to release errored devices */
 		sbi->s_ndevs = i + 1;
 
+		if (logical_blksize != bdev_logical_block_size(FDEV(i).bdev))
+			sbi->aligned_blksize = false;
+
 #ifdef CONFIG_BLK_DEV_ZONED
 		if (bdev_zoned_model(FDEV(i).bdev) == BLK_ZONED_HM &&
 				!f2fs_sb_has_blkzoned(sbi)) {
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6630c69c23a2a..55e5ffacc0e40 100644
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
diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0fe5aacbcfdf1..e7192d0eea3de 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -54,11 +54,14 @@ int nfs42_proc_removexattr(struct inode *inode, const char *name);
  * They would be 7 bytes long in the eventual buffer ("user.x\0"), and
  * 8 bytes long XDR-encoded.
  *
- * Include the trailing eof word as well.
+ * Include the trailing eof word as well and make the result a multiple
+ * of 4 bytes.
  */
 static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
 {
-	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
+	u32 size = 8 * buflen / (XATTR_USER_PREFIX_LEN + 2) + 4;
+
+	return (size + 3) & ~3;
 }
 #endif /* CONFIG_NFS_V4_2 */
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a865b384f0fc0..925ad7dbe6a0d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10517,29 +10517,33 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	ssize_t error, error2, error3;
+	size_t left = size;
 
-	error = generic_listxattr(dentry, list, size);
+	error = generic_listxattr(dentry, list, left);
 	if (error < 0)
 		return error;
 	if (list) {
 		list += error;
-		size -= error;
+		left -= error;
 	}
 
-	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, size);
+	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, left);
 	if (error2 < 0)
 		return error2;
 
 	if (list) {
 		list += error2;
-		size -= error2;
+		left -= error2;
 	}
 
-	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, size);
+	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
 		return error3;
 
-	return error + error2 + error3;
+	error += error2 + error3;
+	if (size && error > size)
+		return -ERANGE;
+	return error;
 }
 
 static void nfs4_enable_swap(struct inode *inode)
diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index fa148308822cc..c2cf4ff628811 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -175,10 +175,10 @@ static int __init root_nfs_cat(char *dest, const char *src,
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
index 75e593b1c03e8..edb414d3fd164 100644
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
@@ -1004,14 +1006,15 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
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
@@ -1084,59 +1087,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
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
@@ -1153,11 +1104,18 @@ static void remove_dquot_ref(struct super_block *sb, int type,
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
@@ -1174,13 +1132,8 @@ static void remove_dquot_ref(struct super_block *sb, int type,
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
@@ -1513,7 +1466,8 @@ static int inode_quota_active(const struct inode *inode)
 static int __dquot_initialize(struct inode *inode, int type)
 {
 	int cnt, init_needed = 0;
-	struct dquot **dquots, *got[MAXQUOTAS] = {};
+	struct dquot __rcu **dquots;
+	struct dquot *got[MAXQUOTAS] = {};
 	struct super_block *sb = inode->i_sb;
 	qsize_t rsv;
 	int ret = 0;
@@ -1588,7 +1542,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 		if (!got[cnt])
 			continue;
 		if (!dquots[cnt]) {
-			dquots[cnt] = got[cnt];
+			rcu_assign_pointer(dquots[cnt], got[cnt]);
 			got[cnt] = NULL;
 			/*
 			 * Make quota reservation system happy if someone
@@ -1596,12 +1550,16 @@ static int __dquot_initialize(struct inode *inode, int type)
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
@@ -1623,7 +1581,7 @@ EXPORT_SYMBOL(dquot_initialize);
 
 bool dquot_initialize_needed(struct inode *inode)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	int i;
 
 	if (!inode_quota_active(inode))
@@ -1648,13 +1606,14 @@ EXPORT_SYMBOL(dquot_initialize_needed);
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
@@ -1662,7 +1621,7 @@ static void __dquot_drop(struct inode *inode)
 
 void dquot_drop(struct inode *inode)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1735,7 +1694,8 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
 		if (reserve) {
@@ -1755,27 +1715,26 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
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
@@ -1805,7 +1764,8 @@ int dquot_alloc_inode(struct inode *inode)
 {
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
 		return 0;
@@ -1816,17 +1776,19 @@ int dquot_alloc_inode(struct inode *inode)
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
@@ -1847,7 +1809,8 @@ EXPORT_SYMBOL(dquot_alloc_inode);
  */
 int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1863,9 +1826,8 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
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
@@ -1889,7 +1851,8 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
  */
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1905,9 +1868,8 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
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
@@ -1933,7 +1895,8 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
+	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1954,17 +1917,18 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
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
@@ -1988,7 +1952,8 @@ void dquot_free_inode(struct inode *inode)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
+	struct dquot *dquot;
 	int index;
 
 	if (!inode_quota_active(inode))
@@ -1999,16 +1964,16 @@ void dquot_free_inode(struct inode *inode)
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
@@ -2034,8 +1999,9 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
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
@@ -2066,6 +2032,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	}
 	cur_space = __inode_get_bytes(inode);
 	rsv_space = __inode_get_rsv_space(inode);
+	dquots = i_dquot(inode);
 	/*
 	 * Build the transfer_from list, check limits, and update usage in
 	 * the target structures.
@@ -2080,7 +2047,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 		if (!sb_has_quota_active(inode->i_sb, cnt))
 			continue;
 		is_valid[cnt] = 1;
-		transfer_from[cnt] = i_dquot(inode)[cnt];
+		transfer_from[cnt] = srcu_dereference_check(dquots[cnt],
+				&dquot_srcu, lockdep_is_held(&dq_data_lock));
 		ret = dquot_add_inodes(transfer_to[cnt], inode_usage,
 				       &warn_to[cnt]);
 		if (ret)
@@ -2119,13 +2087,21 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
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
index 5edffee1162c2..668a5200503ae 100644
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
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 140b6b9a8bbe6..dd6929f0c4f6d 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -262,6 +262,9 @@ ttm_resource_manager_cleanup(struct ttm_resource_manager *man)
 void ttm_resource_init(struct ttm_buffer_object *bo,
                        const struct ttm_place *place,
                        struct ttm_resource *res);
+void ttm_resource_fini(struct ttm_resource_manager *man,
+		       struct ttm_resource *res);
+
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 97d94bcba1314..df15d4d445ddc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -192,9 +192,14 @@ struct bpf_map {
 	 */
 	atomic64_t refcnt ____cacheline_aligned;
 	atomic64_t usercnt;
-	struct work_struct work;
+	/* rcu is used before freeing and work is only used during freeing */
+	union {
+		struct work_struct work;
+		struct rcu_head rcu;
+	};
 	struct mutex freeze_mutex;
 	atomic64_t writecnt;
+	bool free_after_mult_rcu_gp;
 };
 
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a9956b681f090..ddaeb2afc022f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -496,24 +496,27 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 	__BPF_MAP(n, __BPF_DECL_ARGS, __BPF_N, u64, __ur_1, u64, __ur_2,       \
 		  u64, __ur_3, u64, __ur_4, u64, __ur_5)
 
-#define BPF_CALL_x(x, name, ...)					       \
+#define BPF_CALL_x(x, attr, name, ...)					       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
 	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));    \
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))     \
 	{								       \
 		return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
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
@@ -940,8 +943,7 @@ int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
 void sk_reuseport_prog_free(struct bpf_prog *prog);
 int sk_detach_filter(struct sock *sk);
-int sk_get_filter(struct sock *sk, struct sock_filter __user *filter,
-		  unsigned int len);
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
 
 bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 93c262ecbdc92..78890143f0790 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -118,9 +118,9 @@ extern int ip_mc_source(int add, int omode, struct sock *sk,
 		struct ip_mreq_source *mreqs, int ifindex);
 extern int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf,int ifindex);
 extern int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-		struct ip_msfilter __user *optval, int __user *optlen);
+			sockptr_t optval, sockptr_t optlen);
 extern int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-			struct sockaddr_storage __user *p);
+			sockptr_t optval, size_t offset);
 extern int ip_mc_sf_allow(struct sock *sk, __be32 local, __be32 rmt,
 			  int dif, int sdif);
 extern void ip_mc_init_dev(struct in_device *);
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 649a4d7c241bc..55d09f594cd14 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -6,9 +6,9 @@
 #include <linux/xarray.h>
 
 #if defined(CONFIG_IO_URING)
-struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
+bool io_is_uring_fops(struct file *file);
 
 static inline void io_uring_files_cancel(void)
 {
@@ -26,10 +26,6 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 #else
-static inline struct sock *io_uring_get_socket(struct file *file)
-{
-	return NULL;
-}
 static inline void io_uring_task_cancel(void)
 {
 }
@@ -39,6 +35,10 @@ static inline void io_uring_files_cancel(void)
 static inline void io_uring_free(struct task_struct *tsk)
 {
 }
+static inline bool io_is_uring_fops(struct file *file)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index 61e48d459b23c..693d758f2f1c9 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -261,7 +261,10 @@ struct mlx5_wqe_eth_seg {
 	union {
 		struct {
 			__be16 sz;
-			u8     start[2];
+			union {
+				u8     start[2];
+				DECLARE_FLEX_ARRAY(u8, data);
+			};
 		} inline_hdr;
 		struct {
 			__be16 type;
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 1322652a9d0d9..7dc186ec52a29 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -95,6 +95,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
+#ifdef CONFIG_MODULES
+void flush_module_init_free_work(void);
+#else
+static inline void flush_module_init_free_work(void)
+{
+}
+#endif
+
 /* Any cleanup needed when module leaves. */
 void module_arch_cleanup(struct module *mod);
 
diff --git a/include/linux/mroute.h b/include/linux/mroute.h
index 6cbbfe94348ce..80b8400ab8b24 100644
--- a/include/linux/mroute.h
+++ b/include/linux/mroute.h
@@ -17,7 +17,7 @@ static inline int ip_mroute_opt(int opt)
 }
 
 int ip_mroute_setsockopt(struct sock *, int, sockptr_t, unsigned int);
-int ip_mroute_getsockopt(struct sock *, int, char __user *, int __user *);
+int ip_mroute_getsockopt(struct sock *, int, sockptr_t, sockptr_t);
 int ipmr_ioctl(struct sock *sk, int cmd, void __user *arg);
 int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 int ip_mr_init(void);
@@ -29,8 +29,8 @@ static inline int ip_mroute_setsockopt(struct sock *sock, int optname,
 	return -ENOPROTOOPT;
 }
 
-static inline int ip_mroute_getsockopt(struct sock *sock, int optname,
-				       char __user *optval, int __user *optlen)
+static inline int ip_mroute_getsockopt(struct sock *sk, int optname,
+				       sockptr_t optval, sockptr_t optlen)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 99dfb8c1993a6..08d26b58f95ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2284,6 +2284,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
+static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
+{
+	return dev->error_state == pci_channel_io_perm_failure;
+}
+
 void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
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
index 13bddb841ceb1..d908af5917339 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,6 +205,18 @@ static inline void exit_tasks_rcu_stop(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
+/**
+ * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
+ *
+ * As an accident of implementation, an RCU Tasks Trace grace period also
+ * acts as an RCU grace period.  However, this could change at any time.
+ * Code relying on this accident must call this function to verify that
+ * this accident is still happening.
+ *
+ * You have been warned!
+ */
+static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
+
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
@@ -218,6 +230,37 @@ do { \
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
diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index ea193414298b7..38862819e77a1 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -64,6 +64,11 @@ static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
 	return 0;
 }
 
+static inline int copy_to_sockptr(sockptr_t dst, const void *src, size_t size)
+{
+	return copy_to_sockptr_offset(dst, 0, src, size);
+}
+
 static inline void *memdup_sockptr(sockptr_t src, size_t len)
 {
 	void *p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 6033eaddcb749..8670adaa23f91 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -570,9 +570,10 @@ TRACE_EVENT(f2fs_file_write_iter,
 );
 
 TRACE_EVENT(f2fs_map_blocks,
-	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int ret),
+	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map,
+				int create, int flag, int ret),
 
-	TP_ARGS(inode, map, ret),
+	TP_ARGS(inode, map, create, flag, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -583,11 +584,14 @@ TRACE_EVENT(f2fs_map_blocks,
 		__field(unsigned int,	m_flags)
 		__field(int,	m_seg_type)
 		__field(bool,	m_may_create)
+		__field(bool,	m_multidev_dio)
+		__field(int,	create)
+		__field(int,	flag)
 		__field(int,	ret)
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= map->m_bdev->bd_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_pblk		= map->m_pblk;
@@ -595,12 +599,16 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_flags	= map->m_flags;
 		__entry->m_seg_type	= map->m_seg_type;
 		__entry->m_may_create	= map->m_may_create;
+		__entry->m_multidev_dio	= map->m_multidev_dio;
+		__entry->create		= create;
+		__entry->flag		= flag;
 		__entry->ret		= ret;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
-		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u,"
-		"seg_type = %d, may_create = %d, err = %d",
+		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u, "
+		"seg_type = %d, may_create = %d, multidevice = %d, "
+		"create = %d, flag = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->m_lblk,
 		(unsigned long long)__entry->m_pblk,
@@ -608,6 +616,9 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_flags,
 		__entry->m_seg_type,
 		__entry->m_may_create,
+		__entry->m_multidev_dio,
+		__entry->create,
+		__entry->flag,
 		__entry->ret)
 );
 
diff --git a/init/main.c b/init/main.c
index 5c81d7fb2fe9c..f27e8510b1554 100644
--- a/init/main.c
+++ b/init/main.c
@@ -89,6 +89,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/context_tracking.h>
 #include <linux/random.h>
+#include <linux/moduleloader.h>
 #include <linux/list.h>
 #include <linux/integrity.h>
 #include <linux/proc_ns.h>
@@ -1464,11 +1465,11 @@ static void mark_readonly(void)
 	if (rodata_enabled) {
 		/*
 		 * load_module() results in W+X mappings, which are cleaned
-		 * up with call_rcu().  Let's make sure that queued work is
+		 * up with init_free_wq. Let's make sure that queued work is
 		 * flushed so that we don't hit false positives looking for
 		 * insecure pages which are W+X.
 		 */
-		rcu_barrier();
+		flush_module_init_free_work();
 		mark_rodata_ro();
 		rodata_test();
 	} else
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 55fd6d98fe121..a51429c0342e0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -62,7 +62,6 @@
 #include <linux/net.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
-#include <net/scm.h>
 #include <linux/anon_inodes.h>
 #include <linux/sched/mm.h>
 #include <linux/uaccess.h>
@@ -440,9 +439,6 @@ struct io_ring_ctx {
 
 	/* Keep this last, we don't need it for the fast path */
 	struct {
-		#if defined(CONFIG_UNIX)
-			struct socket		*ring_sock;
-		#endif
 		/* hashed buffered write serialization */
 		struct io_wq_hash		*hash_map;
 
@@ -1116,19 +1112,6 @@ static struct kmem_cache *req_cachep;
 
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
 static inline void io_tw_lock(struct io_ring_ctx *ctx, bool *locked)
 {
 	if (!*locked) {
@@ -7832,7 +7815,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
 					  ktime_t *timeout)
 {
-	int io_wait, ret;
+	int ret;
 
 	/* make sure we run task_work before checking for signals */
 	ret = io_run_task_work_sig();
@@ -7847,13 +7830,12 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 	 * can take into account that the task is waiting for IO - turns out
 	 * to be important for low QD IO.
 	 */
-	io_wait = current->in_iowait;
 	if (current_pending_io())
 		current->in_iowait = 1;
 	ret = 1;
 	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	current->in_iowait = io_wait;
+	current->in_iowait = 0;
 	return ret;
 }
 
@@ -8164,15 +8146,6 @@ static void io_free_file_tables(struct io_file_table *table)
 
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
 
 	for (i = 0; i < ctx->nr_user_files; i++) {
@@ -8182,7 +8155,6 @@ static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 		if (file)
 			fput(file);
 	}
-#endif
 	io_free_file_tables(&ctx->file_table);
 	io_rsrc_data_free(ctx->file_data);
 	ctx->file_data = NULL;
@@ -8334,170 +8306,11 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p,
 	return sqd;
 }
 
-#if defined(CONFIG_UNIX)
-/*
- * Ensure the UNIX gc is aware of our file set, so we are certain that
- * the io_uring can be safely unregistered on process exit, even if we have
- * loops in the file referencing.
- */
-static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
-{
-	struct sock *sk = ctx->ring_sock->sk;
-	struct scm_fp_list *fpl;
-	struct sk_buff *skb;
-	int i, nr_files;
-
-	fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
-	if (!fpl)
-		return -ENOMEM;
-
-	skb = alloc_skb(0, GFP_KERNEL);
-	if (!skb) {
-		kfree(fpl);
-		return -ENOMEM;
-	}
-
-	skb->sk = sk;
-	skb->scm_io_uring = 1;
-
-	nr_files = 0;
-	fpl->user = get_uid(current_user());
-	for (i = 0; i < nr; i++) {
-		struct file *file = io_file_from_index(ctx, i + offset);
-
-		if (!file)
-			continue;
-		fpl->fp[nr_files] = get_file(file);
-		unix_inflight(fpl->user, fpl->fp[nr_files]);
-		nr_files++;
-	}
-
-	if (nr_files) {
-		fpl->max = SCM_MAX_FD;
-		fpl->count = nr_files;
-		UNIXCB(skb).fp = fpl;
-		skb->destructor = unix_destruct_scm;
-		refcount_add(skb->truesize, &sk->sk_wmem_alloc);
-		skb_queue_head(&sk->sk_receive_queue, skb);
-
-		for (i = 0; i < nr; i++) {
-			struct file *file = io_file_from_index(ctx, i + offset);
-
-			if (file)
-				fput(file);
-		}
-	} else {
-		kfree_skb(skb);
-		free_uid(fpl->user);
-		kfree(fpl);
-	}
-
-	return 0;
-}
-
-/*
- * If UNIX sockets are enabled, fd passing can cause a reference cycle which
- * causes regular reference counting to break down. We rely on the UNIX
- * garbage collection to take care of this problem for us.
- */
-static int io_sqe_files_scm(struct io_ring_ctx *ctx)
-{
-	unsigned left, total;
-	int ret = 0;
-
-	total = 0;
-	left = ctx->nr_user_files;
-	while (left) {
-		unsigned this_files = min_t(unsigned, left, SCM_MAX_FD);
-
-		ret = __io_sqe_files_scm(ctx, this_files, total);
-		if (ret)
-			break;
-		left -= this_files;
-		total += this_files;
-	}
-
-	if (!ret)
-		return 0;
-
-	while (total < ctx->nr_user_files) {
-		struct file *file = io_file_from_index(ctx, total);
-
-		if (file)
-			fput(file);
-		total++;
-	}
-
-	return ret;
-}
-#else
-static int io_sqe_files_scm(struct io_ring_ctx *ctx)
-{
-	return 0;
-}
-#endif
-
 static void io_rsrc_file_put(struct io_ring_ctx *ctx, struct io_rsrc_put *prsrc)
 {
 	struct file *file = prsrc->file;
-#if defined(CONFIG_UNIX)
-	struct sock *sock = ctx->ring_sock->sk;
-	struct sk_buff_head list, *head = &sock->sk_receive_queue;
-	struct sk_buff *skb;
-	int i;
-
-	__skb_queue_head_init(&list);
-
-	/*
-	 * Find the skb that holds this file in its SCM_RIGHTS. When found,
-	 * remove this entry and rearrange the file array.
-	 */
-	skb = skb_dequeue(head);
-	while (skb) {
-		struct scm_fp_list *fp;
 
-		fp = UNIXCB(skb).fp;
-		for (i = 0; i < fp->count; i++) {
-			int left;
-
-			if (fp->fp[i] != file)
-				continue;
-
-			unix_notinflight(fp->user, fp->fp[i]);
-			left = fp->count - 1 - i;
-			if (left) {
-				memmove(&fp->fp[i], &fp->fp[i + 1],
-						left * sizeof(struct file *));
-			}
-			fp->count--;
-			if (!fp->count) {
-				kfree_skb(skb);
-				skb = NULL;
-			} else {
-				__skb_queue_tail(&list, skb);
-			}
-			fput(file);
-			file = NULL;
-			break;
-		}
-
-		if (!file)
-			break;
-
-		__skb_queue_tail(&list, skb);
-
-		skb = skb_dequeue(head);
-	}
-
-	if (skb_peek(&list)) {
-		spin_lock_irq(&head->lock);
-		while ((skb = __skb_dequeue(&list)) != NULL)
-			__skb_queue_tail(head, skb);
-		spin_unlock_irq(&head->lock);
-	}
-#else
 	fput(file);
-#endif
 }
 
 static void __io_rsrc_put_work(struct io_rsrc_node *ref_node)
@@ -8608,12 +8421,6 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 		io_fixed_file_set(io_fixed_file_slot(&ctx->file_table, i), file);
 	}
 
-	ret = io_sqe_files_scm(ctx);
-	if (ret) {
-		__io_sqe_files_unregister(ctx);
-		return ret;
-	}
-
 	io_rsrc_node_switch(ctx, NULL);
 	return ret;
 out_fput:
@@ -9570,12 +9377,6 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	WARN_ON_ONCE(!list_empty(&ctx->rsrc_ref_list));
 	WARN_ON_ONCE(!llist_empty(&ctx->rsrc_put_llist));
 
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		ctx->ring_sock->file = NULL; /* so that iput() is called */
-		sock_release(ctx->ring_sock);
-	}
-#endif
 	WARN_ON_ONCE(!list_empty(&ctx->ltimeout_list));
 
 	if (ctx->mm_account) {
@@ -10445,6 +10246,11 @@ static const struct file_operations io_uring_fops = {
 #endif
 };
 
+bool io_is_uring_fops(struct file *file)
+{
+	return file->f_op == &io_uring_fops;
+}
+
 static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 				  struct io_uring_params *p)
 {
@@ -10507,32 +10313,12 @@ static int io_uring_install_fd(struct io_ring_ctx *ctx, struct file *file)
 /*
  * Allocate an anonymous fd, this is what constitutes the application
  * visible backing of an io_uring instance. The application mmaps this
- * fd to gain access to the SQ/CQ ring details. If UNIX sockets are enabled,
- * we have to tie this fd to a socket for file garbage collection purposes.
+ * fd to gain access to the SQ/CQ ring details.
  */
 static struct file *io_uring_get_file(struct io_ring_ctx *ctx)
 {
-	struct file *file;
-#if defined(CONFIG_UNIX)
-	int ret;
-
-	ret = sock_create_kern(&init_net, PF_UNIX, SOCK_RAW, IPPROTO_IP,
-				&ctx->ring_sock);
-	if (ret)
-		return ERR_PTR(ret);
-#endif
-
-	file = anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
-					O_RDWR | O_CLOEXEC);
-#if defined(CONFIG_UNIX)
-	if (IS_ERR(file)) {
-		sock_release(ctx->ring_sock);
-		ctx->ring_sock = NULL;
-	} else {
-		ctx->ring_sock->file = file;
-	}
-#endif
-	return file;
+	return anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
+				  O_RDWR | O_CLOEXEC);
 }
 
 static int io_uring_create(unsigned entries, struct io_uring_params *p,
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index f7de5b313cc5b..a8429cfb4ae8c 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -305,6 +305,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -330,10 +331,12 @@ static int cpu_map_kthread_run(void *data)
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
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index f02d04540c0c0..b591073c5f83d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		/* hash table size must be power of 2; roundup_pow_of_two() can
+		 * overflow into UB on 32-bit arches, so check that first
+		 */
+		if (dtab->map.max_entries > 1UL << 31)
 			return -EINVAL;
-	}
 
-	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 28b43642c0593..f53b4f04b935c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -504,7 +504,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -514,10 +520,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
-	err = -E2BIG;
-	/* prevent zero size kmalloc and check for u32 overflow */
-	if (htab->n_buckets == 0 ||
-	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
+	/* check for u32 overflow */
+	if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
 		goto free_htab;
 
 	err = -ENOMEM;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 870127c895c49..273f2f0deb239 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -298,7 +298,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 	__this_cpu_write(irqsave_flags, flags);
 }
 
-notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_lock_irqsave(lock);
 	return 0;
@@ -320,7 +320,7 @@ static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 	local_irq_restore(flags);
 }
 
-notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_unlock_irqrestore(lock);
 	return 0;
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index af0f15db1bf9a..4cf79f86bf458 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -110,10 +110,15 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 
 void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
-	/* ptr->ops->map_free() has to go through one
-	 * rcu grace period by itself.
+	struct bpf_map *inner_map = ptr;
+
+	/* The inner map may still be used by both non-sleepable and sleepable
+	 * bpf program, so free it after one RCU grace period and one tasks
+	 * trace RCU grace period.
 	 */
-	bpf_map_put(ptr);
+	if (need_defer)
+		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+	bpf_map_put(inner_map);
 }
 
 u32 bpf_map_fd_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index f8587abef73c1..e04571c1833f6 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -113,11 +113,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
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
 	smap = bpf_map_area_alloc(cost, bpf_map_attr_numa_node(attr));
 	if (!smap)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 64206856a05c4..d4b4a47081b51 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -487,6 +487,25 @@ static void bpf_map_put_uref(struct bpf_map *map)
 	}
 }
 
+static void bpf_map_free_in_work(struct bpf_map *map)
+{
+	INIT_WORK(&map->work, bpf_map_free_deferred);
+	schedule_work(&map->work);
+}
+
+static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
+{
+	bpf_map_free_in_work(container_of(rcu, struct bpf_map, rcu));
+}
+
+static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_map_free_rcu_gp(rcu);
+	else
+		call_rcu(rcu, bpf_map_free_rcu_gp);
+}
+
 /* decrement map refcnt and schedule it for freeing via workqueue
  * (unrelying map implementation ops->map_free() might sleep)
  */
@@ -496,8 +515,11 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map, do_idr_lock);
 		btf_put(map->btf);
-		INIT_WORK(&map->work, bpf_map_free_deferred);
-		schedule_work(&map->work);
+
+		if (READ_ONCE(map->free_after_mult_rcu_gp))
+			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
+		else
+			bpf_map_free_in_work(map);
 	}
 }
 
diff --git a/kernel/module.c b/kernel/module.c
index ba9f2bb57889c..4d49c32af570c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3713,6 +3713,17 @@ static void do_free_init(struct work_struct *w)
 	}
 }
 
+void flush_module_init_free_work(void)
+{
+	flush_work(&init_free_wq);
+}
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "module."
+/* Default value for module->async_probe_requested */
+static bool async_probe;
+module_param(async_probe, bool, 0644);
+
 /*
  * This is where the real work happens.
  *
@@ -3797,8 +3808,8 @@ static noinline int do_init_module(struct module *mod)
 	 * Note that module_alloc() on most architectures creates W+X page
 	 * mappings which won't be cleaned up until do_free_init() runs.  Any
 	 * code such as mark_rodata_ro() which depends on those mappings to
-	 * be cleaned up needs to sync with the queued work - ie
-	 * rcu_barrier()
+	 * be cleaned up needs to sync with the queued work by invoking
+	 * flush_module_init_free_work().
 	 */
 	if (llist_add(&freeinit->node, &init_free_list))
 		schedule_work(&init_free_wq);
@@ -3943,7 +3954,8 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 	int ret;
 
 	if (strcmp(param, "async_probe") == 0) {
-		mod->async_probe_requested = true;
+		if (strtobool(val, &mod->async_probe_requested))
+			mod->async_probe_requested = true;
 		return 0;
 	}
 
@@ -4110,6 +4122,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto bug_cleanup;
 
+	mod->async_probe_requested = async_probe;
+
 	/* Module is ready to execute: parsing args may do that. */
 	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
 				  -32768, 32767, mod,
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 28f628c702452..b24ef77325eed 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1098,6 +1098,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
+
+	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
 	synchronize_rcu();
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b55d51b4105cd..4a1393405a6fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6394,7 +6394,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -6402,7 +6402,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 831e8e779acef..f7c3de01197c9 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -73,7 +73,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
 			year, month, mdday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d921c1b256cf5..dfa6649c490de 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1163,13 +1163,15 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
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
@@ -1229,7 +1231,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now = tk_clock_read(&tk->tkr_mono);
 		interval_start = tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!timestamp_in_interval(interval_start, now, cycles)) {
 			clock_was_set_seq = tk->clock_was_set_seq;
 			cs_was_changed_seq = tk->cs_was_changed_seq;
 			cycles = interval_start;
@@ -1242,10 +1244,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
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
@@ -1260,13 +1260,13 @@ int get_device_system_crosststamp(int (*get_time_fn)
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
diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index a72a2c16066ef..de7fb7476cb9a 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
 			    n, e[0], r[0]);
 
 	p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
-	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %td out of bound", n, p - r);
 }
 
 static void cmdline_test_range(struct kunit *test)
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
index a8854b24f4cfb..8a3c867bdff03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2187,7 +2187,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ba7242729a8fb..0be37a5c1c0c2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3072,8 +3072,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8d6fce9005bdd..4f54c7df3a94f 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1937,7 +1937,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
 	/* Get data directly from socket receive queue without copying it. */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
-		if (!skb_linearize(skb)) {
+		if (!skb_linearize(skb) && sk->sk_state != BT_CLOSED) {
 			s = rfcomm_recv_frame(s, skb);
 			if (!s)
 				break;
diff --git a/net/core/dev.c b/net/core/dev.c
index af77dc77eb9c8..f80bc2ca888aa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2291,7 +2291,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(ptype, ptype_list, list) {
-		if (ptype->ignore_outgoing)
+		if (READ_ONCE(ptype->ignore_outgoing))
 			continue;
 
 		/* Never send packets back to the socket
@@ -7143,6 +7143,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -7157,6 +7159,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index f0a3cdc4d4961..457d1a164ad5d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10316,8 +10316,7 @@ int sk_detach_filter(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_detach_filter);
 
-int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
-		  unsigned int len)
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
 	struct sock_fprog_kern *fprog;
 	struct sk_filter *filter;
@@ -10348,7 +10347,7 @@ int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
 		goto out;
 
 	ret = -EFAULT;
-	if (copy_to_user(ubuf, fprog->filter, bpf_classic_proglen(fprog)))
+	if (copy_to_sockptr(optval, fprog->filter, bpf_classic_proglen(fprog)))
 		goto out;
 
 	/* Instead of bytes, the API requests to return the number
diff --git a/net/core/scm.c b/net/core/scm.c
index e762a4b8a1d22..a877c4ef4c256 100644
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
diff --git a/net/core/sock.c b/net/core/sock.c
index e254790d562ef..6f761f3c272aa 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -671,8 +671,8 @@ static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 	return ret;
 }
 
-static int sock_getbindtodevice(struct sock *sk, char __user *optval,
-				int __user *optlen, int len)
+static int sock_getbindtodevice(struct sock *sk, sockptr_t optval,
+				sockptr_t optlen, int len)
 {
 	int ret = -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -695,12 +695,12 @@ static int sock_getbindtodevice(struct sock *sk, char __user *optval,
 	len = strlen(devname) + 1;
 
 	ret = -EFAULT;
-	if (copy_to_user(optval, devname, len))
+	if (copy_to_sockptr(optval, devname, len))
 		goto out;
 
 zero:
 	ret = -EFAULT;
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		goto out;
 
 	ret = 0;
@@ -1404,22 +1404,25 @@ static void cred_to_ucred(struct pid *pid, const struct cred *cred,
 	}
 }
 
-static int groups_to_user(gid_t __user *dst, const struct group_info *src)
+static int groups_to_user(sockptr_t dst, const struct group_info *src)
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int i;
 
-	for (i = 0; i < src->ngroups; i++)
-		if (put_user(from_kgid_munged(user_ns, src->gid[i]), dst + i))
+	for (i = 0; i < src->ngroups; i++) {
+		gid_t gid = from_kgid_munged(user_ns, src->gid[i]);
+
+		if (copy_to_sockptr_offset(dst, i * sizeof(gid), &gid, sizeof(gid)))
 			return -EFAULT;
+	}
 
 	return 0;
 }
 
-int sock_getsockopt(struct socket *sock, int level, int optname,
-		    char __user *optval, int __user *optlen)
+static int sk_getsockopt(struct sock *sk, int level, int optname,
+			 sockptr_t optval, sockptr_t optlen)
 {
-	struct sock *sk = sock->sk;
+	struct socket *sock = sk->sk_socket;
 
 	union {
 		int val;
@@ -1436,7 +1439,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 	int lv = sizeof(int);
 	int len;
 
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1578,7 +1581,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
 		spin_unlock(&sk->sk_peer_lock);
 
-		if (copy_to_user(optval, &peercred, len))
+		if (copy_to_sockptr(optval, &peercred, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1596,11 +1599,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		if (len < n * sizeof(gid_t)) {
 			len = n * sizeof(gid_t);
 			put_cred(cred);
-			return put_user(len, optlen) ? -EFAULT : -ERANGE;
+			return copy_to_sockptr(optlen, &len, sizeof(int)) ? -EFAULT : -ERANGE;
 		}
 		len = n * sizeof(gid_t);
 
-		ret = groups_to_user((gid_t __user *)optval, cred->group_info);
+		ret = groups_to_user(optval, cred->group_info);
 		put_cred(cred);
 		if (ret)
 			return ret;
@@ -1616,7 +1619,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_user(optval, address, len))
+		if (copy_to_sockptr(optval, address, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1633,7 +1636,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_PEERSEC:
-		return security_socket_getpeersec_stream(sock, optval, optlen, len);
+		return security_socket_getpeersec_stream(sock, optval.user, optlen.user, len);
 
 	case SO_MARK:
 		v.val = sk->sk_mark;
@@ -1661,7 +1664,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		return sock_getbindtodevice(sk, optval, optlen, len);
 
 	case SO_GET_FILTER:
-		len = sk_get_filter(sk, (struct sock_filter __user *)optval, len);
+		len = sk_get_filter(sk, optval, len);
 		if (len < 0)
 			return len;
 
@@ -1711,7 +1714,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		sk_get_meminfo(sk, meminfo);
 
 		len = min_t(unsigned int, len, sizeof(meminfo));
-		if (copy_to_user(optval, &meminfo, len))
+		if (copy_to_sockptr(optval, &meminfo, len))
 			return -EFAULT;
 
 		goto lenout;
@@ -1772,14 +1775,22 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 
 	if (len > lv)
 		len = lv;
-	if (copy_to_user(optval, &v, len))
+	if (copy_to_sockptr(optval, &v, len))
 		return -EFAULT;
 lenout:
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		return -EFAULT;
 	return 0;
 }
 
+int sock_getsockopt(struct socket *sock, int level, int optname,
+		    char __user *optval, int __user *optlen)
+{
+	return sk_getsockopt(sock->sk, level, optname,
+			     USER_SOCKPTR(optval),
+			     USER_SOCKPTR(optlen));
+}
+
 /*
  * Initialize an sk_lock.
  *
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index c9c45b935f990..bce65b519ee80 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -189,7 +189,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -205,7 +205,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	WRITE_ONCE(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
@@ -223,7 +223,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (sock_diag_handlers[req->sdiag_family] == NULL)
+	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
 
 	mutex_lock(&sock_diag_table_mutex);
@@ -282,12 +282,12 @@ static int sock_diag_bind(struct net *net, int group)
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
index 8c9a20e99f0f4..e0aeeeda3c876 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -237,6 +237,10 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
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
index b099c31501509..257b50124cee5 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -148,14 +148,21 @@ static struct notifier_block hsr_nb = {
 
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
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 88e780a168652..d2d0fb6dcff78 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2532,11 +2532,10 @@ int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf, int ifindex)
 		err = ip_mc_leave_group(sk, &imr);
 	return err;
 }
-
 int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-	struct ip_msfilter __user *optval, int __user *optlen)
+		 sockptr_t optval, sockptr_t optlen)
 {
-	int err, len, count, copycount;
+	int err, len, count, copycount, msf_size;
 	struct ip_mreqn	imr;
 	__be32 addr = msf->imsf_multiaddr;
 	struct ip_mc_socklist *pmc;
@@ -2579,12 +2578,15 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 	copycount = count < msf->imsf_numsrc ? count : msf->imsf_numsrc;
 	len = flex_array_size(psl, sl_addr, copycount);
 	msf->imsf_numsrc = count;
-	if (put_user(IP_MSFILTER_SIZE(copycount), optlen) ||
-	    copy_to_user(optval, msf, IP_MSFILTER_SIZE(0))) {
+	msf_size = IP_MSFILTER_SIZE(copycount);
+	if (copy_to_sockptr(optlen, &msf_size, sizeof(int)) ||
+	    copy_to_sockptr(optval, msf, IP_MSFILTER_SIZE(0))) {
 		return -EFAULT;
 	}
 	if (len &&
-	    copy_to_user(&optval->imsf_slist_flex[0], psl->sl_addr, len))
+	    copy_to_sockptr_offset(optval,
+				   offsetof(struct ip_msfilter, imsf_slist_flex),
+				   psl->sl_addr, len))
 		return -EFAULT;
 	return 0;
 done:
@@ -2592,7 +2594,7 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
 }
 
 int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-	struct sockaddr_storage __user *p)
+		 sockptr_t optval, size_t ss_offset)
 {
 	int i, count, copycount;
 	struct sockaddr_in *psin;
@@ -2622,15 +2624,17 @@ int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
 	count = psl ? psl->sl_count : 0;
 	copycount = count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
 	gsf->gf_numsrc = count;
-	for (i = 0; i < copycount; i++, p++) {
+	for (i = 0; i < copycount; i++) {
 		struct sockaddr_storage ss;
 
 		psin = (struct sockaddr_in *)&ss;
 		memset(&ss, 0, sizeof(ss));
 		psin->sin_family = AF_INET;
 		psin->sin_addr.s_addr = psl->sl_addr[i];
-		if (copy_to_user(p, &ss, sizeof(ss)))
+		if (copy_to_sockptr_offset(optval, ss_offset,
+					   &ss, sizeof(ss)))
 			return -EFAULT;
+		ss_offset += sizeof(ss);
 	}
 	return 0;
 }
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 09cabed358fd0..3aeba9e2b22cd 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -57,7 +57,7 @@ static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 		return ERR_PTR(-ENOENT);
 	}
 
-	if (!inet_diag_table[proto])
+	if (!READ_ONCE(inet_diag_table[proto]))
 		sock_load_diag_module(AF_INET, proto);
 
 	mutex_lock(&inet_diag_table_mutex);
@@ -1419,7 +1419,7 @@ int inet_diag_register(const struct inet_diag_handler *h)
 	mutex_lock(&inet_diag_table_mutex);
 	err = -EEXIST;
 	if (!inet_diag_table[type]) {
-		inet_diag_table[type] = h;
+		WRITE_ONCE(inet_diag_table[type], h);
 		err = 0;
 	}
 	mutex_unlock(&inet_diag_table_mutex);
@@ -1436,7 +1436,7 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 		return;
 
 	mutex_lock(&inet_diag_table_mutex);
-	inet_diag_table[type] = NULL;
+	WRITE_ONCE(inet_diag_table[type], NULL);
 	mutex_unlock(&inet_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 540002c9f3b35..3620dc739a5bf 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1460,37 +1460,37 @@ static bool getsockopt_needs_rtnl(int optname)
 	return false;
 }
 
-static int ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
-		int __user *optlen, int len)
+static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
+				 sockptr_t optlen, int len)
 {
 	const int size0 = offsetof(struct group_filter, gf_slist_flex);
-	struct group_filter __user *p = optval;
 	struct group_filter gsf;
-	int num;
+	int num, gsf_size;
 	int err;
 
 	if (len < size0)
 		return -EINVAL;
-	if (copy_from_user(&gsf, p, size0))
+	if (copy_from_sockptr(&gsf, optval, size0))
 		return -EFAULT;
 
 	num = gsf.gf_numsrc;
-	err = ip_mc_gsfget(sk, &gsf, p->gf_slist_flex);
+	err = ip_mc_gsfget(sk, &gsf, optval,
+			   offsetof(struct group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gsf.gf_numsrc < num)
 		num = gsf.gf_numsrc;
-	if (put_user(GROUP_FILTER_SIZE(num), optlen) ||
-	    copy_to_user(p, &gsf, size0))
+	gsf_size = GROUP_FILTER_SIZE(num);
+	if (copy_to_sockptr(optlen, &gsf_size, sizeof(int)) ||
+	    copy_to_sockptr(optval, &gsf, size0))
 		return -EFAULT;
 	return 0;
 }
 
-static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
-		int __user *optlen, int len)
+static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
+					sockptr_t optlen, int len)
 {
 	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
-	struct compat_group_filter __user *p = optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
 	int num;
@@ -1498,7 +1498,7 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 
 	if (len < size0)
 		return -EINVAL;
-	if (copy_from_user(&gf32, p, size0))
+	if (copy_from_sockptr(&gf32, optval, size0))
 		return -EFAULT;
 
 	gf.gf_interface = gf32.gf_interface;
@@ -1506,21 +1506,24 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
 	num = gf.gf_numsrc = gf32.gf_numsrc;
 	gf.gf_group = gf32.gf_group;
 
-	err = ip_mc_gsfget(sk, &gf, p->gf_slist_flex);
+	err = ip_mc_gsfget(sk, &gf, optval,
+			   offsetof(struct compat_group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gf.gf_numsrc < num)
 		num = gf.gf_numsrc;
 	len = GROUP_FILTER_SIZE(num) - (sizeof(gf) - sizeof(gf32));
-	if (put_user(len, optlen) ||
-	    put_user(gf.gf_fmode, &p->gf_fmode) ||
-	    put_user(gf.gf_numsrc, &p->gf_numsrc))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_fmode),
+				   &gf.gf_fmode, sizeof(gf.gf_fmode)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_numsrc),
+				   &gf.gf_numsrc, sizeof(gf.gf_numsrc)))
 		return -EFAULT;
 	return 0;
 }
 
 static int do_ip_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen)
+			    sockptr_t optval, sockptr_t optlen)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	bool needs_rtnl = getsockopt_needs_rtnl(optname);
@@ -1533,7 +1536,7 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	if (ip_mroute_opt(optname))
 		return ip_mroute_getsockopt(sk, optname, optval, optlen);
 
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1558,15 +1561,17 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			       inet_opt->opt.optlen);
 		release_sock(sk);
 
-		if (opt->optlen == 0)
-			return put_user(0, optlen);
+		if (opt->optlen == 0) {
+			len = 0;
+			return copy_to_sockptr(optlen, &len, sizeof(int));
+		}
 
 		ip_options_undo(opt);
 
 		len = min_t(unsigned int, len, opt->optlen);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, opt->__data, len))
+		if (copy_to_sockptr(optval, opt->__data, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -1657,9 +1662,9 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		addr.s_addr = inet->mc_addr;
 		release_sock(sk);
 
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &addr, len))
+		if (copy_to_sockptr(optval, &addr, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -1671,12 +1676,11 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			err = -EINVAL;
 			goto out;
 		}
-		if (copy_from_user(&msf, optval, IP_MSFILTER_SIZE(0))) {
+		if (copy_from_sockptr(&msf, optval, IP_MSFILTER_SIZE(0))) {
 			err = -EFAULT;
 			goto out;
 		}
-		err = ip_mc_msfget(sk, &msf,
-				   (struct ip_msfilter __user *)optval, optlen);
+		err = ip_mc_msfget(sk, &msf, optval, optlen);
 		goto out;
 	}
 	case MCAST_MSFILTER:
@@ -1698,8 +1702,13 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		if (sk->sk_type != SOCK_STREAM)
 			return -ENOPROTOOPT;
 
-		msg.msg_control_is_user = true;
-		msg.msg_control_user = optval;
+		if (optval.is_kernel) {
+			msg.msg_control_is_user = false;
+			msg.msg_control = optval.kernel;
+		} else {
+			msg.msg_control_is_user = true;
+			msg.msg_control_user = optval.user;
+		}
 		msg.msg_controllen = len;
 		msg.msg_flags = in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
 
@@ -1720,7 +1729,7 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
 		}
 		len -= msg.msg_controllen;
-		return put_user(len, optlen);
+		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
 	case IP_FREEBIND:
 		val = inet->freebind;
@@ -1743,15 +1752,15 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
 		unsigned char ucval = (unsigned char)val;
 		len = 1;
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &ucval, 1))
+		if (copy_to_sockptr(optval, &ucval, 1))
 			return -EFAULT;
 	} else {
 		len = min_t(unsigned int, sizeof(int), len);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &val, len))
+		if (copy_to_sockptr(optval, &val, len))
 			return -EFAULT;
 	}
 	return 0;
@@ -1768,7 +1777,8 @@ int ip_getsockopt(struct sock *sk, int level,
 {
 	int err;
 
-	err = do_ip_getsockopt(sk, level, optname, optval, optlen);
+	err = do_ip_getsockopt(sk, level, optname,
+			       USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
 
 #if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 96b7cd3049a33..db6d3d5c474c6 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -364,7 +364,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  bool log_ecn_error)
 {
 	const struct iphdr *iph = ip_hdr(skb);
-	int err;
+	int nh, err;
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 	if (ipv4_is_multicast(iph->daddr)) {
@@ -390,8 +390,21 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
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
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index aea29d97f8dfa..c9a633559258c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1540,7 +1540,8 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 }
 
 /* Getsock opt support for the multicast routing system. */
-int ip_mroute_getsockopt(struct sock *sk, int optname, char __user *optval, int __user *optlen)
+int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
+			 sockptr_t optlen)
 {
 	int olr;
 	int val;
@@ -1571,14 +1572,16 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, char __user *optval, int
 		return -ENOPROTOOPT;
 	}
 
-	if (get_user(olr, optlen))
+	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
-	olr = min_t(unsigned int, olr, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
-	if (put_user(olr, optlen))
+
+	olr = min_t(unsigned int, olr, sizeof(int));
+
+	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
 		return -EFAULT;
-	if (copy_to_user(optval, &val, olr))
+	if (copy_to_sockptr(optval, &val, olr))
 		return -EFAULT;
 	return 0;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 626cef75afe7a..521c15962c719 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3965,11 +3965,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
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
index c454daa78a2f8..2caf54c241037 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2814,11 +2814,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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
index dcedfe29d9d93..8e9e80eb0f329 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -446,6 +446,11 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
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
@@ -458,6 +463,7 @@ static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.compare		= fib6_rule_compare,
 	.fill			= fib6_rule_fill,
 	.nlmsg_payload		= fib6_rule_nlmsg_payload,
+	.flush_cache		= fib6_rule_flush_cache,
 	.nlgroup		= RTNLGRP_IPV6_RULE,
 	.policy			= fib6_rule_policy,
 	.owner			= THIS_MODULE,
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 0ea7d97cdc025..6e5d1ade48a89 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2722,7 +2722,6 @@ void ipv6_mc_down(struct inet6_dev *idev)
 	/* Should stop work after group drop. or we will
 	 * start work again in mld_ifc_event()
 	 */
-	synchronize_net();
 	mld_query_stop_work(idev);
 	mld_report_stop_work(idev);
 
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 8efc369934fc7..68edefed79f16 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -156,7 +156,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -544,7 +544,7 @@ static int iucv_enable(void)
 
 	cpus_read_lock();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 0d1ab4149553c..5457ca1909801 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1275,10 +1275,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
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
index 9cef8e080f644..55de42b000d8a 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1357,11 +1357,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	err = -ENOTCONN;
 	if (!sk->sk_user_data)
 		goto end;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a5e1468cac5ed..42bf83a20cb52 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1152,7 +1152,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_MASK)
 		return -EOPNOTSUPP;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	if ((nft_table_has_owner(ctx->table) &&
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index e1969209b3abb..58eca26162735 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2240,8 +2240,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(ctx, set, m);
-
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
@@ -2253,8 +2251,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (priv->clone) {
 		m = priv->clone;
 
-		if (priv->dirty)
-			nft_set_pipapo_match_destroy(ctx, set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(priv->clone, cpu);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 75fb80717e489..cffa217fb3063 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3951,7 +3951,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (val < 0 || val > 1)
 			return -EINVAL;
 
-		po->prot_hook.ignore_outgoing = !!val;
+		WRITE_ONCE(po->prot_hook.ignore_outgoing, !!val);
 		return 0;
 	}
 	case PACKET_TX_HAS_OFF:
@@ -4080,7 +4080,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		       0);
 		break;
 	case PACKET_IGNORE_OUTGOING:
-		val = po->prot_hook.ignore_outgoing;
+		val = READ_ONCE(po->prot_hook.ignore_outgoing);
 		break;
 	case PACKET_ROLLOVER_STATS:
 		if (!po->rollover)
diff --git a/net/rds/send.c b/net/rds/send.c
index d6462d1471c14..85c27d9aa33a3 100644
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
index d435bffc61999..97ff11973c493 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -284,10 +284,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
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
index d79f12c2550ac..cb32ab9a83952 100644
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
index ab2c83d58b62a..9bfffe2a7f020 100644
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
index e8e2a00bb0f58..d1048b4c2baaf 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -34,10 +34,8 @@ struct sock *unix_get_socket(struct file *filp)
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
index 07f6206e7cb47..1e5152fdee589 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -460,12 +460,12 @@ static int x25_getsockopt(struct socket *sock, int level, int optname,
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
diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 1d1bde1fd45eb..3ac949b64b309 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -184,7 +184,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Use os.path.abspath() to normalize the path resolving '.' and '..' .
     abs_path = os.path.abspath(os.path.join(root_directory, file_path))
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 312cbad2d34d4..2a76393d52b5b 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -301,8 +301,11 @@ static char *expand_token(const char *in, size_t n)
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
index 4589aac091542..b00bbf18a6f5d 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -112,6 +112,12 @@ static int dump_midi(struct snd_rawmidi_substream *substream, const char *buf, i
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
@@ -131,7 +137,7 @@ static int event_process_midi(struct snd_seq_event *ev, int direct,
 			pr_debug("ALSA: seq_midi: invalid sysex event flags = 0x%x\n", ev->flags);
 			return 0;
 		}
-		snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
+		snd_seq_dump_var_event(ev, __dump_midi, substream);
 		snd_midi_event_reset_decode(msynth->parser);
 	} else {
 		if (msynth->parser == NULL)
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 4abc38c70cae2..339799bfaad9d 100644
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
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a6e6ed1355abf..200d0b953d3b2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3675,6 +3675,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
@@ -6669,6 +6670,60 @@ static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
 	}
 }
 
+static void alc285_fixup_hp_envy_x360(struct hda_codec *codec,
+				      const struct hda_fixup *fix,
+				      int action)
+{
+	static const struct coef_fw coefs[] = {
+		WRITE_COEF(0x08, 0x6a0c), WRITE_COEF(0x0d, 0xa023),
+		WRITE_COEF(0x10, 0x0320), WRITE_COEF(0x1a, 0x8c03),
+		WRITE_COEF(0x25, 0x1800), WRITE_COEF(0x26, 0x003a),
+		WRITE_COEF(0x28, 0x1dfe), WRITE_COEF(0x29, 0xb014),
+		WRITE_COEF(0x2b, 0x1dfe), WRITE_COEF(0x37, 0xfe15),
+		WRITE_COEF(0x38, 0x7909), WRITE_COEF(0x45, 0xd489),
+		WRITE_COEF(0x46, 0x00f4), WRITE_COEF(0x4a, 0x21e0),
+		WRITE_COEF(0x66, 0x03f0), WRITE_COEF(0x67, 0x1000),
+		WRITE_COEF(0x6e, 0x1005), { }
+	};
+
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x12, 0xb7a60130 },  /* Internal microphone*/
+		{ 0x14, 0x90170150 },  /* B&O soundbar speakers */
+		{ 0x17, 0x90170153 },  /* Side speakers */
+		{ 0x19, 0x03a11040 },  /* Headset microphone */
+		{ }
+	};
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
+
+		/* Fixes volume control problem for side speakers */
+		alc295_fixup_disable_dac3(codec, fix, action);
+
+		/* Fixes no sound from headset speaker */
+		snd_hda_codec_amp_stereo(codec, 0x21, HDA_OUTPUT, 0, -1, 0);
+
+		/* Auto-enable headset mic when plugged */
+		snd_hda_jack_set_gating_jack(codec, 0x19, 0x21);
+
+		/* Headset mic volume enhancement */
+		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREF50);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		alc_process_coef_fw(codec, coefs);
+		break;
+	case HDA_FIXUP_ACT_BUILD:
+		rename_ctl(codec, "Bass Speaker Playback Volume",
+			   "B&O-Tuned Playback Volume");
+		rename_ctl(codec, "Front Playback Switch",
+			   "B&O Soundbar Playback Switch");
+		rename_ctl(codec, "Bass Speaker Playback Switch",
+			   "Side Speaker Playback Switch");
+		break;
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -6876,6 +6931,7 @@ enum {
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
 	ALC285_FIXUP_HP_SPECTRE_X360_EB1,
+	ALC285_FIXUP_HP_ENVY_X360,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13,
@@ -8678,6 +8734,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_eb1
 	},
+	[ALC285_FIXUP_HP_ENVY_X360] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_envy_x360,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_HP_GPIO_AMP_INIT,
+	},
 	[ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_ideapad_s740_coef,
@@ -9065,6 +9127,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
@@ -9599,6 +9662,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360_EB1, .name = "alc285-hp-spectre-x360-eb1"},
+	{.id = ALC285_FIXUP_HP_ENVY_X360, .name = "alc285-hp-envy-x360"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index f903bee194d5c..2cc3d814bab41 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3803,6 +3803,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
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
index 779f7097d336c..b5a35999d8dfa 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2219,6 +2219,9 @@ SND_SOC_DAPM_PGA_E("HPOUT", SND_SOC_NOPM, 0, 0, NULL, 0, hp_event,
 
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
 SND_SOC_DAPM_OUTPUT("HPOUTR"),
+
+SND_SOC_DAPM_PGA("SPKOUTL Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
+SND_SOC_DAPM_PGA("SPKOUTR Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_widget wm8962_dapm_spk_mono_widgets[] = {
@@ -2226,7 +2229,6 @@ SND_SOC_DAPM_MIXER("Speaker Mixer", WM8962_MIXER_ENABLES, 1, 0,
 		   spkmixl, ARRAY_SIZE(spkmixl)),
 SND_SOC_DAPM_MUX_E("Speaker PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
 		   out_pga_event, SND_SOC_DAPM_POST_PMU),
-SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
 SND_SOC_DAPM_OUTPUT("SPKOUT"),
 };
 
@@ -2241,9 +2243,6 @@ SND_SOC_DAPM_MUX_E("SPKOUTL PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
 SND_SOC_DAPM_MUX_E("SPKOUTR PGA", WM8962_PWR_MGMT_2, 3, 0, &spkoutr_mux,
 		   out_pga_event, SND_SOC_DAPM_POST_PMU),
 
-SND_SOC_DAPM_PGA("SPKOUTR Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
-SND_SOC_DAPM_PGA("SPKOUTL Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
-
 SND_SOC_DAPM_OUTPUT("SPKOUTL"),
 SND_SOC_DAPM_OUTPUT("SPKOUTR"),
 };
@@ -2353,12 +2352,18 @@ static const struct snd_soc_dapm_route wm8962_spk_mono_intercon[] = {
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
@@ -2901,8 +2906,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
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
@@ -2911,7 +2920,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 49dfbd29c5451..434679afa7e1a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -668,6 +668,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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
diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index ba15d5762b0bf..a164ca2446ecd 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -215,49 +215,27 @@ static const char * const aiu_spdif_ids[] = {
 static int aiu_clk_get(struct device *dev)
 {
 	struct aiu *aiu = dev_get_drvdata(dev);
+	struct clk *pclk;
 	int ret;
 
-	aiu->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(aiu->pclk)) {
-		if (PTR_ERR(aiu->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the aiu pclk\n");
-		return PTR_ERR(aiu->pclk);
-	}
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "Can't get the aiu pclk\n");
 
 	aiu->spdif_mclk = devm_clk_get(dev, "spdif_mclk");
-	if (IS_ERR(aiu->spdif_mclk)) {
-		if (PTR_ERR(aiu->spdif_mclk) != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the aiu spdif master clock\n");
-		return PTR_ERR(aiu->spdif_mclk);
-	}
+	if (IS_ERR(aiu->spdif_mclk))
+		return dev_err_probe(dev, PTR_ERR(aiu->spdif_mclk),
+				     "Can't get the aiu spdif master clock\n");
 
 	ret = aiu_clk_bulk_get(dev, aiu_i2s_ids, ARRAY_SIZE(aiu_i2s_ids),
 			       &aiu->i2s);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the i2s clocks\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't get the i2s clocks\n");
 
 	ret = aiu_clk_bulk_get(dev, aiu_spdif_ids, ARRAY_SIZE(aiu_spdif_ids),
 			       &aiu->spdif);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the spdif clocks\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(aiu->pclk);
-	if (ret) {
-		dev_err(dev, "peripheral clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       aiu->pclk);
 	if (ret)
-		dev_err(dev, "failed to add reset action on pclk");
+		return dev_err_probe(dev, ret, "Can't get the spdif clocks\n");
 
 	return ret;
 }
@@ -281,11 +259,8 @@ static int aiu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, aiu);
 
 	ret = device_reset(dev);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to reset device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset device\n");
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 393b6c2307e49..0f94c8bf60818 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -33,7 +33,6 @@ struct aiu_platform_data {
 };
 
 struct aiu {
-	struct clk *pclk;
 	struct clk *spdif_mclk;
 	struct aiu_interface i2s;
 	struct aiu_interface spdif;
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index b9af2d513e096..bccfb770b3391 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -351,20 +351,12 @@ int axg_fifo_probe(struct platform_device *pdev)
 	}
 
 	fifo->pclk = devm_clk_get(dev, NULL);
-	if (IS_ERR(fifo->pclk)) {
-		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %ld\n",
-				PTR_ERR(fifo->pclk));
-		return PTR_ERR(fifo->pclk);
-	}
+	if (IS_ERR(fifo->pclk))
+		return dev_err_probe(dev, PTR_ERR(fifo->pclk), "failed to get pclk\n");
 
 	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(fifo->arb)) {
-		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get arb reset: %ld\n",
-				PTR_ERR(fifo->arb));
-		return PTR_ERR(fifo->arb);
-	}
+	if (IS_ERR(fifo->arb))
+		return dev_err_probe(dev, PTR_ERR(fifo->arb), "failed to get arb reset\n");
 
 	fifo->irq = of_irq_get(dev->of_node, 0);
 	if (fifo->irq <= 0) {
diff --git a/sound/soc/meson/axg-pdm.c b/sound/soc/meson/axg-pdm.c
index bfd37d49a73ef..672e43a9729dc 100644
--- a/sound/soc/meson/axg-pdm.c
+++ b/sound/soc/meson/axg-pdm.c
@@ -586,7 +586,6 @@ static int axg_pdm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axg_pdm *priv;
 	void __iomem *regs;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -611,28 +610,16 @@ static int axg_pdm_probe(struct platform_device *pdev)
 	}
 
 	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get pclk\n");
 
 	priv->dclk = devm_clk_get(dev, "dclk");
-	if (IS_ERR(priv->dclk)) {
-		ret = PTR_ERR(priv->dclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->dclk))
+		return dev_err_probe(dev, PTR_ERR(priv->dclk), "failed to get dclk\n");
 
 	priv->sysclk = devm_clk_get(dev, "sysclk");
-	if (IS_ERR(priv->sysclk)) {
-		ret = PTR_ERR(priv->sysclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->sysclk))
+		return dev_err_probe(dev, PTR_ERR(priv->sysclk), "failed to get dclk\n");
 
 	return devm_snd_soc_register_component(dev, &axg_pdm_component_drv,
 					       &axg_pdm_dai_drv, 1);
diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index 7aaded1fc376b..245189d2ee95f 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -439,7 +439,6 @@ static int axg_spdifin_probe(struct platform_device *pdev)
 	struct axg_spdifin *priv;
 	struct snd_soc_dai_driver *dai_drv;
 	void __iomem *regs;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -464,20 +463,12 @@ static int axg_spdifin_probe(struct platform_device *pdev)
 	}
 
 	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get pclk\n");
 
 	priv->refclk = devm_clk_get(dev, "refclk");
-	if (IS_ERR(priv->refclk)) {
-		ret = PTR_ERR(priv->refclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get mclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->refclk))
+		return dev_err_probe(dev, PTR_ERR(priv->refclk), "failed to get mclk\n");
 
 	dai_drv = axg_spdifin_get_dai_drv(dev, priv);
 	if (IS_ERR(dai_drv)) {
diff --git a/sound/soc/meson/axg-spdifout.c b/sound/soc/meson/axg-spdifout.c
index e769a5ee6e27e..3960d082e1436 100644
--- a/sound/soc/meson/axg-spdifout.c
+++ b/sound/soc/meson/axg-spdifout.c
@@ -403,7 +403,6 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axg_spdifout *priv;
 	void __iomem *regs;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -422,20 +421,12 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 	}
 
 	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get pclk\n");
 
 	priv->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(priv->mclk)) {
-		ret = PTR_ERR(priv->mclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get mclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->mclk))
+		return dev_err_probe(dev, PTR_ERR(priv->mclk), "failed to get mclk\n");
 
 	return devm_snd_soc_register_component(dev, &axg_spdifout_component_drv,
 			axg_spdifout_dai_drv, ARRAY_SIZE(axg_spdifout_dai_drv));
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 4834cfd163c03..63333a2b0a9c3 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -265,7 +265,6 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	const struct axg_tdm_formatter_driver *drv;
 	struct axg_tdm_formatter *formatter;
 	void __iomem *regs;
-	int ret;
 
 	drv = of_device_get_match_data(dev);
 	if (!drv) {
@@ -292,57 +291,34 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 
 	/* Peripharal clock */
 	formatter->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(formatter->pclk)) {
-		ret = PTR_ERR(formatter->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->pclk))
+		return dev_err_probe(dev, PTR_ERR(formatter->pclk), "failed to get pclk\n");
 
 	/* Formatter bit clock */
 	formatter->sclk = devm_clk_get(dev, "sclk");
-	if (IS_ERR(formatter->sclk)) {
-		ret = PTR_ERR(formatter->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->sclk))
+		return dev_err_probe(dev, PTR_ERR(formatter->sclk), "failed to get sclk\n");
 
 	/* Formatter sample clock */
 	formatter->lrclk = devm_clk_get(dev, "lrclk");
-	if (IS_ERR(formatter->lrclk)) {
-		ret = PTR_ERR(formatter->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->lrclk))
+		return dev_err_probe(dev, PTR_ERR(formatter->lrclk), "failed to get lrclk\n");
 
 	/* Formatter bit clock input multiplexer */
 	formatter->sclk_sel = devm_clk_get(dev, "sclk_sel");
-	if (IS_ERR(formatter->sclk_sel)) {
-		ret = PTR_ERR(formatter->sclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk_sel: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->sclk_sel))
+		return dev_err_probe(dev, PTR_ERR(formatter->sclk_sel), "failed to get sclk_sel\n");
 
 	/* Formatter sample clock input multiplexer */
 	formatter->lrclk_sel = devm_clk_get(dev, "lrclk_sel");
-	if (IS_ERR(formatter->lrclk_sel)) {
-		ret = PTR_ERR(formatter->lrclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk_sel: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->lrclk_sel))
+		return dev_err_probe(dev, PTR_ERR(formatter->lrclk_sel),
+				     "failed to get lrclk_sel\n");
 
 	/* Formatter dedicated reset line */
 	formatter->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(formatter->reset)) {
-		ret = PTR_ERR(formatter->reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get reset: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->reset))
+		return dev_err_probe(dev, PTR_ERR(formatter->reset), "failed to get reset\n");
 
 	return devm_snd_soc_register_component(dev, drv->component_drv,
 					       NULL, 0);
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 87cac440b3693..60d132ab1ab78 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -12,6 +12,9 @@
 
 #include "axg-tdm.h"
 
+/* Maximum bit clock frequency according the datasheets */
+#define MAX_SCLK 100000000 /* Hz */
+
 enum {
 	TDM_IFACE_PAD,
 	TDM_IFACE_LOOPBACK,
@@ -155,19 +158,27 @@ static int axg_tdm_iface_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Apply component wide rate symmetry */
 	if (snd_soc_component_active(dai->component)) {
+		/* Apply component wide rate symmetry */
 		ret = snd_pcm_hw_constraint_single(substream->runtime,
 						   SNDRV_PCM_HW_PARAM_RATE,
 						   iface->rate);
-		if (ret < 0) {
-			dev_err(dai->dev,
-				"can't set iface rate constraint\n");
-			return ret;
-		}
+
+	} else {
+		/* Limit rate according to the slot number and width */
+		unsigned int max_rate =
+			MAX_SCLK / (iface->slots * iface->slot_width);
+		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+						   SNDRV_PCM_HW_PARAM_RATE,
+						   0, max_rate);
 	}
 
-	return 0;
+	if (ret < 0)
+		dev_err(dai->dev, "can't set iface rate constraint\n");
+	else
+		ret = 0;
+
+	return ret;
 }
 
 static int axg_tdm_iface_set_stream(struct snd_pcm_substream *substream,
@@ -266,8 +277,8 @@ static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
 	srate = iface->slots * iface->slot_width * params_rate(params);
 
 	if (!iface->mclk_rate) {
-		/* If no specific mclk is requested, default to bit clock * 4 */
-		clk_set_rate(iface->mclk, 4 * srate);
+		/* If no specific mclk is requested, default to bit clock * 2 */
+		clk_set_rate(iface->mclk, 2 * srate);
 	} else {
 		/* Check if we can actually get the bit clock from mclk */
 		if (iface->mclk_rate % srate) {
@@ -517,21 +528,13 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 
 	/* Bit clock provided on the pad */
 	iface->sclk = devm_clk_get(dev, "sclk");
-	if (IS_ERR(iface->sclk)) {
-		ret = PTR_ERR(iface->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(iface->sclk))
+		return dev_err_probe(dev, PTR_ERR(iface->sclk), "failed to get sclk\n");
 
 	/* Sample clock provided on the pad */
 	iface->lrclk = devm_clk_get(dev, "lrclk");
-	if (IS_ERR(iface->lrclk)) {
-		ret = PTR_ERR(iface->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(iface->lrclk))
+		return dev_err_probe(dev, PTR_ERR(iface->lrclk), "failed to get lrclk\n");
 
 	/*
 	 * mclk maybe be missing when the cpu dai is in slave mode and
@@ -542,13 +545,10 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	iface->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(iface->mclk)) {
 		ret = PTR_ERR(iface->mclk);
-		if (ret == -ENOENT) {
+		if (ret == -ENOENT)
 			iface->mclk = NULL;
-		} else {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to get mclk: %d\n", ret);
-			return ret;
-		}
+		else
+			return dev_err_probe(dev, ret, "failed to get mclk\n");
 	}
 
 	return devm_snd_soc_register_component(dev,
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 415cc0046e4b4..23ccd2a720e19 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -85,11 +85,9 @@ int meson_card_parse_dai(struct snd_soc_card *card,
 
 	ret = of_parse_phandle_with_args(node, "sound-dai",
 					 "#sound-dai-cells", 0, &args);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(card->dev, "can't parse dai %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(card->dev, ret, "can't parse dai\n");
+
 	*dai_of_node = args.np;
 
 	return snd_soc_get_dai_name(&args, dai_name);
diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 4c1349dd1e06a..0571549a88206 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -48,7 +48,6 @@
 #define POWER_CFG	0x10
 
 struct t9015 {
-	struct clk *pclk;
 	struct regulator *avdd;
 };
 
@@ -250,6 +249,7 @@ static int t9015_probe(struct platform_device *pdev)
 	struct t9015 *priv;
 	void __iomem *regs;
 	struct regmap *regmap;
+	struct clk *pclk;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -257,31 +257,13 @@ static int t9015_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		if (PTR_ERR(priv->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get core clock\n");
-		return PTR_ERR(priv->pclk);
-	}
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "failed to get core clock\n");
 
 	priv->avdd = devm_regulator_get(dev, "AVDD");
-	if (IS_ERR(priv->avdd)) {
-		if (PTR_ERR(priv->avdd) != -EPROBE_DEFER)
-			dev_err(dev, "failed to AVDD\n");
-		return PTR_ERR(priv->avdd);
-	}
-
-	ret = clk_prepare_enable(priv->pclk);
-	if (ret) {
-		dev_err(dev, "core clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-			(void(*)(void *))clk_disable_unprepare,
-			priv->pclk);
-	if (ret)
-		return ret;
+	if (IS_ERR(priv->avdd))
+		return dev_err_probe(dev, PTR_ERR(priv->avdd), "failed to AVDD\n");
 
 	ret = device_reset(dev);
 	if (ret) {
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 3d4add94e367d..d5409f3879455 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -300,9 +300,12 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
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
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index bdd4d3b12f6c0..afb28fcc66786 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2098,7 +2098,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	int map_fd;
 
 	profile_perf_events = calloc(
-		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
+		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b3509d9d20cc2..b92c26f6aa1d7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1277,8 +1277,8 @@ static int
 record__switch_output(struct record *rec, bool at_exit)
 {
 	struct perf_data *data = &rec->data;
+	char *new_filename = NULL;
 	int fd, err;
-	char *new_filename;
 
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c87f9974c0c10..c19a583ca9f66 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2252,7 +2252,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 24e50fabb6c33..5ed20e1e09aef 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -275,7 +275,7 @@ static void print_metric_only(struct perf_stat_config *config,
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
index 3bdb093731358..637f1b8ec13b4 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -716,12 +716,12 @@ TEST_F(tls, recv_partial)
 
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

