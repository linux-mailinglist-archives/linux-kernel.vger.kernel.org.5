Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3547A9E70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjIUUCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIUUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:01:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6CE5A003
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:28:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so1533793a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317330; x=1695922130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clF9IqfWOEF59ajJbesUMGqxvJHi1IjyVraJZokbP8Y=;
        b=sFKW/g69BfWuxV5d+mtZY/+gNN+TMq0l5E9mYaSGfcApC3cH1ANQc4gez4w7iw+Nr7
         fiNN6SU4G7wKGlVxWfkXpafXiAwSTUcYM2MvdEGkWCOjpvCYAnRh186C09DL7b9UyxNN
         uZmfj53pjGpj8QzZ0SULMaxgMMB7VcWKm292oktv2NaiiP1YjOkF6vcqB6tR8H8rRW8U
         vUgB8quVcplxFv+gHxcH0Nv2WA3chNn1YPRg/CempL0Or5DrIF/YiL5+ONpDX/9feKfv
         QAe6mtqYe94hAIBwbNm4PYBYwcPm+TbHR5sXGk4aVtuQchXkQ5HRGQjWVxIUSUrbFkul
         waUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317330; x=1695922130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clF9IqfWOEF59ajJbesUMGqxvJHi1IjyVraJZokbP8Y=;
        b=tkS/8ID4qyy9fzu421FP81Jj+4NX5t0pYQdX3VpaJWj0VvjNnNs8xc6ZLkWGDu4Qq9
         m7mh46XCVYsJ++sVD709hEHFfn9PSeR8zA902jrXEVNj+5Cct8Czdp4YSiBkuMsU5ffi
         HuYxBHJEjK9UyU+JoiDrLvpbM7r21VaTpR3U63xnrYuHSbKDAIL01AGr/tycSk7fGCZO
         ZJ8MyANOfhZnnNBQanSPqCu3nAZ/G3weVZU0WwpCF1hdbjuqOrnFv2LUVJtok+/Mv1DQ
         sCqTIge0v9TByZO4rnrp5VVkZm95CCSwc4BWeB6dFzV4J16m9BDLv4RDCdBo2TknFlyb
         Z0WQ==
X-Gm-Message-State: AOJu0Yy8XkMao6+BfIGc+qNcxAbq6LolGidETnTZOqKP6acIw4K+EclO
        sbIJG+R+Q8PsWwCpsYlbF5D1Cnj7I0PGZu1VNXM=
X-Google-Smtp-Source: AGHT+IGL6wW3Rr3w7swzuaKhiPgr5LXLt/JSurYW2bGA+fNjoRuyyz3oGNC765SMK7LS/TQpTDlyyg==
X-Received: by 2002:adf:e18f:0:b0:321:8181:601e with SMTP id az15-20020adfe18f000000b003218181601emr2755407wrb.8.1695306774656;
        Thu, 21 Sep 2023 07:32:54 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:54 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 16:32:43 +0200
Subject: [PATCH v5 4/7] arm64: dts: mediatek: add power domain support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v5-4-fa6f03680832@baylibre.com>
References: <20230207-iommu-support-v5-0-fa6f03680832@baylibre.com>
In-Reply-To: <20230207-iommu-support-v5-0-fa6f03680832@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4724; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=gs34qYbpVZeuz1fNLXc7xbInSDTbehayNY8q/g3uDQE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQPaUQqGai3yH9GDhiKpdCa0NV6X3mBNft+IK0B
 FGe/ky2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURTsaD/
 963hW5XvHhEhM+Lk7WW13Ll1D0xFvoL9s3ixFhZf3TLG5k5S8VjBvoLUpy2/rYh8K+dgaffMknD/o7
 6N7WDsyCjN8LE89S/7DyXP1mxT/685L6TTNjwO3hBpdWIG4lpfgqtjeVZbMGELceLG6T5WRymm0Eh9
 WIUHQBrXQdkyZOeIXcqLUw4jRdFB50olpwRA5CCJqI21sTzDfe9DgPQdtZrq+R08OhKJ5tehnLlGL8
 51ahNbgFsT8ZlS740Up6Nijebsa0JOZUeI6nDh6DSnMA1eGF0ExD9tEmIaDNfsiOOGaWlEdqqIZ6pl
 yIS8xK4UWq9ut/shJpSTyHj5x7VGBu7mUyQZo1u9hw7v2IA3lKe8FkPWKzvYkPblA7xGEczvLJK/1v
 pwCE5leSLQCFrW4VE5Gyx6oyK3QQF6+Ewb6dTaLKD0OXzYxz19zZW1MvPALuSTsCxfz6oJxLBecI5S
 Y0nbYq81Brve4rzoSe7vh+AS7SpN8tbtmY2rLPEDHD9UF+03ohSJvS11RsJ27ehts6KYzc32YTeZyQ
 3MsDC43KwUXhQLCRIg4rXYE4jAt9qNI4RM7ifDY9BEyDoWWayQzWELxCiqFHtkTUxn5t30HedixOR9
 xPXcTpwhPD/x3yms/HXehgUXNIseyzEExN2XmFR0Y9rHJ5Ro8M25sH2N2R3A==
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

