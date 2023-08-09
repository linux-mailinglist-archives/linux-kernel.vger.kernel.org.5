Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A597750F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHICbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHICbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:31:03 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2181980;
        Tue,  8 Aug 2023 19:31:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3792Unld030651;
        Tue, 8 Aug 2023 21:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691548249;
        bh=gBt1esfemGci73ojBGweJMx36TwAFnIc29q9IeP0Vqw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZNXkGfV20CbHtN/4+1hbuXHLjdp/MV3pfjP3+k7jMsUst1D1274q2BenxxHxcJxQD
         oov5SPIjMVztImZeY/ofFmdby0WzZuBcFMKAVbmOGEo0nN6O0OOSfJcRT8wGrBwISz
         K2Ua3JGfjneLDVp+lJp0ddV1MEIsFfqXXOVIAPag=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3792Unnh060937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 21:30:49 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 21:30:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 21:30:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3792UmMD128419;
        Tue, 8 Aug 2023 21:30:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 2/2] dt-bindings: cpufreq: Convert ti-cpufreq to json schema
Date:   Tue, 8 Aug 2023 21:30:45 -0500
Message-ID: <20230809023045.1870410-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809023045.1870410-1-nm@ti.com>
References: <20230809023045.1870410-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the ti-cpufreq binding over to opp and convert the free text
binding to json-schema.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V2:
* Just fixup for commit message and picked up Reviewed-by from Dhruva.

V2: https://lore.kernel.org/r/20230801233341.1416552-3-nm@ti.com
V1: https://lore.kernel.org/all/20230724153911.1376830-6-nm@ti.com/

Side note: Cleanups in dt is picked up on Tony's tree:
https://lore.kernel.org/all/20230731062551.GH5194@atomide.com/

 .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
 .../opp/operating-points-v2-ti-cpu.yaml       |  88 ++++++++++++
 2 files changed, 88 insertions(+), 132 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
