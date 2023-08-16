Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC00177EB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346295AbjHPU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346289AbjHPU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:56:24 -0400
X-Greylist: delayed 1772 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 13:56:22 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AEB270A;
        Wed, 16 Aug 2023 13:56:22 -0700 (PDT)
Received: from p200300ccff49da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff49:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qWN6G-002hco-8F; Wed, 16 Aug 2023 22:26:40 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qWN6F-001MPV-1i;
        Wed, 16 Aug 2023 22:26:39 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andreas@kemnade.info, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: Add TI TWL603X GPADC
Date:   Wed, 16 Aug 2023 22:26:14 +0200
Message-Id: <20230816202614.324457-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document TI TWL603X GPADC devicetree bindings.
A driver is already there, the compatibles are used, but not documented.
Use two separate files to reference only the allowed compatible in
a future YAML version of
Documentation/devicetree/bindings/mfd/twl-family.txt

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/iio/adc/ti,twl6030-gpadc.yaml    | 42 +++++++++++++++++++
 .../bindings/iio/adc/ti,twl6032-gpadc.yaml    | 42 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6032-gpadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
new file mode 100644
index 000000000000..08bc0468f616
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,twl6030-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPADC subsystem in the TWL6030 power module
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  The GPADC subsystem in the TWL6030 consists of a 10-bit ADC
+  combined with a 15-input analog multiplexer.
+
+properties:
+  compatible:
+    const: ti,twl6030-gpadc
+
+  interrupts:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - interrupts
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    twl {
+        gpadc {
+            compatible = "ti,twl6030-gpadc";
+            interrupts = <3>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl6032-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl6032-gpadc.yaml
new file mode 100644
index 000000000000..70acec533277
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,twl6032-gpadc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,twl6032-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPADC subsystem in the TWL6032 power module
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  The GPADC subsystem in the TWL6032 consists of a 10-bit ADC
+  combined with a 19-input analog multiplexer.
+
+properties:
+  compatible:
+    const: ti,twl6032-gpadc
+
+  interrupts:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - interrupts
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    twl {
+        gpadc {
+            compatible = "ti,twl6032-gpadc";
+            interrupts = <3>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.39.2

