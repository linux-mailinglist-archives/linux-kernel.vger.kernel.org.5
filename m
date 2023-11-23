Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66027F61F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbjKWOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345910AbjKWOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:49:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D6D64
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:49:23 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so11400301fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700750962; x=1701355762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbT4SM/ON1fCDmJeJzaowQV/y/xYkwz5XqPAyX1wOkE=;
        b=j++kzYK5W41fsmkStcsk8yAHHPzR6nqeGU0+IiJgB5CkWhj+8x5XQwy0jS2+CpIntA
         EShxFsAbVE7UoOkiKUCtR6wehqUAvV3uFUyTBqPeTn7Aep9FI1r89iyTykTi6vpGsVOC
         0wBKaBVA6jyMJX4guCxyvgc3z64pj7We0rynBjtviSM+U3HjK5nqPnZC4WRUq9Qrv2y7
         xgiysz1kd8V9yTL73T9nlRbNS60wOoMfkpOrvP4ve91K3H8IvB7F3I/qfdYDkbIe4NtA
         LVXAso8Q+CcBsC09xViir/r8eatYRH+eExm/yvjWIn6dzr5+VBdhA8zw89cR2EOyY4ic
         Sl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750962; x=1701355762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbT4SM/ON1fCDmJeJzaowQV/y/xYkwz5XqPAyX1wOkE=;
        b=OZsCq6dQBWZDYTeDoyQeOu/zyTgO7cNp+xdKOPlva1m92XkjXz+xWUgTP2CoYa2TPK
         CNfl56GkwbIu4JpQ3yInnHwvy8M4M+dD0oOpgH5q5v3sJ/huBZ3dY8+YEKwjzparAEM+
         be+qMkO1XxBUwhJwjpdz+CRXtuLhjwXxA7ZqXv2ESDd257ugEi0RSl463GitoZc3DDcK
         IO83NhPEObzDFlOh3WCQx32B5LHKIgLtuTXf8gAA2FFwgKF3yUYvtduEwplr0lqXP1vk
         NxoO68m+tvm3Ur/qnPtLWPlSNHL68LTXqk6uzWi2D2ZCEcKqKhndcvkPXBGeuq6tXVaP
         7hbg==
X-Gm-Message-State: AOJu0YyJWzflzL4zaJT+k3UjPGaCfo44mXRCbQFDJ5oX5cmWu5anrLrC
        8kGMowVQySICig3dS+P+Ay7Eag==
X-Google-Smtp-Source: AGHT+IHZBJb0pGqihr+j1ZdR1L8Y3ZoR7gyEvPbnBZxUyAfpmn7rAtd3hJi7YAP8z2twRupv25QkSA==
X-Received: by 2002:a2e:7a0f:0:b0:2c8:87d6:1fbb with SMTP id v15-20020a2e7a0f000000b002c887d61fbbmr3663797ljc.31.1700750961976;
        Thu, 23 Nov 2023 06:49:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b004094d4292aesm2256135wmo.18.2023.11.23.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:49:21 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 23 Nov 2023 15:49:12 +0100
Subject: [PATCH 2/5] ASoC: dt-bindings: document WCD939x Audio Codec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-2-21d4ad9276de@linaro.org>
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
In-Reply-To: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6327;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oHPZkGB2+lxc+Hu7wE58PGrnkLEAPNKccodV0RWgue4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX2Zt9JH1UOmqaZsEEAIMwtoKeYIrJNN/hAds9sns
 pzsO3hqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV9mbQAKCRB33NvayMhJ0Q20D/
 9jaKFy3eXEBgNMRJ0QYmLMcilCqvGjvP3oiJsqz4yVGzG3+dmvtl4InLV0euJ+9fk5OLC0JXTgSy+r
 TL1Lgj7Y9COniVlLlX/BVzI5X8myL5Tvl6L4yASDx44QppNw377YlD/ZaEkH7Akf8r3Af+y1c6fDA1
 uGq5FPcXRh0zbzZ5adM/wNpibl5ef1BScs6M8JQmvKe6u9yHziJJgbrQtcFIo1t5iNCxaiLl5WmZ68
 NcDNY527101/eRVfxsT4iAsbrCFC6G3Pib/S/mSF8DxKCVf9zU2+2qMCORwPgD2v9UoBjgkUzQ12r2
 /E7ofwWT96A2+KAIsXSlhbRBx+EhBDreH+VjmgFJZWbFa+pc/MQPpO06ajFs+9QgT3+nirgoOTBde8
 vtnHJfICjd49KvlB0KXbOw9EvPEbU2GOGKvAjfzpxForcA8Ib+BMcW+3hUV8uPSob5dlNAjBVUICf2
 cVdbxQEhFC1s5icwCQeNiyaRRyt2JUQnWzPp1LjZpyEglXQY5VtevkHHrvilsM/BR/Y9WL73QOqqcP
 eacdWrKrE0WEdwOHrVxD2GXB1jiHketAIF6QvttbcNWHmgeGzuLKP3IxlFGG1aXgBraUq8eF+FdK4R
 mkT5nQ1FNGPloMP+MHo5vtyYKIkp8bFDbsPM2nS55U0Hp3OfdK47qyGR3pGA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Qualcomm WCD9390/WCD9395 Audio Codec and the
