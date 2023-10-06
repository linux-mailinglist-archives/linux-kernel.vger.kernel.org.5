Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B81E7BBCA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjJFQZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjJFQZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:25:46 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10DC5;
        Fri,  6 Oct 2023 09:25:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BD0FC0007;
        Fri,  6 Oct 2023 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696609542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4frja/Z0fU1jjsXKtt1UqeAD/tIEo1D7QaLVLblbnE=;
        b=bmz6gafgImjV//OnB1RQOa7EHeMdE0iilrHuJy17Xw13oHOLdv7j6VuMMwENZhTMeg2euK
        eUJ6BJUzrHwMAL1yFQLbsIUuQYojZs8mENLjW3HwY+OsKNoe16dmusgADdP/Hi4Sr3Uxfu
        VH2fNa/6Ps2K8Ko3xq79dNd5yWBdD00gyQIj16erJYGguuB95y66lTNX6xTH2CydLJDrsH
        lf7oND2cRC/HF7glaLy/8UyNxA7puQhBwxOlTB4yOmT73keFuSN+NxnAtaSOtvjMPXy7Y4
        7di76NQvCbPpNW1oCcl5agc/lQOqpr9kUniBW7xSC/3cjhw6efzrckWbsCKzkg==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v6 2/3] media: dt-bindings: media: i2c: Add bindings for TW9900
Date:   Fri,  6 Oct 2023 18:25:29 +0200
Message-ID: <6ad44a04366e65d5baec08dd966f5c81995d626d.1696608809.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696608809.git.mehdi.djait@bootlin.com>
References: <cover.1696608809.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
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

 .../bindings/media/i2c/techwell,tw9900.yaml   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
new file mode 100644
index 000000000000..24bbbff5cc01
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
@@ -0,0 +1,61 @@
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
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Video port for the decoder output.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            tw9900: tw9900@44 {
+                    compatible = "techwell,tw9900";
+                    reg = <0x44>;
+
+                    vdd-supply = <&tw9900_supply>;
+                    reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+
+                    port {
+                            tw9900_out: endpoint {
+                                    remote-endpoint = <&vip_in>;
+                            };
+                    };
+            };
+    };
-- 
2.41.0

