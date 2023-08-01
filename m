Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01876BF6C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjHAVnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjHAVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:43:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082C1FDA;
        Tue,  1 Aug 2023 14:43:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso2757314f8f.1;
        Tue, 01 Aug 2023 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690926200; x=1691531000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ptisAxebow9uOm2s7VOrkfI5czz0rYnxrxEnVycD1E=;
        b=rpeHpj8jkihFpBrbMKKdgF9fAH2g49kz+Yolz8n9KmLqQ6cGPTtKIhTp5IAcWKp1r4
         JeP4X/00l8eKFYxvpavij4p58v5sDYdTDjxm6dPELJKJZnDs1sSZ0ODLe1RVa1q3pna3
         N+RLlNjoc4a2o8+guoKVcDJk11IVa0jEguaHZu8x5T09C7KaTRwZP2vEhUtfNqAxzgnt
         4oChVv/RHYTYgMfSHJrnF67hB4zxcStld5/QCaLPrERZcDyuUOeu3dWQlktGKK8GTvW+
         E/DMq0HcwFh/amWUUzGlElUqpaZ0z2HtFoC0k9q82iFNSiiZDxUw49kZgKH+25vBYcgx
         EqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690926200; x=1691531000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ptisAxebow9uOm2s7VOrkfI5czz0rYnxrxEnVycD1E=;
        b=N6W+ixv6TIxWZ/yafq9iXiSmRhdBOun6eHAqxO9/CyHmqvATPVMpfz0Ych40bW44bR
         ldzbRDk5zS5eXK+u9kS+sxwd8/Mo3uC1jF21j0yXHqnVVN10a6Ua1jUIBukIMXrtxctq
         iYwZcA2s6LJxmtEtS7Rdf66h/jbNLIU0//v2XvKRQW0qbwj/2JqvYI8MIY/U142FdAA6
         gq7bHBl8B6WTFxOSFxtXbqgKD8IdnzLys6kEcrlbcRvexX4cj0BSlByfpzhAzSWltXHE
         d6K+pZmLO/bJcejq21G83znjAPZ4PLB+KzipeMbCKm0hiMg8/P0BnoRm4uKKbq7RUEZm
         Pt8g==
X-Gm-Message-State: ABy/qLY7j2OvFEw3LdPovUsXh6cydgu5yBAXG0owoo2iamay6xRI12WX
        tyKd52K+/9wT9BdATrRVej8=
X-Google-Smtp-Source: APBJJlHmcp2zhL4aOFVsgqn+7zNqgzXWObWeOzXTdlEriW8Ej0ZxCfrSDvo3faa4PpskDMjUtJpLcw==
X-Received: by 2002:adf:f74e:0:b0:314:46af:e1e7 with SMTP id z14-20020adff74e000000b0031446afe1e7mr3624085wrp.34.1690926200414;
        Tue, 01 Aug 2023 14:43:20 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:2bb:9098:9156:9ead])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm17221221wrm.3.2023.08.01.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 14:43:20 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: irqchip: convert st,stih407-irq-syscfg to DT schema
Date:   Tue,  1 Aug 2023 23:46:51 +0200
Message-ID: <20230801214651.27418-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert deprecated format to DT schema format.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 .../st,sti-irq-syscfg.txt                     | 30 ---------
 .../st,stih407-irq-syscfg.yaml                | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 30 deletions(-)
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
index 000000000000..fce18d444c56
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
@@ -0,0 +1,67 @@
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
+  Configuration registers.  This driver is used to unmask them prior to use.
+
+properties:
+  compatible:
+    const: st,stih407-irq-syscfg
+
+  st,syscfg:
+    description: Phandle to Cortex-A9 IRQ system config registers
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+  st,irq-device:
+    description: Array of IRQs to enable.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    items:
+      - description: Enable the IRQ of the channel one.
+      - description: Enable the IRQ of the channel two.
+
+  st,fiq-device:
+    description: Array of FIQs to enable.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    items:
+      - description: Enable the IRQ of the channel one.
+      - description: Enable the IRQ of the channel two.
+
+  st,invert-ext:
+    description: External IRQs can be inverted at will. This property inverts
+      these IRQs using bitwise logic.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum:
+      - ST_IRQ_SYSCFG_EXT_1_INV
+      - ST_IRQ_SYSCFG_EXT_2_INV
+      - ST_IRQ_SYSCFG_EXT_3_INV
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

