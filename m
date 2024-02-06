Return-Path: <linux-kernel+bounces-55387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A7684BC04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6D1F2742F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68214A9D;
	Tue,  6 Feb 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYraO9tY"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177513FEB;
	Tue,  6 Feb 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240785; cv=none; b=ru0G1Yz2TbOMVhPJXzy2gt0Ow8X6HDcwLOmWVM2MFP4nEl0CjekZ60KTAVkewFMHHuKn0SNpyRkokogJrAw+HBbANFdVWfxz8lRhAYSWBJJPnPfRTp7q/d++aomHdQPBp8Ay9YU7ieqCobW4DRpKjBMBATZ8CEYCh/yYGwLRPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240785; c=relaxed/simple;
	bh=jyM0CHznvQWMvjL8i2pVQYft4g2oYeiCv4EYtUJLp6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9SKTU9rlzQT26B9rxw0IxccK1XffIc8cvWYsPnVSxJDgm1Yohv79lgiGY5yx2nfydT4/ajjpQq1nk5x7rJ+5vVepPbOalRujxcbkhr17Uzh09bMMIFWxT/DoCyH3t9ItCIqkyW5HnXov+x6e8+DEWx+z0qAjdtmwMeLvcdnoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYraO9tY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so4438530f8f.1;
        Tue, 06 Feb 2024 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240782; x=1707845582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUmCO360MsO9JwRC/7FCAnzALXs5wMt0yoX0PpFvJIY=;
        b=mYraO9tYRpBMd77ANgg9cntTtmmEXkE6ZAiJKifnREfcI7SEF/uY0kt70L6H1wHpK8
         aBNQEa4Mqpx3uNZFIEYpV9xKci1zmYaSFhtj5ZB6n69Uey6wsHNfG+BsDbQyj4y8YP5c
         UVuMp2/qD3jsKrCbQLQrb4LcP60E6HryB/PLR5LDS8eUF4OtAc1+S0KyoYWaRbRp8HYv
         oZudVJ9Z8EEvuUaXYAMg4TPl9zX8K4P7cFo12DNievMAZ26w/uFufCwBjAMlMFBWUsVX
         N5eRREZjEJJPfhqPUZgadVVsVrE8tDoP/Ft9PdCGO1ep5M0eWRkzxmoYFwWlBcNAjyuO
         md8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240782; x=1707845582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUmCO360MsO9JwRC/7FCAnzALXs5wMt0yoX0PpFvJIY=;
        b=qQj2WAxVV8H4yZyIKCjI2kRma9Vtno/1+7M5uShRWCHq/wjw+HJC1MGY+PhEfqa6fa
         NQQRtOJSAssZx4LNi0I9DQ+/fB3lO/o8LVuzHON80xRy87K8nCiYKB2znPWu/uCbzRXC
         S6aEm4a+K1cg/WDMvof3mgtVY1ST/CMDTjaomIqmMgi1RPMVtMIEfudZV+z3Pz3HD0B+
         uIijIcl/P3cVnVdf9ZQTP/DLlUJ5qbP3R88mfxgVvfStuFSa0r8qyZQRjbmkaPPbwP0J
         m7+Qg5nkTjbT/820RFlMiMDXlugwnluSaEMYWUPdR40oyWDEIiMeJXXT5HYrRe/zmpD0
         XXjw==
X-Gm-Message-State: AOJu0YwQ+7pQaN7zpl1cZlJBHwd4wBa+2Lb/TPJr7ZntGiE2cKrmraQf
	MWWN/1dMuFjDjzkAvHZkXVGz6yWgigk9j2pX/nRgM/nA4RsI+V3p
X-Google-Smtp-Source: AGHT+IHQ25b8pHbMCRzU0RlrrHTuPeHh8SPAIjfmfRNSvM9KyJ8xn2r2pkf/PWkfOIY6Pwn3KTDlfQ==
X-Received: by 2002:a5d:678d:0:b0:33b:1577:a2d1 with SMTP id v13-20020a5d678d000000b0033b1577a2d1mr1401188wru.1.1707240781987;
        Tue, 06 Feb 2024 09:33:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUvkE6eU+hGhupY2V0J0OGIrCKJLP8PAqF8LlWaNyocxW+0ts+d2UlYoavbzeDD6M0V0Abv21nL4RHBl8CbbibEbjleYvacc//1M/yXNMXZZaEh+uKKa3dRYTZsPMx64jiUvHSTmw+utW1MrWy0Ynlc0lHpxOQHTmBydoaoBAoxlc4DyWTknl7w4rQtE+KEENVT8ThbeU4Oe6FrHf680GaJehPXXxksjEf3eWkOps3Stb2kaJR2rlyRTBtgKlJc3/MrtbxYiGeRmFwguWBNI7vBr0KG1OytBVlvz8Wlc6XtzvzzZ0fUBYqg5DPowoj5UuTVAM/ol30VcFzV107IO+Rh600MT3YkH74pMRUX4ZUE/npUcV8/M/Wpr0C5w2yR0Hfa4WSDaJ2caPMLS11CQfJjYWRiWBe3O2AlgP8g5ohp5JjzuZFy3sn7pa6mQ6nfFLBMtP/TnFdq86/NwivcVz6A4WXdA+dJPvZGcN0aPQ9xhQIMVqZ4VkLlx11o57LqjecYqIrQhC7SSUapXS8YEjxhUhyfJnrqlVcMBbqtVIrTVhEcpgbTVGlXGPC+5LElTgIn0Cq6eocUrhnnc6NXIA+zoP9rP/pQfe7aJrcsFWitZFgATqpS/DEvaM2v8hUIi2FTIl2jCrYl78cUmsfcHDhsVgIGfih0t2f4AqLPt3ePEayChUoh7Q==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:33:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [net-next PATCH v7 05/10] dt-bindings: net: Document Qcom QCA807x PHY package
