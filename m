Return-Path: <linux-kernel+bounces-73048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12DA85BCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A57282360
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D16A030;
	Tue, 20 Feb 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwOR8E81"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B869E06
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433981; cv=none; b=jTkw10kGgbzvpbHOfwCBaH3D9YLO+uR+YcTguoEx+N26LuL/NZtErBtGUuYHFwCS6hI8bbM7oEIFEpOS3ZU17zkYOrLuQZNPSdcPcFH4smVgQR1b+t3t9L7uY9cL/0XqF2/MHo7/L/dQpXynubfvMPuV4Ywdn0tRrpfDPuC7xOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433981; c=relaxed/simple;
	bh=ThFF7MydSq7GIulN2BiuLPta4fGlEnJTyb85puKw6/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKNn/3riV9efywOcwqhao+MRl7Jd3x/DSHvGyLPO6IE4VIJiihjydR5+ZEMd6L4AYDW+bjx9KL7T09tqQeQvdtAvlqa59VWuOfsMl5ZWSbUyOfKyx5/crievYqfRFalnmmpIMbbhkeKpuL7mD1EKbxxS8domL1frMM2ZPnSYBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qwOR8E81; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5645efb2942so4074550a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708433978; x=1709038778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjEaHSfzaAp92cc1QcNapWfjcTbk7tItlWQ+9zi3zaQ=;
        b=qwOR8E81y0/YgwOYpPEb5GJC3MklnSnnm4SYN0yq5h9kQnIXs/X8Z4jkGrZFiSwQSB
         qbSp3apLbDHBJrMGwRbY5UOCP5EbTlp0qDdcgwnmCwPnSSEss8eefrcFB/E74QlFgDru
         2ZNZ6ys3+77rPnO/S6CItZwPxMa8qvHrPLI8vpIFWcp6sHnwMYl4tAZ8EV+27NfwiJa7
         Kb180ZPxbe0kwLdgKARMzN0v/VxXYe/LBwSzaiXW5dKDEW6u9iQ0vpxr4EttxnXkdbvQ
         KSvC8fCFBa1nCAhLdkeUrlpPVLpGuKvHiX5yX5wBerkAUy0lg5Qc+RuWOewdebCuyGie
         2jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708433978; x=1709038778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjEaHSfzaAp92cc1QcNapWfjcTbk7tItlWQ+9zi3zaQ=;
        b=lYrlwtDmp/EZIZXMqkPTv6VONPw7Edt/70jS+MAoExkyICC2ARJ31k7xaLUdN+ZfCs
         BoL4aMfEOBsvL/B3baXuOmQHLLfUCChYrhc61q0vKwvX+O5uXq8wJSiG18FwvhKiEuwP
         W7WMGO9w8Q6izNuk1iS1EyS3cLV9Dyg5GZWDhIzO6y2pX7Pav8Z2HaoKBAp2NJ65Ozww
         FJKUeU8SxeRXsNLVRxajPjlrtCN0+o/MQCxZWgl5wjkblWU+3X+yycfmNNCDSCcoAXNJ
         q10GiSGEmP4j0mD2Vg5aZccVt+ponqFZWmjuG5rByGBMp5UXdTT72kA+GJelUU5dBURu
         8Gow==
X-Forwarded-Encrypted: i=1; AJvYcCVSI3Br7rWsQ4CAfN/RaRdgNt/iwyzZ1VbQBog8181CbIWLXQSlo2N8XMerNxF7tJTjsdo+SeXJvYCJjUO/CP3U8WMQlSLcEPmVj4aI
X-Gm-Message-State: AOJu0Yx4XUOSDZkbQ4EOwryZJJ6uBDe+RKt7UEkl/1C0PoOb2uOJBTYX
	Q6sS0K9piyqi2qc+uqZrNqGTNwQ3j9lYhgsYI1WHA22b928RnpgdQ26Nu5vvMkI=
X-Google-Smtp-Source: AGHT+IEb4Cm5uVF+9tBq0GgVnU8zP7htuazyc7HAMuiist+/EysRahieUcUeX89Q1qGq5lLzBJ7phg==
X-Received: by 2002:a17:906:816:b0:a3c:5e17:1635 with SMTP id e22-20020a170906081600b00a3c5e171635mr13747344ejd.30.1708433978257;
        Tue, 20 Feb 2024 04:59:38 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id rf23-20020a1709076a1700b00a3ce36ce4f9sm3948802ejc.83.2024.02.20.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:59:37 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 14:59:21 +0200
