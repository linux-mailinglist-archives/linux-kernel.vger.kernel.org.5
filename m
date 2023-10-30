Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E327B7DB9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJ3MZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjJ3MZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:25:25 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC01A2;
        Mon, 30 Oct 2023 05:25:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8E07C000F;
        Mon, 30 Oct 2023 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698668720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11p8GVTZYwN7sl4t6Y54rV8mWEh6v6UHata8/icFUYY=;
        b=dDCYFJjhM8hyWeR0+6alishjc7ficrxT36zoB21D3aDFdk+AOA5wlV7HMCEfGdmTTpJ3aA
        +HK2Iia8zUFQGX5wkHRvYaUshpl6kZkRO9i39l+t5s/mm6XBqcG65p1+vHiKrCQ30HoyLQ
        CQdecK69DavHsCN3OEAusxgNlLQg7chnZmfFQlD+7AvoIokyPEXQ3CKTlD3kt9CAM39gz1
        Ad+FHuxyEYA0RmmZNV1tCSWaMb072Psg3X9E5BafGLGquCQ1Y7XCGuIQOER45ReRw5jW06
        gLhZieAeiBaKcQrYZhKnfGESoz3OI+jff5qMNCH8RpILIzV/gpyaI4KuqE7odQ==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, michael.riesch@wolfvision.net,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v9 1/3] media: dt-bindings: media: add bindings for Rockchip CIF
Date:   Mon, 30 Oct 2023 13:25:12 +0100
Message-ID: <5f83d60031320c4c7b0f0727604903f50ee49058.1698666612.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1698666612.git.mehdi.djait@bootlin.com>
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
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

Add a documentation for the Rockchip Camera Interface
binding.

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
v8=>v9:
dropped the "Reviewed-by: Rob Herring <robh@kernel.org>"
because of the following changes:
- changed the compatible to rk3066-cif: rk3066 is the earliest Rockchip SoC
  that uses cif and it is the first model starting the RK30 lineup.
- adjusted the description
- changed the node name to video-capture


 .../bindings/media/rockchip,rk3066-cif.yaml   | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
new file mode 100644
index 000000000000..be69e474ed26
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/rockchip,rk3066-cif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip CIF Camera Interface
+
+maintainers:
+  - Mehdi Djait <mehdi.djait@bootlin.com>
+
+description: |
+  CIF is a camera interface present on some rockchip SoCs. It
+  receives the data from Camera sensor or CCIR656 encoder and
+  transfers it into system main memory by AXI bus.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3066-cif
+      - rockchip,px30-vip
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ACLK
+      - description: HCLK
+      - description: PCLK
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: pclk
+
+  resets:
+    items:
+      - description: AXI
+      - description: AHB
+      - description: PCLK IN
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+      - const: pclkin
+
+  power-domains:
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: A connection to a sensor or decoder
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/px30-cru.h>
+    #include <dt-bindings/power/px30-power.h>
+
+    parent {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        video-capture@ff490000 {
+            compatible = "rockchip,px30-vip";
+            reg = <0x0 0xff490000 0x0 0x200>;
+            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
+            clock-names = "aclk", "hclk", "pclk";
+            resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
+            reset-names = "axi", "ahb", "pclkin";
+            power-domains = <&power PX30_PD_VI>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&tw9900_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.41.0

