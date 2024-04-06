Return-Path: <linux-kernel+bounces-133947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707C89AB4A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF11B282521
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499073770C;
	Sat,  6 Apr 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZd2ahzA"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E024374EB;
	Sat,  6 Apr 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412914; cv=none; b=a5/xBkOn0qPHXheEagMxZeyiYHP766K9a7JSopFHNIzFAA4c0XTszETE0EWaYtxf/XonyTYes5KxghjV2HgBUo+z/QI7n4ryCeuVrk/ymre0dwxLGY6J/g0SjdzoS6u2jUxNXPRLRa6HZWoum8rCOjDc0M/Qc1xFyX2PB6nDCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412914; c=relaxed/simple;
	bh=CxGFv9jvNTqeIa8ZarV7ZY4hs+L+mjnOC11K92E+Z7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivaSqiLXQ4Mh0SL5uWtT3LR01FW0zL7xqa4DVpeMuzrUiMPLQ7pqgOx/djfLLfvjItMDqej1ahxrkw7QGBAcRcIqaUAN1TCh1MLSlHkmNoJT5+BsB1sGjaRj35w3qvQN8RV8nkUaTZ5SG27lQPqmcFddP9RqnjhX5mKhO4iV5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZd2ahzA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso1704705ad.1;
        Sat, 06 Apr 2024 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712412912; x=1713017712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5t85f7blTuWv3UGrktfZJ6b2Gu2J4GPIU/N0JQkbL0k=;
        b=IZd2ahzAt6+0X7ZgY3pClLjsqjHBM9yg8x7oRbBVyL2UVmcaADIlHpb9P2EzZOUbzN
         C2nwA8OxopPuEUdOlVazDQpxi2n4GcspWNA2/qsNVvEMu16nrcAtw68jXTy8N++aja0K
         Ch08EuVPTeyfc/VYFHL/gCI/DbFjP9f0L15/DjwaxKwHAXXvdX1N6qcBjdFEBEDI+ekF
         Ss6CI7i/YEq5YghX6fDioA+749+pkvlwK28vgIijQ0GFIb1wqHZJv3IenSvNTYwNHcWH
         kddpov2VUMt2BLtbTVPX8I9iIHKFXBPDDMmWTkwNGBJbC9UudAa1wFYzgGiLNob9rGLX
         W11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712412912; x=1713017712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t85f7blTuWv3UGrktfZJ6b2Gu2J4GPIU/N0JQkbL0k=;
        b=vnALppuhHeENZHVL4petenvAHfz+Blyb4J7fsyKEqWxPi4bdngGBlrrssLIpfXyw2x
         c2Lbh74sVArIY3100AZu+8PF/1ZRyxFnvk/tYHUnP3gf8cnORDGM1AMMOsn77exOaa/j
         nWu/Fu56uwFRK1VEFx0kFg9Wy5G/idSbWl6cUsAjTQUQteLh383EtIc4IeCRL7vptSOl
         L9H48ePibsViXwQTm5oBJzm7LxCMgNLjhavaVBUR8fiQRoDANo9IJ88sJ0lqg65eC7fZ
         gkg47arLCL6/hLlWhW7UGOVpEeqLoW2ZjHX83gQZhfV37A1+m5skCt7s2NwvKtJUdxCh
         A3eg==
X-Forwarded-Encrypted: i=1; AJvYcCVezF4r89lRaFviywdEnRFpIc+v+lro5XeFo3TwwGgJlsWnH++eZzQwPYV8ZKvHP3Hzj2IIGgWPIQmeWNH+vnei07C+2sXZ5Gjy4BVxyMithzUPCnYL9+eHvJVZ/7ihU0BzYTjYnCAp3g==
X-Gm-Message-State: AOJu0YwQh+G+L2nh6Ju1VSLY5vEN7dwwN+n9epVn8vi3NT8rcLP9mzyk
	/cKsDi6yLBexxmRydeVqC0whW2vA6A/w0r4D7B2vPiEssv3ptGNP
X-Google-Smtp-Source: AGHT+IFgs4/FEoib8hU/ok1TVSzmB1fbWFiM+uZk4kceufpUhC2Ch79+Ar8YHPBhpWONVDqSnLf5Ew==
X-Received: by 2002:a17:902:e9c6:b0:1e2:b137:4f88 with SMTP id 6-20020a170902e9c600b001e2b1374f88mr4603566plk.30.1712412912298;
        Sat, 06 Apr 2024 07:15:12 -0700 (PDT)
Received: from fedora.. ([2409:40f4:3d:d63:253:b5f6:7724:8cee])
        by smtp.gmail.com with ESMTPSA id jc2-20020a17090325c200b001e28d18bd52sm3437400plb.232.2024.04.06.07.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 07:15:12 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: ti,pcm1681: Convert to dtschema
Date: Sat,  6 Apr 2024 19:44:49 +0530
Message-ID: <20240406141454.45529-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments PCM1681 bindings to DT schema.
Make bindings complete by adding #sound-dai-cells.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v2:
- Added existing maintainers to the list of maintainers.
- Added  #sound-dai-cells, $ref to dai-common and unevaluatedProperties: false.
- Added "audio-codec" in example.
---
 .../devicetree/bindings/sound/ti,pcm1681.txt  | 15 -------
 .../devicetree/bindings/sound/ti,pcm1681.yaml | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1681.txt b/Documentation/devicetree/bindings/sound/ti,pcm1681.txt
deleted file mode 100644
index 4df17185ab80..000000000000
--- a/Documentation/devicetree/bindings/sound/ti,pcm1681.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Texas Instruments PCM1681 8-channel PWM Processor
-
-Required properties:
-
- - compatible:		Should contain "ti,pcm1681".
- - reg:			The i2c address. Should contain <0x4c>.
-
-Examples:
-
-	i2c_bus {
-		pcm1681@4c {
-			compatible = "ti,pcm1681";
-			reg = <0x4c>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml b/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
new file mode 100644
index 000000000000..5aa00617291c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm1681.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PCM1681 8-channel PWM Processor
+
+maintainers:
+  - Shenghao Ding <shenghao-ding@ti.com>
+  - Kevin Lu <kevin-lu@ti.com>
+  - Baojun Xu <baojun.xu@ti.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: ti,pcm1681
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pcm1681: audio-codec@4c {
+            compatible = "ti,pcm1681";
+            reg = <0x4c>;
+        };
+    };
-- 
2.44.0


