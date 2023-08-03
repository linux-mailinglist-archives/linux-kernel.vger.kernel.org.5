Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D176E4C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjHCJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjHCJlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:41:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AC32129
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:41:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so633505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691055670; x=1691660470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqq71BmglqPdWoPEtToCLWEFpVEun8ESIoG7WuZgwYc=;
        b=WnhUHoeTUptr5l4v/vwdEeIp0W2YCBwoMwYLNFhtvsJrji73kXfUshz8FQDgZihQoo
         Kp/wuue2SecUj17IQHm3gjVjn2ALZalxmLldUxJLX0dbc/ObcWTMsEInHC4Eg8+xffAG
         EDjl3LHCZPES5+Fpnpt7aq80jNlxfeh8hHFB9+4Cf2epIbOugmCsTfllqtRrGuTfoHfO
         G5jctLGJRzJNuYy/3wz5wR0B0gNubQUfGHtMfBCaelVfuyFiP+OUBAyrSqgDtVGkX8SS
         qvjCZznWazW6b5p0uKGeuGOXg71VZEwsZmmMDMJ21AVRiLfuaC9NHvpV7YrJs7ZBK7gy
         52wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055670; x=1691660470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqq71BmglqPdWoPEtToCLWEFpVEun8ESIoG7WuZgwYc=;
        b=TW/4oP9XgBnPiGFSHNBV3agSMXZe9kGwMBO2cEe3equeVnB13J4/93Fd2cDp5to2js
         NnE/eteFuJNaPuTHtlfvtWYx3/M3/4TJTk8Z2kMwkOpFc3BxfVjIa/A4v0oqfGHM82h9
         DnC0ZIakkV8Xsy1v5qP2zQvDU0INmZ245O4r+d/2mQ7O/P+b0clRyweZykzJgO/ZSOma
         +C8Y1E/2eeeIEG/t9mw1EEy03TbjirnuSGIIDuaO7IJJK5dcPpENZRPB6oq8Zck26z2B
         nd6vUyHaSwEns9pQWk3ajICuTU0U3MTUivmX1/NrgfMl59z1xRl43XJMbBzrQ8+Vc5DA
         9EfA==
X-Gm-Message-State: ABy/qLbd3uivJhVKMlAK5ZCstP3ctU5su5ekUTJNdyFvCcNe65/F6/jU
        oKYfkmkaPHESoxQmigWnG3/VPQ==
X-Google-Smtp-Source: APBJJlFjYPT4M218ADNSnzkr3IWgI8sSPk0J+nYARdhmfuCH1saGPdRYT0ZqdGtrtzHHcgQGmMNDOg==
X-Received: by 2002:a05:600c:b52:b0:3fa:71db:56ff with SMTP id k18-20020a05600c0b5200b003fa71db56ffmr6590901wmr.40.1691055670541;
        Thu, 03 Aug 2023 02:41:10 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm13294994wmq.1.2023.08.03.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:41:09 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 03 Aug 2023 11:40:57 +0200
Subject: [PATCH v4 5/7] arm64: dts: mediatek: add smi support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v4-5-84798657c410@baylibre.com>
References: <20230207-iommu-support-v4-0-84798657c410@baylibre.com>
In-Reply-To: <20230207-iommu-support-v4-0-84798657c410@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=lJi09wmfuA1CnXJrdr2+qCC0CVBcfrZwevdWJeNOAo0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBky3Yu3yeqBTweXTt4cjB1hcjTBIfzC12xsT49Nncx
 PSlXDyOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMt2LgAKCRArRkmdfjHURYI2EA
 CCouYESfKP1onbfZhLrWVjFgWLu6PqRRHJ63+175fKOdum61IMImElsCVOkQRk4lVT8166SgtXvRKk
 so5hZRBIqgRJWEKDjyPaFDgg8SsXWw41ZOLuqCH4Expc9tkYflCBo6WfSTMNgvXL01+VHi+5TwhffY
 AyIZu1CGtkY/NQhi/hi98lgFAB9O+FSxkxqbJHpS2bKo9IEyuez1FxqQXllawa196TQyEQg35RLzUw
 cRbQAWF476YQ0DN1QZf2bs2msBOV/n9aAqDcEYOLbTlKWB5Cm/lsC8ZrL9P8ibUZIN4qZmLiqhcQ+9
 KBVaVuNCI47Y0sqI0Dr9gL0qQ2s9n2lyYoI4lmyIJk5ObJMJVuDSb1NRi10lGJZfYfcnIl/yhvWWJk
 cwa3pE2yJRCib6ZF014i5tH6kjuWgQTiVkdXx23WTCldhjUroQf/wKP4O0pd0l+6ovu9B09Mi7PtVE
 1EVIktUj/teOcf/PZZGW0y6Sa/iuYbjmhROyEXVNkKgN1fYuNgBHvpmKjCRyGMYbl+tK4NGun3Mawz
 FzWMbySbdTecoiwuRAdMV30/TLi8P2P7Bk5FnwHUBQIYm820jhAWVlC8R+8kVDEjLTotZ+3tdY5qi+
 Z2mHMQ6S++b9Rsns53ghYOz8JIodTVyLN2wx6MGSsJCI/81ZcS1uP5rIgu8w==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smart Multimedia Interface (SMI) local arbiter does the arbitration for
memory requests from multi-media engines. Add SMI in the MT8365 DTS will
allow to add local ARBiter (LARB), use by IOMMU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index c2f88d153dee..a03b8c0da68b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -340,16 +340,19 @@ power-domain@MT8365_POWER_DOMAIN_CAM {
 							      "cam-4", "cam-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VDEC {
 						reg = <MT8365_POWER_DOMAIN_VDEC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VENC {
 						reg = <MT8365_POWER_DOMAIN_VENC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_APU {
@@ -367,6 +370,7 @@ power-domain@MT8365_POWER_DOMAIN_APU {
 							      "apu-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 				};
 
@@ -720,6 +724,17 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14002000 {
+			compatible = "mediatek,mt8365-smi-common";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMM0>,
+				 <&mmsys CLK_MM_MM_SMI_COMM1>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;

-- 
2.25.1