Soundwire slaves than can be found on Qualcomm SM8650 based platforms.

The Qualcomm WCD9390/WCD9395 Audio Codec communicates
with the host SoC over 2 Soundwire links to provide:
- 4 ADC inputs for up to 5 Analog Microphones
- 4 DMIC inputs for up to 8 Digital Microphones
- 4 Microphone BIAS
- Stereo Headphone output
- Mono EAR output
- MBHC engine for Headset Detection

The WCD9390/WCD9395 IC has separate I2C subsystem for USB-C
DP Altmode/Audio Accessory mode Mux which is not documented
here but requires port/endpoint graph and properties to handle
Altmode/Audio Accessory switch and orientation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/sound/qcom,wcd939x-sdw.yaml           | 70 ++++++++++++++++
 .../devicetree/bindings/sound/qcom,wcd939x.yaml    | 93 ++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd939x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd939x-sdw.yaml
new file mode 100644
index 000000000000..7528c8b100a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd939x-sdw.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd939x-sdw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoundWire Slave devices on WCD9390/WCD9395
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9390/WCD9395 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire slave devices. This bindings is for the
+  slave devices.
+
+properties:
+  compatible:
+    const: sdw20217010e00
+
+  reg:
+    maxItems: 1
+
+  qcom,tx-port-mapping:
+    description: |
+      Specifies static port mapping between slave and master tx ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+
+  qcom,rx-port-mapping:
+    description: |
+      Specifies static port mapping between slave and master rx ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 6
+    maxItems: 6
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire@3210000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03210000 0x2000>;
+        wcd938x_rx: codec@0,4 {
+            compatible = "sdw20217010e00";
+            reg  = <0 4>;
+            qcom,rx-port-mapping = <1 2 3 4 5 6>;
+        };
+    };
+
+    soundwire@3230000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03230000 0x2000>;
+        wcd938x_tx: codec@0,3 {
+            compatible = "sdw20217010e00";
+            reg  = <0 3>;
+            qcom,tx-port-mapping = <2 3 4 5>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
new file mode 100644
index 000000000000..39c1de6961ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd939x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCD9380/WCD9385 Audio Codec
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9390/WCD9395 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire slave devices.
+  The WCD9390/WCD9395 IC has a functionally separate USB-C Mux subsystem
+  accessible over an I2C interface.
+  The Audio Headphone and Microphone data path between the Codec and the USB-C Mux
+  subsystems are external to the IC, thus requiring DT port-endpoint graph description
+  to handle USB-C altmode & orientation switching for Audio Accessory Mode.
+
+allOf:
+  - $ref: dai-common.yaml#
+  - $ref: qcom,wcd93xx-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcd9390-codec
+      - qcom,wcd9395-codec
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the WCD939x Codec node to USB MUX subsystems for the
+      purpose of handling altmode muxing and orientation switching to detecte and
+      enable Audio Accessory Mode.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    codec {
+        compatible = "qcom,wcd9390-codec";
+        reset-gpios = <&tlmm 32 0>;
+        #sound-dai-cells = <1>;
+        qcom,tx-device = <&wcd939x_tx>;
+        qcom,rx-device = <&wcd939x_rx>;
+        qcom,micbias1-microvolt = <1800000>;
+        qcom,micbias2-microvolt = <1800000>;
+        qcom,micbias3-microvolt = <1800000>;
+        qcom,micbias4-microvolt = <1800000>;
+        qcom,hphl-jack-type-normally-closed;
+        qcom,ground-jack-type-normally-closed;
+        qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+    };
+
+    /* ... */
+
+    soundwire@3210000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03210000 0x2000>;
+        wcd939x_rx: codec@0,4 {
+            compatible = "sdw20217010e00";
+            reg  = <0 4>;
+            qcom,rx-port-mapping = <1 2 3 4 5 6>;
+        };
+    };
+
+    soundwire@3230000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03230000 0x2000>;
+        wcd938x_tx: codec@0,3 {
+            compatible = "sdw20217010e00";
+            reg  = <0 3>;
+            qcom,tx-port-mapping = <2 3 4 5>;
+        };
+    };
+
+...

-- 
2.34.1

