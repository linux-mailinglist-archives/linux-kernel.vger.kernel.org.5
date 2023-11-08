Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3977E4E49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjKHAzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjKHAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:55:19 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A256101;
        Tue,  7 Nov 2023 16:55:17 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso3832419fac.2;
        Tue, 07 Nov 2023 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699404916; x=1700009716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBwW2x1NB7Zv9x5MLA+XOPhgMD9GcocogtWLN68fSio=;
        b=Eyc6avEOE2FESibg5nhpnjZNU6MnmZSS+TtAaU0d+lRFR1wUi6xfDFUH7JhYdnrQhD
         q27cs3wtxmsQ+Y1oNjdeLvdr+XpYa84uIwFpT29lmqaUHu0aatXXbkcKskAoWlnolgbR
         vGXI8BmQCZcLAasyDCgrwhk6m051KKWZNqpnOwe0y6LaTxVtr1DaqIh5GnmxwVyaY/8V
         e/jEwOndMLbjUoz/V5EWBiSwTb5WsSO1mwboSqxQsUmAZJqVaUQtQg/EOQ0bl2YoTJAp
         uuhhMtQme5GWxg28TNkDKQjq80XKnUIIYj/b4b14KtKtiEFLPwa2hm0CnS0PVXONzoje
         TUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699404916; x=1700009716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBwW2x1NB7Zv9x5MLA+XOPhgMD9GcocogtWLN68fSio=;
        b=KlX9OzcpolACkkiE437Kq6lAVq9BQK+uFHcK0Vxlvq1t6BzcG8rnofOQ8rICnFv+r9
         MWKizeChzMEd5iuGx9eMEmDT3yQ1wGSYmUdVvdWqqgxBwaW1tXUemZhd+glbk6D/LLqM
         q3UtyoEjFySnzCD5zGUnjuK3qxsG89QkfHzhs4DwQ9soBv6y4VeX8E910EViJ8CuMuQK
         1OgPbCEAaXa5MdEr3mJnKGSPt7/Y3UOEXnlvKcuTWotSzTURBNwpoEx4cYE3Ej7sjgpt
         RaeNlF57KxE+Icpje87lkcmbhUJ5Oi1CT+AyTGcenLPkfvDJmehYBXu3mrO/WlxccU+i
         ky0Q==
X-Gm-Message-State: AOJu0Yz7ch7wMN0Il2kVGDoD5uN4fI1hRI5cE65Pj36IP0AOn5XYesL7
        HTIFwbYOQSLlJ8pvg2WcBG06fGFpJveWcO7U
X-Google-Smtp-Source: AGHT+IEEZT9EznDaRpIPe/oGe4godmJbxmua7mNLjGmR//N7q4uG+t9wAoPFiZH0Md3h2/YhHGGvhg==
X-Received: by 2002:a05:6870:2188:b0:1e9:9179:4c6f with SMTP id l8-20020a056870218800b001e991794c6fmr366225oae.49.1699404915998;
        Tue, 07 Nov 2023 16:55:15 -0800 (PST)
Received: from archlinux.srmu.edu.in ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id g5-20020a631105000000b005bd11296584sm1939468pgl.53.2023.11.07.16.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 16:55:15 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Conor Dooley" <conor.dooley@microchip.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Jeff LaBundy" <jeff@labundy.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v8 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date:   Wed,  8 Nov 2023 06:23:35 +0530
Message-ID: <20231108005337.45069-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds bindings for the Adafruit Seesaw Gamepad.

The gamepad functions as an i2c device with the default address of 0x50
and has an IRQ pin that can be enabled in the driver to allow for a rising
edge trigger on each button press or joystick movement.

Product page:
  https://www.adafruit.com/product/5743
Arduino driver:
  https://github.com/adafruit/Adafruit_Seesaw

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v8:
- no updates

Changes for v7:
- no updates

Changes for v6:
- no updates

Changes for v5:
- Added link to the datasheet

Changes for v4:
- Fixed the URI for the id field
- Added `interrupts` property

Changes for v3:
- Updated id field to reflect updated file name from previous version
- Added `reg` property

Changes for v2:
- Renamed file to `adafruit,seesaw-gamepad.yaml`
- Removed quotes for `$id` and `$schema`
- Removed "Bindings for" from the description
- Changed node name to the generic name "joystick"
- Changed compatible to 'adafruit,seesaw-gamepad' instead of
  'adafruit,seesaw_gamepad'
---
 .../input/adafruit,seesaw-gamepad.yaml        | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml

diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
new file mode 100644
index 000000000000..3f0d1c5a3b9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/adafruit,seesaw-gamepad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Adafruit Mini I2C Gamepad with seesaw
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+description: |
+  Adafruit Mini I2C Gamepad
+
+    +-----------------------------+
+    |   ___                       |
+    |  /   \               (X)    |
+    | |  S  |  __   __  (Y)   (A) |
+    |  \___/  |ST| |SE|    (B)    |
+    |                             |
+    +-----------------------------+
+
+  S -> 10-bit percision bidirectional analog joystick
+  ST -> Start
+  SE -> Select
+  X, A, B, Y -> Digital action buttons
+
+  Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
+  Product page: https://www.adafruit.com/product/5743
+  Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw
+
+properties:
+  compatible:
+    const: adafruit,seesaw-gamepad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      The gamepad's IRQ pin triggers a rising edge if interrupts are enabled.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        joystick@50 {
+            compatible = "adafruit,seesaw-gamepad";
+            reg = <0x50>;
+        };
+    };
-- 
2.42.0

