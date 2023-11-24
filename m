Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC47F6B89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjKXE6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKXE55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:57:57 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2CD6E;
        Thu, 23 Nov 2023 20:58:04 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vvpS043202;
        Thu, 23 Nov 2023 22:57:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700801877;
        bh=HjBkXljfWp+92EwJDlN9yJARdABEr4KgfTuFDro3yCM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UECTTwLZQJBtqdkxcku7VjuIAnrjR/CnNySAFURiGUvs/9Z7Thl7pyZFtivXWUb98
         H4lKhgYy8mv/sD8lMPuAHlqF3NINsbh/7zegDWgoV4su+iaTvkevcB48KIDZrnyll9
         TYCQcIq7hoEnOJQCWay0SMGunw82EPfJglMlRHBQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO4vv5f076370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 22:57:57 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 22:57:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 22:57:57 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vo8g004756;
        Thu, 23 Nov 2023 22:57:54 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/4] dt-bindings: dma: ti: k3-*: Add descriptions for register regions
Date:   Fri, 24 Nov 2023 10:27:19 +0530
Message-ID: <20231124045722.191817-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124045722.191817-1-vigneshr@ti.com>
References: <20231124045722.191817-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for introducing more register regions, add description
for existing register regions so that its easier to map reg-names to
that of SoC Documentations/TRMs.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml   | 18 +++++++++++++++---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml  |  6 +++++-
 .../devicetree/bindings/dma/ti/k3-udma.yaml    |  5 ++++-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 4ca300a42a99..11727af9df73 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -141,7 +141,10 @@ allOf:
         ti,sci-rm-range-tchan: false
 
         reg:
-          maxItems: 3
+          items:
+            - description: BCDMA Control /Status Registers region
+            - description: RX Channel Realtime Registers region
+            - description: Ring Realtime Registers region
 
         reg-names:
           items:
@@ -160,7 +163,12 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 5
+          items:
+            - description: BCDMA Control /Status Registers region
+            - description: Block Copy Channel Realtime Registers region
+            - description: RX Channel Realtime Registers region
+            - description: TX Channel Realtime Registers region
+            - description: Ring Realtime Registers region
 
         reg-names:
           items:
@@ -184,7 +192,11 @@ allOf:
         ti,sci-rm-range-bchan: false
 
         reg:
-          maxItems: 4
+          items:
+            - description: BCDMA Control /Status Registers region
+            - description: RX Channel Realtime Registers region
+            - description: TX Channel Realtime Registers region
+            - description: Ring Realtime Registers region
 
         reg-names:
           items:
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
index a69f62f854d8..3580b08f65c6 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -45,7 +45,11 @@ properties:
       The second cell is the ASEL value for the channel
 
   reg:
-    maxItems: 4
+    items:
+      - description: Packet DMA Control /Status Registers region
+      - description: RX Channel Realtime Registers region
+      - description: TX Channel Realtime Registers region
+      - description: Ring Realtime Registers region
 
   reg-names:
     items:
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 22f6c5e2f7f4..ded588bd079a 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -69,7 +69,10 @@ properties:
       - ti,j721e-navss-mcu-udmap
 
   reg:
-    maxItems: 3
+    items:
+      - description: UDMA-P Control /Status Registers region
+      - description: RX Channel Realtime Registers region
+      - description: TX Channel Realtime Registers region
 
   reg-names:
     items:
-- 
2.43.0

