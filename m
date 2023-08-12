Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB077A072
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjHLOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHLOZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:25:54 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EE1BD9;
        Sat, 12 Aug 2023 07:25:58 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37CCq98p031375;
        Sat, 12 Aug 2023 07:25:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=yUBBkoNtf172j5obfqUohpULPbPyTGS0+qy55YTkxqU=;
 b=EqU7vt8AM/u2tu6Ykd8Wa77XfulUSHyDMbQT3anRoIq89poyTELZ+zx1a7RjWlHKg6Mh
 yxfFVVC6HV40gUfoCLx48cc4ahXdqja4kdkqB8BAswTm7pIGej79ox22QIHKWnkGkTu1
 xHrfGWtZB8tvbnqiIsX+975nCHcGTsoBlPoQXl1m5eg8xaWJjLRxhe9KOcsNqkjTeNLV
 lytHtGQTZRV9mqr2aHZ/90BxpimHNA/m4xDE/qQhGDG6m5HQERRJd147YFiowrc9rohW
 0ZMViCoNowHpoUN9KM3B2/+aHNYmkzu+YFOkhCNw3ANU8MG43ff3L9yuaZEYUUYuJrp3 1g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3se7en0k30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 07:25:47 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 12 Aug
 2023 07:25:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 12 Aug 2023 07:25:45 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id D7BBE3F7041;
        Sat, 12 Aug 2023 07:25:41 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v2 2/6] dt-bindings: perf: Add Marvell PEM performance monitor unit
Date:   Sat, 12 Aug 2023 19:55:14 +0530
Message-ID: <20230812142518.778259-3-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812142518.778259-1-gthiagarajan@marvell.com>
References: <20230812142518.778259-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: f4CY9Dl3ylvjV4l3yMOdSMRP_B-DXlZs
X-Proofpoint-ORIG-GUID: f4CY9Dl3ylvjV4l3yMOdSMRP_B-DXlZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_14,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Marvell PEM performance monitor unit.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---

v1->v2
- Changed DT binding file name to match with compatible
- Added respective document in MAINTAINERS

 .../perf/marvell,odyssey-pem-pmu.yaml         | 38 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell,odyssey-pem-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell,odyssey-pem-pmu.yaml b/Documentation/devicetree/bindings/perf/marvell,odyssey-pem-pmu.yaml
new file mode 100644
index 000000000000..a761fc09565b
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell,odyssey-pem-pmu.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell,odyssey-pem-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PCIe interface performance monitor
+
+maintainers:
+  - Linu Cherian <lcherian@marvell.com>
+  - Gowthami Thiagarajan <gthiagarajan@marvell.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - marvell,odyssey-pem-pmu
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@8e0000005000 {
+            compatible = "marvell,odyssey-pem-pmu";
+            reg = <0x8e00 0x00005000 0x0 0x3000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9eaabaa60317..192a69d2fad6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12582,6 +12582,7 @@ MARVELL PEM PMU DRIVER
 M:	Linu Cherian <lcherian@marvell.com>
 M:	Gowthami Thiagarajan <gthiagarajan@marvell.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/perf/marvell,odyssey-pem-pmu.yaml
 F:	drivers/perf/marvell_pem_pmu.c
 
 MARVELL PRESTERA ETHERNET SWITCH DRIVER
-- 
2.25.1

