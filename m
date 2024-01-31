Return-Path: <linux-kernel+bounces-45852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F4843710
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105802832B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A303EA66;
	Wed, 31 Jan 2024 07:00:58 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4994F608;
	Wed, 31 Jan 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684458; cv=none; b=K1y0n9nFT46aOBNITcBZRhmrMF6w+p9esp8PiWkxOwlzd0m4UcpN+RqVWJb/JI/KsfJRaRBfWu66h3j1nJCMc02Mx4fjAZDU0e8HFCLH5K9rmDtn19/6ieFwfdTitASRwSu2Xn1BvhZsX8xXl9o7/Vh/XxvQA5ZZ1dZ1ZwEfI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684458; c=relaxed/simple;
	bh=B/ElHGjxCkLeMBY823z+y/Hl28wrPRCDlTkzZXoSwIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LipaPYPdeptHoG7L/3mI7EL+QTdYgZlcHTFFRW4BgG9MM3sAWL4hrpRyQGui4yMjaPLw8tUa1OYvpkHYAAPL4k4ezXpabxyMCD7jBl9AsoIeLeaZh4d9aeQF4R0GbDcg6/9OTaKSdwHLcodJKzporTqLnAZzxgHiKmbUq71MCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1706684405tzxcwwhw
X-QQ-Originating-IP: 7tQsAHQX4BoX3xLqOMeHuWcg7OvaXJdXcdN0YcqngNY=
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 15:00:03 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: RqEkWZU95OHUMMbnP5O7pi75yccQvoLOKSaRKuHaOOzptfT2R6XrK9l9iFErh
	G3/j+PxM/liXJH0nqhRZ7VhsiFeY22Ba8lOlwB22/kko4VeFXGWGgppbHYNavC7ZDPLH6hH
	1max6ZXzbeON1oXvsTysh3W2jihhIBq2T6bSLK+DBcNfT4lsu1OVXInznr4kH9pU5SoGQ5x
	UZpXpTVQdSSm/5yUjPwNLblojd9HpX1PRaMXy9GT4tcOvoidoXks3UEJDKoq4QbQ3c0ya68
	5VzbOCx03O/g7udQePvBN4fg2cx3RucyiydnkNR6givjCyc/uL+IwMhfhlIU97FWpKSkfUF
	iQ7QkzuUvnsiqDFejouCciTzwOpN0+SQl2ZX9cGoSioEfaRmGDo5pcLoTdORLcV5E5CSNZQ
	CgkloBQaORjMcX66yVMiCA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16691829228007298276
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Jialong Yang <jialong.yang@shingroup.cn>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn,
	ke.zhao@shingroup.cn,
	zhijie.ren@shingroup.cn,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bingdings: perf: Support uncore ARM NI-700 PMU
Date: Wed, 31 Jan 2024 14:59:53 +0800
Message-Id: <20240131065953.9634-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU driver
for HX.

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
---
v1 --> v2:
1. Submit dt-bindings file Seperately.
2. Do some check:
   ~ #: make dt_binding_check DT_SCHEMA_FILES=perf
   LINT    Documentation/devicetree/bindings
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTEX    Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts
   DTC_CHK Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dtb

 .../bindings/perf/hx,c2000-arm-ni.yaml        | 53 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 +++
 3 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml

diff --git a/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
new file mode 100644
index 000000000000..de50c79a5f23
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/hx,c2000-arm-ni.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HX-C2000 NI (Network-on-chip Interconnect) Performance Monitors
+
+maintainers:
+  - Jialong Yang <jialong.yang@shingroup.cn>
+
+properties:
+  compatible:
+    enum:
+      - hx,c2000-arm-ni
+
+  reg:
+    items:
+      - description: Physical address of the base (PERIPHBASE) and
+          size of the whole NI configuration address space.
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: Overflow interrupt for clock domain 0
+      - description: Overflow interrupt for clock domain 1
+      - description: Overflow interrupt for clock domain 2
+      - description: Generally, one interrupt line for one PMU. But this also
+          support one interrupt line for a NI if merged.
+
+  pccs-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Used to identify NIs in system which has more than
+      one NI.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmu@23ff0000 {
+            compatible = "hx,c2000-arm-ni";
+            reg = <0x2b420000 0x10000>;
+            pccs-id = <0>;
+            interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..f6b4103ef436 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -617,6 +617,8 @@ patternProperties:
     description: Shenzhen Hugsun Technology Co. Ltd.
   "^hwacom,.*":
     description: HwaCom Systems Inc.
+  "^hx,.*":
+    description: HEXIN Technologies Co., Ltd.
   "^hxt,.*":
     description: HXT Semiconductor
   "^hycon,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..101974780710 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18866,6 +18866,12 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/
 
+HX ARM-NI-700 PMU DRIVERS
+M:	Jialong Yang <jialong.yang@shingroup.cn>
+S:	Supported
+F:	Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
+F:	drivers/perf/hx_arm_ni.c
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.25.1


