Return-Path: <linux-kernel+bounces-98938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83075878142
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A615BB2276F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3BA3FBA4;
	Mon, 11 Mar 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCrTGkFW"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D561804C;
	Mon, 11 Mar 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165942; cv=none; b=qYOXeu1LN8KyIFhJ6Sjb61lKmld/hlgY2X4P6puztw5sYHyoP9wex7SHPfrnQXKJnzFkSwwF2gGv9S9OZtij1m7CZfdxFlZOyqTZjIPNmT5nHk8MNKiXeVbnJi9ZBUDjZKzbfTKej2rStMrtJhC6pepKmZXydpHhf5db8JRsUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165942; c=relaxed/simple;
	bh=JZaWt59UeCeNqcvWv/r5KgGKkLciUCSkM8vrzhZCIq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELzsttdJDxogdXhc+Zjy365rIEQAeCUjhGe6lQFuKFZE3PpznBSzpnIrF3WsqpP2RQxNZYUkRP3zl8Nc2vpORapZCXDyMpUvmGiqZvukfdk9BfCcNNRqajQBYJVsF+7EmalHDQWC49WnEeb1yNJffcNdDazxofae5cjx+VvmH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCrTGkFW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd916ad172so9048065ad.2;
        Mon, 11 Mar 2024 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710165940; x=1710770740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGpBbMBa0HNbveOXPkSVIl+7CcmOX/xDsnjZNZtqj28=;
        b=jCrTGkFWvmoJky+u63JlySZTvgBBdh+wImW1a724Bpp1sZNOQSkakaElVeU7dVCrd+
         C+sJFd11tjuoR5+hfC4i57aw/YOkgY2Zhhkk2GO4rcLwH4+GjaQrzCymYsNBqqO+gtbU
         xc+kui+03kom9IhcItr0uK4qf2uctGbukebEeA2LmkAqwYpMO8jVCG7I3r4+cdXPZTZh
         w06Rr94/I53TpJ0GYrbhvfTkCjsB61fPUGTvUYVCd6SCAamQAcQlzQOzYUuPiNwi5+Y+
         xn8HV+TX6N5KnjArrgsjv7ksnzJzhTRR52IGseqNRojAqy5ad28aGwOx+o3wAldEJFVt
         xnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710165940; x=1710770740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGpBbMBa0HNbveOXPkSVIl+7CcmOX/xDsnjZNZtqj28=;
        b=LdKeCsNwmpYcdpBNyaWLyf/PUZg+7Qsjv7F5ixsKQNBupMjE+Ov2pyqjK6T/BGx6w4
         h83/bgXTOdC2TaPeYx7iEdZRfOk7GsAxzUZUlmkQjlb/SVGWm31uvTPjf6I6/weL7Is+
         acXBUdkpsFJg3I0Q5QG9iFi5a35Ob3xtmuJKtdurqB+Rhve6ubVU6r9BAH+yWw1wLsdE
         uHfXdEOjrBeeqzn50v2Y5sfTnjRl26V+uUbWFd4ITNciV4JvXRoiarNFEDpLU+Dhqqiz
         a3FUAvnuBbfTJcIwzM94uCPjljU1XscLVczi7zhzUEjkSTJSkNYPqVAVqEUbKlMLVZmM
         XV1A==
X-Forwarded-Encrypted: i=1; AJvYcCUKNet28JyRe3Hex3Eoqgbj/kulGNgWskcaKB4Clfty13qLLDROgCYzGsuEjrZExxA8TEvOJxzn4yZqmtJctir36Y/sCCRycfZdxlmrs93snH03G9h3UgzxxeIjHAuo9g4R+2fmoWEkucwmH1fUVyAPHlTLj1Hd1ql65G01UHBVKo9BTQ==
X-Gm-Message-State: AOJu0YzwGRlP05JgipAn44Lcj9EjbMVijjc2ur9O4ALGrPESyJWt6n1V
	p6bblj6AU5QVj2CQIiZZ1LFJ/gYfmH0G9CBGR8DyITWeL48FInuQ
X-Google-Smtp-Source: AGHT+IFrWc8qJis+RyGSwF7nLR4pCsKTP7tEgT5YdzAVXgtdQYPGMOl+PKdKOilW6izN/63zMXQXiA==
X-Received: by 2002:a17:902:d2c1:b0:1dd:b315:906d with SMTP id n1-20020a170902d2c100b001ddb315906dmr45245plc.8.1710165939915;
        Mon, 11 Mar 2024 07:05:39 -0700 (PDT)
Received: from localhost.localdomain ([115.240.194.54])
        by smtp.gmail.com with ESMTPSA id kt12-20020a170903088c00b001dd566a1f5fsm4744180plb.155.2024.03.11.07.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:05:39 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7] dt-bindings: imx-pata: Convert to dtschema
Date: Mon, 11 Mar 2024 19:34:29 +0530
Message-ID: <20240311140435.34329-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the imx-pata bindings to DT schema.
Add missing fsl,imx31-pata and
fsl,imx51-pata compatibles during conversion,
because they are already being used in existing DTS.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v7:
- removed blank space at the end of file.

Changes in v6:
- removed items before const due to single element.

Changes in v5:
- added oneOf in compatible property to allow the usage of imx27 alone.

Changes in v4:
- added fsl,imx31-pata in compatible property as enum.

Changes in v3:
- added fsl,imx51-pata in compatible property as enum
- fsl,imx27-pata is added as a const to ensure it is present always

Changes in v2:
- fixed style issues
- compatible property now matches the examples
- fixed yamllint warnings/errors
---
 .../devicetree/bindings/ata/fsl,imx-pata.yaml | 42 +++++++++++++++++++
 .../devicetree/bindings/ata/imx-pata.txt      | 16 -------
 2 files changed, 42 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
new file mode 100644
index 000000000000..27b47e2d32f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/fsl,imx-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX PATA Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx31-pata
+              - fsl,imx51-pata
+          - const: fsl,imx27-pata
+      - const: fsl,imx27-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: PATA Controller interrupts
+
+  clocks:
+    items:
+      - description: PATA Controller clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pata: pata@83fe0000 {
+        compatible = "fsl,imx51-pata","fsl,imx27-pata";
+        reg = <0x83fe0000 0x4000>;
+        interrupts = <70>;
+        clocks = <&clks 161>;
+    };
diff --git a/Documentation/devicetree/bindings/ata/imx-pata.txt b/Documentation/devicetree/bindings/ata/imx-pata.txt
deleted file mode 100644
index f1172f00188a..000000000000
--- a/Documentation/devicetree/bindings/ata/imx-pata.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Freescale i.MX PATA Controller
-
-Required properties:
-- compatible: "fsl,imx27-pata"
-- reg: Address range of the PATA Controller
-- interrupts: The interrupt of the PATA Controller
-- clocks: the clocks for the PATA Controller
-
-Example:
-
-	pata: pata@83fe0000 {
-		compatible = "fsl,imx51-pata", "fsl,imx27-pata";
-		reg = <0x83fe0000 0x4000>;
-		interrupts = <70>;
-		clocks = <&clks 161>;
-	};
-- 
2.44.0


