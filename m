Return-Path: <linux-kernel+bounces-59139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B784F1D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FA71F23A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2642566B54;
	Fri,  9 Feb 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8uipCIo"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6633664CD;
	Fri,  9 Feb 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468985; cv=none; b=pkKLeHovgaT5WGr4qe01fYAtvdDeQzaXp/G9JgsqfQzakitQdVPT2V7R82efuqaTsVTWaLkNz+kT2oFkrTPDqnBZid/D+e+3vMt1+07i8wAuD3ammyvYHKkwgGYUEySKXwXBEUdxBcZJZ0U0lWsJHB0ovM4Bs+dJRD5iJ5A6FrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468985; c=relaxed/simple;
	bh=VBbiUmPADiYD6GrR3jzy54qrdeN9TRJQ1J6XHQRONsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i9sIM/8bIQ4n7ZHfBvCmJ2eVgjAk04rgrjCgRIDZRHPSzKALCaqFJKOGRVTIGbK6VRKck6i6l4f3AcXCpqaYXnp5w2s/E+/nQ371B/suqgAodmUZYq/HIJqchNylhkB38XXA4/RmyvY1KJVzrzjpiXeJOLVHXndkt2qgb1feRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8uipCIo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5610c233b95so825312a12.0;
        Fri, 09 Feb 2024 00:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707468982; x=1708073782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4j7w0tByNWeRjldXgrdGngLfYLub5epQdu5N9wCAKVU=;
        b=N8uipCIoNSGl24YXaCfcgJWVrvj/HFsDwuBmQfW++TjFRcc82s7cEOpdMi4JGQooZM
         f6KxJL7k3mle9Q2Z/LmiISMckdbRPcUbF7dB1LQJQ0LaRxX5T0sxkmcgLRWbF1NP5KkR
         XJd/+ET4IhoVP28n4IYojv/1R6rr23fYjj/WECgtMHb2TNfCNkPxnOiK2BL+qiYKK7ab
         VYFlztXK+/BvV0OESNFtd2fWzjs1UFH7oD2JaZXMXgP76Jsysf3baa9p0oT8c/jNsEsq
         AxkcUhCtl6jvdb0KKcnyw+ynr750ccWnzvRSdbJYbFADso84lNdpdCD2Hx54J09qO8ea
         ZUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468982; x=1708073782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4j7w0tByNWeRjldXgrdGngLfYLub5epQdu5N9wCAKVU=;
        b=kIukSi6SrLBm45IZQOa7Cy++wvuCmpiC6e2QKJJlWZQrxIMj3jBT8n51fk4ch3MIIV
         +H3DHv4ZSM5vL7334zy1Seit1GiAEhB+NN2GCH64/5dy9I9fOeqZkUUVhD2FqI7L7Ekv
         +fGvNEgy2COrb+YO50BUIdffj9oXU2Jr1y7b8PWrfD24v9zH+LjZtX3cBCWe3L7NWEQq
         /AbcrMFCI3QklIxMqKKaJrtYYG9tQsjCcj+iSz7ACLbmNABeq3edWOSigBcS1pH3SwUr
         teKQdO/DVFPtjsao7vrPkkl9+MuYccBlY9GCxYHnLb0XH8B/HlGXprIk9xJLJthHi7IS
         yvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6+MUT0UquwRdxp8Ksn/wqIRNbUewrGL0jTCulqk6oYt5guVzVeMpY8b6lCpR821QmdxybWfcrGL5kr3gQfNAOtEkGCSFYqSIqzObX2yoxS2WC3rjdSdV3sVKrSRX7IlImmpXFRfFH3+n14FhRLH5OPGQvqHIp4jyOd9YJ6EcBWjO3rd62
X-Gm-Message-State: AOJu0Yws49tKMEvUu4bKRpd8dprI+iJXhe4ETBSQrSsprDHo1ofzm9Fk
	d2MCA0Z63zCAlQOrFGz/McCccVPA8I+ZM7luRT7clzxACvoYIyUI
X-Google-Smtp-Source: AGHT+IHgUuPQ7ASwNg4AZLYzCfolnE+XedYQpKiuByHC3g0qdKp7WqfDRZQlga0+sRblJhvvfXBs2g==
X-Received: by 2002:a05:6402:1812:b0:55f:fc07:baea with SMTP id g18-20020a056402181200b0055ffc07baeamr794710edy.4.1707468981739;
        Fri, 09 Feb 2024 00:56:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbqSBHGNmgdBRpDUYcZC699RCw2D4Xv3BMZi05Dp2S2QFd8qqK4tk8EkwSUREvszkQ8OyCP5ik4Q6h90Bu1fnb/q7eJxHvTj1/4YikS+rUxBPMjyUPb2+J9iLUtnB/Z4gVZKRAzS41peNFg7FKyd40G94aq20a00ZQ6/NRsY5hkCmmzwom7klWckUuQzGLLY3n8oVOYHE7F5CI51KnBcpjcLoJqjwtibGAawrpSh+v7gA+Y1EzPuN2rvuhCNpuZApaSiyBGI2V+5fb7Kj7tI7rBbuTG43+fFSgF36eAb+mJsqb5uHEIBFqlAxp3K+Cae/7TvA2AcqRT7VbTxLO8lekl/zMWMUv7st1aPph5zBoy5YHPdmZL1SU3hUc+/hJkMNQ67sHWVNo+V/E0NgjF1RtVYEzUs8x1xLbYsOwFWnjIPfvWtMxpDafQImls6+5BASvAk4aq8dyxFpQdjJgAi9NEACeCe4LzOcHd//KKyE=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ay2-20020a056402202200b005611fc0cc11sm583618edb.43.2024.02.09.00.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:56:21 -0800 (PST)
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
Subject: [PATCH V2] dt-bindings: media: convert Mediatek consumer IR to the json-schema
Date: Fri,  9 Feb 2024 09:56:16 +0100
Message-Id: <20240209085616.1062-1-zajec5@gmail.com>
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
2. Made "bus" clock required on MT7623 as well
3. Added required #include-s and adjusted "reg" & clocks in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Extended "IR" in title
    Made "bus" required at MT7623 needs it as well
    Updated example

Thanks AngeloGioacchino!

 .../bindings/media/mediatek,mt7622-cir.yaml   | 55 +++++++++++++++++++
 .../devicetree/bindings/media/mtk-cir.txt     | 28 ----------
 2 files changed, 55 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mtk-cir.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
new file mode 100644
index 000000000000..c01210e053f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Consumer Infrared Receiver on-SoC Controller
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+allOf:
+  - $ref: rc.yaml#
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
+    maxItems: 2
+
+  clock-names:
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
+        clocks = <&infracfg CLK_INFRA_IRRX>, <&topckgen CLK_TOP_AXI_SEL>;
+        clock-names = "clk", "bus";
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


