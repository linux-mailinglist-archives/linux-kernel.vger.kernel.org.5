Return-Path: <linux-kernel+bounces-128840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B1E896052
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD105286909
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885F126F09;
	Tue,  2 Apr 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="aiGqJ/ZD"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304B5914D;
	Tue,  2 Apr 2024 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101194; cv=none; b=iO+4HlrjJVhK+9Yrj2PrXX9OM34tUE71JjHBGprlwID8bLw7R5vOK5ryMPT5K9r16wbzHfTQdwBQZq2KMc0wyf/3MtWel8AJ8hWkUvUW4CRLDajORYP2Pac528sgDniP+fhiQDgWUTMaeJo/UaO6myx4cABLdt4JeH3sOPcqHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101194; c=relaxed/simple;
	bh=9ciK0WFlkwxLrJYfGaqE48QR269wBp49zV2proQBWmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brNgEwsorXpqw7q4TucEoM5L6r7ROaV4ye8R9RxEaKtKykZGn3QPtvDCTurXcmHkV4rskUT32Yv4M755zuit3ZevZtqYeei0ysW3njPZCcHk8qC36QC3cKdBIoRWueLVQEhgMtsr2VStKSkR/9DYddI3uIXYq8/XNvqf+YOuzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=aiGqJ/ZD; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 4FCB3634;
	Tue,  2 Apr 2024 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1712100638;
	bh=4U8xqwY5U+BvijTvs9foSSCeaMMprSgbvDP6CtRfqd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiGqJ/ZD20iv4mVGF5l+BNy2lgszhmXCBQMW5/x3kuebd+BGAa7gKQ8f3oOonzG/w
	 qklknmlA9tw+zi0VMenVdtIM2FljaBCMFk4A6ByMIUD7hZhc5UzCGOD99HwJoayBk5
	 tA03W84mzVS7Jq8sCUuqv6BCFhHAQ+EKCUEz4eSU=
Date: Tue, 2 Apr 2024 16:30:37 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: Convert Aspeed binding to DT
 schema
Message-ID: <65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net>
References: <20240402120118.282035-1-andrew@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240402120118.282035-1-andrew@codeconstruct.com.au>

On Tue, Apr 02, 2024 at 05:01:18AM PDT, Andrew Jeffery wrote:
>Squash warnings such as:
>
>```
>arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/watchdog@1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
>```
>
>Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>---
> .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 130 ++++++++++++++++++
> .../bindings/watchdog/aspeed-wdt.txt          |  73 ----------
> 2 files changed, 130 insertions(+), 73 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>
>diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
>new file mode 100644
>index 000000000000..10fcb50c4051
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
>@@ -0,0 +1,130 @@
>+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>+%YAML 1.2
>+---
>+$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>+
>+title: Aspeed watchdog timer controllers
>+
>+maintainers:
>+  - Andrew Jeffery <andrew@codeconstruct.com.au>
>+
>+properties:
>+  compatible:
>+    enum:
>+      - aspeed,ast2400-wdt
>+      - aspeed,ast2500-wdt
>+      - aspeed,ast2600-wdt
>+
>+  reg:
>+    maxItems: 1
>+
>+  clocks: true
>+
>+  aspeed,reset-type:
>+    enum:
>+      - cpu
>+      - soc
>+      - system
>+      - none
>+    description: |
>+      Reset behaviour - The watchdog can be programmed to generate one of three
>+      different types of reset when a timeout occcurs.
>+
>+      Specifying 'cpu' will only reset the processor on a timeout event.
>+
>+      Specifying 'soc' will reset a configurable subset of the SoC's controllers

Might be worth clarifying that it's configurable only on ast2500 & 
ast2600, and which property (aspeed,reset-mask) configures it?

>+      on a timeout event. Controllers critical to the SoC's operation may remain untouched.
>+
>+      Specifying 'system' will reset all controllers on a timeout event, as if EXTRST had been asserted.
>+      Specifying "none" will cause the timeout event to have no reset effect.

Tiny nit: quoting (single vs. double) is slightly inconsistent between 
values here.

>+      Another watchdog engine on the chip must be used for chip reset operations.
>+
>+      The default reset type is "system"
>+
>+  aspeed,alt-boot:
>+    $ref: /schemas/types.yaml#/definitions/flag
>+    description: |
>+      Direct the watchdog to configure the SoC to boot from the alternative boot
>+      region if a timeout occurs.
>+
>+  aspeed,external-signal:
>+    $ref: /schemas/types.yaml#/definitions/flag
>+    description: |
>+      Assert the timeout event on an external signal pin associated with the
>+      watchdog controller instance. The pin must be muxed appropriately.
>+
>+  aspeed,ext-pulse-duration:
>+    $ref: /schemas/types.yaml#/definitions/uint32
>+    description: |
>+      The duration, in microseconds, of the pulse emitted on the external signal pin
>+
>+  aspeed,ext-push-pull:
>+    $ref: /schemas/types.yaml#/definitions/flag
>+    description: |
>+      If aspeed,external-signal is specified in the node, set the external
>+      signal pin's drive type to push-pull. If aspeed,ext-push-pull is not
>+      specified then the pin is configured as open-drain.
>+
>+  aspeed,ext-active-high:
>+    $ref: /schemas/types.yaml#/definitions/flag
>+    description: |
>+      If both aspeed,external-signal and aspeed,ext-push-pull are specified in
>+      the node, set the pulse polarity to active-high. If aspeed,ext-active-high
>+      is not specified then the pin is configured as active-low.
>+
>+  aspeed,reset-mask:
>+    $ref: /schemas/types.yaml#/definitions/uint32-array
>+    minItems: 1
>+    maxItems: 2
>+    description: |
>+      A bitmaks indicating which peripherals will be reset if the watchdog

