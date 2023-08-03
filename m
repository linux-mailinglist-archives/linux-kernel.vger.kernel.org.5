Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835E476E4BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjHCJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjHCJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:41:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A22102
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:41:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so7535805e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691055668; x=1691660468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABe5lag05JGrRRfK6Q7TQU2Nmk4xnwbIxqigvQsoK2A=;
        b=IGrwuEB8yps4AozN1gYGAsDqpyxiycbKZlWnc7BJbdL2FV/M5AfbfWecJUiixOzzvA
         1nr/sH7OhPjjVm9cQaaGjDugwm1dN6/HeoAlWcTnoG2w6gobunCEv5YM77NdYymr+GHC
         71210i+2bT6yawzBE3ndNeRPIVFRRBa0IveeWvZgE4avSRHqDQhzvFnUWIoDTGOa2nNO
         d5zFcS4D3vQMSHIAmNFtl+34BWdCfklngHnWVEKkYGKwH7tNo++OmMgrvSg7mnNtepHz
         KSdufwBIvpwgnJkxmhWW9G5EWTkzvI9UOmYRXxNPnVMfheH6FnglZmVRPO8kbHYgwl8m
         Gbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055668; x=1691660468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABe5lag05JGrRRfK6Q7TQU2Nmk4xnwbIxqigvQsoK2A=;
        b=dCNbQR/doyTqPpy7jtD+2PMEgLLMvVo8tlwhuwjhMmwkSole/PinksZR+J9dnNa7JN
         8VDocXmLDijc2/q+689SmF7FaAf2GediIzGwf8RKUsm1/Uptz6P+U9KT4SGeFT1aDQtW
         sZNvNzpniTy9W/agrda/kIi8rGxEHdg1BaEgqBcPUcYbPEiSeRLc5EALYStkxoM+nPUj
         dzPzGmA3rQyWKKxALcEvjR0fkp7jgKFAR/tLE0qgUFhkOMXScHzdbTF0SJJ4FmRJm9KK
         Q7kyLjz15kfwhU35ql4RYtdz4Yh1GQ9wGkEa2r/edr6YckBxNZL1Q2HKHYTdURHb+/11
         a9NQ==
X-Gm-Message-State: ABy/qLbCoJbN2m8rE7pSwJhI9Hf/77w+ZqX9jKZo3V/zv3SFeqBFS1u8
        1Vy6misxTxlQyWDoKQgvZ4sSYQ==
X-Google-Smtp-Source: APBJJlGxUIGgf8Ra/YV2+Q5e/JdY+71Jq25KOf5qdrpaJIgzJwQ15REV9oJzcQ0aIT8xzZSV1SuCzQ==
X-Received: by 2002:a05:600c:44a:b0:3fb:e206:ca5f with SMTP id s10-20020a05600c044a00b003fbe206ca5fmr6521392wmb.31.1691055668078;
        Thu, 03 Aug 2023 02:41:08 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm13294994wmq.1.2023.08.03.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:41:07 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 03 Aug 2023 11:40:55 +0200
Subject: [PATCH v4 3/7] arm64: dts: mediatek: add apu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v4-3-84798657c410@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=LNi5XTwnw6k3l6Q87CyTgWzrlVLjaNEqurZKDlk2veo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBky3Yu5YDQrxts7CW7gmlgK5Q2+8w9EgP2JlLA0zQE
 YMo0zVGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMt2LgAKCRArRkmdfjHURe2kD/
 9mn2GOOQMXI+Yej0LdjG8rsBXc7kMiB1Kb+M0FIP9a5L8mRSaG0tyKoF7SkL7qV25dBusbzd4nGX8A
 aaaONk7dlsbCGrL+AahWousddNVY7JA+SuSd0+Cmrf2ASnhZd+oVp9yy2tQh9ClsOVXg9N6hhEFk8H
 jaQNBv+ndjb9b6M7b6nY+YI/0XTBMQoGA87n+DOKyrw74e/NcyIg4XlwybiCE+93uQl/KEw4qA0HeJ
 n5CUe8U1ok/jYqxhR3WLhvhkgbaOERBJNcYhSvWw5XCylpHhdIqLcTn4MwIJ8m/Md3XNtLY56rx0C2
 WGbSVNsHInK+LPEcd7KgstTB76EeuiaxMD+izIeDycCfenGXwAIxRiJoYOpuo11nPfe+u9NN8ibPSt
 N0Q+luAzxzph0SnW10DBT1KBulvvyeEHGERAk94HcVJKduDjNxImfSnkt1yf4jSiKBUib9QQteJVsg
 Dbt2P2KC0WoE5JFkvbV8S/X13Kxw7miZqby/AyMl2ZABQf95zIA0ccmcZtz9GwW+iNX8W1tmrtqOZe
 Vwh20iOzzcN+vmz1SdYYe/A79Q+lT5WL6t4OUnqlvikYm+BmLg6GnJO/6uM92VnuqLe9Od359GslEo
 RjNAwmOQrDMbpQNDuOPkC9id93SIgEZLwDjOxU7PgemvOI4+rqLAKeDPOtQA==
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

AI Processor Unit System (APUSYS) is a highly efficient computing unit
system which is most suitable for AI/CV algorithms. It includes one
programmable AI processor (Cadence VP6) for both AI and CV algorithms,
and an eDMA engine for data movement between external DRAM and VP6
internal memory.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index f9cddce5bd9d..c3ad7cbc89ab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -615,6 +615,12 @@ camsys: syscon@15000000 {
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		apu: syscon@19020000 {
+			compatible = "mediatek,mt8365-apu", "syscon";
+			reg = <0 0x19020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1

