Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0227C9458
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjJNLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 07:32:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C6AA9;
        Sat, 14 Oct 2023 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697283122; x=1728819122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+7rcNmKnwufjlL6AHwqt0bX7NfKG6QQIv0CPhQLel/I=;
  b=ZiFkVXUwMSq5eLfPqzjMwZBJyXoAqY4xNBSVwX13gq7T7quBIIolpTZ1
   4scMbml3Zl8j6IWkbXFBDMattM9Ig9/ypw0lyj7dk7y+lwR50qEUcEDQF
   Qc841uBcl9Ginx3WVwvv/mLi4UsbKilefWZkLm/UCd3qm/GjyAUCVNmO0
   ry/pG9hnVh6voyowWm3qKZby/Hvbm2j4kTEK02Qhl9pepRTF9nTWD+sXK
   2MSICnns9rgEh9Q7P4nkQmjY0MTJjy1LQpNMRpKqsPMtfqN5QxB6bRMBZ
   phD+1jRw/yL3vdCmpuOfzMQbe9q2UUsBIwgqpPQOOpmGbr7IQWzMmTJON
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389179269"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="389179269"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 04:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="928745036"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="928745036"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga005.jf.intel.com with ESMTP; 14 Oct 2023 04:31:59 -0700
From:   niravkumar.l.rabara@intel.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: soc: altera: convert socfpga-system.txt to yaml
Date:   Sat, 14 Oct 2023 19:29:05 +0800
Message-Id: <20231014112905.1512650-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Convert socfpga-system.txt to altr,socfpga-sys-mgr.yaml and move to
soc directory.

Add platform names in description for clarity. ARM(32-bit) platforms
Cyclone5, Arria5 and Arria10 is using "altr,sys-mgr" compatible,
while ARM64 is using "altr,sys-mgr-s10" compatible.
Removed "cpu1-start-addr" for ARM64 as it is not required.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---

Changes in v2:
- Added detail description of changes in commit message.
- Moved coverted yaml file to soc folder.  

 .../bindings/arm/altera/socfpga-system.txt    | 25 ---------
 .../soc/altera/altr,socfpga-sys-mgr.yaml      | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
 create mode 100644 Documentation/devicetree/bindings/soc/altera/altr,socfpga-sys-mgr.yaml

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
diff --git a/Documentation/devicetree/bindings/soc/altera/altr,socfpga-sys-mgr.yaml b/Documentation/devicetree/bindings/soc/altera/altr,socfpga-sys-mgr.yaml
new file mode 100644
index 000000000000..b8bf63bba567
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/altera/altr,socfpga-sys-mgr.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/altera/altr,socfpga-sys-mgr.yaml#
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: altr,sys-mgr-s10
+    then:
+      properties:
+        cpu1-start-addr: false
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
-- 
2.25.1

