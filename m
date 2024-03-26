Return-Path: <linux-kernel+bounces-119458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2888C935
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5202C1C637FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6713D25A;
	Tue, 26 Mar 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBwq5aBQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866213CC69
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470523; cv=none; b=dtVygB8hK9AlfW5Hx+kc6hSB8UGFIYQvOvkDiOoktvqVHut2COn4m374oY1IDRo8AtD0kaO7PbHZVPFIlfUIqgBflh0bD4+lxYKqlxM7GZr2gUBb+xEV1ZALEHesPM1RLYqsnDMOhCWcFbkEev/QQ1kJoax/MyJAUSfucyc4fhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470523; c=relaxed/simple;
	bh=YamVkfgVhnxdN0nuqUEaGc7/CimD3+iO1qHB6FQRmek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5AEo+pC2BgiyEVLmspaVdWFWGXqgu7nfJOVuqMnhI4b5194zVImLbPs4UNGReXa72jLpjO2ai4yXaD7LWwovTaF69n0T9kpd7LO553cun1GjSVGuPEWuPVg5nqUeCVwAqenmSiYabrUc0CeC8cyqZ962f5hewpF3b/CL+WGgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LBwq5aBQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so754719566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711470519; x=1712075319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21TlRVjoWnFJstWCWbc/kPU2iAo+CaLQkVmZjbxJqtA=;
        b=LBwq5aBQXRY20Z91AA3iYVB2qUSnCwnY0wgatniR3WxJp3s9s7s0iNbMtLKmN5Xwgj
         nWiaK+od75ALfY380+yIVSxoppYUL/kLjOx6Wdx5MhWireA/HA18gEDKRLR94qpI6vuW
         V/KQQktpJpJ5cIucqFhtnPhxrThObW9q7SbPmg1Ntc63XC2aPk/dlDM1lzdJvyWojfWQ
         +vBThwX6LEVaHf7rBhNzHWErHwyYrt8q177k6ADI3LS4ZQY1l2uFKMQbwBh0+JRQP4Qe
         WrzM6pNgnYuPV1kgWOMa9wTVMSyuZIk1nTLm3gdARgBu92KwR0vXkXmWaI5zYbgkS1gW
         tbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470519; x=1712075319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21TlRVjoWnFJstWCWbc/kPU2iAo+CaLQkVmZjbxJqtA=;
        b=mFYNf/JKaiGDPLO6pcMAqfYTcfvU/kG9+ejNBmZUkL6udKVLtjEL4xX6jp0AA+0M9Y
         PXHhBR2NzxoYWpMRvOlrIqSP8c6zE4ya0a72RKFu2qALHjb+VzqMah/etvm8O346gezb
         3b1URbebqxHPYjk4FxNLRIULirOt6RF5P86grkvf0WF7Tsv9RlBMf0TI6J1x/OHRZZYk
         9OkdQakepZapWwOY4XAyZCKDkkcTboZNKa+u0KapsclbMy9kCFHOfkWcC7kdWGDTJFXh
         UzXNwprymDTtcL8at4AR+VerpzVSIwLSAu8Clo4iVu23/ewiDBBUIhGvjsG27ujZHflJ
         L8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVi3FF/6E++bVnyZt/MJKOy5tnE3UDEAiFOAi12McbmbOBTEnPo37DG1L2w1xoI6HLmpLuM2TrIQQJcZ8JZ7vGSFOC6e2b6Hj8h8ksL
X-Gm-Message-State: AOJu0YzqUQQrG1w6Bds4YFr7ky6zfed2XveIjKdAE2EepWL1F2x8flb5
	Z6KHLTNDtedIiwgMz96ayRSfE+3jvNbnh0865T023MKaixGy3rzw1ByoANoI5+c=
X-Google-Smtp-Source: AGHT+IGed6RYYegytLLJEvd4IRwiScyADdhypb0dxesLrpFiAXmkGzv8IRj8uH4ltIetznMTCVs5MQ==
X-Received: by 2002:a17:907:8694:b0:a47:4d61:de44 with SMTP id qa20-20020a170907869400b00a474d61de44mr6699025ejc.55.1711470519023;
        Tue, 26 Mar 2024 09:28:39 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906b09400b00a469e55767dsm4375051ejy.214.2024.03.26.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:28:38 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 26 Mar 2024 18:28:16 +0200
Subject: [PATCH RESEND v6 1/5] dt-bindings: spmi: Add X1E80100 SPMI PMIC
 ARB schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-spmi-multi-master-support-v6-1-1c87d8306c5b@linaro.org>
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
In-Reply-To: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4212; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=YamVkfgVhnxdN0nuqUEaGc7/CimD3+iO1qHB6FQRmek=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmAveurS+krQLbG3LbSzQ/3ngLL4be1mc194dov
 qz17LJyvBWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgL3rgAKCRAbX0TJAJUV
 VmEhD/9Kax6dsIm8lqYaUwHdsl3gy7HPX5wpmgFpViXDZxM/V9jLNEyTWLWI7gEvnkyCEGWU7L0
 giNfadM3k0Q+LLmD07Q3NbtSen9F0XojNZb2qZrvDsss8w481lYE2bRHirMyauYpBPhIGpjTiPV
 w3hVuqFt+5dCMBT4XOMr6b5+FM8vOD1T7AxkSQika5CTzaitXXr3SGBMYhckwdQeMh06ckqS5eD
 GqCPR73FYEoUPJv2Rud7U1OUy/KmIzL01Askmt4PthupD3hgRaMSmEJDEjK2B6HCs+2wvdSW8F1
 vzpYgg4veOZfc5bDVoPNnkGOZijg6P0ZEJa/1EsgXBXA1tnzItEJiEzb4Hund2Z3coTBXjtoAZZ
 yqEiAkqpnRrKGDoZ3zZ59jluu1mBPkGfkHCzvzDgW4Ak9qZwcdOHVHKCK1XFsNmMJoQapgOARtn
 g32yfnaW/GrhmvJ4P5ORMI/i+5i92TfRYcSZr8/3HL1ZAarG9vXtReT/wBItb9d/9RNI8mhDJ3q
 sL5HW+b4eNLTt0jPafe0fkU+W+ntc52CohFmaJWABnSVDKsvh3A43kQJe3ArNWQGc6zVD/zG6tL
 hQ13pecnVzRR5zBLsfCaA0806jOXv46khOM/Sff1uamKrwLpAnNziRyiLy8gT7pnq/5ymmC2HWo
 VZkMYuzEYszTnXQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add dedicated schema for X1E80100 PMIC ARB (v7) as it allows multiple
buses by declaring them as child nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml | 136 +++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml
new file mode 100644
index 000000000000..bdf362c4a147
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
+  "spmi@[a-f0-9]+$":
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


