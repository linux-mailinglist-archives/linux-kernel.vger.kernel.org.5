Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8F780DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377692AbjHROWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377896AbjHROWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:22:05 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA66421C;
        Fri, 18 Aug 2023 07:21:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37IELRlb051327;
        Fri, 18 Aug 2023 09:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692368487;
        bh=y+cZV/NGBr5uaeP0m3MNYnfxhUPqRXB8CDdrvgoyUkA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WRcZwexapCicqAPDnpxWbqHwGxuKJ3WT2IdkhBOsV1tj+cmWy/fULWypywwpwQAJy
         yK9UajmYaDnB84MPgG+eG7vuJwMeDlB5vDoZjn2uMMRP+P1oByaw1rOc7lU6r+cMxB
         7foIyy8eAduia/RaZVmZvhBaotgfPo39eQF2P1v8=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37IELRTM031666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 09:21:27 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 09:21:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 09:21:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37IELQkK077435;
        Fri, 18 Aug 2023 09:21:26 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
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
Subject: [PATCH v2 1/2] dt-bindings: display: ti: Add support for am62a7 dss
Date:   Fri, 18 Aug 2023 19:51:23 +0530
Message-ID: <20230818142124.8561-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818142124.8561-1-a-bhatia1@ti.com>
References: <20230818142124.8561-1-a-bhatia1@ti.com>
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

The DSS controller on TI's AM62A7 SoC is an update from that on TI's
AM625 SoC. Like the DSS in AM625, the DSS in this SoC has 2 video
pipelines, but unlike the former, the latter only has one output port on
VP2 to service DPI display sinks.

Add the new controller's compatible.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
Notes:
       Changes from V1:
       * No change from V1.

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
2.40.1

