Return-Path: <linux-kernel+bounces-5191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830218187C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFACD1F22239
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1BE18E23;
	Tue, 19 Dec 2023 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqGuz8b/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809318E31
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3365f1326e4so3199360f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702989940; x=1703594740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qINiKytCFGh2MDywcjo0UyglJ8pj6SdN9F5fHmVcUK4=;
        b=fqGuz8b/VzmV5585MEQuvDySKR7Ibha/dwld5RLmlNKWAl1KZOciT7zauhjAX3nM3o
         vVfHwNZrDWy2IBlaDNB2zn0OYmwQ8ZJSToWswgPbfnz4p2LICRn7RQoC+e7v/iv0tBpk
         681vuXylylzT/RHsBhuDei7O+ii66i2e30L6wyIRdVK3MraQFCbVLftm8xPyix9MVidt
         SAXAtRd3EalboDNhnJzId/Kxefi751LLw1AAe3qcJFKiDyF/81xmUMBtEPJnlHTrasDN
         5r+ouUxa07g2Yq4el7eEvGuLROjKHCOSzYfECDzcRjeoWhkYy0ZuiSHWXUmPT+YSqiP5
         oJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989940; x=1703594740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qINiKytCFGh2MDywcjo0UyglJ8pj6SdN9F5fHmVcUK4=;
        b=KX4qjkwZ8OMHKWKVJJz8Lg1OoByyCUTflPtdetvdiczewMeSZzQZNdycT+lC8h0alp
         kE3kxTk2V7ZyWiSuLdMlZSYYu4DLP9PNUVL66Fjs65chrAcoO6gihwPsamyO6wxXNUg9
         FdhcjMFb2CPTDnpre2Y8Oez/cJmtkUjr4taXguPTwxwDWR2fuXmJlv3Y9JU16JN6ZJoL
         k64U1o0I2qQWVOuTZj+qfm8hT7QelCFOB8KRCkl/a8mUcxmM2Qksl/wO+JnjtJPsqlka
         SLk02a7y8kCDkJFIHYjhp6yhOjIDXOi70hGzlnreQPDHn7oRyAG41xzQl4Nz3tVIN8jy
         iqPA==
X-Gm-Message-State: AOJu0YzUCq3++cOkRStxOkPcodYqVJ7rSarLdm4Xb+hIYQ0QFThGCBqF
	Yqe/4KyNTPw1Ji8cx434721g1A==
X-Google-Smtp-Source: AGHT+IG+WJohecn283T4uQjtCrucD1UHqRapQpYj6Q1k48upLA0gVfO5Pr6Rh7bt7wI6S2t190vWVA==
X-Received: by 2002:adf:fb44:0:b0:333:3f5d:63d2 with SMTP id c4-20020adffb44000000b003333f5d63d2mr9137527wrs.3.1702989940187;
        Tue, 19 Dec 2023 04:45:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b00336673a4153sm5975782wrs.80.2023.12.19.04.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:45:39 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Dec 2023 13:45:34 +0100
Subject: [PATCH v4 1/5] ASoC: dt-bindings: qcom,wcd938x: move out common
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-1-1c3bbff2d7ab@linaro.org>
References: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-0-1c3bbff2d7ab@linaro.org>
In-Reply-To: <20231219-topic-sm8650-upstream-wcd939x-codec-v4-0-1c3bbff2d7ab@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6302;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Uglg24nZY1C7ElRVJ4NCgzh7HTGQqFA6AMsN4Ezv9Kk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgZBvitCN9PjH4kAQVw553KUN/aGEdNsThpb0aDbw
 dVlb7oiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYGQbwAKCRB33NvayMhJ0Q34EA
 CK6j/hP8U6HoTVRGuUX1CGUtm0a2CM/j/D5raygmCY1HDnQ2f0aTyN2d822+tMj56XWE8Be/13Mzum
 RYXJUXQxYfNyPQRxoi8vvMTCT7Dbl9kLtu+PEfX17KzCNr+t5aiep03pO8eTCjV9MMc4A3QvqueMuS
 SiBR7v2mKW8vRvjyD180DWY5gX6m8W82+SdpgPJon5Ru1BCPOse905tPSV6vxVmebjqROEensnAtQW
 bbnCK8cuSs5lIG3L7BWfOuS0hFVn4PBgseYB+ONe+Ek+YSjViXMnnCBiFHHQ6T4nt4jZ5lfEty1sGB
 4TObxoXaXOa8/3ORnwCFNTT/vSIp7UQB7lnKQEfa8/R+yXITNl2YrxcEjE/1QoA6UDb5yHUbjhQU4G
 4vxkmUHH+/cF/YWIaxHSB7Wo6Pd2JC8oy+zFOBxxHacQTWhJjpw/hFOFQAkaukXDvsFLGGn8FfzuDU
 yBwShwF6vGnakLPokXa6qYWASDrIw/3Ni3FcQ1ZhgUNMdCcznKDGsF3nsaIgec+p+j6xvvH4jHyEIw
 i3GFnVX7ycKMICi46BJsTSfyNGTt4GD5l95/3DYjtsYZdMwAqqc9wZaaxtSkVKwFudFb+L75+0Q4lM
 FKBwAQyGgMYbMJ6mrR2JRZe7DDiNzI5Y27l9EEgeZsaolbVrI8EWtgiaElgw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Move out common properties from qcom,wcd938x bindings in preparation
