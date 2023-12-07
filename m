Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA5808A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443262AbjLGOat convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 09:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443309AbjLGOan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:30:43 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ABB93;
        Thu,  7 Dec 2023 06:30:49 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 05E24819E;
        Thu,  7 Dec 2023 22:30:48 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 22:30:48 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 22:30:40 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ilkka Koskinen" <ilkka@os.amperecomputing.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/3] dt-bindings: perf: starfive: Add JH8100 StarLink PMU
Date:   Thu, 7 Dec 2023 22:29:39 +0800
Message-ID: <20231207142940.1794032-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207142940.1794032-1-jisheng.teoh@starfivetech.com>
References: <20231207142940.1794032-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for StarFive's JH8100 StarLink PMU (Performance
Monitor Unit).

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../perf/starfive,jh8100-starlink-pmu.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
new file mode 100644
index 000000000000..915c6b814026
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/starfive,jh8100-starlink-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 StarLink PMU
+
+maintainers:
+  - Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
+
+description:
+  StarFive's JH8100 StarLink PMU integrates one or more CPU cores with a
+  shared L3 memory system. The PMU support overflow interrupt, up to
+  16 programmable 64bit event counters, and an independent 64bit cycle
+  counter. StarFive's JH8100 StarLink PMU is accessed via MMIO.
+
+properties:
+  compatible:
+    const: starfive,jh8100-starlink-pmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@12900000 {
+            compatible = "starfive,jh8100-starlink-pmu";
+            reg = <0x0 0x12900000 0x0 0x10000>;
+            interrupts = <34>;
+        };
+    };
-- 
2.25.1

