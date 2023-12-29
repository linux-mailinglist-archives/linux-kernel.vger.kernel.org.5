Return-Path: <linux-kernel+bounces-12982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7081FDF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18FE281706
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA358467;
	Fri, 29 Dec 2023 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSGc2CV7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1863A3;
	Fri, 29 Dec 2023 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d60a96533so20325005e9.1;
        Thu, 28 Dec 2023 23:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703836670; x=1704441470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P67FAbYgYiwNxp7OFTRw42rLTF9X3i2GMJZApqfKWc=;
        b=VSGc2CV7xh+Wd5i3CXpqKuWqQCHLMsvF+mbUiC1tkoffS/liAY8GFXv927BV6lnLLk
         oJ1ozh1fFNHA2ZxwHLaQpS6sKB7Rxzb7Goy9QwwrJrAdS+2lOvPj8377cIq5b4WlXUG0
         2V6ALHEL/IxJfAHu7ljl+VjhMpCC0LdyG9JMUkUao1PKPmZIMaFrY93vEkr73OCUxFPQ
         So0wPydYPF1xYOTYezYEVVsW7LDbNlKP9T/SmAXcUcx1r8ZwwtK7TAUdIRFtrCzc2Lab
         Hbpf1oi6iQGXcazbQejXZtFMq8C2mz0v4acwezoKkeZ8nEoV4pp1Crhyl+xEXwI0CALR
         swJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703836670; x=1704441470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P67FAbYgYiwNxp7OFTRw42rLTF9X3i2GMJZApqfKWc=;
        b=opVNffRSvLl/mzyaaGeLaVHamGcciISAuhy8WzsZ+FGFaCOgFN0iN6H6NhEsx3iVNV
         BZpFb9z2pOk9oBO/KNvebH/cdXLNpl+AxkDDu5NqzGXNorVVP9vdxjnpszokNaIHY9y6
         lKc+y/NH4AS9CH9MDoX/uAgt74W3OCGM2v5EtsUtdp2DugFtmhWS47oWE2YubrSytksr
         Xzsr7LoeSni74iPzLE4+hJ0+wDVfOPTwpkRfQPHiNLaJjMEerg5KsR4nYuN21fU4KeCm
         e25kETtlBZ+ytg5KEOvNaFX2gzBlB7xv8TSIW2BC4Btha3pIW56u4o2SatCEHzHZ22vQ
         19sw==
X-Gm-Message-State: AOJu0Yx5kJ0rJpjTK/KvAGgAccx1FFpri9hWuNXDK/hDCttmR8CaZ5Xc
	kXMTlu6iNlosdFW/tHgkT/8=
X-Google-Smtp-Source: AGHT+IEwDq9rzaVHewB/ph/t8AJ7nJZtNx1u0xpKOQX5/AkLLUa2D36QF/PcMWY6bhsR20lfw6g8dQ==
X-Received: by 2002:a05:600c:2d84:b0:40b:5e59:ccb3 with SMTP id i4-20020a05600c2d8400b0040b5e59ccb3mr5746648wmg.148.1703836669989;
        Thu, 28 Dec 2023 23:57:49 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id wh13-20020a170906fd0d00b00a2684d2e684sm8120865ejb.92.2023.12.28.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:57:49 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7986: reorder nodes
Date: Fri, 29 Dec 2023 08:57:39 +0100
Message-Id: <20231229075739.8328-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231229075739.8328-1-zajec5@gmail.com>
References: <20231229075739.8328-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Use order described as preferred in DTS Coding Style:
1. Sort bus nodes by unit address
2. Use alpha-numerical order for the rest

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 118 +++++++++++-----------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 23feeff881de..a0f28b9ada18 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -16,13 +16,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	clk40m: oscillator-40m {
-		compatible = "fixed-clock";
-		clock-frequency = <40000000>;
-		#clock-cells = <0>;
-		clock-output-names = "clkxtal";
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -59,6 +52,13 @@ cpu3: cpu@3 {
 		};
 	};
 
