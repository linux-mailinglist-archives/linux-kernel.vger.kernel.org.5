Return-Path: <linux-kernel+bounces-147182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B68A70A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B681C215FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C26B13BC36;
	Tue, 16 Apr 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ciwj3xFY"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2C13B2A4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282830; cv=none; b=kN+4bx3u5sasfJ06vzz2SMj6oOkkZa5g8/8w4n5vsEtrP8qDXHzjxP78io1ajFLHOiomabpl7d9str6Jq7tKqLB0RhY/K2t1iLoUa3AZR11J+fVxxtvEzbZHQyqm8PaG4r7HA34c87SpKQnBoLzXxVwYoh+Z24sQz+lycFmYPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282830; c=relaxed/simple;
	bh=Je6MV7zYnEgJBAa2y3wMLhKFqHHT2W/QwQ4yB0KiBX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9d/sflcwKA+jOFzuTrEQqC2iU8zGfF8SfaPXWIhMN/ryyPiE4lND973daQfH8A1/AVn/gvVYkUnoTKHzJWdHL7q+kcna2PuC0kkGYllr0t4AnvS1YU5euqKXOrLLJF/sFrX/LuygNdCAfO3bpEawkCss8iJYHHvzZLkt8e6twA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ciwj3xFY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57009454c83so4003005a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282827; x=1713887627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xDvvUPmtzf8YnX5VO4+ExnFhszPyGilyEKMtRDvoyg=;
        b=Ciwj3xFY9gJ5nvRjD2NpJTbV2va75NWfIE2Os0ftuHg+xdeRU2g3ieSc+9ktbfphLF
         2mbPB6Wj840t8tqavGWr+zM0gjwUmAwKn6bahlfuNFArbQQuZjVDCzQ4yzaciaZsywnE
         NkC2IHq3u0L7vX7LhNxSR6D6a+HpwKA8Gme9oGi3DiWGTN++VqFXx45i/m5GE48sMWEf
         6eIWnnPGF5z+e033+QYKyLRao9f2EUnZhMD4zSmy9eTMa8+CEBDA0N/TQmN7yydZQryq
         2oqJ+/PHdcjvo6+bcOBjh1M07S5UzT7zoQ8N5a8ef5hVQGIRtc0TbdOcUIBUQiWKWhYw
         9lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282827; x=1713887627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xDvvUPmtzf8YnX5VO4+ExnFhszPyGilyEKMtRDvoyg=;
        b=lIPhmrdfwOnBJbBCglzpsXikfsnyrNO6281+t2GMIgd6gWgIutVGWW/ZSX5ybhAoUf
         UmhoMjyF+Gc9rfc9qihmTIf1DA+nug3YWNZiBH4LajgnSE1a9FKhNUe3ixUV+04jgjVD
         ZF/qs3H6JGcxCBOQ7lzMadkO24Ck1rG4aoXo59LwDloXfdvd26sm6kyHNYO44GADD8rO
         xvSYqWi1e7kSKrhBDexYMR1O5FqgZzNW84zJDBu2ViEH8tqLyiylj0MLldNHv5pNS1JY
         7w7A4PChIjWt/d+m5hLeTAHf9YBdFwX4aSVECyZ8crGHD3H5ohR1FojVvMZL+c8eZ64k
         2u6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6X88kiegfz4Gb6OkLFmG9t5jwjvVSHlKMBXXg9UTIheB5i+mCT7fn5w9PNTjk7dUjR5V/ySI0LalK+1IpRHXbbyHDsdvAzCLPW9qG
X-Gm-Message-State: AOJu0YwnP+7qvzzBZbRaxF8GyNOi410s/wdDZrs5966nUIBUMRvh7hev
	fS1i+YbcV7Doc5DLKiigNvBAqrHskBV6dN8E3k5dxS0qxseFHcbxbFhpYy/Pt/0=
