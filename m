Return-Path: <linux-kernel+bounces-106088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88F87E8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1D8B2268C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B937703;
	Mon, 18 Mar 2024 11:44:15 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898336B1C;
	Mon, 18 Mar 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762255; cv=none; b=Qts204vNjJ/NFmPnrkvMQXmMC9vAIDawy0V3enyAEedOyB51vjedH++oL1vVc4hh5EMJdsPzCP/j1L3Zth4aQBHg2pyKgGyUQ1nOO7F9Xo0oil+FmLduUUk8SamtC46CpaT7lv3TX3GIHIEI/5dNOI5hbV3gkFBoIwBPYs3858E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762255; c=relaxed/simple;
	bh=TgCsrvn8V3788RU5b4cHvpSfJVDnV+NHa5xdUiaIP0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQLW4Q22QsBHk5XSrCxQii57MEH47yUoqe41t75eUFgCLA6FqbJ9IClhd5JmaJjd12g25m5AqN+ALIfCwfLMx2fp5Kpi7BrJIj9RcFkJMcOsLHltZNkhZ2uFVVLikmYlHRull76MBamlngszZYev2DU4rpym2265vvQXVdpF9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513dc99b709so3078661e87.1;
        Mon, 18 Mar 2024 04:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762251; x=1711367051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hiv/Sv5PRyhx4BtepRtAoddyXGWHT+ApWqPraywbFRc=;
        b=h2VUHr18TAn2oVtD5cnxrGh4lZiFkV8ESa8nXn8pIKJXneF5EUtf+EiP5OzDZCnifh
         CU9GUL99Uv/FV9O3tyvv68KUNNkorr8WFqWEKR6iJzc+7YIlUJQ5Y86ZjI71sYxGA1vT
         y2YD358KpYX5mhRDHPRW1WuGdoS2XY0o2ch8X6XlVjlzAn4dqSaDA0kizeaCrff93qVN
         4EK0HCKChoAK2d+s+ifV/8pPboTRHHqwCArWEB055BbORgG7uf4nIPb294uyP+k1ptwf
         MaX7hKZbSuPUI8CtKon+R65rkkvwMP+AkmVYVfXsz5Mfzb7VqS6los9zUQjHG1yKiFtp
         ND6w==
X-Forwarded-Encrypted: i=1; AJvYcCVdDlAIHDr+5qGplxLrZ46XHeepa6bvyO/QUhBUgKybGj5oCBK7ajZAFp4SPPoK10jeKUDtPAb4DaNQyIklk3E8KqJ1xDC2mrKM3J1gmNA0Hzw1CpCuybaXZP7o70NDsdcwqq57n2pmkhrEHxGrAWF+WHnNAzwrwlCMX1tKaCm5AkbCow==
X-Gm-Message-State: AOJu0Yyz5Ozhh24YlAuAdxo/ftNhhweqPr+F8AYth3ddYQl5U7wXTyK0
	vexOuV34vpuCy47/X+i/ZzXY6QgwsFJRAAz59sobeZ+ZpNv1QdMF
X-Google-Smtp-Source: AGHT+IEK0o7Q49Ii+/ma3d/6fqohcGNbjahjQ4Bg4N3NFO0Truxy0FwquwQQF9BzvIoekqykmouRNg==
X-Received: by 2002:ac2:4e14:0:b0:513:a977:933b with SMTP id e20-20020ac24e14000000b00513a977933bmr8831924lfr.42.1710762251315;
        Mon, 18 Mar 2024 04:44:11 -0700 (PDT)
Received: from ryzen.lan (cpc147820-finc19-2-0-cust1005.4-2.cable.virginm.net. [86.16.175.238])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm17925813wmb.42.2024.03.18.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:44:10 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Yu Tu <yu.tu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Lucas Tanure <tanure@linux.com>
Subject: [RFC][PATCH 2/2] arm64: dts: amlogic: t7: SDCard, Ethernet and Clocking
Date: Mon, 18 Mar 2024 11:43:46 +0000
Message-ID: <20240318114346.112935-3-tanure@linux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318114346.112935-1-tanure@linux.com>
References: <20240318114346.112935-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test Clocking, SDCard and Ethernet for Khadas Vim4.

