Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC79F759A15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGSPpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGSPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:45:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED0197;
        Wed, 19 Jul 2023 08:45:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso11813749e87.0;
        Wed, 19 Jul 2023 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689781513; x=1692373513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eSE5PufSbPTUsRNAeK5Nlopm2AA9GyCjqeYSlulI3A=;
        b=LjbyP/phFapwDihnGcU1TM699njxE3gU8W+o6nuquMg3Gbinz8PMCvZ991U+T5gGu9
         k2kBhGtMNu1UDFS2did5j0QH85W2M6GlP/ThTq2CtBK0G9WpV5lPqKk9bhgrraUxsdYq
         TS7VuYxJ5M5VN7f0+5Ou9BFeH6kTpOeh6Fdp0iMxOGpoZaWxL98PH6+ryUWTmh++3ojt
         D1NEpzN0hIN5c1bywouCwx04dsUG/BF/xAmOHJh9nDMvuv738Deu9SjQVh02rxOfm4fq
         880YeCCR8fAf8c3ry+X+YYaR+EN2cwIO5xcY+jtiyyw7KcxOHeLD2fpwsy1rPtFpLWAC
         OE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781513; x=1692373513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eSE5PufSbPTUsRNAeK5Nlopm2AA9GyCjqeYSlulI3A=;
        b=UVU7h61pwHW9MruKuD7bA9BjUL4UiCOyxib6kPUG36t2ncPNG7+W8e0n5SKBV3uvBU
         rP2bMqBGt/IsfO0s0jvGoFoErLORjAHzBB4Pm8AtKz7AVYSM/ZKnm7+BXw4JTzbRY0iW
         pTgsmC+dguH8INMXIGaCXAr+mChzjny6SdUgENuAIvNYbMpZIWvxDY/OUWnUtI69U+G7
         YZB3X9NtQ1FNMGiFitsCU4p4uLZpakGgMX0/RsCeu38wckGs1l6Ca0hkRv/yribqbRV0
         rnCA2lY8uz4iyFuKZlgrmRstE8EdbBM/GPtdk7cw0XBu51yBnEl58or8kN1ToiacXJF2
         7bZA==
X-Gm-Message-State: ABy/qLaJwf+BsdTcGI+61HhQCh1sR6+6CnZlrjnStiy7upuec/Rx0cDL
        M7cISZkoKEXE1mAtLkNeAdU=
X-Google-Smtp-Source: APBJJlFGNXbDbnAA9ArUgh05ey8iUBjzciSFQItiJjzD0Vsx2FKi172A3dqMVfN9FdeSK2KtTt+9Yg==
X-Received: by 2002:a05:6512:36c5:b0:4f8:6d53:a692 with SMTP id e5-20020a05651236c500b004f86d53a692mr154702lfs.61.1689781512689;
        Wed, 19 Jul 2023 08:45:12 -0700 (PDT)
Received: from localhost.localdomain ([86.57.157.184])
        by smtp.gmail.com with ESMTPSA id v19-20020ac25593000000b004fb78959218sm996075lfg.200.2023.07.19.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:45:12 -0700 (PDT)
From:   Viktar Simanenka <viteosen@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Viktar Simanenka <viteosen@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: add bindings for pcd8544 displays
Date:   Wed, 19 Jul 2023 18:44:49 +0300
Message-Id: <20230719154450.620410-1-viteosen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Viktar Simanenka <viteosen@gmail.com>

V2: deleted oneOf property from compatible
changed prefix from 'philips' to existing vendor prefix 'nxp'
placed `reg = <0>` right after `compatible`

About parameters exposed for controller:
inverted - I had an unbranded display that after reset had all pixels black,
while register was in 'normal operation'. The display I have now is opposite:
all white after reset in normal mode. This parameter should help user keep
same settings in KMS(?) for diverse displays;
voltage-op & temperature-coeff - adjusts contrast for display. voltage-op
cannot be expressed in real units, because resulting equation looks like
V = a + Vop * b, where a and b varies with ambient temperature. Vop is a
coefficient. same story for temperature-coeff - it shifts resulting voltage
curve depending on display usage invironment;
bias - relates to waveforms for LCD segments. default is 4 and should be
changed only if you use external oscillator for display.

v1 link: https://lore.kernel.org/linux-devicetree/20230719092903.316452-1-viteosen@gmail.com/

---
 .../bindings/display/nxp,pcd8544.yaml         | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/nxp,pcd8544.yaml

diff --git a/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml b/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml
new file mode 100644
index 000000000000..52e40fd0eacb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/nxp,pcd8544.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Philips Semiconductors PCD8544 LCD Display Controller
+
+maintainers:
+  - Viktar Simanenka <viteosen@gmail.com>
+
+description: |
+  Philips Semiconductors PCD8544 LCD Display Controller with SPI control bus.
+  Designed to drive a graphic display of 48 rows and 84 columns,
+  such as Nokia 5110/3310 LCDs.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcd8544
+
+  dc-gpios:
+    maxItems: 1
+    description: Data/Command selection pin (D/CX)
+
+  reset-gpios:
+    maxItems: 1
+    description: Display Reset pin (RST)
+
+  nxp,inverted:
+    type: boolean
+    description: Display color inversion
+
+  nxp,voltage-op:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 127
+    description: |
+      Liquid crystall voltage operation coefficient. Determines the LCD
+      controlling voltage on the display segments. Should be adjusted
+      depending on the ambient temperature.
+
+  nxp,temperature-coeff:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: |
+      Display temperature compensation coefficient. Increases LCD
+      controlling voltage at lower temperatures to maintain optimum
+      contrast.
+
+  nxp,bias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: Display bias system coefficient.
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "nxp,pcd8544";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+
+            dc-gpios = <&pio 0 3 GPIO_ACTIVE_HIGH>; /* DC=PA3 */
+            reset-gpios = <&pio 0 1 GPIO_ACTIVE_HIGH>; /* RESET=PA1 */
+            backlight = <&backlight>;
+
+            nxp,inverted;
+            nxp,voltage-op = <0>;
+            nxp,bias = <4>;
+            nxp,temperature-coeff = <0>;
+        };
+    };
+
+...
-- 
2.34.1

