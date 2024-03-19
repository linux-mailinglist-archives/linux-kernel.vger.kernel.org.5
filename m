Return-Path: <linux-kernel+bounces-108184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABA0880736
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FB91F22E39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CE5F86E;
	Tue, 19 Mar 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH1tXBDM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147F5FB91;
	Tue, 19 Mar 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886651; cv=none; b=kR36k9JQk2Rpd21nXrEQF+C5M0O3NswYrJqSmx8ORqeC1fEm16OcNiNEKZP80yVzC2SrXYwOsotXcdn2Zi1NBXm9cGUHJjKf7eQsHbRqmhdoSLgXb1M6xSpX6xocBifi0AlvVg1Uovqx1alWCAdzPM6iBc8VuDFfqlqA4JVHeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886651; c=relaxed/simple;
	bh=NBsCidwybkOuC08K4j2GSNpZoPj3a1MZv4LIIq4Vitk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOiajejjHMd7EalRPwQdWUw8zHe+AcH62VqAP3gDUoOCZAJH9gJZ3RERV0Vdnt2oVJNa9feTFMQFPTASFGMa7ot4Ol65Ci1KrK9TTNAGTy3vcYO1Suf/x3JQ4IYfAL4KEqqDr4f8S8c/4qpEpVOHxswGVddvi5z+RtU6rfJp91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH1tXBDM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso2870306a12.1;
        Tue, 19 Mar 2024 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710886647; x=1711491447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD2cpkMsukc2t6lOEVJMAGeEzdFznTLV1Ae/yHi4lbc=;
        b=ZH1tXBDMRUzLPALk0/aaUM7GW4JQq2AabZYMZLh414sVC9/J8ASYA5zqcnQ1THiz4m
         mDCJqYJ4QtPCSpgPPMnveAr7ttQO5SbQvqttarM6jLdaT6OaJBu1ZaVKewtBq+jHWIYY
         jGk2yZkzKcUFCoV5OtiCrrvrisBr20s8IGp7W1ZU6kh6ND5+0CzT64HQK233R74jpT+j
         TWQwm4z0D8dUXw0doPF2hDsK+pSxFSZeTuOtvd4/rMrLxMdeBYZN+lrya3x6Ga2fFOzB
         N60g3mZMeaix5RpoSgmwNlZHIiOEFPw3ZWlfS1lknYxJWuQC8PnU8dlSDYNSjEbkzI5N
         U2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710886647; x=1711491447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD2cpkMsukc2t6lOEVJMAGeEzdFznTLV1Ae/yHi4lbc=;
        b=odAbaBJrQ/faWlLMTPr3pd2YGIm0SqpUk0St+ceG/on2Kxr2RtI7tFLxjONUdMgqlo
         5nfVee6ttK0qnWX1g/PCYbHwuFfRILcUk5CV5n8+/nTpt+DISU06YV8+NaQ8r2iu5/pc
         tYjaYExTk2Eb+HgtnesbOXV4GkCDPNPDmbebley36jdcHs4i38DWgfXDKnyoUni7v6fh
         Edbank4u/ES+rKEDxB3YTilMf5dNbQ1VcSATQy2d+kdnoawDG48QMutYjTRaD9kCF/U7
         BfGGkGyOiYodaMoqS//Do9YkPEE0deYfFRq95ugmNN2t3m0y0YPTDemaY+CblEh+kyJA
         /Z+g==
X-Forwarded-Encrypted: i=1; AJvYcCVbZgxggnVyC7u/e/XoFCEP4nLLl8K58m63OflVz2BWhX3ilbfFYzJmUkU4z9Qz/oJtsfJtE1A/YbS96H86sXmuveLNPWUzVhghGYqUnvK4kojIT4XG3zstLVfYdK7GkghrwOYEguzDGY5tQBRTLQVdflXUsRgq7HeQhQJ7K2VLQhHRdf5kKA==
X-Gm-Message-State: AOJu0YxDSz5wOyWSYjKDfpakryyg0nQKHLYVGwCzQ/8j56/3vKTPUfcs
	kd1Bmhr5+Kzz5dKtC2EJRdqcbbgpsR9+HrAsLZ3hce9TvkFARvI+
