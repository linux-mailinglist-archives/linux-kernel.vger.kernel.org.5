Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8BC7C03B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjJJSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjJJSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:50:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC193;
        Tue, 10 Oct 2023 11:49:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9b1e3a809so8336925ad.2;
        Tue, 10 Oct 2023 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696963797; x=1697568597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3r/GV/XLucgebya1CEWK14+Mj9aJsAwuJyhcB53lBRU=;
        b=YVVvScDh+6mt/HY+bR7McCHcAk9xuOoEOrP0WPZArvqxjDJAGJxMttm2qypMy0PcFb
         5dhy5C6f6mrrQ72iX4MVXKJ002Dk/BA+U1LshuO3VQYuykB42vExt7u+uPqU3/Fhx9A9
         DhE96l2906Dks0D2BiNNmoD52afkKgOtg8FCPIKsPvzjkNndRNUWlyFAEI8OoeMXbz1/
         JSbr0e4t/dzFBOa32FuWdjI5TWgRsW8wAKLpzvm1dWvQzK1W7aUiXe0RUECKVvKilD6+
         ZtsQD5cXtC1UOWmGwFxtEK3BEm90MxHtexct7XvIlXagTi04ey28n2bO5dpi41LqIRju
         LFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963797; x=1697568597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3r/GV/XLucgebya1CEWK14+Mj9aJsAwuJyhcB53lBRU=;
        b=vGJmaQfv3EyZQgENpbXgO5TOLZV8E5szaGI94OqsZkmqZzCwfvvZIoJPicwcRRBvFl
         RBB/HZjzch4hscOPl7HkVcyhMT6lamKKQBIcB+DHT6CNgXc15/QtUiqygnU+NrST7xCv
         jbNxss/Uz8hD8ieBA7r/kbfyzaiOQytDK7Y24KShCAfSiyn9TIJ/nXELSq8wgKHA0rJx
         rz5A3CkkMW5BS08t2FwrR7+6rYI6lyur0MAkBWojF/DfGsipd8CVFC8kFquypaeDQ4/f
         Ihm10mQoDl4BXUU7iisCjOguNC2ayo+MJEZRGkFfV1YCBTukiN05m+xM5VQsUUQ76AQt
         iHEw==
X-Gm-Message-State: AOJu0YwvIrkij8NKEE7de8k/ZuektxHkBktAPnQBq65/ICJO2zIH57fb
        J8HXz9VALaeQ6NB3ABIUFDEfpvTRYjAaXx8nRuE=
X-Google-Smtp-Source: AGHT+IHeml2e2h+flm0b4gyQ9W87X8pjvLvYttiBiveqrYZq/41IZBUYmoWCmUJ30hLtemH9Eam+2w==
X-Received: by 2002:a17:902:8e87:b0:1b8:2ba0:c9c0 with SMTP id bg7-20020a1709028e8700b001b82ba0c9c0mr15123695plb.59.1696963797436;
        Tue, 10 Oct 2023 11:49:57 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:629e:4cec:991b:26e5:7c89:9a07])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b001bc87e6e26bsm12147570plg.222.2023.10.10.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:49:57 -0700 (PDT)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date:   Wed, 11 Oct 2023 00:18:23 +0530
Message-ID: <20231010184827.1213507-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

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

 .../input/adafruit,seesaw-gamepad.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml

diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
new file mode 100644
index 000000000000..e8e676006d2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
@@ -0,0 +1,59 @@
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

