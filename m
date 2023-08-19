Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF987819CF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjHSNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHSNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:44:09 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A311FD03;
        Sat, 19 Aug 2023 06:42:06 -0700 (PDT)
Received: from p200300ccff2bce001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2b:ce00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDF-002nxf-VO; Sat, 19 Aug 2023 15:41:57 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDF-001ueD-2B;
        Sat, 19 Aug 2023 15:41:57 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: clock: add TWL6032 32K clocks
Date:   Sat, 19 Aug 2023 15:41:45 +0200
Message-Id: <20230819134147.456060-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819134147.456060-1-andreas@kemnade.info>
References: <20230819134147.456060-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to be referenced from a future yaml-version of
mfd/twl-family.txt depending on toplevel compatible have a separate file
for the 6032

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/clock/ti,twl6032-clk.yaml        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
new file mode 100644
index 0000000000000..aebd9f8d761a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,twl6032-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clocks of the TWL6032 PMIC
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description:
+  The TWL6032 has some 32Khz clock outputs which can be controlled.
+
+properties:
+  compatible:
+    enum:
+      - ti,twl6032-clk32kaudio
+      - ti,twl6032-clk32kg
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    twl {
+        clk32kaudio {
+            compatible = "ti,twl6032-clk32kaudio";
+            #clock-cells = <0>;
+        };
+    };
+...
-- 
2.39.2

