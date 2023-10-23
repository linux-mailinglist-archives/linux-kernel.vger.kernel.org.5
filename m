Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752667D39DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjJWOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJWOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:42:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911181FED
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-778999c5ecfso239462485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072078; x=1698676878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7LsImvOXL0o3XHHExR7Yh7FPNSroEzRfhHt2s1V9mI=;
        b=ts8j3P9AqVBZH1jP7HfKpKHrnoi7Z11zcbDsRVMwU46OIjwgjzXuXaAdpAnzMkRaE3
         VTSwL0O2RO8Q5L4trtPBvZXDRPpESczSdLBYFTQGQNGZ/78Hys0JP1ud+hFIg4KyEmBh
         SxKubfNxK0tKakfybuiNRsfxCRZCBVOaUU8DOjYwxowfaP+r1jXL8BiYkLrfUTBLYyTK
         W/Cy4E/80h/k4hDHQUFiIslBvdDHLhIEgv8Xzul2tzqcgZheNs0Y+qujtsuUjbKX0oI8
         39CVRNvWdvoqqJklQANTbl9qRxCoqW4LgWhbPexYzlaHeBZT4Kqvz2+QIofLV1eUAhGg
         BhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072078; x=1698676878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7LsImvOXL0o3XHHExR7Yh7FPNSroEzRfhHt2s1V9mI=;
        b=sYDlxwFklnoXXTqykxnuYs1JJ0l7cudTzEdSJWS953v4QZQz1BFtyhAK7Q5mAnHvQO
         jC3sWoGidOlRl4dXTfEz3f64L9UBprLakxFzB49NwUk0qqsbMJ0LbVI09zZP5mFRjFE2
         URfohRwxVTNlc8b/ilo0tFsvgQWtT4wm2eaAHVjKIBbx5RbsctklMuTIui+i/xz+mrEY
         t2MZzAYTfG59CdCNW/+cRX3FGPP9kRYIT0YM5P9HUNnaFVHpWbg0WuX59sy6oy5xloUg
         ugghZH7lC1xaPoHlniMGPSa8JMpTWuLLRbcfPoiDv45A0XffqjyotbkqNnPnZyX3KISa
         Dt2A==
X-Gm-Message-State: AOJu0YyyN1mj7qsHDAfi1pLsaLPF5UF9g9DKDLb3m40HfSn0+AGqe/gH
        uKqwEleGL0jMhIlaSCbhAbuAiQ==
X-Google-Smtp-Source: AGHT+IGiTzHbMfjG/TOhYPZrSyreD2Vic10suD7z5G5gbFvXkGq//tiEzy6adCX/CC/3rJOsIkieCA==
X-Received: by 2002:a05:620a:440a:b0:76c:ea3f:9010 with SMTP id v10-20020a05620a440a00b0076cea3f9010mr10992717qkp.16.1698072078098;
        Mon, 23 Oct 2023 07:41:18 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:41:17 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:17 +0200
Subject: [PATCH 17/18] arm64: dts: mediatek: add display blocks support for
 the MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-17-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7082; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=GrqIHwd0l9+44q9ggVwPid+Zd2sZPQpFOwpuTf1SwWY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPPcsd/oUE0a9NY68W+0Ky2eNYAfmRaFOVUlwY
 Fr2tBLWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURVuAD/
 9o/qWcsErVbAO5/ec3rAt7R2x0P+I5D9RaBuukKd7b5m0IE8U2CBqbNivJTaA/t1LbRzwHzC/ah3SS
 qcyz6vE38fXyjCrpFRt42IuTSxMk4lIIuK4BsyGjPznAyL/HH+70O88uzw4B83x9VvvjFAVjB5YVMt
 SAwZL+wQ0bI0FnauDW3PCkEqasdIzWz3BRGIolJ7iKRM7iZwkqPdgE9FHCNYIyQvdn+fnFG6ZEDHUA
 fyJs0SK2JzrQugPsFxjQsQawuQRMPm+/WME13iCojHuImZbJCQIeLyhem98xq7c0ludW+1oMLfifTK
 y5h+azpqOFnG4PAV2bZN2ECUI/tRB4BQxsCIk3gPprDxOFnDGe7A1F9ubDPtJJijvDMF1P+kiLHFEU
 RMPk8O/Y3/c2bV7RzKBjy00byPbBTAuXzn1AQZBEf5OtXaRs7wBoe/RzeUUAU2zOzy3wimMs60FYmy
 DKhDKnjDBkS9199Ia+X3b4UeW1l6EhCWGSmovYgyBiR6sG3/H6l5TK93YAKRw0SQH9gsdZHHwJ9iE2
 Dwza+H2EfJkCqNLCWo4QEyZ3kq9oK0VipWezsJM97k7wcb4wwC9QyPoN5P0uQdPvIJoaNvdibfJTjC
 CtBA02Hj+qRBmGlS6x6KvQfcGrgNZn3l/9H00K1MIdGTlw1bgYX4tfEJKang==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 24581f7410aa..6096358f7d07 100644
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
+			compatible = "mediatek,mt8183-dsi";
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
+			assigned-clock-parents = <&topckgen CLK_TOP_LVDSPLL_D4>;
+			assigned-clocks = <&topckgen CLK_TOP_DPI0_SEL>;
+			clock-names = "pixel", "engine", "pll", "dpi";
+			clocks = <&topckgen CLK_TOP_DPI0_SEL>,
+				 <&mmsys CLK_MM_MM_DPI0>,
+				 <&apmixedsys CLK_APMIXED_LVDSPLL>,
+				 <&mmsys CLK_MM_DPI0_DPI0>;
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

