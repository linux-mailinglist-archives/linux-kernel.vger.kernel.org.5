Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFAD783B30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjHVHwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjHVHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:52:30 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047819E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:52:26 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37M7pfxP026542;
        Tue, 22 Aug 2023 15:51:41 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RVM1W67vKz2QDlXq;
        Tue, 22 Aug 2023 15:49:19 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 22 Aug
 2023 15:51:39 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jinfeng.lin1@unisoc.com>, <jianshengwu16@gmail.com>
Subject: [PATCH 1/2] dt-bindings: spi: Convert sprd spi bindings to yaml
Date:   Tue, 22 Aug 2023 15:51:12 +0800
Message-ID: <20230822075113.25506-2-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
References: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37M7pfxP026542
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sprd,sc27xx-pmic.txt to yaml, and add UMP962x series PMICs.

Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 .../bindings/mfd/sprd,sc27xx-pmic.txt         | 40 ---------
 .../bindings/mfd/sprd,sc27xx-pmic.yaml        | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
deleted file mode 100644
index 21b9a897fca5..000000000000
--- a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Spreadtrum SC27xx Power Management Integrated Circuit (PMIC)
-
-The Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723, SC2730
-and SC2731. The Spreadtrum PMIC belonging to SC27xx series integrates all
-mobile handset power management, audio codec, battery management and user
-interface support function in a single chip. It has 6 major functional
-blocks:
-- DCDCs to support CPU, memory.
-- LDOs to support both internal and external requirement.
-- Battery management system, such as charger, fuel gauge.
-- Audio codec.
-- User interface function, such as indicator, flash LED and so on.
-- IC level interface, such as power on/off control, RTC and typec and so on.
-
-Required properties:
-- compatible: Should be one of the following:
-	"sprd,sc2720"
-	"sprd,sc2721"
-	"sprd,sc2723"
-	"sprd,sc2730"
-	"sprd,sc2731"
-- reg: The address of the device chip select, should be 0.
-- spi-max-frequency: Typically set to 26000000.
-- interrupts: The interrupt line the device is connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: The number of cells to describe an PMIC IRQ, must be 2.
-- #address-cells: Child device offset number of cells, must be 1.
-- #size-cells: Child device size number of cells, must be 0.
-
-Example:
-pmic@0 {
-	compatible = "sprd,sc2731";
-	reg = <0>;
-	spi-max-frequency = <26000000>;
-	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml
new file mode 100644
index 000000000000..590970a17143
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: |
+  Spreadtrum SC27xx and UMP96xx Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  The Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723, SC2730, SC2731
+  and UMP96xx series PMICs contain ump9620, ump962 and ump9622. The Spreadtrum PMIC
+  belonging to SC27xx series and ump962x series integrates all mobile handset power
+  management, audio codec, battery management and user interface support function in
+  a single chip. It has 6 major functional.
+
+blocks:
+  - DCDCs to support CPU, memory.
+  - LDOs to support both internal and external requirement.
+  - Battery management system, such as charger, fuel gauge.
+  - Audio codec.
+  - User interface function, such as indicator, flash LED and so on.
+  - IC level interface, such as power on/off control, RTC and typec and so on.
+
+allOf:
+  - $ref: /schemas/spi/sprd,spi-adi.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc2720
+      - sprd,sc2721
+      - sprd,sc2723
+      - sprd,sc2730
+      - sprd,sc2731
+      - sprd,ump9620
+      - sprd,ump9621
+      - sprd,ump9622
+
+  reg:
+    maxItems: 7
+    description: The address of the device chip select
+
+  spi-max-frequency:
+    default: 26000000
+
+  interrupts: true
+
+  interrupt-controller:
+    description: Marks the device node as an interrupt controller.
+
+  interrupt-cells:
+    const: 2
+    description: The number of cells to describe an PMIC IRQ, must be 2.
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - '#address-cells' # Child device offset number of cells, must be 1.
+  - '#size-cells' # Child device size number of cells, must be 0.
+
+unevaluatedProperties: false
+
+Example:
+  - |
+    adi_bus {
+        pmic@0 {
+            compatible = "sprd,sc2731";
+            reg = <0>;
+            spi-max-frequency = <26000000>;
+            interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
+...
-- 
2.17.1

