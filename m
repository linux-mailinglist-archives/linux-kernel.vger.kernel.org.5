Return-Path: <linux-kernel+bounces-8904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58181BDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1801C23D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748D63517;
	Thu, 21 Dec 2023 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi6ls69n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C77634F7;
	Thu, 21 Dec 2023 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d045097b4cso7842235ad.0;
        Thu, 21 Dec 2023 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703182621; x=1703787421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YkM0jC9/yHAO382d+ILawqQDBhBWk0KZJUHJnBoAQj8=;
        b=gi6ls69nO9y16qL7Wl1OfZCf741VlbWSd5F0v/rUvh3/SaJ/r6JXrJDUbnKgIxB6t5
         A4NRF6v+Ybg4282Q/f74XleVSwraG5JXi0z+3rWldD59myBIaP2YNJtMRNH6mp8kxRUB
         KWRFGns+A4p8i8rg2VjLKQW2O/Y8uDLtMB0y89XfkHQO9pUdLEWs1gF58H9nRVh+/HQ9
         CNIJBNlgpM8/PtARErKoI6QzDIIF/B7WZV2sYrGxf1cnBmDfgmuzXx1SNGE+aFSSEstz
         Nh/RG2fQFcAH/+UvvfdCcd1y+FRvy5XajqRvKNWAo+4CZl36i1ekmhDvl+e5SatDygNU
         171Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703182621; x=1703787421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkM0jC9/yHAO382d+ILawqQDBhBWk0KZJUHJnBoAQj8=;
        b=mlp/UBT0Ztk24R7wyX/tIdC0yVNEn0LkAfQTbqICOpNar+NXtUmHAv5wDDz7HXkVxd
         yTrRshAI1Dh5geup6SZeG1XK9FtVvMh2Q74FdIgou5cBn2equrlL8heo3dE2CkGFIFjb
         xoNrn2O75DCkYWP0FhdyOfD/F2xNhLnsWushWWGOCJgfgs6XjnMpWvevfTHTmkTLL33R
         HpkZEUqp/7Rs8QCnxAEAdZnJDC5Ar7tteA2raFyY2GJTnhYJoFCNuMs4GklfaENy+DTb
         PLLk4UDLYuoDGZqGxmnrOaN4elbwX/6rbH8chQUpenAKs/x8vfGMQR9PQYgBnFl4RZHk
         dsGQ==
X-Gm-Message-State: AOJu0YyGud140mrctMn4c/7f8xSoLlrhEUsui+tRjQu/kdk5OpyH7ZsN
	LTU/3Xz6UrYyd8aaTlnO3olSwjAKcRPmnQ==
X-Google-Smtp-Source: AGHT+IGDgd2VOVIdT8TOMu96tItwZra5gdbxf1n9VZmBNR7FQBm3hI+DsGtXZ54F1fGp1RRi9U/DPw==
X-Received: by 2002:a17:90a:f188:b0:28a:c3e2:3967 with SMTP id bv8-20020a17090af18800b0028ac3e23967mr134583pjb.30.1703182620849;
        Thu, 21 Dec 2023 10:17:00 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:5f28:c37d:9ad0:e7ae:52c2:c31a])
        by smtp.gmail.com with ESMTPSA id lt17-20020a17090b355100b0028b338470a0sm2121454pjb.3.2023.12.21.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:17:00 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Dan Murphy <dmurphy@ti.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] dt-bindings: input: convert drv266x to json-schema
Date: Thu, 21 Dec 2023 23:44:22 +0530
Message-ID: <20231221181423.671432-1-anshulusr@gmail.com>
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


