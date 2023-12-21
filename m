Return-Path: <linux-kernel+bounces-8855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA881BD50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EBD1C21A02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A162816;
	Thu, 21 Dec 2023 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq+MPFU8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1662805;
	Thu, 21 Dec 2023 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a235500d0e1so118301066b.2;
        Thu, 21 Dec 2023 09:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703180070; x=1703784870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
        b=Kq+MPFU8ho63pVTD8BxR18cnpGQtmVGRXVU+Bg4g85ViAj8UDqHFbEM1PkT5vIhFhJ
         9AUi/lWEax2JVY/RB4UIl7BV9R3OtW7zLAokF2oh//anZrGJkaWlxFQ2hF5leVgdjcTz
         tVt3MZ8Tqz4D/MkhEDNUwoGkuncqnuLnRajN6bukE//jFbHWXmPBOk4EnakttyTLza3o
         s9PHpkS6v5wAJBzm5nZFv0BQLtlcseTXATlZnbzHYBMkqg4luZAR0RE16T/bJ6nlhdLT
         CIgFQXsabhPm4rULQIWcUjq9kyqzN+YkKaittb8PLYAyf4dhc+7+5DU7D0ivywdA4f6N
         vZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180070; x=1703784870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
        b=e5nf/rgUBzFR2pZ/3FA5gDODmPJkkbR5Kt+YVE16lZSCFxm+v/BhRS7SrLZ43PCS3j
         ayDMKpZBtbCXSCs/cDHX/vRYdknKfE5DKvaQG+RUAcKPFQrGk/Q2DIt1zut3ioFreSfz
         MWkaYWigNr1nNQtmuXwoql2g2cPg6aRvu0dndw6uVzUe4cFq33o53peGG3vK2qqf6nb0
         RFUzAbQZYi6zBqKTDNtIpN5pWP7sbW1iJ2iBRjybtu6O49MrYLwROXA42pDBmL0+SU8H
         jXIiV3Eu879DEijPWsiUtJy1Xc/C9JWw/fM6x1SFtAOrUMgGgOhy+ehnbhJJv75fZY0I
         nHwA==
X-Gm-Message-State: AOJu0YzYQxcSGo5T3UI+Tx4J8fknoQm6VuwNKKpgntib2XC5NSPND+3R
	R7tfiFGgMqXibzejdNQY7W8=
X-Google-Smtp-Source: AGHT+IFhvgdzoX/pSzYG9L+mNveigbIiVGhQYxcEzlqMYOH+0jGOj+DcvcKDRwemDM4HbX3utBRWiA==
X-Received: by 2002:a17:906:1db:b0:a26:8c3a:5133 with SMTP id 27-20020a17090601db00b00a268c3a5133mr61852ejj.99.1703180069801;
        Thu, 21 Dec 2023 09:34:29 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:34:29 -0800 (PST)
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
Subject: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot environment variables layout
Date: Thu, 21 Dec 2023 18:34:16 +0100
Message-Id: <20231221173421.13737-1-zajec5@gmail.com>
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


