Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4816F800E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379329AbjLAPJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379319AbjLAPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:08:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BAAA8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:09:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bbb4de875so3093884e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443342; x=1702048142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XsLuiRUcl36nuEUQhIDR6/wMADjrm/yz4rDk8pYcHg=;
        b=iDFNPpTnzFYKQDdkC1u0/NuetXfAcQexHeT2Pv1yEB8NUhq+uCuieBiiRQDL7+1HVL
         uiijVVpHZL+9Vzt76sqPDo08JfMOiTIyLVFtXn2L8REMOmLbfjawg2JU4WJBZ2qtUeuR
         +Y5RHvLHYUZusQlr+CjInv0cdBjfllVwTHhWsOG0aIA7Bpo45OBS8NfQSG5tWuSzvxsQ
         oOxbYyqnUxQV2NLehYrHF5HR8yxClATWjR1IXv8dkghgf8UVuZ82GuK7N7+kbF6T1Pjy
         A6l1OA+bViVAJ9gg0M2ET5bUFIqgkVrL4d4ROlXJDKHBm16mvesLS0kFGSCyOtNFjdKu
         dWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443342; x=1702048142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XsLuiRUcl36nuEUQhIDR6/wMADjrm/yz4rDk8pYcHg=;
        b=ew7bBe8QbaV9Pl7dpMid5Jqn2popNNrdiD9K3t9/Tet7ZmLVpv2tmikjb3qpHDY/R5
         vEeoexRwyZ/LFP/aF9+HhSmltvL9bOJdYh+ElDvLpBVBcOT7GhI8CHlfn5Hh2vRZka+1
         8nenJu4HYPO5bnVc0L9D7yg/m4DEaG97RPn2E7atk/j+ZMnTN9GvcTaQDmTyCCSgJgfS
         m39PtfkJRoa9AZglvjQ4XvybShN4jgKAoDMxbf1SNuAGcFxKVIboyjRTkxhtUhCarpJX
         UmUQbzmvVD1tlcpvcoXvX9bWgdIpSQV52aNzr7RxruwEB5P6sWVKtTRxfkcRFw7kpFyW
         YOdQ==
X-Gm-Message-State: AOJu0Yxf79VyTvKUdJOp20L2RKNvfK1uSlQ/h1kA3JpNagq+6o5IIyn6
        QEwpNytVvsGT2HbTVLQ/bbjy4Q==
X-Google-Smtp-Source: AGHT+IEwFSqRwLE0S6z19fYJUigSGSe/Lu9/AOWHA4ZBfp800Zqya6nMl0xRFRT+G2toL+v80OukIA==
X-Received: by 2002:a05:6512:15a4:b0:50b:bd9c:8b0 with SMTP id bp36-20020a05651215a400b0050bbd9c08b0mr910702lfb.19.1701443341914;
        Fri, 01 Dec 2023 07:09:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b0040b5517ae31sm8569539wmb.6.2023.12.01.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:09:01 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 01 Dec 2023 16:08:55 +0100
Subject: [PATCH v2 2/5] ASoC: dt-bindings: document WCD939x Audio Codec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-2-94ed814b25aa@linaro.org>
References: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-0-94ed814b25aa@linaro.org>
In-Reply-To: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-0-94ed814b25aa@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6444;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mWJwSaSVD3XgzAsTKQAIK+4sHRaSB/e8uBoCOrJJHRY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlafcI+CFIkmDxQv6JZxNpc6BcOs7M809vJRw7TPfG
 /EvKkRCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWn3CAAKCRB33NvayMhJ0UVaD/
 sHUXq/75jcU9Ng/rmV7whQfVTtgNB2acYdQtrZ8iBTn0wGGknC0tDN3aqCLnZ2zRBfNaLdgE8dBmDI
 O/39aGdQyi6x+pqYLwt/lFitMMq/+bf7e9F3/aVicanNTR4ysPZwDsrSKdsNYTEzlZlYW+BVsSjXbQ
 ync93+UUsFxHwFsTjVV0tZ95rfbvb6LAMTueaOKN8IQRmMgmVp8bEY/sTjwBjf6o/KhR4GvU7B+Xc2
 8eF6JtANnWXhkeoXrR++ZLAPZWveKSuN7mTS4Rh6ksfzvPOhgla6zY6HiBxBHhxagNVUc6N4uxxMOp
 Sl4r79yy4ftpBXE/Dts8kJYp3OV9sZUaZeVANieeexsC63PT8Qlt0dRwO//h46RT288rnuavTj8kU6
 eIwYIKwNWQwARBOy/ib1CMbCRoHu2SH36XVJtrd3L0CX7/gVHsJ7H3KptN7YiDPt/HNNOpBhe5t/Qq
 wG9cpgYaU24zaLxFkRNU2o5nSNxhxseYSkW7Rh0xeVa/wZlsPdd9Av2cstubywxF6HOQ0HSLsskuOb
 xuoArFp0xGyFB/gWbXB7pMhjVSdjBsCXTGnsfjQZUIIdrrW7REjJKz7Y4OjQ8QF7Yfzz76UUmCKgw2
 DTPDmPA1ny4AKWIRuf4iIqK7xVbNECeC6fpSLPXp/9Iisn+OkYdhe9kyvQMA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Qualcomm WCD9390/WCD9395 Audio Codec and the
Soundwire devices than can be found on Qualcomm SM8650 based platforms.

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
 .../bindings/sound/qcom,wcd939x-sdw.yaml           | 69 ++++++++++++++++
 .../devicetree/bindings/sound/qcom,wcd939x.yaml    | 96 ++++++++++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd939x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd939x-sdw.yaml
new file mode 100644
index 000000000000..67ed7701b5d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd939x-sdw.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd939x-sdw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoundWire devices on WCD9390/WCD9395
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9390/WCD9395 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire devices. This bindings is for the devices.
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
+      Specifies static port mapping between device and host tx ports.
+      In the order of the device port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+
+  qcom,rx-port-mapping:
+    description: |
+      Specifies static port mapping between device and host rx ports.
+      In the order of device port index.
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
+            reg = <0 4>;
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
+            reg = <0 3>;
+            qcom,tx-port-mapping = <2 3 4 5>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
new file mode 100644
index 000000000000..6e76f6a8634f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
@@ -0,0 +1,96 @@
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
+  It has RX and TX Soundwire devices.
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
+    oneOf:
+      - const: qcom,wcd9390-codec
+      - items:
+          - const: qcom,wcd9395-codec
+          - const: qcom,wcd9390-codec
+
+  mode-switch:
+    description: Flag the port as possible handler of altmode switching
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
+      purpose of handling altmode muxing and orientation switching to detect and
+      enable Audio Accessory Mode.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    codec {
+        compatible = "qcom,wcd9390-codec";
+        reset-gpios = <&tlmm 32 IRQ_TYPE_NONE>;
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
+            reg = <0 4>;
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
+            reg = <0 3>;
+            qcom,tx-port-mapping = <2 3 4 5>;
+        };
+    };
+
+...

-- 
2.34.1