Typo: "bitmask"

>+      timer expires. On AST2500 SoCs this should be a single word defined using
>+      the AST2500_WDT_RESET_* macros; on AST2600 SoCs this should be a two-word
>+      array with the first word defined using the AST2600_WDT_RESET1_* macros,
>+      and the second word defined using the AST2600_WDT_RESET2_* macros.
>+
>+required:
>+  - compatible
>+  - reg
>+
>+allOf:
>+  - if:
>+      anyOf:
>+        - required:
>+            - aspeed,ext-push-pull
>+        - required:
>+            - aspeed,ext-active-high
>+        - required:
>+            - aspeed,reset-mask
>+    then:
>+      properties:
>+        compatible:
>+          enum:
>+            - aspeed,ast2500-wdt
>+            - aspeed,ast2600-wdt
>+  - if:
>+      required:
>+        - aspeed,ext-active-high
>+    then:
>+      required:
>+        - aspeed,ext-push-pull
>+
>+additionalProperties: false
>+
>+examples:
>+  - |
>+    wdt1: watchdog@1e785000 {
>+        compatible = "aspeed,ast2400-wdt";
>+        reg = <0x1e785000 0x1c>;
>+        aspeed,reset-type = "system";
>+        aspeed,external-signal;
>+    };
>+  - |
>+    #include <dt-bindings/watchdog/aspeed-wdt.h>
>+    wdt2: watchdog@1e785040 {
>+        compatible = "aspeed,ast2600-wdt";
>+        reg = <0x1e785040 0x40>;
>+        aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
>+                            (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
>+    };
>diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>deleted file mode 100644
>index 3208adb3e52e..000000000000
>--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>+++ /dev/null
>@@ -1,73 +0,0 @@
>-Aspeed Watchdog Timer
>-
>-Required properties:
>- - compatible: must be one of:
>-	- "aspeed,ast2400-wdt"
>-	- "aspeed,ast2500-wdt"
>-	- "aspeed,ast2600-wdt"
>-
>- - reg: physical base address of the controller and length of memory mapped
>-   region
>-
>-Optional properties:
>-
>- - aspeed,reset-type = "cpu|soc|system|none"
>-
>-   Reset behavior - Whenever a timeout occurs the watchdog can be programmed
>-   to generate one of three different, mutually exclusive, types of resets.
>-
>-   Type "none" can be specified to indicate that no resets are to be done.
>-   This is useful in situations where another watchdog engine on chip is
>-   to perform the reset.
>-
>-   If 'aspeed,reset-type=' is not specified the default is to enable system
>-   reset.
>-
>-   Reset types:
>-
>-        - cpu: Reset CPU on watchdog timeout
>-
>-        - soc: Reset 'System on Chip' on watchdog timeout
>-
>-        - system: Reset system on watchdog timeout
>-
>-        - none: No reset is performed on timeout. Assumes another watchdog
>-                engine is responsible for this.
>-
>- - aspeed,alt-boot:    If property is present then boot from alternate block.
>- - aspeed,external-signal: If property is present then signal is sent to
>-			external reset counter (only WDT1 and WDT2). If not
>-			specified no external signal is sent.
>- - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
>-
>-Optional properties for AST2500-compatible watchdogs:
>- - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
>-			 drive type to push-pull. The default is open-drain.
>- - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
>-			   is configured as push-pull, then set the pulse
>-			   polarity to active-high. The default is active-low.
>-
>-Optional properties for AST2500- and AST2600-compatible watchdogs:
>- - aspeed,reset-mask: A bitmask indicating which peripherals will be reset if
>-		      the watchdog timer expires.  On AST2500 this should be a
>-		      single word defined using the AST2500_WDT_RESET_* macros;
>-		      on AST2600 this should be a two-word array with the first
>-		      word defined using the AST2600_WDT_RESET1_* macros and the
>-		      second word defined using the AST2600_WDT_RESET2_* macros.
>-
>-Examples:
>-
>-	wdt1: watchdog@1e785000 {
>-		compatible = "aspeed,ast2400-wdt";
>-		reg = <0x1e785000 0x1c>;
>-		aspeed,reset-type = "system";
>-		aspeed,external-signal;
>-	};
>-
>-	#include <dt-bindings/watchdog/aspeed-wdt.h>
>-	wdt2: watchdog@1e785040 {
>-		compatible = "aspeed,ast2600-wdt";
>-		reg = <0x1e785040 0x40>;
>-		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
>-				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
>-	};
>-- 
>2.39.2
>