The following power domain are added to the SoC dts:
- MM (MultiMedia)
- CONN (Connectivity)
- MFG (MFlexGraphics)
- Audio
- Cam (Camera)
- DSP (Digital Signal Processor)
- Vdec (Video decoder)
- Venc (Video encoder)
- APU (AI Processor Unit)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 110 +++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index c3ad7cbc89ab..c2f88d153dee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/mediatek,mt8365-power.h>
 
 / {
 	compatible = "mediatek,mt8365";
@@ -298,6 +299,115 @@ syscfg_pctl: syscfg-pctl@10005000 {
 			reg = <0 0x10005000 0 0x1000>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+			#power-domain-cells = <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8365-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domains of the SoC */
+				power-domain@MT8365_POWER_DOMAIN_MM {
+					reg = <MT8365_POWER_DOMAIN_MM>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>,
+						 <&mmsys CLK_MM_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_MM_SMI_COMM0>,
+						 <&mmsys CLK_MM_MM_SMI_COMM1>,
+						 <&mmsys CLK_MM_MM_SMI_LARB0>;
+					clock-names = "mm", "mm-0", "mm-1",
+						      "mm-2", "mm-3";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+					mediatek,infracfg-nao = <&infracfg_nao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@MT8365_POWER_DOMAIN_CAM {
+						reg = <MT8365_POWER_DOMAIN_CAM>;
+						clocks = <&camsys CLK_CAM_LARB2>,
+							 <&camsys CLK_CAM_SENIF>,
+							 <&camsys CLK_CAMSV0>,
+							 <&camsys CLK_CAMSV1>,
+							 <&camsys CLK_CAM_FDVT>,
+							 <&camsys CLK_CAM_WPE>;
+						clock-names = "cam-0", "cam-1",
+							      "cam-2", "cam-3",
+							      "cam-4", "cam-5";
+						#power-domain-cells = <0>;
+						mediatek,infracfg = <&infracfg>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VDEC {
+						reg = <MT8365_POWER_DOMAIN_VDEC>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VENC {
+						reg = <MT8365_POWER_DOMAIN_VENC>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_APU {
+						reg = <MT8365_POWER_DOMAIN_APU>;
+						clocks = <&infracfg CLK_IFR_APU_AXI>,
+							 <&apu CLK_APU_IPU_CK>,
+							 <&apu CLK_APU_AXI>,
+							 <&apu CLK_APU_JTAG>,
+							 <&apu CLK_APU_IF_CK>,
+							 <&apu CLK_APU_EDMA>,
+							 <&apu CLK_APU_AHB>;
+						clock-names = "apu", "apu-0",
+							      "apu-1", "apu-2",
+							      "apu-3", "apu-4",
+							      "apu-5";
+						#power-domain-cells = <0>;
+						mediatek,infracfg = <&infracfg>;
+					};
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_CONN {
+					reg = <MT8365_POWER_DOMAIN_CONN>;
+					clocks = <&topckgen CLK_TOP_CONN_32K>,
+						 <&topckgen CLK_TOP_CONN_26M>;
+					clock-names = "conn", "conn1";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_MFG {
+					reg = <MT8365_POWER_DOMAIN_MFG>;
+					clocks = <&topckgen CLK_TOP_MFG_SEL>;
+					clock-names = "mfg";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_AUDIO {
+					reg = <MT8365_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+						 <&infracfg CLK_IFR_AUDIO>,
+						 <&infracfg CLK_IFR_AUD_26M_BK>;
+					clock-names = "audio", "audio1", "audio2";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_DSP {
+					reg = <MT8365_POWER_DOMAIN_DSP>;
+					clocks = <&topckgen CLK_TOP_DSP_SEL>,
+						 <&topckgen CLK_TOP_DSP_26M>;
+					clock-names = "dsp", "dsp1";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8365-wdt", "mediatek,mt6589-wdt";
 			reg = <0 0x10007000 0 0x100>;

-- 
2.25.1

