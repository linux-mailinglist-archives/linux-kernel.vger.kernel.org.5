Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307C177B5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjHNJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjHNJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:52:00 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F45CD1;
        Mon, 14 Aug 2023 02:51:58 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37E9pmv6027597;
        Mon, 14 Aug 2023 04:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692006708;
        bh=YHisbs6R0xXrNTsJCEqlxBiPrz26Ghe5FBVp20PuDnA=;
        h=From:To:CC:Subject:Date;
        b=Vo+v61TCf8/PNvxOjgM+iw74ijEXX8zx+2mq8YSZG3LPDimCRLPLnvFaTxXurntz9
         GJl52+c9qal7+mKgvTL1mHTWj1SyMlcsQXt08+DP9BIUs/xCMrl1nMR/Wa3vdLSV4X
         TEHbbMxuNvraDc55I/Ij4w59FOXJdoXFHGWeyY6c=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37E9pmiP014340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 04:51:48 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 04:51:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 04:51:48 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37E9pmwG023606;
        Mon, 14 Aug 2023 04:51:48 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37E9plpd016978;
        Mon, 14 Aug 2023 04:51:48 -0500
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
Subject: [PATCH v2] dt-bindings: remoteproc: pru: Add Interrupt property
Date:   Mon, 14 Aug 2023 15:21:41 +0530
Message-ID: <20230814095141.3526684-1-danishanwar@ti.com>
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
Changes from v1 to v2:
*) Added reference of ti,pruss-intc.yaml schema in the description of
   interrupts property as suggested by Conor.
*) Rebased on latest next-20230809 linux-next.

v1: https://lore.kernel.org/all/20230807110836.2612730-1-danishanwar@ti.com/

 .../bindings/remoteproc/ti,pru-rproc.yaml     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
index cd55d80137f7..fc81ba2ad2da 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
@@ -66,6 +66,17 @@ properties:
       Should contain the name of the default firmware image
       file located on the firmware search path.
 
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt specifiers enable the virtio/rpmsg communication between MPU
+      and the PRU/RTU cores. For the values of the interrupt cells please refer
+      to interrupt-controller/ti,pruss-intc.yaml schema.
+
+  interrupt-names:
+    items:
+      - const: vring
+
 if:
   properties:
     compatible:
@@ -171,6 +182,9 @@ examples:
               <0x22400 0x100>;
         reg-names = "iram", "control", "debug";
         firmware-name = "am65x-pru0_0-fw";
+        interrupt-parent = <&icssg0_intc>;
+        interrupts = <16 2 2>;
+        interrupt-names = "vring";
       };
 
       rtu0_0: rtu@4000 {
@@ -180,6 +194,9 @@ examples:
               <0x23400 0x100>;
         reg-names = "iram", "control", "debug";
         firmware-name = "am65x-rtu0_0-fw";
+        interrupt-parent = <&icssg0_intc>;
+        interrupts = <20 4 4>;
+        interrupt-names = "vring";
       };
 
       tx_pru0_0: txpru@a000 {
@@ -198,6 +215,9 @@ examples:
               <0x24400 0x100>;
         reg-names = "iram", "control", "debug";
         firmware-name = "am65x-pru0_1-fw";
+        interrupt-parent = <&icssg0_intc>;
+        interrupts = <18 3 3>;
+        interrupt-names = "vring";
       };
 
       rtu0_1: rtu@6000 {
@@ -207,6 +227,9 @@ examples:
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

