Return-Path: <linux-kernel+bounces-23391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602A82AC2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702741F223D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5815480;
	Thu, 11 Jan 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRl1AhQO"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AC14F89;
	Thu, 11 Jan 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5588a83e0d0so633480a12.3;
        Thu, 11 Jan 2024 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704969580; x=1705574380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVgpAQw5lxERHkBicfugIDRBRVx5HBt1tQZLZuFr6Ec=;
        b=iRl1AhQOUm2eRYMzIRo4dic80Ng9Hz5nVX3h78/w0WqVsJt56Fi60sgEjWF0wW3IiC
         nc60n7Ljw2Mb7/qS2b5nG8kMWHQVHNwlJgNTIY+wCYnhwB+TxuLMFH0I94yJlIeV12WA
         DtNPBdfkaFO0zhxjaCaQ2vDdHX8bisj66/Yig2N+jPPeDATUBOf9mIzkQUOk0/8RucVC
         uclw2qTKIzegc4YhBz1h15teYK9Lf0PyHDeNXNAtDS+ejp/wuUkr8pfryz0l1uvLZqKG
         J4IFYpwxgn3A1JMdIkJMKriS8ZuZkh5ghYLibbNCBZBf283q6Jv4ZEhcH8AfQTrLMFHW
         E8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704969580; x=1705574380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVgpAQw5lxERHkBicfugIDRBRVx5HBt1tQZLZuFr6Ec=;
        b=D9B6RIgwztwDdlaGvyz2PI9DMBShoAmee/w4h5p60faDGlfGrO4sOB1umwZNL39z6X
         xSkd3zuxzzQ22KwtKU7dtI1S5hGsK8ZCOerig//UrU65ABbab1cOsk8jp2FEoIyWT2+L
         DFAaSGm3bnjhntcPE1qGURzBJ6rJ+9V7cODdv0ISKzndjtrM7OGOVgOXlf8WlsODPgV1
         0t09wmcmRhwsvae1ne9SIH6s8l9t7SnPi6AWh7YehExV4vNC6QuDF5gKLNTkoffnFdce
         99QmLAMnKWMdir8J0hpLCfjqAJ74OZB5zn3Bdo8y6zCyjBnRLHGWIicG57IU7AmgHXpw
         spKw==
X-Gm-Message-State: AOJu0YxxoA5w4OlJ7/TGgw0yoYuiezzf+PZ6QoD7QGvSP/zgyf34WLUK
	GdORPsJYal3HsrzTns0tsjA=
X-Google-Smtp-Source: AGHT+IGCI51BT0950v+o0UYQLAUBlFB/Hr7Uxq7pBrhSwMwN7fwM/Q56+vSPKOF47X5RNjaJJco2wg==
X-Received: by 2002:a17:906:a28f:b0:a28:b170:5504 with SMTP id i15-20020a170906a28f00b00a28b1705504mr454038ejz.76.1704969579904;
        Thu, 11 Jan 2024 02:39:39 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906c20e00b00a298e2f6b3csm407179ejz.213.2024.01.11.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:39:39 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	soc@kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] arm64: dts: mediatek: Add initial MT7981B and Xiaomi AX3000T
Date: Thu, 11 Jan 2024 11:39:28 +0100
Message-Id: <20240111103928.721-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240111103928.721-1-zajec5@gmail.com>
References: <20240111103928.721-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981B (AKA MediaTek Filogic 820) is a dual-core ARM Cortex-A53 SoC.
One of market devices using this SoC is Xiaomi AX3000T.

This is initial contribution with basic SoC support. More hardware block
will get added later. Some will need their bindings (like auxadc).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
V2: Fix psci version
    Fix gic regs

 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt7981b-xiaomi-ax3000t.dts   |  15 +++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 105 ++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 0a189d5d8006..8bff11acfe1f 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
new file mode 100644
index 000000000000..a314c3e05e50
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+/dts-v1/;
+
+#include "mt7981b.dtsi"
+
+/ {
+	compatible = "xiaomi,ax3000t", "mediatek,mt7981b";
+	model = "Xiaomi AX3000T";
+
+	memory@40000000 {
+		reg = <0 0x40000000 0 0x10000000>;
+		device_type = "memory";
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
new file mode 100644
index 000000000000..4feff3d1c5f4
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+#include <dt-bindings/clock/mediatek,mt7981-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt7981b";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+	};
+
+	oscillator-40m {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		clock-output-names = "clkxtal";
+		#clock-cells = <0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
+			      <0 0x0c080000 0 0x200000>; /* GICR */
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		infracfg: clock-controller@10001000 {
+			compatible = "mediatek,mt7981-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1001b000 {
+			compatible = "mediatek,mt7981-topckgen", "syscon";
+			reg = <0 0x1001b000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1001e000 {
+			compatible = "mediatek,mt7981-apmixedsys";
+			reg = <0 0x1001e000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pwm@10048000 {
+			compatible = "mediatek,mt7981-pwm";
+			reg = <0 0x10048000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_PWM_STA>,
+				<&infracfg CLK_INFRA_PWM_HCK>,
+				<&infracfg CLK_INFRA_PWM1_CK>,
+				<&infracfg CLK_INFRA_PWM2_CK>,
+				<&infracfg CLK_INFRA_PWM3_CK>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
+			#pwm-cells = <2>;
+		};
+
+		clock-controller@15000000 {
+			compatible = "mediatek,mt7981-ethsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
-- 
2.35.3


