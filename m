Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F180045D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377689AbjLAHHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:07:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB6103
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfb4d28c43so1960645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701414458; x=1702019258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmSSbesO2dwzEk65LrlUoXH/BVZbqQKxMDTsvYIIuxE=;
        b=aIC/cFvCdLqAP6kkZ7XSYTL5q9kuMCteH2ouubXeqZL/vjR1rHVnVciPijSPymqm/m
         f+eBG3lYkH6Ln4K1EFRLIl2FwSycB/Fz6NR5EXJBMB3INBX9AYhwMqG6MzG7e7r3NBTJ
         17ze02ZLjqgy1Erm61KlJc9LlNvj+ZYM8Tz5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414458; x=1702019258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmSSbesO2dwzEk65LrlUoXH/BVZbqQKxMDTsvYIIuxE=;
        b=eIjj5igCqWKehoXwpD35t2bCV70VWD5hPcRRF7BaY0bZF8ALbAayRNEUwyi8r80Hpo
         ws/dDok9VjvuCG5KFzShCGUdv92dDMH+sEdmUz49VEzOwyoK/V7ygW8V75wLb7o5N0hJ
         /tyj4W0hKMaupX429c6Jsj2Rvcc4UagF7LFkrKbNq2lRg8rBfrrjkSKtr2kazKmmvHXd
         9PNhanc2pLs83N6QTGZvMB8eYFy8E9zQ401//WZYWC3gdtUXWOz5IwX7hvPO8WG48lRQ
         J+9ktPlHCXt3ON+EGtU3STNIeMF5nGemn/GqeI0el22vTSX/YRvOWl49r7jHJYCmdvtN
         NcZw==
X-Gm-Message-State: AOJu0YxJ1haxleLzrN1w+e/VOqX2CexYehqUGoTQNFu+ldhkZ+ArsjVN
        EBefwk5VoXw8TksC1u8lZXFP8A==
X-Google-Smtp-Source: AGHT+IFKJXXHSlz5KqBZB/XpFyGkKH2Q1j9i1aeTwuURH1I9GWoQMnP15sW4eYSuQYeRTTefz8Pznw==
X-Received: by 2002:a17:902:d488:b0:1d0:5be:7814 with SMTP id c8-20020a170902d48800b001d005be7814mr10498476plg.23.1701414458070;
        Thu, 30 Nov 2023 23:07:38 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:720a:d435:c253:2402])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b001cfa0c04553sm2558684pll.116.2023.11.30.23.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:07:37 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/9] dt-bindings: arm: mediatek: Sort entries by SoC then board compatibles
Date:   Fri,  1 Dec 2023 15:07:05 +0800
Message-ID: <20231201070719.1229447-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201070719.1229447-1-wenst@chromium.org>
References: <20231201070719.1229447-1-wenst@chromium.org>
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

Some of the new MediaTek board entries were inserted in a chronological
order, or just randomly. This makes it harder to search for an entry.

Sort the entries by first grouping by SoC, then sorting by board
compatible strings. Also add a comment at the top asking people to do
the same.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
Changes since v1:
- none

 .../devicetree/bindings/arm/mediatek.yaml     | 123 +++++++++---------
 1 file changed, 62 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a5999b3afc35..60337b439744 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -17,6 +17,7 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      # Sort by SoC (last) compatible, then board compatible
       - items:
           - enum:
               - mediatek,mt2701-evb
@@ -129,71 +130,10 @@ properties:
           - enum:
               - mediatek,mt8173-evb
           - const: mediatek,mt8173
