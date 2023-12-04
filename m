Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9583E803CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjLDSYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjLDSXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:23:41 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8720127;
        Mon,  4 Dec 2023 10:23:47 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4IMnKD056516;
        Mon, 4 Dec 2023 12:22:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701714169;
        bh=lrDUeYGbJDS+87ZbWhSZim9BrWk30vrJWUGBbVKqVQ4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KhUbnOHcP9zXugWIMsIwYd24qc0k3K+eHTT7Fo8y68CWiqrMWapVWYkdhxZ5P2K1B
         nJ0Fj+o9O5MIq9f+iYcGBl/9fjc+AmYR762duYDF0XCU2WjWMWk/0UNBwVwzXYo/Df
         5e0+d/mEqiz5oNtd89F8PC8KaR+QCYj2qFPQYrz4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4IMniA013411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Dec 2023 12:22:49 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 12:22:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 12:22:48 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4IMkx4042313;
        Mon, 4 Dec 2023 12:22:48 -0600
From:   Andrew Davis <afd@ti.com>
To:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Date:   Mon, 4 Dec 2023 12:22:36 -0600
Message-ID: <20231204182245.33683-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204182245.33683-1-afd@ti.com>
References: <20231204182245.33683-1-afd@ti.com>
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

The Imagination PowerVR Series5 "SGX" GPU is part of several SoCs from
multiple vendors. Describe how the SGX GPU is integrated in these SoC,
including register space and interrupts. Clocks, reset, and power domain
information is SoC specific.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../devicetree/bindings/gpu/img,powervr.yaml  | 69 +++++++++++++++++--
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr.yaml b/Documentation/devicetree/bindings/gpu/img,powervr.yaml
index a13298f1a1827..9f036891dad0b 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr.yaml
@@ -11,11 +11,33 @@ maintainers:
   - Frank Binns <frank.binns@imgtec.com>
 
 properties:
+  $nodename:
+    pattern: '^gpu@[a-f0-9]+$'
+
   compatible:
-    items:
-      - enum:
-          - ti,am62-gpu
-      - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
+    oneOf:
+      - items:
+          - enum:
+              - ti,am62-gpu
+          - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
+      - items:
+          - enum:
+              - ti,omap3430-gpu # Rev 121
+              - ti,omap3630-gpu # Rev 125
+          - const: img,powervr-sgx530
+      - items:
+          - enum:
+              - ingenic,jz4780-gpu # Rev 130
+              - ti,omap4430-gpu # Rev 120
+          - const: img,powervr-sgx540
+      - items:
+          - enum:
+              - allwinner,sun6i-a31-gpu # MP2 Rev 115
+              - ti,omap4470-gpu # MP1 Rev 112
+              - ti,omap5432-gpu # MP2 Rev 105
+              - ti,am5728-gpu # MP2 Rev 116
+              - ti,am6548-gpu # MP1 Rev 117
+          - const: img,powervr-sgx544
 
   reg:
     maxItems: 1
@@ -40,8 +62,6 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
 
 additionalProperties: false
@@ -56,6 +76,43 @@ allOf:
       properties:
         clocks:
           maxItems: 1
+      required:
+        - clocks
+        - clock-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am654-sgx544
+    then:
+      properties:
+        power-domains:
+          minItems: 1
+      required:
+        - power-domains
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun6i-a31-gpu
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+      required:
+        - clocks
+        - clock-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ingenic,jz4780-gpu
+    then:
+      required:
+        - clocks
+        - clock-names
 
 examples:
   - |
-- 
2.39.2

