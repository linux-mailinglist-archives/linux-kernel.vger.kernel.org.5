Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1B7B2601
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjI1Tlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1Tlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:41:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68761A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:41:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE9AC433C7;
        Thu, 28 Sep 2023 19:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695930095;
        bh=+f/LROZgFTPzcFy5/y8VtrXLG8LIcts2Ik8CzlQ3RsM=;
        h=From:To:Cc:Subject:Date:From;
        b=GS04NkNVwjZ5aAvctflC98Uo4+fIaRixp/S7KhAw1pj6pKgWEnR6iDPnRHcMrbxWk
         GDRgbrpFlHSnG52T5EMZagd0oohD+/xcuCf4IvfL4xylZ6RTNK1drD97IFlFBhvAYe
         rMlWf9Os5/p+g+hY6SnSR+EjfGnV8WR42DL5Bu6SarRJs1I73kT6nkyt2N6xugHotX
         DZjlqz/z04UMNuNoCQsaclN3jzUEiyc2uE39Ahqx7ekUBFq46WzlKbD3tNmilxO26P
         x6jbj8r7HxHo4ukR3juucsPsAq1CpDdnM/+vHzKqpvc1t4NAi6L8MkFv3DsG1aPtw7
         SevonLnDNfLVg==
Received: (nullmailer pid 1147011 invoked by uid 1000);
        Thu, 28 Sep 2023 19:41:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: Simplify referencing dai-params.yaml
Date:   Thu, 28 Sep 2023 14:41:16 -0500
Message-Id: <20230928194126.1146622-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's generally no need to use definitions to reference from
individual properties. All the property names are the same, and all the
defined properties are used by all the users.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/audio-graph-port.yaml      | 20 ++++++-------------
 .../bindings/sound/audio-graph.yaml           |  9 +++------
 .../devicetree/bindings/sound/dai-params.yaml | 11 ++++------
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index fa9f9a853365..60b5e3fd1115 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -13,19 +13,17 @@ select: false
 
 definitions:
   port-base:
-    $ref: /schemas/graph.yaml#/$defs/port-base
+    allOf:
+      - $ref: /schemas/graph.yaml#/$defs/port-base
+      - $ref: /schemas/sound/dai-params.yaml#
     properties:
-      convert-rate:
-        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-rate
-      convert-channels:
-        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-channels
-      convert-sample-format:
-        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-format
       mclk-fs:
         $ref: simple-card.yaml#/definitions/mclk-fs
 
   endpoint-base:
-    $ref: /schemas/graph.yaml#/$defs/endpoint-base
+    allOf:
+      - $ref: /schemas/graph.yaml#/$defs/endpoint-base
+      - $ref: /schemas/sound/dai-params.yaml#
     properties:
       mclk-fs:
         $ref: simple-card.yaml#/definitions/mclk-fs
@@ -68,12 +66,6 @@ definitions:
             - pdm
             - msb
             - lsb
-      convert-rate:
-        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-rate
-      convert-channels:
-        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-channels
-      convert-sample-format:
-        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-format
 
       dai-tdm-slot-num:
         description: Number of slots in use.
diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
index ed31e04ff6a6..71f52f7e55f6 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
@@ -9,6 +9,9 @@ title: Audio Graph
 maintainers:
   - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
+allOf:
+  - $ref: /schemas/sound/dai-params.yaml#
+
 properties:
   dais:
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -30,12 +33,6 @@ properties:
       widget ("Microphone", "Line", "Headphone", "Speaker"), the
       second being the machine specific name for the widget.
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-  convert-rate:
-    $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-rate
-  convert-channels:
-    $ref: /schemas/sound/dai-params.yaml#/$defs/dai-channels
-  convert-sample-format:
-    $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-format
 
   pa-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/dai-params.yaml b/Documentation/devicetree/bindings/sound/dai-params.yaml
index f5fb71f9b603..cd8508175564 100644
--- a/Documentation/devicetree/bindings/sound/dai-params.yaml
+++ b/Documentation/devicetree/bindings/sound/dai-params.yaml
@@ -11,15 +11,14 @@ maintainers:
 
 select: false
 
-$defs:
-
-  dai-channels:
+properties:
+  convert-channels:
     description: Number of audio channels used by DAI
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
     maximum: 32
 
-  dai-sample-format:
+  convert-sample-format:
     description: Audio sample format used by DAI
     $ref: /schemas/types.yaml#/definitions/string
     enum:
@@ -29,12 +28,10 @@ $defs:
       - s24_3le
       - s32_le
 
-  dai-sample-rate:
+  convert-rate:
     description: Audio sample rate used by DAI
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 8000
     maximum: 192000
 
-properties: {}
-
 additionalProperties: true
-- 
2.40.1

