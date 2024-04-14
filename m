Return-Path: <linux-kernel+bounces-144205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF738A431F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBCB1C209B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89616CDAF;
	Sun, 14 Apr 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OouyyuxL"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE656771;
	Sun, 14 Apr 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104653; cv=none; b=Mjvqh5NoQ1iK3kqh22cicoG0p5E8jQZFhw3dSWJvpmtZavJ0p7UJprTiGs6aGFtZ0deXhsybWWI11JcBmXbMOnqfUEwaBiGCot9p/lWFmEebjR65xtkT+LOKFXX6BErqYj016HqNZ7fcVVdKOYxS92cZpUSTUfpWd2TsWTgSOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104653; c=relaxed/simple;
	bh=jr0C6sNwIGJdObduli6FVCaxDeCtBKhG3NSdzuSaMGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E78s57vs4YSFRkTglFhqs3F7M5J8U0mlKOF++qqJ2g9t3pFRM11uDhv/NSEkmDBWSFqAu2xWrBi67uDH+5WtXbnkIHL+v3llWVI83XsRbP/oxgV+4byFHqa1pcHvVxEpW7t/Svu3CHKoc79TDB9CLLUYP5y7hwMiV1S7EmqRGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OouyyuxL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CA0DC0006;
	Sun, 14 Apr 2024 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/M7MblF5FojAIwCImILZRFXjF6A2YTa3pBx7P1LIj6g=;
	b=OouyyuxLlB7BmRIgJpeX9rEnWWkdS/IyqUkH+PfXC8X/84NzbTPqbL3YvIL6mYlPkukm4R
	kcD23e4Y1c/lFg/u8DHNUduUzKzV2KF1vQBkZrs/t9Wj02w9/Lm/eZcl/OP4SDUMJBb347
	nKZDLNlfbf9ADWgXkDTHZssHxKWYYY397ztRCI83dLXHt4w/ujTnlgX/KqvlACHm4Ri9Nd
	pwf6L7hE72/A3+vaQUKSzfSFIuSMRGUA9iSyFP1lbD9nWr/naGg2omrA+4A/Dror1iN+gJ
	bEDhxabB1Z7Ao0e/Jr9YKYW7w9wDLavKnjD+VpdM1mgwZkLpjub6RTwE45dHww==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:22:03 +0200
Subject: [PATCH net-next v8 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-14-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add the PD692x0 I2C Power Sourcing Equipment controller device tree
bindings documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Changes in v2:
- Enhance ports-matrix description.
- Replace additionalProperties by unevaluatedProperties.
- Drop i2c suffix.

Changes in v3:
- Remove ports-matrix parameter.
- Add description of all physical ports and managers.
- Add pse_pis subnode moving to the API of pse-controller binding.
- Remove the MAINTAINERS section for this driver as I will be maintaining
  all pse-pd subsystem.

Changes in v5:
- Remove defs used only once.
- Replace underscore by dash.
- Add description.

Changes in v7:
- Fix nit.
- Add vpwr-supply property in the example.
- Remove ports references for the manager node.
---
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 169 +++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
new file mode 100644
index 000000000000..828439398fdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PD692x0 Power Sourcing Equipment controller
+
+maintainers:
+  - Kory Maincent <kory.maincent@bootlin.com>
+
+allOf:
+  - $ref: pse-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - microchip,pd69200
+      - microchip,pd69210
+      - microchip,pd69220
+
+  reg:
+    maxItems: 1
+
+  managers:
+    type: object
+    description:
+      List of the PD69208T4/PD69204T4/PD69208M PSE managers. Each manager
+      have 4 or 8 physical ports according to the chip version. No need to
+      specify the SPI chip select as it is automatically detected by the
+      PD692x0 PSE controller. The PSE managers have to be described from
+      the lowest chip select to the greatest one, which is the detection
+      behavior of the PD692x0 PSE controller. The PD692x0 support up to
+      12 PSE managers which can expose up to 96 physical ports. All
+      physical ports available on a manager have to be described in the
+      incremental order even if they are not used.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+    patternProperties:
+      "^manager@0[0-9a-b]$":
+        type: object
+        description:
+          PD69208T4/PD69204T4/PD69208M PSE manager exposing 4 or 8 physical
+          ports.
+
+        properties:
+          reg:
+            description:
+              Incremental index of the PSE manager starting from 0, ranging
+              from lowest to highest chip select, up to 11.
+            maxItems: 1
+
+          "#address-cells":
+            const: 1
+
+          "#size-cells":
+            const: 0
+
+        patternProperties:
+          '^port@[0-7]$':
+            type: object
+            required:
+              - reg
+            additionalProperties: false
+
+        required:
+          - reg
+          - "#address-cells"
+          - "#size-cells"
+
+required:
+  - compatible
+  - reg
+  - pse-pis
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet-pse@3c {
+        compatible = "microchip,pd69200";
+        reg = <0x3c>;
+
+        managers {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          manager@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phys0: port@0 {
+              reg = <0>;
+            };
+
+            phys1: port@1 {
+              reg = <1>;
+            };
+
+            phys2: port@2 {
+              reg = <2>;
+            };
+
+            phys3: port@3 {
+              reg = <3>;
+            };
+          };
+
+          manager@1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phys4: port@0 {
+              reg = <0>;
+            };
+
+            phys5: port@1 {
+              reg = <1>;
+            };
+
+            phys6: port@2 {
+              reg = <2>;
+            };
+
+            phys7: port@3 {
+              reg = <3>;
+            };
+          };
+        };
+
+        pse-pis {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pse_pi0: pse-pi@0 {
+            reg = <0>;
+            #pse-cells = <0>;
+            pairset-names = "alternative-a", "alternative-b";
+            pairsets = <&phys0>, <&phys1>;
+            polarity-supported = "MDI", "S";
+            vpwr-supply = <&vpwr1>;
+          };
+          pse_pi1: pse-pi@1 {
+            reg = <1>;
+            #pse-cells = <0>;
+            pairset-names = "alternative-a";
+            pairsets = <&phys2>;
+            polarity-supported = "MDI";
+            vpwr-supply = <&vpwr2>;
+          };
+        };
+      };
+    };

-- 
2.34.1


