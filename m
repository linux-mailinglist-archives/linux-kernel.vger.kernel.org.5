Return-Path: <linux-kernel+bounces-156171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8598AFEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB9E1C232A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9AF143C48;
	Wed, 24 Apr 2024 02:48:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941E7F490;
	Wed, 24 Apr 2024 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926898; cv=none; b=M0efyOjL/DVVrBAhwM96nFTVaRkkFtcr9Z4tWJlx3FtMFiu9KrN860pWXEkZJMKNsT+Rf/bNAQyCiWgaIMcuaOUMJsKgvXsfXSDfJvjd01OvQG/XJgwBdi31fsrLss7toFkap0A4ub5Ygq0imDM/OyWQEa5DHwC8/c3JzdlxpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926898; c=relaxed/simple;
	bh=NE0OOwZiqiCSBKdmYZhk4+BaQDo4g6hiQBkXmkoQI5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ST7uuWIjde0/DUoNSCnGGDyw8LSVDak47xNxqHwYMejrNqwxOZr3vl/miH4Q992ldwNCWkBzoDBYGql+tIUfX9uqDS9/SFcbO2yZFZKTiZLizhXknadKwb1ql5a5R3qpbhB/GY5VDfdqd0TOtfvMc56t+hnfGRQ+/dkr5n3q4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; arc=none smtp.client-ip=210.130.202.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 43O2laOv3503573; Wed, 24 Apr 2024 11:47:37 +0900
X-Iguazu-Qid: 2yAbrn6vF8CACHMBUo
X-Iguazu-QSIG: v=2; s=0; t=1713926856; q=2yAbrn6vF8CACHMBUo; m=kyEivCb1HvndwPm5vwCgrTc2l+8aoldnO3ZxPPpPkEo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 43O2lYFJ2335841
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 11:47:35 +0900
X-SA-MID: 20405579
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 1/6] dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface
Date: Wed, 24 Apr 2024 11:42:10 +0900
X-TSB-HOP2: ON
Message-Id: <20240424024215.1624299-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424024215.1624299-1-yuji2.ishikawa@toshiba.co.jp>
References: <20240424024215.1624299-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds the Device Tree binding documentation that allows to describe
the Video Input Interface found in Toshiba Visconti SoCs.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changelog v2:
- no change

Changelog v3:
- no change

Changelog v4:
- fix style problems at the v3 patch
- remove "index" member
- update example

Changelog v5:
- no change

Changelog v6:
- add register definition of BUS-IF and MPU

Changelog v7:
- remove trailing "bindings" from commit header message
- remove trailing "Device Tree Bindings" from title
- fix text wrapping of description
- change compatible to visconti5-viif
- explicitly define allowed properties for port::endpoint

Changelog v8:
- Suggestion from Krzysztof Kozlowski
  - rename bindings description file
  - use block style array instead of inline style
  - remove clock-lane (as it is fixed at position 0)
  - update sample node's name
  - use lowercase hex for literals
- Suggestion from Laurent Pinchart
  - update description message port::description
  - remove port::endpoint::bus-type as it is fixed to <4>
  - remove port::endpoint::clock-lanes from example
  - add port::endpoint::data-lanes to required parameters list
  - fix sequence of data-lanes: <1 2 3 4> because current driver does not support data reordering
  - update port::endpoint::data-lanes::description
  - remove redundant type definition for port::endpoint::data-lanes

Changelog v9:
- place "required" after "properties"
- dictionary ordering of properties

Changelog v10:
- no change

 .../media/toshiba,visconti5-viif.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml

diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml
new file mode 100644
index 0000000000..97e8bda427
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/toshiba,visconti5-viif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti5 SoC Video Input Interface
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description: |-
+  Toshiba Visconti5 SoC Video Input Interface (VIIF) receives MIPI CSI2 video
+  stream, processes the stream with image signal processors (L1ISP, L2ISP),
+  then stores pictures to main memory.
+
+properties:
+  compatible:
+    const: toshiba,visconti5-viif
+
+  reg:
+    items:
+      - description: Registers for capture control
+      - description: Registers for CSI2 receiver control
+      - description: Registers for bus interface unit control
+      - description: Registers for Memory Protection Unit
+
+  interrupts:
+    items:
+      - description: Sync Interrupt
+      - description: Status (Error) Interrupt
+      - description: CSI2 Receiver Interrupt
+      - description: L1ISP Interrupt
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description: CSI-2 input port, with a single endpoint connected to the CSI-2 transmitter.
+
+    properties:
+      endpoint:
+        $ref: video-interfaces.yaml#
+        additionalProperties: false
+
+        properties:
+          data-lanes:
+            description: VIIF supports 1, 2, 3 or 4 data lanes
+            minItems: 1
+            items:
+              - const: 1
+              - const: 2
+              - const: 3
+              - const: 4
+
+          clock-noncontinuous: true
+          link-frequencies: true
+          remote-endpoint: true
+
+        required:
+          - clock-noncontinuous
+          - data-lanes
+          - link-frequencies
+          - remote-endpoint
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        video@1c000000 {
+            compatible = "toshiba,visconti5-viif";
+            reg = <0 0x1c000000 0 0x6000>,
+                  <0 0x1c008000 0 0x400>,
+                  <0 0x1c00e000 0 0x1000>,
+                  <0 0x2417a000 0 0x1000>;
+            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+
+            port {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                csi_in0: endpoint {
+                    clock-noncontinuous;
+                    data-lanes = <1 2>;
+                    link-frequencies = /bits/ 64 <456000000>;
+                    remote-endpoint = <&imx219_out0>;
+                };
+            };
+        };
+    };
-- 
2.25.1



