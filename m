Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0A7C7286
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379520AbjJLQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347163AbjJLQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:29:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712AFA9;
        Thu, 12 Oct 2023 09:29:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso9702925ad.3;
        Thu, 12 Oct 2023 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128141; x=1697732941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpenc3TC1wxTiSmB6vD1Cx4tRH9i7lUBaz0u5rLStfY=;
        b=eYdN0SOKdzSYfnVLup0EWHcWxlXi+6TP6ygo0yAQkgCOcXr/sg9YEPK2jRTJTh9SEN
         ZyCkKLgh8kyAaMJI6RYeZ4P/gop7Dp/D4ib9nJ9OQIYIl8tIn9Xtj+LnNJlGKmZyYL3z
         gJbxo5lLDnN6cnUJxD8ize3EbdBPbva0lMmWE8VfNNOwzeRcJ2f8cFhZgy0llBsiOpwc
         lBAV0h1hgx1/WFTjL+tYcaoX+gi3dzQtJUyPxqlMJuIGtouJbQ5cT0EZ4ZzACc3s/4Jk
         WuaRYY10A+bS5canucz/Ms28kad3onE+LvKEQPsbd4FPELZd7D0yJONY+S7J04Ezl04i
         CTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128141; x=1697732941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpenc3TC1wxTiSmB6vD1Cx4tRH9i7lUBaz0u5rLStfY=;
        b=Z7c24/DvQCQL4bg0myiPQermFCg4SJmZbFJzEwrRpt72vitg7ZdSuyUcIKzdQCEgnE
         eJLMZymMUe1E0brR0zjKo8TR+0TOwZ1U71vdmWNdBxcWqCk1DdHCBQEWy3dYRxTK1x4E
         FjYoR8cVQeWfuzlej+LsrYMwuDklsge11IffM1E5d/vgdWzB0PNCwAoGlyjtTX5rZfXQ
         ezBrZS5dhC1RaJ/gs7pxWuL7xYgUJJ6OgTvDtP3hXVknoht982W1VE5+UA43TiBNOotZ
         Z41asGGY6c/G6ckspAMgZhmwNyTnaDz916VODkwZFpkS7ich+IbN1i1sfAyP6o4ZFhof
         +YUw==
X-Gm-Message-State: AOJu0YzCaLt4ucWpWeyjV9nTghWC75NkATcqX+uei/FwvADGPPDtizbh
        B52a/civNIdhUH9dhSRfGAejLaOuC2lIu77C
X-Google-Smtp-Source: AGHT+IFkWga7vo54OSr36L35yv47ognTjOFByF3OqK3ls8hf+tjE4WBSr1/XuS8nDNuwW3ZC7sFLJA==
X-Received: by 2002:a17:902:8f8b:b0:1c1:eb8b:79a6 with SMTP id z11-20020a1709028f8b00b001c1eb8b79a6mr21673887plo.24.1697128140627;
        Thu, 12 Oct 2023 09:29:00 -0700 (PDT)
Received: from localhost.localdomain ([49.37.136.12])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001bb9f104328sm2181575plg.146.2023.10.12.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:29:00 -0700 (PDT)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date:   Thu, 12 Oct 2023 21:57:55 +0530
Message-ID: <20231012162759.691555-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

