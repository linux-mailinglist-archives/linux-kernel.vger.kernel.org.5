Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8074779CA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjILIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjILIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:44:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D170AE6F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:44:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401187f8071so33882505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694508253; x=1695113053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=hKsSACdhMAZZFbvvLcUkjD1hjy6DI4AZ4Ar1p+7Te/QzFJOtpnQIKPH0908158/2eX
         CS7NXjclogpi29V/ax2DyU+0js4HLhqkTlHecyEPmXwhY3V++ClFJshr78+0cEhHdnot
         G0uq4AzuMvkZ62YAhO5D0+YSpGRAvyOWf43Ugb5NGSlI1yMcCDr986DyNQbeamXabSkO
         ySA3dhQLL4W56r2N/XKfujCWcMCDdI7GKu146JQHF6ycgAbubBqXhFKtWxKOlTAjn4oI
         47KlizxFY+CPJMC7uyOjHkwGjaw3yxm125HO9McXLnKcBVZzAQiHrmBhgB+I7LNg26r3
         wOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508253; x=1695113053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=YEtjci3HtgvSNc4KuKl4H62Wjb7qt9YSpcduM2FW8tTmIE7q+nAyYxrkJeTsEeQ2VF
         RDaXVylaoZQPu7qpoQerqvXcK0TM/fAxxYDp+2yfVeLquU/ghMDkTzXY+PLNWi8kayLB
         nB/Vy6sl9BRywYClIIFf+VT0lI6ok37Fmazia3qBK8kQG2ruA92pS63Lh/o57fa+5XCL
         AeMuhSb25SIAHru4h2Ae1lEGxgWOC7jQJYb89uM/0DXdul/r+jNydKeVo2OWDxjbEYc7
         ZvHvNQcLGBwDqKgugrHtmKTEOpMmlQwOWnlpYOyacukMoDc6sII+OqRLh7ga7pRi8AH8
         DLKw==
X-Gm-Message-State: AOJu0YzQs3QHNXio2M5biQrLCnmRnVtRiBh3PJbNF0LSrMW3MfxiNUED
        uSwhf1fyivLOJ2DBTvUg5nT2mQ==
X-Google-Smtp-Source: AGHT+IEt3NzgR+P5uYbaM/5eng8KvYHQpso+avyYdGvBdraio2F1z6boIZWwbLo+1u0+aq0x+XcMFQ==
X-Received: by 2002:a05:600c:20cb:b0:402:f91e:df80 with SMTP id y11-20020a05600c20cb00b00402f91edf80mr1166516wmm.3.1694508253230;
        Tue, 12 Sep 2023 01:44:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c7-20020a7bc847000000b003fe2bea77ccsm12301348wml.5.2023.09.12.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:44:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 12 Sep 2023 10:44:07 +0200
Subject: [PATCH v6 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-goodix-berlin-upstream-initial-v6-1-b4ecfa49fb9d@linaro.org>
References: <20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org>
In-Reply-To: <20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sfk9uxvNPIwk9f8d5iBn9m2N4nTZgMQFpRmAil1gnVU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlACTZ6grE0hkz9CI0cvJQs2LwXa4Ntq2TSut9gBxo
 nOnhEwKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZQAk2QAKCRB33NvayMhJ0VUdD/
 43fvSCO4mbhlP4fu2iZ0BaxMgBifTC0iz2aXidR+tEAjM/F8EywPDQ63GWFxy01zQyo0qJMOWXi7qm
 cbRj6RKgmH1XNpIZ6sfOM3Oeiir8jnPFxGfOE90WRntF4sXszQg2aTmsfsN/Z1Dt421BY6WP5YWwAg
 n1QQ6X08FhciuCg3NpTZBsjiq5ogV6RP1Vz5l0LdD16lhzzS/zaHFcV+iHFxC8yXfB/dGGN1qDgk9f
 K0JR84xiMmUMi2BIKmhaOxZgNfSlKn25hS3JOwn/uYsQmNMGTzMyFuSurlsRjv6drFF+JafrW2oKJr
 7Myo5zptzQZmCMz+eUrcWyCPXf7KDd4OcyDLu/tweuYmRD8/QccSCFzVKUEfDb4coCpVrOVf0B7715
 +YfzijhTCe1FZpZWjvG25SI2gKlAfzu25DTytXZ0h7T6l/z+xHhTbLziSCYWFL2jUwIwYQtEMmxDQx
 HGvZ/AKPnxdIhqse2ZyVvi0Bn0pJwc9uAr+gLczz+p+wXXDhw4+PQGodNceqTNVF73K5fI5eycVyvU
 kXIDCmXTdW1bCaKH+vHpGKoQKpOKhHypiamRUvZ8T6MJ6IZKyoxDJQa6kaiI3HAcYuhKTHSSzj8eVW
 crv1d+vMIHV06GgystTyQzTB2q1/DY11Anngf+1iNUWwAA0RbgfMnVXSqzqw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

