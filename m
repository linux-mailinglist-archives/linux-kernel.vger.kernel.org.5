Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFECC76B48A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjHAMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjHAMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:15:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24619BE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:15:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so60478485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690892151; x=1691496951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=g2KQPtx4Xd82H3N2fIZOqy2rUkIn/LolrIz8REKpuV+6Vk/F1TGjjaqzXHa/1JJj4J
         /Z2cQOuS3OuuA1UdMWZADI5zHzub1n/4r49SjHce1S/0bzw1nIosWDJWnbEJARzswPDp
         PM5651LhXcfGajsZcwdkbSXYzSP0Az920pZ1hf5GEBFOBW8vJc+JPPLTrBiRSDwEsB42
         GWuGOj2bQpraEqyb2NykVy7ri0MBmAgk2xQhbG4v/z3lX4tI4dHz6f9MJ9ketf2FxxII
         QS6w21fu30jVXEy5oGIBlMiwJkJAkI+U3QZtEQMNDClOtGlAwSx32uM31iKFFKxWKNmV
         COjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892151; x=1691496951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=Thz7lnoMVeGeAAzVbuNB49IrWwUdqyM4aLbTWAbu/qLVwDK2/g28Z/Wive8cXBav0b
         6x6VDo49pfbf1vCp9nBYfT/8PIY8jfWSvz/eWa2TdJ1QStan5AjfqNT4MA8j8A7BPrwn
         JBdX4AdM5tmIhER47twGUP5APRWiZFsp3i0TKx1RT2UvXfPUdp1HCH1iaaqhJTwZwoUc
         6QzmLetPtbPGUV7CArsHsTNwNBolc5jLTNzTwDY7hng8S3o/buQNom8Obba/+k6o/Efu
         /WbbrgY4Q0wS/aAaVOJLqysZ/8vU/dRhsftV82sEFEoH8yoAQvskggt2d/83IrXbp+BW
         1MRA==
X-Gm-Message-State: ABy/qLaPKTXtXdEoV0gRQvEpxZQjQHBfbVshB6yym2ZeLLpxT/MRExb5
        MlIuFrivDa/FFX87Tt6U4rpXPQ==
X-Google-Smtp-Source: APBJJlGEK6KPfVRRz5/S4ExVZKF0lz2WUiK6wZWcoP+xbNYp1TTwGOkapL3mOmkiiNbYySpib3dGNg==
X-Received: by 2002:a5d:4010:0:b0:317:a423:40e1 with SMTP id n16-20020a5d4010000000b00317a42340e1mr2416486wrp.55.1690892151596;
        Tue, 01 Aug 2023 05:15:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm15874351wrq.115.2023.08.01.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:15:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 01 Aug 2023 14:15:45 +0200
Subject: [PATCH v5 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-topic-goodix-berlin-upstream-initial-v5-1-079252935593@linaro.org>
References: <20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org>
In-Reply-To: <20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sfk9uxvNPIwk9f8d5iBn9m2N4nTZgMQFpRmAil1gnVU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkyPdzc0rAXaXPqjctjYDPdX6blxowU5JuGy/cQjfk
 yZawQ+mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMj3cwAKCRB33NvayMhJ0SpyEA
 CYdKB4u1FyyfwPp4KkOve1o1P8x8DjA+0DdjLOgeQLmfUWdFaCkb5+7YOjlUBALTzEKc0qhfv8Ac4p
 SsJLUyRw2wgIrpbaAgysRa4QIdNVMUqX3KKIpWTwCXUSoi0iIBWyXdqYeLgGr0rVYjtiJ9fo6XRFuY
 n2Zvx/YErKvrx3OGgM0a9KbzM5yJ+AM8U+uZ52SMkgbogmwhWglruwqj2R+NVLr8XHCxqT56uG4kNU
 oXRv4+YUiQ9ef2celfNb812ycbIPjj+gW4+Gy7zi/jfe6hlYk8vndOgj7WyKZgx7ZZZUjcXxZ/J85B
 Y/VuUDEKruLM7ce8H3+BR+VO6mIAu0Zz5nZCAK1aK4+MeuOOia502QjKqn3S3rImjtydXcVvpFzS1r
 dES/SOeUVW2HL7SHjcoqoBai6+UPkGG5HQ9BX+zaBZgZBk+I42k1uRvvgfKuay9oWWBjHfaRZqp66r
 24c7USPC5c4Q9kO0ZM5tJ8yDEu3UwXCiRJVk42eMgoHcm53du22GYludf0wQvaA9DImYZJMP0Vy2VQ
 IAL/tUfwefuGirCQ6EvCFzlmeuxg5WJVSr1YpXJyESRROkZMdPLxqsV3JAabT1bNXJuQpo6aluW+2F
 SOwHOwn6ovGNIun6n+Mzz3r/7z3VQ0GhyIELbRSd+hiWS4+Vb/REerFW+J6g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Goodix GT9916 wich is part of the "Berlin" serie
of Touchscreen controllers IC from Goodix.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/input/touchscreen/goodix,gt9916.yaml  | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
new file mode 100644
index 000000000000..d90f045ac06c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/goodix,gt9916.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix Berlin series touchscreen controller
+
+description: The Goodix Berlin series of touchscreen controllers
+  be connected to either I2C or SPI buses.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - goodix,gt9916
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply regulator on AVDD pin
+
+  vddio-supply:
+    description: power supply regulator on VDDIO pin
+
+  spi-max-frequency: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@5d {
+        compatible = "goodix,gt9916";
+        reg = <0x5d>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      num-cs = <1>;
+      cs-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+      touchscreen@0 {
+        compatible = "goodix,gt9916";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        spi-max-frequency = <1000000>;
+        touchscreen-size-x = <1024>;
+        touchscreen-size-y = <768>;
+      };
+    };
+
+...

-- 
2.34.1

