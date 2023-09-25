Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A67AE0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjIYV2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjIYV2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:28:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430F116;
        Mon, 25 Sep 2023 14:28:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0AEC433C7;
        Mon, 25 Sep 2023 21:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695677306;
        bh=k11FO+tobwQenACLbB1LItsIBnNjBvlbdtKW6gNnERY=;
        h=From:To:Cc:Subject:Date:From;
        b=rQZVyhr3IPEgAE4KzzEUwj0cAEByNb9PaIJzK7+u8ldY99AxBPw21hErFOB/JI/cX
         yXuGvT4kODgmEiHkGUDE+kWO4J80HxMvQkldvUUNd2A9oQgC3y4VAsjQ2O41vI3RwH
         9vS9eZsR2eA6LZmBhZLOHg7wQl5+7WKjxXmeTZWScBX9G+hGUFyOBp3g+YX3R4kgNy
         aH6jOLodIHUmmCNGywN0e/QlkeFAO2+geFUpLToV9CdM7oiFP+Fyry9W7xtVMKtv4X
         2FKgOm5UYKZhE8KxKxVvVd9RXjYMn0ooSkFnRZEJL/p+VSW3FdFBWQ2SjNMJgPMeEG
         BT1XuAKOH/X9w==
Received: (nullmailer pid 1977290 invoked by uid 1000);
        Mon, 25 Sep 2023 21:28:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: Add missing unevaluatedProperties on child node schemas
Date:   Mon, 25 Sep 2023 16:27:58 -0500
Message-Id: <20230925212803.1976803-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml    | 1 +
 .../devicetree/bindings/media/i2c/toshiba,tc358746.yaml         | 2 ++
 Documentation/devicetree/bindings/media/samsung,fimc.yaml       | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
index ffccf5f3c9e3..642f9b15d359 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
@@ -54,6 +54,7 @@ properties:
 
   port:
     $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
 
     properties:
       endpoint:
diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
index c5cab549ee8e..1c476b635b69 100644
--- a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
@@ -69,6 +69,7 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description: Input port
 
         properties:
@@ -89,6 +90,7 @@ properties:
 
       port@1:
         $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description: Output port
 
         properties:
diff --git a/Documentation/devicetree/bindings/media/samsung,fimc.yaml b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
index 79ff6d83a9fd..b3486c38a05b 100644
--- a/Documentation/devicetree/bindings/media/samsung,fimc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
@@ -57,6 +57,7 @@ properties:
     patternProperties:
       "^port@[01]$":
         $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description:
           Camera A and camera B inputs.
 
-- 
2.40.1

