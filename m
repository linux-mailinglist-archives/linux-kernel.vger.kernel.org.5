Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EEB762B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjGZGgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjGZGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:36:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D982116
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:36:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso2933180e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690353373; x=1690958173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayyVdy2SPTLgLEOyosJwICplFlSWRn2s+e25D/uiqqQ=;
        b=n1Kx737Dxds1SWzQjW2/U3tPFuteCpA+DX2cIXLx+k49SV9UelUEwA6uydmqWRJriD
         pR+McjTeIc7SDNahMZ//vDbYRIXCg+OhrtmxDjg2fjB8Z5yNbaDHsBdUiI+qQafo+6hh
         e1Woo6SCdCEwqe/LqLUyAVl8N68FPGP7yBxqgY5JkvjF8YJNkODKISPovxqPXw6L611p
         qS1XnRJt6xWLSsIQ8dQZvEWX2TjWzNHcoK33WuUNrXj5zIb9Djgp07SE488wC0S/hXme
         HqJkExC+AFpgEhItIwbQ7hw+ap+hwwxqetIKAbF2QNugyKn/ViJDovHGbwoQSMd8OU3w
         XkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690353373; x=1690958173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayyVdy2SPTLgLEOyosJwICplFlSWRn2s+e25D/uiqqQ=;
        b=W1ieezSvQbzGzGD92I2Ds7y3okImhNc7FfQwZFgMeFkjLQp0kmZvmD7d4AgBE2WSK6
         y9NmXuZusSuVHIF3Eqv9m93tlqsOoztEkIpy7ukallqOcVjXbu76+oh9AaLDwlMl2IFe
         GlUL6Nvehcgf3iUS85i4cdCr5F9cl4Mn8tSlC9tqMoCo1AVilAwrecLvY8iTdLCsIhIi
         SCaMs2wK22fFOiCJx7t/EnogKbv1QuMCE43qHMuYSEyb4DKbOtL2C0v/Qm8EMr8iSNg3
         8xr+odpHizc2A+MusOnXCHzNx1GaLMfW7R6uXr3j+89xBVAqDdYDrZvwTL00UQ8CBPj2
         veqQ==
X-Gm-Message-State: ABy/qLalkgsJxEwOu/X02RMuR2GjHmjoI1KDdEqMuKZ4sII69Z4mlmyy
        Xudcu4L3kH0CwrNf2+icERCzwg==
X-Google-Smtp-Source: APBJJlFt69+XhfYUJpqwCQlV1ZVMGgKnsQV2XBBGmzo/w6LirjbkRjUvU1GtbnakErn20Zt2xWcRjQ==
X-Received: by 2002:ac2:5e2f:0:b0:4fb:8f79:631 with SMTP id o15-20020ac25e2f000000b004fb8f790631mr623122lfg.46.1690353373205;
        Tue, 25 Jul 2023 23:36:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t24-20020aa7d718000000b0051de20c59d7sm8336270edq.15.2023.07.25.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:36:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: mfd: st,stpmic1: Merge patterns for nodes
Date:   Wed, 26 Jul 2023 08:36:09 +0200
Message-Id: <20230726063610.5394-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties should be described only once, thus having separate pattern
for children just to specify the $ref to regulator.yaml is not correct.
It also makes impossible to finish it with
additional/unevaluatedProperties:false to restrict allowed properties in
regulator node.

Merge the patterns, so each regulator subnode has regulator.yaml $ref,
additional properties and ends with additionalProperties:false.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Merge the entries instead of duplicating regulator properties.
---
 Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
index 97c61097f9e2..0eccfc01233f 100644
--- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
@@ -106,6 +106,7 @@ properties:
         const: st,stpmic1-regulators
 
       ldo3:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -128,6 +129,7 @@ properties:
         additionalProperties: false
 
       ldo4:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -147,6 +149,7 @@ properties:
         additionalProperties: false
 
       vref_ddr:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -165,6 +168,7 @@ properties:
         additionalProperties: false
 
       boost:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -187,10 +191,8 @@ properties:
       "^(buck[1-4]|ldo[1-6]|vref_ddr|boost|pwr_sw[1-2])-supply$":
         description: STPMIC1 voltage regulators supplies
 
-      "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
-        $ref: ../regulator/regulator.yaml
-
       "^ldo[1-2,5-6]$":
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -213,6 +215,7 @@ properties:
         additionalProperties: false
 
       "^buck[1-4]$":
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -237,6 +240,7 @@ properties:
         additionalProperties: false
 
       "^pwr_sw[1-2]$":
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
-- 
2.34.1

