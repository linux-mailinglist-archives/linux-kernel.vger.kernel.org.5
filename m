Return-Path: <linux-kernel+bounces-127897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7D989527B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2028765F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45EA78274;
	Tue,  2 Apr 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBnnSfN5"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB526E602
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059681; cv=none; b=h0b9GYvf+GUjPeS4DMXSXMxG+NSQMghpMbombWL/fdj5MDkBak+mpJfS+90LUf+inyHPhDn3NoBTQ7EqDIH23IWW5MQsL9HxfbrqH+lKaGnV0OCN0hqdTCKL2OrS+IiklVWjWRIHsuVdK/gUS/M/wTF66PXTldI9f3epUYcO7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059681; c=relaxed/simple;
	bh=H2L6hk3BSbGZWXsaMqnOwDhN0rNiIn1lAFbUz+5zVTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZhcKR6b6iwi+FRzQ7B3AlBqMl2MjsI6FjazTDT30ZwUuo49bNEDGAG8/aMI4lWgCfJhOqxhPIbHNDo8CI5PD8x5kk0FsZFbObat5FqMsVtbOk2n2c9re4mhaelU8uWB4KSsZBioov7CdD6NpxyH238MPOWJZCwvRl4MIvmQfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBnnSfN5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a468226e135so610486466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712059678; x=1712664478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0l9XqgR5rgZt/McZ1+LYeV2+Ae3g0xUIEFWoqdq9PI=;
        b=MBnnSfN5Jk0Ktd6h1QNuvR6ftInUZOne11unhgCIHkl+aJGVTMN9jVdYdoVzzP/+iJ
         m0hEz3wIJDN/5nLauEyybGRKFaFnxueCnjt99yXWs0SrWHrT4kh7b6UBlPFTRbpEb0kY
         mGSbkPafNxbwS5x0W8EtjaDM++AHpBB83vLopV6SsooecdX4hKJ8ZLIJnxW/d9gKu10o
         frh+HHXy0M3LrAJ0ckQR1PwBZDVwZZRGP6OrC9ZP0peh7scupZ/xWoinze4W1J1xiA92
         c+J4sA8gKZqhupO9Dk0PfWQdTCq+X8WqILjQaKe2BnlrwXNdQTQUumrIQouzPM6Rk/0h
         st9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712059678; x=1712664478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0l9XqgR5rgZt/McZ1+LYeV2+Ae3g0xUIEFWoqdq9PI=;
        b=mUdCgcjDwE9EkhNpSaVsu6bu27ogHzcvp/orvV9ZnZRd7VJAd1/5p/TIiQ30dNC2fe
         mI8drRpIgv1UOaq7K7STU0+YjwheU1drRq/MUXF73I1rcHGnvgYM57+QalSE8aeKdbbP
         MzowkZcbNCDhXiIUEJt0pnC1ekeNyvDNUIJGegyAwyvJB4ygYTMRTwD7aL9oQEHZgk6z
         IRa4LxcEcd6itp+hPUOK6V040mj9lQarVjxhoLCKVpSl4tm/iDpB/2Q+SLwGKHVyMXrV
         Jl78so4W3ZmVVSpDmH+1UMH0LakcLFcng3W+q/KCWWlw+VzqDMgyDv/IPzpkyAJHbGj6
         DtMw==
X-Forwarded-Encrypted: i=1; AJvYcCXi+SkIVmHmOFkTH3aOt62jQf/8kJWJjDghr1LOQLU1sdqAooBb2lMfV92PbA/vlz1fD1Z0ADX8J3q7F+A3EKYE2Jd8PF9VODNIpY+J
X-Gm-Message-State: AOJu0Yxe6yU567RxcoOeGL+VbFZPluW2n8ZxzxmrT7J/+PN3Z8yO1KXN
	BCAI3QwqgOh1Ocf8A2b6esjB86zxuvyr7U4nJzjGFPh1LaILGv9ReEgxop+2BK0cMcu78hxf9OT
	9
X-Google-Smtp-Source: AGHT+IEJul2UyOBnNzX9jiFv2kE1saST7wjLNXY/wrt3Zz1YliDjZ/vc/6cnOv5WctEGKams9g+fsg==
X-Received: by 2002:a17:907:961e:b0:a4e:9197:7f21 with SMTP id gb30-20020a170907961e00b00a4e91977f21mr679253ejc.30.1712059677980;
        Tue, 02 Apr 2024 05:07:57 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709065a8d00b00a4df251a601sm6519384ejq.77.2024.04.02.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:07:57 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 02 Apr 2024 15:07:30 +0300
