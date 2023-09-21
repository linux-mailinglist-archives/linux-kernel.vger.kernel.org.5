Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419F17A9EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjIUULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjIUULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:11:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B940573F2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:27:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a6190af24aso154680666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317261; x=1695922061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqq71BmglqPdWoPEtToCLWEFpVEun8ESIoG7WuZgwYc=;
        b=eHAjTBl5IvZXytb+ifCFx+B1FCRqLMVzHM/ky1Bfe2ZJ2TQPdj5TW0V6NK0lgofKF7
         YOfoldrwqSMw3jKWvAJBYWfRah94kHxZSfAjt2NyH6O9DYNDjf3MBi7vIED8YhHL7XwY
         PEHLMfqVBUnXgg66oVoyxEnLfhP+cuEaR3QMfm2IP4KPITZdLfEFYRTWsWeB2tlnqWZJ
         S2kowSgEnk3+HFyVnyml2DLqFT2LEbN/0NUuemDpzLFXqcr0JbT/RyegQ5l0qItQa8Ib
         wviayTebuYP9/0MWxgFwr6cZ6muJpCUj5XJe/yE1DWN8JOolbK0hfQ7pV4jC5AL3pU7D
         MEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317261; x=1695922061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqq71BmglqPdWoPEtToCLWEFpVEun8ESIoG7WuZgwYc=;
        b=RdSkhOjyiWhMdFux3/8drYxYVJIVKa50jbJQuC1NU1zjscuwsHP7ZzK+clWkUQ2HBW
         Xf7gszjNhGJIf11c1N/5UUWn9B20/Z9JKH85OsAqzhe//TQP6Eoy465vrgWO7BTt4qgt
         RBdYfhqVkSnIABhAEwRoxqxjPfMXN+hVdjcvcBW0y7zf4MC7lZAtd9odK+Wpt02/KgX8
         AVu0sJ3q1Ue+7rbVIJGYUhQ6glcsjjgxBUeNOldw+XeNI6M8nPistjGOHq0CAVNzS0HR
         hXoNUqtJgsff1W4Lw1Rqp3/pHClCY3BBXK113kXhI6CTOB0lhKZLdcqw7HsCqmgImx+C
         6ynQ==
X-Gm-Message-State: AOJu0Yy+qIgK7R+aXMy2tekifcJZv635fh0Jk5YpeZHTuqLnZux6usJB
        C/lVqe3vCgV0S1ytYfCNAjeC2rlv3vIVd2zefy0=
X-Google-Smtp-Source: AGHT+IFR1kbbxTRWEH9mw/Vp5hxxeIOn40wseoaICuj9UqBtVI3f3zQkL5poxy1AfUdKYxKM6xtXUg==
X-Received: by 2002:a17:906:314b:b0:994:555a:e49f with SMTP id e11-20020a170906314b00b00994555ae49fmr5565998eje.31.1695306776297;
        Thu, 21 Sep 2023 07:32:56 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:55 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 16:32:44 +0200
Subject: [PATCH v5 5/7] arm64: dts: mediatek: add smi support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v5-5-fa6f03680832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=lJi09wmfuA1CnXJrdr2+qCC0CVBcfrZwevdWJeNOAo0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQPeEVAosQevQAqB7DoM0uAAPVMlpfJ/ukAvN/9
 bwraReqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURaBED/
 9eQyPJqcaKtboU6kfg6hZoH67UPapjGCGlzPX+xN+cp/AidAM2WYleo1XPoIXxOcKmAeuXc3t+Riqk
 Jf9KAYa+FVlFWxo6o4et8YVILM2za8IBVlX/YvMFxDQqd3n13pdxaNf2Y+m8misSokZV6QZaNso/J+
 j8JVdwu/MpisGqVHHTyNa0xcUkm4cXj7Q0vxwX5KnONMvD976B3zZ3nNjCWxsMMpeCG6qMsXILJr53
 BXbZjkP3LvdzxVDTdmeAelVFG9vzFCDR2PIYKqUcZoyUyiAJ55CA79a1QcECE9voFPZQhT1yTMb4xg
 AxvT/C1KQH0JLIlN1+N/5RuNQYyeSCGulEdhdMsCGvk0UJlCtb7GUF1rO/LVujU8X493BHp95rqAS1
 bJXtF0AeSfp1sldVPNb+8BTNMNYhX9xXtqUehSBBHHULhV9dIvJR+Kv3SaF7cPpqVf0+8T+8NjfSd1
 Nb7pBdlZxMenbZlec/2EzaPvyGzHeeg5S4XIh0KIccn70OnaSK4hLrkW9jG5rATgyH6eo7LT8gdYOz
 Oe5kmSkiIBKyG0REtL1u3wZID1KitQFJeStZLw8Dy0H/+gN94gM2/qi1c2gCh5Mw+/hOo5HqC5M4TG
 Gp9/t+mnQ+hzYN/7IM2nTEKP1mea5sjxYsga5c8EeNn0nHddqwE33d/vL7fQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