of adding Qualcomm WCD939x bindings sharing most of the properties.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wcd938x.yaml    | 81 +-----------------
 .../bindings/sound/qcom,wcd93xx-common.yaml        | 95 ++++++++++++++++++++++
 2 files changed, 96 insertions(+), 80 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 018565793a3e..de333d07d469 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -15,6 +15,7 @@ description: |
 
 allOf:
   - $ref: dai-common.yaml#
+  - $ref: qcom,wcd93xx-common.yaml#
 
 properties:
   compatible:
@@ -22,92 +23,12 @@ properties:
       - qcom,wcd9380-codec
       - qcom,wcd9385-codec
 
-  reset-gpios:
-    description: GPIO spec for reset line to use
-    maxItems: 1
-
   us-euro-gpios:
     description: GPIO spec for swapping gnd and mic segments
     maxItems: 1
 
-  vdd-buck-supply:
-    description: A reference to the 1.8V buck supply
-
-  vdd-rxtx-supply:
-    description: A reference to the 1.8V rx supply
-
-  vdd-io-supply:
-    description: A reference to the 1.8V I/O supply
-
-  vdd-mic-bias-supply:
-    description: A reference to the 3.8V mic bias supply
-
-  qcom,tx-device:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: A reference to Soundwire tx device phandle
-
-  qcom,rx-device:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: A reference to Soundwire rx device phandle
-
-  qcom,micbias1-microvolt:
-    description: micbias1 voltage
-    minimum: 1800000
-    maximum: 2850000
-
-  qcom,micbias2-microvolt:
-    description: micbias2 voltage
-    minimum: 1800000
-    maximum: 2850000
-
-  qcom,micbias3-microvolt:
-    description: micbias3 voltage
-    minimum: 1800000
-    maximum: 2850000
-
-  qcom,micbias4-microvolt:
-    description: micbias4 voltage
-    minimum: 1800000
-    maximum: 2850000
-
-  qcom,hphl-jack-type-normally-closed:
-    description: Indicates that HPHL jack switch type is normally closed
-    type: boolean
-
-  qcom,ground-jack-type-normally-closed:
-    description: Indicates that Headset Ground switch type is normally closed
-    type: boolean
-
-  qcom,mbhc-headset-vthreshold-microvolt:
-    description: Voltage threshold value for headset detection
-    minimum: 0
-    maximum: 2850000
-
-  qcom,mbhc-headphone-vthreshold-microvolt:
-    description: Voltage threshold value for headphone detection
-    minimum: 0
-    maximum: 2850000
-
-  qcom,mbhc-buttons-vthreshold-microvolt:
-    description:
-      Array of 8 Voltage threshold values corresponding to headset
-      button0 - button7
-    minItems: 8
-    maxItems: 8
-
-  '#sound-dai-cells':
-    const: 1
-
 required:
   - compatible
-  - reset-gpios
-  - qcom,tx-device
-  - qcom,rx-device
-  - qcom,micbias1-microvolt
-  - qcom,micbias2-microvolt
-  - qcom,micbias3-microvolt
-  - qcom,micbias4-microvolt
-  - "#sound-dai-cells"
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
new file mode 100644
index 000000000000..f78ba148ad25
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd93xx-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for Qualcomm WCD93xx Audio Codec
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  reset-gpios:
+    description: GPIO spec for reset line to use
+    maxItems: 1
+
+  vdd-buck-supply:
+    description: A reference to the 1.8V buck supply
+
+  vdd-rxtx-supply:
+    description: A reference to the 1.8V rx supply
+
+  vdd-io-supply:
+    description: A reference to the 1.8V I/O supply
+
+  vdd-mic-bias-supply:
+    description: A reference to the 3.8V mic bias supply
+
+  qcom,tx-device:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A reference to Soundwire tx device phandle
+
+  qcom,rx-device:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A reference to Soundwire rx device phandle
+
+  qcom,micbias1-microvolt:
+    description: micbias1 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias2-microvolt:
+    description: micbias2 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias3-microvolt:
+    description: micbias3 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias4-microvolt:
+    description: micbias4 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,hphl-jack-type-normally-closed:
+    description: Indicates that HPHL jack switch type is normally closed
+    type: boolean
+
+  qcom,ground-jack-type-normally-closed:
+    description: Indicates that Headset Ground switch type is normally closed
+    type: boolean
+
+  qcom,mbhc-headset-vthreshold-microvolt:
+    description: Voltage threshold value for headset detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-headphone-vthreshold-microvolt:
+    description: Voltage threshold value for headphone detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-buttons-vthreshold-microvolt:
+    description:
+      Array of 8 Voltage threshold values corresponding to headset
+      button0 - button7
+    minItems: 8
+    maxItems: 8
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - reset-gpios
+  - qcom,tx-device
+  - qcom,rx-device
+  - qcom,micbias1-microvolt
+  - qcom,micbias2-microvolt
+  - qcom,micbias3-microvolt
+  - qcom,micbias4-microvolt
+  - "#sound-dai-cells"
+
+additionalProperties: true

-- 
2.34.1


