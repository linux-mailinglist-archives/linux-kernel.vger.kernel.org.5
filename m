Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35A97E4F79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbjKHDaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbjKHD37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:29:59 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E210FC;
        Tue,  7 Nov 2023 19:29:57 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6b44befac59so273307b3a.0;
        Tue, 07 Nov 2023 19:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699414197; x=1700018997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T4iCnxkiZ/SMsg0Y/BS/6F5TpeSE2Kxr8J84ltCywo=;
        b=W9BmafPu6pCEthiDHnihCl3GsmZow+U8fnhhXaFp7mT0S4prH4Qte/6usrR3ZD9GjY
         9v1Jy7BL9oOAtsJVkc7qhJBlS0ClfHiuXkC7TX0Ts9BcQcSjafoMRAAHuwpQgGDUM74v
         CpYWBFEpOQ0m43L9Zw/lZNLhNpyIJlvr4C/6ycKdyqrvpOU7kqaTaPBSRBIgi9+q9pn2
         ouKgj/99FtPjbSOk2DrJ5jC5Wrh7dH4s7YBotJVwBcrQnOKFZTymwusFghG6QdrUdukV
         YYBGdkeSYcdYz21JEWOPZRUSMktpv6ypMVPDKzcHtR6TQxHk1yVaPDNDiTH3BwefHGSe
         dcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699414197; x=1700018997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T4iCnxkiZ/SMsg0Y/BS/6F5TpeSE2Kxr8J84ltCywo=;
        b=eevDW23Dig/DqqdO5vrfnEnrmEN2urXEyYg9S02FnMWDb2mOOJ1awfYS9QsuPgZEfv
         9oOZpthoUmwO+28dC3g0TRJ8Q/UD8bO1YwV+r4EDcmSnik7PPY/UMnv6vab1VkWlYLqg
         NJ8dpYal0zbaWPFHdq6rYLYwMoXhZGKw6kGUi9ueOgsy0S+NnGWKzFDUEF4Fb/rZQn9v
         kuaBgH8BrjK0ZEY3UFUuY1mm17lEtkA6O6YJXpydfSXiMlSCBLw/Rk27Z6iFy35/RWJ1
         qTolq1CraLN7jhGebcHgbxbUTzPAPe1GD732oG0Xhqyt0XfxDdYWXNXAAzAL4WSY82JF
         FI6g==
X-Gm-Message-State: AOJu0Yxf0JvciY1zaJ5lWKpzaVaekGT49ZgjRhJxuuqyMH+UWGZso/Yb
        CDumfBZ1nWuLNYBlmP1Difk=
X-Google-Smtp-Source: AGHT+IEIbOtVFuN6QkODRaiBuBKuoIrWVj1FNhSExT1xy3xjcIowEJHHSKysm6vqN74XNX2LDSaTEw==
X-Received: by 2002:a05:6a20:a127:b0:159:c07d:66f0 with SMTP id q39-20020a056a20a12700b00159c07d66f0mr1112196pzk.6.1699414197028;
        Tue, 07 Nov 2023 19:29:57 -0800 (PST)
Received: from localhost ([115.192.116.120])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b006be5e537b6csm7960768pfn.63.2023.11.07.19.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 19:29:56 -0800 (PST)
From:   Yuxi Wang <wyx137120466@gmail.com>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wyx137120466@gmail.com, Yuxi.Wang@monolithicpower.com
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Date:   Wed,  8 Nov 2023 11:29:20 +0800
Message-Id: <20231108032921.3134115-2-wyx137120466@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108032921.3134115-1-wyx137120466@gmail.com>
References: <20231108032921.3134115-1-wyx137120466@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document mps mp3326 LED driver devicetree bindings.

Signed-off-by: Yuxi Wang <wyx137120466@gmail.com>
---
 .../devicetree/bindings/leds/leds-mp3326.yaml | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-mp3326.yaml b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
new file mode 100644
index 000000000000..899cf568f647
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mps,mp3326.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MPS MP3326 RGB/White LED Driver
+
+maintainers:
+  - Yuxi Wang <wyx137120466@gmail.com>
+
+description: |
+  The MP3326 is a RGB/White LED driver with I2C interface.
+
+  For more product information please see the link below:
+  https://www.monolithicpower.com/en/products/mp3326.html
+
+properties:
+  compatible:
+    - const: mps,mp3326
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  mps,led-protect:
+    description: |
+      LED short protection threshold.
+    enum: [0, 1, 2, 3]
+
+  multi-led:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+      color:
+        description: RGB module
+        const: LED_COLOR_ID_RGB
+
+      led_r:
+        type: object
+
+        properties:
+          "#address-cells":
+            const: 1
+          "#size-cells":
+            const: 0
+          reg:
+            description: Index of the LED.
+            minimum: 1
+            maximum: 16
+          color:
+            description: Red.
+            const: LED_COLOR_ID_RED
+          required:
+            - reg
+            - color
+
+      led_g:
+        type: object
+
+        properties:
+          "#address-cells":
+            const: 1
+          "#size-cells":
+            const: 0
+        reg:
+          description: Index of the LED.
+          minimum: 1
+          maximum: 16
+        color:
+          description: Green.
+          const: LED_COLOR_ID_GREEN
+        required:
+          - reg
+          - color
+
+      led_b:
+        type: object
+
+        properties:
+          "#address-cells":
+            const: 1
+          "#size-cells":
+            const: 0
+        reg:
+          description: Index of the LED.
+          minimum: 1
+          maximum: 16
+        color:
+          description: Blue.
+          const: LED_COLOR_ID_BLUE
+        required:
+          - reg
+          - color
+
+  patternProperties:
+    "^led@[0-3]$":
+      type: object
+
+      properties:
+        reg:
+          description: Index of the LED.
+          minimum: 1
+          maximum: 16
+
+        required:
+          - reg
+          - color
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mp3326@30 {
+            compatible = "mps,mp3326";
+            reg = <0x30>;
+            led-protect =<3>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            multi-led {
+              color = <LED_COLOR_ID_RGB>;
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              rgb_r@1 {
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  reg  = <1>;
+                  color = <LED_COLOR_ID_RED>;
+              };
+              rgb_g@2 {
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  reg = <2>;
+                  color = <LED_COLOR_ID_GREEN>;
+              };
+              rgb_b@3 {
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  reg = <3>;
+                  color = <LED_COLOR_ID_BLUE>;
+              };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mp3326@30 {
+            compatible = "mps,mp3326";
+            reg = <0x30>;
+            led-protect =<3>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            led0@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg= <5>;
+                color = <LED_COLOR_ID_WHITE>;
+            };
+        };
+    };
+
+...
-- 
2.25.1

