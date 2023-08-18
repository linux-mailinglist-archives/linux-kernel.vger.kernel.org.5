Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4578123E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379167AbjHRRmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379166AbjHRRmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:42:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDB2102;
        Fri, 18 Aug 2023 10:42:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9da57da6bso129651a34.0;
        Fri, 18 Aug 2023 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692380529; x=1692985329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=frFXT81oGoBe4H5BDwWZvVTpyZiYUlOIV08g1D7uaJk=;
        b=eWM3jABeaceXy7eeqdwQmcdNjnFbRODXiCCHn4CiRyC+kOQbip4zIH3Ia+5sQ6TJRI
         6SvJ04pT7wtSieQ7N20Rl67wCKDXJ07efPHWIT9XK57j3FQyC/W7lHLZ2gWIGgf34l3q
         Rzah95wA1KPOdpffx/F9fqO19oQvgdB7BXkfRu22LVWmf1FzeLbhzauHuqn8UKuEmMDI
         lnzzOD+ifK66BaOu3nxeuGbAz2rbNvxxXmHud6IholTdE6Y50RTUiYARNf39YfY22zsY
         LAamDqZc8OY+1BTwt42RnmWyimhMmUVYQ6148e15GZT6Pv6uUlpw4XuHl5K26ZJf5Q8C
         LTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380529; x=1692985329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frFXT81oGoBe4H5BDwWZvVTpyZiYUlOIV08g1D7uaJk=;
        b=RKJmQVL+5yPMfzuWPhlQ7juzY0jh5SxBCGNt2UrEmPozOo6HmSiFDYJbiwaf4Oucqy
         h2vpFetcL7dY6pVBToioQI3v/tVF8tsqVFcv7h4A6t78+yMuv2BofDm+aTh7HMWq9mP1
         LKqRjQy5i4j4kB/sIfUMqiw2vX/tjVY0vaxBQOel9ME9vMfGnXjHFReBoEBfQ5Qv9sIw
         uJo4+U+vZqrJjbOT8w/lTBrgsDyPRqok5C3/xGoyCwOIBkwkU1dQO0md9XBVIVpZRqP8
         u3zqjy1DiDVXYJxeijodm32ZzWJVWu84mut9WSRbicg9L86bn+McDEtwtSjQgh2QP3An
         v+Rw==
X-Gm-Message-State: AOJu0YyJ5GYXXlv0o8NHKs5qWL2hTV2IA9xYvHRvbKqA/OtODkXoLI1x
        wALLaJMjJmG9dqrN6WvytPEOrGKxFyA=
X-Google-Smtp-Source: AGHT+IG0eGe4e0bLkal0BTcVcZDNAZikYQTpXD5zLK+Kp/HH0k7ofdZPzuCzMibDXZXPVmmHNYofxg==
X-Received: by 2002:a05:6830:6e17:b0:6bc:ff9d:bc9 with SMTP id ec23-20020a0568306e1700b006bcff9d0bc9mr3796312otb.3.1692380529195;
        Fri, 18 Aug 2023 10:42:09 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f36:d687:b1a7:ba34])
        by smtp.gmail.com with ESMTPSA id h20-20020a9d6f94000000b006b8a0c7e14asm1033568otq.55.2023.08.18.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:42:08 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     robh+dt@kernel.org
Cc:     giometti@enneenne.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] dt-bindings: pps: pps-gpio: Convert to yaml
Date:   Fri, 18 Aug 2023 14:41:59 -0300
Message-Id: <20230818174159.1680572-1-festevam@gmail.com>
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
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
Changes since v1:
- Pass maxItems to 'gpios' and 'echo-gpios'. (Rob)
- Pass 'type: boolean' to 'assert-falling-edge'. (Rob)
- Added Rodolfo's Acked-by tag.

 .../devicetree/bindings/pps/pps-gpio.txt      | 30 ------------
 .../devicetree/bindings/pps/pps-gpio.yaml     | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 30 deletions(-)
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
index 000000000000..fd4adfa8d2d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
@@ -0,0 +1,49 @@
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
+    maxItems: 1
+
+  echo-gpios:
+    description: The GPIO that provides the PPS ECHO signal.
+    maxItems: 1
+
+  echo-active-ms:
+    description: Duration in ms of the active portion of the echo pulse.
+
+  assert-falling-edge:
+    description: Indicates a falling edge assert, when present. Rising edge if absent.
+    type: boolean
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

