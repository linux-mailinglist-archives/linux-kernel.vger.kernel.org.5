Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF17CAA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjJPN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjJPN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:58:47 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B783;
        Mon, 16 Oct 2023 06:58:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D531A20003;
        Mon, 16 Oct 2023 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697464723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKroyI00sULjJiUSulXbUNd0S6lW+G9DyC1inAuNSDw=;
        b=WvrAyQb9u/Gx05zi6NiZDwTyv1QIxvnZ6OuohSZAcjaUjd6pS84O1yeNVCdb89j9PoABi1
        l3gDjLPI/zLJF/yDLkQw2hUlWitGDrPQ43+osqeVcNdJgGRqCbI0saU4kyLJGAfcyeKDkF
        9BhdhEXrTcXg6iEnbPaR22wOJBCSUatTBFjiri1seJNxFNn4YHk2UWsZddmUxh4iz7p76F
        L9PaTrZNZgH20AjmOHMILbK03oTj5rTB/IQQxKnfQ4oIhyYcae+R5SYYIbQfqF7L95ec9D
        pkxantwZNtDq74SjR4kJuOXGOYVrtHD+1jGBxrpSdu23ARL0DVgu0TN08QDyVg==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v7 2/3] media: dt-bindings: media: i2c: Add bindings for TW9900
Date:   Mon, 16 Oct 2023 15:58:32 +0200
Message-ID: <d5b2b2584fd471a037e574086bfd193b22fb9587.1697463708.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697463708.git.mehdi.djait@bootlin.com>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Techwell TW9900 is a video decoder supporting multiple input
standards, such as PAL and NTSC, and outputs a BT.656 video
signal.

It's designed to be low-power, posesses some features such as a
programmable comb-filter, and automatic input standard detection

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
V6->V7: 
- added powerdown-gpios and input ports
- used 4 spaces for example identation

V5->V6: 
- This commit had a "Reviewed-by: Rob Herring <robh@kernel.org>" Tag but
  decided not to collect it because the last Iteration was more than 2
  years ago
- removed SECAM from the mentioned standards
- changed maintainer

V4->V5: 
- renamed the file to match the compatible string, and referenced
  the graph.yaml schema

V3->V4: 
- add the missing reset-gpios node to the binding

V2->V3: 
- fix the example not compiling due to a typo in the reset-gpios
  node.

 .../bindings/media/i2c/techwell,tw9900.yaml   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
new file mode 100644
index 000000000000..244289a9a3e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/techwell,tw9900.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Techwell TW9900 NTSC/PAL video decoder
+
+maintainers:
+  - Mehdi Djait <mehdi.djait@bootlin.com>
+
+description:
+  The tw9900 is a multi-standard video decoder, supporting NTSC, PAL standards
+  with auto-detection features.
+
+properties:
+  compatible:
+    const: techwell,tw9900
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: VDD power supply
+
+  reset-gpios:
+    description: GPIO descriptor for the RESET input pin
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO descriptor for the POWERDOWN input pin
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for the decoder output.
+
+    patternProperties:
+      "^port@[0-2]$":
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Analog video input port.
+
+    required:
+      - port@3
+
+required:
+  - compatible
+  - ports
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        video-decoder@44 {
+            compatible = "techwell,tw9900";
+            reg = <0x44>;
+
+            vdd-supply = <&tw9900_supply>;
+            reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@3 {
+                    reg = <3>;
+                    endpoint {
+                        remote-endpoint = <&vip_in>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.41.0

