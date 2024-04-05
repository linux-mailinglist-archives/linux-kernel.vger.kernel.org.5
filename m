Return-Path: <linux-kernel+bounces-132803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C8C899A71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4025284B01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A39161912;
	Fri,  5 Apr 2024 10:14:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388AC161339
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312071; cv=none; b=C4bTR9AxyRevsu7ZDz1CUci0giZ3CNpto3AveesRKjfd26+aU0G/BVYrYbdeySxuDpQpJE3xnBeOXdoQS6hivZqO4EKt0ptTJsp/dmYrJc5C3qrrRraHmt9FU4fPaNNCFAOSpRE7I/UnMivq93nkg6nlzjFDO6lDZhU6/rGECc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312071; c=relaxed/simple;
	bh=+xKOajsc2Izq55sVeKrU1ybNlqYAvE/aWZh9mmJq/uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/TEY4kpKyYPW4XA8ieGRLClApq351v8KChUWUzQgQq8G0mcMd8J7tpcUM+83wXkpO/LMGr0sp7OLBEaSl5BUF23+UsbiVnzu0KkDu929n2g6R2936VVrqcYxXr4sS6bCHbyItu4Dzj/ur/2Z9+4tPOMgUFxxQ3InwYcA1TCd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rsgaY-0008Kv-R3; Fri, 05 Apr 2024 12:14:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rsgaY-00AY5F-3L; Fri, 05 Apr 2024 12:14:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rsgaY-00AhER-05;
	Fri, 05 Apr 2024 12:14:26 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 05 Apr 2024 12:14:26 +0200
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add Protonic MECSBC
 device-tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-protonic-mecsbc-v2-2-0a6fedc78b9f@pengutronix.de>
References: <20240405-protonic-mecsbc-v2-0-0a6fedc78b9f@pengutronix.de>
In-Reply-To: <20240405-protonic-mecsbc-v2-0-0a6fedc78b9f@pengutronix.de>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Jander <david@protonic.nl>, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712312066; l=9611;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=AmaeLU460BkqowyJgoyxOdzI89kg/HGa+2cLnp5Pl6E=;
 b=bRaZVrWcdPo/Rz4TGl2WFBEDp0SAnVr2Exp4PkkbFfC6MNpM5/F63L6SxEQzi1xi7vAtN1td/
 FtOra7YusyqDjMA4i6tH0YFqWrDIQFfg5CkfLgsRdTRcD3aqcgeJNvk
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

MECSBC is a single board computer for blood analysis machines from
RR-Mechatronics, designed and manufactured by Protonic Holland, based on
the Rockchip RK3568 SoC.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/rockchip/Makefile          |   1 +
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 404 +++++++++++++++++++++++++
 2 files changed, 405 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index f906a868b71ac..51c242c462b04 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r68s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-mecsbc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
new file mode 100644
index 0000000000000..edd54c5932337
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "rk3568.dtsi"
+
+/ {
+	model = "Protonic MECSBC";
+	compatible = "prt,mecsbc", "rockchip,rk3568";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	tas2562-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Speaker";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&tas2562>;
+		};
+	};
+
+	vdd_gpu: regulator-vdd-gpu {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 5000 PWM_POLARITY_INVERTED>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <915000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-settling-time-up-us = <250>;
+		pwm-dutycycle-range = <0 100>; /* dutycycle inverted 0% => 0.915V */
+	};
+
+	vcc_sd: regulator-sd {
+		compatible = "regulator-gpio";
+		enable-gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		regulator-name = "sdcard-gpio-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <1800000 0x1>, <3300000 0x0>;
+	};
+
+	vdd_npu: regulator-vdd-npu {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 5000 PWM_POLARITY_INVERTED>;
+		regulator-name = "vdd_npu";
+		regulator-min-microvolt = <915000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-settling-time-up-us = <250>;
+		pwm-dutycycle-range = <0 100>; /* dutycycle inverted 0% => 0.915V */
+	};
+
+	p3v3: regulator-p3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "p3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	p1v8: regulator-p1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "p1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&combphy2 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-id";
+	clock_in_out = "output";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_clkinout
+		     &gmac1m1_rgmii_bus>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@60 {
+		compatible = "fcs,fan53555";
+		reg = <0x60>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2m0_xfer>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3m0_xfer>;
+	status = "okay";
+
+	tas2562: amplifier@4c {
+		compatible = "ti,tas2562";
+		reg = <0x4c>;
+		#sound-dai-cells = <0>;
+		shutdown-gpios = <&gpio1 RK_PD4 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tas2562>;
+		interrupts = <RK_PD1 IRQ_TYPE_LEVEL_LOW>;
+		ti,imon-slot-no = <0>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp1075";
+		reg = <0x48>;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf85363";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-output-names = "rtcic_32kout";
+	};
+};
+
+&i2s1_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx &i2s1m0_lrcktx &i2s1m0_sdi0 &i2s1m0_sdo0>;
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eth_phy1_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie20m1_pins>;
+	reset-gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x2m1_pins>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&p3v3>;
+	status = "okay";
+};
+
+&pinctrl {
+	ethernet {
+		eth_phy1_rst: eth-phy1-rst {
+			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	tas2562 {
+		pinctrl_tas2562: tas2562 {
+			rockchip,pins = <1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&p3v3>;
+	pmuio2-supply = <&p3v3>;
+	vccio1-supply = <&p1v8>;
+	vccio2-supply = <&p1v8>;
+	vccio3-supply = <&vcc_sd>;
+	vccio4-supply = <&p1v8>;
+	vccio5-supply = <&p3v3>;
+	vccio6-supply = <&p1v8>;
+	vccio7-supply = <&p3v3>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&p1v8>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	vmmc-supply = <&p3v3>;
+	vqmmc-supply = <&p1v8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&p3v3>;
+	vqmmc-supply = <&vcc_sd>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	status = "okay";
+	dr_mode = "host";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	status = "okay";
+};
+
+&usb2phy1_otg {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1m0_pins>;
+};
+
+&pwm2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2m0_pins>;
+};
+
+&gpu_opp_table {
+	compatible = "operating-points-v2";
+
+	opp-200000000 {
+		opp-hz = /bits/ 64 <200000000>;
+		opp-microvolt = <915000>;
+	};
+
+	opp-300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+		opp-microvolt = <915000>;
+	};
+
+	opp-400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <915000>;
+	};
+
+	opp-600000000 {
+		opp-hz = /bits/ 64 <600000000>;
+		opp-microvolt = <920000>;
+	};
+
+	opp-700000000 {
+		opp-hz = /bits/ 64 <700000000>;
+		opp-microvolt = <950000>;
+	};
+
+	opp-800000000 {
+		opp-hz = /bits/ 64 <800000000>;
+		opp-microvolt = <1000000>;
+	};
+};

-- 
2.39.2