Subject: [PATCH RFC v4 1/4] dt-bindings: spmi: Add PMIC ARB v7 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-spmi-multi-master-support-v4-1-dc813c878ba8@linaro.org>
References: <20240220-spmi-multi-master-support-v4-0-dc813c878ba8@linaro.org>
In-Reply-To: <20240220-spmi-multi-master-support-v4-0-dc813c878ba8@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3681; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ThFF7MydSq7GIulN2BiuLPta4fGlEnJTyb85puKw6/Y=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1KIyzs8YVUgvE5dRf6d5suxJZ7odVJwulay/g
 YQbLKVqXNOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdSiMgAKCRAbX0TJAJUV
 VoouD/94NOL0UK2zX/jQmWLQ96DxsMJTSYNtK4mKLvnQhjogZQ6OxWw60gq5iyQEIiozWWpvZKJ
 GXcIsHO4ohx1JJeyJRLHchnwKfqWY/BnbeCu/Dso678WaufCI5Ge3KxycE0C5NVeiiAAvVO90tb
 aXCozh3DCo1T10Vok+XdB0hJ/iRC+q/8jwLVgoAgQO6H4LnRw5B4QoINeg4utoWMk9pFlwzGoTa
 wW1QVlMwRjUH6/LtYCWEaZjOVkoqdtWzWB51TGHoOjYKW5N/JOHHuOorLd7G2/Lgw5WrGX2FZ/Z
 07OilFw2R1gVb++I7nyLEM199hBgl7T8nKeTwgHPmjpKFE1t7pBto8SQXPnctCOQUUPsVRsL/Gj
 RMhseYUa787BuqJdrTvGD6uQcsjJ7tmIHRlDc45/ZUAhQlnXsrRRz2H9OjzMK6usuj3dPx3Jurt
 5dTlHJ3fW3RQqCm7bYlAGzjMzbL8VxKevcEKjMRfxJeFb8TIjNtHrcjAmlrWfE17DxSahbZAxwk
 hGsi/6KMqDFiveuOcWdZ6Ks8iCInBufdS68QXScpUJDB9IvB6xTieoMQecFW4aZFVnmAKpY4UD3
 zFUVvifa8G55DHkvRkiVRgR0d+h1bK1c4v8eDXD0lTWszfWAFuF+qDUgrMOEyVciSi4uv15NqlL
 4CCgtIkWWnH7tig==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add dedicated schema for PMIC ARB v7 as it allows multiple
buses by declaring them as child nodes. These child nodes
will follow the generic spmi bus bindings.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/spmi/qcom,spmi-pmic-arb-v7.yaml       | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb-v7.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb-v7.yaml
new file mode 100644
index 000000000000..8a93d2145aa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb-v7.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb-v7.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SPMI Controller v7 (PMIC Arbiter)
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  The SPMI PMIC Arbiter v7 is found on Snapdragon chipsets. It is an SPMI
+  controller with wrapping arbitration logic to allow for multiple on-chip
+  devices to control up to 2 SPMI separate buses.
+
+  The PMIC Arbiter can also act as an interrupt controller, providing interrupts
+  to slave devices.
+
+properties:
+  compatible:
+    const: qcom,spmi-pmic-arb-v7
+
+  reg:
+    items:
+      - description: core registers
+      - description: tx-channel per virtual slave regosters
+      - description: rx-channel (called observer) per virtual slave registers
+
+  reg-names:
+    items:
+      - const: core
+      - const: chnls
+      - const: obsrvr
+
+  ranges: true
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description: >
+      indicates the active Execution Environment identifier
+
+  qcom,channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description: >
+      which of the PMIC Arb provided channels to use for accesses
+
+patternProperties:
+  "spmi@[0-1]$":
+    type: object
+    $ref: /schemas/spmi/spmi.yaml
+
+required:
+  - compatible
+  - reg-names
+  - qcom,ee
+  - qcom,channel
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spmi: arbiter@c400000 {
+      compatible = "qcom,spmi-pmic-arb-v7";
+      reg = <0x0c400000 0x3000>,
+            <0x0c500000 0x4000000>,
+            <0x0c440000 0x80000>;
+      reg-names = "core", "chnls", "obsrvr";
+
+      qcom,ee = <0>;
+      qcom,channel = <0>;
+
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spmi_bus0: spmi@0 {
+        reg = <0 0x0c42d000 0 0x4000>,
+              <0 0x0c4c0000 0 0x10000>;
+        reg-names = "cnfg", "intr";
+
+        interrupt-names = "periph_irq";
+        interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <4>;
+
+        qcom,bus-id = <0>;
+
+        #address-cells = <2>;
+        #size-cells = <0>;
+      };
+
+      spmi_bus1: spmi@1 {
+        reg = <0 0x0c432000 0 0x4000>,
+              <0 0x0c4d0000 0 0x10000>;
+        reg-names = "cnfg", "intr";
+
+        interrupt-names = "periph_irq";
+        interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <4>;
+
+        qcom,bus-id = <1>;
+
+        #address-cells = <2>;
+        #size-cells = <0>;
+      };
+    };

-- 
2.34.1


