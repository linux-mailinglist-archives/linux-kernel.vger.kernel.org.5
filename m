Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13BB805B94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345188AbjLEQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjLEQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:24:05 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC51AA;
        Tue,  5 Dec 2023 08:24:11 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5GO0Ep002469;
        Tue, 5 Dec 2023 10:24:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701793440;
        bh=WRpAXXk9cF26IADEfdegk6SZVUw+VjPNz9fKUwXfzj8=;
        h=From:To:CC:Subject:Date;
        b=FmLaXSo7uM78EP5zCb8UILPPcpEwr/LTZ3M+DsGYtXrWdPURnkrWcAEMFZYcFaMj+
         X/F0p5eWLLm+iqSpfFo1kvNkvq6H/OiIgutdmlcBBN53R+R8YfMctyiJSkiKmRWuS5
         rO9++avsYs5IjHr+LFwigHDb5yWjZ/w/6p9OpHMU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5GO0AG023434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 10:24:00 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 10:23:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 10:23:59 -0600
Received: from lelv0326.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5GNxR3038454;
        Tue, 5 Dec 2023 10:23:59 -0600
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Bryan Brattlof <bb@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am65: Add AM652 DTSI file
Date:   Tue, 5 Dec 2023 10:23:58 -0600
Message-ID: <20231205162358.23904-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM652 is basically a AM654 but with 2 cores instead of 4. Add
a DTSI file for AM652 matching AM654 except this core difference.

This removes the need to remove the extra cores from AM654 manually
in DT files for boards that use the AM652 variant. Do that for
the IOT2050 boards here.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
---

Changes for v2:
 - Add r-b
 - Rebase on next-20231204

 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  1 -
 arch/arm64/boot/dts/ti/k3-am652.dtsi          | 74 +++++++++++++++++++
 .../ti/k3-am6528-iot2050-basic-common.dtsi    | 11 +--
 .../ti/k3-am6548-iot2050-advanced-common.dtsi |  1 +
 4 files changed, 76 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am652.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index ab1dffa5c1c6f..73ff119d85cdc 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -9,7 +9,6 @@
  * Common bits of the IOT2050 Basic and Advanced variants, PG1 and PG2
  */
 
-#include "k3-am654.dtsi"
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/net/ti-dp83867.h>
 
diff --git a/arch/arm64/boot/dts/ti/k3-am652.dtsi b/arch/arm64/boot/dts/ti/k3-am652.dtsi
new file mode 100644
index 0000000000000..0f22e00faa903
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am652.dtsi
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM65 SoC family in Dual core configuration
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am65.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+	};
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-unified;
+		cache-size = <0x80000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	msmc_l3: l3-cache0 {
+		compatible = "cache";
+		cache-level = <3>;
+		cache-unified;
+	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-am654-industrial-thermal.dtsi"
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 5ab434c02ab6b..feb0eae4e6df4 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -9,6 +9,7 @@
  * Common bits of the IOT2050 Basic variant, PG1 and PG2
  */
 
+#include "k3-am652.dtsi"
 #include "k3-am65-iot2050-common.dtsi"
 
 / {
@@ -17,16 +18,6 @@ memory@80000000 {
 		/* 1G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
 	};
-
-	cpus {
-		cpu-map {
-			/delete-node/ cluster1;
-		};
-		/delete-node/ cpu@100;
-		/delete-node/ cpu@101;
-	};
-
-	/delete-node/ l2-cache1;
 };
 
 /* eMMC */
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index be55494b1f3fc..ff2fdc2e12e3c 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 
+#include "k3-am654.dtsi"
 #include "k3-am65-iot2050-common.dtsi"
 
 / {
-- 
2.39.2

