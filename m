Return-Path: <linux-kernel+bounces-155424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3B8AEA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F69B1F2337E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578CA13C3E3;
	Tue, 23 Apr 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap7xUb7H"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B0134CC2;
	Tue, 23 Apr 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884763; cv=none; b=W+lpA9brKm/iyO69ZpunjPpLj5U+pVYYkCouM9CktQBu7+T1G8Js5NK8+obpNlfC3LSMEntMhPSXq0W6wbZLs7b0PAvWOvPIX+3uDWJV0wOCQZUuSXMysRgCD0oA/0MNlbojDkOo7J/ipAirzAQU29mlZk0SsXfvHUme0ZfSjKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884763; c=relaxed/simple;
	bh=c1YQiuI+aSkLs5EilLhcs3Z49GczY6uW8zvV0s+0ZEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrk/HjqwKO1ZK6moS6kXPGuVRPV0//kHHN7K6z2+hpl3yxB6p9VUMblg9N4CN9zM+fhcTLeu7XfPeVXz0Fbg23bCJK+spcPV5gy1HWW5h0ygzjE+zOm7EsjGF/tENCH0apJq1vY3e+FwgfrlEankK5yenA3QNH8jq04wLIemxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap7xUb7H; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed112c64beso4992472b3a.1;
        Tue, 23 Apr 2024 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884758; x=1714489558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSiLT8rGn/DUAMlTsyuIcVEZ7KNG3BkMo6PmY1zTuJA=;
        b=ap7xUb7HFqIAJ7/56Gea282ealKItiwGkf6C6CVaZQo4iwUw/zF2H7xpfmuxgB8fd3
         fh+yifZjUIIxZXPz+EmCeq4i/nV/56bNRn22jmEOfZirV1tP2sfkjLXjiZOIrBVpNqq7
         I8OgsXGDVjRSLdSkTYjNDlKNYDkLQFgPcCQnPxuhz0LtUEXPE1Wh28J0DylxfMoctE8T
         MPCVOkT1AOw5fmUQtvzU7zSW0haLqi2nlBp9NfaupJN7EQ1JMupq8Sclel1n4lVY8AW3
         A5HXxVX/iV34Hz/GqfXl31ijnWUTMgmxRqI6rHl0xQFjmCLs3pd5qkZKlums9FkD4GuA
         ZUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884758; x=1714489558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSiLT8rGn/DUAMlTsyuIcVEZ7KNG3BkMo6PmY1zTuJA=;
        b=vAfD8Ga3+HadUmjvKmMSnBcYcD52TRKL0K82aPU/4VzEkrFo+ebbp02ZbzjJYV0ZCP
         N6MBiCKUsblmX0NvnvY/nYxPcsXl+cwA/PmA63+h5aS3qrpt/kDjALfJk0Kh0hUPDRdn
         3cSGmlebnuk3iFnmF78BN7EDY5l69R6U/qZ2nQqJXpt6c3ENVD6fGFU29pZoZKyjgE3O
         ehQxuDZ2KeNMEw9UmXPlsBX/HhfJZq1xtxJApSSAEjxwhoyC/g7TQtZM8kKVR0PRrQMc
         23+fBu22nGk6Y7an8CGqvltyYwShrS55hWmdFqE/2nWfPuZ8IxOK8oQhHG0jrPI9VsCZ
         fEUg==
X-Forwarded-Encrypted: i=1; AJvYcCVFexX6NPPjwLtFd9qRQF2fEi1reugii17QeYh3AI9wa6FwAebZNkWZkyrJQLwwY9EnlilMJbgDfuyeJpk4G9FoFFDTPl7oGxPQM0b66WjLW8NNbjRFf2wCOc1BWkuUgqANzXqjvE7huEl+K5Fe2uH0XYoufMMN3HDOAv/eJrJ8G2OOfw==
X-Gm-Message-State: AOJu0YygZLDlr+Gy3c0K7xjLTKEGY0/oQZh+ZWyiDJw+hQ9uDBPgR/ex
	hDpFc9kq8ov6pLsb8C/f84zn7V6x6RKLxk8E78uPasmT0wX2gb0NR9YzykqwDqk=
X-Google-Smtp-Source: AGHT+IHYglb1gDlfjysIQShA+h/0ERVm859A1Kwe/GAK/vhX5AYcQXn/bUJHrimTMjCaOROr/lexPA==
X-Received: by 2002:a05:6a21:33a9:b0:1a9:4570:2d3b with SMTP id yy41-20020a056a2133a900b001a945702d3bmr14252832pzb.7.1713884757641;
        Tue, 23 Apr 2024 08:05:57 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id g22-20020a056a000b9600b006edf7be92c2sm9708701pfj.72.2024.04.23.08.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:05:57 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: usb: uhci: convert to dt schema
Date: Tue, 23 Apr 2024 20:35:48 +0530
Message-ID: <20240423150550.91055-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert USB UHCI bindings to DT schema. Documenting aspeed compatibles
and missing properties. Adding aspeed/generic-uhci example and fixing
nodename for the original example.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
Changes 
v3->v4:
- fix previous incorrect use of if-then block and original example
v2->v3:
- fix property declaration and if-then-else block
- add generic-uhci example and fix prev incorrect example
v1->v2:
- add aspeed compatible and deprecated platform-uhci compatible

v3 patch : https://lore.kernel.org/all/20240422122125.455781-1-sheharyaar48@gmail.com
v2 patch : https://lore.kernel.org/all/20240422093706.324115-1-sheharyaar48@gmail.com
v1 patch : https://lore.kernel.org/all/20240420142108.76984-1-sheharyaar48@gmail.com
---
 .../devicetree/bindings/usb/usb-uhci.txt      | 18 -----
 .../devicetree/bindings/usb/usb-uhci.yaml     | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 18 deletions(-)
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
index 000000000000..d8336f72dc1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
@@ -0,0 +1,75 @@
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
+  '#ports':
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: usb-hcd.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: generic-uhci
+    then:
+      required:
+        - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    usb@d8007b00 {
+        compatible = "generic-uhci";
+        reg = <0xd8007b00 0x200>;
+        interrupts = <43>;
+        clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
+    };
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    usb@1e6b0000 {
+        compatible = "aspeed,ast2500-uhci", "generic-uhci";
+        reg = <0x1e6b0000 0x100>;
+        interrupts = <14>;
+        #ports = <2>;
+        clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
+    };
+...
-- 
2.44.0


