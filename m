Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40BA7B32E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjI2Myj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjI2Myb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:54:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726651AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:54:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8a822508so1900944866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695992068; x=1696596868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJRnOC1uVFTy9wWN09XVjV1SBIhNc3zqk8m17zK48I4=;
        b=F4sBYtB1oSwbAKHlJnQLXPKL3K4e7K+nL0RoqQFKEpjac+QKZit7pxky39ieaXJl7h
         0TdNDETt3ejzLQM2DoySQA82aIZQSOt6ljjUWesVP9/VRKZM+3Mm8Xd5YUz2NO+pnYTG
         GLrhVDHWK+bctHBmymZiXmqOOEHrGcluc/cO2462CkgTJdBtGu5R9k5zssDgZQZLl/dr
         fO6bx/fYcT7deY+s5h+MZ2lV/ywJyifvm6LpNK8jW7i9AxY0CdAcGVxMER4vwwAWoZZe
         A/lg0n3ocojcQEGjb/bPW7nSitROviCcJyyziEwgGv9WOla/lW2Hlj37wajAiR0kangW
         FYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992068; x=1696596868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJRnOC1uVFTy9wWN09XVjV1SBIhNc3zqk8m17zK48I4=;
        b=UdkPmq2Nbm+8e3cuyorViACB8L87vQ9q0uFU0xyy2gkPRv9u35nBUzF4wYznpJLkqG
         Sj/y1/RluPobi8KFvWtG7KkFKqNjEyCD9GZOpRSFXh/xS3xeqp8J0Kn5QO+5zYDYkFei
         f0yX4ZL8N5mdk2vUJcdk4WK6yf5EYm8Wj2nghLck41QvneHKGR1NZrXuj6bd2bDvGz2C
         ucKbW2a54oiTgr2YCCdDVD1meJLLqWZSMEHvuUNfG6IAbZMK7M9H6oIPmai5DZ5vIBem
         68Pas3BV1Jk/X8xuD7i/avS+92BZfAQWVMbqoes3tNHzsvMWkwqzEbp1nKyJCfvhoorO
         94pA==
X-Gm-Message-State: AOJu0YzaHUta/bJBKXzkEtraswnWKCVFiaZbJwJShsZAsH7pwyR8YbKx
        0qPIOYO3zZgyqmqrWoZHGlNu+g==
X-Google-Smtp-Source: AGHT+IHlfDyfdppYdfWPSEvGU1WK5j1KreCcUFNSlRJmHZyBRqXcnqIwdbLcwU6AMeSWtGRaTxH+Zw==
X-Received: by 2002:a17:907:7786:b0:9ae:695a:fed0 with SMTP id ky6-20020a170907778600b009ae695afed0mr3976275ejc.11.1695992067908;
        Fri, 29 Sep 2023 05:54:27 -0700 (PDT)
Received: from [10.167.154.1] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906831a00b0099bc8bd9066sm12380376ejx.150.2023.09.29.05.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:54:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 29 Sep 2023 14:54:20 +0200
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Raydium RM692E5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-topic-fp5_disp-v2-1-7b5e1d1662a6@linaro.org>
References: <20230927-topic-fp5_disp-v2-0-7b5e1d1662a6@linaro.org>
In-Reply-To: <20230927-topic-fp5_disp-v2-0-7b5e1d1662a6@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695992063; l=2259;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9potHV92k4LaUbwEIxQbafFOD7jGDkkwV6NtioaJszc=;
 b=Osq3muYbMdMz9+o2MgDamp+nm0liT3RTNziSm/EWgr4xMlCD22SMwj3pcDFiziAW1l0rYKbd3
 FCtyY1Sr4a4AkSN2HKnGAxDCZ+FZEBGkO/CWX73soG+oq9Kraejc3hP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raydium RM692E5 is a display driver IC used to drive AMOLED DSI panels.
Describe it.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/panel/raydium,rm692e5.yaml    | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
new file mode 100644
index 000000000000..f436ba6738ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm692e5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM692E5 based DSI display panels
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description:
+  The Raydium RM692E5 is a generic DSI Panel IC used to control
+  AMOLED panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fairphone,fp5-rm692e5-boe
+      - const: raydium,rm692e5
+
+  dvdd-supply:
+    description: Digital voltage rail
+
+  vci-supply:
+    description: Analog voltage rail
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  reg: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - dvdd-supply
+  - vci-supply
+  - vddio-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "fairphone,fp5-rm692e5-boe", "raydium,rm692e5";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 44 GPIO_ACTIVE_LOW>;
+            dvdd-supply = <&vreg_oled_vci>;
+            vci-supply = <&vreg_l12c>;
+            vddio-supply = <&vreg_oled_dvdd>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.42.0

