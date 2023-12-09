Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC880B2CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjLIHdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLIHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:33:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EC710E7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 23:33:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3332efd75c9so2637309f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 23:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702107226; x=1702712026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=L8G40mZYegqcCvYV8k0c0aqTGnQDNPY8HR/ACoIUbFaqwm0lthDrxB2nlUBYuqrYXH
         xKQwnpfM1/+A8qufZcLrR7/6EBOq95MM2sUm/T0OqFOxmzxMWWfTcM8quqPYJoeBUuu8
         EK3CsIdWRmc7498XA3Cgcg7BNN9lsNECX8pSCM9MLaFAy+GWdCILlZlE5Vv46wfZUfd4
         M/CdJW+Bsi9F8YZUqG1XW1bexx4QUfE0MHL2fhXaw81d6EX0BfW/2mjtsX2V8Q1hKBdi
         5WS/aSPMtaGoR54p5yrAUj7I90wioBtpbGxopGPlnsB7SedvB2fhMNAIQ5JWCKHHNhQV
         u0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702107226; x=1702712026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31dDSPmTEwAk2xBEYscYsgGP3NvqtS1pbeFP7C1NdB4=;
        b=f/zEQuUzbaIz2J91BEIbV2XNHW6NClU+pfwJcvUnlDwAULWkuFCJqBWd4HwnSUjglw
         Pj1M6p071nAkwQcNwiYaVcPAalMeKWZF7SEu21ry5Vd/qwI0Q7BYpm+7z5YlRaBncbU0
         XuqRO7aJyBs/WwuYcRx2WzIC3jtFYMqv8DEFPyXFKjdR1mZjZYpxfTWeJv2BX/Anrc2w
         NBPmGmzxGuCpXNdS36aMhHRojpwESCfFFYyEEH3rIQvoK49xqjfvDl480pVS4OdlcpMI
         AFgQjpaMV1JQ8/d8+6sZEGGdGFCEqbpjfIW99n/0re3mwh/wkzoG1eMxbEuGWZf3Tdb1
         kQiA==
X-Gm-Message-State: AOJu0YyyxO8WDH8LPSwKi2dl9XTpF8L9RcM+i/n+jDQyouB6GaVJu2/3
        hzyBhZDE8F8o4G3/ltiZnC2ObA==
X-Google-Smtp-Source: AGHT+IHj7ShhVjMt4093im1KcDZC0Z5/bXfMGgTmQoUM7WxPNHI6nB8hoARq+oKGRCkeIx68Mubt2g==
X-Received: by 2002:a5d:6e8d:0:b0:333:3117:c43e with SMTP id k13-20020a5d6e8d000000b003333117c43emr284271wrz.207.1702107226672;
        Fri, 08 Dec 2023 23:33:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b003334520e49bsm3577803wrw.53.2023.12.08.23.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:33:46 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Sat, 09 Dec 2023 08:33:39 +0100
Subject: [PATCH v12 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-topic-goodix-berlin-upstream-initial-v12-1-eaffaeb53fb5@linaro.org>
References: <20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org>
In-Reply-To: <20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBldBhWpRETZRzoQ+wlfao2qaeIz/dVT35rxQE1WjFg
 IjOi2xaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXQYVgAKCRB33NvayMhJ0bS8EA
 Co7RUt5x8LnwxAYh/dZWYLnhHM1Q6IVTinFG/1H89CHCKiPZCTMjBpIuSdZs62KHyft80VllwvUB9X
 cDGNjqTkGNvbGNCIprLSiTU/klc4hEn25g0vLsa2ZsOT4Toisr4O4UpbEHckC9Tx04Zwtt4Kx+R6sy
 M2KQ3vmNPR2RHGxWppmoc/UwHd2i4Csx8MCbFwfokLMNf90M+nv0TXlKdUt6QBKtkLOV3oMCZWzRqX
 5wSqLzTc+oHvvhND1RtKrIJT6jv9+44mIdhn0WjOJeKuWSoKC5yIX5rjG8OMEdIBnfJwmZlg7FKp8Q
 3S/ziQ3wGH/kMBgi0txThzq/RF7RdXz5N2ZmjZ2icRqTFPiSq0wZ93bb9YjnVG4xRZh2QVkzrVVxpJ
 2z/Jai+oC6+bpv3sj5DT+lLvd/gBlEH21rkb76DkZbhutpt1pr0tguRCOg3hBGYw1m8tYEvYZWVOPr
 9bMW9jqrxfWhZCaIEDPreUVGzB2gAiyV/AMnbM0mV5J7H/lcSn/3STEeIon4mVp4eWut3XPjvqnxAv
 tHmk7aKyPWd0h8MBZzyTTP3zANUhx2esrw6STVJoBFiXrIQMajgOqumFaiYtOq8Oa95XO34e4RpDxo
 PtSVvPSmuxXekM09PvqQ8GalmLtjt64ZIIPKhsoQPw9+36SjEDLsLABG+V9Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

