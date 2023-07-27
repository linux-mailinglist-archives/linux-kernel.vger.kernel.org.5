Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2972765D24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjG0UXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjG0UXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:23:07 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710602688;
        Thu, 27 Jul 2023 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690489386; x=1722025386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syGttct7/MMhyRZ0y8XJZbRtPo5+VsMlS6W5J8vJio8=;
  b=OM9ZNqQwtP3yGLTG4x4z30ZlmkKaWK426OM5+PzPR9jn3oGBkGGXVuqg
   2KtS0q1TRAJQBL0FO1pUS/jjb7bmzFfVhMmYe4Zu/fpfDrE3smz0EkpM8
   1AyACsER9LUKCcBufBA7OzR8DKFf6+gDgOL2QyoJyJXqAhVVUl4eCAL3d
   SalPbiLvylEwk/s+IBH+n/N8QEz+HIpum0tqUMIOsIVdpWw5s22rerX+g
   DgojNjR41X0czGc0gDdsocHNLKlJW4WBdONo/wVGGeTLvDTEah17jQ7jf
   jer/aY/umU/chovqY1D0mKeZZjnHnVmwjcMC4ybv87QVFM28udt1+m+0+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="358441168"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="358441168"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="850915735"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="850915735"
Received: from mtyszka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.133.203])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:23:02 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Tyrone Ting <warp5tw@gmail.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v3 1/4] dt-bindings: Add bindings for peci-npcm
Date:   Thu, 27 Jul 2023 22:21:23 +0200
Message-Id: <20230727202126.1477515-2-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230727202126.1477515-1-iwona.winiarska@intel.com>
References: <20230727202126.1477515-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Maimon <tmaimon77@gmail.com>

Add device tree bindings for the peci-npcm controller driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: Tyrone Ting <warp5tw@gmail.com>
Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
Changes v2 -> v3:

* Fixed dt_binding_check error (Rob)

Changes v1 -> v2:

* Renamed binding filename to match compatible (Krzysztof)
---
 .../bindings/peci/nuvoton,npcm-peci.yaml      | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml

diff --git a/Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml b/Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml
new file mode 100644
index 000000000000..087e02a9ade3
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/peci/nuvoton,npcm-peci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton PECI Bus
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+allOf:
+  - $ref: peci-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-peci
+      - nuvoton,npcm845-peci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Clock source for PECI controller. Should reference the APB clock.
+    maxItems: 1
+
+  cmd-timeout-ms:
+    minimum: 1
+    maximum: 1000
+    default: 1000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    peci-controller@f0100000 {
+      compatible = "nuvoton,npcm750-peci";
+      reg = <0xf0100000 0x200>;
+      interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk NPCM7XX_CLK_APB3>;
+      cmd-timeout-ms = <1000>;
+    };
+...
-- 
2.40.1

