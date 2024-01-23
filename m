Return-Path: <linux-kernel+bounces-34751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA983871C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7781F1F24046
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BBA4EB56;
	Tue, 23 Jan 2024 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2lbURai"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB04EB25;
	Tue, 23 Jan 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990095; cv=none; b=keunLUJ/pfquFpOk71kJ1EkNKT7kryRdVYEBZct6YP4vOQh6cNMrElvVSSfgqUpIZd5bUb51War6awrYeXkzH3cZI13RAMTY2TcxOJi5kTqESLqv5kPzIVDHg/xbyJ9QB4VPqAgAnvOyI1Yd6/6O2u7YxNPTp2OAXPu4g0CIbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990095; c=relaxed/simple;
	bh=XjjPu5c8trVSir5vPeosEclGyGek+TDgQ5alu3svLpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gDJwRucNvW3Yr2TeD6TdRLpA4fZ9g3gaET1blxzPvl8JVwfF5xYHXB9XzI5poaErc/WV85wuxtIUutQHmjvaVO+eNWqEvV4xIxcAxpA6H6dG5sphdqHd0WPNIh83QJZQIRdcm+SgdOwC4wsJV8TgYvxnTMuM+FDKmDTpN+OgAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2lbURai; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso4180190e87.2;
        Mon, 22 Jan 2024 22:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705990092; x=1706594892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4qORfUlpEqFlYNvW/x/uQF2RSEyUxdmLIwXBI7kmUk=;
        b=k2lbURaiTWqeXexJZFKLaYMBzWLAcZGrFyMo8edVPeKdGcdY89qecgtt73qMKiAKB4
         Naq5k2C729Q/rbbyluzKlkwh8VdUEG0UReggKQ3bubWZLUN5iuFD+h4mIfGoOhOW8jIY
         TJcKCJMwb2RCeU+Jdt+AjI6lM1izvPu7h8lfZCsK6/eYz0Jbxt3dz3hHJ06/pPikvTzh
         ryeEL7QYlG2QPS4Zo5tGXsYsMq8+5mMVBLd4E5ImdpJ+t/jtiADyxQpYMLu5c8N23E8q
         K1oWOYcd7ipk8kvtYRbU/eW1TohXWd9+HlzGd7W78V3NgFWEttOKQL/YjDcqvsKpxdEN
         tG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990092; x=1706594892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4qORfUlpEqFlYNvW/x/uQF2RSEyUxdmLIwXBI7kmUk=;
        b=dpFgV8gnETedHrhwx1fK+HL+45YbSO0XnAhifwWGJqqu54D0vTTSwO5d4mCAiWUKM9
         Jk5afUgSZq5XEQVoVW4VdfIi+WAwd6Y5gtrY8HK+5ZEJttIpwyv1QannB2r+SqfItfmN
         +MwmlbgVk98xrxFrokP4kYKROP/WXekjnQ2JxRx1o8gb6n0Ji0gfL4FbHa25BRznGnAr
         EcwnR6iQNQBTkeODWdkT6Ko6v4p1XC/FqVPpKgmXv32CNl+xNHga2C4XydSxFzEg35PH
         NM/V0wjDdOf2QiplNUehg6r5WrDUsTG5RfuhSzSK6yo8Tr/lMK2IcNmo4qLTMR9OzWKT
         ipyw==
X-Gm-Message-State: AOJu0YzLcx3WxzkB7hzzeV57VWU9OZwMN93Z2bZifndk4yl4yG9RR3Eu
	hbV7R+OcR4AvlGby/rLB+f+qHr9SLLDdAVuhPoPU+y7twv+ekWY4
X-Google-Smtp-Source: AGHT+IG6xtqGKymYk8+JRle5ViKMEL/w01zGchfO3OMVWOXeHFp4ZehD2KI0mPvKHeRC4vXp91HPXA==
X-Received: by 2002:a05:6512:3c94:b0:50e:8d0c:5eeb with SMTP id h20-20020a0565123c9400b0050e8d0c5eebmr2981468lfv.85.1705990091798;
        Mon, 22 Jan 2024 22:08:11 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906311700b00a269b4692a9sm11727880ejx.84.2024.01.22.22.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:08:11 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: interrupt-controller: convert MediaTek sysirq to the json-schema
