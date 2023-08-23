Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E15786389
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbjHWWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbjHWWpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:45:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A3CF1;
        Wed, 23 Aug 2023 15:45:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fee600dce6so43587955e9.1;
        Wed, 23 Aug 2023 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692830698; x=1693435498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUMCOUtyQrIYTwazhCYMZXOt/hI2ZI3M7opV35FQAKo=;
        b=QADy7Uh4TWpNIiEFZ10c9vs0uL7pTCAgC15Utwt+b8HQ7+zEF+oB81ts/59MtFNsyo
         Km8CIy5XS0JMtEe1hovG2OrIDdJzwwFyApKqRr4qCeSNdCJCeWBD/wFfqKpQsRPTmwdG
         OlsC2ORT6KQLyJj1xktj5/9Zj92ddIAZ+gkaspouU925Ym4WzyAtsoMKI3PHcvwknwnJ
         lRCpZBeJhCtGGEmDDxG5RWcOqQLDosTaWgyT0GziJR4xG8FbQpkpR+6xXxUXv+EckiSA
         4lHCeKFUPQfS44tp/4ccBqxgusSQ9oxaC4Ozg7m2OiIFNkd1W2nBF+R7Smm9h7usannt
         TNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830698; x=1693435498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUMCOUtyQrIYTwazhCYMZXOt/hI2ZI3M7opV35FQAKo=;
        b=NpGBxyx1tYKZ/afXif+eeLqDdXRgJqI7ewSd7xRKjZVVFwQf+obz5DoyG9aomvg+jx
         sqM3YNA9EP/08ZIZs2Tp23CbKCgrhx0ZzS6nVWHC7F6EzFg0kPvEieMjsTrKMW4biQmF
         5tnFYKlxr9pz7+rOx0ouWfGG5jMKXu6/tJlkK8V5kQI2zgLaSCNulqkhY1ASAfgQvaqW
         dM6w5ndfhGRPSpFD8lvowjflnkvKBQDjHWfTj28mitefcvZPXBI4LvXG4YdgC3kKh+s9
         2VrmtBfkqfzHBlPcealRLqvIK/xiomCyy7K82HlJOEJmZpsBTefe8U2e3X3tCVeOg6hd
         GfIA==
X-Gm-Message-State: AOJu0YxASkAmUmyWfxIYGqB2ezg7ZdnmUSiD+mTCkT3CvMBoTEj1ZlgY
        vE3e7922esIrOtueTnHnWXQ=
X-Google-Smtp-Source: AGHT+IHohP4dIKk3Jaf3boxqhxtSI8hwzTdQ0rXclcDdJb0AyezIH/V/WFTA17lq1H5TsjWZjRMD8A==
X-Received: by 2002:a1c:6a16:0:b0:3fe:1deb:82 with SMTP id f22-20020a1c6a16000000b003fe1deb0082mr10738652wmc.7.1692830698224;
        Wed, 23 Aug 2023 15:44:58 -0700 (PDT)
Received: from localhost ([37.169.46.77])
        by smtp.gmail.com with ESMTPSA id t4-20020a1c7704000000b003fefe70ec9csm799602wmi.10.2023.08.23.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:44:58 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] dt-bindings: irqchip: convert st,stih407-irq-syscfg to DT schema
Date:   Thu, 24 Aug 2023 00:44:53 +0200
Message-ID: <20230823224453.126963-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert deprecated format to DT schema format.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
	- Added Conor's r-by
	- Removed quotes surrounding $refs
	- Hardcoded 'st,invert-ext' possible values

Changes in v3:
	- Fixed enum syntax warnings
	- Removed reference to driver in favor of device
---
 .../st,sti-irq-syscfg.txt                     | 30 ---------
 .../st,stih407-irq-syscfg.yaml                | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
deleted file mode 100644
index 977d7ed3670e..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-STMicroelectronics STi System Configuration Controlled IRQs
------------------------------------------------------------
-
-On STi based systems; External, CTI (Core Sight), PMU (Performance Management),
-and PL310 L2 Cache IRQs are controlled using System Configuration registers.
-This driver is used to unmask them prior to use.
-
-Required properties:
-- compatible	: Should be "st,stih407-irq-syscfg"
-- st,syscfg	: Phandle to Cortex-A9 IRQ system config registers
-- st,irq-device	: Array of IRQs to enable - should be 2 in length
-- st,fiq-device	: Array of FIQs to enable - should be 2 in length
-
-Optional properties:
-- st,invert-ext	: External IRQs can be inverted at will.  This property inverts
-		  these IRQs using bitwise logic.  A number of defines have been
-		  provided for convenience:
-			ST_IRQ_SYSCFG_EXT_1_INV
-			ST_IRQ_SYSCFG_EXT_2_INV
-			ST_IRQ_SYSCFG_EXT_3_INV
-Example:
-
-irq-syscfg {
-	compatible    = "st,stih407-irq-syscfg";
-	st,syscfg     = <&syscfg_cpu>;
-	st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
-			<ST_IRQ_SYSCFG_PMU_1>;
-	st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
-			<ST_IRQ_SYSCFG_DISABLED>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
new file mode 100644
index 000000000000..985fa281f027
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/st,stih407-irq-syscfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi System Configuration Controlled IRQs
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+description:
+  On STi based systems; External, CTI (Core Sight), PMU (Performance
+  Management), and PL310 L2 Cache IRQs are controlled using System
+  Configuration registers.  This device is used to unmask them prior to use.
+
+properties:
+  compatible:
+    const: st,stih407-irq-syscfg
+
+  st,syscfg:
+    description: Phandle to Cortex-A9 IRQ system config registers
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  st,irq-device:
+    description: Array of IRQs to enable.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: Enable the IRQ of the channel one.
+      - description: Enable the IRQ of the channel two.
+
+  st,fiq-device:
+    description: Array of FIQs to enable.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: Enable the IRQ of the channel one.
+      - description: Enable the IRQ of the channel two.
+
+  st,invert-ext:
+    description: External IRQs can be inverted at will. This property inverts
+      these IRQs using bitwise logic.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4]
+
+required:
+  - compatible
+  - st,syscfg
+  - st,irq-device
+  - st,fiq-device
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq-st.h>
+    irq-syscfg {
+        compatible    = "st,stih407-irq-syscfg";
+        st,syscfg     = <&syscfg_cpu>;
+        st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
+                        <ST_IRQ_SYSCFG_PMU_1>;
+        st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
+                        <ST_IRQ_SYSCFG_DISABLED>;
+    };
+...
-- 
2.41.0

