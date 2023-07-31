Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8C76903D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjGaIbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGaIax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:30:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19BB10CA;
        Mon, 31 Jul 2023 01:30:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TtxR048224;
        Mon, 31 Jul 2023 03:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792195;
        bh=o9JmDGlCqf7iYc+hFKgavJ+cIgy8OWygrvm/7RwaCNo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PR3Igdmh8CfimocdKLA5wIR9GgApNgQh8DfR2lekUNA+zkK7HduYofXUuSmQAy/hW
         dYYNfcfIWLqoBfw2ID9K6uMQOYuA3BcuYa6ukBwrW8Njq4/0sWdiFYyBV0inTbErzV
         OCoJpnrJhhRioojjIWJo9BuJtUo3QahjXXA0/l+o=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TtX2087236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:55 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TsZg084162;
        Mon, 31 Jul 2023 03:29:54 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 15/16] media: dt-bindings: Add TI J721E CSI2RX
Date:   Mon, 31 Jul 2023 13:59:33 +0530
Message-ID: <20230731-upstream_csi-v8-15-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3761; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=P09JGVDeZt3QJTcEtMST4pms90RpLSolhngTDU+XnaI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xw/W/v9+VPlHfBxF3Drv6p1QEVN5/bKrRJ/
 7MZl7OAUk2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdscAAKCRBD3pH5JJpx
 RV0nD/wMiNawsYKemxtmXt0Ft7T6NMLlLRmTU0QI0wEJzwG6YhWbsNN9LOHlIkyAhYU8m8PcB3S
 aHBlQgb0ckWEYjVQoVq1DoPQ2Yz6IS+e0lRxsoNnuivPAf6QiM+RMwxhnBwXNUy2j0Rx+Wc4kO/
 9KA4JvNOzEjIci90VxoPKoKIL9dttKhLchcnF/xAp2cQCUt9qa1NMOlYGLxN6BU4iLjOLwY6knl
 NI+6q+dQS9JMq3sD8j5IsxNu48HmYPfpnifBWHjO+RftIL9ilHTx7jg6jZyYqqI72oknYaqIHAI
 j0niviLZEgMveHlEmQk01CIz9JsevJ3wwK7P/iViGNTMBsC6pRYe4oRUxL24h5BY3YtKCXzeyrF
 F6wRAqaP7CplSy2SDh5SbFCKYxkp87dQ02OatCbJqrwiq1plNZ8tL8j7mAcia6F775KsiX7qmRM
 jbvqOSmiWr8a4TqDM5XDc7R6p9zq+sVKkap3eTq6Dh1G84sA0wrAc5ewV6eUw+blC4h5xR0tkG6
 7wtmwP3eyTTHGimsAIuDnOPdeRrLRxI+joz09P9eD+VG0daPGHTgrKKwuMRRGolm9PARmQMYqGo
 3PccY8PVla7N3ip0R1jntLJ/yVCsggg4pnA/hAq1bY3HmodQgsMeAW+acDzEDT2O1dIBxmwRS7a
 RBw1yejXwLkjgzQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
parts together.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v7->v8:
- Drop "Device Tree Bindings" from title
- Rename "Wrapper" to "Shim" in title as that is the name referred in
  the TRM and other places
- Update maintainer to myself
- Drop items from compatible as only a single element is present
- Rename compatible to "ti,j721e-csi2rx-shim" to distinguish from the
  SoC-specific CSI2RX bridge compatible

 .../bindings/media/ti,j721e-csi2rx-shim.yaml       | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
new file mode 100644
index 000000000000..f762fdc05e4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/ti,j721e-csi2rx-shim.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI J721E CSI2RX Shim
+
+description: |
+  The TI J721E CSI2RX Shim is a wrapper around Cadence CSI2RX bridge that
+  enables sending captured frames to memory over PSI-L DMA. In the J721E
+  Technical Reference Manual (SPRUIL1B) it is referred to as "SHIM" under the
+  CSI_RX_IF section.
+
+maintainers:
+  - Jai Luthra <j-luthra@ti.com>
+
+properties:
+  compatible:
+    const: ti,j721e-csi2rx-shim
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx0
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+patternProperties:
+  "^csi-bridge@":
+    type: object
+    description: CSI2 bridge node.
+    $ref: cdns,csi2rx.yaml#
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - power-domains
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    ti_csi2rx0: ticsi2rx@4500000 {
+        compatible = "ti,j721e-csi2rx-shim";
+        dmas = <&main_udmap 0x4940>;
+        dma-names = "rx0";
+        reg = <0x4500000 0x1000>;
+        power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        cdns_csi2rx: csi-bridge@4504000 {
+            compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+            reg = <0x4504000 0x1000>;
+            clocks = <&k3_clks 26 2>, <&k3_clks 26 0>, <&k3_clks 26 2>,
+              <&k3_clks 26 2>, <&k3_clks 26 3>, <&k3_clks 26 3>;
+            clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+              "pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+            phys = <&dphy0>;
+            phy-names = "dphy";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                csi2_0: port@0 {
+
+                    reg = <0>;
+
+                    csi2rx0_in_sensor: endpoint {
+                        remote-endpoint = <&csi2_cam0>;
+                        bus-type = <4>; /* CSI2 DPHY. */
+                        clock-lanes = <0>;
+                        data-lanes = <1 2>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.41.0