Subject: [PATCH v8 1/7] dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-spmi-multi-master-support-v8-1-ce6f2d14a058@linaro.org>
References: <20240402-spmi-multi-master-support-v8-0-ce6f2d14a058@linaro.org>
In-Reply-To: <20240402-spmi-multi-master-support-v8-0-ce6f2d14a058@linaro.org>
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
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=H2L6hk3BSbGZWXsaMqnOwDhN0rNiIn1lAFbUz+5zVTU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmC/UPXfe0w39Yxj5a+0jZ+tGvt2H1SNZQbKYzl
 nglHQRsoHOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgv1DwAKCRAbX0TJAJUV
 VuamEACbNcLnCQcnz4W18nC7uDvgNVQB0DJoknwroD1Ma5Q7R0sJFX7R8Htqoh8oIvdJxoO/vrq
 iHkbdbyh9l0Oe5PuFdWnXoLNrd9EcCV/zxHnNOMOZbEev3qRIDf8tWsPMpSNFbtcr9AuLwGpBCB
 T4AA/c78OtLRS5S4NeKTDlDt1XlNDAQKYz4uYp90uYjC8TQZoMxckOTESiolJqg6//Hs/JCjeiq
 Dbl5T/d8divypDYuvcpxCv/ikxnW9SOIi9hQq83uYogMDL3sKbuPysObHynwCKlrgn3sxj9prTA
 kCD4zMn2TFfYDh+DatI5BuakEbKZwSitdFMLXZe/CZYxkHOH7gm1dj77skgRabBjucxG6xnwyAW
 x+oMx3hIHn2wuULBfWBl7WS9sjA/32Guspi4CVYzTATB68b+6W6zKemOtUeOjz6vdPWh2ctzxqi
 K2Z74OQpZVw8dydP1oJItac98gloxs0Y4IGmhYYVrDbbz4lCC8Yk/7DdjUWkXZIL15NIeaBiTnm
 bc0pCUM1JmTqktZIrxy8bb7iAWXjlrBhn3eupslmV+AetOZ0G45G+8XF5k35hnoGwK4w8ixwVwr
 O5srV5H56hWPW+oJT4Yg0ILukYwcfjpoNNUyb1dV+ASM8bHbW7cbgE6G3mzQqrrfqq59n0uj9rt
 wvxqwRk60deyWBQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add dedicated schema for X1E80100 PMIC ARB (v7) as it allows multiple
buses by declaring them as child nodes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml | 136 +++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml
new file mode 100644
index 000000000000..f32a7ae33b4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/qcom,x1e80100-spmi-pmic-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm X1E80100 SPMI Controller (PMIC Arbiter v7)
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  The X1E80100 SPMI PMIC Arbiter implements HW version 7 and it's an SPMI
+  controller with wrapping arbitration logic to allow for multiple on-chip
+  devices to control up to 2 SPMI separate buses.
+
+  The PMIC Arbiter can also act as an interrupt controller, providing interrupts
+  to slave devices.
+
+properties:
+  compatible:
+    const: qcom,x1e80100-spmi-pmic-arb
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
+  "^spmi@[a-f0-9]+$":
+    type: object
+    $ref: /schemas/spmi/spmi.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        items:
+          - description: configuration registers
+          - description: interrupt controller registers
+
+      reg-names:
+        items:
+          - const: cnfg
+          - const: intr
+
+      interrupts:
+        maxItems: 1
+
+      interrupt-names:
+        const: periph_irq
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 4
+        description: |
+          cell 1: slave ID for the requested interrupt (0-15)
+          cell 2: peripheral ID for requested interrupt (0-255)
+          cell 3: the requested peripheral interrupt (0-7)
+          cell 4: interrupt flags indicating level-sense information,
+                  as defined in dt-bindings/interrupt-controller/irq.h
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
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spmi: arbiter@c400000 {
+        compatible = "qcom,x1e80100-spmi-pmic-arb";
+        reg = <0 0x0c400000 0 0x3000>,
+              <0 0x0c500000 0 0x4000000>,
+              <0 0x0c440000 0 0x80000>;
+        reg-names = "core", "chnls", "obsrvr";
+
+        qcom,ee = <0>;
+        qcom,channel = <0>;
+
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        spmi_bus0: spmi@c42d000 {
+          reg = <0 0x0c42d000 0 0x4000>,
+                <0 0x0c4c0000 0 0x10000>;
+          reg-names = "cnfg", "intr";
+
+          interrupt-names = "periph_irq";
+          interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-controller;
+          #interrupt-cells = <4>;
+
+          #address-cells = <2>;
+          #size-cells = <0>;
+        };
+      };
+    };

-- 
2.34.1


