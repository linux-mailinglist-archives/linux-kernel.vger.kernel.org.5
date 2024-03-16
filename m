Return-Path: <linux-kernel+bounces-105007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE42487D78D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767361F22D10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25496800;
	Sat, 16 Mar 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ASlrYBuX"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB11FA6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710548439; cv=none; b=MPLUrOeIoVCCn1IJj7BtHuZ3hnZE151xn451sAY0BomxZR8LLdXhMyZSG0Tb8U8zUcwV8xQb/7WfiFAJW+3T2UuEYrkKfzGava3V+WRuAAnGGPpG5DA/Tc7/Fq52PsWk6ycSeLGkR/xub1/Y/i6m1Y9pWNnxHp4gVLPCl9UsByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710548439; c=relaxed/simple;
	bh=2UVMuJ75o+GNguwcY2L4zVEWo1QXzLViKUn1kR+eLH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFoEMGI09Uom8pyB9zBUY+fC9WWKlsTAJqjBvDAnUEKxCgv5YSoPnDAXxqxuXAd2D+7ZOCPOSJbg6eZ1qcuvw/daslGZn2I0oueV4brLI7q8PHRqfO0DRwU5AJR81yUTCWtxvTXoP7zFCGfsUIyz0VbkYA/eDs29MtdgyjmKAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ASlrYBuX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710548432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7d13b+m7t1YfrTYPjsXVlued+mXALI1HjsiRsZcRfc=;
	b=ASlrYBuX5r6ZI9NmHTVPypDNXcHxn7ebn2QYPVWe8OlNYeUHmfPvNrUjaM3yfwhP1VyF6l
	vgE/PKlVL+dc+V0W6wIosN3UxFO1VPb3dNcuja04wXiULE1PG9dFp5WHHk5jMw2Cf0FRAQ
	8xgxcWwV8jiTVvqVGQRbiPd9f4qEwbs=
From: Sean Anderson <sean.anderson@linux.dev>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Richard Alpe <richard@bit42.se>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Michael Walle <michael@walle.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of fsl,layerscape-sfp
Date: Fri, 15 Mar 2024 20:20:25 -0400
Message-Id: <20240316002026.1808336-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These bindings document the same hardware (just different minor
revisions). Remove the newer fsl,t1023-sfp.

Fixes: aa1ed6047107 ("dt-bindings: nvmem: Add t1023-sfp efuse support")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 21 ++++++++++-
 .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 -------------------
 2 files changed, 19 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 70fb2ad25103..8a54dd1328ea 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -19,6 +19,13 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - description: Trust architecture 2.0 SFP
+        items:
+          enum:
+            - fsl,t1023-sfp
+            - fsl,t1040-sfp
+            - fsl,t2080-sfp
+            - fsl,t4240-sfp
       - description: Trust architecture 2.1 SFP
         items:
           - const: fsl,ls1021a-sfp
@@ -45,8 +52,18 @@ properties:
 required:
   - compatible
   - reg
-  - clock-names
-  - clocks
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,ls1021a-sfp
+          - fsl,ls1028a-sfp
+then:
+  required:
+    - clocks
+    - clock-names
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
deleted file mode 100644
index df826b40d8ca..000000000000
--- a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
+++ /dev/null
@@ -1,37 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: NXP QorIQ eFuse support
-
-maintainers:
-  - Richard Alpe <richard@bit42.se>
-
-description:
-  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
-
-allOf:
-  - $ref: nvmem.yaml#
-
-properties:
-  compatible:
-    const: fsl,t1023-sfp
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    efuse@e8000 {
-        compatible = "fsl,t1023-sfp";
-        reg = <0xe8000 0x1000>;
-    };
-...
-- 
2.35.1.1320.gc452695387.dirty