+	clk40m: oscillator-40m {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		#clock-cells = <0>;
+		clock-output-names = "clkxtal";
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
@@ -121,15 +121,6 @@ wo_boot: wo-boot@15194000 {
 
 	};
 
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		ranges;
@@ -202,6 +193,20 @@ pio: pinctrl@1001f000 {
 			#interrupt-cells = <2>;
 		};
 
+		pwm: pwm@10048000 {
+			compatible = "mediatek,mt7986-pwm";
+			reg = <0 0x10048000 0 0x1000>;
+			#clock-cells = <1>;
+			#pwm-cells = <2>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_PWM_SEL>,
+				 <&infracfg CLK_INFRA_PWM_STA>,
+				 <&infracfg CLK_INFRA_PWM1_CK>,
+				 <&infracfg CLK_INFRA_PWM2_CK>;
+			clock-names = "top", "main", "pwm1", "pwm2";
+			status = "disabled";
+		};
+
 		sgmiisys0: syscon@10060000 {
 			compatible = "mediatek,mt7986-sgmiisys_0",
 				     "syscon";
@@ -240,20 +245,6 @@ crypto: crypto@10320000 {
 			status = "disabled";
 		};
 
-		pwm: pwm@10048000 {
-			compatible = "mediatek,mt7986-pwm";
-			reg = <0 0x10048000 0 0x1000>;
-			#clock-cells = <1>;
-			#pwm-cells = <2>;
-			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&topckgen CLK_TOP_PWM_SEL>,
-				 <&infracfg CLK_INFRA_PWM_STA>,
-				 <&infracfg CLK_INFRA_PWM1_CK>,
-				 <&infracfg CLK_INFRA_PWM2_CK>;
-			clock-names = "top", "main", "pwm1", "pwm2";
-			status = "disabled";
-		};
-
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt7986-uart",
 				     "mediatek,mt6577-uart";
@@ -337,6 +328,21 @@ spi1: spi@1100b000 {
 			status = "disabled";
 		};
 
+		thermal: thermal@1100c800 {
+			compatible = "mediatek,mt7986-thermal";
+			reg = <0 0x1100c800 0 0x800>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_THERM_CK>,
+				 <&infracfg CLK_INFRA_ADC_26M_CK>,
+				 <&infracfg CLK_INFRA_ADC_FRC_CK>;
+			clock-names = "therm", "auxadc", "adc_32k";
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
+			#thermal-sensor-cells = <1>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
+
 		auxadc: adc@1100d000 {
 			compatible = "mediatek,mt7986-auxadc";
 			reg = <0 0x1100d000 0 0x1000>;
@@ -388,21 +394,6 @@ mmc0: mmc@11230000 {
 			status = "disabled";
 		};
 
-		thermal: thermal@1100c800 {
-			compatible = "mediatek,mt7986-thermal";
-			reg = <0 0x1100c800 0 0x800>;
-			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&infracfg CLK_INFRA_THERM_CK>,
-				 <&infracfg CLK_INFRA_ADC_26M_CK>,
-				 <&infracfg CLK_INFRA_ADC_FRC_CK>;
-			clock-names = "therm", "auxadc", "adc_32k";
-			nvmem-cells = <&thermal_calibration>;
-			nvmem-cell-names = "calibration-data";
-			#thermal-sensor-cells = <1>;
-			mediatek,auxadc = <&auxadc>;
-			mediatek,apmixedsys = <&apmixedsys>;
-		};
-
 		pcie: pcie@11280000 {
 			compatible = "mediatek,mt7986-pcie",
 				     "mediatek,mt8192-pcie";
@@ -534,20 +525,6 @@ wed1: wed@15011000 {
 			mediatek,wo-ccif = <&wo_ccif1>;
 		};
 
-		wo_ccif0: syscon@151a5000 {
-			compatible = "mediatek,mt7986-wo-ccif", "syscon";
-			reg = <0 0x151a5000 0 0x1000>;
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		wo_ccif1: syscon@151ad000 {
-			compatible = "mediatek,mt7986-wo-ccif", "syscon";
-			reg = <0 0x151ad000 0 0x1000>;
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		eth: ethernet@15100000 {
 			compatible = "mediatek,mt7986-eth";
 			reg = <0 0x15100000 0 0x80000>;
@@ -590,6 +567,20 @@ eth: ethernet@15100000 {
 			status = "disabled";
 		};
 
+		wo_ccif0: syscon@151a5000 {
+			compatible = "mediatek,mt7986-wo-ccif", "syscon";
+			reg = <0 0x151a5000 0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wo_ccif1: syscon@151ad000 {
+			compatible = "mediatek,mt7986-wo-ccif", "syscon";
+			reg = <0 0x151ad000 0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		wifi: wifi@18000000 {
 			compatible = "mediatek,mt7986-wmac";
 			reg = <0 0x18000000 0 0x1000000>,
@@ -647,4 +638,13 @@ cpu_trip_active_low: active-low {
 			};
 		};
 	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
-- 
2.35.3


