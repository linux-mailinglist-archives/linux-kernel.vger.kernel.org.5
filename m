Return-Path: <linux-kernel+bounces-110268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA5885C54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF321C22C27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C60128386;
	Thu, 21 Mar 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmz8c58N"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCB12837A;
	Thu, 21 Mar 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035696; cv=none; b=CJsKIcwt7GJJqd4NJyb4cTkTx0kafg4Uv/cynbZwEqum05BbsNbB0ym2OAPh2cRPYVbCi46PkgrkIZPY9SMfYBbwW2KyuFm9l+MSl+i1dNCebQN+lGiMDWfJvzZ7vcjMbEqxZNx0wLBvqVDQIFUpNAHkqe+WgpK0VT0QL0PQcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035696; c=relaxed/simple;
	bh=XaYpmJAsR81dleBYhWJJlPnvk28HHmW1OINgM20h6mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LFp/xxa6vma4Yt9NdzS3gLJT1zcncYMrhEV5I59waZsdxHohWY1fKNQuCJLTRlj8k1QzGrfW/7K+eA61Q2vU/t0OnskPwjzIe1TMxjBFUOcgPoh2jISiSQ1Z2Ih62YgLHR1mAgv4r1nwGnmcjTqRZ9kFmT4TRy5GVVaLgCyzNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmz8c58N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a468226e135so137818766b.0;
        Thu, 21 Mar 2024 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035692; x=1711640492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks3B8gta3Kso0CEXjpkQLs/PLzamWFdv61CS+4Zn9Js=;
        b=jmz8c58N2WVUTXSAshXRKI/pjJvN7YMN/Qv1R8mG3srTElVwhD97z+iszKy3HJ8AZu
         9fDHTSRMVhxY+oMn/Vw5hMo4kmhCKxLg9+YZvD/8Fg/761Sc7d7v8fmXSFBbYTQ2htpv
         Y1SOfzas5lEC6Sc9ehfttHMQszlBwry4yn2stv3EDp2kqaUJCSzJAxp0oNvSVHrZijQj
         aS/ljGRuL5dzCiReN8JVcjU1zuVdUSPKxNLoqIIxfw13yihukVvb+642qRSB+fgr9AZm
         IunMviNe6rZ2buo7sPnPaG/YznRQR6ihBpjJ3f4q/TiQrhjdLqO0ZKkoeJn1Ac9LLvh6
         XdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035692; x=1711640492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks3B8gta3Kso0CEXjpkQLs/PLzamWFdv61CS+4Zn9Js=;
        b=wOauIxpPJN2sSk/A+gl/PiqhMEnUbltXn0r7DGFP1Ux9G8Apuq+7iOd+S4JSvHJB7l
         y88xAeC8wKO1reRbVtfqIvDuddy9S4KOKpHZ7RbH0m1aSZOtS9JuoFETlcerjrSasNF/
         0QzooFYMtfX5tfNnaxXXn49tkDj6uEdhs3sE82lBGAHRyNSeA5fkCHfq+YcwBIEZ6ENf
         LEeo/o0iF8D89ZywaOJrWwUe7EAxn7QY4IHR69BJsLUSKd4zU/IzPkyZi/Oz9+/ie0zq
         exq3NyDuG+wrpPS70jifrgf6gXaAsjV/hlvd3ts+23CcL+AOhnnBeKGcq9h4mGxcUy6c
         8fWA==
X-Forwarded-Encrypted: i=1; AJvYcCWFhOHu2HEC6WBVVRg+EvsLIw5Ax2HDQT+BBt7SKCutinNqcL5liI2W42vnV6vpDlY80AW+3taaoc0/hRnrFhCbU9rmc2ox+hbAr+r+X91p4sJFl+5jWY68vhKDULLR7hbwSoaHV712fysSTDAHmMLHVAcNCrMsz8LvuPKQtlecPgGP9NzEgPAVM9V3zxo/js+YQnUQzJiW/GrNvWfTWSuQjw==
X-Gm-Message-State: AOJu0YwY3rN4y7Zs/oou0ezJyXeL1ofb1QKs9aV0azBK+j7q0MdMGFfu
	YnMx22Vy5W4olAi1WaQozdciRnyKcQJagvyUwgSpgt+bAI5BF4BS
X-Google-Smtp-Source: AGHT+IFGzEZx6MoJU5fZoz+IF1Zk1e4dl3hBBZFHuvcOMOg0dQcC1sr2j3TxCgN1RTElj6HgyJ2b9g==
X-Received: by 2002:a17:907:9811:b0:a47:d95:51ba with SMTP id ji17-20020a170907981100b00a470d9551bamr2169426ejc.38.1711035692424;
        Thu, 21 Mar 2024 08:41:32 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id wy3-20020a170906fe0300b00a46b10861acsm36851ejb.208.2024.03.21.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:41:31 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3
Date: Thu, 21 Mar 2024 16:41:06 +0100
Message-Id: <20240321154108.146223-5-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240321154108.146223-1-wafgo01@gmail.com>
References: <20240321154108.146223-1-wafgo01@gmail.com>
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
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 237 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  45 ++++
 3 files changed, 283 insertions(+)
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
index 000000000000..54428285eec2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -0,0 +1,237 @@
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
+
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
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* phys */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* virt */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>, /* hyp-phys */
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>; /* hyp-virt */
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
+			compatible = "nxp,s32g3-usdhc",
+				     "nxp,s32g2-usdhc";
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
index 000000000000..db6b4db89612
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -0,0 +1,45 @@
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
+		mmc0 = &usdhc0;
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
+	bus-width = <8>;
+	status = "okay";
+};
-- 
2.25.1


