Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0876A7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHAEqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjHAEqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:46:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF210C7;
        Mon, 31 Jul 2023 21:46:48 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3712XAD7021689;
        Mon, 31 Jul 2023 21:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ewKtmKa73JfXtQvdkvNowev2HAcGMB8AogjqYSMc2io=;
 b=hKzYQSAMmIYeo6HHr6RTO4aFzkqups18oAvv+FMfdS4j3EX82EJ4nkgY937U7D+aHGza
 dWfLWpVUlXk8kdfk92OJp5gORAsrjukSUOM/cy24qNylUIuMW2Mto5TpS+Ini3ygvDdO
 t4B7j5yUZOZaWGMbzr0XslDLBHrXPhywtJAFi1jO+HNlsLvzvXdh0edINzGMJnckisAu
 f9HMh3rPixZTfHmZ9MjM/BaN2mV0WyuprlLOFM/fyP1gX+tkX7+fBObUkdFt+//+JNX0
 TOl7/2YDqc4iz8mYzmRLbuWkzq284pLrEQrY7BJ2m6UgQ715nx5ZpHDFrBG9zgii0ekP ag== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s6du0aw1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 21:46:31 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 21:46:29 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 21:46:26 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/2 v10] dt-bindings: watchdog: marvell GTI system watchdog driver
Date:   Tue, 1 Aug 2023 10:16:22 +0530
Message-ID: <20230801044623.9275-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: hkVvKA2_BIyXE3tI1uxqPjy9BMgOGvfs
X-Proofpoint-ORIG-GUID: hkVvKA2_BIyXE3tI1uxqPjy9BMgOGvfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_02,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell GTI system
watchdog driver.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v10:
 - Added Reviewed by Krzysztof Kozlowski

v9:
 - Rename binding file name from marvell,octeontx2-wdt.yaml to
   marvell,cn10624-wdt.yaml
 - "allOf: - $ref: watchdog.yaml#" moved after maintainers
 - clocks have maxItems rather than minItems
 - Added "clock-names" name defination
 - Added Fallback to compatible

v8:
  - Compatible name as per soc name

 .../watchdog/marvell,cn10624-wdt.yaml         | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
new file mode 100644
index 000000000000..1b583f232e53
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/marvell,cn10624-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Global Timer (GTI) system watchdog
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - marvell,cn9670-wdt
+          - marvell,cn10624-wdt
+
+      - items:
+          - enum:
+              - marvell,cn9880-wdt
+              - marvell,cnf9535-wdt
+          - const: marvell,cn9670-wdt
+
+      - items:
+          - enum:
+              - marvell,cn10308-wdt
+              - marvell,cnf10518-wdt
+          - const: marvell,cn10624-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: refclk
+
+  marvell,wdt-timer-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 63
+    description:
+      An SoC have many timers (up to 64), firmware can reserve one or more timer
+      for some other use case and configures one of the global timer as watchdog
+      timer. Firmware will update this field with the timer number configured
+      as watchdog timer.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        watchdog@802000040000 {
+            compatible = "marvell,cn9670-wdt";
+            reg = <0x00008020 0x00040000 0x00000000 0x00020000>;
+            interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&sclk>;
+            clock-names = "refclk";
+            marvell,wdt-timer-index = <63>;
+        };
+    };
+
+...
-- 
2.17.1

