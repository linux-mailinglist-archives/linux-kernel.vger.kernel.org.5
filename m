Return-Path: <linux-kernel+bounces-14819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEC48222D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A0C1F2366C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240EC168B4;
	Tue,  2 Jan 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv7aTVnj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6186168A4;
	Tue,  2 Jan 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-556ad908f7cso600029a12.1;
        Tue, 02 Jan 2024 12:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704229192; x=1704833992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajkx4bsq5FblcMrag9XMXkO7pdSXa2ulGlzhuPvkJzs=;
        b=lv7aTVnjw/lIbRvafwKgOPl8AjWd3K2Ez7Fwes66zgdOD3MnrLmhw6iJk5h6ANwGIU
         WyjrTxR2HtBGTnqBcKpmi+isZkxzhqylNlIYX4XXmtkULfEZIYg8i031o3V8qHYIFTjn
         OMiaMpp1KfAFSvFIgEAi0Xi5pIusyN/bHHCHclsPFgM+iTYhnFAWaaX6868N5deGC3gr
         uZOQeuz3wyfeJtooqRQZmm9ouw8LSNfhbmbSSagGNjVbE4n4wCAJS8j6qW0gnYwkFQyk
         FxMVwrWpqu+In5aiNaS+WO7ia9psRqgP1kjnkZGybulnWUYn4Be/KUdHoMK/44iHke95
         QlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229192; x=1704833992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ajkx4bsq5FblcMrag9XMXkO7pdSXa2ulGlzhuPvkJzs=;
        b=PKAPe3pEyebGmUUdsMQF+EhXRnV/CgSu494Vl+ZGjDmeYXSG4FpnZcjt/hQTeHdKd7
         v+LQXs5IEtW/Nwv0hKg4VWkIUf5rXtUKBigOKu4Jf+xGC9yXRHZr73Y2U5R0+5Vcb3qs
         e48lBTQ0eaAD3d604p6ni7rTmK0VcYydekFatKD85M/N2vCvnu2xPBYTOEjCZTgAL+Ol
         ZAFELBXbwTjPBTVc4SSfRTFkqaYQwYCP1UXQDHHbh49qxMDzyy2P1GEFI3foqywSg6t9
         XHhMBV4AWWQAJtIPXCF+j1bIC5Et5D7tTu5SGGfUX4OcMsOY+NNEfdp6mBFwGj2A1Ha2
         O4yA==
X-Gm-Message-State: AOJu0YzPpv7F/XOqOBrMbKVU83CwC01kHC+e4QrfGJo2fsleE9vNxmH/
	QnlDoNal85zz99KKwXGGDVc=
X-Google-Smtp-Source: AGHT+IHhDQdRAcYOHrrLF2vqGrpF1xEzF7AiAnQxEGAx2mAbQ4UFRo0J9Hw9Iabzet1I/707xTXfUg==
X-Received: by 2002:a17:906:1091:b0:a23:5b04:d2ed with SMTP id u17-20020a170906109100b00a235b04d2edmr4778977eju.142.1704229191786;
        Tue, 02 Jan 2024 12:59:51 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090660cf00b00a26f66ce72fsm7941200ejk.83.2024.01.02.12.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 12:59:51 -0800 (PST)
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
	=?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: Add initial MT7988A and BPI-R4
Date: Tue,  2 Jan 2024 21:59:41 +0100
Message-Id: <20240102205941.29654-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240102205941.29654-1-zajec5@gmail.com>
References: <20240102205941.29654-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7988A (AKA MediaTek Filogic 880) is a quad-core ARM Cortex-A73
platform designed for Wi-Fi 7 devices (there is no wireless on SoC
though). The first public MT7988A device is Banana Pi BPI-R4.

Many SoC parts remain to be added (they need their own bindings or
depend on missing clocks). Those present block however are correct and
having base .dtsi will help testing & working on missing stuff.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  11 ++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 149 ++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 1e6f91731e92..0a189d5d8006 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
new file mode 100644
index 000000000000..efc4ad0b08b8
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+/dts-v1/;
+
+#include "mt7988a.dtsi"
+
+/ {
+	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
+	model = "Banana Pi BPI-R4";
+	chassis-type = "embedded";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
new file mode 100644
index 000000000000..0f2ae9c7aef7
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt7986a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a73";
+			reg = <0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a73";
+			reg = <0x1>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		cpu@2 {
+			compatible = "arm,cortex-a73";
+			reg = <0x2>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		cpu@3 {
+			compatible = "arm,cortex-a73";
+			reg = <0x3>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+	};
+
+	oscillator-40m {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		#clock-cells = <0>;
+		clock-output-names = "clkxtal";
+	};
+
+	pmu {
+		compatible = "arm,cortex-a73-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/* 320 KiB reserved for ARM Trusted Firmware (BL31 and BL32) */
+		secmon@43000000 {
+			reg = <0 0x43000000 0 0x50000>;
+			no-map;
+		};
+
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
+		watchdog@1001c000 {
+			compatible = "mediatek,mt7988-wdt";
+			reg = <0 0x1001c000 0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			#reset-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			trips {
+				crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+
+				hot {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				active-high {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				active-med {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				active-low {
+					temperature = <40000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+			};
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


