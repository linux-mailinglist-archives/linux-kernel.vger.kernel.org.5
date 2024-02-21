Return-Path: <linux-kernel+bounces-75124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F8C85E39C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E1E1F22D12
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977283CB4;
	Wed, 21 Feb 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP/ftiom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7E79DAE;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533681; cv=none; b=G09L3rnymfBJ+QGK9YehSYfz6DRJbgGl1DVY/KLHWDNJ86djIZ0a6uTAR7r0DIsb3QcmCDNUnaJ5fk6liONsvfflUzZ6FA0STyROPhC1Ab60xvZ+I9lJHk/Yv1JO3Qdsw5fh7kv/+mRwpiiP7Ad1CoznfZFNQzx0CWhuXglp0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533681; c=relaxed/simple;
	bh=X+fk+3XslbjTnKyRgSxAmue6mFFlJmgxgQznW4Xq0rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ba5jOdrsV0lhqm2ZPwk3TaimOXPR+qMah904Tv1rWGBam1X4/WMV28D8OeUiN92qFNTf42mHa7jzq7ygG2pi/Jk1HCUCe8gEQ2FFJe6maJWBpGQXfoj1ojFVUUkH/7OOfr4MdovreD9do1arPB9+yz4eKqz5Wea0nIka0CPl1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP/ftiom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39F83C433C7;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533681;
	bh=X+fk+3XslbjTnKyRgSxAmue6mFFlJmgxgQznW4Xq0rA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RP/ftiomqnenfJJKvEKnXjwk+n89r33RqZ+GmIjqZGEWupqGtH40WAD1wVolJYPr0
	 voXiLHMRCaxx4xLolZwChucC0QugReyxuxxjk5r7OWavKrQPCIS2JrHujN7SJcor7C
	 PR4jyKrWTjj8ULnHQCF/hNBPlZfvlPLgtNwaBBFXHP3lRjpDGMFee6de26vQIPdGJz
	 HjqunMH6hDx5S+Cj/JbJQIDLOX0DY2rrVLfQDLXZVK+XTufqfRz5M557bF55kvIcsJ
	 cL1Bxz6VO40PcBsY1UygcwtVWNluUEcq8GXUKbINtoF+nlm4YeEjxdKVAyak/fXi+P
	 R0HIdzw7X7acw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A3C5478A;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 00:41:04 +0800
Subject: [PATCH v3 1/8] dt-bindings: clock: convert hisi-crg.txt to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-clk-mv200-v3-1-f30795b50318@outlook.com>
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
In-Reply-To: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708533664; l=2410;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=e4ZAxJ8Lbk3HDBssdHe1QUVePLSWlZsNs3s4SArOgJI=;
 b=o0WcTEzhdU8xHqE/WOiTDhMlymGeAJSbT0qbwwa5mbHfJSLvNwLBA6ccO8D9OH4BioeTEAAGN
 HxVrA4cSw0tBzTfglLHLXYj3jscBdrScWngkPryQiHRP/8l7zCccLUQ
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Also rename to hisilicon,hisi-crg.yaml. While at it, add "syscon" and
"simple-mfd" compatibles to match the existing dts.

Add reset-controller subnode for hisilicon,hi3798cv200-crg to match the
existing hi3798cv200.dtsi.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/clock/hisilicon,hisi-crg.yaml         | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
new file mode 100644
index 000000000000..2cf21cb5ff27
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/hisilicon,hisi-crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon SOC Clock and Reset Generator (CRG) module
+
+maintainers:
+  - Yang Xiwen <forbidden405@foxmail.com>
+
+description: |
+  Hisilicon SOC clock control module which supports the clocks, resets and
+  power domains on various SoCs.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hisilicon,hi3516cv300-crg
+          - hisilicon,hi3516cv300-sysctrl
+          - hisilicon,hi3519-crg
+          - hisilicon,hi3798cv200-crg
+          - hisilicon,hi3798cv200-sysctrl
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 2
+    description: |
+      First cell is reset request register offset.
+      Second cell is bit offset in reset request register.
+
+  reset-controller:
+    type: object
+    description: |
+      Reset controller for Hi3798CV200 GMAC module
+
+required:
+  - compatible
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: hisilicon,hi3798cv200-crg
+    then:
+      properties:
+        reset-controller: false
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-reset-controller@12010000 {
+        compatible = "hisilicon,hi3519-crg", "syscon", "simple-mfd";
+        reg = <0x12010000 0x10000>;
+        #clock-cells = <1>;
+        #reset-cells = <2>;
+    };

-- 
2.43.0


