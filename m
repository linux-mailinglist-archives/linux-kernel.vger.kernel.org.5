Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C97E1C57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjKFIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjKFIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:34:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75FD4C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:34:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40806e4106dso24815775e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259641; x=1699864441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=EifMfDWGLfmvhxW303ApSFWk6FNqHN5+bzCaFjwrdtZ0JaKvlQiKxvUX0h2S0iw/a+
         E9SEvnW3aY9GZtfLVjR9ZaSzCk5G1Nrc7Hd88rQjzaXycClejrd6myVtJPpsg/o1KlUz
         A5bYcQO/02pPWJywg6zn+1cGtVJasoizxmbYzYP7/Xu+0Kmti6uCQvROMziEY0OyrC3C
         QuTSjmIH9HR5EE/yD9A0b3D4vbCMg6PhcovtRWfd6iw3Z3Y9ql/ACD4qc9ughzhtiw+E
         qEkMXs/L1NKdEp3FKrUsaBFk4YAqOUnY49SO5uBbHimpVBkOWSj41uNmM37NxK7FCLIl
         A9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259641; x=1699864441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=wILiEewtL5Nwiggba7A5ghc1dm+yNvjkCSI9gJI+0KOcPq6TXsfbQr4898Oq1BxO0P
         T9Gip8pM+PkUHzQk1Hm3Tpl6laeBBMAN29SLWNIXNgMm1Q5xgZn5gmGUDz9ltZyXvXiK
         3Jx9AM8lpbtVwutVtsAZg/u/HoS64se88fQQpx2UR2zE9c4byd/zsX72n3/iStnMql3O
         ojWkwy+jD6TTc7vqW3vVcsXct5c4llpupVfprpaDRxenM6MQdWrbmDBSoWJPnAIAWLIi
         A8BVGE0w+bSJR1fsOlLqAyIOULy3R6ZUxQB31hdESm4hq1c617WldLNygGgPhwSRNUYd
         A5GQ==
X-Gm-Message-State: AOJu0YzGmc8hBQBk7lBKmjJ+61+s9Jl55mDR7Zo1Tg5nTd6Rrg7nzhP5
        Q2HpZBYVrNHlLFRDtlX6ACNKuw==
X-Google-Smtp-Source: AGHT+IF1lIvUnDu4ryB7v1WnbFD2iFOhMO+MpX4NuYm+pN4GRFwFu2Rykf5XDHYpKYGHg/33gMkSwg==
X-Received: by 2002:a05:600c:3b14:b0:405:3f06:d2ef with SMTP id m20-20020a05600c3b1400b004053f06d2efmr10335512wms.4.1699259640971;
        Mon, 06 Nov 2023 00:34:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q24-20020a7bce98000000b0040648217f4fsm11132991wmj.39.2023.11.06.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:34:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:33:56 +0100
Subject: [PATCH v11 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-goodix-berlin-upstream-initial-v11-1-5c47e9707c03@linaro.org>
References: <20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org>
In-Reply-To: <20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sfk9uxvNPIwk9f8d5iBn9m2N4nTZgMQFpRmAil1gnVU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKT0fNTCUzanqriHuEA5SmSalaSvfvYk/BWuQMbO
 rZo+49uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUik9AAKCRB33NvayMhJ0VWTD/
 4uuraJ0vtjWd9ZAkmH1J1mSbuUK1CmLr3JV9RSzdxBib1OI++2Ut3X8SLdKcz3Qxa2JxTsaSdIBNyl
 Fl6Go+7OC3tMqh/kO0DclKx7GlCqq6jg8JiKJXwyFvX0WndMDe1tRFVkDEibmpOT5DsOHR39s16QHB
 uQYt7DeMolyw8iOa2Z+XNA7YP34TmYMFx9bJDe8IHjByy5FjtkGmaL4Leyw6yhlcnahSritfjqUkef
 Gsm7XVOl9xEtEv9NccN74gwOuaPI9lg9tVdu4TFAnUblIx8sjSv+WkGjd/+JImVphmQIxgnBa409+m
 pCl7+9DlNZJGb7fgUFHIipv+WLtBuQwJ7ZxENTi7szCNMEUAHuuqsa0XBgFN0aasdG7nNmqYcoH9IG
 alochTBY3ImFqnbU2krvA7Htt0VzX7Ez3Vsv7Whc8A168uQJuwoqBxz8OsQKSRLJGmCqBj/dmeSUPH
 suygHLZJ2JODuop7+YJWMA2jNL6LlfGwN09WqqeJpNGN6tHW76bXG0A4+KrkJgM46bP9CqaytUiDWM
 QRM9jKwy+QswXT+nvzAdtfIsW/P55NeLs45j3+tNEIn33LsYlCiH7LWKPBZ4edL//vLiIq2UX6rsNu
 0s7ve8iJOKDn3gVpFlG3E+95zpYXHL8XJambhHeIg5mMOjrs8DM+HKs4DrBA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

