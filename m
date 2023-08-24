Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD178743E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbjHXPba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbjHXPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:31:12 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925D619BA;
        Thu, 24 Aug 2023 08:31:10 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 63F8C8CC7F8; Thu, 24 Aug 2023 17:31:09 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: misc: rohm,bm92txx: Add BM92Txx support
Date:   Thu, 24 Aug 2023 17:30:53 +0200
Message-ID: <20230824153059.212244-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824153059.212244-1-linkmauve@linkmauve.fr>
References: <20230824153059.212244-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BM92T36 is used in the Nintendo Switch as its USB-C Power Delivery
controller.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 .../bindings/misc/rohm,bm92txx.yaml           | 67 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/rohm,bm92txx.yaml

diff --git a/Documentation/devicetree/bindings/misc/rohm,bm92txx.yaml b/Documentation/devicetree/bindings/misc/rohm,bm92txx.yaml
new file mode 100644
index 000000000000..0322a7f096f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/rohm,bm92txx.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2023 Emmanuel Gil Peyrot
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/rohm,bm92txx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BM92Txx USB-C Power Delivery Controller
+
+maintainers:
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+properties:
+  compatible:
+    enum:
+      - rohm,bm92t10
+      - rohm,bm92t20
+      - rohm,bm92t30
+      - rohm,bm92t36
+      - rohm,bm92t50
+
+  reg:
+    maxItems: 1
+
+  rohm,dp-signal-toggle-on-resume:
+    type: boolean
+    description: |
+      Do a toggle on resume instead of disable in suspend and enable in resume,
+      because this also disables the LED effects.
+
+  rohm,led-static-on-suspend:
+    type: boolean
+    description: Dim or breathing dock LED.
+
+  rohm,dock-power-limit-disable:
+    type: boolean
+    description: Disable the power limit in dock mode.
+
+  rohm,dp-alerts-enable:
+    type: boolean
+    description: Enable DisplayPort alerts.
+
+  rohm,pd-5v-current-limit-ma:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2000
+    description: Current limit in mA when voltage is 5V.
+
+  rohm,pd-9v-current-limit-ma:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2000
+    description: Current limit in mA when voltage is 9V.
+
+  rohm,pd-12v-current-limit-ma:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1500
+    description: Current limit in mA when voltage is 12V.
+
+  rohm,pd-15v-current-limit-ma:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1200
+    description: Current limit in mA when voltage is 15V.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index d590ce31aa72..cc100a02fa7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18453,6 +18453,11 @@ F:	include/linux/mfd/rohm-bd957x.h
 F:	include/linux/mfd/rohm-generic.h
 F:	include/linux/mfd/rohm-shared.h
 
+ROHM USB-C POWER DELIVERY CONTROLLERS
+M:	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+S:	Supported
+F:	Documentation/devicetree/bindings/misc/rohm,bm92txx.yaml
+
 ROSE NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-- 
2.42.0