X-Google-Smtp-Source: AGHT+IHqNP4eDOND/pFYT6lJIoBvlaJeTeBp+Ry8h2SJ1b6D3Xlvm3LQ0ugDLQZI0f8tW/Be9psq0w==
X-Received: by 2002:a17:906:54e:b0:a52:6cdc:c83 with SMTP id k14-20020a170906054e00b00a526cdc0c83mr3507234eja.64.1713282826850;
        Tue, 16 Apr 2024 08:53:46 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:46 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:18 +0200
Subject: [PATCH v2 17/18] arm64: dts: mediatek: add display blocks support
 for the MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-17-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7069; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Je6MV7zYnEgJBAa2y3wMLhKFqHHT2W/QwQ4yB0KiBX0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qQc67h9xNW7lKwOqsAZ3Awb5scXlRwhswlbAG
 QHw8dqOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURQt2D/
 4shkLROp4fn+W8X8AYfb0+SNisDC0+HXTJXzj/kLqUswJuSRpCpG9qKW3DdNyzo/jeUF2yuY5XtsjI
 +1VprTswJP/Q43UJauQVODzpI39BKk5jlq2awci+ltU+b540du62GsCocim+JNj1MSMLT8R/MXfcqc
 d9YGbkXJljT9cqDnN0splwAnA9i644til2L53dqsWnHIJEcoYdcdy8SnslSh14csHT89E2zENgArGZ
 JKl3XffXEZtZ9kr2kn8KGhp2p3gR6e5mxPNuro8FcN2kxr3lZwDz9VyLfw3sSTGh08b0nWKKEdHVKE
 lQLGmjCLUkeqywtUD2QJbUUH8I7a6/nzoLl5st2ytSHxdgWQmWI8jOrypayX/vGGkZyYRuzIWBCS2n
 XQDtlay+oBOXwkqKHk5Sx+iJLtHvxsU/7LX/rK6NbPzz0CnCaSWj50gxYFslCxm5ITSZydTqXAPgAB
 kGOPHpcywWP1axdoYPlIxbuxxrlRylJrgjNtzwWN8ve2fSy2LI3z4qHTJi83K8kGJRxTB8PP263EgA
 28uC8eQwWOyebX32OL95YfUiKsPJJ9RwkhdjWjOiqqrHGH7JiwosVNiiCK2wWWT5ccxOoLtKrOX/9W
 6FI8HKw+Tsq8KBDKVmNVQahuDPUswOtm+o+/+y5yWpIDbtOy5Kpb8NpuwMFA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

- Add aliases for each display components to help display drivers.
- Add the Display Pulse Width Modulation (DISP_PWM) to provide PWM signals
  for the LED driver of mobile LCM.
- Add the MIPI Display Serial Interface (DSI) PHY support. (up to 4-lane
  output)
- Add the display mutex support.
- Add the following display component support:
  - OVL0 (Overlay)
  - RDMA0 (Data Path Read DMA)
  - Color0
  - CCorr0 (Color Correction)
  - AAL0 (Adaptive Ambient Light)
  - GAMMA0
  - Dither0
  - DSI0 (Display Serial Interface)
  - RDMA1 (Data Path Read DMA)
  - DPI0 (Display Parallel Interface)

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 146 +++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 24581f7410aa..a95f90da4491 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mediatek,mt8365-power.h>
 
@@ -17,6 +18,19 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		aal0 = &aal0;
+		ccorr0 = &ccorr0;
+		color0 = &color0;
+		dither0 = &dither0;
+		dpi0 = &dpi0;
+		dsi0 = &dsi0;
+		gamma0 = &gamma0;
+		ovl0 = &ovl0;
+		rdma0 = &rdma0;
+		rdma1 = &rdma1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -607,6 +621,17 @@ spi: spi@1100a000 {
 			status = "disabled";
 		};
 
