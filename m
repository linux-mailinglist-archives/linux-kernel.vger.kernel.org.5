Return-Path: <linux-kernel+bounces-44187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F7841E80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1850282E95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECA5822C;
	Tue, 30 Jan 2024 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK/2LbAD"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4B58ACF;
	Tue, 30 Jan 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605027; cv=none; b=EjgN/3x/Oqmi2lHOV64yKubB65XoR+XouP5TrjLeHrXFT0AxgHW7yFKM6tnPOQxq3/NzLMZosJNjUt6WuSlphnGePDBpR5gyubl+A11FnXv4fSkRFmxSK9M5K1/blM4FhNC13pUlmI1wvYQwoav4C5GQ32Zck+abl5fbD3iEzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605027; c=relaxed/simple;
	bh=IdQvpKX8Z/YuWsLS//ehpITfz1DRqjRyX5E2pQfSRi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjH+u3rvmP9kKqmLq7Wwx51p9pg6Od6eW4l9OZei3WqDWgHG/WLSw20bjGkrON2cN6OnGEFtfR8m89pJ1/0JNr6obys83D5+v55wj6V6w6625yOXkkBP4Bv2KVoUh9kgT4Qs2D4A0vnQL/txSwLHFiSWRWwuu+du3resvrSPTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK/2LbAD; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-595b208a050so2509144eaf.0;
        Tue, 30 Jan 2024 00:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605024; x=1707209824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmHSYPasnmftPhZlf61VtAJzsFmds52Vo77fQDJqRx8=;
        b=gK/2LbAD36piOois2jTZmBsXc4D4RfoviluXhXvL8PNxfLqN18UEp2Oo9ei5U+XQhn
         mDH1Vqf+qCfY0Zw8zCIzIW3dc1IDasiiwEAieFtmxqJOITxOx8z4HZaPdNs6qSEnOmbV
         /gPa7SwrHMvVCWzxoL6tiQ8JvLmIKf5CF9rd+45CKgcALhZQrTc6VBTDlz9nkqUG1EyY
         BqacaGmBtgfBoJyyD24vhNXD75DC0Y7A/2goPEc4FPRi8eWbybLSFoYm/V7gpCrK+TKc
         WW83JITiSL1Y74mbpbNY4rgNpO3YpG9VyhdZgWcSY2y8UpFge0pegrkPOXlj1iZEnWyV
         aEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605024; x=1707209824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmHSYPasnmftPhZlf61VtAJzsFmds52Vo77fQDJqRx8=;
        b=J4JD/ZI7CmbneK4ivUc7KnKaQ4R6Hs4Qw8enKMKqpDzJI421eF13+TfgAAK//f4Z8J
         jyDUo6tzIHsrVULULsjMYXH6EQ5xrevWj+fO9eZGnUHAxUfrA1AOMtoWFJZjKBB7jc6F
         hHc2T51e9fIJenbjKPo0xH1T69rFC/lkU6gAe0prNSAJ6+ny9FeNYsPhwurW5Qhh+o8E
         E1wUrlhsnPTuXg9WNT8EsFNlkpWq7m8sEiDNFKikFDCZ1bp5hAbvhR35CwhdjdXdtEqK
         fCqMYgkG8CUtGu8j1LyV9FdbMfaZfSHjLNMssnfw4j2ut52j+kCkLiXRf5jgJOrv5xnx
         Z6zA==
X-Gm-Message-State: AOJu0YxRNuPLMDVc7VPd/MKlkILcxkT0683hoPV+HmshM7WPDE69fwRe
	1kbpMvMVsrWyYN6qNO3un+darYebJjAs+WbxNCCAbzDGxOqmn8qN
X-Google-Smtp-Source: AGHT+IFsfclg10yNFJiRxBZT4APCMSFfIk5lfwtdsPGuMRgszdLFutRVam+E+AiAGNVTeUAXlOZ+Kg==
X-Received: by 2002:a05:6359:4c21:b0:178:89b4:5199 with SMTP id kj33-20020a0563594c2100b0017889b45199mr1226654rwc.48.1706605023753;
        Tue, 30 Jan 2024 00:57:03 -0800 (PST)
