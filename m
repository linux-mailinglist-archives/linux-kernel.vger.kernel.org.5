Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC63F7B76C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 05:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjJDDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJDDKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 23:10:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91824A6;
        Tue,  3 Oct 2023 20:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696389001; x=1727925001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mJnhoo943eKVTSYrVP9yvYUDpIcrgWMkHfVZOqgfH5k=;
  b=SuvijANy3V00euQbJcJHFHElhVyO/QfkFqbklw9bMUybWmo1x2KFpUhw
   gXIVQh7wV0x94AMy0Mc+QZXzVzbeFaapGZo2nQwmoQjVOCd58gdESAB/B
   yNEPFrOgEFPYR5/U1KQAxaCupF38/OanlhHu9B3bxYD9IPZMxXFVJZckp
   AF1+7HRcjmTTE3DmCj4AGHr0rRHxhvTETZg+T5LNJBYZmcVq9tte/ySSg
   WdJ0lz3C6or18DCxN1TQEyB/U9mEZFM5V9A2YsKjBMLrkjWLZsgAdc4dx
   DNntWCrvtpS8zrGMyHvf7uAAXajoIYGkN8dROIMAzMlOqfkoZ4Y3S2hyF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="362395999"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="362395999"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 20:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="924889221"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="924889221"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga005.jf.intel.com with ESMTP; 03 Oct 2023 20:09:56 -0700
From:   niravkumar.l.rabara@intel.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to yaml
Date:   Wed,  4 Oct 2023 11:07:23 +0800
Message-Id: <20231004030723.11082-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Convert socfpga-system.txt to altr,sys-mgr.yaml.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 .../bindings/arm/altera/altr,sys-mgr.yaml     | 50 +++++++++++++++++++
 .../bindings/arm/altera/socfpga-system.txt    | 25 ----------
 2 files changed, 50 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-system.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml b/Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml
new file mode 100644
index 000000000000..8deb70aef664
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/altera/altr,sys-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA System Manager
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - description: Cyclone5/Arria5/Arria10
+        const: altr,sys-mgr
+      - description: Stratix10 SoC
+        items:
+          - const: altr,sys-mgr-s10
+          - const: altr,sys-mgr
+
+  reg:
+    maxItems: 1
+
+  cpu1-start-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: CPU1 start address in hex
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: altr,sys-mgr-s10
+then:
+  properties:
+    cpu1-start-addr: false
+
+additionalProperties: false
+
+examples:
+  - |
+    sysmgr@ffd08000 {
+      compatible = "altr,sys-mgr";
+      reg = <0xffd08000 0x1000>;
+      cpu1-start-addr = <0xffd080c4>;
+    };
diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
deleted file mode 100644
index 82edbaaa3f85..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Altera SOCFPGA System Manager
-
-Required properties:
-- compatible : "altr,sys-mgr"
-- reg : Should contain 1 register ranges(address and length)
-- cpu1-start-addr : CPU1 start address in hex.
-
-Example:
-	 sysmgr@ffd08000 {
-		compatible = "altr,sys-mgr";
-		reg = <0xffd08000 0x1000>;
-		cpu1-start-addr = <0xffd080c4>;
-	};
-
-ARM64 - Stratix10
-Required properties:
-- compatible : "altr,sys-mgr-s10"
-- reg : Should contain 1 register range(address and length)
-        for system manager register.
-
-Example:
-	 sysmgr@ffd12000 {
-		compatible = "altr,sys-mgr-s10";
-		reg = <0xffd12000 0x228>;
-	};
-- 
2.25.1

