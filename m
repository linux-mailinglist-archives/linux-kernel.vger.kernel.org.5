Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCBC7A9DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjIUTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjIUTnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:43:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D2589239
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:52:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502a4f33440so2248615e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695318721; x=1695923521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxkPmAViZ4bBY9DKE4WBvD6KeHCq77X51+2zFhsJvjI=;
        b=RWdjyFdAPpUIkK8r+giDY1S8bHdIAu9Q/pWCu3GoEL+8Ff70vaXfs3nGfjNgqePbhc
         BoSCxkwU2dakozlAWXZRdAjW/koKzg1odqKscjEqZxlv59dC+zzlJvQ48GbIqSL40FMo
         8r7ma+kYPRs5KjU9ttGZY8h+0ZQ2gYh1+0JFsdItF6LW/a9qQnbD1vKSvKJme7dv/wrv
         zFqlQ2Q/VoBFR0rm/wcqCasMpKnlOb18GxmyvoIYbIfFeXeMa6jyag8/wDmz6IUjCxCd
         /Dq+QGlCCpnbFIW6GlSHUOqYw8kbVP66FENVrQoJkTHAkVPHRJ9xx3XYelDxNVJq8r8Y
         orBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318721; x=1695923521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxkPmAViZ4bBY9DKE4WBvD6KeHCq77X51+2zFhsJvjI=;
        b=YTin34VOL4U3ASCEeadl9pqbR3YdAVYIgS0ey8GAeCdCqJWsMp09Bk8QrdbXUQg8X8
         bG72Ab1yHX93Sk8yjZDwBr5t+/a6kOuQBwbeq08CL0YRWHwu++LEQjcWqWw2Ll1EqnbC
         6+KW+fW7x0kH3aKuheYa0Ch21aKnM/INCvYsdEokPBdaaJSUGT46/wM5mDjrJ0cYTvlF
         veWUjLi+fpEK8UE65ntLCpmj7lJEktAc1l/TGFCvvmTE9sVGEdi8bW5YsVkNAlfllqJq
         pkIIZ7wI0efBCFPbRDOzl543r12oDubgwnl1FbvnNjXhs0iuC2BKIVgI9OjEfTqB9jAz
         GCqg==
X-Gm-Message-State: AOJu0YwboL51GF59ZFe0djxLINaxofTueCmhMcs5ptCjh6yUgaSxPKJd
        OzW/VeW6V0btdUXkRRD4oNAAJ8SEcGzpHUC41rA=
X-Google-Smtp-Source: AGHT+IE24TGT99DikzPg5zG+6oyXRaRUuY6+u/KuMZcpuCCWeHerHnJXlIqtmoOq6kDnMQwaM6y3ZQ==
X-Received: by 2002:a5d:6282:0:b0:321:4ca9:ee86 with SMTP id k2-20020a5d6282000000b003214ca9ee86mr5788827wru.53.1695306777512;
        Thu, 21 Sep 2023 07:32:57 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:56 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 16:32:45 +0200
Subject: [PATCH v5 6/7] arm64: dts: mediatek: add larb support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v5-6-fa6f03680832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=YQ4gFuFLZ3ZXhHJoLIMLvf6JGXdHrmuwZeJIyfaEitM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQPhJHEHhv6HpHOR8vnZbdJqOs94UdeCDIGq9yk
 oP0A2XCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURRxSD/
 95BCCUm6vXCQ3heLFsNf0wN6jPPVGGVQvyaRoSVnPA+qE1wmUMIJSJ3/Os+3vPTAaQKqRSSi5S4bps
 3H/NTU8PqwL2g2f0cN1qjKrnvBdsVR5DJ40Nf10BqZZu1TZHYNIcM7vg3HmLTXFb+s+cbg8bQwjQJa
 j01l+vxGCArOiBpxCAyGyzACfTCTlFFGdaIxUc4H4wqUKD04624XV5ntBjTNthw2P+qzkDxXcx9nur
 iG2zXXUBFyIhzl38RYQIxvCsP5pw2KELEZGIkzxSayQ5L44xtSBjPOiTWbdY5XvprQFxU9wnnmWepl
 7vwQSRnSrLz+OCv9MOzKCGroNm1IzNTrSdi0Za6+CD5+Q0yBwQkA0vUqoCf94y3R9wlDb3ZNoGGJIb
 bk2+P7zJHMCrEc/yDl6N2T/jG7cF5sLKBD+PympY8cfQHWeNXRWWShRXn09PQqB/gX5Nm79/Mzm57t
 omaDyWe3lrnXx1H2frtvyzr2Wf6nWbh0GD4zyKrl413WQgeXt5tcTPATFSY34QSXVPlNOU0SkRNz1p
 58/Dlrb9QqA2LODi+/nhKZUzjT5EluaUYCBS2GpeeuytKTL9EAxx9tgvGOWrSlIqHcImowYIaY4Hs4
 e3q3arOf4R4E/epzs7VxtO791cfKKfqRKw12rvXRk9Y2RIFwQPMqE73rPQ3Q==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local arbiter (LARB) is a component of Smart Multimedia Interface (SMI),
used to help the memory management (IOMMU).
This patch add 4 LARBs and 2 clocks for the larb1 and larb3 support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index a03b8c0da68b..afcfa1dd242e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -735,12 +735,71 @@ smi_common: smi@14002000 {
 			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
 		};
 
+		larb0: larb@14003000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+			mediatek,larb-id = <0>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb2: larb@15001000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_IMG>,
+				 <&camsys CLK_CAM_LARB2>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+			mediatek,larb-id = <2>;
+		};
+
+		vdecsys: syscon@16000000 {
+			compatible = "mediatek,mt8365-vdecsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb3: larb@16010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_LARB1>,
+				 <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VDEC>;
+			mediatek,larb-id = <3>;
+		};
+
+		vencsys: syscon@17000000 {
+			compatible = "mediatek,mt8365-vencsys", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb1: larb@17010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC>, <&vencsys CLK_VENC>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VENC>;
+			mediatek,larb-id = <1>;
+		};
+
 		apu: syscon@19020000 {
 			compatible = "mediatek,mt8365-apu", "syscon";
 			reg = <0 0x19020000 0 0x1000>;

-- 
2.25.1

