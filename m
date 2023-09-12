Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B579D334
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjILOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjILOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:06:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD810D1;
        Tue, 12 Sep 2023 07:06:25 -0700 (PDT)
X-UUID: 8b8e0048517511eea33bb35ae8d461a2-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8FjUm0hq6mJ/zz6HU8aW+G8Dmx6DmmpLqwpVe6hbI24=;
        b=pHHWWa8JNNjJqTntRo8O7+JeIF5GTkD3CBfDagWMzE2GrgZ+6p504MZziKYbYcplwWEr5SzpZc7Sq/2nKwCzIypmf4d5UTkm7qFnQr52gObluv/n27Xz0zxGItR/fv1llh5+jPC7yb1SmPTm7y24U+cVKWAlz1FiOEFMtKKU+WI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:21e81980-d3aa-4d89-93b7-b80398d898e9,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:30a49cef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8b8e0048517511eea33bb35ae8d461a2-20230912
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 730016540; Tue, 12 Sep 2023 22:06:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 22:06:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 22:06:16 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chris-QJ Chen <chris-qj.chen@mediatek.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: add device-tree for Genio 700 EVK board
Date:   Tue, 12 Sep 2023 22:06:13 +0800
Message-ID: <20230912140613.6528-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230912140613.6528-1-macpaul.lin@mediatek.com>
References: <20230912140613.6528-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.395000-8.000000
X-TMASE-MatchedRID: KEfJ27p7zSmuhCBFl/b63ov73wEu0Nx7+eBf9ovw8I1mAuQLcdQ1EM1F
        WVtFP0e2gjbkBAXhAHgXgxnlx9eOX9B2IIHmvwfAo90M/hchIwbg8xL52+Q82+Cv/NhMM5kIdO+
        /9tNlGWiVMlcqqHWd7Uzyp2gK85W+KeLGzKm/w9KdVNZaI2n6/yhRWQHuJ8meRi9INZ1ZpGEGk2
        pTPAu+98L1MXSgRnEMHAbqPb7+W5WD2tTvn+1nTcdt9cf9BUOgVX7TxgU0dK7N1rLqpIKz45PDb
        ikkMnICga/TkM+bFslR9n9eR6KlvHGjcWW4cazAh2VzUlo4HVOsCj48cLzpmvHFoBcOsKezj+Jv
        xx0kMPncV2eMAQdHRlY02gawggwKXnJwiKaI+/qPmEs8Jfdl0z+COaD3ynve1JVSTP0E9d7GF2N
        b+WjHakrlJSJYAhJJ2vupAEYCWQjhx95Ia5/7CQs9VkfCh3uAKJfSpcAUv12bKItl61J/yUGDDk
        bg1gJkOAawE8JvIaJ5zdAzex5xZo1iRzVXV4Dndoeid/1UHSlpzqGOJ9VFgsXYseIJ5GNlpzl56
        m2FUX6UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.395000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6821DEF7D5B08B4278E48D09E1A29678F73288B15CBC84B68B90457A0BEFA8352000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic device-tree for the Genio 700 EVK board. The
Genio 700 EVK is based on MediaTek MT8390 SoC.
MT8390 hardware register maps are identical to MT8188.

The Genio 700 EVK has following features:

- MT8390 SoC
- MT6365 PMIC
- MT6319 Buck IC
- 12V DC Jack
- 2x4GB LPDDR4X
- 64GB eMMC 5.1
- 64Mb SPI NOR
- M.2 Key A-E slot with PCIe Gen2 and USB 2.0
- 2x DSI LCM ports
- 2x touch sensor ports
- 2x MIPI-CSI, as camera daughter board slots
- USB 2 micro USB connector
- USB 3 with 1 to 2 hub:
  - M.2 Key B slot
  - Type-C connector, with DisplayPort over Type-C
