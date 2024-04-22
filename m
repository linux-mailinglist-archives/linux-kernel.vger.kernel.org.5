Return-Path: <linux-kernel+bounces-153095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF168AC90C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03F51F2152C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7E83CD0;
	Mon, 22 Apr 2024 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPlPCwiY"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DC502B3;
	Mon, 22 Apr 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778656; cv=none; b=ZKfqUWcroYuytEWymsDh09lfn+de1wOLhZCwfanWXNTdQqeq9di1K9UR4ZVBcWiPZPAXpFgqjrEzttAfoA6k2ntfAAzdXqq+Xicti3E4p/CB6GMMjNVAfU07tZ480UxhS6YPzQZW4paz2Ll6NMhPY5H58wV/nupgZ9qxEMc+nfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778656; c=relaxed/simple;
	bh=6FFicjleLaK4NSrzR0hZBxcOH2qkSWXm1PjvEXM5AAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/S91YKtr53S/6jNBDdCp4/D5GnyITygQOEwRYYQITI64h8LBtfeaI3m4RkUfwcsirWTfa7hH7aT0SfUJDCOZTFF35/6e6wchXkVJLNxyEdVwUzvT5wN7zocR1Z06PJWXA7bRVHkAZf3Wve43VSJOuXb6p/h0BI+3ZixB2N7xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPlPCwiY; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a38c13550so16784445ab.0;
        Mon, 22 Apr 2024 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713778654; x=1714383454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDnU4LVHrNGJ4IpdX+j3QH8fQ0vCkqgYOxnuWATwBXc=;
        b=KPlPCwiYZHSoF+Qo6AIRyV8WJqIy76vb1VyWlFdp36cTLzidzeWheobSsZk/QCfNsb
         3JHxS9wcgtzDujYTJVnJ5fRnuHr/eJNG+7buuFU1qJuvqXWdiSaNtj2/GpTQeKkb0jlV
         FF65yaNvhqXnzCIU3c9llDBq7YLWY60Lf56h/XCEdptCFkPHmZAccJEM8Ktp6i2wXpbu
         He9YuwUwsInjdiLIN2j9yBPYCF3ZYILAY2VvFCyq/cELM1LDV0JmtGg16XmluVif8Z4o
         i3XD52D9ASk91NvbB7ubxmKw1nE+FvbZfZWJwqEpdVGkommr7EO9yfzfwV7KK8z8sG0S
         vjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778654; x=1714383454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDnU4LVHrNGJ4IpdX+j3QH8fQ0vCkqgYOxnuWATwBXc=;
        b=nbDAyeXiqfz9P0iwN31PeSNhnDW9xO8OhflbRcTQZCmvFQndyWSUz3iAblOr6IaS55
         lAmUWKxILucMeru1HnzlVuuMVxnT/JSawbMrWLf96rfuhoBf3rU93vYpkVrmnnXMYtBS
         t3dBvMcSD99j4OkUphcHjbnhq+OSBPGwQKUbKJJIyd+SC67wEMX63GwUldw5j4pRm1hN
         dAA6xb54ZTmfemj4PCcJ2ndbPecWhJW1+UIvnlwSAPnOg4MbjKvByzboh0+nLCWqugcV
         W2K0DC/2ElIav4Vcy3sKwtd5weZp46AzFWWcA7zBzfTD22NwilqcFRecyM+w2jmUzTpD
         kXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxiQRf4t3jt+xywlRSYXhwx1minQLRJANcaQcrOB4seM/QEoy9yKG46eTW6/fhwHQ1lPEHAifvPGcOvLv+xrhNtpg8cEu0UmaSf87TzD17+P/B/7FP5+y1eghsCLkNa+z7wQpX8BkryIK8JMO6oUsVrAoI5ZgCxM5NzakX513JfGq63Q==
X-Gm-Message-State: AOJu0Yyf42wq2hFJJuWz+khJySO6f9muPaVw6rSyTqbz0mnGhoKXeXH4
	z1l3JCf5JgVbGHIkhY8iQsQMwZ2oS8UWu0GLbwN2ogkHaz563xXq
X-Google-Smtp-Source: AGHT+IESL+15Zhi1sznbljSsh+otZIGBA3yjXTo9QZaza/SdrEzFkHVJOjnF7H2qv1Dy520CRiFzdQ==
X-Received: by 2002:a92:c56b:0:b0:36a:2245:205d with SMTP id b11-20020a92c56b000000b0036a2245205dmr16591052ilj.15.1713778653720;
        Mon, 22 Apr 2024 02:37:33 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id a7-20020a654187000000b0060013d7c463sm1115911pgq.72.2024.04.22.02.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:37:33 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: usb: uhci: convert to dt schema
Date: Mon, 22 Apr 2024 15:07:04 +0530
Message-ID: <20240422093706.324115-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert USB UHCI bindings to DT schema.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---

Changes v1->v2:
- add aspeed compatible and deprecated platform-uhci compatible

v1 patch : https://lore.kernel.org/all/20240420142108.76984-1-sheharyaar48@gmail.com/

---
 .../devicetree/bindings/usb/usb-uhci.txt      | 18 -----
 .../devicetree/bindings/usb/usb-uhci.yaml     | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.txt b/Documentation/devicetree/bindings/usb/usb-uhci.txt
deleted file mode 100644
index d1702eb2c8bd..000000000000
--- a/Documentation/devicetree/bindings/usb/usb-uhci.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Generic Platform UHCI Controller
------------------------------------------------------
-
-Required properties:
-- compatible : "generic-uhci" (deprecated: "platform-uhci")
-- reg : Should contain 1 register ranges(address and length)
-- interrupts : UHCI controller interrupt
-
-additionally the properties from usb-hcd.yaml (in the current directory) are
-supported.
-
-Example:
-
-	uhci@d8007b00 {
-		compatible = "generic-uhci";
-		reg = <0xd8007b00 0x200>;
-		interrupts = <43>;
-	};
diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.yaml b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
new file mode 100644
index 000000000000..c5cbcc0a820a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb-uhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Platform UHCI Controller
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: generic-uhci
+      - const: platform-uhci
+        deprecated: true
+      - items:
+          - enum:
+              - aspeed,ast2400-uhci
+              - aspeed,ast2500-uhci
+              - aspeed,ast2600-uhci
+          - const: generic-uhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: generic-uhci
+then:
+  allOf:
+    - $ref: usb-hcd.yaml
+  if:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - aspeed,ast2400-uhci
+            - aspeed,ast2500-uhci
+            - aspeed,ast2600-uhci
+  then:
+    properties:
+      '#ports':
+        $ref: /schemas/types.yaml#/definitions/uint32
+      clocks:
+        maxItems: 1
+    required:
+      - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    usb@d8007b00 {
+        compatible = "generic-uhci";
+        reg = <0xd8007b00 0x200>;
+        interrupts = <43>;
+    };
+...
-- 
2.44.0


