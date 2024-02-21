Return-Path: <linux-kernel+bounces-74730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF985D855
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C02284648
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCD69D2F;
	Wed, 21 Feb 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqcwFK83"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16569945
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519974; cv=none; b=tHVOnb4SLVjY9bbZiUjh0rUJC75MUnyzcVVfU7+gScYfxy+JwnbpnFWxfuNM4kBIinnN4zGw1m81XR95pN+wbP8eZ0bZaH+/VoydeoATis0m+q8miQa8OBmEbydiu8fxd3CTHkTf2bRwyLJ7QFGr7FibCXnadLggNdug2vB0WyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519974; c=relaxed/simple;
	bh=ThFF7MydSq7GIulN2BiuLPta4fGlEnJTyb85puKw6/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rO/Z0fkNwxoGUOEHbGdDYJL0cZjdEQZc+v0JHcUPDfK9BTRHobkdRc4zUp8h9+CIogEksDQX8V/GB0HEpcJ3qIn0h/m0hgf2vln69mljGiSaHWOhsozH+EX+3V65e9/0WOKk+6E19VnUcYPjWy8jveLcZ3j4x/uEFF5meleaRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqcwFK83; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so5154607a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708519971; x=1709124771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjEaHSfzaAp92cc1QcNapWfjcTbk7tItlWQ+9zi3zaQ=;
        b=XqcwFK83uW+/fwpsHlrWntqAutqc+hzNruhqmcfxkIoc8dSOE3VGdYPcaSdfAPDUGb
         LufxbALFHbL+B/3uefdjPDMnq1cP6KVFemuPJSt5nnH/JRmWnVE1l/QV0sUzFFM7zoCc
         mqEDVV2jpvhFfrVGfMB7PiVVyziM496OJ/EE3ctvHEs7AZzjwnU0ttaMtiVGK5MKBhBa
         lZMSk6xPztixHcBItN1hTF9o/YCOZSE0nTZ2JPwJc75LigkGGWS4c19uWdzH/D0bwbOV
         n8Rb2Bpnj7lxFHZ6/+McfpOiC+ZPgI12POpNiCZnmjW+sL/gY0Pdg82I5FoeWVlwd3Ps
         SzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519971; x=1709124771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjEaHSfzaAp92cc1QcNapWfjcTbk7tItlWQ+9zi3zaQ=;
        b=GiSkCRxROZe0WdywY3zVEmvNhNHpezAIx1gy0UN0z5LWCtELasdrYtgU21/xfFnTul
         3uSs6TYQatiKnv8OQQ+n5o/WmL3EyOAUSOltVFu5pM10CLGpsVUBXNaigHnsefXxkeQz
         eCLtMSog6iqUoVK9xVYSPfms+ZZV5iLkrvmahqmfwyRedtB3UCoilzefZN/AGlcXxO9S
         RE0ocHlY7I4egM5N2RnRuclfUOyFmcdRTAn52tSyYeoDyRFtFOcslhgxhbOG6okkTXOu
         WEsJbglvLu0xOrx/KhRaw9xagPTOeZKlAcXgK3DOfaUOP4B78VmrAuXzzGKmXwSXelnx
         D2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe+MBAqS2CnjbBiEoh+O8c57xPQms1OdtOw120kuZ9baNtXn/wkZTHJpWuA4r6pGwpYOFgL7KllR4/K42w46zq8yFSjV3+QmhpjkdG
X-Gm-Message-State: AOJu0Yy7isqihtQl/5kRmxrX77sm+owhfgfvECjbOImjzY5joPGQOb/L
	stRtUY8gh5Qek4egwpxxlyEXQv3HFxHpK69os10EZRjtibGXFv8OmiC15XIVNdI=
X-Google-Smtp-Source: AGHT+IFfJb9m3usN9WfSh2Gve+kZOuvECibupHZOqpQ5qo7RskgYkY97KVcOy8RHrkzjTD7vGyfOjQ==
X-Received: by 2002:a17:906:280c:b0:a3c:cbab:f3b with SMTP id r12-20020a170906280c00b00a3ccbab0f3bmr13049387ejc.23.1708519970972;
        Wed, 21 Feb 2024 04:52:50 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id tl23-20020a170907c31700b00a3da5bf34absm4930392ejc.207.2024.02.21.04.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:52:50 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Feb 2024 14:52:37 +0200
Subject: [PATCH v5 1/4] dt-bindings: spmi: Add PMIC ARB v7 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-spmi-multi-master-support-v5-1-3255ca413a0b@linaro.org>
References: <20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org>
In-Reply-To: <20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org>
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
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1fIbsBAWlgDn3Auks4oUMtCdpsV6ZLQRxy14G
 UE1bSMXsayJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdXyGwAKCRAbX0TJAJUV
 VozQD/9cX+W+CF+0DET2wbnV6ncUZ2kIluZYFSgDxC5qHUv815UvVAuTboCqCaS54DfkpJIyDpm
 IHD0MR5pAybsIbVeQElw9VSZbPt1sUW77xXFk9Oyv/c513YyWGGE9c7XaF8Ua5F6vsu76NQla74
 LOIeZuBAohmgeEoi5hmup4+DqquXYh1qRKymTeFvmfCeIgld+SFmumEwoEW4So+Zi3dx91wd2Ex
 seZdohykYsRo0nvwh8nG/CTcGOYuMVkOtIJuX0RJaXx9+H7uiSY+m0CHhqWhLRDTeY5qXq9ZmNG
 0uAtx7KqoPI/Z7OnvqiR+tAdq4xrZahFnL9fRhdOl8gh/Abit8mQ89A2fAte9q6IpL8mFY02SdN
 abBIOz93Eucxmc2HOvKU8sBbUDliDL9vcxI/vydcw9rEskX9giXgdEjoXhG3MtpSG6/eAYtmZNB
 xmnZAw7xbPA06M5POqAplGiQWsLyOHfzHzR69qwuPDN1mBON63fJaB/FffGpEyRZrB3Vq57p0Ca
 z9yRDHsZoM7qvoXMNWeiDsTyCyVXe+VNvv8U8G4vOoYL8VzsL/wWaSDUtmYFQkTXhZnERjd/x9h
 cg6uXv20+36PSMX0YeVPstze/6hdbSN1mU0Elh9QsUplbEWtZ9KozspOgulGx+RUTrR7shTAtL2
 mrd+c+s3N5Ppgcw==
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