deleted file mode 100644
index 1758051798fe..000000000000
--- a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
+++ /dev/null
@@ -1,132 +0,0 @@
-TI CPUFreq and OPP bindings
-================================
-
-Certain TI SoCs, like those in the am335x, am437x, am57xx, and dra7xx
-families support different OPPs depending on the silicon variant in use.
-The ti-cpufreq driver can use revision and an efuse value from the SoC to
-provide the OPP framework with supported hardware information. This is
-used to determine which OPPs from the operating-points-v2 table get enabled
-when it is parsed by the OPP framework.
-
-Required properties:
---------------------
-In 'cpus' nodes:
-- operating-points-v2: Phandle to the operating-points-v2 table to use.
-
-In 'operating-points-v2' table:
-- compatible: Should be
-	- 'operating-points-v2-ti-cpu' for am335x, am43xx, and dra7xx/am57xx,
-	  omap34xx, omap36xx and am3517 SoCs
-- syscon: A phandle pointing to a syscon node representing the control module
-	  register space of the SoC.
-
-Optional properties:
---------------------
-- "vdd-supply", "vbb-supply": to define two regulators for dra7xx
-- "cpu0-supply", "vbb-supply": to define two regulators for omap36xx
-
-For each opp entry in 'operating-points-v2' table:
-- opp-supported-hw: Two bitfields indicating:
-	1. Which revision of the SoC the OPP is supported by
-	2. Which eFuse bits indicate this OPP is available
-
-	A bitwise AND is performed against these values and if any bit
-	matches, the OPP gets enabled.
-
-Example:
---------
-
-/* From arch/arm/boot/dts/am33xx.dtsi */
-cpus {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	cpu@0 {
-		compatible = "arm,cortex-a8";
-		device_type = "cpu";
-		reg = <0>;
-
-		operating-points-v2 = <&cpu0_opp_table>;
-
-		clocks = <&dpll_mpu_ck>;
-		clock-names = "cpu";
-
-		clock-latency = <300000>; /* From omap-cpufreq driver */
-	};
-};
-
-/*
- * cpu0 has different OPPs depending on SoC revision and some on revisions
- * 0x2 and 0x4 have eFuse bits that indicate if they are available or not
- */
-cpu0_opp_table: opp-table {
-	compatible = "operating-points-v2-ti-cpu";
-	syscon = <&scm_conf>;
-
-	/*
-	 * The three following nodes are marked with opp-suspend
-	 * because they can not be enabled simultaneously on a
-	 * single SoC.
-	 */
-	opp50-300000000 {
-		opp-hz = /bits/ 64 <300000000>;
-		opp-microvolt = <950000 931000 969000>;
-		opp-supported-hw = <0x06 0x0010>;
-		opp-suspend;
-	};
-
-	opp100-275000000 {
-		opp-hz = /bits/ 64 <275000000>;
-		opp-microvolt = <1100000 1078000 1122000>;
-		opp-supported-hw = <0x01 0x00FF>;
-		opp-suspend;
-	};
-
-	opp100-300000000 {
-		opp-hz = /bits/ 64 <300000000>;
-		opp-microvolt = <1100000 1078000 1122000>;
-		opp-supported-hw = <0x06 0x0020>;
-		opp-suspend;
-	};
-
-	opp100-500000000 {
-		opp-hz = /bits/ 64 <500000000>;
-		opp-microvolt = <1100000 1078000 1122000>;
-		opp-supported-hw = <0x01 0xFFFF>;
-	};
-
-	opp100-600000000 {
-		opp-hz = /bits/ 64 <600000000>;
-		opp-microvolt = <1100000 1078000 1122000>;
-		opp-supported-hw = <0x06 0x0040>;
-	};
-
-	opp120-600000000 {
-		opp-hz = /bits/ 64 <600000000>;
-		opp-microvolt = <1200000 1176000 1224000>;
-		opp-supported-hw = <0x01 0xFFFF>;
-	};
-
-	opp120-720000000 {
-		opp-hz = /bits/ 64 <720000000>;
-		opp-microvolt = <1200000 1176000 1224000>;
-		opp-supported-hw = <0x06 0x0080>;
-	};
-
-	oppturbo-720000000 {
-		opp-hz = /bits/ 64 <720000000>;
-		opp-microvolt = <1260000 1234800 1285200>;
-		opp-supported-hw = <0x01 0xFFFF>;
-	};
-
-	oppturbo-800000000 {
-		opp-hz = /bits/ 64 <800000000>;
-		opp-microvolt = <1260000 1234800 1285200>;
-		opp-supported-hw = <0x06 0x0100>;
-	};
-
-	oppnitro-1000000000 {
-		opp-hz = /bits/ 64 <1000000000>;
-		opp-microvolt = <1325000 1298500 1351500>;
-		opp-supported-hw = <0x04 0x0200>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
new file mode 100644
index 000000000000..ada57bfc1da9
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/opp/operating-points-v2-ti-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI CPU OPP (Operating Performance Points)
+
+description:
+  Certain TI SoCs, like those in the am335x, am437x, am57xx, am62x and dra7xx
+  families support different OPPs depending on the silicon variant in use.
+  The ti-cpufreq driver can use revision and an efuse value from the SoC to
+  provide the OPP framework with supported hardware information. This is
+  used to determine which OPPs from the operating-points-v2 table get enabled
+  when it is parsed by the OPP framework.
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+allOf:
+  - $ref: opp-v2-base.yaml#
+
+properties:
+  compatible:
+    const: operating-points-v2-ti-cpu
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      points to syscon node representing the control module
+      register space of the SoC.
+
+  opp-shared: true
+
+patternProperties:
+  '^opp(-?[0-9]+)*$':
+    type: object
+    additionalProperties: false
+
+    properties:
+      clock-latency-ns: true
+      opp-hz: true
+      opp-microvolt: true
+      opp-supported-hw: true
+      opp-suspend: true
+      turbo-mode: true
+
+    required:
+      - opp-hz
+      - opp-supported-hw
+
+required:
+  - compatible
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    opp-table {
+        compatible = "operating-points-v2-ti-cpu";
+        syscon = <&scm_conf>;
+
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            opp-microvolt = <1100000 1078000 1122000>;
+            opp-supported-hw = <0x06 0x0020>;
+            opp-suspend;
+        };
+
+        opp-500000000 {
+            opp-hz = /bits/ 64 <500000000>;
+            opp-microvolt = <1100000 1078000 1122000>;
+            opp-supported-hw = <0x01 0xFFFF>;
+        };
+
+        opp-600000000 {
+            opp-hz = /bits/ 64 <600000000>;
+            opp-microvolt = <1100000 1078000 1122000>;
+            opp-supported-hw = <0x06 0x0040>;
+        };
+
+        opp-1000000000 {
+            opp-hz = /bits/ 64 <1000000000>;
+            opp-microvolt = <1325000 1298500 1351500>;
+            opp-supported-hw = <0x04 0x0200>;
+        };
+    };
-- 
2.40.0

