Return-Path: <linux-kernel+bounces-120688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0788DB78
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF94B1C26572
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648152F94;
	Wed, 27 Mar 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imzIbDF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8494F61D;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536292; cv=none; b=KtwJZpP+x6Q22bWaffOrPsmLO1M+CEvoPkPnW8ck7vtI7UFfkVNTGrZp9Yn9OimdjOi91sONiQKijp+hPW8CWYxciFfyDrgk4EGvEauMMGvoR4nj0u139e1FhDfC3WNmrteRKKZ5UYiZlbZdsYee7M3EQAduhdaYjyaAZ+pR6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536292; c=relaxed/simple;
	bh=SOFXEAyxqf7gCj/PKs4OxopkGggYXvVGBYupyrDF7MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVm7/uSFXgN9iqqOEaBgisIU6lTG0loV+H3/mQJ1kzeNeQ7Ipy5g7Pcsu3aIJWXZ2B8E/j4+cJVv9vvJKSdlIteamUE+h9WE6m+GFvFXlrpPeHCoPdVsBcpqwFnb6l8Jj1+GKvVhT56sos6YnQNHNn9txkWzTzqMQhxhPBH5MjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imzIbDF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE830C433F1;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711536291;
	bh=SOFXEAyxqf7gCj/PKs4OxopkGggYXvVGBYupyrDF7MQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=imzIbDF4cBc002W+hFN9aAH7GeCSjth9qKsiEuK5Dqag4nAYohKJIiGJ7rblNnpFe
	 V3YKMqPw6LVobmuzLD/Ac9etyrRl/xE9RsU/RL4DyLA3uVmkGbwK7RPL4PGQHkLGDq
	 YYDDrVlmibNp45zKxeAEUnTGsLce5EBfl9G/TYVjAVBSUh2AqOuElOCJuxaP4f+weU
	 CP7EI0IBgE1vmDZq+j5kk/uuy0/VIwdi2xqgfqHIzrsHl+ul5PhbxejRWFMvF9EKT2
	 i4B2LoR1nemzqlTRup48aqzPabdNTY1piBpNhafYUe5YT7LNtnJrVhB7PpINLRWsnp
	 YCCug7gpdofqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CBC54E67;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Wed, 27 Mar 2024 18:43:59 +0800
Subject: [PATCH v6 1/3] dt-bindings: mtd: Add Loongson-1 NAND Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-loongson1-nand-v6-1-7f9311cef020@gmail.com>
References: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
In-Reply-To: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711536289; l=1918;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=/c2JzCGiocJH2FRjGpQj1Q5eYCDgSYWhUtAJhnm0nNk=;
 b=eaerRshqwfTKjm0fCEbsHmg1vT1vqL96vqKGFwahc8rg9aGw2YxI9AeHm3KR85x7LcCIlYf+Z
 ZsmgEurqShEBYEkbliGi10MUSklMLGGV/zF/PLi8k/BFjxQ/XpEy4XV
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

Add devicetree binding document for Loongson-1 NAND Controller.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v6:
- A newly added patch
---
 .../devicetree/bindings/mtd/loongson,ls1x-nfc.yaml | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
new file mode 100644
index 000000000000..2494c7b3b506
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/loongson,ls1x-nfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 NAND Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+allOf:
+  - $ref: nand-controller.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - const: loongson,ls1b-nfc
+      - items:
+          - enum:
+              - loongson,ls1a-nfc
+              - loongson,ls1c-nfc
+          - const: loongson,ls1b-nfc
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rxtx
+
+patternProperties:
+  "^nand@[0-3]$":
+    type: object
+    $ref: raw-nand-chip.yaml
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand-controller@1fe78000 {
+        compatible = "loongson,ls1b-nfc";
+        reg = <0x1fe78000 0x40>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dmas = <&dma 0>;
+        dma-names = "rxtx";
+
+        nand@0 {
+            reg = <0>;
+            nand-use-soft-ecc-engine;
+            nand-ecc-algo = "hamming";
+        };
+    };

-- 
2.40.1



