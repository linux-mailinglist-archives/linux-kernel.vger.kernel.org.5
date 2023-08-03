Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9976E21F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjHCHyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHCHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:53:41 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158C8A5E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:25 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a4875e65a3so492320b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048580; x=1691653380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O80suLs8Qvsgc7R30L63r0azKWcMa3PZDlYRfpOpp9M=;
        b=G50odMpAiZPUQ5zKrQkOTXNvwx71UmOrW5jQwfS90yBVF4M1S1MmNa91G9TeT3n6x9
         kcPygwXC5w7+KoeaijZIPd62cmcxCJBeeJ4uc68B4fPzdMdTG58FRERDnHX3inxJbaWI
         bKxOMGW/At9tyeEGMXhL/vivf8DwgG9a/sh5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048580; x=1691653380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O80suLs8Qvsgc7R30L63r0azKWcMa3PZDlYRfpOpp9M=;
        b=BddNXkUEnCQAtAFBhHSY1zpkqBKoZO4zXj+xtEgqbw8UU8QzmhnlLUaQm8tGV1kvkm
         VF+x1Xoec7QOKvBD5CPtVXuq1pZbZfvZZDgMog8h78DWddAOYHrEQoxkNL0EhOI+2WQB
         EiWOttpTtIQ45gSbbmalNW+/8ukYG5ZUCkOYKrVU2yF3N93VZYnHSuarZwn+31BT71KI
         UawIvlJxVtZt4OnSEjNJO76bG4PWdmXcOV1oVT/QcsU6vLwb9hQv3GVdowM6+ugrOijq
         WoGdGnjkOr384aQtTXDmQAzZu7Guz6IatWBkQSeFXqHA5nBmXaXwq301tuyXarzZyhQn
         NVtg==
X-Gm-Message-State: ABy/qLabrUOS/+5pkf+EhK80VVR3aSA49OAH+9t8rXr1m1OzhDjLEOFg
        dYrdHiFfec+c7e45wkK5Jw97UQ==
X-Google-Smtp-Source: APBJJlGY9mduFao8XJQFVBFE9ih/bv4zzgVrQtxOi7vXuN0THQ/f3tRLfB/zLRer9OPXZDJahrPkbA==
X-Received: by 2002:a54:4d8b:0:b0:3a6:f876:148d with SMTP id y11-20020a544d8b000000b003a6f876148dmr18312483oix.8.1691048580528;
        Thu, 03 Aug 2023 00:43:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:43:00 -0700 (PDT)
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
Subject: [PATCH 1/9] dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366 PMIC
Date:   Thu,  3 Aug 2023 15:42:39 +0800
Message-ID: <20230803074249.3065586-2-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803074249.3065586-1-wenst@chromium.org>
References: <20230803074249.3065586-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
a different set of regulators. Specifically, it lacks the camera related
VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.

Add a separate compatible for the MT6366 PMIC.

Fixes: 49be16305587 ("dt-bindings: mfd: Add compatible for the MediaTek MT6366 PMIC")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 294693a8906c..d4778b0d5f5c 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -22,8 +22,9 @@ compatible:
 	"mediatek,mt6323" for PMIC MT6323
 	"mediatek,mt6331" for PMIC MT6331 and MT6332
 	"mediatek,mt6357" for PMIC MT6357
-	"mediatek,mt6358" for PMIC MT6358 and MT6366
+	"mediatek,mt6358" for PMIC MT6358
 	"mediatek,mt6359" for PMIC MT6359
+	"mediatek,mt6366" for PMIC MT6366
 	"mediatek,mt6397" for PMIC MT6397
 
 Optional subnodes:
@@ -41,6 +42,8 @@ Optional subnodes:
 	see ../regulator/mt6323-regulator.txt
 		- compatible: "mediatek,mt6358-regulator"
 	see ../regulator/mt6358-regulator.txt
+		- compatible: "mediatek,mt6366-regulator"
+	see ../regulator/mediatek,mt6366-regulator.yaml
 		- compatible: "mediatek,mt6397-regulator"
 	see ../regulator/mt6397-regulator.txt
 - codec
-- 
2.41.0.585.gd2178a4bd4-goog

