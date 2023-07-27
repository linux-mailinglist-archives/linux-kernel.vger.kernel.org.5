Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D70765235
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjG0L0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjG0L0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:26:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45984E61;
        Thu, 27 Jul 2023 04:26:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36RBPo09084065;
        Thu, 27 Jul 2023 06:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690457150;
        bh=Xcy33PUqxwGfc5BJ3nYt5ip5CNyWZGNoW8CPsHBKEh8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ubIwm0uiLJYIjymfC0sAavx6VqdSVgjs5fjgPjUCBAl8wVtov6/bHI1cTGwFLG2+2
         Qlwu8RIhE6CPqg/umNpotEaj4xEV/9jhuRAZ7t3ZALxGSmkdVF6mncpCcmaaKwQk2p
         Jk+t66h2BhC9X//gfjjt6sL5M8w9MX+NLJ+TInBQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36RBPoLv103463
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 06:25:50 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 06:25:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 06:25:50 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36RBPnEC090132;
        Thu, 27 Jul 2023 06:25:49 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <eugen.hristev@collabora.com>, <ezequiel@vanguardiasur.com.ar>,
        <u.kleine-koenig@pengutronix.de>, <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <b-brnich@ti.com>,
        <detheridge@ti.com>, <p-mantena@ti.com>, <vijayp@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: media: Add bindings for Imagination E5010 JPEG Encoder driver
Date:   Thu, 27 Jul 2023 16:55:45 +0530
Message-ID: <20230727112546.2201995-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727112546.2201995-1-devarsht@ti.com>
References: <20230727112546.2201995-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for Imagination E5010 JPEG Encoder driver which is
implemented as stateful V4L2 M2M driver.

Co-developed-by: David Huang <d-huang@ti.com>
Signed-off-by: David Huang <d-huang@ti.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: No change, just sending this together with driver and cover-letter

 .../bindings/media/img,e5010-jpeg-enc.yaml    | 79 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml

diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
new file mode 100644
index 000000000000..0060373eace7
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagination E5010 JPEG Encoder
+
+maintainers:
+  - Devarsh Thakkar <devarsht@ti.com>
+
+description: |
+  The E5010 is a JPEG encoder from Imagination Technologies implemented on
+  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
+  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
+  8Kx8K resolution.
+
+properties:
+  compatible:
+    const: img,e5010-jpeg-enc
+
+  reg:
+    items:
+      - description: The E5010 main register region
+      - description: The E5010 mmu register region
+
+  reg-names:
+    items:
+      - const: regjasper
+      - const: regmmu
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cbass_main {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      e5010: e5010@fd20000 {
+          compatible = "img,e5010-jpeg-enc";
+          reg = <0x00 0xfd20000 0x00 0x100>,
+                <0x00 0xfd20200 0x00 0x200>;
+          reg-names = "regjasper", "regmmu";
+          clocks = <&k3_clks 201 0>;
+          clock-names = "core_clk";
+          power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
+          interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a5c16bb92fe2..aab11219810f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10170,6 +10170,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/auxdisplay/img,ascii-lcd.yaml
 F:	drivers/auxdisplay/img-ascii-lcd.c
 
+IMGTEC JPEG ENCODER DRIVER
+M:	Devarsh Thakkar <devarsht@ti.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
+
 IMGTEC IR DECODER DRIVER
 S:	Orphan
 F:	drivers/media/rc/img-ir/
-- 
2.34.1

