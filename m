Return-Path: <linux-kernel+bounces-16306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51954823C99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9207E282930
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E91EB43;
	Thu,  4 Jan 2024 07:22:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8241DFE9;
	Thu,  4 Jan 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4047M7C8002299;
	Thu, 4 Jan 2024 15:22:07 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T5Ht304Pbz2R85lG;
	Thu,  4 Jan 2024 15:15:22 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 4 Jan 2024
 15:22:05 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 1/3] dt-bindings: clk: sprd: Add UMS9620 support
Date: Thu, 4 Jan 2024 15:21:46 +0800
Message-ID: <20240104072148.1619009-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104072148.1619009-1-chunyan.zhang@unisoc.com>
References: <20240104072148.1619009-1-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4047M7C8002299

Add UMS9620's clock compatible strings and descriptions for clock
and clock-names for UMS9620.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 79 ++++++++++++++++---
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
index 43d2b6c31357..dcad41a1fea7 100644
--- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -30,25 +30,38 @@ properties:
       - sprd,ums512-mm-clk
       - sprd,ums512-mm-gate-clk
       - sprd,ums512-apapb-gate
+      - sprd,ums9620-pmu-gate
+      - sprd,ums9620-g1-pll
+      - sprd,ums9620-g5l-pll
+      - sprd,ums9620-g5r-pll
+      - sprd,ums9620-g8-pll
+      - sprd,ums9620-g9-pll
+      - sprd,ums9620-g10-pll
+      - sprd,ums9620-apapb-gate
+      - sprd,ums9620-ap-clk
+      - sprd,ums9620-apahb-gate
+      - sprd,ums9620-aon-gate
+      - sprd,ums9620-aonapb-clk
+      - sprd,ums9620-topdvfs-clk
+      - sprd,ums9620-ipaapb-gate
+      - sprd,ums9620-ipa-clk
+      - sprd,ums9620-ipaglb-gate
+      - sprd,ums9620-ipadispc-gate
+      - sprd,ums9620-pcieapb-gate
+      - sprd,ums9620-pcie-clk
+      - sprd,ums9620-mm-gate
+      - sprd,ums9620-mm-clk
+      - sprd,ums9620-dpu-vsp-gate
+      - sprd,ums9620-dpu-vsp-clk
 
   "#clock-cells":
     const: 1
 
   clocks:
-    minItems: 1
-    maxItems: 4
     description: |
       The input parent clock(s) phandle for the clock, only list
       fixed clocks which are declared in devicetree.
 
-  clock-names:
-    minItems: 1
-    items:
-      - const: ext-26m
-      - const: ext-32k
-      - const: ext-4m
-      - const: rco-100m
-
   reg:
     maxItems: 1
 
@@ -57,7 +70,43 @@ required:
   - '#clock-cells'
   - reg
 
-additionalProperties: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: "^sprd,ums512-.*"
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 4
+
+        clock-names:
+          minItems: 1
+          items:
+            - const: ext-26m
+            - const: ext-32k
+            - const: ext-4m
+            - const: rco-100m
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: "^sprd,ums9620-.*"
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 6
+
+        clock-names:
+          minItems: 1
+          maxItems: 6
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -68,4 +117,12 @@ examples:
       clock-names = "ext-26m";
       #clock-cells = <1>;
     };
+
+    aonapb_gate: clock-controller@0 {
+      compatible = "sprd,ums9620-aon-gate";
+      reg = <0x0 0x3000>;
+      clocks = <&ext_26m>, <&ext_32k>, <&rco_60m>;
+      clock-names = "ext-26m", "ext-32k", "rco-60m";
+      #clock-cells = <1>;
+    };
 ...
-- 
2.41.0


