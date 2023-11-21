Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63B7F2A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjKUKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjKUKbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:31:39 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C2B1BB;
        Tue, 21 Nov 2023 02:21:41 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b3e13fc1f7so3517231b6e.0;
        Tue, 21 Nov 2023 02:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700562100; x=1701166900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9i/Xx6cWAF0VcdPrFkUZoAivNKzRZ6xEFa30biSsbo=;
        b=hNcw7/lhRt8kjjQsXMd6NQsc79WlvjTuHrua5LmM+nY4mkbld3YsnyQ0zppz2uGvLr
         uo7Sua5al51WjOYD9r7zgQM8486NU9z1It5HSie5e0tmUSQ/au1B+4WE/20/VpHgeyB6
         JKYAZCPdGtYwH33b4EQrnwNOfKzhCPvCaoZjQxkFF3eFGMpBkHZmG0bjR+zWUQ4xeepC
         +7UKyO3NcE4E2ex4SxgPmOslViLbk5g3215valtEsWibxI/fx2i8PodoY5YTBXTiFXlJ
         3MvyKgHj97efBhVHndpB10BihwJ0wdDD0PHRBuhzIOn3KPVPPKVEYBzh+LRmFJGSNQpo
         9Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700562100; x=1701166900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9i/Xx6cWAF0VcdPrFkUZoAivNKzRZ6xEFa30biSsbo=;
        b=Tq0hGQK8BMYytfaTHpVScSt9/L5NnT/Z48jxs/X7Tv60ZKxypgWyjBjAMr/4J1pQYn
         seTPP2XaOJqv0sz8Xji7Jij/6Y6Ifyy38R/3jW7TjO+iHLaJ4nx24iPpq2zCaaXmYYMj
         pcJOF5uZbsh6FyOm9izkHCFfDUL0GyALvu/R168gwwyu0Kkb5KUG0HmXQoxt4AqKGX7b
         /UdsC9ursMbpkn5y/60GFg66zvCFLArYAsF/UdBWtK1mKDtI0wflYLbM68gnTGgS3u00
         YCg3mlg7CgH07pFfXicjUsIrra4FCPHQMczoCh7LzVWLIFSfAS16eEsb4WjbPYOYQc8S
         Sjvg==
X-Gm-Message-State: AOJu0YzzEDbdJ12lhA/qDNTHFnbWHNKulmrTkKWN1+JpN0udQJF2nI/Y
        rP8Gk3apF1JKNTSfnvf+UjqmE8oBPG8cid+u
X-Google-Smtp-Source: AGHT+IGVaUz452Nk5uw6WVVZGoUWyhMLV0E6SX8yvPNM7DWZ8Q+OGDfQYIel9HvM7y1KFEajgrhZag==
X-Received: by 2002:a05:6808:23cd:b0:3ad:aee1:1b3e with SMTP id bq13-20020a05680823cd00b003adaee11b3emr14494020oib.8.1700562100653;
        Tue, 21 Nov 2023 02:21:40 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id c10-20020a631c4a000000b005b82611378bsm7451502pgm.52.2023.11.21.02.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:21:40 -0800 (PST)
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
Subject: [PATCH v9 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date:   Tue, 21 Nov 2023 15:47:48 +0530
Message-ID: <20231121101751.2189965-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes for v9:
- Added interrupt in example

v8: https://lore.kernel.org/lkml/20231108005337.45069-1-anshulusr@gmail.com/

Changes for v8:
- no updates

v7: https://lore.kernel.org/lkml/20231106164134.114668-1-anshulusr@gmail.com/

Changes for v7:
- no updates

v6: https://lore.kernel.org/lkml/20231027051819.81333-1-anshulusr@gmail.com/

Changes for v6:
- no updates

v5: https://lore.kernel.org/lkml/20231017034356.1436677-1-anshulusr@gmail.com/

Changes for v5:
- Added link to the datasheet

v4: https://lore.kernel.org/lkml/20231010184827.1213507-1-anshulusr@gmail.com/

Changes for v4:
- Fixed the URI for the id field
- Added `interrupts` property

v3: https://lore.kernel.org/linux-input/20231008185709.2448423-1-anshulusr@gmail.com/

Changes for v3:
- Updated id field to reflect updated file name from previous version
- Added `reg` property

v2: https://lore.kernel.org/linux-input/20231008172435.2391009-1-anshulusr@gmail.com/

Changes for v2:
- Renamed file to `adafruit,seesaw-gamepad.yaml`
- Removed quotes for `$id` and `$schema`
- Removed "Bindings for" from the description
- Changed node name to the generic name "joystick"
- Changed compatible to 'adafruit,seesaw-gamepad' instead of
  'adafruit,seesaw_gamepad'

v1: https://lore.kernel.org/linux-input/20231007144052.1535417-1-anshulusr@gmail.com/
---
 .../input/adafruit,seesaw-gamepad.yaml        | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml

diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
new file mode 100644
index 000000000000..0f17e110f368
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
@@ -0,0 +1,61 @@
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
+  S -> 10-bit precision bidirectional analog joystick
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
+            interrupts = <18 IRQ_TYPE_EDGE_RISING>;
+            reg = <0x50>;
+        };
+    };
-- 
2.42.1

