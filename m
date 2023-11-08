Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784A27E5C31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjKHRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjKHRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:16:54 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694CC198D;
        Wed,  8 Nov 2023 09:16:52 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A8HGNQs120680;
        Wed, 8 Nov 2023 11:16:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699463783;
        bh=qbI0UjTa2VKzuWI1Jm4SN8FB5q+5YhQmtDHi91YLPAA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DP5nFF6UnOEHv8bCtmXeDSqzS1pGPtmuHhFBMbuDnH8TEn8d2HTjOf+pJGVdow6CK
         Zni5wgAlTUV1engxKXPwLHy69mde5DEkLIWG7z5FkUXflkb/xLWtBkeKLxswyTzI8z
         kuCBE1yoSRpq61KJg/56bjTZ04JNzvMAkqRxtoWs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A8HGMIe063933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Nov 2023 11:16:22 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Nov 2023 11:16:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Nov 2023 11:16:22 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A8HGLXk000537;
        Wed, 8 Nov 2023 11:16:22 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: display: ti: Add support for am62a7 dss
Date:   Wed, 8 Nov 2023 22:46:18 +0530
Message-ID: <20231108171619.978438-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108171619.978438-1-a-bhatia1@ti.com>
References: <20231108171619.978438-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSS controller on TI's AM62A7 SoC is an update from that on TI's
AM625 SoC. Like the DSS in AM625, the DSS in this SoC has 2 video
pipelines, but unlike the former, the latter only has one output port on
VP2 to service DPI display sinks.

Add the new controller's compatible.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/ti/ti,am65x-dss.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index ae09cd3cbce1..b6767ef0d24d 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - ti,am625-dss
+      - ti,am62a7,dss
       - ti,am65x-dss
 
   reg:
@@ -87,6 +88,7 @@ properties:
           For AM65x DSS, the OLDI output port node from video port 1.
           For AM625 DSS, the internal DPI output port node from video
           port 1.
+          For AM62A7 DSS, the port is tied off inside the SoC.
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
@@ -108,6 +110,18 @@ properties:
       Input memory (from main memory to dispc) bandwidth limit in
       bytes per second
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am62a7-dss
+    then:
+      properties:
+        ports:
+          properties:
+            port@0: false
+
 required:
   - compatible
   - reg
-- 
2.42.0

