Return-Path: <linux-kernel+bounces-36749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3ED83A5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4EA28892D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335B18B1A;
	Wed, 24 Jan 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrfYhubb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E118625;
	Wed, 24 Jan 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089971; cv=none; b=LtxjExMMHTHAUiLvFfsa4bMJzyiLJ8CqCX2fUCJRfvDDWY5NvIQVXKR2oESjsY/MfojdywGbum97A7G4WIN4IEZtOvti9ikfIkN2kv3ryqpfpVklZs0rHxjmviTGZl0ujNTGFQBgbfcPkHjhJXefCz/WlGGTDMGp8AIDESL9SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089971; c=relaxed/simple;
	bh=NiIeZZFwIvY0DyQXr6Ns8lr+2tiWC2O7tm2aI4XiJ6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RhevI4TzESlm4mGsZd57lWu0aW5A4IgL/JUDf2t+BNmhfR85q2naqU0ND/r7kv/hXoCnkXFBZZcg+K+9iThNNYv4z1b1eflJRzHbw79HMPJtZm1drqGyTq/9MJhqaNVzdsrNZVTnmVm/sz+YToP8BIzV0kbcpqPCYyZSiKXVzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrfYhubb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so6354062a12.2;
        Wed, 24 Jan 2024 01:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706089966; x=1706694766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3P4SKIph2kaJ1P9uxNmooxsVTdL3TJ4ADsGzchIR86I=;
        b=DrfYhubbju74F5rME3DbcZnKMY+sqiHjN4cqe7m+gE1rmXuFowJa38c/sGSWJoFFgG
         PpdbkSVb71xYgK0mnI1vOtY70bTSu9w4QdW9pfABI4SrHL97Xy5qOE8G38s28HqoTBhB
         Gyu+REowI2tvXiOmWLpdHieQLGsHLxuuoyVN6It8cB10KZop18y0l84/gbNJjKHEHMZY
         JrzfxXbgHmqDVH360fYWipIXJIKgcI01FyZG4dDl0ZgYjG/31r3abj0SQOoBATBfQSOW
         BTYHw3QMrBnB1HFw6B1AT8mEXAX6vDKAybIjz1ecly8wo44iUj2N4drp/3UqEX0j2ZRf
         9MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706089966; x=1706694766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P4SKIph2kaJ1P9uxNmooxsVTdL3TJ4ADsGzchIR86I=;
        b=sFFdN7EXK7HeVVkEdFiJBR6/cT23rk3OTNfm7mysaoNQl6oQA3n+7U1eYOkm05lUlk
         Lru/CPLYpY5+QPs6D7MErsOLeRRwRpbjGHSwesDfY/aoCfyiFbHrYTsJwZzUbkxI/kBm
         tsJOOYa6JpZu8JgpEcBx+ImHTPBVcKpe0tkR5n+uq7XC/EfV4fwvPeCJGHm3uEsTEUgZ
         h1miVK9eC44/q1ByqsQABA5jDWsNg6LWeocPHKdKQIUF6w3dzd/bvNC0PCWu2qu9dy+6
         7gzRXE43iBZHunjR7wsZIwhLfvDnMm1esPQDKb0lqZQaEhHMDejfydxWUBeji51IuWbr
         xYUw==
X-Gm-Message-State: AOJu0Yx/gJVka5uUogBjNb3rBSEJy7pCZu/HLvgGVAmCLyh+4yaNigo/
	TOu5IsJURYUET2dig6vBry4mgBppOnIlM09CVECYIPa0cbJxFaNg
X-Google-Smtp-Source: AGHT+IF6irlAgTX/3kJ/yMSr7XD5tEf74ti0lx8fEEXP6sie7G0d9uw/OA9b8NTVqdOr0j9L59CNkQ==
X-Received: by 2002:a05:6402:344e:b0:55a:5d43:2ef4 with SMTP id l14-20020a056402344e00b0055a5d432ef4mr1595734edc.72.1706089966311;
        Wed, 24 Jan 2024 01:52:46 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id eg34-20020a05640228a200b0055c2404fbe4sm507410edb.69.2024.01.24.01.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:52:45 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: media: convert Mediatek consumer IR to the json-schema
Date: Wed, 24 Jan 2024 10:52:30 +0100
Message-Id: <20240124095230.25704-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files. Introduced changes:
1. Reworded title
2. Added required #include-s and adjusted "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/media/mediatek,mt7622-cir.yaml   | 81 +++++++++++++++++++
 .../devicetree/bindings/media/mtk-cir.txt     | 28 -------
 2 files changed, 81 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mtk-cir.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
new file mode 100644
index 000000000000..a2d0eed33292
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek consumer IR on-SoC controller
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7622-cir
+      - mediatek,mt7623-cir
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: clk
+      - const: bus
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: rc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt7622-cir
+    then:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          minItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt7623-cir
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ir@10013000 {
+        compatible = "mediatek,mt7623-cir";
+        reg = <0x10013000 0x1000>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&infracfg CLK_INFRA_IRRX>;
+        clock-names = "clk";
+        linux,rc-map-name = "rc-rc6-mce";
+    };
diff --git a/Documentation/devicetree/bindings/media/mtk-cir.txt b/Documentation/devicetree/bindings/media/mtk-cir.txt
deleted file mode 100644
index 5e18087ce11f..000000000000
--- a/Documentation/devicetree/bindings/media/mtk-cir.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Device-Tree bindings for Mediatek consumer IR controller
-found in Mediatek SoC family
-
-Required properties:
-- compatible	    : Should be
-			"mediatek,mt7623-cir": for MT7623 SoC
-			"mediatek,mt7622-cir": for MT7622 SoC
-- clocks	    : list of clock specifiers, corresponding to
-		      entries in clock-names property;
-- clock-names	    : should contain
-			- "clk" entries: for MT7623 SoC
-			- "clk", "bus" entries: for MT7622 SoC
-- interrupts	    : should contain IR IRQ number;
-- reg		    : should contain IO map address for IR.
-
-Optional properties:
-- linux,rc-map-name : see rc.txt file in the same directory.
-
-Example:
-
-cir: cir@10013000 {
-	compatible = "mediatek,mt7623-cir";
-	reg = <0 0x10013000 0 0x1000>;
-	interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
-	clocks = <&infracfg CLK_INFRA_IRRX>;
-	clock-names = "clk";
-	linux,rc-map-name = "rc-rc6-mce";
-};
-- 
2.35.3


