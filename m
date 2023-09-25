Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB87ADE80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjIYSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjIYSR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:17:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565011B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so8463556a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695665870; x=1696270670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqq71BmglqPdWoPEtToCLWEFpVEun8ESIoG7WuZgwYc=;
        b=E2utTMwhmGo/2orNGPwC7c4zVaQPVX0eoTfkxHOFoKu9lQRWIaDJhCwAztv/GMXKmN
         mstiIUDQeu5s6lOAGHeGj6deiIjBEZnPzcEZRHFnXLXLbvGFgz8tHLCR10he3rIpzHmQ
         YATrLM57gMBMWi22d7h/KtbwbmiwGVx5XDtmh9OowLzVV5X/MjT5yuMBCABqpszKrSIK
         uCiproXeZS00a+LY/GUI8rnrWrTbDOLHGYknR2J1WnP41B8LN9Lj2dF08FSBMFtyJBxa
         YmeuxZLFJ49zS7mgwsY5U9yexjbm91QbAS8g4EKPqkojKn24tkB6wgYToX7YlW9h+w2w
         w6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665870; x=1696270670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqq71BmglqPdWoPEtToCLWEFpVEun8ESIoG7WuZgwYc=;
        b=aZKO5HJ6F4oXE+Ch2t/FRF7XPbkNIVonETfR4bj/Sf8oIl9vpq4AiayQveCRqNqDdF
         DrSsL0Mr2odioi915ui5HTHcyugB3S3tTt1z7+R//p0vMGt7jMErl0ZuVEFa9csNHSqE
         WUWvEN0h6HxH+Yas+Wmf1VPkVok3aAQcx2stGmwUyQcmHunoVKvlidx6zcOK0WdOmhSH
         +HQ9DgjTu7TcKuwxYN56R9Tyru0XEl1oxEEIuw+lWXwrrxnElN5XDsxR19oXEUx9kwmS
         le86kmFGFFHiCzRBWo8AOnctpOM8RRDeKVAiLF2fricPbMSSetr4S7UMz4a88fDH2gPq
         9nlg==
X-Gm-Message-State: AOJu0Yw1khVAAr1GzTaIW/udhscfOOLdwQNX/TmcAmMBN1R/gm6onrq1
        v/Tz1tks5drNsFxzrWJg9Bx1araUr0xu3zgBobI=
X-Google-Smtp-Source: AGHT+IEMW0D4RL4XutuqCdBjfC9hfPonSP98tq7X8qAUWLouKrT/Ecb+2L8B5v7B6vOhgAOXSTEYWw==
X-Received: by 2002:a17:906:30ca:b0:9ae:541e:7310 with SMTP id b10-20020a17090630ca00b009ae541e7310mr6564400ejb.33.1695665870368;
        Mon, 25 Sep 2023 11:17:50 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j26-20020a170906831a00b00997d7aa59fasm6793962ejx.14.2023.09.25.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:17:49 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 25 Sep 2023 20:17:39 +0200
Subject: [PATCH v6 5/7] arm64: dts: mediatek: add smi support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v6-5-24453c8625b3@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=lJi09wmfuA1CnXJrdr2+qCC0CVBcfrZwevdWJeNOAo0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlEc7FEVSjGHrSkrW+FZLtcEUWl13xhTtayX8+9r0L
 ox5XimCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZRHOxQAKCRArRkmdfjHURcE8D/
 oCX9XceWnTnvrl8BWagMD6eSAJw12HSntAuLDm5Mh4VSePapKwF+YtdBSdye+NW04rD5+/R3/enaIm
 Fcodp4SWwIRHPzYhW4tVswoWBaoHN/vsHx42s8kZYC8d8vovCzkrG9M6jyaXsmXulUG6kpICd8ZV8b
 iv3XNNkzYw7jtWd5rOQHQknQ6W+J2FsI4vChmN+isiK0+JRRiSEjBkWwaT8Va0wQOwA85zmw3SgMxB
 A+nwnbP1my2HKYWCOcnDGnG5UkeS+CMFyYTkxYvXTuD2lgCXKWvIjNiUY7G3wUv7l0UHyBG1wjO0s6
 3pKmyuY3J16fXGUy3dtwGmqRSSm50PzW7oZefu2MLyDmJu1wcFLBznBTcH5N8uJ3e8TT0kbCopo8ct
 rlMJbNoASMEXnAb1hk5pYcwjf5IY/pUyoS5pPRHXCgTR1DhP8ql3SsQbRnWBviwpaAom4v5udwxkdM
 wqiKSCioTRQ42bnWW9PZDEkC5oSaZHTFJoEBRECB6P46X9AGTLCcWiAPMuE9974XuKjfCswCU9t4YH
 np1bFl2UH/zE1LYbUXT/tto4ebmeDDarhHF4sgDCg16io2CeSpKWfIVDDOf9fGe2Se3DRGwR31d+fX
 dOwIvZ9DcptgXFDE2IUyT0YwwUIKd7908/O7vSoI6hnUX3aRMgp3tbPrDZiw==
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