-      - items:
-          - enum:
-              - mediatek,mt8183-evb
-          - const: mediatek,mt8183
-      - description: Google Hayato rev5
-        items:
-          - const: google,hayato-rev5-sku2
-          - const: google,hayato-sku2
-          - const: google,hayato
-          - const: mediatek,mt8192
-      - description: Google Hayato
-        items:
-          - const: google,hayato-rev1
-          - const: google,hayato
-          - const: mediatek,mt8192
-      - description: Google Spherion rev4 (Acer Chromebook 514)
-        items:
-          - const: google,spherion-rev4
-          - const: google,spherion
-          - const: mediatek,mt8192
-      - description: Google Spherion (Acer Chromebook 514)
-        items:
-          - const: google,spherion-rev3
-          - const: google,spherion-rev2
-          - const: google,spherion-rev1
-          - const: google,spherion-rev0
-          - const: google,spherion
-          - const: mediatek,mt8192
-      - description: Acer Tomato (Acer Chromebook Spin 513 CP513-2H)
-        items:
-          - enum:
-              - google,tomato-rev2
-              - google,tomato-rev1
-          - const: google,tomato
-          - const: mediatek,mt8195
-      - description: Acer Tomato rev3 - 4 (Acer Chromebook Spin 513 CP513-2H)
-        items:
-          - const: google,tomato-rev4
-          - const: google,tomato-rev3
-          - const: google,tomato
-          - const: mediatek,mt8195
-      - items:
-          - enum:
-              - mediatek,mt8186-evb
-          - const: mediatek,mt8186
-      - items:
-          - enum:
-              - mediatek,mt8192-evb
-          - const: mediatek,mt8192
-      - items:
-          - enum:
-              - mediatek,mt8195-demo
-              - mediatek,mt8195-evb
-          - const: mediatek,mt8195
       - description: Google Burnet (HP Chromebook x360 11MK G3 EE)
         items:
           - const: google,burnet
           - const: mediatek,mt8183
-      - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
-        items:
-          - enum:
-              - google,krane-sku0
-              - google,krane-sku176
-          - const: google,krane
-          - const: mediatek,mt8183
       - description: Google Cozmo (Acer Chromebook 314)
         items:
           - const: google,cozmo
@@ -244,6 +184,13 @@ properties:
               - google,kodama-sku32
           - const: google,kodama
           - const: mediatek,mt8183
+      - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
+        items:
+          - enum:
+              - google,krane-sku0
+              - google,krane-sku176
+          - const: google,krane
+          - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
@@ -251,10 +198,64 @@ properties:
               - google,willow-sku1
           - const: google,willow
           - const: mediatek,mt8183
+      - items:
+          - enum:
+              - mediatek,mt8183-evb
+          - const: mediatek,mt8183
       - items:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - items:
+          - enum:
+              - mediatek,mt8186-evb
+          - const: mediatek,mt8186
+      - description: Google Hayato
+        items:
+          - const: google,hayato-rev1
+          - const: google,hayato
+          - const: mediatek,mt8192
+      - description: Google Hayato rev5
+        items:
+          - const: google,hayato-rev5-sku2
+          - const: google,hayato-sku2
+          - const: google,hayato
+          - const: mediatek,mt8192
+      - description: Google Spherion (Acer Chromebook 514)
+        items:
+          - const: google,spherion-rev3
+          - const: google,spherion-rev2
+          - const: google,spherion-rev1
+          - const: google,spherion-rev0
+          - const: google,spherion
+          - const: mediatek,mt8192
+      - description: Google Spherion rev4 (Acer Chromebook 514)
+        items:
+          - const: google,spherion-rev4
+          - const: google,spherion
+          - const: mediatek,mt8192
+      - items:
+          - enum:
+              - mediatek,mt8192-evb
+          - const: mediatek,mt8192
+      - description: Acer Tomato (Acer Chromebook Spin 513 CP513-2H)
+        items:
+          - enum:
+              - google,tomato-rev2
+              - google,tomato-rev1
+          - const: google,tomato
+          - const: mediatek,mt8195
+      - description: Acer Tomato rev3 - 4 (Acer Chromebook Spin 513 CP513-2H)
+        items:
+          - const: google,tomato-rev4
+          - const: google,tomato-rev3
+          - const: google,tomato
+          - const: mediatek,mt8195
+      - items:
+          - enum:
+              - mediatek,mt8195-demo
+              - mediatek,mt8195-evb
+          - const: mediatek,mt8195
       - items:
           - enum:
               - mediatek,mt8365-evk
-- 
2.43.0.rc2.451.g8631bc7472-goog

