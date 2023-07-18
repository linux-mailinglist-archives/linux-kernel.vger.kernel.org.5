Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9184B757A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjGRLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjGRLKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:10:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B51703;
        Tue, 18 Jul 2023 04:10:05 -0700 (PDT)
X-UUID: a3daf1a6255b11ee9cb5633481061a41-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1v9RzcfOmboXWRzv6dmWHVzTWoc8pJQTHi5XeA8e+Uw=;
        b=P0jesnYxA8u6tsK2QDoX23ifs+BUURt8xr1mwV0W7bAxeRYHbuHdFG3vRYfHz8qzrL0fEDQdXmqFsrBFYQquRhCzNv/JdlCJ7Whkcdp9TQhP2bWQiZxnmSMpIrhbxHAG51Wcw12lfrJlzqGHxhVP+ZbNIfi+miMLIIaG8vL61/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:04b927ce-3324-403b-abe7-a7c3a3e096ec,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:176cd25,CLOUDID:bf78c187-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a3daf1a6255b11ee9cb5633481061a41-20230718
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 294230315; Tue, 18 Jul 2023 19:10:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 19:10:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 19:10:00 +0800
From:   Jason-ch Chen <jason-ch.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        jason-ch chen <Jason-ch.Chen@mediatek.com>
Subject: [PATCH v4 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makefile
Date:   Tue, 18 Jul 2023 19:09:47 +0800
Message-ID: <20230718110947.13426-5-jason-ch.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230718110947.13426-1-jason-ch.chen@mediatek.com>
References: <20230718110947.13426-1-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jason-ch chen <Jason-ch.Chen@mediatek.com>

MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.

We add basic chip support for MediaTek MT8188 on evaluation board.

Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 400 ++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 951 ++++++++++++++++++++
 3 files changed, 1352 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c99c3372a4b5..9bd2324259a3 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
new file mode 100644
index 000000000000..ad71a0e1ad41
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ */
+/dts-v1/;
+#include "mt8188.dtsi"
+#include "mt6359.dtsi"
+
+/ {
+	model = "MediaTek MT8188 evaluation board";
+	compatible = "mediatek,mt8188-evb", "mediatek,mt8188";
+
+	aliases {
+		serial0 = &uart0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		mmc0 = &mmc0;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scp_mem_reserved: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
+};
+
+&auxadc {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	clock-frequency = <400000>;
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
+&mt6359_vbbck_ldo_reg {
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
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
+};
+
+&nor_flash {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+	};
+};
+
+&pio {
+	adsp_uart_pins: adsp-uart-pins {
+		pins-adsp-uart {
+			pinmux = <PINMUX_GPIO35__FUNC_O_ADSP_UTXD0>,
+				 <PINMUX_GPIO36__FUNC_I1_ADSP_URXD0>;
+		};
+	};
+
+	i2c0_pins: i2c0-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>,
+				 <PINMUX_GPIO55__FUNC_B1_SCL0>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO58__FUNC_B1_SDA1>,
+				 <PINMUX_GPIO57__FUNC_B1_SCL1>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO60__FUNC_B1_SDA2>,
+				 <PINMUX_GPIO59__FUNC_B1_SCL2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO62__FUNC_B1_SDA3>,
+				 <PINMUX_GPIO61__FUNC_B1_SCL3>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO64__FUNC_B1_SDA4>,
+				 <PINMUX_GPIO63__FUNC_B1_SCL4>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	i2c5_pins: i2c5-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO66__FUNC_B1_SDA5>,
+				 <PINMUX_GPIO65__FUNC_B1_SCL5>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO68__FUNC_B1_SDA6>,
+				 <PINMUX_GPIO67__FUNC_B1_SCL6>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	mmc0_default_pins: mmc0-default-pins {
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
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
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
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	nor_pins_default: nor-pins {
+		pins0 {
+			pinmux = <PINMUX_GPIO127__FUNC_B0_SPINOR_IO0>,
+				 <PINMUX_GPIO125__FUNC_O_SPINOR_CK>,
+				 <PINMUX_GPIO128__FUNC_B0_SPINOR_IO1>;
+			bias-pull-down;
+		};
+
+		pins1 {
+			pinmux = <PINMUX_GPIO126__FUNC_O_SPINOR_CS>,
+				 <PINMUX_GPIO129__FUNC_B0_SPINOR_IO2>,
+				 <PINMUX_GPIO130__FUNC_B0_SPINOR_IO3>;
+			bias-pull-up;
+		};
+	};
+
+	spi0_pins: spi0-pins {
+		pins-spi {
+			pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
+				 <PINMUX_GPIO70__FUNC_O_SPIM0_CLK>,
+				 <PINMUX_GPIO71__FUNC_B0_SPIM0_MOSI>,
+				 <PINMUX_GPIO72__FUNC_B0_SPIM0_MISO>;
+			bias-disable;
+		};
+	};
+
+	spi1_pins: spi1-pins {
+		pins-spi {
+			pinmux = <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
+				 <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
+				 <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
+				 <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
+			bias-disable;
+		};
+	};
+
+	spi2_pins: spi2-pins {
+		pins-spi {
+			pinmux = <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
+				 <PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
+				 <PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
+				 <PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
+			bias-disable;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins-uart0 {
+			pinmux = <PINMUX_GPIO31__FUNC_O_UTXD0>,
+				 <PINMUX_GPIO32__FUNC_I1_URXD0>;
+			bias-pull-up;
+		};
+	};
+};
+
+&pmic {
+	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&scp {
+	memory-region = <&scp_mem_reserved>;
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins>;
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
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+};
+
+&xhci1 {
+	status = "okay";
+};
+
+&xhci2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
new file mode 100644
index 000000000000..37343297e392
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -0,0 +1,951 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ *
+ */
+
+/dts-v1/;
+#include <dt-bindings/clock/mediatek,mt8188-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
+#include <dt-bindings/power/mediatek,mt8188-power.h>
+
+/ {
+	compatible = "mediatek,mt8188";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x000>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x600>;
+			enable-method = "psci";
+			clock-frequency = <2600000000>;
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x700>;
+			enable-method = "psci";
+			clock-frequency = <2600000000>;
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+
+				core4 {
+					cpu = <&cpu4>;
+				};
+
+				core5 {
+					cpu = <&cpu5>;
+				};
+
+				core6 {
+					cpu = <&cpu6>;
+				};
+
+				core7 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_off_l: cpu-off-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <50>;
+				exit-latency-us = <95>;
+				min-residency-us = <580>;
+			};
+
+			cpu_off_b: cpu-off-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <45>;
+				exit-latency-us = <140>;
+				min-residency-us = <740>;
+			};
+
+			cluster_off_l: cluster-off-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010010>;
+				local-timer-stop;
+				entry-latency-us = <55>;
+				exit-latency-us = <155>;
+				min-residency-us = <840>;
+			};
+
+			cluster_off_b: cluster-off-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010010>;
+				local-timer-stop;
+				entry-latency-us = <50>;
+				exit-latency-us = <200>;
+				min-residency-us = <1000>;
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-unified;
+		};
+	};
+
+	clk13m: oscillator-13m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <13000000>;
+		clock-output-names = "clk13m";
+	};
+
+	clk26m: oscillator-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	clk32k: oscillator-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "clk32k";
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
+	};
+
+	pmu-a78 {
+		compatible = "arm,cortex-a78-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+		clock-frequency = <13000000>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#redistributor-regions = <1>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x40000>,
+			      <0 0x0c040000 0 0x200000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu6 &cpu7>;
+				};
+			};
+		};
+
+		topckgen: syscon@10000000 {
+			compatible = "mediatek,mt8188-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg_ao: syscon@10001000 {
+			compatible = "mediatek,mt8188-infracfg-ao", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg: syscon@10003000 {
+			compatible = "mediatek,mt8188-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt8188-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11c00000 0 0x1000>,
+			      <0 0x11e10000 0 0x1000>,
+			      <0 0x11e20000 0 0x1000>,
+			      <0 0x11ea0000 0 0x1000>,
+			      <0 0x1000b000 0 0x1000>;
+			reg-names = "iocfg0", "iocfg_rm",
+				    "iocfg_lt", "iocfg_lm", "iocfg_rt",
+				    "eint";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 176>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH 0>;
+			#interrupt-cells = <2>;
+		};
+
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8188-wdt";
+			mediatek,disable-extrst;
+			reg = <0 0x10007000 0 0x100>;
+			#reset-cells = <1>;
+		};
+
+		apmixedsys: syscon@1000c000 {
+			compatible = "mediatek,mt8188-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		systimer: timer@10017000 {
+			compatible = "mediatek,mt8188-timer", "mediatek,mt6765-timer";
+			reg = <0 0x10017000 0 0x1000>;
+			reg-names = "sys_timer_base";
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk13m>;
+		};
+
+		pwrap: pwrap@10024000 {
+			compatible = "mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap", "syscon";
+			reg = <0 0x10024000 0 0x1000>;
+			reg-names = "pwrap";
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
+				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>;
+			clock-names = "spi", "wrap";
+		};
+
+		scp: scp@10500000 {
+			compatible = "mediatek,mt8188-scp";
+			reg = <0 0x10500000 0 0x100000>,
+			      <0 0x10720000 0 0xe0000>;
+			reg-names = "sram", "cfg";
+			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		adsp_audio26m: clock-controller@10b91100 {
+			compatible = "mediatek,mt8188-adsp-audio26m";
+			reg = <0 0x10b91100 0 0x100>;
+			#clock-cells = <1>;
+		};
+
+		uart0: serial@11001100 {
+			compatible = "mediatek,mt8188-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001100 0 0x100>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART0>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart1: serial@11001200 {
+			compatible = "mediatek,mt8188-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001200 0 0x100>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART1>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart2: serial@11001300 {
+			compatible = "mediatek,mt8188-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001300 0 0x100>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART2>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart3: serial@11001400 {
+			compatible = "mediatek,mt8188-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001400 0 0x100>;
+			interrupts = <GIC_SPI 723 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART3>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		auxadc: adc@11002000 {
+			compatible = "mediatek,mt8188-auxadc", "mediatek,mt8173-auxadc";
+			reg = <0 0x11002000 0 0x1000>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_AUXADC>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		pericfg_ao: syscon@11003000 {
+			compatible = "mediatek,mt8188-pericfg-ao", "syscon";
+			reg = <0 0x11003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		spi0: spi@1100a000 {
+			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI0>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi1: spi@11010000 {
+			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11010000 0 0x1000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI1>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi2: spi@11012000 {
+			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11012000 0 0x1000>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI2>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi3: spi@11013000 {
+			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11013000 0 0x1000>;
+			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI3>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi4: spi@11018000 {
+			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11018000 0 0x1000>;
+			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI4>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi5: spi@11019000 {
+			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11019000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI5>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		xhci1: usb@11200000 {
+			compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x1000>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port1 PHY_TYPE_USB2>,
+			       <&u3port1 PHY_TYPE_USB3>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_BUS>,
+				 <&topckgen CLK_TOP_SSUSB_TOP_REF>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x468 2>;
+			wakeup-source;
+			status = "disabled";
+		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8188-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11230000 0 0x10000>,
+			      <0 0x11f50000 0 0x1000>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_MSDC50_0>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>,
+				 <&infracfg_ao CLK_INFRA_AO_RG_AES_MSDCFDE_CK_0P>;
+			clock-names = "source", "hclk", "source_cg", "crypto_clk";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8188-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11240000 0 0x1000>,
+			      <0 0x11eb0000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_MSDC30_1>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC1>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC1_SRC>;
+			clock-names = "source", "hclk", "source_cg";
+			assigned-clocks = <&topckgen CLK_TOP_MSDC30_1>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@11280000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11280000 0 0x1000>,
+			      <0 0x10220080 0 0x80>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_c CLK_IMP_IIC_WRAP_C_AP_CLOCK_I2C0>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_BCLK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@11281000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11281000 0 0x1000>,
+			      <0 0x10220180 0 0x80>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_c CLK_IMP_IIC_WRAP_C_AP_CLOCK_I2C2>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_BCLK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@11282000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11282000 0 0x1000>,
+			      <0 0x10220280 0 0x80>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_c CLK_IMP_IIC_WRAP_C_AP_CLOCK_I2C3>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_BCLK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		imp_iic_wrap_c: clock-controller@11283000 {
+			compatible = "mediatek,mt8188-imp-iic-wrap-c";
+			reg = <0 0x11283000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		xhci2: usb@112a0000 {
+			compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x112a0000 0 0x1000>,
+			      <0 0x112a3e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_3P>,
+					  <&topckgen CLK_TOP_USB_TOP_3P>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
+				 <&topckgen CLK_TOP_SSUSB_TOP_P3_REF>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck";
+			status = "disabled";
+		};
+
+		xhci0: usb@112b0000 {
+			compatible = "mediatek,mt8188-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x112b0000 0 0x1000>,
+			      <0 0x112b3e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port0 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_SSUSB_XHCI_2P>,
+					  <&topckgen CLK_TOP_USB_TOP_2P>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
+				 <&topckgen CLK_TOP_SSUSB_TOP_P2_REF>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x460 2>;
+			wakeup-source;
+			status = "disabled";
+		};
+
+		nor_flash: spi@1132c000 {
+			compatible = "mediatek,mt8188-nor", "mediatek,mt8186-nor";
+			reg = <0 0x1132c000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_SPINOR>,
+				 <&pericfg_ao CLK_PERI_AO_FLASHIFLASHCK>,
+				 <&pericfg_ao CLK_PERI_AO_FLASHIF_BUS>;
+			clock-names = "spi", "sf", "axi";
+			assigned-clocks = <&topckgen CLK_TOP_SPINOR>;
+			interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@11e00000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11e00000 0 0x1000>,
+			      <0 0x10220100 0 0x80>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_AP_CLOCK_I2C1>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_BCLK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@11e01000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11e01000 0 0x1000>,
+			      <0 0x10220380 0 0x80>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_AP_CLOCK_I2C4>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_BCLK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		imp_iic_wrap_w: clock-controller@11e02000 {
+			compatible = "mediatek,mt8188-imp-iic-wrap-w";
+			reg = <0 0x11e02000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		u3phy0: t-phy@11e30000 {
+			compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x11e30000 0x1000>;
+			status = "disabled";
+
+			u2port0: usb-phy@0 {
+				reg = <0x0 0x700>;
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P2_REF>,
+					 <&apmixedsys CLK_APMIXED_PLL_SSUSB26M_EN>;
+				clock-names = "ref", "da_ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u3phy1: t-phy@11e40000 {
+			compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x11e40000 0x1000>;
+			status = "disabled";
+
+			u2port1: usb-phy@0 {
+				reg = <0x0 0x700>;
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_REF>,
+					 <&apmixedsys CLK_APMIXED_PLL_SSUSB26M_EN>;
+				clock-names = "ref", "da_ref";
+				#phy-cells = <1>;
+			};
+
+			u3port1: usb-phy@700 {
+				reg = <0x700 0x700>;
+				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M_EN>,
+					 <&clk26m>;
+				clock-names = "ref", "da_ref";
+				#phy-cells = <1>;
+				status = "disabled";
+			};
+		};
+
+		u3phy2: t-phy@11e80000 {
+			compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x11e80000 0x1000>;
+			status = "disabled";
+
+			u2port2: usb-phy@0 {
+				reg = <0x0 0x700>;
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P3_REF>,
+					 <&apmixedsys CLK_APMIXED_PLL_SSUSB26M_EN>;
+				clock-names = "ref", "da_ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		i2c5: i2c@11ec0000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11ec0000 0 0x1000>,
+			      <0 0x10220480 0 0x80>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_en CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C5>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_BCLK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@11ec1000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11ec1000 0 0x1000>,
+			      <0 0x10220600 0 0x80>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_en CLK_IMP_IIC_WRAP_EN_AP_CLOCK_I2C6>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_BCLK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		imp_iic_wrap_en: clock-controller@11ec2000 {
+			compatible = "mediatek,mt8188-imp-iic-wrap-en";
+			reg = <0 0x11ec2000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mfgcfg: clock-controller@13fbf000 {
+			compatible = "mediatek,mt8188-mfgcfg";
+			reg = <0 0x13fbf000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vppsys0: clock-controller@14000000 {
+			compatible = "mediatek,mt8188-vppsys0";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		wpesys: clock-controller@14e00000 {
+			compatible = "mediatek,mt8188-wpesys";
+			reg = <0 0x14e00000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		wpesys_vpp0: clock-controller@14e02000 {
+			compatible = "mediatek,mt8188-wpesys-vpp0";
+			reg = <0 0x14e02000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vppsys1: clock-controller@14f00000 {
+			compatible = "mediatek,mt8188-vppsys1";
+			reg = <0 0x14f00000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys: clock-controller@15000000 {
+			compatible = "mediatek,mt8188-imgsys";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys1_dip_top: clock-controller@15110000 {
+			compatible = "mediatek,mt8188-imgsys1-dip-top";
+			reg = <0 0x15110000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys1_dip_nr: clock-controller@15130000 {
+			compatible = "mediatek,mt8188-imgsys1-dip-nr";
+			reg = <0 0x15130000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys_wpe1: clock-controller@15220000 {
+			compatible = "mediatek,mt8188-imgsys-wpe1";
+			reg = <0 0x15220000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipesys: clock-controller@15330000 {
+			compatible = "mediatek,mt8188-ipesys";
+			reg = <0 0x15330000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys_wpe2: clock-controller@15520000 {
+			compatible = "mediatek,mt8188-imgsys-wpe2";
+			reg = <0 0x15520000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys_wpe3: clock-controller@15620000 {
+			compatible = "mediatek,mt8188-imgsys-wpe3";
+			reg = <0 0x15620000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys: clock-controller@16000000 {
+			compatible = "mediatek,mt8188-camsys";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawa: clock-controller@1604f000 {
+			compatible = "mediatek,mt8188-camsys-rawa";
+			reg = <0 0x1604f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_yuva: clock-controller@1606f000 {
+			compatible = "mediatek,mt8188-camsys-yuva";
+			reg = <0 0x1606f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawb: clock-controller@1608f000 {
+			compatible = "mediatek,mt8188-camsys-rawb";
+			reg = <0 0x1608f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_yuvb: clock-controller@160af000 {
+			compatible = "mediatek,mt8188-camsys-yuvb";
+			reg = <0 0x160af000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ccusys: clock-controller@17200000 {
+			compatible = "mediatek,mt8188-ccusys";
+			reg = <0 0x17200000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys_soc: clock-controller@1800f000 {
+			compatible = "mediatek,mt8188-vdecsys-soc";
+			reg = <0 0x1800f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys: clock-controller@1802f000 {
+			compatible = "mediatek,mt8188-vdecsys";
+			reg = <0 0x1802f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys: clock-controller@1a000000 {
+			compatible = "mediatek,mt8188-vencsys";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
2.18.0

