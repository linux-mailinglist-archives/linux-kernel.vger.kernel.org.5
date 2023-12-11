Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6980C935
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjLKMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjLKMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:14:38 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABADC;
        Mon, 11 Dec 2023 04:14:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 795DD1C000A;
        Mon, 11 Dec 2023 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702296882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eg87ZovtTfscZWbYAJIdbHo+yXOg2XwLG3HN8O/pMsg=;
        b=QH6gccPCVALh6eD2FyEtc0C4RVC37GtrEsTRk8a6j6rGH5DXwN/K/MchaZW0XGMjeS0PEK
        z7NWkjpCKIjM7g7/2qBTUzDN86vdFLHhJE/89nx5n7uU2U8hcAgWLPupdbCpdWPzIXrcT9
        5CiVDc5WFQqevtFhwv23E+qnfFxoSFkbL10GEtWaMX5yJdyK9joUEiTUpZV2Pz+RlI48AO
        Z5rbWBFA7+QM5JKjjKHgSsHdovYI3gMx+39g43BKf+TBRJwtXDvr77XVMix4EV7/Y6kXXY
        XoaYMqjIDVuG9iHlaRVyxNh8fBMUBbmtewZRQkVRP3TLr0he4PfRYA8GLWFFwA==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     catalin.popescu@leica-geosystems.com,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v5 2/3] dt-bindings: input: Add TouchNetix axiom touchscreen
Date:   Mon, 11 Dec 2023 13:14:28 +0100
Message-ID: <20231211121430.1689139-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TouchNetix axiom I2C touchscreen device tree bindings
documentation.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 .../input/touchscreen/touchnetix,ax54a.yaml   | 64 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
new file mode 100644
index 000000000000..cbdf48fc538b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/touchnetix,ax54a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TouchNetix Axiom series touchscreen controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    const: touchnetix,ax54a
+
+  reg:
+    const: 0x66
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdda-supply:
+    description: Analog power supply regulator on VDDA pin
+
+  vddi-supply:
+    description: I/O power supply regulator on VDDI pin
+
+  poll-interval: true
+
+required:
+  - compatible
+  - reg
+  - vdda-supply
+  - vddi-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@66 {
+        compatible = "touchnetix,ax54a";
+        reg = <0x66>;
+        interrupt-parent = <&gpio2>;
+        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+        vdda-supply = <&vdda_reg>;
+        vddi-supply = <&vddi_reg>;
+        poll-interval = <20>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7608b714653f..4752d8436dbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21431,6 +21431,12 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
 F:	drivers/platform/x86/think-lmi.?
 
+TOUCHNETIX AXIOM I2C TOUCHSCREEN DRIVER
+M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
+
 THUNDERBOLT DMA TRAFFIC TEST DRIVER
 M:	Isaac Hazan <isaac.hazan@intel.com>
 L:	linux-usb@vger.kernel.org
-- 
2.25.1