- HDMI 2.0 TX port with Type A HDMI connector
- eDP port
- Gigabit Ethernet with RJ45 connector
- SD card slot
- Earphone Jack
- Analog Microphone
- 2x Digital Microphone
- 3x UART with serial-to-usb converters and micro USB connectors

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 880 ++++++++++++++++++
 2 files changed, 881 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts

dependencies for v1:
 - This patch should be applied after the following patch set
  - mt8365-gneio-350-evk's dts change (v4)
   - https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macpaul.lin@mediatek.com/T/
  - mt8395-genio-1200-evk's dts basic support (v6)
   - https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/
  - mt8188 platform's basic support
   - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 22f362bbbdac..3262849c0f6b 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -54,5 +54,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-genio-350-evk.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
new file mode 100644
index 000000000000..7dbdc3d75724
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -0,0 +1,880 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Author: Chris Chen <chris-qj.chen@mediatek.com>
+ *	   Pablo Sun <pablo.sun@mediatek.com>
+ *	   Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+/dts-v1/;
+
+#include "mt8188.dtsi"
+#include "mt6359.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
+#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/usb/pd.h>
+
+/ {
+	model = "MediaTek Genio-700 EVK";
+	compatible = "mediatek,mt8390-evk", "mediatek,mt8390",
+		     "mediatek,mt8188";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0x2 0x00000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+
+		scp_mem: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: memory@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		apu_mem: memory@55000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x55000000 0 0x1400000>; /* 20 MB */
+		};
+
+		vpu_mem: memory@57000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x57000000 0 0x1400000>; /* 20 MB */
+		};
+	};
+
+	common_fixed_5v: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5v_en";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	edp_panel_fixed_3v3: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "edp_panel_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 15 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_panel_3v3_en_pins>;
+	};
+
+	gpio_fixed_3v3: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "gpio_3v3_en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sdio_fixed_1v8: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "sdio_io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sdio_fixed_3v3: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "sdio_card";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 74 0>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	touch0_fixed_3v3: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_hub_fixed_3v3: regulator-6 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_hub_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 112 0>; /* HUB_3V3_EN */
+		startup-delay-us = <10000>;
+		enable-active-high;
+	};
+
+	usb_hub_reset_1v8: regulator-7 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_hub_reset";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&pio 7 0>; /* HUB_RESET */
+		vin-supply = <&usb_hub_fixed_3v3>;
+	};
+
+	usb_p0_vbus: regulator-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_p0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 84 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator-9 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_p1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p2_vbus: regulator-10 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_p2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt9271";
+		reg = <0x5d>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&pio 6 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&touch0_fixed_3v3>;
+		VDDIO-supply = <&mt6359_vio18_ldo_reg>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c4 {
+	pinctrl-names = "default", "default";
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-1 = <&rt1715_int_pins>;
+	clock-frequency = <1000000>;
+	status = "okay";
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	cap-mmc-hw-reset;
+	no-sdio;
+	no-sd;
+	hs400-ds-delay = <0x1481b>;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	non-removable;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	no-mmc;
+	no-sdio;
+	cd-gpios = <&pio 2 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&mt6359_vpa_buck_reg>;
+	vqmmc-supply = <&mt6359_vsim1_ldo_reg>;
+};
+
+&mt6359_vbbck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcn18_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcn33_2_bt_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcore_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vpa_buck_reg {
+	regulator-max-microvolt = <3100000>;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsim1_ldo_reg {
+	regulator-enable-ramp-delay = <480>;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359codec {
+	mediatek,mic-type-0 = <1>; /* ACC */
+	mediatek,mic-type-1 = <3>; /* DCC */
+};
+
+&pio {
+	audio_default_pins: audio-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO101__FUNC_O_AUD_CLK_MOSI>,
+				 <PINMUX_GPIO102__FUNC_O_AUD_SYNC_MOSI>,
+				 <PINMUX_GPIO103__FUNC_O_AUD_DAT_MOSI0>,
+				 <PINMUX_GPIO104__FUNC_O_AUD_DAT_MOSI1>,
+				 <PINMUX_GPIO105__FUNC_I0_AUD_DAT_MISO0>,
+				 <PINMUX_GPIO106__FUNC_I0_AUD_DAT_MISO1>,
+				 <PINMUX_GPIO107__FUNC_B0_I2SIN_MCK>,
+				 <PINMUX_GPIO108__FUNC_B0_I2SIN_BCK>,
+				 <PINMUX_GPIO109__FUNC_B0_I2SIN_WS>,
+				 <PINMUX_GPIO110__FUNC_I0_I2SIN_D0>,
+				 <PINMUX_GPIO114__FUNC_O_I2SO2_MCK>,
+				 <PINMUX_GPIO115__FUNC_B0_I2SO2_BCK>,
+				 <PINMUX_GPIO116__FUNC_B0_I2SO2_WS>,
+				 <PINMUX_GPIO117__FUNC_O_I2SO2_D0>,
+				 <PINMUX_GPIO118__FUNC_O_I2SO2_D1>,
+				 <PINMUX_GPIO121__FUNC_B0_PCM_CLK>,
+				 <PINMUX_GPIO122__FUNC_B0_PCM_SYNC>,
+				 <PINMUX_GPIO124__FUNC_I0_PCM_DI>,
+				 <PINMUX_GPIO125__FUNC_O_DMIC1_CLK>,
+				 <PINMUX_GPIO126__FUNC_I0_DMIC1_DAT>,
+				 <PINMUX_GPIO128__FUNC_O_DMIC2_CLK>,
+				 <PINMUX_GPIO129__FUNC_I0_DMIC2_DAT>;
+		};
+	};
+
+	dptx_pins: dptx-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO46__FUNC_I0_DP_TX_HPD>;
+			bias-pull-up;
+		};
+	};
+
+	edp_panel_3v3_en_pins: edp-panel-3v3-en-pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO15__FUNC_B_GPIO15>;
+			output-high;
+		};
+	};
+
+	eth_default_pins: eth-default-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO139__FUNC_B0_GBE_TXC>,
+				 <PINMUX_GPIO140__FUNC_I0_GBE_RXC>,
+				 <PINMUX_GPIO141__FUNC_I0_GBE_RXDV>,
+				 <PINMUX_GPIO142__FUNC_O_GBE_TXEN>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO143__FUNC_O_GBE_MDC>,
+				 <PINMUX_GPIO144__FUNC_B1_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO145__FUNC_B_GPIO145>,
+				 <PINMUX_GPIO146__FUNC_B_GPIO146>;
+			output-high;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO135__FUNC_I0_GBE_RXD3>,
+				 <PINMUX_GPIO136__FUNC_I0_GBE_RXD2>,
+				 <PINMUX_GPIO137__FUNC_I0_GBE_RXD1>,
+				 <PINMUX_GPIO138__FUNC_I0_GBE_RXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-txd {
+			pinmux = <PINMUX_GPIO131__FUNC_O_GBE_TXD3>,
+				 <PINMUX_GPIO132__FUNC_O_GBE_TXD2>,
+				 <PINMUX_GPIO133__FUNC_O_GBE_TXD1>,
+				 <PINMUX_GPIO134__FUNC_O_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+	};
+
+	eth_sleep_pins: eth-sleep-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO139__FUNC_B_GPIO139>,
+				 <PINMUX_GPIO140__FUNC_B_GPIO140>,
+				 <PINMUX_GPIO141__FUNC_B_GPIO141>,
+				 <PINMUX_GPIO142__FUNC_B_GPIO142>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO143__FUNC_B_GPIO143>,
+				 <PINMUX_GPIO144__FUNC_B_GPIO144>;
+			input-disable;
+			bias-disable;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO135__FUNC_B_GPIO135>,
+				 <PINMUX_GPIO136__FUNC_B_GPIO136>,
+				 <PINMUX_GPIO137__FUNC_B_GPIO137>,
+				 <PINMUX_GPIO138__FUNC_B_GPIO138>;
+		};
+
+		pins-txd {
+			pinmux = <PINMUX_GPIO131__FUNC_B_GPIO131>,
+				 <PINMUX_GPIO132__FUNC_B_GPIO132>,
+				 <PINMUX_GPIO133__FUNC_B_GPIO133>,
+				 <PINMUX_GPIO134__FUNC_B_GPIO134>;
+		};
+	};
+
+	i2c0_pins: i2c0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>,
+				 <PINMUX_GPIO55__FUNC_B1_SCL0>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO58__FUNC_B1_SDA1>,
+				 <PINMUX_GPIO57__FUNC_B1_SCL1>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pins {
+			pinmux = <PINMUX_GPIO60__FUNC_B1_SDA2>,
+				 <PINMUX_GPIO59__FUNC_B1_SCL2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins {
+			pinmux = <PINMUX_GPIO62__FUNC_B1_SDA3>,
+				 <PINMUX_GPIO61__FUNC_B1_SCL3>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		pins {
+			pinmux = <PINMUX_GPIO64__FUNC_B1_SDA4>,
+				 <PINMUX_GPIO63__FUNC_B1_SCL4>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c5_pins: i2c5-pins {
+		pins {
+			pinmux = <PINMUX_GPIO66__FUNC_B1_SDA5>,
+				 <PINMUX_GPIO65__FUNC_B1_SCL5>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins {
+			pinmux = <PINMUX_GPIO68__FUNC_B1_SDA6>,
+				 <PINMUX_GPIO67__FUNC_B1_SCL6>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	gpio_key_pins: gpio-key-pins {
+		pins {
+			pinmux = <PINMUX_GPIO42__FUNC_B1_KPCOL0>,
+				 <PINMUX_GPIO43__FUNC_B1_KPCOL1>,
+				 <PINMUX_GPIO44__FUNC_B1_KPROW0>;
+		};
+	};
+
+	mmc0_default_pins: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
+				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
+				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
+				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
+				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
+				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
+				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
+				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
+				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
+				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
+				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
+				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
+				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
+				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
+				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
+				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
+				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_default_pins: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO164__FUNC_B1_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO163__FUNC_B1_MSDC1_CMD>,
+				 <PINMUX_GPIO165__FUNC_B1_MSDC1_DAT0>,
+				 <PINMUX_GPIO166__FUNC_B1_MSDC1_DAT1>,
+				 <PINMUX_GPIO167__FUNC_B1_MSDC1_DAT2>,
+				 <PINMUX_GPIO168__FUNC_B1_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_B_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO164__FUNC_B1_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO163__FUNC_B1_MSDC1_CMD>,
+				 <PINMUX_GPIO165__FUNC_B1_MSDC1_DAT0>,
+				 <PINMUX_GPIO166__FUNC_B1_MSDC1_DAT1>,
+				 <PINMUX_GPIO167__FUNC_B1_MSDC1_DAT2>,
+				 <PINMUX_GPIO168__FUNC_B1_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc2_default_pins: mmc2-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO170__FUNC_B1_MSDC2_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO169__FUNC_B1_MSDC2_CMD>,
+				 <PINMUX_GPIO171__FUNC_B1_MSDC2_DAT0>,
+				 <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>,
+				 <PINMUX_GPIO173__FUNC_B1_MSDC2_DAT2>,
+				 <PINMUX_GPIO174__FUNC_B1_MSDC2_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-pcm {
+			pinmux = <PINMUX_GPIO123__FUNC_O_PCM_DO>;
+		};
+	};
+
+	mmc2_uhs_pins: mmc2-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO170__FUNC_B1_MSDC2_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO169__FUNC_B1_MSDC2_CMD>,
+				 <PINMUX_GPIO171__FUNC_B1_MSDC2_DAT0>,
+				 <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>,
+				 <PINMUX_GPIO173__FUNC_B1_MSDC2_DAT2>,
+				 <PINMUX_GPIO174__FUNC_B1_MSDC2_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc2_eint_pins: mmc2-eint-pins {
+		pins-dat1 {
+			pinmux = <PINMUX_GPIO172__FUNC_B_GPIO172>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc2_dat1_pins: mmc2-dat1-pins {
+		pins-dat1 {
+			pinmux = <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	panel_default_pins: panel-default-pins {
+		pins-dcdc {
+			pinmux = <PINMUX_GPIO45__FUNC_B_GPIO45>;
+			output-low;
+		};
+
+		pins-en {
+			pinmux = <PINMUX_GPIO111__FUNC_B_GPIO111>;
+			output-low;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO25__FUNC_B_GPIO25>;
+			output-high;
+		};
+	};
+
+	rt1715_int_pins: rt1715-int-pins {
+		pins_cmd0_dat {
+			pinmux = <PINMUX_GPIO12__FUNC_B_GPIO12>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	spi0_pins: spi0-pins {
+		pins-spi {
+			pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
+				<PINMUX_GPIO70__FUNC_O_SPIM0_CLK>,
+				<PINMUX_GPIO71__FUNC_B0_SPIM0_MOSI>,
+				<PINMUX_GPIO72__FUNC_B0_SPIM0_MISO>;
+			bias-disable;
+		};
+	};
+
+	spi1_pins: spi1-pins {
+		pins-spi {
+			pinmux = <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
+				<PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
+				<PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
+				<PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
+			bias-disable;
+		};
+	};
+
+	spi2_pins: spi2-pins {
+		pins-spi {
+			pinmux = <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
+				<PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
+				<PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
+				<PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
+			bias-disable;
+		};
+	};
+
+	touch_pins: touch-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO6__FUNC_B_GPIO6>;
+			input-enable;
+			bias-disable;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO5__FUNC_B_GPIO5>;
+			output-high;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO31__FUNC_O_UTXD0>,
+				 <PINMUX_GPIO32__FUNC_I1_URXD0>;
+			bias-pull-up;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO33__FUNC_O_UTXD1>,
+				 <PINMUX_GPIO34__FUNC_I1_URXD1>;
+			bias-pull-up;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins {
+			pinmux = <PINMUX_GPIO35__FUNC_O_UTXD2>,
+				 <PINMUX_GPIO36__FUNC_I1_URXD2>;
+			bias-pull-up;
+		};
+	};
+
+	usb_default_pins: usb-default-pins {
+		pins-iddig {
+			pinmux = <PINMUX_GPIO83__FUNC_B_GPIO83>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-valid {
+			pinmux = <PINMUX_GPIO85__FUNC_I0_VBUSVALID>;
+			input-enable;
+		};
+
+		pins-vbus {
+			pinmux = <PINMUX_GPIO84__FUNC_O_USB_DRVVBUS>;
+			output-high;
+		};
+
+	};
+
+	usb1_default_pins: usb1-default-pins {
+		pins-valid {
+			pinmux = <PINMUX_GPIO88__FUNC_I0_VBUSVALID_1P>;
+			input-enable;
+		};
+
+		pins-usb-hub-3v3-en {
+			pinmux = <PINMUX_GPIO112__FUNC_B_GPIO112>;
+			output-high;
+		};
+	};
+
+	wifi_pwrseq_pins: wifi-pwrseq-pins {
+		pins-wifi-enable {
+			pinmux = <PINMUX_GPIO127__FUNC_B_GPIO127>;
+			output-low;
+		};
+	};
+};
+
+&pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&scp {
+	memory-region = <&scp_mem>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-0 = <&spi2_pins>;
+	pinctrl-names = "default";
+	mediatek,pad-select = <0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+};
+
+&xhci1 {
+	status = "okay";
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&usb_hub_reset_1v8>;
+};
+
+&xhci2 {
+	status = "okay";
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+};
-- 
2.18.0

