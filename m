Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34777238A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHGMPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHGMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:15:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9D95;
        Mon,  7 Aug 2023 05:15:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso70091361fa.3;
        Mon, 07 Aug 2023 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691410505; x=1692015305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKePUWsqqPfdyKnC+nOZ4wJ8jqFpMDU8BF27PxoqbU0=;
        b=nn/v1ffZy6I2WKHKTqe3ekcuVHAg6+sC+A+r1Qr2bAjuxI+cdSe7i4tybkRHG2t/J5
         Y4qeH08exJLdyJfet9zh8kSFluNGP6K/IQ134xLklqENF757SAPsFUPc06hdXDVK0g2B
         fXEZUTflA8AxKcvWi9grzz0eBQNm3ahOubHKsW/eqtgh7SYzEDD7PsVSAW5kcX/9o54c
         Uurgb1m3Ae2tIznX0DSqlLqRLDEkyaraNmsaXD24uPGIbkCu6ojJhe08zYVCSxBkqFHJ
         ZscobIKvth/rddrkm1EfqxiHmn7MAqI4e9Q9sx3cTFcwJcGVDz6Mq2fa+BiWdlGqpBsF
         8NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410505; x=1692015305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKePUWsqqPfdyKnC+nOZ4wJ8jqFpMDU8BF27PxoqbU0=;
        b=K06x86laOWr1iVhW95RMerwvsg8mQsh0S9z87S5zW383bvNpYeMnJOTAlXZtcD/Yvf
         W7zM1eGuqDc7ZFEOqgZazj7ZjrIT42X2AUEjcjH/ezAHdFGXqNWvCZsISYBws9HzJpbU
         CYusSWCSJDx5GNxyNWmFoKdjQiOpZ5F7avwrHFceeARFKlltNytjF5P7INQXjyBcHkAD
         Sts5oCi7iKzYc9gD/f9LLZlu1wMSFzZgvCSjbfWVPu44UW744plL9UB9TR7AiM4IrqLC
         9lsZMok95MRM2NTyzP71xEiXSE242knT8fODtBkL8T1ebXGQBTzjfoYU+u/0k0/Kaq3b
         7Mkw==
X-Gm-Message-State: AOJu0YzWOM9IdINCstFjzjBRu/spcbTpdAM3W+KQTMN9wHUqzyzBdBYL
        WiVP20w2ZvvnxYH2QLY8mC/tVtslkuQ=
X-Google-Smtp-Source: AGHT+IFf0qzcd8z5ADfWey3UpVtgneit/0BbLUhaxx9KIoJtbF7Oa62SuXUNgrYgyHGV6sWYFrUlDw==
X-Received: by 2002:a19:5007:0:b0:4fb:821e:2241 with SMTP id e7-20020a195007000000b004fb821e2241mr5279043lfb.23.1691410504848;
        Mon, 07 Aug 2023 05:15:04 -0700 (PDT)
Received: from localhost.localdomain (mm-94-245-57-86.leased.line.mgts.by. [86.57.245.94])
        by smtp.gmail.com with ESMTPSA id g20-20020a19ee14000000b004fe3212fefcsm1477868lfb.282.2023.08.07.05.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:15:04 -0700 (PDT)
From:   Viktar Simanenka <viteosen@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Viktar Simanenka <viteosen@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2 RESEND] dt-bindings: display: add bindings for pcd8544 displays
Date:   Mon,  7 Aug 2023 15:10:21 +0300
Message-Id: <20230807121022.1871-1-viteosen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add device tree binding documentation for PCD8544 LCD display controller.

Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4:remove reference to panel/panel-common.yaml
add optional backlight property
v3 link: https://lore.kernel.org/linux-devicetree/20230720124026.356603-1-viteosen@gmail.com/
 .../bindings/display/nxp,pcd8544.yaml         | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/nxp,pcd8544.yaml

diff --git a/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml b/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml
new file mode 100644
index 000000000000..236eb4f4b3a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/nxp,pcd8544.yaml
@@ -0,0 +1,100 @@
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
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcd8544
+
+  dc-gpios:
+    maxItems: 1
+    description: Data/Command selection pin (D/CX).
+
+  reset-gpios:
+    maxItems: 1
+    description: Display Reset pin (RST).
+
+  backlight:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle of the backlight device. The display may have an LED pin that
+      controls the backlight through GPIO or PWM.
+
+  nxp,inverted:
+    type: boolean
+    description: Display color inversion.
+
+  nxp,voltage-op:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 127
+    description: |
+      Liquid crystall voltage operation coefficient. Determines the LCD
+      controlling voltage on display segments. Should be adjusted according
+      to the ambient temperature. Adjusts the contrast of the display.
+
+  nxp,temperature-coeff:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: |
+      Display temperature compensation coefficient. Increases LCD controlling
+      voltage at lower temperatures to maintain optimum contrast.
+
+  nxp,bias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: |
+      Display bias system coefficient. Should only be changed if an external
+      oscillator is used for the display.
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

