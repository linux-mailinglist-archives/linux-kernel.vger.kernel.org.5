Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0277FB16D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbjK1Foa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjK1FoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:44:24 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611BAD6;
        Mon, 27 Nov 2023 21:44:31 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5iCtI072775;
        Mon, 27 Nov 2023 23:44:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701150252;
        bh=0m2Zfqeb+FQunMXPM7eB5iriJ4FlPLIrtvm2HPPZ7tc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xq8z0LiAaN9jCKOaxykMQADY52tyI5253/RsVRrZUgoYBUqfUZKDh5zZ6WOw/3/yN
         ILEk3XVe/DbPOY+YUaKU5Favc+Zi4WGozwMgSNlhg8jAX2WntFmpCC3nEFDXJ/poNH
         CxTJwjpmb/r3SmJCvKXf4j/tP+sKQ+mjc5zvdUw8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS5iCx1021460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Nov 2023 23:44:12 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 23:44:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 23:44:12 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5i2uP096776;
        Mon, 27 Nov 2023 23:44:08 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>, <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <nm@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v13 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
Date:   Tue, 28 Nov 2023 11:13:58 +0530
Message-ID: <20231128054402.2155183-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128054402.2155183-1-s-vadapalli@ti.com>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <mranostay@ti.com>

Add num-lanes schema checks based on compatible string on available lanes
for that platform.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../bindings/pci/ti,j721e-pci-ep.yaml         | 27 ++++++++++++++++---
 .../bindings/pci/ti,j721e-pci-host.yaml       | 27 ++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 62292185fe2e..162e5c2906e1 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -10,9 +10,6 @@ title: TI J721E PCI EP (PCIe Wrapper)
 maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
-allOf:
-  - $ref: cdns-pcie-ep.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -65,6 +62,30 @@ properties:
     items:
       - const: link_state
 
+allOf:
+  - $ref: cdns-pcie-ep.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          const: 1
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j7200-pcie-ep
+            - ti,j721e-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 2
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index a2c5eaea57f5..854dc9e08dcf 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -10,9 +10,6 @@ title: TI J721E PCI Host (PCIe Wrapper)
 maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
-allOf:
-  - $ref: cdns-pcie-host.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -94,6 +91,30 @@ properties:
       interrupts:
         maxItems: 1
 
+allOf:
+  - $ref: cdns-pcie-host.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-pcie-host
+    then:
+      properties:
+        num-lanes:
+          const: 1
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j7200-pcie-host
+            - ti,j721e-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 2
+
 required:
   - compatible
   - reg
-- 
2.34.1

