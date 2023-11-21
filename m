Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EAC7F2D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjKUMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjKUMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:36:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F512A;
        Tue, 21 Nov 2023 04:35:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ce5e65ba37so28759325ad.1;
        Tue, 21 Nov 2023 04:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700570155; x=1701174955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVHOuGYwxoI/ien1Js+ADNjcb3WBPI5CxYXxkzPCUlo=;
        b=a6KmmP9OdrIKK3rR/CY1kkomvfu79dXJMY6K/6ERD3gnXIx3W+o5OFrYEsUVN7+Bcj
         3UEHtUTLnw8ISPMKyYgKE8CI6odRjWV/XhvTDakBtd68QOZjyfB+ZFDrPkuTKyU9c9Dk
         Cy61jh7I36kA3ERmQKXIsE8XfJOwc6d19dM3gCTmONS6b6ttacL3ForcY2uF8ijdYfdc
         Nzjk3s5yOuZKnPkXjOE+zjKnU/vpkBSxOpol4XjeFD8Ws3LpvgY0vlNMx9E1Y+jw/INp
         vkLjgrXkAX+rB3XTuzyLt7lnFWjdSw91QPpVGWc7evJPur8LooEJ7bz7XQ+DS++7OJGO
         oWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700570155; x=1701174955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVHOuGYwxoI/ien1Js+ADNjcb3WBPI5CxYXxkzPCUlo=;
        b=GjIwDQN0I5DY1g2pjtAH2IpZhnJJOd/iDpojwVm4ov875XvJH2w5zcL19avXdByU4T
         g4ruUknyeNJRFw/81QF/s/L/lf6TgKiJxLlPm43ago3SmSmKiRd/4avAuPXxcLoRcUza
         1Hc4LMgam8DhB3eviYV3YbLxQ5taMRFFJgBlUN6OnfhGMdbshzbld/G/DjpiEbCKbsPW
         nwhHrZP5k8glRnZI3J+mc2BUuBQza1s4cKH2bJexYTNWmAqDcX17HeW9IejBSox+cFIS
         8hqd5SYYDtqxkWJ96oaAAwZ36d4whjkXQc+DIkUQYcXZHF/SIWTLiLxciC5M7IIaqt8T
         v1Bw==
X-Gm-Message-State: AOJu0YwAKearoa7QIECNXjSoFYWduhaY0LPN0naK/YpMpXD8r911hUXl
        1vsKaisJWnhA/htBTFxQJowVG4f9Aft2p0ST
X-Google-Smtp-Source: AGHT+IEfyBmj0fJQWwLMQun9Vu8GL+cZJg4GfHD8QDRj93peVGM3TZ0cfFQuRioVmCCdTQ+RAOYctw==
X-Received: by 2002:a17:903:32c4:b0:1cc:36fb:22ae with SMTP id i4-20020a17090332c400b001cc36fb22aemr4178526plr.2.1700570155041;
        Tue, 21 Nov 2023 04:35:55 -0800 (PST)
Received: from archlinux.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902744800b001c3f7fd1ef7sm7846614plt.12.2023.11.21.04.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:35:54 -0800 (PST)
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
Subject: [PATCH v10 1/2] dt-bindings: input: bindings for Adafruit Seesaw Gamepad
Date:   Tue, 21 Nov 2023 18:04:07 +0530
Message-ID: <20231121123409.2231115-1-anshulusr@gmail.com>
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

Changes for v10:
- Added interrupt-controller/irq.h header

v9: https://lore.kernel.org/lkml/20231121101751.2189965-1-anshulusr@gmail.com/

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
 .../input/adafruit,seesaw-gamepad.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml

diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
new file mode 100644
index 000000000000..5e86f6de6978
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
@@ -0,0 +1,63 @@
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
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

