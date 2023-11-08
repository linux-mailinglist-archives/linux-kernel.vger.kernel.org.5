Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F297E5B76
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjKHQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:39:06 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F161D1FE9;
        Wed,  8 Nov 2023 08:39:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1694020015;
        Wed,  8 Nov 2023 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699461542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RtXE1wjiBLai/i7W9NaqWPbO7B6YYMVmgm5e5vnHRQ=;
        b=Kgrw/c11NfggAEIgrA5u87lpugnnMRhm02uMzRCQLys6y1nzIq42VOEjZEN4SzAzUQuy9F
        pqQRXu70lUhAQ1N1JtRxutlfir6j3xL73Me0a+keNQUgyv1GgmjEQfHYWgQLkbPyY92uVh
        NJv00ZRcHcP8gd03J4kxuZcG9QlzdQyYUrA/LhRQZ5dgO2c71P5SNFKxEd0/DYx1C2Db0v
        aBb0uBe+KIOAnePWXU1idb/kiahIFCTL8HoJ8bpsVvqGI9tbFqZWSxNCoL67dsFjWrhNXi
        aRg3zGZ++b/ahJ+gM7nuArESWBrBfnaehh36Wyz6/O8JUkDY0z6VebN0lSsz0g==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, michael.riesch@wolfvision.net,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v10 1/3] media: dt-bindings: media: add bindings for Rockchip CIF
Date:   Wed,  8 Nov 2023 17:38:56 +0100
Message-ID: <037bcabf97294d37b271537e4b11fb88cf9bb6f6.1699460637.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699460637.git.mehdi.djait@bootlin.com>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation for the Rockchip Camera Interface binding.

the name of the file rk3066 is the first Rockchip SoC generation that uses cif
instead of the px30 which is just one of the many iterations of the unit.

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 .../bindings/media/rockchip,rk3066-cif.yaml   | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
new file mode 100644
index 000000000000..c3a5cd2baf71
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
@@ -0,0 +1,94 @@
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
+description:
+  CIF is a camera interface present on some rockchip SoCs. It receives the data
+  from Camera sensor or CCIR656 encoder and transfers it into system main memory
+  by AXI bus.
+
+properties:
+  compatible:
+    const: rockchip,px30-vip
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

