Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE0778C56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjHKKs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjHKKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B124E54;
        Fri, 11 Aug 2023 03:48:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlvgY088961;
        Fri, 11 Aug 2023 05:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750877;
        bh=k/A7YqeoKUIIsFnL9gFHEsGEuAJrBb/WhWE43Oc5uyk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CTuiH/cFVR/qNZrQU3weKsqk5ExiTJ9CZygNxwcDQwrJ1MI36JANZTO2K/HIFafk/
         UZWKtiIevyOOeTH+RwFO3TTwdUC0jI7q4jn/UuxlJUwdEjmy6GhWE1ihSvzR2hRUgD
         GAyyEaeNAQ455TrRqpzrAcUMwuPFEscj0rdiCKm0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlv7X042003
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlud0003199;
        Fri, 11 Aug 2023 05:47:57 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v9 12/13] media: dt-bindings: Add TI J721E CSI2RX
Date:   Fri, 11 Aug 2023 16:17:34 +0530
Message-ID: <20230811-upstream_csi-v9-12-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3540; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=KhrJ6PSvXWrFSyVDAGdNqpVcjWzkUWqIMwHh59uJtxI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g8LtpCcYkRYYIY6+nZeEEqTSr9e0FezRzPi2
 LfwWwjBAHOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYPCwAKCRBD3pH5JJpx
 ReEPD/9OcEHDDHZ8yq96rbu3iQ3Vht3LCWf3rVUWMlUH6JrmGV8PbcM1E6fcafu8yKnYPVeAZbv
 xlz5AAGts1reND9qiWGeexuAgnWwSeIfcAp2JDSTp9HfSCKFfuUBQsZJZ9uviuVbKh3/nCyV3RA
 pWG3gGjsQNUzaH+Xb2GJPyw5TWd0Y+fQ4ppy5ikLa9+oWQLLl396u3/95NyCBLjAYAhJ2cMkjxW
 eac09hZ/PAw259tVY4DyIrPseLM+Ozrlaly/JxSWYVoz5WTFnMFto98t9ETcpu1DBHJmKwtC37o
 9Xo85XbAdxmDSidOM/aAf03/anmcJtFjQC4l4cogl2S/m18PYcY/At+outWXCzJnrwpYBff3Bg3
 TPnDF0cv6xS4idAr8v6cMKJe1jBZtiP5v/4cB6/9i0e44tcul3a7EKjvFOrEtdaQHVyY8wpiVVD
 HA4+RDpnvrp3r9LZB1KRviNBB8XHjVy5EGIdNDUcbMRWEEC2VqvgXh46jibPxyBvFX44CFs+WEo
 OkhYBCAP3bd01pUvx5tZtZJXZ5J0pRyzo+E8Qm8vFDq8SSE0VhyN4PoKSUY+ZHgCMNaXesdE8Xy
 D4f1ossYbz1jxsF1Xz905U/jUufPjGtcVw2XD6Ao6rD5rMw4sQUgPMNw+hM0xcCkhl2SskRgFWx
 a5s36lZ07u5jy/g==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
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

From: Pratyush Yadav <p.yadav@ti.com>

TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
parts together.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
NOTE:

This patch depends on
9536cc949235 ("media: dt-bindings: cadence-csi2rx: Convert to DT schema") 
which is part of linux-next.

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
