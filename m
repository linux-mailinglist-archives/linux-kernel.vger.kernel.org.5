Return-Path: <linux-kernel+bounces-163827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6058B72C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2571C23162
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003C12DD8F;
	Tue, 30 Apr 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxCGMtml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50D12D209;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475493; cv=none; b=GEhB37V/ar3BtqCpTypsu2nkMvon3a+HloxWrTOUw2g3nwoPQfhUQtoYFHRz+9l4vzbMh+KXUnbrYn2NsYUDwK/vM4v+PPJDNAtfygx19vlWh0GND7bDVEXWU5kfegVvQwd8UQPHmdUSomoj81VggX+ZL4fHtqhJnD9VB94DBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475493; c=relaxed/simple;
	bh=2v7bw47Y8yac0BNl8kfbTVNGSFn6BD1G1x5HiyR04yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMeNNrC3vI3FRtUzXDFn69eRynpHpSUyBiVgfUDGnEZsPZEI+weRC9bQs86XL6Ej9PRL79LX7wSiBeQEuGE6ZoE6mOdha5FTzbHf0SE5EAJfPrdFw9fHf2s2qB5ltyuVD3d/7VpWpB+tNNVEAwu8nr7oGYUIDIvv+AlCS1fDtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxCGMtml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FF69C4AF18;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714475493;
	bh=2v7bw47Y8yac0BNl8kfbTVNGSFn6BD1G1x5HiyR04yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DxCGMtmliiMPZwmnrapARnExGI0flvG1XUX7bZf5eucZyez/5PfJd06nSDkxd7BKF
	 z2GN+1anL6VUi0y2Sn0EO3lx1fKyLvLUXViar6a8rAHj/cI2ypIGjdUsRN9/08LOID
	 dwvaK0x7yQpd5yS5OrJ1NCqssT4k7VJbA2mkC+XEHAPyY8TOnWf2aGG+RmDSj+E7eM
	 YGSqUumO+lbjxJBnwAw0n7OHaOEeAtCe9EG6kLqipR5xZnrU63uFDXbC0LqQjCia/V
	 5KWHAACsDZj0jqrAkd+p9mIG+l5RDlLnuq/86jm+T1jiyOnVaFpPD/0GL1b1mVaIgu
	 u6C3MwZalUzAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC7C19F53;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Tue, 30 Apr 2024 19:11:10 +0800
Subject: [PATCH v7 1/3] dt-bindings: mtd: Add Loongson-1 NAND Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-loongson1-nand-v7-1-60787c314fa4@gmail.com>
References: <20240430-loongson1-nand-v7-0-60787c314fa4@gmail.com>
In-Reply-To: <20240430-loongson1-nand-v7-0-60787c314fa4@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714475491; l=1981;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=051ksmvBr0UxivFTnhR9mHkGLTvP/HWsibHv4Ii5zR4=;
 b=NWQWxMYBcUQhSr4sUNOhXWIGbWl7BRPCIJSTrLjZgsIWxIHm3C9M+lhuZdk/KQNJpnjN3ND9V
 SRKmhBxJgE8ATTyAVc/nwE9e/VrZByAA7jsUZAdTZ+9zynIXp2rjo5v
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
Changes in v7:
- rename the file to loongson,ls1b-nfc.yaml

Changes in v6:
- A newly added patch
---
 .../devicetree/bindings/mtd/loongson,ls1b-nfc.yaml | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/loongson,ls1b-nfc.yaml b/Documentation/devicetree/bindings/mtd/loongson,ls1b-nfc.yaml
new file mode 100644
index 000000000000..a69f22b9fd9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/loongson,ls1b-nfc.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/loongson,ls1b-nfc.yaml#
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