This is RFC patch that enables SDCard, Ethernet and Clocking
for Amlogic T7 soc.
In this current state the patch doesn't work and gives a kernel
panic when probing the meson-axg-mmc for the SDCard.
DO NOT MERGE.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  66 ++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 189 ++++++++++++++++++
 2 files changed, 255 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index fffdab96b12e..473649223512 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include "amlogic-t7.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/amlogic,t7-periphs-pinctrl.h>
 
 / {
 	model = "Khadas vim4";
@@ -44,6 +46,27 @@ xtal: xtal-clk {
 		clock-output-names = "xtal";
 		#clock-cells = <0>;
 	};
+	
+	sdcard_power: regulator-sdcard {
+			compatible = "regulator-fixed";
+			regulator-name = "SDCARD_POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio GPIOD_11 GPIO_ACTIVE_LOW>;
+			regulator-boot-on;
+			enable-active-low;
+			regulator-always-on;
+	};
+
+	vddio_card: gpio-regulator {
+			compatible = "regulator-gpio";
+			regulator-name = "VDDIO_CARD";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			gpios = <&gpio GPIOD_9 GPIO_ACTIVE_HIGH>;
+			gpios-states = <1>;
+			states = <1800000 1 3300000 0>;
+	};
 
 };
 
@@ -52,3 +75,46 @@ &uart_a {
 	clocks = <&xtal>, <&xtal>, <&xtal>;
 	clock-names = "xtal", "pclk", "baud";
 };
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sd_all_pins>;
+	pinctrl-1 = <&sd_1bit_pins>;
+	pinctrl-2 = <&sd_clk_gate_pins>;
+	pinctrl-names = "sd_default",
+			"sd_1bit_pins",
+			"clk-gate";
+	bus-width = <4>; 
+	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	max-frequency = <200000000>;
+
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_HIGH>;
+	//dat1-gpios = <&gpio GPIOC_1 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&sdcard_power>;
+	vqmmc-supply = <&vddio_card>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		reg = <0>;
+		max-speed = <1000>;
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&external_phy>;
+	mc_val = <0x1621>;
+	cali_val = <0xa0000>;
+	amlogic,tx-delay-ns = <2>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 5248bdf824ea..376b352697b7 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -5,6 +5,8 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/amlogic,t7-pwrc.h>
+#include <dt-bindings/clock/amlogic,t7-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,t7-peripherals-clkc.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -148,6 +150,42 @@ apb4: bus@fe000000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
+			
+			clkc_periphs: clock-controller@0 {
+				compatible = "amlogic,t7-peripherals-clkc";
+				reg = <0x0 0x0 0x0 0x49c>;
+				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+					 <&clkc_pll CLKID_FCLK_DIV2P5>,
+					 <&clkc_pll CLKID_FCLK_DIV3>,
+					 <&clkc_pll CLKID_FCLK_DIV4>,
+					 <&clkc_pll CLKID_FCLK_DIV5>,
+					 <&clkc_pll CLKID_FCLK_DIV7>,
+					 <&clkc_pll CLKID_HIFI_PLL>,
+					 <&clkc_pll CLKID_GP0_PLL>,
+					 <&clkc_pll CLKID_GP1_PLL>,
+					 <&clkc_pll CLKID_MPLL0>,
+					 <&clkc_pll CLKID_MPLL1>,
+					 <&clkc_pll CLKID_MPLL2>,
+					 <&clkc_pll CLKID_MPLL3>,
+					 <&clkc_pll CLKID_MPLL_50M_DIV>,
+					 <&clkc_pll CLKID_HDMI_PLL>,
+					 <&xtal>;
+				clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3",
+					      "fclk_div4", "fclk_div5", "fclk_div7",
+					      "hifi_pll", "gp0_pll", "gp1_pll",
+					      "mpll0", "mpll1", "mpll2", "mpll3",
+					      "mpll_50m_div", "hdmi_pll", "xtal";
+				#clock-cells = <1>;
+			};
+
+			clkc_pll: clock-controller {
+				compatible = "amlogic,t7-pll-clkc";
+				#clock-cells = <1>;
+				reg = <0x0 0x8000 0x0 0x320>;
+				clocks = <&xtal>;
+				clock-names = "xtal";
+				status = "okay";
+			};
 
 			watchdog@2100 {
 				compatible = "amlogic,t7-wdt";
@@ -155,6 +193,41 @@ watchdog@2100 {
 				clocks = <&xtal>;
 			};
 
+			eth_phy: mdio-multiplexer@28000 {
+				compatible = "amlogic,g12a-mdio-mux";
+				reg = <0x0 0x28000 0x0 0xa4>;
+
+				clocks = <&clkc_periphs CLKID_ETHPHY>,
+					 <&xtal>,
+					 <&clkc_pll CLKID_MPLL_50M>;
+				clock-names = "pclk", "clkin0", "clkin1";
+				mdio-parent-bus = <&mdio0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				enet_type = <5>;
+				tx_amp_src = <0xFE010330>;
+
+				ext_mdio: mdio@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				int_mdio: mdio@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					internal_ephy: ethernet_phy@8 {
+						compatible = "ethernet-phy-id0180.3301",
+							     "ethernet-phy-ieee802.3-c22";
+						interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+						reg = <8>;
+						max-speed = <100>;
+					};
+				};
+			};
+
 			periphs_pinctrl: pinctrl@4000 {
 				compatible = "amlogic,t7-periphs-pinctrl";
 				#address-cells = <2>;
@@ -187,7 +260,123 @@ uart_a: serial@78000 {
 				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
+
+			sd_emmc_b: sd@8a000 {
+				compatible = "amlogic,meson-axg-mmc";
+				reg = <0x0 0x8a000 0x0 0x800>;
+				interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&clkc_periphs CLKID_SD_EMMC_B>,
+					 <&clkc_periphs CLKID_SD_EMMC_B_CLK_MUX>,
+					 <&clkc_periphs CLKID_SD_EMMC_B_CLK>,
+					 <&xtal>,
+					 <&clkc_pll CLKID_FCLK_DIV2>;
+				clock-names = "core", "mux0", "mux1", "clkin0", "clkin1";
+				card_type = <5>;
+				use_intf3_tuning;
+				mmc_debug_flag;
+			};
+
+		};
+
+		ethmac: ethernet@fdc00000 {
+			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac-4.00";
+			reg = <0x0 0xfdc00000 0x0 0x10000>,
+			      <0x0 0xfe024000 0x0 0x8>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			power-domains = <&pwrc PWRC_T7_ETH_ID>;
+			clocks = <&clkc_periphs CLKID_ETH>,
+				 <&clkc_pll CLKID_FCLK_DIV2>,
+				 <&clkc_pll CLKID_MPLL2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1";
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <2048>;
+
+			internal_phy = <1>;
+			status = "disabled";
+
+			mdio0: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+		};
+	};
+};
+
+&periphs_pinctrl {
+	sd_all_pins:sd_all_pins {
+		mux {
+			groups = "sdcard_d0",
+				   "sdcard_d1",
+				   "sdcard_d2",
+				   "sdcard_d3",
+				   "sdcard_cmd";
+			function = "sdcard";
+			bias-pull-up;
+			drive-strength-microamp = <4000>;
+		};
+		mux1 {
+			groups = "sdcard_clk";
+			function = "sdcard";
+			bias-pull-up;
+			drive-strength-microamp = <4000>;
+		};
+	};
+	
+	sd_1bit_pins:sd_1bit_pins {
+		mux {
+			groups = "sdcard_d0",
+					"sdcard_cmd";
+			function = "sdcard";
+			bias-pull-up;
+			drive-strength-microamp = <4000>;
+		};
+		mux1 {
+			groups = "sdcard_clk";
+			function = "sdcard";
+			bias-pull-up;
+			drive-strength-microamp = <4000>;
 		};
+	};
+	
+	sd_clk_gate_pins: sd_clk_gate {
+		mux {
+			groups = "GPIOC_4";
+			function = "gpio_periphs";
+			bias-pull-down; 
+			drive-strength-microamp = <4000>;
+		};
+	};
 
+	eth_pins: eth {
+		mux {
+			groups = "eth_mdio",
+				 "eth_mdc",
+				 "eth_rgmii_rx_clk",
+				 "eth_rx_dv",
+				 "eth_rxd0",
+				 "eth_rxd1",
+				 "eth_txen",
+				 "eth_txd0",
+				 "eth_txd1";
+			function = "eth";
+			drive-strength-microamp = <4000>;
+			bias-disable;
+		};
+	};
+
+	eth_rgmii_pins: eth-rgmii {
+		mux {
+			groups = "eth_rxd2_rgmii",
+				 "eth_rxd3_rgmii",
+				 "eth_rgmii_tx_clk",
+				 "eth_txd2_rgmii",
+				 "eth_txd3_rgmii";
+			function = "eth";
+			drive-strength-microamp = <4000>;
+			bias-disable;
+		};
 	};
 };
-- 
2.44.0


