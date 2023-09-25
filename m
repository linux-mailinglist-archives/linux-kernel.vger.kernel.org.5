Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628BF7ADE82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjIYSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjIYSSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:18:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644F210F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99357737980so854965266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695665872; x=1696270672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxkPmAViZ4bBY9DKE4WBvD6KeHCq77X51+2zFhsJvjI=;
        b=MNNpPdc3aHjc4HNHp/cPnevLABlpq4lMlhlr9HCHKv9QalWKs06KZ5SrNEkoR3Ud0M
         MKp5dg4viDL8TZznuUFrLdivtZjgW/IBeLiv2GuaaDIFifmRv0ps80krk0Jhe97qBLK1
         MgcYkzDFR6dC/ouHLusgDCx7H6aDGKmQz3YBd5+uGgdCSZVjUDz5NaI7TxvwTUmC4G6N
         IIBn7advaKNmKBkK752vjDi1YBPLz8EScmSJaxQmd6cucvF1KsZ9k7SSWBwN7k5dxegX
         6sOJc90zCj4KyW7221uhSIJsvQfESV9jVQfit2omg3r7Jw7njmF/BEobt/NXpkH++N01
         qpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665872; x=1696270672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxkPmAViZ4bBY9DKE4WBvD6KeHCq77X51+2zFhsJvjI=;
        b=UV3cBZfOwfUPOQYRatU8RzoZhHPPRyWlTKAYzEC/o+7W7JLuHJ8t1CwQ81KFGwqw2x
         TRQ4nHbRcVLRd7HuqTubVX2SihLve+zZcC3Ay6ygbWbTqxQivwptJM7fL1uwKWc9h2Tf
         nrVsMWI5nMLuGGl7lovnwH5LfxvFB+W49q5f1R+2nGZnbcsIfaPBTcALz+0q8ScDUXJn
         jqS6tt5fioWl/kURhla35s0hvEob1QFKN9JF1v35U+5sxkOMVAdyaS53Hpt4JuAq46uz
         Gp5wZtdroCa6MPVhZyrLsIRNkli+0QpKEyyrW+cZG2aHZjG1XToHLLMC0Bnx2kE7qq0O
         QpCg==
X-Gm-Message-State: AOJu0Yxsrfeb6I8HZk8c6W3ukwEQ/26P9TDp3H2QoFvKqEobDqehGoV0
        vEYonAZJ5EFbxQ/7pbdt1Gm7jQ==
X-Google-Smtp-Source: AGHT+IHT3syoSHTbKtilMHTDdnamW084akA+RA0Z1wDTTjmW2uxSgNEb1Sm286eCv+m4TnzoxP+WLQ==
X-Received: by 2002:a17:906:2088:b0:9a5:d657:47e1 with SMTP id 8-20020a170906208800b009a5d65747e1mr6035027ejq.43.1695665871898;
        Mon, 25 Sep 2023 11:17:51 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j26-20020a170906831a00b00997d7aa59fasm6793962ejx.14.2023.09.25.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:17:51 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 25 Sep 2023 20:17:40 +0200
Subject: [PATCH v6 6/7] arm64: dts: mediatek: add larb support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v6-6-24453c8625b3@baylibre.com>
References: <20230207-iommu-support-v6-0-24453c8625b3@baylibre.com>
In-Reply-To: <20230207-iommu-support-v6-0-24453c8625b3@baylibre.com>
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
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlEc7F7qzSRjVHw3D4953FjAQpy02IRt7Bxz4Q11WU
 pRp6gGWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZRHOxQAKCRArRkmdfjHURZFND/
 97j8hIibvje8nqBVb8pJ/n5gAklskcO6X2r5QqLlaedqjf2PH4qAbaVmPrbU01rF2zOIq3Y+T0SZcm
 7VLM4w4H1flT9mr1D7na3MJ7VPtV8XbzvppZJ3WEdj634c50ebGsqE/e6MGtIOojOFpb7URUr+iIPc
 5oIjYm2rqMxDo60UyJOxnPg2mknQ2UhVo+NDynRhEaFxy6FfzRtwnoSXyrA9PXZ4QOJ8VwBk5NNhKa
 F8ob15opFebohf3ghsyUyCxUK6Aqmqyuft6hEKNJYXzuVBDCz/EdKGhq/4KYwy9r8PUbV8AWKkiGzF
 SrUmB6zKYRxaPrNKfxfShdKaifxnfIbCxyOyD/Ec+bbi3tR5HtuSjy5a4WrN4akgYUW4uUdOXYww/t
 IPbr1HxwaoWsa+9CH/aO+adV0mhURYFZjpm1Vb/ZFbPXsXb2YIVS8rDfc5c0gafTt0CnaLfLnxiT2s
 qcbj6ZxI8JmdCn2h7X/TFvF+CG+nKD2Z8b8XGXOsJFikcK/WOOP4Fob3HizUSGvcPconTRhlqYRejO
 AHp2uZwFpPHuMIGQJNyh8R4cb9kSPi+8HYPL7maITrrHBnt/ELS/9cGNbGKHYdjhuK3wyeXcqnZ8EC
 GJgkqz9i6mpmYHQl2mfM9ICSupb2NEHeNb8TRpR00EAYMllM5tyHk7X/y2HQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
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

