Return-Path: <linux-kernel+bounces-19214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0C8269DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CBC1C22471
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A612B68;
	Mon,  8 Jan 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF5DDrjy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085510A2C;
	Mon,  8 Jan 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so155392066b.2;
        Mon, 08 Jan 2024 00:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704703971; x=1705308771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MAavEp4GRQ8ByO63q+MnUAR25rHkk0tfYwSOvmf5+U=;
        b=GF5DDrjyUf7+GhFUfDhw4QMw5WgZx1KPJ1phPKiMMkMvq0udYAVVxdlJeXp4oHbqTX
         baHrAPKNCZky4CP6xB24duIjPXxRTCKk4zyazNmjijDOpX0zmge8tVLnQBFgjSSCxxu6
         THNZDyIQPvP4vCdZ0IflrSFvaF3SU3loBy6I3l5Rl5tovTvUH4XsU+tBemVrCShoOcSM
         G1ITvmo+itgJECXo0B22Y9/H0yvTTtBYJJWP0lm5pOlzFox6f3E/reP7PpHkLm/ypF7H
         v36go6yHFwvmgbSGJzvaPMw9/Qw0GxEGsOwesiCBMLEyHx1Kv7SVMdqZtfZuGXUi9JKj
         y5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704703971; x=1705308771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MAavEp4GRQ8ByO63q+MnUAR25rHkk0tfYwSOvmf5+U=;
        b=WyiS8pEzaFoqQrkmXeTaCGFaQaKFp6rdIbvHOe35mVDM+iAnYAZVMU1XDS/dYVW546
         /oi0sXIhNDUsRDRXycJLF4oC+gQwHr0C6HNcwo+E8oWNrrI/xN9HW0sC0aCS1foS8Wur
         TezvnlBMJ71BeDtpFPCHfx+fZc/x6mzX43ncfFgFqb5iXnQ0W6bbhh7buo8dTL7WORpu
         AvbmUi9hpyEd2+DNCi1E0ZoePzXTsjhI1J8Y3tED6d2Vkgz35YAGcoD3EwSfHitD3udO
         2iVrOwcm5HgJs0HxRA8AJF9aI5UrIZSIq01RWJPuQ7mtJk4Ua3lxrBmo0EdSRf2J0kfL
         KrzQ==
X-Gm-Message-State: AOJu0YwHtO5uTm8W7L40LfDL6M+Yr0p5ipkX/QJGziJZYEPUvbeqxxo/
	AXOsRSBN6xeVFfKu37XJRCY=
X-Google-Smtp-Source: AGHT+IHFSe/T3E6nBi9RJvETekIde80UBx4iiRCg1sXHrFOWTPmfA+ufoG1KXL5sczNPhTL1eQpTpw==
X-Received: by 2002:a17:906:cb10:b0:a29:529c:1db7 with SMTP id lk16-20020a170906cb1000b00a29529c1db7mr822402ejb.44.1704703971134;
        Mon, 08 Jan 2024 00:52:51 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id uz29-20020a170907119d00b00a2aae23b414sm666046ejb.26.2024.01.08.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:52:50 -0800 (PST)
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
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/3] arm64: dts: mediatek: Add initial MT7988A and BPI-R4
Date: Mon,  8 Jan 2024 09:52:27 +0100
Message-Id: <20240108085228.4727-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240108085228.4727-1-zajec5@gmail.com>
References: <20240108085228.4727-1-zajec5@gmail.com>
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
V2: Drop thermal zones & reserved memory from .dtsi (those don't belong
    there and we also need thermal controller first). Fix compatible.

 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 11 +++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 97 +++++++++++++++++++
 3 files changed, 109 insertions(+)
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
index 000000000000..5a778188ac21
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt7988a";
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


