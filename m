Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB80783C00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjHVIpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjHVIpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:45:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F531B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so1763924b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693933; x=1693298733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scA3slj2GnANfQZ9WmrZNWN3UDRBxFFiMbyHn692ZM4=;
        b=Y6BM3dWQ2i1ulThxW8v48ZRSijPKfGGDZU7YePxZx4AQcVIlA/ORIdCKMV08hkCpCY
         qPNYEzQkzeGYFKSMV8pGTxo2/wvqI8UxJHVruSp1Y+nVqJz8GWV514e3wRNI1sTiDPYK
         nUL7pKK3A3Qh1AOStKX69Lnb2vawQmrTGjUGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693933; x=1693298733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scA3slj2GnANfQZ9WmrZNWN3UDRBxFFiMbyHn692ZM4=;
        b=WUJozVMzHOlfXmlX7gD/KIrZsE/Y728CRt7ffovix7gBFbEeugaeo7N9wLS6KcN6+r
         +RVtRap/8gAAtn+jnCt4bKNdW95c02YKhe9AcZGG/vMnYGyvXTw+g+P8Cz79fqp50jYQ
         SMR+yyeAWYI3wEhWT7Sromn3thnMZJgUF3EthC3Q6FF/YiHNPJPrExGYRLX0BdwqWUKK
         23Eb7NJ9RWS5cdETyAI7VuJqpMNar4KA9ASKiLOByi3mwRxkK0S56HgBD1Mbmlky0XK0
         hiTQU3DWSW6Nx9JZhMhDOjWJ58a6MOq0vOvKKc3UPPSkgd85E6pPmm1Oq0EYPR51LZvP
         OA3Q==
X-Gm-Message-State: AOJu0YwupajWiayMLGnZ6o16176AD4pmjGV+UD9E9MC/G7XA0Fn7LYBM
        k1HYaSLSGhVqdBkk6JBN+leYug==
X-Google-Smtp-Source: AGHT+IHW6ePGH6SgC29qM4b5i2IL+bnaOrlXSniE0MdltskRkrxsbx0tRAxYxqvSf6DSgpjVj78adQ==
X-Received: by 2002:a05:6a00:1492:b0:68a:4312:e0d6 with SMTP id v18-20020a056a00149200b0068a4312e0d6mr7109893pfu.10.1692693932995;
        Tue, 22 Aug 2023 01:45:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:32 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 01/11] dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366 PMIC
Date:   Tue, 22 Aug 2023 16:45:09 +0800
Message-ID: <20230822084520.564937-2-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822084520.564937-1-wenst@chromium.org>
References: <20230822084520.564937-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
a different set of regulators. Specifically, it lacks the camera related
VCAM* LDOs and VLDO28, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.

The PMICs contain a chip ID register that can be used to detect which
exact model is preset, so it is possible to share a common base
compatible string.

Add a separate compatible for the MT6366 PMIC, with a fallback to the
MT6358 PMIC.

Fixes: 49be16305587 ("dt-bindings: mfd: Add compatible for the MediaTek MT6366 PMIC")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Dropped Conor's Reviewed-by tag as this patch is now completely different.

 Documentation/devicetree/bindings/mfd/mt6397.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 294693a8906c..10540aa7afa1 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -22,8 +22,9 @@ compatible:
 	"mediatek,mt6323" for PMIC MT6323
 	"mediatek,mt6331" for PMIC MT6331 and MT6332
 	"mediatek,mt6357" for PMIC MT6357
-	"mediatek,mt6358" for PMIC MT6358 and MT6366
+	"mediatek,mt6358" for PMIC MT6358
 	"mediatek,mt6359" for PMIC MT6359
+	"mediatek,mt6366", "mediatek,mt6358" for PMIC MT6366
 	"mediatek,mt6397" for PMIC MT6397
 
 Optional subnodes:
@@ -40,6 +41,7 @@ Optional subnodes:
 		- compatible: "mediatek,mt6323-regulator"
 	see ../regulator/mt6323-regulator.txt
 		- compatible: "mediatek,mt6358-regulator"
+		- compatible: "mediatek,mt6366-regulator", "mediatek-mt6358-regulator"
 	see ../regulator/mt6358-regulator.txt
 		- compatible: "mediatek,mt6397-regulator"
 	see ../regulator/mt6397-regulator.txt
-- 
2.42.0.rc1.204.g551eb34607-goog

