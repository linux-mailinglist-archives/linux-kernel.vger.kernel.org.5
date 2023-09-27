Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF337B052A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjI0NTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjI0NTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:19:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E510A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:19:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adb9fa7200so2462907566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695820749; x=1696425549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Huk11R8abuio8R+T/LI4XP/yxkr/XotUa5HlDC5r0jQ=;
        b=UzsLlc55kJ+B+ip1ZXeYJVdIKznQ67+04i+nFVeG2eWNJEj4jOfNY/l5RXWY/lMAcP
         8LKK0h9DRjroF8ixbIawTt2AsUY65mol5cTiIA/CHMniR/t2aotvjGXabXwS9jbObYfu
         DNElhCs5KNG2xNHTLshFqMK7Em/dxH51oj6LGaPHf/AFLERLtiJbmE3go7almd6nCc9m
         tlnd/FcHa9L3TQO9nHh/SU4yezqFKBxizLgXUnexSqSVWErKRNij1UAVv6BlOvUtvxHy
         AfbbHvMwSNl6wMGmyGLi74NIF2TvFdLA3aQYc6hlwOIsZGKfRfDas5DSUvy59DUgs1xL
         oKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820749; x=1696425549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Huk11R8abuio8R+T/LI4XP/yxkr/XotUa5HlDC5r0jQ=;
        b=OYUkEiSh8eXub5o+7a7z93SHjRPUu6F+kJMzPEp/nKBcxCCtM/6ARP/T/VZHLj5BV4
         kRlahXerJ00o0qu38qPsv7jomTtrOQLjnTDJoHO0CZ0Iu5rIwREB4UQgn/n9k0+s9sZt
         ALmhLkVXfo5lLoncrXt40DL43y2coVaQW8Q9UgA3rZ8HKEVU4hZddQejKvXgWGO5nPs/
         XHsmIHzTiavwMrrAcL2KCaNrqHQQousjUT01RAuhohJmNwNT+KGHh2L5wRJXnau0nxbe
         0Euf7PT7zCgv5GI6FxSCTwboRAcIb3mfTExK4jq7xIVt8lCBb/wW2Z2SZLo3uQPC06s8
         iG/w==
X-Gm-Message-State: AOJu0YzkSJiYc0azer/J3aWhOZtOtJbx2PpBdQ4BcxA6odU7K4e/Z9A2
        oMocVpqtrw96vWnjrVAPNmrqvQ==
X-Google-Smtp-Source: AGHT+IGHvTZVdi2yGYaB4aqyYEh9nb5/nrgESVIgMaKwBIGJi+yY4hRI/oM/Erhu0Hl5I0uEq/0brg==
X-Received: by 2002:a17:907:7793:b0:9b2:b742:d1d3 with SMTP id ky19-20020a170907779300b009b2b742d1d3mr1546607ejc.5.1695820749038;
        Wed, 27 Sep 2023 06:19:09 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b009ad8acac02asm9369335ejb.172.2023.09.27.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:19:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 27 Sep 2023 15:19:01 +0200
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Raydium RM692E5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-topic-fp5_disp-v1-1-a6aabd68199f@linaro.org>
References: <20230927-topic-fp5_disp-v1-0-a6aabd68199f@linaro.org>
In-Reply-To: <20230927-topic-fp5_disp-v1-0-a6aabd68199f@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695820745; l=2205;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mQ6RVBqfnjkn7k7aw7JAtC6ys5lPho9IhAiB1YQIk6E=;
 b=P4qdwJsc/KL+8ZdQDXzOqavmia7ll3W6F+OJdDtWHAA5HfWnWtzK6DjXPgWYNLrwtvR2bgqea
 wUZSOt56u7jBGRX97M8h0hv9/gVhP2s2sODl655ohBXY/dhtHJoqQxf
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raydium RM692E5 is a display driver IC used to drive AMOLED DSI panels.
Describe it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/panel/raydium,rm692e5.yaml    | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
new file mode 100644
index 000000000000..423a85616c1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm692e5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM692E5 based DSI display Panels
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
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

