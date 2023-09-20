Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8737A711F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjITDvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjITDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:51:15 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D01FB0;
        Tue, 19 Sep 2023 20:51:07 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1978106:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 20 Sep 2023 11:50:36 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 20 Sep
 2023 11:50:35 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 20 Sep 2023 11:50:35 +0800
From:   <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] ASoC: dt-bindings: Add Richtek rtq9128 audio amplifier
Date:   Wed, 20 Sep 2023 11:50:33 +0800
Message-ID: <1695181834-5809-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695181834-5809-1-git-send-email-cy_huang@richtek.com>
References: <1695181834-5809-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Create richtek,rtq9128.yaml for rtq9128 amplifier.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3
- Add Reviewed-by tag

v2
- Dual license
- Add $ref for dai-common.yaml
- Remove delimiter '|' in head of description
---
 .../bindings/sound/richtek,rtq9128.yaml       | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml

diff --git a/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml b/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
new file mode 100644
index 000000000000..d117f08fff30
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/richtek,rtq9128.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RTQ9128 Automative Audio Power Amplifier
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description:
+  The RTQ9128 is a ultra-low output noise, high-efficiency, four-channel
+  class-D audio power amplifier and delivering 4x75W into 4OHm at 10%
+  THD+N from a 25V supply in automotive applications.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rtq9128
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      speaker@1a {
+        compatible = "richtek,rtq9128";
+        reg = <0x1a>;
+        enable-gpios = <&gpio 26 GPIO_ACTIVE_HIGH>;
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.34.1

