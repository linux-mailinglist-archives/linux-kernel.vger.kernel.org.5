Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F2771F53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjHGLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjHGLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:09:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B1171B;
        Mon,  7 Aug 2023 04:08:51 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377B8hgN110698;
        Mon, 7 Aug 2023 06:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691406523;
        bh=/7Ens+j7LBBU6sXNeN8Uzz8ZjijeFBZTeoh8od1xgmE=;
        h=From:To:CC:Subject:Date;
        b=IyQAs0A4Yn+zZWUBv1tL8ynQVha+7tC5txT8q7EdvQObbLa4p94irK8sQK5r/Ctjf
         1AkOw2xgNMamt1KEgVbdwAZAhHCznGl6REg5Oam2TWsOAYjFCkJnDAX9U6KQOqzuqL
         sZJfiRSQEHQWN8rmYH4f1XCYpnjqPw8p6qPQquws=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377B8h4E027689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 06:08:43 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 06:08:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 06:08:43 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377B8hKf041448;
        Mon, 7 Aug 2023 06:08:43 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 377B8g8S029789;
        Mon, 7 Aug 2023 06:08:42 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>
Subject: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property 
Date:   Mon, 7 Aug 2023 16:38:36 +0530
Message-ID: <20230807110836.2612730-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupts and interrupt-names protperties for PRU and RTU cores.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../bindings/remoteproc/ti,pru-rproc.yaml     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
index cd55d80137f7..6970316943bb 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
@@ -66,6 +66,16 @@ properties:
       Should contain the name of the default firmware image
       file located on the firmware search path.
 
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt specifiers enable the virtio/rpmsg communication between MPU
+      and the PRU/RTU cores.
+
+  interrupt-names:
+    items:
+      - const: vring
+
 if:
   properties:
     compatible:
@@ -171,6 +181,9 @@ examples:
               <0x22400 0x100>;
         reg-names = "iram", "control", "debug";
         firmware-name = "am65x-pru0_0-fw";
+        interrupt-parent = <&icssg0_intc>;
+        interrupts = <16 2 2>;
+        interrupt-names = "vring";
       };
 
       rtu0_0: rtu@4000 {
@@ -180,6 +193,9 @@ examples:
               <0x23400 0x100>;
         reg-names = "iram", "control", "debug";
         firmware-name = "am65x-rtu0_0-fw";
+        interrupt-parent = <&icssg0_intc>;
+        interrupts = <20 4 4>;
+        interrupt-names = "vring";
       };
 
       tx_pru0_0: txpru@a000 {
@@ -198,6 +214,9 @@ examples:
               <0x24400 0x100>;
         reg-names = "iram", "control", "debug";
         firmware-name = "am65x-pru0_1-fw";
+        interrupt-parent = <&icssg0_intc>;
+        interrupts = <18 3 3>;
+        interrupt-names = "vring";
       };
 
       rtu0_1: rtu@6000 {
@@ -207,6 +226,9 @@ examples:
               <0x23c00 0x100>;
         reg-names = "iram", "control", "debug";
         firmware-name = "am65x-rtu0_1-fw";
+        interrupt-parent = <&icssg0_intc>;
+        interrupts = <22 5 5>;
+        interrupt-names = "vring";
       };
 
       tx_pru0_1: txpru@c000 {
-- 
2.34.1

