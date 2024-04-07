Return-Path: <linux-kernel+bounces-134544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3AC89B2D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2C1C2108C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86693AC0C;
	Sun,  7 Apr 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYB2DPKZ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFF3A1CA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507026; cv=none; b=NG5e3NhY2ZJJdXD4rh7nJCvPO+TbnFeSS+53/UPqqDEwUlTwFZtRwq/D+/lDAa3jbEPLPEa/zMlzfAYhJDxKepXuEvR5Qhqu7tw8Bq/5FYw0cmfyQNHwpwGNYyLwBdvV9OcgfuwYEe5wl3B+sZEIK4FbJ4hisc32YegsncBFU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507026; c=relaxed/simple;
	bh=JVkBmCam2jdYO9LinquGWXrAvLM+y7WEW8TtTtGRCWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JerZapaaVgVm7/uSAJK6KWIyn7sM+iSY8kLKvwCzSXfBpEACf58kBh0Q+pq/2/bs3tMvztlM0ukNw/AR+AyMTcjhaTZz9VDF5oPAt3RWcrsr5X2hEfH9Nh21XcMWoQwg4ociII9CCPVUVcHUoZ649p0qdukt9vNkdRN9GQCvB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yYB2DPKZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5199906493so333585866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712507022; x=1713111822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRt6rM9Twb56M3ayCf2fMMjJ0a9uWjup39IBritYyoc=;
        b=yYB2DPKZBqvP5Vz9ZjczZyK7J7vaQMe8q2DOBqfspLOl3RpZ/LH33o9hyVhDPDQNe0
         eH3mHQE4k6/dZNBkKmFEEV9df5lMmgDkCYxFWEn/XE0i9UUlXUSMo9K+fs3ERmgW2C2h
         vYCa5yoJps0kLUW/nlhwh2nvWDqt+PGzZ5I8N+e4RI7bOBbdLxR4vQagorvYXDuecJ+u
         gSQo4eSAQBH5Lxc/Rh7JsECViYqXFX+oB9y6c7fktSoyqzd5CaufqzMgHoOWuHDHLxVs
         OdXycCTUQ0xxfw/QrZOkEzm9svHQ6dY0LXipPrR6+oVW4/cjyIKAFb3nxmUVAD0gupJr
         5qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712507022; x=1713111822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRt6rM9Twb56M3ayCf2fMMjJ0a9uWjup39IBritYyoc=;
        b=amgAbq5DtTzk5Pf+CAq+egTDE9389NZBsYDRxPdNS0T0rhOVWRaz3/QWNW3pTVzO0n
         cKg+mR59GL3y2lIOQUweMEbu1GprNz+stkNPjvAeZpAjBo0Ctv+cn2Ly3xsAoEFc92qJ
         f5v4Q3vMulFjxRqKLrOlZQeFVWXpRk+eX3ZdtsQk+5ekEnCHCramNxJdhbjP4ytkzxYG
         awPcDfQ4hvPgWPQtKxdQtQfinNkVSSFUL5GPf5InkLttLKforZ8I44qU+AylyACtBCYk
         abjKodydIvyYBybgQEWNGgi3hPz4Fz0g7fAJAO7xlQGzQbLzt95ufx9v3WQxx187cARt
         Bj0g==
X-Forwarded-Encrypted: i=1; AJvYcCUi/tbHvUKJ8r+Q+ejW7s7aj4ovPaLI2yEnXwHAjwEN0bU6CX01CNcdKpD2YfB6uQx8clqouxYGefBb0KV1JYnZjbnVWLfASaeHrnqG
X-Gm-Message-State: AOJu0YyP1JHuFIvdOFHZjn7FxJYfYSjVnuf31dJ6lA+B8GxuU9E8BxXA
	7g8xX/7tnRaEWd6IHQcQEg1YyILPoVLL+CFVCSxNz2pwxViR9pzzC4PQVYHZBsE=
X-Google-Smtp-Source: AGHT+IFByAhkWASSEH7HI0Ywz4AL/IJfpKfRcVOuocpKS+0jAne7bJChvlhu2fEdc9QBGBtBA7zj8g==
X-Received: by 2002:a17:907:6e87:b0:a51:c1db:659f with SMTP id sh7-20020a1709076e8700b00a51c1db659fmr2880334ejc.9.1712507022013;
        Sun, 07 Apr 2024 09:23:42 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a51bed388a4sm1811626ejc.139.2024.04.07.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 09:23:41 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Sun, 07 Apr 2024 19:23:21 +0300
Subject: [PATCH v9 1/7] dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-spmi-multi-master-support-v9-1-fa151c1391f3@linaro.org>
References: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
In-Reply-To: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
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
 Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=JVkBmCam2jdYO9LinquGWXrAvLM+y7WEW8TtTtGRCWc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmEsiCcr851qTRXAH7gE1SwkOFNYU1tGQZBb8B/
 9sEIdFUhtmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZhLIggAKCRAbX0TJAJUV
 VtRMD/93s27RINnTGgd8p2L9n+6axxSTC3sxduApeGdowZfWkWWzP9VnxFu4rkRZTZ9zTrpScTY
 4K95GNeofSNDTengwSLf6mvajJrYdtE937r6A71QgepBaMO0x8l60XT5M++iohjU/OnHBAPHSic
 4k/5HID0me8IRvKkBzzPm+KjBNnH19llmxP0JIqblS+Ljg0yLdOWo/Y+Q0FHZa1amN/7ZbdbpZt
 8RgXeYgxZrA4MP20Z9EhbmJizDAxehPw/fz9x9d8E9+5TOSjpePlEn8JssBENKbep+o2vJcVUEa
 UXqFGVevN53tDiPWvk+QbU9HjTRgwKI8Qw/Gzn8sPwmqHpA+ncuMNUAxSWqm41siYHokFrEehMK
 z1gMJ218Oo6cbdeRXJB1des95Xm/I0JI7WRukNyEEsY16umZgqdgYpDR7OFvflkQv6aTOi+ntel
 LFtixjMIrOb9Ry0DlPtei38OFWxs9k9FG9swucvwHGOnYKX5L32O76g0SGVU1d71VeE9LiXYNcd
 veRBOfBctZhIz1zxxQEedS+xsvHQYod0+f43MSrRU4F99mVEiXXZQOvptpzroMH2ky2aj/dtfrf
 10aRzRLhVpnRR1GU/oNKHMWySGd/w3F21Vhywk9fs0fm3S/sJ38++pwATlnFP9qx2OTzI158ENm
 GCNqbg8y3ho3l5A==
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
index 000000000000..a28b70fb330a
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
+      - description: tx-channel per virtual slave registers
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


