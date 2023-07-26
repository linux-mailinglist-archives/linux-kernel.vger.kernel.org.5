Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7508762959
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGZDgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B840268E;
        Tue, 25 Jul 2023 20:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D5C611B1;
        Wed, 26 Jul 2023 03:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21307C433C8;
        Wed, 26 Jul 2023 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690342562;
        bh=sxLcDLKkcr5fwf9GynK67WfceXdUXdkfWJfBfqa8qr0=;
        h=From:To:Cc:Subject:Date:From;
        b=Oj8JicSe4yn78ANfBFdZ0dy7fqDM3pwnVNMlbfSX0oD4McOrXlyN0F5xu/IuFH7aM
         T2SFsNfyHlRSktyG9t/o/0tmR8yLUwTas4OjeKNLsACWJEqkW40OiwpC+hYDWZx/+N
         Qenc9IVkrDuNqIZryUnUgzkOHdJASktg/tQbqoiyipLS66IAjE2R0b58pi5DVO/Bji
         UlyApIBvVqkaBVBXu1Acch3aAp3RNeiFF6gYi3pSB9GLiUP+jdl9OIn0datExghZhU
         WYQaWt/CH3diZdRn7IjXnw0nP1Fnp68gquVLUw+WliH987Qa0Zp0TD8KbjwDrtfqta
         AktIvWzEJWt8w==
Received: (nullmailer pid 174492 invoked by uid 1000);
        Wed, 26 Jul 2023 03:35:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: allwinner: prcm: Simplify conditional schemas
Date:   Tue, 25 Jul 2023 21:35:54 -0600
Message-Id: <20230726033554.174365-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for 'additionalProperties' in the if/then schema as there's
already 'unevaluatedProperties' in the parent schema. With
'additionalProperties' dropped, 'compatible' and 'phandle' don't need
to be listed in the conditional schemas as 'compatible' is already in
the main section and 'phandle' will be implicitly added.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../mfd/allwinner,sun6i-a31-prcm.yaml         | 43 ++-----------------
 .../mfd/allwinner,sun8i-a23-prcm.yaml         | 42 ------------------
 2 files changed, 3 insertions(+), 82 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
index cf94176fe1eb..8789e3639ff7 100644
--- a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
+++ b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
@@ -34,6 +34,9 @@ patternProperties:
           - allwinner,sun6i-a31-clock-reset
           - fixed-factor-clock
 
+    required:
+      - compatible
+
     allOf:
       - if:
           properties:
@@ -55,25 +58,17 @@ patternProperties:
             "#clock-cells":
               const: 0
 
-            # Already checked in the main schema
-            compatible: true
-
             clocks:
               maxItems: 2
 
             clock-output-names:
               maxItems: 1
 
-            phandle: true
-
           required:
             - "#clock-cells"
-            - compatible
             - clocks
             - clock-output-names
 
-          additionalProperties: false
-
       - if:
           properties:
             compatible:
@@ -85,25 +80,17 @@ patternProperties:
             "#clock-cells":
               const: 0
 
-            # Already checked in the main schema
-            compatible: true
-
             clocks:
               maxItems: 1
 
             clock-output-names:
               maxItems: 1
 
-            phandle: true
-
           required:
             - "#clock-cells"
-            - compatible
             - clocks
             - clock-output-names
 
-          additionalProperties: false
-
       - if:
           properties:
             compatible:
@@ -119,9 +106,6 @@ patternProperties:
                 offset of the bit controlling this particular gate in
                 the register.
 
-            # Already checked in the main schema
-            compatible: true
-
             clocks:
               maxItems: 1
 
@@ -129,16 +113,11 @@ patternProperties:
               minItems: 1
               maxItems: 32
 
-            phandle: true
-
           required:
             - "#clock-cells"
-            - compatible
             - clocks
             - clock-output-names
 
-          additionalProperties: false
-
       - if:
           properties:
             compatible:
@@ -150,9 +129,6 @@ patternProperties:
             "#clock-cells":
               const: 0
 
-            # Already checked in the main schema
-            compatible: true
-
             clocks:
               maxItems: 4
               description: >
@@ -162,16 +138,11 @@ patternProperties:
             clock-output-names:
               maxItems: 1
 
-            phandle: true
-
           required:
             - "#clock-cells"
-            - compatible
             - clocks
             - clock-output-names
 
-          additionalProperties: false
-
       - if:
           properties:
             compatible:
@@ -183,16 +154,8 @@ patternProperties:
             "#reset-cells":
               const: 1
 
-            # Already checked in the main schema
-            compatible: true
-
-            phandle: true
-
           required:
             - "#reset-cells"
-            - compatible
-
-          additionalProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml b/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
index 16c80a7eec49..e51f85519911 100644
--- a/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
+++ b/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
@@ -57,25 +57,17 @@ patternProperties:
             "#clock-cells":
               const: 0
 
-            # Already checked in the main schema
-            compatible: true
-
             clocks:
               maxItems: 1
 
             clock-output-names:
               maxItems: 1
 
-            phandle: true
-
           required:
             - "#clock-cells"
-            - compatible
             - clocks
             - clock-output-names
 
-          additionalProperties: false
-
       - if:
           properties:
             compatible:
@@ -91,9 +83,6 @@ patternProperties:
                 offset of the bit controlling this particular gate in
                 the register.
 
-            # Already checked in the main schema
-            compatible: true
-
             clocks:
               maxItems: 1
 
@@ -101,16 +90,11 @@ patternProperties:
               minItems: 1
               maxItems: 32
 
-            phandle: true
-
           required:
             - "#clock-cells"
-            - compatible
             - clocks
             - clock-output-names
 
-          additionalProperties: false
-
       - if:
           properties:
             compatible:
@@ -122,34 +106,8 @@ patternProperties:
             "#reset-cells":
               const: 1
 
-            # Already checked in the main schema
-            compatible: true
-
-            phandle: true
-
           required:
             - "#reset-cells"
-            - compatible
-
-          additionalProperties: false
-
-      - if:
-          properties:
-            compatible:
-              contains:
-                const: allwinner,sun8i-a23-codec-analog
-
-        then:
-          properties:
-            # Already checked in the main schema
-            compatible: true
-
-            phandle: true
-
-          required:
-            - compatible
-
-          additionalProperties: false
 
 required:
   - compatible
-- 
2.40.1