X-Google-Smtp-Source: AGHT+IFrqLpPM0ZVS5wF5SRG4eUSyLDL2aB2cnjv/EIlpuYUtvQ7ik5xD64PHhzDc91m3PvMnqg7NA==
X-Received: by 2002:a05:6402:f11:b0:568:d7c0:eaa9 with SMTP id i17-20020a0564020f1100b00568d7c0eaa9mr201527eda.4.1710886647278;
        Tue, 19 Mar 2024 15:17:27 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id n13-20020a05640204cd00b00569aed32c32sm2761182edw.75.2024.03.19.15.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 15:17:26 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Josua Mayer <josua@solid-run.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3
Date: Tue, 19 Mar 2024 23:16:09 +0100
Message-Id: <20240319221614.56652-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319221614.56652-1-wafgo01@gmail.com>
References: <20240319221614.56652-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds device tree support for the NXP S32G3-based
S32G-VNP-RDB3 Board [1].

The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.

The device tree files are derived from the official NXP downstream
Linux tree [2].

This addition encompasses a limited selection of peripherals that
are upstream-supported. Apart from the ARM System Modules
(GIC, Generic Timer, etc.), the following IPs have been validated:

    * UART: fsl-linflexuart
    * SDHC: fsl-imx-esdhc

Clock settings for the chip rely on ATF Firmware [3].
Pin control integration into the device tree is pending and currently
relies on Firmware/U-Boot settings [4].

These changes were validated using BSP39 Firmware/U-Boot from NXP [5].

The modifications enable booting the official Ubuntu 22.04 from NXP on
the RDB3 with default settings from the SD card and eMMC.

[1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
[2] https://github.com/nxp-auto-linux/linux
[3] https://github.com/nxp-auto-linux/arm-trusted-firmware
[4] https://github.com/nxp-auto-linux/u-boot
[5] https://github.com/nxp-auto-linux/auto_yocto_bsp

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 236 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  43 ++++
 3 files changed, 280 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2cb0212b63c6..e701008dbc7b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -252,3 +252,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-rpidsi.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
+dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
new file mode 100644
index 000000000000..6be638326142
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2021-2023 NXP
+ *
+ * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
+ *          Ciprian Costea <ciprianmarian.costea@nxp.com>
+ *          Andra-Teodora Ilie <andra.ilie@nxp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+/ {
+	compatible = "nxp,s32g3";
+	interrupt-parent = <&gic>;
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x100>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x101>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x102>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x103>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* virt */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* hyp-virt */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>; /* phys */
+		arm,no-tick-in-suspend;
+	};
+
+	reserved-memory  {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scmi_shmem: shm@d0000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0xd0000000 0x0 0x80>;
+			no-map;
+		};
+	};
+
+	firmware {
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			shmem = <&scmi_shmem>;
+			arm,smc-id = <0xc20000fe>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
+
+			dfs: protocol@13 {
+				reg = <0x13>;
+				#clock-cells = <1>;
+			};
+
+			clks: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x80000000>;
+
+		uart0: serial@401c8000 {
+			compatible = "nxp,s32g3-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg = <0x401c8000 0x3000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		uart1: serial@401cc000 {
+			compatible = "nxp,s32g3-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg = <0x401cc000 0x3000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		uart2: serial@402bc000 {
+			compatible = "nxp,s32g3-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg = <0x402bc000 0x3000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@50800000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x50800000 0x10000>,
+			      <0x50900000 0x200000>,
+			      <0x50400000 0x2000>,
+			      <0x50410000 0x2000>,
+			      <0x50420000 0x2000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		usdhc0: mmc@402f0000 {
+			compatible = "nxp,s32g2-usdhc";
+			reg = <0x402f0000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 32>,
+				 <&clks 31>,
+				 <&clks 33>;
+			clock-names = "ipg", "ahb", "per";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
new file mode 100644
index 000000000000..199605b28df3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2021-2023 NXP
+ *
+ * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
+ */
+
+/dts-v1/;
+
+#include "s32g3.dtsi"
+
+/ {
+	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
+	compatible = "nxp,s32g399a-rdb3", "nxp,s32g3";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* 4GiB RAM */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>,
+		      <0x8 0x80000000 0 0x80000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usdhc0 {
+	status = "okay";
+};
-- 
2.25.1


