Return-Path: <linux-kernel+bounces-128960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D031789624D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CF9288897
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1A17997;
	Wed,  3 Apr 2024 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="h2JCCK1U"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5B168A8;
	Wed,  3 Apr 2024 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712109893; cv=none; b=enDdzVUPBFiGzZqoFx2ijNfg9HpjoRpFowgMxfWuvOvvm++e7a901F3GPvjkvlQjmDXbBN0FfZ5DnfGuz6mrMQkOBqjmbzWEyhUjL8+QDUS/Stub70+kVluionB/XIG20kc9p56CPXXACrSlHmbkexM8PlGa/8Aq7Wqi+ia6Q2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712109893; c=relaxed/simple;
	bh=rX8gIwLzj9i+NrbHgx/4MPN8g2hbR2CC7BqbS9FNum8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRqlddajuwfi/byKiu49VfxV2D2bcGRQcPgmNymLYCZJHBMb0uuupr5XM/VQ/8VQAF52SzN2dbnzPDLcG4ck25+UVT427bmsFPnkOc49gmY87BTXt/j3HcBgw/aG6DpyEbJPf0BcyWYNNtryfDaALguAJJqczhGtJbr5kZOy8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=h2JCCK1U; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from localhost.localdomain (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 78DE920075;
	Wed,  3 Apr 2024 10:04:47 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712109889;
	bh=CHtl7bWOPaZNTF6/vPau0ikdHIEDo+eVR2BRd+QNipc=;
	h=From:To:Cc:Subject:Date;
	b=h2JCCK1UiiDcyJg4DhhddJ1AEGre8Z0Wt4UJPXPxaOlOw0RcsmJ9xxIy+trwNDGJ0
	 dOp0JE76UyotLGcZ7FYl5hY0SKZ0IhO+sRA/GGCR3KW1J11dCfMtEQ6CemtmCIGWZa
	 cAioct+O/kcLkXHJDzLe4c9ECiPo2e6+4tgkHXKd2+snYlEgXBcorkTJ9qWIALYim7
	 weGb5qpMQgMY71Ys61A1rHRpLLUmkRHIa9rU8eXNJ7uOH9g4Vdk5vYbE2vjtjT0WlL
	 AligKszqy0ktKNNNtuBloGsyC7nMfYDV+VYKi+caDcq1mrOr7XTLQMHeSaKSb9fgEx
	 bpUPEwDEdNsFQ==
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	zev@bewilderbeest.net,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: watchdog: aspeed,ast2400-wdt: Convert to DT schema
Date: Wed,  3 Apr 2024 12:34:39 +1030
Message-Id: <20240403020439.418788-1-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/watchdog@1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
```

The schema binding additionally defines the clocks property over the
prose binding to align with use of the node in the DTS files.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
v2: Address feedback from Rob and Zev

    - Rob: https://lore.kernel.org/linux-watchdog/20240402180718.GA358505-robh@kernel.org/
    - Zev: https://lore.kernel.org/linux-watchdog/65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net/

v1: https://lore.kernel.org/linux-watchdog/20240402120118.282035-1-andrew@codeconstruct.com.au/

 .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 142 ++++++++++++++++++
 .../bindings/watchdog/aspeed-wdt.txt          |  73 ---------
 2 files changed, 142 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
new file mode 100644
index 000000000000..be78a9865584
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed watchdog timer controllers
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-wdt
+      - aspeed,ast2500-wdt
+      - aspeed,ast2600-wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: >
+      The clock used to drive the watchdog counter. From the AST2500 no source
+      other than the 1MHz clock can be selected, so the clocks property is
+      optional.
+
+  aspeed,reset-type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - cpu
+      - soc
+      - system
+      - none
+    default: system
+    description: >
+      The watchdog can be programmed to generate one of three different types of
+      reset when a timeout occcurs.
+
+      Specifying 'cpu' will only reset the processor on a timeout event.
+
+      Specifying 'soc' will reset a configurable subset of the SoC's controllers
+      on a timeout event. Controllers critical to the SoC's operation may remain
+      untouched. The set of SoC controllers to reset may be specified via the
+      aspeed,reset-mask property if the node has the aspeed,ast2500-wdt or
+      aspeed,ast2600-wdt compatible.
+
+      Specifying 'system' will reset all controllers on a timeout event, as if
+      EXTRST had been asserted.
+
+      Specifying 'none' will cause the timeout event to have no reset effect.
+      Another watchdog engine on the chip must be used for chip reset operations.
+
+  aspeed,alt-boot:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: >
+      Direct the watchdog to configure the SoC to boot from the alternative boot
+      region if a timeout occurs.
+
+  aspeed,external-signal:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: >
+      Assert the timeout event on an external signal pin associated with the
+      watchdog controller instance. The pin must be muxed appropriately.
+
+  aspeed,ext-pulse-duration:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      The duration, in microseconds, of the pulse emitted on the external signal
+      pin.
+
+  aspeed,ext-push-pull:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: >
+      If aspeed,external-signal is specified in the node, set the external
+      signal pin's drive type to push-pull. If aspeed,ext-push-pull is not
+      specified then the pin is configured as open-drain.
+
+  aspeed,ext-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: >
+      If both aspeed,external-signal and aspeed,ext-push-pull are specified in
+      the node, set the pulse polarity to active-high. If aspeed,ext-active-high
+      is not specified then the pin is configured as active-low.
+
+  aspeed,reset-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+    description: >
+      A bitmask indicating which peripherals will be reset if the watchdog
+      timer expires. On AST2500 SoCs this should be a single word defined using
+      the AST2500_WDT_RESET_* macros; on AST2600 SoCs this should be a two-word
+      array with the first word defined using the AST2600_WDT_RESET1_* macros,
+      and the second word defined using the AST2600_WDT_RESET2_* macros.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      anyOf:
+        - required:
+            - aspeed,ext-push-pull
+        - required:
+            - aspeed,ext-active-high
+        - required:
+            - aspeed,reset-mask
+    then:
+      properties:
+        compatible:
+          enum:
+            - aspeed,ast2500-wdt
+            - aspeed,ast2600-wdt
+  - if:
+      required:
+        - aspeed,ext-active-high
+    then:
+      required:
+        - aspeed,ext-push-pull
+
+additionalProperties: false
+
+examples:
+  - |
+    watchdog@1e785000 {
+        compatible = "aspeed,ast2400-wdt";
+        reg = <0x1e785000 0x1c>;
+        aspeed,reset-type = "system";
+        aspeed,external-signal;
+    };
+  - |
+    #include <dt-bindings/watchdog/aspeed-wdt.h>
+    watchdog@1e785040 {
+        compatible = "aspeed,ast2600-wdt";
+        reg = <0x1e785040 0x40>;
+        aspeed,reset-type = "soc";
+        aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
+                            (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
deleted file mode 100644
index 3208adb3e52e..000000000000
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-Aspeed Watchdog Timer
-
-Required properties:
- - compatible: must be one of:
-	- "aspeed,ast2400-wdt"
-	- "aspeed,ast2500-wdt"
-	- "aspeed,ast2600-wdt"
-
- - reg: physical base address of the controller and length of memory mapped
-   region
-
-Optional properties:
-
- - aspeed,reset-type = "cpu|soc|system|none"
-
-   Reset behavior - Whenever a timeout occurs the watchdog can be programmed
-   to generate one of three different, mutually exclusive, types of resets.
-
-   Type "none" can be specified to indicate that no resets are to be done.
-   This is useful in situations where another watchdog engine on chip is
-   to perform the reset.
-
-   If 'aspeed,reset-type=' is not specified the default is to enable system
-   reset.
-
-   Reset types:
-
-        - cpu: Reset CPU on watchdog timeout
-
-        - soc: Reset 'System on Chip' on watchdog timeout
-
-        - system: Reset system on watchdog timeout
-
-        - none: No reset is performed on timeout. Assumes another watchdog
-                engine is responsible for this.
-
- - aspeed,alt-boot:    If property is present then boot from alternate block.
- - aspeed,external-signal: If property is present then signal is sent to
-			external reset counter (only WDT1 and WDT2). If not
-			specified no external signal is sent.
- - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
-
-Optional properties for AST2500-compatible watchdogs:
- - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
-			 drive type to push-pull. The default is open-drain.
- - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
-			   is configured as push-pull, then set the pulse
-			   polarity to active-high. The default is active-low.
-
-Optional properties for AST2500- and AST2600-compatible watchdogs:
- - aspeed,reset-mask: A bitmask indicating which peripherals will be reset if
-		      the watchdog timer expires.  On AST2500 this should be a
-		      single word defined using the AST2500_WDT_RESET_* macros;
-		      on AST2600 this should be a two-word array with the first
-		      word defined using the AST2600_WDT_RESET1_* macros and the
-		      second word defined using the AST2600_WDT_RESET2_* macros.
-
-Examples:
-
-	wdt1: watchdog@1e785000 {
-		compatible = "aspeed,ast2400-wdt";
-		reg = <0x1e785000 0x1c>;
-		aspeed,reset-type = "system";
-		aspeed,external-signal;
-	};
-
-	#include <dt-bindings/watchdog/aspeed-wdt.h>
-	wdt2: watchdog@1e785040 {
-		compatible = "aspeed,ast2600-wdt";
-		reg = <0x1e785040 0x40>;
-		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
-				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
-	};
-- 
2.39.2