+		disp_pwm: pwm@1100e000 {
+			compatible = "mediatek,mt8365-disp-pwm",
+				     "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100e000 0 0x1000>;
+			clock-names = "main", "mm";
+			clocks = <&topckgen CLK_TOP_DISP_PWM_SEL>,
+				 <&infracfg CLK_IFR_DISP_PWM>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+			#pwm-cells = <2>;
+		};
+
 		i2c3: i2c@1100f000 {
 			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
 			reg = <0 0x1100f000 0 0xa0>, <0 0x11000200 0 0x80>;
@@ -703,6 +728,15 @@ ethernet: ethernet@112a0000 {
 			status = "disabled";
 		};
 
+		mipi_tx0: dsi-phy@11c00000 {
+			compatible = "mediatek,mt8365-mipi-tx", "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11c00000 0 0x800>;
+			clock-output-names = "mipi_tx0_pll";
+			clocks = <&clk26m>;
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+
 		u3phy: t-phy@11cc0000 {
 			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
 			#address-cells = <1>;
@@ -732,6 +766,13 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		mutex: mutex@14001000 {
+			compatible =  "mediatek,mt8365-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
 		smi_common: smi@14002000 {
 			compatible = "mediatek,mt8365-smi-common";
 			reg = <0 0x14002000 0 0x1000>;
@@ -755,6 +796,111 @@ larb0: larb@14003000 {
 			mediatek,larb-id = <0>;
 		};
 
+		ovl0: ovl@1400b000 {
+			compatible = "mediatek,mt8365-disp-ovl",
+				     "mediatek,mt8192-disp-ovl";
+			reg = <0 0x1400b000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_OVL0>;
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_DISP_OVL0>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		rdma0: rdma@1400d000 {
+			compatible = "mediatek,mt8365-disp-rdma",
+				     "mediatek,mt8183-disp-rdma";
+			reg = <0 0x1400d000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_RDMA0>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
+			mediatek,rdma-fifo-size = <5120>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		color0: color@1400f000 {
+			compatible = "mediatek,mt8365-disp-color",
+				     "mediatek,mt8173-disp-color";
+			reg = <0 0x1400f000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_COLOR0>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		ccorr0: ccorr@14010000 {
+			compatible = "mediatek,mt8365-disp-ccorr",
+				     "mediatek,mt8183-disp-ccorr";
+			reg = <0 0x14010000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_CCORR0>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		aal0: aal@14011000 {
+			compatible = "mediatek,mt8365-disp-aal",
+				     "mediatek,mt8183-disp-aal";
+			reg = <0 0x14011000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_AAL0>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		gamma0: gamma@14012000 {
+			compatible = "mediatek,mt8365-disp-gamma",
+				     "mediatek,mt8183-disp-gamma";
+			reg = <0 0x14012000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_GAMMA0>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		dither0: dither@14013000 {
+			compatible = "mediatek,mt8365-disp-dither",
+				     "mediatek,mt8183-disp-dither";
+			reg = <0 0x14013000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_DITHER0>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		dsi0: dsi@14014000 {
+			compatible = "mediatek,mt8365-dsi",
+				     "mediatek,mt8183-dsi";
+			reg = <0 0x14014000 0 0x1000>;
+			clock-names = "engine", "digital", "hs";
+			clocks = <&mmsys CLK_MM_MM_DSI0>,
+				 <&mmsys CLK_MM_DSI0_DIG_DSI>,
+				 <&mipi_tx0>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
+			phy-names = "dphy";
+			phys = <&mipi_tx0>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		rdma1: rdma@14016000 {
+			compatible = "mediatek,mt8365-disp-rdma",
+				     "mediatek,mt8183-disp-rdma";
+			reg = <0 0x14016000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_DISP_RDMA1>;
+			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
+			mediatek,rdma-fifo-size = <2048>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
+		dpi0: dpi@14018000 {
+			compatible = "mediatek,mt8365-dpi";
+			reg = <0 0x14018000 0 0x1000>;
+			assigned-clocks = <&mmsys CLK_MM_DPI0_DPI0>;
+			assigned-clock-parents = <&topckgen CLK_TOP_LVDSPLL_D4>;
+			clocks = <&mmsys CLK_MM_DPI0_DPI0>,
+				 <&mmsys CLK_MM_MM_DPI0>,
+				 <&apmixedsys CLK_APMIXED_LVDSPLL>;
+			clock-names = "pixel", "engine", "pll";
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+			status = "disabled";
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;

-- 
2.25.1


