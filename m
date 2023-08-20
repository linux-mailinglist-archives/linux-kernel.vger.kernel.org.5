Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29D781DCA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHTMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjHTMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:37:52 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE67E4487;
        Sun, 20 Aug 2023 05:32:47 -0700 (PDT)
Received: from p200300ccff2b60001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2b:6000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qXhbi-002rBh-FG; Sun, 20 Aug 2023 14:32:38 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qXhbh-002Dyb-1n;
        Sun, 20 Aug 2023 14:32:37 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] dt-bindings: iio: adc: Add TI TWL603X GPADC
Date:   Sun, 20 Aug 2023 14:32:29 +0200
Message-Id: <20230820123229.530371-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document TI TWL603X GPADC devicetree bindings.
A driver is already there, the compatibles are used, but not documented.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/iio/adc/ti,twl6030-gpadc.yaml    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
new file mode 100644
index 000000000000..5b075237bcfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,twl6030-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPADC subsystem in the TWL6030 power module
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description:
+  The GPADC subsystem in the TWL603X consists of a 10-bit ADC
+  combined with a 15-input analog multiplexer in the TWL6030 resp. a
+  19-input analog muliplexer in the TWL6032.
+
+properties:
+  compatible:
+    enum:
+      - ti,twl6030-gpadc
+      - ti,twl6032-gpadc
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
-- 
2.39.2

