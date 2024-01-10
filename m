Return-Path: <linux-kernel+bounces-21922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AC82969F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF20B24F79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A63F8FF;
	Wed, 10 Jan 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+E3uS3T"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3A3EA93;
	Wed, 10 Jan 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2be2148777so33280766b.0;
        Wed, 10 Jan 2024 01:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704880314; x=1705485114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eyRxR6bVp9zc7fZy28Xp4h3YUMVLD6VRe57ZqeUulk=;
        b=i+E3uS3TYytHCudcpCJB5+9o2ugEDLWSCTogAyecGjOj3YW0eXhR2bLZ7rewCjMaqh
         8SiWBS6Hl8tDV63wsKPF05TVEm5sf8GjxmOiLsxpER0UkJvFMMS58gNkLGA4kV8Xj2yY
         MntDO0625pzxmRnxqWnM13yWFTckJKUJXmK4QTaiLmt5t71A4YTZNKl7SXmdoNsGnl6O
         AMUZW34xNT3vq5LCgSRYCrtFcpq6jc7JgbAM+Go4zMKdr8QdLSczuAcig7IhOb2qYixY
         dGhO3yonqFKWPYGUsUGNJ1MeVru40sIIZ2TkprM6uFRlFJnpqIGiG6JRy/Yuo5C+GPAm
         6GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704880314; x=1705485114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eyRxR6bVp9zc7fZy28Xp4h3YUMVLD6VRe57ZqeUulk=;
        b=j0QnDKR+YGDZck5xREnzwsxwDdVl20Hzi+d8A4JpIT9a//+I5MePh/COtD2qFDt1tf
         4uHXGDv4TGA88N8Wr06r1XP/T62K3WMBgJy/CS1bdPr1jm9Dfh7euPC1zQjGSL6FAV3L
         V/kIgsOegWcp0kKT8+Dv71PJBZrAoKSg0Dfcyp6Q4u4lCzD+Zyv9c+RkGzSxybqc0ff4
         bqzfYWxNNSBYYexaCUYnotxEz7LGt3ooTa9Utl1F0RVm4KA/PeUt8p/lgIG2K4boCPQ3
         EXWCtxwUkyMGlG1+0kX14iVNgob+cIefEB7SCz9RA4mZCJ1ibhb88LjfQy4GEabdmftc
         SL/Q==
X-Gm-Message-State: AOJu0YyAfMee9v+KqDKYjMJrGHuu6+hmeh2fCJxWKiQgwgAkaFZj0D0a
	L7i0YKtJlvgtqB+EYwtD2F0=
X-Google-Smtp-Source: AGHT+IFXWlA0EPX7UHPNM67MuIcwZijEcSqO48IFxFR++3r/e5jyzK+T5oMMlCUtrM8McxTDaD/oAg==
X-Received: by 2002:a17:906:1c0f:b0:a26:f2da:3bfe with SMTP id k15-20020a1709061c0f00b00a26f2da3bfemr476791ejg.124.1704880313791;
        Wed, 10 Jan 2024 01:51:53 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906529800b00a27aabff0dcsm1947617ejm.179.2024.01.10.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 01:51:53 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: Add initial MT7981B and Xiaomi AX3000T
Date: Wed, 10 Jan 2024 10:51:18 +0100
Message-Id: <20240110095118.25598-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240110095118.25598-1-zajec5@gmail.com>
References: <20240110095118.25598-1-zajec5@gmail.com>
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
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt7981b-xiaomi-ax3000t.dts   |  15 +++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 108 ++++++++++++++++++
 3 files changed, 124 insertions(+)
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
index 000000000000..ce878ad55204
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -0,0 +1,108 @@
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
+		compatible = "arm,psci-0.2";
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
+			      <0 0x0c080000 0 0x200000>, /* GICR */
+			      <0 0x0c400000 0 0x2000>,   /* GICC */
+			      <0 0x0c410000 0 0x1000>,   /* GICH */
+			      <0 0x0c420000 0 0x2000>;   /* GICV */
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


