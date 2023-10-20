Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3287D0E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377149AbjJTLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377116AbjJTLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:34:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC36D5A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:34:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso1004687a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697801667; x=1698406467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxGWL09T/U8ViEdhIaJ8zHze/hctW85nUnnCuD7crpg=;
        b=OlAcPWgLgD5XQa2g1oABOiYlOkQ0cmgeab74PrKT4ZPAsADa30zkJVqQSz7AkiMysC
         73c4cAX3+oK2eT1qRc5hZpj5+kUo12hVA2hWISPQAB2xu4BmOWaC5n0Sp/fV/gNKlCK5
         UMVnSf3hg/5JVGD3nMhotEI2gjIyiSebOBTZFEvotRyEZrIk2u3W3StuSvtfojAuJ0eW
         RLsQGrjhW7rhLeO5PQ4+Apld9ljYI6A/V/kD1/mlTXEbJOcNL55u2rG7NqE2vW2KVltN
         QwauF6QN/zmJTbv99T9knK67PyUlPg47AbtHQQfs02+KoHEQ74+2HBsURq1rudKc9J2+
         7Qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697801667; x=1698406467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxGWL09T/U8ViEdhIaJ8zHze/hctW85nUnnCuD7crpg=;
        b=FFXLsqaJyfwu2r4uvb4dAFtgwrMC+lQCyIjWFhGEIaepShIOtpaKxWtqnIFIUihBF5
         QFaRQgV+E/CFgCpPJF6UBQ0AnPYLbS7v7t6pEjgSWuCV9If9NS0+tUj+L8aqh7WEHici
         v9HHWNsup0yJ1l1NTb+NpyowYvRa83Ti53SGJwcnpwGVK+BnEkZi8tc+f1Ok5tSRHpgK
         alSprtDcP9yGKeC1KZ6OZxjG1aM26mhRfB31vbNPEOUHdoRpSHofaZmli8zZeimJELs2
         Fy1RUiX4Gs0Xq3lJakVxzSXfWIcu5a8MPuxwLQ5YzkYEjVgJhduKnXTAg2pV1xTw5IBV
         iEuA==
X-Gm-Message-State: AOJu0YzKFHcfhR8fDBXYGTMyCIVRBKPN+wEgJBNNfDBwVVp1WPvRyp1w
        nUPikTC3ppRmcuSQj516qtQV1A==
X-Google-Smtp-Source: AGHT+IHMEcSQYLg9QnANE/SCuKGkV1bpDxt4qIA1Ne26TTi2jlK39j64HmyMxOHY7QP2okztXw4xzQ==
X-Received: by 2002:a17:907:741:b0:9a5:9038:b1e7 with SMTP id xc1-20020a170907074100b009a59038b1e7mr1093606ejb.36.1697801667115;
        Fri, 20 Oct 2023 04:34:27 -0700 (PDT)
Received: from capella.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id ce10-20020a170906b24a00b009b654751c14sm1300320ejb.47.2023.10.20.04.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:34:26 -0700 (PDT)
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Fri, 20 Oct 2023 13:34:15 +0200
Subject: [PATCH v5 2/3] dt-bindings: clock: si5351: add PLL reset mode
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231020-alvin-clk-si5351-no-pll-reset-v5-2-f0c1ba537f88@bang-olufsen.dk>
References: <20231020-alvin-clk-si5351-no-pll-reset-v5-0-f0c1ba537f88@bang-olufsen.dk>
In-Reply-To: <20231020-alvin-clk-si5351-no-pll-reset-v5-0-f0c1ba537f88@bang-olufsen.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

For applications where the PLL must be adjusted without glitches in the
clock output(s), a new silabs,pll-reset-mode property is added. It
can be used to specify whether or not the PLL should be reset after
adjustment. Resetting is known to cause glitches.

For compatibility with older device trees, it must be assumed that the
default PLL reset mode is to unconditionally reset after adjustment.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Jacob Siverskog <jacob@teenage.engineering>
Cc: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 .../devicetree/bindings/clock/silabs,si5351.yaml   | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
index 494fa49a0c1b..d3e0ec29993b 100644
--- a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
+++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
@@ -62,6 +62,27 @@ properties:
         - description: PLL source, XTAL (0) or CLKIN (1, Si5351C only).
           enum: [ 0, 1 ]
 
+  silabs,pll-reset-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 2
+    description: A list of cell pairs containing a PLL index and its reset mode.
+    items:
+      items:
+        - description: PLL A (0) or PLL B (1)
+          enum: [ 0, 1 ]
+        - description: |
+            Reset mode for the PLL. Mode can be one of:
+
+                0 - reset whenever PLL rate is adjusted (default mode)
+                1 - do not reset when PLL rate is adjusted
+
+            In mode 1, the PLL is only reset if the silabs,pll-reset is
+            specified in one of the clock output child nodes that also sources
+            the PLL. This mode may be preferable if output clocks are expected
+            to be adjusted without glitches.
+          enum: [ 0, 1 ]
+
 patternProperties:
   "^clkout@[0-7]$":
     type: object
@@ -195,6 +216,9 @@ examples:
         /* Use XTAL input as source of PLL0 and PLL1 */
         silabs,pll-source = <0 0>, <1 0>;
 
+        /* Don't reset PLL1 on rate adjustment */
+        silabs,pll-reset-mode = <1 1>;
+
         /*
          * Overwrite CLK0 configuration with:
          * - 8 mA output drive strength

-- 
2.42.0

