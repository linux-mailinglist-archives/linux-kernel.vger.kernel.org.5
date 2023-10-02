Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51537B4BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjJBGy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJBGy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:54:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A4C9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:54:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50433d8385cso24254963e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696229691; x=1696834491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=dt6Vd9nG9qDpW941cQjAwAeGjdz9yy6LtWIW2GaGjvNHkQeZNCO388x9EvAfqIeeQw
         FagqXGsoT1RVFgC4OHK59GhIeQXSTps8UFHxKUObP8q1g1M/NTTiHMxRMUbY7jyyySYy
         ok1XeuaeB1SRg5A9bx6RDv75VMAA5A9CNTRh7+427TCi7Q6AYhRQq2rxKdt7cT8j37cz
         FDfzd8KjQ3rkH3qjwtIj7knBmzHO87Dsiy2ofMciKju8Iqmo0WHYJxc+2xxGW640Rcdb
         NJS4hlqdF3D8x8NYwzeASN61/SqgxfmfSASVQtJ2tr/AEc2yGHRAyF07Ciqiws8vHNyu
         2CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229691; x=1696834491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=PD+ta+N4T0TUdzt4liBFBZanjQQ+K5u6R0G7p8oS9aHUuET/CcNNHvqhIvc7NXM5qn
         tD+PLHWxmFCdCNFheHLf8HhlXROGoR6jT7yZ8wheflXgIs1EsZK77uZq315iAsc6smjV
         tlso3U2ImEn6OC/U+CQ7ApgVBKoVqw+WXRKaHugNLtDSzK2GWf+r73zt2ww7P6i1c77E
         Fghok3wxZ02yqatVhif5kpqtW83eORR0o6PMeqahe7bSij1+IjomG3rXeJ48PjKxiqA+
         flm9St6+4GW2/4G8dYTLhzl2IACCdl12XlFm7RKot1dZyzyCs1VUU/PA/RySV6I09dsX
         4c4w==
X-Gm-Message-State: AOJu0Yx8s0sUgibUQemU2JXfZ6FtKlhUOWQa68TQm1yCYMbKWVCwBDUc
        CW307Qi0C/4NsjrdQUnc1u1xBw==
X-Google-Smtp-Source: AGHT+IEB/6yhlrtSiuh3BEfXS5SQRnF/Cus7pirew9hsEmjkW7xyyvqXhVR3x9+ZBqt50WJd+KjsaQ==
X-Received: by 2002:a19:7b03:0:b0:503:294d:78b with SMTP id w3-20020a197b03000000b00503294d078bmr7626208lfc.46.1696229690977;
        Sun, 01 Oct 2023 23:54:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b004063cced50bsm6601815wmi.23.2023.10.01.23.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 23:54:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 02 Oct 2023 08:54:44 +0200
Subject: [PATCH v7 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-topic-goodix-berlin-upstream-initial-v7-1-792fb91f5e88@linaro.org>
References: <20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org>
In-Reply-To: <20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlGmk3U3UsAa1cjEtpG5e5LmXNy0LTD6XksEgNaSyR
 dMVHkrmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRppNwAKCRB33NvayMhJ0VRbD/
 4vX6m42uwbgaKhQ0cl+IxY7rcs4VmhEDz89yRcmGxYkKLhJffOUndRYkg54mwZBwb9KNuocUScPwi0
 oFCYmHKzfOEEbjS9HxKqrcY+Qm7QU/RqOoHWQWVhdoCKIwSxgvp5XSAb0Bt3rJdogaVVkJyzQ/H6em
 DjqXF+RqcQFRzvfUxRgRfiSeCbZi4s1NlRunTO4TCTCJSngJ56sm5Je/iqmfqDl56EXvRjj28RYZAh
 KFZOhff4lJQIoQqM/VvRU9bJAzA62ezXaHqfHlMsMC8Dg9yfRKbExUNLPi6j2WEVVRsXz4vr82Qe/m
 GQNX/OXuzp0tMCJCRIMhMfsazSHqmiDJ+X5ZquaKqweX4OmYedxWDtD0gflNQLc3l/7It9DCj4wuvG
 SDYL28uuKJdCKTPYFSrUr1TuIXTYVh1D8tf0RE/lHL0pXFw4wV4Sh1vX/EJzypZRD6WDzkkqL2oyPf
 8ypx94GcoKC0Ruf17R/b8PpDWX3WN0fV4BRrkIQjuJNQ9ainEHBPAR0F1aOUUqgxPtxiA4sk3YQ2Z8
 gWd/2Ag6Tx5LqYLyXwUHu/9yH03YTrfwMavh4FURYkzNSUgcZutimLeFTcCaQwx0DsZQ7zDWI6dGzD
 LsIWefxh893JcWi9ww/Up0DcF5QAocZ6n8FEC32bDqfnBGs0nDP5TaotjyrQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

