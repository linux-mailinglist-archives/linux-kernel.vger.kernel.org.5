Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B94811A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjLMRNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjLMRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:13:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAB106
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:13:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso73741405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702487602; x=1703092402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=vRf3GCAmd+2vsajOLfAobRT+HWtWdv+hzJNN85w4SlVSwkTshej+VkKMBeWv+acXml
         C9XpuvlgS++/L5bfwGASViy5FYv1NfwwFsWi7g6zGYnHFnascWiKlpZLFvrvfvzyjjSl
         QBidhyT7ChrPhfMvmAilBGRxXxoZGnIZQ1Y2QfMUkIVF8YcQUiun4vNkyc5y8OAYkymu
         XyIQCxgiSIk9Z3zADaN5XdBCErAQTpG8XgjlqB5SCpSMTJAZNIanKVUnn3LhJxad3YGB
         tQOsDVeltktB1Ya6sYdrm0pN+maEkahjfBCQ0JkxCXTp0vV2WYphhtKsQdxNblZcJnsx
         NgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487602; x=1703092402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=HeEmWDGEiC6PlWLs85L/aKcFLxDBRRu3Yru3G1kY6K35J5A0LzlF10LFceLSz3kgNf
         YipDZcKyow0sjTsKxdkJKmyFWxXyBryy/MoJpLz6MzLv7rjIiL8lKY5LP1Qf3YwOBXAA
         Z1NTDlFnud7KNa4EHsZK9SbYtY9VHQYtlon0E7T1XHgLJTaa35ImXdglYMyW36xpuR6c
         U/WGK9UhKAoXzPBZh3NH87SbjIHcU6XweJYN9TfRuRcywEYROTDl8gfT5wmhEU6FHi+t
         3Gslg7Fszy3CPrNzkTk/ICMmcOz4xeSMab4RA+gG2mRGgXy2dbkDZBaO1N8mYxVbJyGS
         w6iw==
X-Gm-Message-State: AOJu0Yxv0izcuLD6UphS+C8lHkgOlxRQ6J7i4AH1DBZy8ZwgFm08MwX8
        T7vNc720PUI4W/v7atlrntKDFA==
X-Google-Smtp-Source: AGHT+IFNxRWuoyoMH99OVMds74dBq0nzs3ZGX6y7FzWzIYWb39Co8GjVY1K8MQjTbIB5l3gmiCGrGQ==
X-Received: by 2002:a05:600c:21c7:b0:40b:5e59:c56d with SMTP id x7-20020a05600c21c700b0040b5e59c56dmr3995877wmj.151.1702487601882;
        Wed, 13 Dec 2023 09:13:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fs27-20020a05600c3f9b00b0040b36050f1bsm20711039wmb.44.2023.12.13.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:13:21 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 13 Dec 2023 18:13:15 +0100
Subject: [PATCH v13 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-topic-goodix-berlin-upstream-initial-v13-1-5d7a26a5eaa2@linaro.org>
References: <20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org>
In-Reply-To: <20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sfk9uxvNPIwk9f8d5iBn9m2N4nTZgMQFpRmAil1gnVU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleeYtdo3/RXb6z9No87q/nEif3kzQeQmpKl3o0czv
 dBOjeaaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXnmLQAKCRB33NvayMhJ0SNFD/
 4mDZ9YQJBUetNhtMkQ1OwNW2iiRHIva7gDQ0eXvOZSnejUXC0krLIS2/LeWhzWbgjY8RS4jZ8fxlVY
 ufvtpjrC0RYSBsVLNYROB5TTFMakp0b5PplncZuFOL6xD9kFT5nhHJVxglIPWi9afFHobmgAzoq/1A
 5Z3ypeh15eXYfAVzxqlZR9zaIDnWQFqa0Tzox9+GGYYt53E3uPGmNznsXREthx+25Fxf0eHnd243JR
 cvAEN/pyI7OCvFm5JVLQY8vGV4ZU5V0jR7dC72WMwF8XU4mu0B3Z3CpMN8tNts5h9DXkhZTk31mBzb
 7bLNaY2fKrFS4rEXSyd7x6fliIRRPpzfRMMfwBewO7Lx1VdHHxQdpf0T6HXF9rB662/kigJb/f3fkH
 Qj/1I43y4JiNGxiSq0DG7q7dGeQdbtX4xcD1hWgrf6s5gonieDKyN6juaYdd4RLNCFEbx4NDigu1Hx
 RngW8T/ecjZCJcVknWc9gR26O5tNWvm55qolQDHLp/+kZW6XCnEDsGZIa4/i4gjyURcLoQyvCC6rJ9
 zCmuGWNc/9nUc7n0Q5wXpvsJYEPk418VjICddEJFaXub1uTHUkAUAB96xzM4UHMUi/3e5rq8BVpkqU
 poiSSwbPPwLJP6BiXxyNKNjNIqbJS5ngAmUz1CBAtsiHaYTQsdx9f6xiaBtA==
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