Date: Tue,  6 Feb 2024 18:31:08 +0100
Message-ID: <20240206173115.7654-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Qcom QCA807x PHY package.

Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
1000BASE-T PHY-s.

Document the required property to make the PHY package correctly
configure and work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/qcom,qca807x.yaml | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
new file mode 100644
index 000000000000..7290024024f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA807x Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  Qualcomm QCA8072/5 Ethernet PHY is PHY package of 2 or 5
+  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
+  1000BASE-T PHY-s.
+
+  They feature 2 SerDes, one for PSGMII or QSGMII connection with
+  MAC, while second one is SGMII for connection to MAC or fiber.
+
+  Both models have a combo port that supports 1000BASE-X and
+  100BASE-FX fiber.
+
+  Each PHY inside of QCA807x series has 4 digitally controlled
+  output only pins that natively drive LED-s for up to 2 attached
+  LEDs. Some vendor also use these 4 output for GPIO usage without
+  attaching LEDs.
+
+  Note that output pins can be set to drive LEDs OR GPIO, mixed
+  definition are not accepted.
+
+$ref: ethernet-phy-package.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,qca8072-package
+      - qcom,qca8075-package
+
+  qcom,package-mode:
+    description: |
+      PHY package can be configured in 3 mode following this table:
+
+                    First Serdes mode       Second Serdes mode
+      Option 1      PSGMII for copper       Disabled
+                    ports 0-4
+      Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
+                    ports 0-4
+      Option 3      QSGMII for copper       SGMII for
+                    ports 0-3               copper port 4
+
+      PSGMII mode (option 1 or 2) is configured dynamically based on
+      the presence of a connected SFP device.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - qsgmii
+      - psgmii
+    default: psgmii
+
+  qcom,tx-drive-strength-milliwatt:
+    description: set the TX Amplifier value in mv.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [140, 160, 180, 200, 220,
+           240, 260, 280, 300, 320,
+           400, 500, 600]
+    default: 600
+
+patternProperties:
+  ^ethernet-phy@[a-f0-9]+$:
+    $ref: ethernet-phy.yaml#
+
+    properties:
+      qcom,dac-full-amplitude:
+        description:
+          Set Analog MDI driver amplitude to FULL.
+
+          With this not defined, amplitude is set to DSP.
+          (amplitude is adjusted based on cable length)
+
+          With this enabled and qcom,dac-full-bias-current
+          and qcom,dac-disable-bias-current-tweak disabled,
+          bias current is half.
+        type: boolean
+
+      qcom,dac-full-bias-current:
+        description:
+          Set Analog MDI driver bias current to FULL.
+
+          With this not defined, bias current is set to DSP.
+          (bias current is adjusted based on cable length)
+
+          Actual bias current might be different with
+          qcom,dac-disable-bias-current-tweak disabled.
+        type: boolean
+
+      qcom,dac-disable-bias-current-tweak:
+        description: |
+          Set Analog MDI driver bias current to disable tweak
+          to bias current.
+
+          With this not defined, bias current tweak are enabled
+          by default.
+
+          With this enabled the following tweak are NOT applied:
+          - With both FULL amplitude and FULL bias current: bias current
+            is set to half.
+          - With only DSP amplitude: bias current is set to half and
+            is set to 1/4 with cable < 10m.
+          - With DSP bias current (included both DSP amplitude and
+            DSP bias current): bias current is half the detected current
+            with cable < 10m.
+        type: boolean
+
+      gpio-controller: true
+
+      '#gpio-cells':
+        const: 2
+
+    if:
+      required:
+        - gpio-controller
+    then:
+      properties:
+        leds: false
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "qcom,qca8075-package";
+            reg = <0>;
+
+            qcom,package-mode = "qsgmii";
+
+            ethernet-phy@0 {
+                reg = <0>;
+
+                leds {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    led@0 {
+                        reg = <0>;
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_LAN;
+                        default-state = "keep";
+                    };
+                };
+            };
+
+            ethernet-phy@1 {
+                reg = <1>;
+            };
+
+            ethernet-phy@2 {
+                reg = <2>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            ethernet-phy@3 {
+                reg = <3>;
+            };
+
+            ethernet-phy@4 {
+                reg = <4>;
+            };
+        };
+    };
-- 
2.43.0


