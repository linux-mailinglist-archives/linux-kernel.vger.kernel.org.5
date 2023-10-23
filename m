Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D367D3A50
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjJWPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjJWPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:03:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC6D10D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:03:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839652b97so26477705e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698073432; x=1698678232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=ZOJLyB5IS+CDkk0RRTIsKXfEYMN0TUbjiPEmiIEZ0quOcfuzVDbOcZIJyXQWFi7lZg
         4WAJsIFPeh+OHNzRwTbpFYusSPeG6NsDUbWhTpQ3MnVWR7kRT0uM1zN4QPz0suO8bnxK
         TKTUMpiHd6UOThpTQ6hSwwtlEbqSjdyBtVEXIzRgzlQYOzZ2wzW6fUlDWmuiHtoN2zO1
         KYsDblXuLGUV/mDeS1IxOU+pHTfu2Uaud75SJRuq4jh3y6GWZtE1kI3+/4u6cL4mbrfw
         G9KyhfhEArNgW6vFBINZJgMLKzRCcb80EGSpOFsaQDZ8RTPIYx+2B7MqTT4iKiYp4Tli
         S1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073432; x=1698678232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=r1YDDrNQfSWbnwp2sWV6uDV4N3i1yiXyBRA4YuLjDgSKghqnfL+A16gduU7YbBUa6j
         Kwn6i/EKzW1PSsTNrVUF2hQzU18haa60cZ3lbRNITXgpi4q+roYVKsUqQNXFBWdN+UT+
         aQhtsmLwSjl0VW5aXtnEWnVykQ1EIcukDSQKlFhDLJUeXFRziIUhrX0uK+w5RG6OtzWR
         JtVk7CvKF7naED+Td7Yi2inQBHMqvc0cCyg2EBECsBGw0ItCbvJIznHH1RszhdUgd/kr
         EM96VVA1Df2x0zajxOlzCFQxWYnB02+q0tEJQXYgd6VfThtSFjvfTjJw98PsNtPuT2YP
         9phA==
X-Gm-Message-State: AOJu0YxRKzu4XzoEEHqoRaqz3xOAVco2SG/JJQbIJ46fAlGncVcd71pw
        XFRZB5stLANJydrdPAfx9SU5Dw==
X-Google-Smtp-Source: AGHT+IFoKTeYTjY5gQs8xHa9uIZQTN2qXidov/tizbs1eJiwrNooEEHXMfyNYJ7mC/YTwNoghy6Umw==
X-Received: by 2002:a05:600c:3147:b0:407:8e85:89ad with SMTP id h7-20020a05600c314700b004078e8589admr7109954wmo.14.1698073431528;
        Mon, 23 Oct 2023 08:03:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b0040586360a36sm14235016wmg.17.2023.10.23.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:03:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Oct 2023 17:03:45 +0200
Subject: [PATCH v10 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-topic-goodix-berlin-upstream-initial-v10-1-88eec2e51c0b@linaro.org>
References: <20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org>
In-Reply-To: <20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNotTUfBxk6lYA8BHRxiS2R3DFWaOLDk5tgLtPni1
 V+n9kCWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTaLUwAKCRB33NvayMhJ0QiJD/
 9q0UhD+HwBx45nBCMA9kvAaDudYxnH0OJZfd5jGihfK6Thgu8vFo81ohHkfJZhCo8ylBGVvceQKhhc
 KfvSiG+3x9UBjn3pOutB0VCn+VV/dpzwQmJDka1Sk4QR616lD3N+bOneZHSBnQ4hMAm6o83mS6L+k0
 AJKz43CPRqLS026t9uUbjCjFitmMKagm/t2YgaMd2UgcDSyM0IbTaES3TkbMP5BdgUmMt5fZ+q6N/e
 7mrhap7gWmQU4m/gV9BvsWr7wLftIuX5dO+1YzkOx4dQp4XuyO/U1yHGXjhHmV0nvEkq+hGPZYDIMc
 PZjNUdasWnbI/ZwRkT3HKPGiYDh9g6JxfnOis9855pLhNB8QocMbOUAxoefNsek1HUBOpQEY8p2X8y
 zQIh3iY3prZD13jmwtyQKohAD6r6fy3GgRQ/0IP73F7+L7P89nEdDmgDGYSZsMyWcK27U7+1oOW5KB
 uL/5bDb2Z4o/AP8biV2uYT3vEreWSsIndZ8jDiZPzyST+T9PCczH9bUjoxUWVjhaNLCamTxGDAgIvM
 BNan21uduuzRLQq4T8AlWIOoiEJTERk5yYGfjNWivgTNYLnEZdQocBoiDiSv58kNxOl6opdz6ZYnCE
 K2BIWEtt3fIYtjlCEyDLPcl/FcWHGMQLngG88Ej0ruiXcy/7/gCPoeu4DWQg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

