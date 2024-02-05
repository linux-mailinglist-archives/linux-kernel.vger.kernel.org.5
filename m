Return-Path: <linux-kernel+bounces-53043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5CD849FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06E5B24F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A4482CB;
	Mon,  5 Feb 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk9/mvlK"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB245952;
	Mon,  5 Feb 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151753; cv=none; b=TrriwhVKZz7K6heChCv5/f4bKwqlEbIitf5p5MXW8LljZSp4h8tJzkUaiqWXjX/acxmEfTiPNHtlybu3WZqCNANMQZx5wS/XteRLj8EtLA3aslitijCPzNp2v/N2JfEjVqPIsENEg48zv0jtUj0ensQEpzXKCeHRrz7f6G8BvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151753; c=relaxed/simple;
	bh=Wg5jJEedhsGjN5i61zC/V7MyghdP2OFcHkRYafvEIEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP5NxCziGNRoj9fZ5W3TYg3+5ls8gyln7Mpt8wiObPo0eD3BvYW6p07F59F3PVWN7JUqHcRAtTO1S6c6gZv7w6ccDn/CTQChFTfGSp9BABs97adKD7gjPmvmE7UUW9FTMF+0A56OIINCLoW5IHCezb1RekzB4d9rXBaGtMOcQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk9/mvlK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51137c8088dso4606426e87.1;
        Mon, 05 Feb 2024 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151749; x=1707756549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik0kKiOnA2UFtkx7hoizPBGiM4n98hhnoOpxjfv8+/Q=;
        b=Tk9/mvlKzD35K7pp8jN3qA+R6922dSPcsysx3p/t4pqFXiAmvqZkt/9z6r5XAwGMq5
         kRi5tyTIUH9FPYI4MCjVjKm7BHmLYFLetegqguYO/pYpIUXhpq8EpCrOIuFWU0AUB7+7
         HeT11UbD4qb2nWHc05w7rJWrKL8/8MtMdgMabgptbuvafTwgqi4g9iS6pdYWOwD7uroN
         h2BcdWDSShusw5iorRB56l+03AzHFRnLzPZI4D6+GrStZ5YYwbASmbglj+pFeMdLN7Mc
         BIzOu2+WXucrfSwXwtExikiyPqJrQqq5XQ9x+SvMyXTioeeitu8Jh1ZEp8VO3obtsDR9
         9EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151749; x=1707756549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik0kKiOnA2UFtkx7hoizPBGiM4n98hhnoOpxjfv8+/Q=;
        b=RYkOp4yF31e3mTKj13Em4q9ASCr/ACx31+NwlcET9ZDMLmt5fwnMDjC3BeuMTOvfJV
         IND2bxW+ei0/TEIJuoc4ASWxSvwMsAv/me1xKoi08nSXFmCZ1M6zJyyPn/ic/cXW35b1
         i9tCOD8p/ckvm9jR9rOlH9iFObIQ9g5MoXgUl5Nl/sSGlDVjU80CoK8JwH9fHaQYnVN4
         4IIxqAljKA9RBeIYo49kG/h0n7+0DozCtNktC1IUjh9um18EUD4kOpwxbUZHzO1/BujC
         pOZWyWztFZ8I072GRiDDQtJwx7x9NE4YFuTuQ/0y14KpsIvzSS/diI2SfgJzamQEg7xU
         M7WQ==
X-Gm-Message-State: AOJu0YzZb88rNxZIoxwi8CeTsCUW4+3vxqxWLSi8oNVaSU1FkXi6FHcW
	wSQ3rw+IA8yzvXtMhC5hfMZBdDsR3YlLPElaV79r0UnSuKDxLjDF
X-Google-Smtp-Source: AGHT+IHVM2lzBYD3zxtZEFsJBnV9ARYndrSilWtLhxFGRvJSsQwO+J5QwCtgEgJawGvE3w/2LEse7w==
X-Received: by 2002:ac2:410a:0:b0:511:4f21:4517 with SMTP id b10-20020ac2410a000000b005114f214517mr127917lfi.33.1707151749006;
        Mon, 05 Feb 2024 08:49:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVEugsGv/mOoWaB+lGOcd/WTHd4xopt3wV8dg/L7c1WXRbSj4gM6e1DnN8XemxWC9RV1Ixe9ZKxqm8HDXKw+lKXlk+07p5Ha4SOxPesoE4CYBWqlC08r5hr/zflxjLDEB+MxqmIhL+Gbe07Fk4r1XpJ/Wh8DZU5gV6Pby7V2Tq0neLXrTubnEZ9O3e5fCMBW07LZLlk6hpAh7B3aDvXB2JOHNQXdEH4RHovkBUGK6v4TpH7VtDGNeA1jM8U73m+A+ujskEbA+qv7d5pr9cb8HZMsejHKr4h86lOyg47Z9+ADxl5bvUP9/OdE+l0dWItymsGy3w3Eu3KbkCXrI8qXAm9J7eBtuxoHuF43nHksF82cGmtj/5ly6Z66bmQongnPpZJlLO3tn8Mli7s1jPBiBHcVM5gVy9Fs5+mb0oSBKsJTpUR0oNtLl3c9XVdBc3MM0ctOEYi83B5f35zEDH1dhVOTSgLN4lHmtF5JzY8czcLkuD04tq7A2hRPj+mNFSofD2NFSpRsD34nuO1sVnuTuuoEIktTKmLU7fiSjHwFxW1rT0jSMpdWV1Os7gJ2dStdtdyBVJglBI2NY3HiQcbNPZ4ESkdV2DOKWW29DNRBSvPCcLH0t1aoifGRhRB15lRoRk40lQUgo7DMRZ0h38OJB9cKuV6Uc25fq4x1hdr3JCe8XGrJkMog==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:08 -0800 (PST)
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
Subject: [net-next PATCH v6 05/10] dt-bindings: net: Document Qcom QCA807x PHY package
Date: Mon,  5 Feb 2024 17:48:37 +0100
Message-ID: <20240205164851.1351-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
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
---
 .../devicetree/bindings/net/qcom,qca807x.yaml | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
new file mode 100644
index 000000000000..021246cd7b3a
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
+      PSGMII mode (option 1 or 2) is configured dynamically by the driver
+      based on the presence of a connected SFP device.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - qsgmii
+      - psgmii
+    default: psgmii
+
+  qcom,tx-driver-strength-milliwatt:
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


