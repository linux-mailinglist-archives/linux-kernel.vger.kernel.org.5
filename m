Return-Path: <linux-kernel+bounces-5704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4668818E57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E321F26CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B231755;
	Tue, 19 Dec 2023 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjaGNKMF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E037D18;
	Tue, 19 Dec 2023 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2331e7058aso416904766b.2;
        Tue, 19 Dec 2023 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703007638; x=1703612438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
        b=GjaGNKMFhNze/ROkjNXef+t5EepiThV8hhyj7dbE2NA8AR0aR4IxFypP3TUxYIRDfn
         4bohsXvJ6aVWyOJLiRWz5W/KrKDlQlWtUZLQ2nqpDKhikhXweHNxqoI9fI1i5Z20pw5R
         B3IsWqxBWuzPCIJUXbLVEfMI6PQShHrKf84AHvvSIi1OcYmM9pSXU1S4DQnxmtyeGVJ+
         Kjr2QVOQKXPDbAybBM6CRVpD2hRG3Otie3tBsFpWFajzDqNN68F9jFj3zPk6Bqjcaz1t
         85woP8ctCwYh63fRFjLRX+S0Kat8lkABcKKwBlxf0Az0GhhyKpTZ1tcZOC1FSZtM1CNx
         RPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007638; x=1703612438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
        b=Gqz+quv4mPlNPK+gV+66oZkRJE5fd1iOjKd0nsdsQUymSxCv4cmPcTqoSDTaymQkAj
         Y21lJflFbLuNNTIJhRNEQyr2Do1Yh9B4X7Qeb2U4upaqU0D26I9dPJa5350BZr/g4pyn
         r0eaWwyZ0+7767+Ff3dH0Xe0d6a8r/m2qEsdRccXkNxSnnnlCdW2ZXra9FTVwkRmvHLI
         MyhO9hlAq9GbD+0ki4SY7DzLnay/h7AAEnoam6EcgBD8yIi+K9lBSBLdsTRklBhwnbiU
         XV3HYBFPsFZ+3L9Z46mcQsO6P+++po85CDNN/PAOm7vuyVE+4r2BVW5Z+y1xZV6ewzb5
         vB/g==
X-Gm-Message-State: AOJu0Yws5TAKrkP0ccYk3NaIZfsGrU41dmi9YSey8whxco8BlcKno687
	nMQiZb6zZTHtlUAtdZp9Nik=
X-Google-Smtp-Source: AGHT+IGj03k4tKfPpLbPbo44mQ331d1Cth9MTNhfOJCUqRXauznoIRp+BrTJhH+JppWzVsGZ3iN7Rw==
X-Received: by 2002:a17:907:764c:b0:a26:8ab0:43b8 with SMTP id kj12-20020a170907764c00b00a268ab043b8mr48795ejc.41.1703007638248;
        Tue, 19 Dec 2023 09:40:38 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a1c85124b08sm15834840ejc.94.2023.12.19.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:40:37 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/5] dt-bindings: nvmem: layouts: add U-Boot environment variables layout
Date: Tue, 19 Dec 2023 18:40:21 +0100
Message-Id: <20231219174025.15228-1-zajec5@gmail.com>
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

U-Boot env data is a way of storing firmware variables. It's a format
that can be used of top of various storage devices. Its binding should
be an NVMEM layout instead of a standalone device.

This patch adds layout binding which allows using it on top of MTD NVMEM
device as well as any other. At the same time it deprecates the old
combined binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add "-layout" suffix to compatibles to avoid conflict

 .../nvmem/layouts/u-boot,env-layout.yaml      | 55 +++++++++++++++++++
 .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml
new file mode 100644
index 000000000000..3b4d8f2a44e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env-layout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of U-Boot environment variables
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description:
+  U-Boot uses environment variables to store device parameters and
+  configuration. They may be used for booting process, setup or keeping end user
+  info.
+
+  Data is stored using U-Boot specific formats (variant specific header and NUL
+  separated key-value pairs).
+
+properties:
+  compatible:
+    oneOf:
+      - description: A standalone env data block
+        const: u-boot,env-layout
+      - description: Two redundant blocks with active one flagged
+        const: u-boot,env-redundant-bool-layout
+      - description: Two redundant blocks with active having higher counter
+        const: u-boot,env-redundant-count-layout
+      - description: Broadcom's variant with custom header
+        const: brcm,env-layout
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0x40000>;
+            label = "u-boot";
+            read-only;
+        };
+
+        partition@40000 {
+            reg = <0x40000 0x10000>;
+            label = "u-boot-env";
+
+            nvmem-layout {
+                compatible = "u-boot,env-layout";
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 9c36afc7084b..6c2a3ca5f051 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -26,9 +26,15 @@ description: |
 
   Variables can be defined as NVMEM device subnodes.
 
+  Introduction of NVMEM layouts exposed a limitation of this binding design.
+  Description of NVMEM data content should be separated from NVMEM devices.
+  Since the introduction of U-Boot env data layout this binding is deprecated.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+deprecated: true
+
 properties:
   compatible:
     oneOf:
-- 
2.35.3


