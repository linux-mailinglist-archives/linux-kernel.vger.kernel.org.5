Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9364D7D1CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjJULJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJULJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:09:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13AD6B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 04:09:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32003aae100so1647144f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697886569; x=1698491369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=paUT+Q6GNehX6v7fDfPWI+N6Ji0oV3/HMQPAaX9H43AJJVz95s7Mp3LEgjlyTIg5Xm
         7sC8QuxgJVHMlLfGE0r6hstkhqzf1CzxDg52bdcll5lq9/l5JJ1D3EZAuh1uvYrYP3jw
         eJggRwui3Uhq5oyHfNtozVDhuszC0E4WAdkCQf3h12DtU5pzxvsth1M8nx3vl0BG63Ro
         wFqjcdqF1HOsjr2zv6lvOcEDoEyLHXv9h+Jpc3+rOk304HJPzseintjnCFmmDTyLxwrt
         tHFKYKF4u3umYnLhCwmkQa7VPCUkQj6iU1I18sTwcUt/lz6rEZXffnnQGpsmjilKAh9B
         yRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697886569; x=1698491369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=wlslBw34RX2aLESMGFXY+lArfkYpJXyYuuFt3SshU2L/LSYKzzGh2od/RquzpITv2Y
         bU/aHm0WBc+AKX/VBwhTS/DqW6vlJrizpEj7TYzOqmvRr7UIhCmDxBOCjVvouU0xzMoq
         QyeaJBNDu7Fzzu63JBYndu7B1zx/Rq5DrVWb+r0Ssd7mlyUNHovX0AqI8z8Iteuf5MPQ
         CcWHexDSBhgu7MUZAhxixe6OU3FoSiLHHC0tqcimu5yOOUMo/cuXoHcBXgPLMznBrsPM
         WDzn8saVIfiN0NzA2KcOvnqMzzcKsG9TQRqVZ4afRwAQAVzpofX5fmyWGKNqZXUyS21+
         KJVQ==
X-Gm-Message-State: AOJu0YwX4Eebx7dql/edDe4zs5rFc5wQ8EuQPNkPxXvxqP3naaLxl9zg
        H8eLsCXlyB9t2yh57BmRokKFgQ==
X-Google-Smtp-Source: AGHT+IGsZ7x8BHYo+vy2M0OBszvsAWMgeJXU297G/jacAZXOAy2Att3vpAYPgVUg1JHbclD7+qn9pg==
X-Received: by 2002:adf:9cc6:0:b0:31f:f8a7:a26c with SMTP id h6-20020adf9cc6000000b0031ff8a7a26cmr4516485wre.25.1697886569470;
        Sat, 21 Oct 2023 04:09:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b003232d122dbfsm3491096wrx.66.2023.10.21.04.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:09:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Sat, 21 Oct 2023 13:09:23 +0200
Subject: [PATCH v9 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231021-topic-goodix-berlin-upstream-initial-v9-1-13fb4e887156@linaro.org>
References: <20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org>
In-Reply-To: <20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlM7Fle5w7ETIsDU2BtBBNqRsY7dZHknpyKPqkeYfN
 y3rBrpqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTOxZQAKCRB33NvayMhJ0QpTEA
 DG1ymYyYLzzyNiFGF9G0idaeRqiWulzAW8bjZIq/RRXN7cKDne0zHDmUeepUq5HH0WyT3SVHed9qfI
 OJPaHN0bxzaQEcdbCVQ3YXqUBCvxXY/t+xHG84PqkCx5j9Y9SRltN0mkmoxOyjanY0vAoTUS5LteZO
 3WW5jik0T8maUUg70A84PpEDvHGDb6Q3J+glR9J9hm1cCWHQSEMYBoIWA5YnA7fLfSaFZ+vl3HTZVN
 miHYcrbItBataHoKL+N50LnS9mvwpnvGKgQRz5lNZ95tHBM04zAX6t7FaMZUNp9mMXJkcP6FRpHR6z
 MAUakjSuXDKzm1Uroc8oKNdqHvEF6V/QxqJtJYvtr92JeGBH+mQ6S0ZdnZJuPx86Ign9xeYQ+vyKT8
 UW/XnGSO248gdh4CFGWT0xhgZA35H/AnMMu48KuSqdbk0GEepQkQw0S5+6Ag7YUshISOCHicgyQ7JX
 4cNJFXuTO16M+bsk1OuIdg63nc4H6abcgEcAYbgcCqjcRGujBBEc+MAluWowZsdCW9pp4zjlD5okgy
 IyyjG2yDOW8qdYeK8KzgyPjM5og7CAY+KocVl/tS2fnjZJZU4Bb4WFRgqRDpU24c/hf2caK6dwb0HY
 EPRNcyyhjyNa3BkC5PaAfsvoTOLCk1Jz4UHiCe040lRl0zjSODirs89JBDng==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

