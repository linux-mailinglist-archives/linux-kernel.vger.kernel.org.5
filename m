Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5978121E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjLMWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442836AbjLMWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:43:00 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB0D5A;
        Wed, 13 Dec 2023 14:42:36 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5913e3a9e05so1448353eaf.1;
        Wed, 13 Dec 2023 14:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507356; x=1703112156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FW/pmmw2V+DW6nT308vGzDaKBo2V/WiIuPZcl8Qc+Ug=;
        b=vUUA+SuwjoKWSZNJoPn2tjGdbjAES65/oCF4QfLYaMxUIWQKvHNeNJ6EHQ749XkiOd
         fKSnafTNHU5iUVE1VBsGKkRznGwCzbrCY45PeVp7SeRIokQGpnOhHMTSbFy7MX8YTCqD
         o0VcceyI9gZnGqxHQ3LnFxdcQa3My7wYjTPd2bvvm3TCe5F+8L/MFJRpx4aw54uo4WCc
         fhC8fz4eFPVpv81c0tIuwyWYipfBPnkpAxlVfSsZisjaxtDvyHNgTIWhEqkhTjoTi+Di
         bKoY/OywjzB7gR9Hs87VpeA1nKcqE35u/AvLkCqftkDLVT+MC56paUE/Qm3kbQk6HiXA
         3EZw==
X-Gm-Message-State: AOJu0YxZmN7opb2o27sMNkegmmT8UWYqvCaTnAQJnljiQJg7wMXTPVJ3
        KiB8DgBYQjW/0Hdl+7ulig==
X-Google-Smtp-Source: AGHT+IHaJX2FfX/ctN3Th93fsrv8ZHkMh+5Fl3XcKJvoRGEVgImi2x4SvuBQgy8Lp1Sfb2Yj9+MGKQ==
X-Received: by 2002:a4a:245c:0:b0:590:9a90:16d with SMTP id v28-20020a4a245c000000b005909a90016dmr5562296oov.5.1702507355754;
        Wed, 13 Dec 2023 14:42:35 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j11-20020a4ad2cb000000b005907ad9f302sm3233886oos.37.2023.12.13.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:35 -0800 (PST)
Received: (nullmailer pid 2192084 invoked by uid 1000);
        Wed, 13 Dec 2023 22:42:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aakarsh Jain <aakarsh.jain@samsung.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: samsung,s5p-mfc: Fix iommu properties schemas
Date:   Wed, 13 Dec 2023 16:42:26 -0600
Message-ID: <20231213224227.2191897-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommus and iommu-names property schemas have several issues. First,
'iommus-names' in the if/then schemas is the wrong name. As all the names
are the same, they can be defined at the top level instead. Then the
if/then schemas just need to define how many entries. The iommus if/then
schemas are also redundant. Best I can tell, the desire was to require 2
entries for "samsung,exynos5433-mfc", "samsung,mfc-v5", "samsung,mfc-v6",
and "samsung,mfc-v8".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/samsung,s5p-mfc.yaml       | 29 +++++++------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index 084b44582a43..a970d80692d3 100644
--- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -49,7 +49,9 @@ properties:
 
   iommu-names:
     minItems: 1
-    maxItems: 2
+    items:
+      - const: left
+      - const: right
 
   power-domains:
     maxItems: 1
@@ -84,7 +86,7 @@ allOf:
             - const: sclk_mfc
         iommus:
           maxItems: 1
-        iommus-names: false
+        iommu-names: false
 
   - if:
       properties:
@@ -102,11 +104,9 @@ allOf:
             - const: aclk
             - const: aclk_xiu
         iommus:
-          maxItems: 2
-        iommus-names:
-          items:
-            - const: left
-            - const: right
+          minItems: 2
+        iommu-names:
+          minItems: 2
 
   - if:
       properties:
@@ -123,11 +123,9 @@ allOf:
             - const: mfc
             - const: sclk_mfc
         iommus:
-          maxItems: 2
+          minItems: 2
         iommus-names:
-          items:
-            - const: left
-            - const: right
+          minItems: 2
 
   - if:
       properties:
@@ -144,11 +142,9 @@ allOf:
           items:
             - const: mfc
         iommus:
-          maxItems: 2
+          minItems: 2
         iommus-names:
-          items:
-            - const: left
-            - const: right
+          minItems: 2
 
   - if:
       properties:
@@ -161,9 +157,6 @@ allOf:
         clocks:
           minItems: 1
           maxItems: 2
-        iommus:
-          minItems: 1
-          maxItems: 2
 
 examples:
   - |
-- 
2.43.0

