Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829FF7EF585
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjKQPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346029AbjKQPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:42:40 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44170126;
        Fri, 17 Nov 2023 07:42:36 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62DA71BF203;
        Fri, 17 Nov 2023 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPGUtDW2wu6xe9Vi1b7tVrkDIWPN7+oNEA+MDEXHBYg=;
        b=a3x6RiiiOKVI2mmDQDXEgwD/b+Guu1in/vpXEgFujB0kwdaiImm2j9+5UlNjvlC4XTIfvN
        PmtVly2u8fREf2FLah8JnyeUfF9Ac8S5tmYHCX5jd9wT1Yu8J5OPzviZGUvMhl78tYQncS
        jTuN3vu6RiWh2kd+65D/2BnAjzqchx6rLNTT4igmHC4izwAnHoildBh5qvcZU/D5sZBLGw
        zcTclg7FH3Y4fpwio2RPmiRUQOMGOElYUudTKiv9lZh9tUkeGubZAvsTs+oWxY4tLEo697
        +pxMtJr/sLZBpej4igVsEwYmmswp2mRToIh6Gu2pjwXgAUCAKbMol2/4kFCp+Q==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 2/3] media: dt-bindings: media: i2c: Add bindings for TW9900
Date:   Fri, 17 Nov 2023 16:42:28 +0100
Message-ID: <de0f0831cbbd64328b1e348168d5d6cf4bc65b0d.1700235276.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700235276.git.mehdi.djait@bootlin.com>
References: <cover.1700235276.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Techwell TW9900 is a video decoder supporting multiple input
standards such as PAL and NTSC and has a parallel BT.656 output
interface.

It's designed to be low-power, posesses some features such as a
programmable comb-filter, and automatic input standard detection

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 .../bindings/media/i2c/techwell,tw9900.yaml   | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
new file mode 100644
index 000000000000..e37317f81072
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
@@ -0,0 +1,137 @@
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
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Analog input port
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: CVBS over MUX0
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: CVBS over MUX1
+
+          endpoint@2:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: Chroma over CIN0 and Y over MUX0
+
+          endpoint@3:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: Chroma over CIN0 and Y over MUX1
+
+        oneOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+          - required:
+              - endpoint@2
+          - required:
+              - endpoint@3
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for the decoder output.
+
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/display/sdtv-standards.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    composite_connector {
+        compatible = "composite-video-connector";
+        label = "tv";
+        sdtv-standards = <(SDTV_STD_PAL | SDTV_STD_NTSC)>;
+
+        port {
+            composite_to_tw9900: endpoint {
+                remote-endpoint = <&tw9900_to_composite>;
+            };
+        };
+    };
+
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
+                port@0 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    reg = <0>;
+                    tw9900_to_composite: endpoint@0 {
+                        reg = <0>;
+                        remote-endpoint = <&composite_to_tw9900>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    endpoint {
+                        remote-endpoint = <&cif_in>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.41.0

