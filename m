Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAD7592E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGSK0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGSKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:25:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE12706;
        Wed, 19 Jul 2023 03:24:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fba86f069bso11026477e87.3;
        Wed, 19 Jul 2023 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689762298; x=1692354298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzwI5VxEU3KMLKWKNIn2pwe7xkF7bK6X8n8zVQIr7Rg=;
        b=lLD7U78AvsWpQsA+ih7cP/XCaGmPFltne9MPqtHTzBQS+p3YpOfOb9o4wKgs/xstYd
         DEIg6DYTG6baWnMkZPF19uln0GPiAVPkMQd0xcJcHl0QTVOWWnzywdJ3+LxBPTdWiigC
         ja1haPZz7EVoWCD2gFGraRpHUOu5lEdVfMlxn7Mos+CMef5YpI6S5+JjiXn9n5bHvLME
         mFv3WPXKBN9SVVF38NgWnlciFJebgjOOztwxf/BVNOnPimAJcUEmO6yrgGLmvEIDgfvd
         bR/umRb2gHL+l7Ap2BhLXQxestuKJ2HmgK4Z/qqAqQQ8usmCkTtrlhDelbTpaw9zG0nV
         8bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762298; x=1692354298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzwI5VxEU3KMLKWKNIn2pwe7xkF7bK6X8n8zVQIr7Rg=;
        b=VcGPWrEvumrDkKA5ptprOCYnr1YZ0r/ReFstjjga/NuxV+GYCFuEp2U7uUcPXrF4tb
         dffDaxOYEqA2CoqqPyBRIQJrvEaneHYVy46cptWHMhG8K/ivC7cNt9Dts7y5bSiSyA9r
         aPGLpoE3KjdjfEabYpJmM4F39fUEDGG4KA7owUeWGU+us22kMCNILHc9cTgmnSkx2aaG
         Ghz0JRGgJFPxLeOb3QN7pISj6OZbnMnOnmaJdiRFRAO7DoXF6Pmx+wo+4jPj5O9Zbd+y
         ewsyoPoqUh87jUErKrmk0QO/shF4Pn4n/iuGmjilZtBaoNXbSrTWsLGf6B+8luCqcafu
         ZSMw==
X-Gm-Message-State: ABy/qLZ4qaxXmFepzAAZZmHcw7H0fOAIgV73tpNiXGBxo9X6tfEnCOO4
        MMiGzMsLyI0azz4wrwnPmlU=
X-Google-Smtp-Source: APBJJlGhm6Wd3ZSuA/ojzZSkRjGMNdf9Nw27UIw1oSG2HZPZKShGd2lhnbkd3lqo9fy+Xwkkw6MuAg==
X-Received: by 2002:ac2:46f7:0:b0:4fb:c67e:b067 with SMTP id q23-20020ac246f7000000b004fbc67eb067mr1296369lfo.66.1689762297723;
        Wed, 19 Jul 2023 03:24:57 -0700 (PDT)
Received: from localhost.localdomain (mm-94-245-57-86.leased.line.mgts.by. [86.57.245.94])
        by smtp.gmail.com with ESMTPSA id q11-20020a19a40b000000b004fa4323ec97sm887786lfc.301.2023.07.19.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 03:24:57 -0700 (PDT)
From:   Viktar Simanenka <viteosen@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Viktar Simanenka <viteosen@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: add vendor-prefixes and bindings for pcd8544 displays
Date:   Wed, 19 Jul 2023 13:24:29 +0300
Message-Id: <20230719102430.316504-1-viteosen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
---
 .../bindings/display/philips,pcd8544.yaml     | 89 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/philips,pcd8544.yaml

diff --git a/Documentation/devicetree/bindings/display/philips,pcd8544.yaml b/Documentation/devicetree/bindings/display/philips,pcd8544.yaml
new file mode 100644
index 000000000000..ac880d9d8cc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/philips,pcd8544.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/philips,pcd8544.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Philips PCD8544 LCD Display Controller
+
+maintainers:
+  - Viktar Simanenka <viteosen@gmail.com>
+
+description: |
+  Philips PCD8544 LCD Display Controller with SPI control bus.
+  Monochrome 84x48 LCD displays, such as Nokia 5110/3310 LCDs.
+  May contain backlight LED.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - philips,pcd8544
+
+  dc-gpios:
+    maxItems: 1
+    description: Data/Command selection pin (D/CX)
+
+  reset-gpios:
+    maxItems: 1
+    description: Display Reset pin (RST)
+
+  philips,inverted:
+    type: boolean
+    description: Display color inversion
+
+  philips,voltage-op:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 127
+    description: Display liquid crystal operation voltage
+
+  philips,bias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: Display bias voltage system value
+
+  philips,temperature-coeff:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: Display temperature compensation coefficient
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
+            compatible = "philips,pcd8544";
+            spi-max-frequency = <8000000>;
+            reg = <0>;
+
+            dc-gpios = <&pio 0 3 GPIO_ACTIVE_HIGH>; /* DC=PA3 */
+            reset-gpios = <&pio 0 1 GPIO_ACTIVE_HIGH>; /* RESET=PA1 */
+            backlight = <&backlight>;
+
+            philips,inverted;
+            philips,voltage-op = <0>;
+            philips,bias = <4>;
+            philips,temperature-coeff = <0>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..0c3844af6776 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1037,6 +1037,8 @@ patternProperties:
     description: Pervasive Displays, Inc.
   "^phicomm,.*":
     description: PHICOMM Co., Ltd.
+  "^philips,.*":
+    description: Koninklijke Philips N.V.
   "^phytec,.*":
     description: PHYTEC Messtechnik GmbH
   "^picochip,.*":
-- 
2.34.1

