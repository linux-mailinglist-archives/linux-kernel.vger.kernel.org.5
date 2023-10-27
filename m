Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0D7D8E12
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjJ0FTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0FTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:19:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B5A1A7;
        Thu, 26 Oct 2023 22:19:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so1348398a12.1;
        Thu, 26 Oct 2023 22:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698383987; x=1698988787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fA+Tv1bE2U9KWCqAA1m16+V2i4hhY6QGRQgT7CJSbXI=;
        b=XRJPZBLNZQTXvoBFoI7FQqfcPzVf1aChI1eqqG+QssCA5c5js263PAD17TMQOBrYSV
         fya9//DegWgifaboghh1qqJZYSuPkYxCXN7CFfhSsXMgeQHwJ5VIGxHE5KkE3UiA2CRu
         PRBQnanJr+ygWFucaSpY06y8CoNk6kPr6iIR/FP8P4H++JjaMXFpOPo23X0dLfWg9lrw
         k/w/uS++vCDeMnE1g+3F/MySNQSJmnQIz5Qhn+m8LqDz+mZ0YUP+yiH6FGVeQvR30b1Y
         om+aSsNJAgt+Ap7TsKAeRbvHwu4J+J5S5guiYPvNBurRfKxnHFXqGjb2U30QRTc7pAhA
         JdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698383987; x=1698988787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fA+Tv1bE2U9KWCqAA1m16+V2i4hhY6QGRQgT7CJSbXI=;
        b=S9tWOR70/Mas4aBvxRfAzQhk2oXWIRP8HfzYNjHuq5lTgCQz/TV3yVxF/zJpEqOMFL
         mlocXPU2vEUJ5qN2sPSU+WVgiEoKoG4fby4UHpI2ZzBvVCPCw2r7zxYvhhCDVRDlb09L
         EgFXB665MLESBz2cPIJdfKUVbCP4zPkZ/rGuo5V3796k+9i+k7QyP5iZuBw0hlv93+7H
         vJKcsA9T4LVd5aEI0P+gUa+8+fYMsLtkYGW5aOKaPQ7118SgW1tBZYSBTkJPF+HyVZYL
         aEYpEBJu41IucF+GdPKmEBVVoqY3ikFnzC8ggW+aL5WMl2P42z5C351AbTY+q2QSOLZn
         LdTg==
X-Gm-Message-State: AOJu0Ywvwy0cEcunJbYcV7jrxbqNhlJog9EVH3wuQ233oGEAYxPzIj70
        H5VvY//GOOT+IoTcIe6GtagcLdgyFxoNxyNI
X-Google-Smtp-Source: AGHT+IFvz/xV6lMfHz3vDz/j1mVa+ah0INFY3WvFerJgzjK4K0wG5CL9dE6a9/0sZ3STEpSy22cvrA==
X-Received: by 2002:a17:90a:c215:b0:27d:491d:2e40 with SMTP id e21-20020a17090ac21500b0027d491d2e40mr1456057pjt.22.1698383987087;
        Thu, 26 Oct 2023 22:19:47 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:6286:35cd:e1b0:b6b4:69e:b5fb])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090adb9000b00276e8e4f1fbsm2494296pjv.1.2023.10.26.22.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 22:19:46 -0700 (PDT)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jeff LaBundy <jeff@labundy.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date:   Fri, 27 Oct 2023 10:48:10 +0530
Message-ID: <20231027051819.81333-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
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

