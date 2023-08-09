Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57642775A70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjHILIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjHILIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:08:24 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C088DED;
        Wed,  9 Aug 2023 04:08:23 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-563393b63dbso1026406eaf.1;
        Wed, 09 Aug 2023 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691579303; x=1692184103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYFU+JWeZ+yWYoi2UmtBxXHBh0Cp9KdbrDyGhS8cH2E=;
        b=lNwN9wRbMI2UGV0V+vNG+3YiwwqXQbqnUpyOXoKYhHUq8F3xRvZPowLib7vACsz77Y
         lfyhIYgYZ1XPgzCR4pZx9v7/h47qGNHqLPr5KeMnd9XrGQp4kW3ysC0KzOiIziihM5gD
         5FlNV+N5d4WO3BKTEJXZgkbCmDaOo/MJ0WRqK3yNm1GBCBSm92We6h8zEWmJBbaewBFI
         HH1lNvXapxDoSl9kHCVM/CRYELSLYPqdjkjsPHfGit0maoahKXZ6oqk8HiOw1tb/wIVb
         ENOby2+KeIq90lzBO3T9tVio3q6WeLr8i0OwGbaWPpT6Pg8qbncPhBoabRSAe9WJKdKA
         oCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691579303; x=1692184103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYFU+JWeZ+yWYoi2UmtBxXHBh0Cp9KdbrDyGhS8cH2E=;
        b=hF7rc93b5+ZB8RJzcxKaJGRi83ZDT4NCpW4ItYm19R2sOAIAEAkEsxHXaSJjeEoEhI
         IE6do5kk/PNf75qvuypZZjnHvdh+DoLel6vgmHTO/Nqmf/dXX9qV5H6tpDiBowEDxYGS
         cT4I8n50s/ra4ox/JKI58mIySUytVdvk/jRwfE5lPL1f/7+HEZ9ORcqzWFLYbkRsmKyr
         /sM6h/Ag13R+yfzYVkIxM/zWTHJLwj5DyLovE8cj4Zjl0O3h3BsKS237kRHnd6dq3Z+U
         Q1G0EgpobZZUU0Sq4YaOR0PLoncFw+5JQN6qLKTo9VDQx50Fln5j45HLSA2so1pQoppk
         gi+Q==
X-Gm-Message-State: AOJu0YyGhJlIPlTLx+3Q6Kh50pFz/VL6gpRjZrR2OLK2TCObx+R0Kgpo
        9FvMUmGu1r/S3kpdmgJtrR8=
X-Google-Smtp-Source: AGHT+IHAEJfAqNRzKyv/6f2BxXsgNN9JO/p92gRF+Ox8iBNkqKuCbX0NHRdNVg0S5CohquPyUOKcRw==
X-Received: by 2002:a4a:a64a:0:b0:56c:484a:923d with SMTP id j10-20020a4aa64a000000b0056c484a923dmr2209591oom.1.1691579302936;
        Wed, 09 Aug 2023 04:08:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9f74:900a:da2a:e14e])
        by smtp.gmail.com with ESMTPSA id x17-20020a4a4111000000b0056d2dde4cb7sm6834658ooa.0.2023.08.09.04.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:08:22 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     giometti@enneenne.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: pps: pps-gpio: Convert to yaml
Date:   Wed,  9 Aug 2023 08:08:12 -0300
Message-Id: <20230809110812.2058428-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Convert from pps-gpio.txt to pps-gpio.yaml to allow schema validation.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../devicetree/bindings/pps/pps-gpio.txt      | 30 ------------
 .../devicetree/bindings/pps/pps-gpio.yaml     | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.yaml

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
deleted file mode 100644
index 9012a2a02e14..000000000000
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Device-Tree Bindings for a PPS Signal on GPIO
-
-These properties describe a PPS (pulse-per-second) signal connected to
-a GPIO pin.
-
-Required properties:
-- compatible: should be "pps-gpio"
-- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
-
-Additional required properties for the PPS ECHO functionality:
-- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
-- echo-active-ms: duration in ms of the active portion of the echo pulse
-
-Optional properties:
-- assert-falling-edge: when present, assert is indicated by a falling edge
-                       (instead of by a rising edge)
-
-Example:
-	pps {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pps>;
-
-		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
-		assert-falling-edge;
-
-		echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
-		echo-active-ms = <100>;
-
-		compatible = "pps-gpio";
-	};
diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.yaml b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
new file mode 100644
index 000000000000..801fd2720080
--- /dev/null
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pps/pps-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PPS Signal via GPIO
+
+maintainers:
+  - Fabio Estevam <festevam@gmail.com>
+
+properties:
+  compatible:
+    const: pps-gpio
+
+  gpios:
+    description: The GPIO that provides the PPS signal.
+
+  echo-gpios:
+    description: The GPIO that provides the PPS ECHO signal.
+
+  echo-active-ms:
+    description: Duration in ms of the active portion of the echo pulse.
+
+  assert-falling-edge:
+    description: Indicates a falling edge assert, when present. Rising edge if absent.
+
+required:
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/gpio/gpio.h>
+
+      pps {
+          compatible = "pps-gpio";
+          pinctrl-names = "default";
+          pinctrl-0 = <&pinctrl_pps>;
+          gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+          assert-falling-edge;
+          echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+          echo-active-ms = <100>;
+      };
-- 
2.34.1

