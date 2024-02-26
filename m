Return-Path: <linux-kernel+bounces-80562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2131B866999
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07AF2815B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E91B81C;
	Mon, 26 Feb 2024 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NiuIa6GK"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EAEADD;
	Mon, 26 Feb 2024 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708924634; cv=none; b=WEjycuVLTw1gYrwVMFBffOchurVmreMJrIVXp1DJvNnUB4mVZ4yVQCgVducQbNJ+VQxzPeby9PM2w+RNHXXGYnUH/LQE2J4XzYBdr+6hQsYNOFSer0OM3wYuzdB+pPmHxZnqWI0cNkn/Ybbk7/dUTYjbZ6wS5YipXca0Lwe1V+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708924634; c=relaxed/simple;
	bh=KOvhpneIZpmi+cMDEU/4i2+NNq6gfox83gvbSfDdpTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ky+IE1I1XGZa9g0JVhti/SjKZdtqqyAz8k4hZDZzY0f9YslJl1u35iJNO3BzrUmDrDTOjsrr2d0S9JcJiaKuEenGG9R5h9jxscbQC84pPnT5lC5014rq4yo9LAtDV9tYwAzGfcbeMX9M2SsUM2JIJKAh/RcdzrupcHugtmToeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NiuIa6GK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from localhost.localdomain (ppp118-210-168-240.adl-adc-lon-bras34.tpg.internode.on.net [118.210.168.240])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 903582014E;
	Mon, 26 Feb 2024 13:17:06 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708924629;
	bh=mdH/1Yorj+DulUAB+fzBS9UNRkSo6PY+idiU6w3jbB8=;
	h=From:To:Cc:Subject:Date;
	b=NiuIa6GKxthSeyOFdS7yvPAHZDjJZH7sFgYK7cqscvcSb2EIrZX/ltbvPzG/ueOiq
	 7h6gY6B1eI0Et+vksQapQ4VbFsSd5uDMhxMnJvzEY3tEMd2eZgO+ix6A6hmEWT4o5R
	 kR6r0+NRnbR4tOqV5xV38TyrMAsrBt73m5Lc9zEKSyvy+tMOHt2RltpEdH061A713q
	 UfL3Y+14UcELHI4/pnJ4MQ10CIvSMkAMgzEkMIIc5e7kiTaNZIm5MYY3TV9MrM1QOt
	 qBA1oyf4pUrUyzi/zHoL4hLJEQ1ew47D0TbLg2Qu9mdP/2YXcsTQv/CicOOH20QGgs
	 Opqw2ARSAwmCQ==
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	krzysztof.kozlowski+dt@linaro.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
Date: Mon, 26 Feb 2024 15:46:45 +1030
Message-Id: <20240226051645.414935-1-andrew@codeconstruct.com.au>
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
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
v3: Base on v6.8-rc6, fix yamllint warning

    Rob's bot picked the missing `#interrupt-cells` in the example on v2[1]. The
    patch was based on v6.8-rc1, and going back over my shell history I missed
    the following output from `make dt_binding_check`:

    ```
    ...
      LINT    Documentation/devicetree/bindings
      usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
      yamllint: error: one of the arguments FILE_OR_DIR - is required   
    ...
    ```

    I've rebased on v6.8-rc6 and no-longer see the issue with the invocation
    of `yamllint`.

[1]: https://lore.kernel.org/all/170892197611.2260479.15343562563553959436.robh@kernel.org/

v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew@codeconstruct.com.au/

    Address feedback from Krzysztof:
    https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org/

v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstruct.com.au/

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 74 +++++++++++++++++++
 .../devicetree/bindings/gpio/gpio-aspeed.txt  | 39 ----------
 2 files changed, 74 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
new file mode 100644
index 000000000000..31fa8959c0e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed GPIO controller
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-gpio
+      - aspeed,ast2500-gpio
+      - aspeed,ast2600-gpio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: The clock to use for debounce timings
+
+  gpio-controller: true
+  gpio-line-names: true
+  gpio-ranges: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  ngpios: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - gpio-controller
+  - "#gpio-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-gpio
+    then:
+      required:
+        - ngpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@1e780000 {
+        compatible = "aspeed,ast2400-gpio";
+        reg = <0x1e780000 0x1000>;
+        interrupts = <20>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
deleted file mode 100644
index b2033fc3a71a..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Aspeed GPIO controller Device Tree Bindings
--------------------------------------------
-
-Required properties:
-- compatible		: Either "aspeed,ast2400-gpio", "aspeed,ast2500-gpio",
-					or "aspeed,ast2600-gpio".
-
-- #gpio-cells 		: Should be two
-			  - First cell is the GPIO line number
-			  - Second cell is used to specify optional
-			    parameters (unused)
-
-- reg			: Address and length of the register set for the device
-- gpio-controller	: Marks the device node as a GPIO controller.
-- interrupts		: Interrupt specifier (see interrupt bindings for
-			  details)
-- interrupt-controller	: Mark the GPIO controller as an interrupt-controller
-
-Optional properties:
-
-- clocks		: A phandle to the clock to use for debounce timings
-- ngpios		: Number of GPIOs controlled by this controller. Should	be set
-				  when there are multiple GPIO controllers on a SoC (ast2600).
-
-The gpio and interrupt properties are further described in their respective
-bindings documentation:
-
-- Documentation/devicetree/bindings/gpio/gpio.txt
-- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-  Example:
-	gpio@1e780000 {
-		#gpio-cells = <2>;
-		compatible = "aspeed,ast2400-gpio";
-		gpio-controller;
-		interrupts = <20>;
-		reg = <0x1e780000 0x1000>;
-		interrupt-controller;
-	};

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.39.2