Received: from localhost.localdomain ([124.218.12.74])
        by smtp.gmail.com with ESMTPSA id gx20-20020a056a001e1400b006dde04c10dasm7188623pfb.217.2024.01.30.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:57:03 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kelly_hung@asus.com,
	kelly1732000 <Kelly_Hung@asus.com>
Subject: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
Date: Tue, 30 Jan 2024 16:56:52 +0800
Message-Id: <20240130085652.198010-2-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130085652.198010-1-Kelly_Hung@asus.com>
References: <20240130085652.198010-1-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: kelly1732000 <Kelly_Hung@asus.com>

This initial device-tree provides the necessary configuration for
basic BMC functionality and work on ASUS X4TF production.

Signed-off-by: kelly1732000 <Kelly_Hung@asus.com>
---
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 828 ++++++++++++++++++
 1 file changed, 828 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
new file mode 100644
index 000000000000..723bbb33137f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
@@ -0,0 +1,828 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2023 ASUS Corp.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+
+/ {
+	model = "ASUS-X4TF";
+	compatible = "asus,x4tf", "aspeed,ast2600";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8 earlycon";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		video_engine_memory: video {
+			size = <0x04000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		rvas_memory: rvas {
+			size = <0x04000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		bmc_dev_memory: bmc_dev_memory {
+			size = <0x00100000>;
+			alignment = <0x00100000>;
+			compatible = "shared-dma-pool";
+			no-map;
+		};
+
+		pci_msi_memory: pci_msi_memory {
+			no-map;
+			reg = <0x9e770000 0x100>;
+			compatible = "shared-dma-pool";
+		};
+		/* 1GB memory */
+		vga_memory: region@bf000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>;  /* 16M */
+		};
+		ssp_memory: ssp_memory {
+			size = <0x02000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			no-map;
+		};
+	};
+
+	vcc_sdhci0: regulator-vcc-sdhci0 {
+		compatible = "regulator-fixed";
+		status = "disabled";
+		regulator-name = "SDHCI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhci0: regulator-vccq-sdhci0 {
+		compatible = "regulator-gpio";
+		status = "disabled";
+		regulator-name = "SDHCI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>,
+			 <1800000 0>;
+	};
+
+	vcc_sdhci1: regulator-vcc-sdhci1 {
+		compatible = "regulator-fixed";
+		status = "disabled";
+		regulator-name = "SDHCI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhci1: regulator-vccq-sdhci1 {
+		compatible = "regulator-gpio";
+		status = "disabled";
+		regulator-name = "SDHCI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>,
+			 <1800000 0>;
+	};
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				<&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+				<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	video-engine@1e700000 {
+		compatible = "aspeed,ast2600-video-engine";
+		reg = <0x1e700000 0x20000>;
+		clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
+		clock-names = "vclk", "eclk";
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		memory-region = <&video_engine_memory>;
+		//resets = <&syscon ASPEED_RESET_VIDEO>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+		uid_led {
+			gpios = <&gpio0 ASPEED_GPIO(P, 1) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+			default-state = "off";
+		};
+		status_Y {
+			gpios = <&gpio1 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+		sys_boot_status {
+			gpios = <&gpio1 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+	spigpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_HIGH>;
+	};
+
+};
+
+&adc0 {
+	vref = <2500>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	vref = <2500>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&lpc_snoop {
+	snoop-ports = <0x80>;
+	status = "okay";
+};
+
+
+&mdio0 {
+	status = "disabled";
+};
+
+
+&mdio1 {
+	status = "disabled";
+};
+
+&mdio2 {
+	status = "okay";
+
+	ethphy2: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy3: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "disabled";
+};
+
+&mac1 {
+	status = "disabled";
+};
+
+//for X4TF
+&mac2 {
+	status = "okay";
+	phy-mode = "rmii";
+	#phy-handle = <&ethphy2>;
+	use-ncsi;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+};
+
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rmii";
+	#phy-handle = <&ethphy3>;
+	use-ncsi;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+};
+
+
+&syscon {
+	uart-clock-high-speed;
+	status = "okay";
+};
+
+&rtc {
+	status = "disabled";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc-spi";
+		spi-max-frequency = <50000000>;
+		spi-bus-width = <1>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bmc@0 {
+				label = "bmc";
+				reg = <0x0 0x4000000>;
+			};
+			u-boot@0 {
+				label = "u-boot";
+				reg = <0x0 0x200000>;
+			};
+			u-boot-env@1f0000 {
+				label = "u-boot-env";
+				reg = <0x1f0000 0x10000>;
+			};
+			kernel@200000 {
+				label = "kernel";
+				reg = <0x200000 0xc00000>;
+			};
+			rofs@a00000 {
+				label = "rofs";
+				reg = <0xa00000 0x2a00000>;
+			};
+			rwfs@2a00000 {
+				label = "rwfs";
+				reg = <0x2a00000 0x43f0000>;
+			};
+		};
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+		w25q256,fast-read;
+		label = "bios-spi";
+		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			biosfullimg@0 {
+				reg = <0x0 0x2000000>; //  32768 *1024 = 0x2000000, 32 MB
+				label = "biosfullimg";
+			};
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+	tmp75@48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+	tmp75@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+
+	pca9555_4_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555_4_22: gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555_4_24: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+		/*A0 - A7 0*/	"", "STRAP_BMC_BATTERY_GPIO1", "", "", "", "", "", "",
+		/*B0 - B7 8*/	"", "", "", "", "", "", "", "";
+	};
+
+	pca9555_4_26: gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	i2c-switch@70 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel_1: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		channel_2: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_3: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_4: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	pca9555_5_24: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	i2c-switch@70  {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70 >;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel_5: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			pca9555_5_5_20: gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names =
+				/*A0 0*/	"", "", "", "", "", "", "", "",
+				/*B0 8*/	"", "", "SYS_FAN6", "SYS_FAN5",
+				/*B4 12*/	"SYS_FAN4", "SYS_FAN3", "SYS_FAN2", "SYS_FAN1";
+			};
+			pca9555_5_5_21: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+			ina219@0x44 {
+				compatible = "ti,ina219";
+				reg = <0x44>;
+				rshunt = <2>;
+			};
+		};
+
+		channel_6: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_7: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_8: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+	pca9555_6_27: gpio@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+	pca9555_6_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+		/*A0 - A7 0*/	"", "", "", "", "", "", "", "",
+		/*B0 - B7 8*/	"Drive_NVMe1", "Drive_NVMe2", "", "", "", "", "", "";
+	};
+	pca9555_6_21: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	i2c-switch@70 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		idle-state = <1>;
+
+		channel_9: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			tmp75@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+			tmp75@49 {
+				compatible = "ti,tmp75";
+				reg = <0x49>;
+			};
+			ina219@0x40 {
+				compatible = "ti,ina219";
+				reg = <0x40>;
+				rshunt = <2>;
+			};
+			ina219@0x41 {
+				compatible = "ti,ina219";
+				reg = <0x41>;
+				rshunt = <5>;
+			};
+		};
+
+		channel_10: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_11: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_12: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+	i2c-switch@71 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		channel_13: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		channel_14: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_15: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_16: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	i2c-switch@70 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		channel_17: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		channel_18: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			tmp75@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+			ina219@0x41 {
+				compatible = "ti,ina219";
+				reg = <0x41>;
+				rshunt = <5>;
+			};
+		};
+
+		channel_19: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_20: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "disabled";
+};
+
+&i2c13 {
+	status = "disabled";
+};
+
+&i2c14 {
+	status = "okay";
+	multi-master;
+	eeprom@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+	};
+	eeprom@51 {
+		compatible = "atmel,24c08";
+		reg = <0x51>;
+	};
+};
+
+&sgpiom0 {
+	status = "okay";
+};
+
+&gfx {
+	pcie-reset-detect;
+	status = "disabled";
+	memory-region = <&gfx_memory>;
+};
+
+&sdc {
+	status = "okay";
+};
+
+&sdhci0 {
+	status = "disabled";
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	sdhci-drive-type = /bits/ 8 <3>;
+	/* SDR104/DDR50/SDR50 bits in CAPA2 is not supported */
+	sdhci-caps-mask = <0x7 0x580000>;
+	sdhci,wp-inverted;
+};
+
+#if !defined(CONFIG_SPX_FEATURE_ENABLE_SSP)
+&sdhci1 {
+	status = "disabled";
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	sdhci-drive-type = /bits/ 8 <3>;
+	sdhci-caps-mask = <0x7 0x580000>;
+	sdhci,wp-inverted;
+};
+#endif
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&ibt {
+	status = "disabled";
+};
+
+&kcs1 {
+	kcs_addr = <0xca0>;
+	status = "okay";
+};
+
+&kcs2 {
+	kcs_addr = <0xca8>;
+	status = "okay";
+};
+
+&kcs3 {
+	kcs_addr = <0xca2>;
+	status = "okay";
+};
+
+&kcs4 {
+	kcs_addr = <0xca4>;
+	status = "disabled";
+};
+
+&uart1 {
+	status = "disabled";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+	/* GPIOB6 will be used in ASD function, do not set to be TXD4 */
+	//pinctrl-0 = <&pinctrl_txd4_default &pinctrl_rxd4_default>;
+	pinctrl-0 = <&pinctrl_txd2_default &pinctrl_rxd2_default>;
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+#if defined(CONFIG_SPX_FEATURE_ENABLE_SSP)
+&uart7 {
+	status = "okay";
+};
+#endif
+
+#if defined(CONFIG_SPX_FEATURE_PLATGUARDPLUS_SUPPORT)
+&uart11 {
+	status = "okay";
+};
+#endif
+#ifdef CONFIG_SPX_FEATURE_USB_PORT_B_HOST_SUPPORT
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+#endif
+
+&vhub {
+	status = "okay";
+};
+
+#ifdef CONFIG_SPX_FEATURE_USB_PORT_B_SUPPORT
+&udc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2bd_default>;
+};
+#endif
+
+&gpio0 {
+	gpio-line-names =
+	/*A0 0*/	"", "", "", "", "", "", "", "",
+	/*B0 8*/	"", "", "", "", "", "", "PS_PWROK", "",
+	/*C0 16*/	"", "", "", "", "", "", "", "",
+	/*D0 24*/	"", "", "", "", "", "", "", "",
+	/*E0 32*/	"", "", "", "", "", "", "", "",
+	/*F0 40*/	"", "", "", "", "", "", "", "",
+	/*G0 48*/	"", "", "", "", "", "", "", "",
+	/*H0 56*/	"", "", "", "", "", "", "", "",
+	/*I0 64*/	"", "", "", "", "", "", "", "",
+	/*J0 72*/	"", "", "", "", "", "", "", "",
+	/*K0 80*/	"", "", "", "", "", "", "", "",
+	/*L0 88*/	"", "", "", "", "", "", "", "",
+	/*M0 96*/	"", "", "", "", "", "", "", "",
+	/*N0 104*/	"", "", "", "",
+	/*N4 108*/	"POST_COMPLETE", "ESR1_GPIO_AST_SPISEL", "", "",
+	/*O0 112*/	"", "", "", "", "", "", "", "",
+	/*P0 120*/	"ID_BUTTON", "ID_OUT", "POWER_BUTTON", "POWER_OUT",
+	/*P4 124*/	"RESET_BUTTON", "RESET_OUT", "", "HEARTBEAT",
+	/*Q0 128*/	"", "", "", "", "", "", "", "",
+	/*R0 136*/	"", "", "", "", "", "", "", "",
+	/*S0 144*/	"", "", "", "", "", "", "", "",
+	/*T0 152*/	"", "", "", "", "", "", "", "",
+	/*U0 160*/	"", "", "", "", "", "", "", "",
+	/*V0 168*/	"", "", "", "", "", "", "", "",
+	/*W0 176*/	"", "", "", "", "", "", "", "",
+	/*X0 184*/	"", "", "", "", "", "", "", "",
+	/*Y0 192*/	"", "", "", "", "", "", "", "",
+	/*Z0 200*/	"", "", "", "", "", "", "", "";
+};
-- 
2.25.1


