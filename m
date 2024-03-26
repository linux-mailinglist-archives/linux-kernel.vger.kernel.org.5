Return-Path: <linux-kernel+bounces-118934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A496C88C185
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592882E858E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5471B40;
	Tue, 26 Mar 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrocT1JS"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE859150;
	Tue, 26 Mar 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454500; cv=none; b=geio1BBcKhf0lJtcqwN9ZCyBku9CkbSXIQ5/wBvWYlKlY5zKZmMeKr3Y7S37PP8QNiATPYJyMDFLIJAMNT9Ck7VaYrLzVFgrVoVRgFuABAXl+Jd1rZ9gkkWG9kP7KTzDkQ2pXn5P6Y6y2ZWrw/JP4lf+CXPLcvsB1FJBQ3D+pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454500; c=relaxed/simple;
	bh=41CWSV0IHKqJ5fSiwoEwTaOvpIuV8R217x+Taxhr5wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ux0r0l/6gF7qAm0j4ced4mbi1ZRAGmX520H65x1zA9QVlI+Q7lm8dGGUYNdV/V8hK6DXlUGW/xuRL8CFv34j29K3AzGMMvR6VutrpzRKmRPjrB4twoCfO1qdVCKw0DcSz9loQrgol8YMpMuZ3FNuIGbH4MlVXtaAf1hlc51XEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrocT1JS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4141015b3a.1;
        Tue, 26 Mar 2024 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711454498; x=1712059298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkemDfqKQM4Sa8+6g7uj2yezaS/ybtOaXo6oGO+9f1c=;
        b=YrocT1JS/Q4YuvLp3Q9NCA8rm6hLWUsuGoIluc1En7U4roC+gtWgOjIOPbEPGgNs3G
         4jYQ/eeEM2VxcJVp07AEVpAC0/ITeGhy32UrQBSBVgiJIj4LpeGAY5gxW0kYQkDrVClW
         kj4huxTtxwsuvjHDLaF+wjsS7z3EGaH88XeOti9wOgn/WlVKREldpHO7IT5lALYrv+gY
         fPhdZYAcXI99daad6C+E8vAsMYh9kG2zibW96ZtKcQ5MT4PzX/f8/S/kWlrezYmBSLYf
         JeXs5AJ0Al7JJeL6lqsgc9cZhHeHFIslF1QnhjAEdc1ZJtazEr965RjuWotshTz7Q5lX
         mrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711454498; x=1712059298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkemDfqKQM4Sa8+6g7uj2yezaS/ybtOaXo6oGO+9f1c=;
        b=JCW56syzVY9OKPm+QZHE9dEDgWi/XTaXd9MpvcfrfOAZmNFQB0t97m+2oJThgpCcSS
         Fn9Ji61aPabYTB32gtieDJFQftVYFS4FmOJZBVqRmU/T+e6X439N8aaSgkNd+YBKtk1b
         fFeoGtcS1HzveBJW8gNDF7Nhzupdrr0RTxOLYhJ0rbzQ6kvUcnEEAKQ8DtmAMStWt3Wd
         r9Y7vlo+9gYx2EFvldVGtAMNgRIozKDSVn0de69TIUjbWB1qFVFCLhxdQl21VSXdKf+K
         fbmtMTFAinqZbxNTkL9otAxEImP6luHh39cO/gGvZUvEJolY3iP2ZejhZfEErP8KzNv/
         C05Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+pGy2cQHU1OKjps6foj1pXOyhXMfYKFU+DPGUEVskYFu71n+jUZR8mdnwQ/jW/P5ceArLkGwNRScJFug2Ej/OS+n3yRLolW71YpSJbeY0ZRPJ+o3s3YokOvc8GbL50mprnWuZiU/pNDwQgg+bK6bIRtGvqwZn/Lh4fnx0IdZ0JijIwcHYeg==
X-Gm-Message-State: AOJu0YzvXtbpds6VpyM9yiyp4VUmjbTgB5sWOJRrRZA+W3k8iNBBTxDn
	c5dWyn/dliKKSZWabE4NC1pGmhXY3Uu+Z/AFr5rwgGLpTiV7QUTS
X-Google-Smtp-Source: AGHT+IGHjCZgHzz3oIDoYLZMvTYoa6AO8FCO/i7Fv1JiaHfOEUAPBeqKXwlccMBIr8feS2JJiD6YuA==
X-Received: by 2002:a05:6a00:814:b0:6e6:830:cd13 with SMTP id m20-20020a056a00081400b006e60830cd13mr1078130pfk.23.1711454498455;
        Tue, 26 Mar 2024 05:01:38 -0700 (PDT)
Received: from localhost.localdomain ([122.187.117.179])
        by smtp.gmail.com with ESMTPSA id y16-20020a62f250000000b006ea858e6e78sm5746247pfl.45.2024.03.26.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:01:38 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
Date: Tue, 26 Mar 2024 17:31:00 +0530
Message-ID: <20240326120107.13442-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the OMAP SoC SHA crypto Module bindings to DT Schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../devicetree/bindings/crypto/omap-sham.txt  | 28 ----------
 .../bindings/crypto/ti,omap-sham.yaml         | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml

diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
deleted file mode 100644
index ad9115569611..000000000000
--- a/Documentation/devicetree/bindings/crypto/omap-sham.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-OMAP SoC SHA crypto Module
-
-Required properties:
-
-- compatible : Should contain entries for this and backward compatible
-  SHAM versions:
-  - "ti,omap2-sham" for OMAP2 & OMAP3.
-  - "ti,omap4-sham" for OMAP4 and AM33XX.
-  - "ti,omap5-sham" for OMAP5, DRA7 and AM43XX.
-- ti,hwmods: Name of the hwmod associated with the SHAM module
-- reg : Offset and length of the register set for the module
-- interrupts : the interrupt-specifier for the SHAM module.
-
-Optional properties:
-- dmas: DMA specifiers for the rx dma. See the DMA client binding,
-	Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: DMA request name. Should be "rx" if a dma is present.
-
-Example:
-	/* AM335x */
-	sham: sham@53100000 {
-		compatible = "ti,omap4-sham";
-		ti,hwmods = "sham";
-		reg = <0x53100000 0x200>;
-		interrupts = <109>;
-		dmas = <&edma 36>;
-		dma-names = "rx";
-	};
diff --git a/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
new file mode 100644
index 000000000000..7a2529cc4cae
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/ti,omap-sham.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP SoC SHA crypto Module
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,omap2-sham
+      - ti,omap4-sham
+      - ti,omap5-sham
+
+  ti,hwmods:
+    description: Name of the hwmod associated with the SHAM module
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [sham]
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+dependencies:
+  dmas: [dma-names]
+
+additionalProperties: false
+
+required:
+  - compatible
+  - ti,hwmods
+  - reg
+  - interrupts
+
+examples:
+  - |
+    sham@53100000 {
+        compatible = "ti,omap4-sham";
+        ti,hwmods = "sham";
+        reg = <0x53100000 0x200>;
+        interrupts = <109>;
+        dmas = <&edma 36>;
+        dma-names = "rx";
+    };
-- 
2.44.0