Date: Tue, 23 Jan 2024 07:08:04 +0100
Message-Id: <20240123060804.32254-1-zajec5@gmail.com>
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

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../mediatek,mt6577-sysirq.yaml               | 85 +++++++++++++++++++
 .../interrupt-controller/mediatek,sysirq.txt  | 44 ----------
 2 files changed, 85 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
new file mode 100644
index 000000000000..e1a379c052e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/mediatek,mt6577-sysirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek sysirq
+
+description:
+  MediaTek SOCs sysirq support controllable irq inverter for each GIC SPI
+  interrupt.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt6577-sysirq
+      - items:
+          - enum:
+              - mediatek,mt2701-sysirq
+              - mediatek,mt2712-sysirq
+              - mediatek,mt6580-sysirq
+              - mediatek,mt6582-sysirq
+              - mediatek,mt6589-sysirq
+              - mediatek,mt6592-sysirq
+              - mediatek,mt6755-sysirq
+              - mediatek,mt6765-sysirq
+              - mediatek,mt6779-sysirq
+              - mediatek,mt6795-sysirq
+              - mediatek,mt6797-sysirq
+              - mediatek,mt7622-sysirq
+              - mediatek,mt7623-sysirq
+              - mediatek,mt7629-sysirq
+              - mediatek,mt8127-sysirq
+              - mediatek,mt8135-sysirq
+              - mediatek,mt8173-sysirq
+              - mediatek,mt8183-sysirq
+              - mediatek,mt8365-sysirq
+              - mediatek,mt8516-sysirq
+          - const: mediatek,mt6577-sysirq
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    $ref: "arm,gic.yaml#/properties/#interrupt-cells"
+
+required:
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6797-sysirq
+    then:
+      properties:
+        reg:
+          minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interrupt-controller@10200620 {
+        compatible = "mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq";
+        reg = <0x10220620 0x20>,
+              <0x10220690 0x10>;
+        interrupt-parent = <&gic>;
+        interrupt-controller;
+        #interrupt-cells = <3>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
deleted file mode 100644
index 3ffc60184e44..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-MediaTek sysirq
-
-MediaTek SOCs sysirq support controllable irq inverter for each GIC SPI
-interrupt.
-
-Required properties:
-- compatible: should be
-	"mediatek,mt8516-sysirq", "mediatek,mt6577-sysirq": for MT8516
-	"mediatek,mt8183-sysirq", "mediatek,mt6577-sysirq": for MT8183
-	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
-	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
-	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
-	"mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
-	"mediatek,mt7623-sysirq", "mediatek,mt6577-sysirq": for MT7623
-	"mediatek,mt7629-sysirq", "mediatek,mt6577-sysirq": for MT7629
-	"mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
-	"mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq": for MT6797
-	"mediatek,mt6779-sysirq", "mediatek,mt6577-sysirq": for MT6779
-	"mediatek,mt6765-sysirq", "mediatek,mt6577-sysirq": for MT6765
-	"mediatek,mt6755-sysirq", "mediatek,mt6577-sysirq": for MT6755
-	"mediatek,mt6592-sysirq", "mediatek,mt6577-sysirq": for MT6592
-	"mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq": for MT6589
-	"mediatek,mt6582-sysirq", "mediatek,mt6577-sysirq": for MT6582
-	"mediatek,mt6580-sysirq", "mediatek,mt6577-sysirq": for MT6580
-	"mediatek,mt6577-sysirq": for MT6577
-	"mediatek,mt2712-sysirq", "mediatek,mt6577-sysirq": for MT2712
-	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
-	"mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq": for MT8365
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
-- reg: Physical base address of the intpol registers and length of memory
-  mapped region. Could be multiple bases here. Ex: mt6797 needs 2 reg, others
-  need 1.
-
-Example:
-	sysirq: intpol-controller@10200620 {
-		compatible = "mediatek,mt6797-sysirq",
-			     "mediatek,mt6577-sysirq";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&gic>;
-		reg = <0 0x10220620 0 0x20>,
-		      <0 0x10220690 0 0x10>;
-	};
-- 
2.35.3


