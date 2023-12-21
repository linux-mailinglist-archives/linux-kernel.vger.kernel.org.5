Return-Path: <linux-kernel+bounces-8927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486381BE44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A461F24760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D099C208CC;
	Thu, 21 Dec 2023 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWFSarlv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF22BA30;
	Thu, 21 Dec 2023 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so853913a12.1;
        Thu, 21 Dec 2023 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703183631; x=1703788431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YkM0jC9/yHAO382d+ILawqQDBhBWk0KZJUHJnBoAQj8=;
        b=NWFSarlvHM76cDXDO/8ThaS7uQnaGDt0OgXn+3ercda5p6Nh44iw8TAkeSt+1kWAi7
         dEl2uNeq/1NGaksVhRFtrHb48jPFr5WRgH9zqW5bkL9x8MvlPcAeNuC3U7c5lD1xwPDC
         N1kl1xPJZN56+GkbHtdFHKlbaVGgCJSOGuQvzqjAfN1FxjC3uRTJbKbvS+jgpLC3v+y6
         GkN+/h9thmYephHbHGS+TlLqnVN+POHwcU5Q0JAFuh/nh2wUaXgcPYnz8SECjqO/BrMA
         DJQeYsTjK+V5oOfgHuXdVubKPK0RKUvjW3IxcfWn5bemto0kjtfPTkilxPVzSVAnXmNm
         5Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183631; x=1703788431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkM0jC9/yHAO382d+ILawqQDBhBWk0KZJUHJnBoAQj8=;
        b=uYWf00vl0q9KUh66yJmIiaZcb3bEDX5WlqZ4E7F1qz6AykDjnjRr3e11p4Ugz3BvA4
         fZaWosy7ZE/nPDezeVKTxG261Sh1E9eOGgRUx6RszYmOQHhuuJq8MT1W6MxKuWRXksov
         h+dAofPiRxXmD/2P3fW8SAHr65oUgzQpIfk61vmo0Csm5P93zSv4FReADy+EPGCdLOI6
         ssUr01I4EvYZFABPW5Cs68jcqhxZ1WspXfB6BfiS9ysw7B7d2hJeO4k14Ln+0Pjo+IhE
         nN18+IkPEyvcOivTS7F7Ujzwip4XFfMekzRwXb6Q+0l4QNhB/3ww2Q82roZvFbVtBONf
         JtDg==
X-Gm-Message-State: AOJu0YyBCrsKUrRZ5xRQm2nR90rcOM2ZPnV/ApoebIi58D3/aT5iyUPP
	6adSqNDmI1yrD7aqXAwPMMbDY1dAf2hJTg==
X-Google-Smtp-Source: AGHT+IHebS7pSf/c5UzumBrqxQMXdQsW1Z2LHz1hJZPTMqTvpsA5neH2P+pyHDHWYXbXY1GDik9frg==
X-Received: by 2002:a05:6a20:a10a:b0:191:6028:c6cc with SMTP id q10-20020a056a20a10a00b001916028c6ccmr133280pzk.96.1703183630744;
        Thu, 21 Dec 2023 10:33:50 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:5f28:c37d:9ad0:e7ae:52c2:c31a])
        by smtp.gmail.com with ESMTPSA id u26-20020a63235a000000b005c2420fb198sm1926978pgm.37.2023.12.21.10.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:33:49 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] dt-bindings: input: convert drv266x to json-schema
Date: Fri, 22 Dec 2023 00:01:08 +0530
Message-ID: <20231221183109.684325-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert devicetree binding documentation for ti drv2665 and drv2667
haptics driver to json-schema. The previously two separate bindings have
been merged into a single drv266x.yaml.

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---
 .../devicetree/bindings/input/ti,drv2665.txt  | 17 -------
 .../devicetree/bindings/input/ti,drv2667.txt  | 17 -------
 .../devicetree/bindings/input/ti,drv266x.yaml | 50 +++++++++++++++++++
 3 files changed, 50 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/ti,drv2665.txt
 delete mode 100644 Documentation/devicetree/bindings/input/ti,drv2667.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,drv266x.yaml

diff --git a/Documentation/devicetree/bindings/input/ti,drv2665.txt b/Documentation/devicetree/bindings/input/ti,drv2665.txt
deleted file mode 100644
index 1ba97ac04305..000000000000
--- a/Documentation/devicetree/bindings/input/ti,drv2665.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Texas Instruments - drv2665 Haptics driver
-
-Required properties:
-	- compatible - "ti,drv2665" - DRV2665
-	- reg -  I2C slave address
-	- vbat-supply - Required supply regulator
-
-Example:
-
-haptics: haptics@59 {
-	compatible = "ti,drv2665";
-	reg = <0x59>;
-	vbat-supply = <&vbat>;
-};
-
-For more product information please see the link below:
-http://www.ti.com/product/drv2665
diff --git a/Documentation/devicetree/bindings/input/ti,drv2667.txt b/Documentation/devicetree/bindings/input/ti,drv2667.txt
deleted file mode 100644
index 996382cf994a..000000000000
--- a/Documentation/devicetree/bindings/input/ti,drv2667.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Texas Instruments - drv2667 Haptics driver
-
-Required properties:
-	- compatible - "ti,drv2667" - DRV2667
-	- reg -  I2C slave address
-	- vbat-supply - Required supply regulator
-
-Example:
-
-haptics: haptics@59 {
-	compatible = "ti,drv2667";
-	reg = <0x59>;
-	vbat-supply = <&vbat>;
-};
-
-For more product information please see the link below:
-http://www.ti.com/product/drv2667
diff --git a/Documentation/devicetree/bindings/input/ti,drv266x.yaml b/Documentation/devicetree/bindings/input/ti,drv266x.yaml
new file mode 100644
index 000000000000..da1818824373
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,drv266x.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,drv266x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments - drv266x Haptics driver
+
+description: |
+  Product Page:
+    http://www.ti.com/product/drv2665
+    http://www.ti.com/product/drv2667
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,drv2665
+      - ti,drv2667
+
+  reg:
+    maxItems: 1
+
+  vbat-supply:
+    description: Required supply regulator
+
+required:
+  - compatible
+  - reg
+  - vbat-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        haptics@59 {
+            compatible = "ti,drv2667";
+            reg = <0x59>;
+            vbat-supply = <&vbat>;
+        };
+    };
-- 
2.43.0


