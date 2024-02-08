Return-Path: <linux-kernel+bounces-58125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F984E1A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E91F237ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661D85C62;
	Thu,  8 Feb 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FzIdas9Z"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804A7EEFA;
	Thu,  8 Feb 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397813; cv=none; b=X+GLFx7NK2zDtoHHOanJpVpJmpaBh8anZtvdbFGgRSKNsFoOqpM2sf48YqJwQH5abuywF26dnSR5mQiYYkRG3VqeeTgrf3L2rs7+XDgQQjOD8LU7YsFfmC4mMJ/FUL0rlmSYBgrcs6+bIJ7jDUdDiClyoBDnHOrJLDqHH0NgFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397813; c=relaxed/simple;
	bh=jqnYlgaXLMzYuH4LjfkpNupJn5BIEgbBBQ598xxZShI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnqWyhIF1TEWP1S3XKx7d8md9/RYoeLXf3QKD19TWHVKwQURTSWDOtF1QXuL/5ZPIH9/7mPVeT40yWb0c8DgpDjrK/JWK8DsVadBnWovu9G366z+oNf3nIjn5bRYmSoXaN7LAyqNbLGxN2TfhlBaqrlTkC3yfqPlY77cUUHsthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FzIdas9Z; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6A021BF203;
	Thu,  8 Feb 2024 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVmOdG75ilt1TdaWC4koloYDTkgPxuUNMS9OlBOwSYA=;
	b=FzIdas9Zs6OdEeA2SuodmgqUw7WVK7d+iqaTZfUAvgHUO9KEjxZ9/e/7+cK05OtIEwB9E7
	lUgbXn36uizuzAU0UrX9nG1HN5KXbGltEGeXAH5R3NZW3Ek3BKcdvKhqcaAZDBOyZfGTPp
	TOOWbkF4FxZIKBHCKA5Q5Xdw6L2+ul105pLMRFJvKLoydjpKD4YMZgQ9qxO3wgCX4v9qEK
	NxN/fE8KEYa4aQrTqhRwj+5WJ/oZ5yARYbhAp+03LZH5sG8olp+G/T/sSmA7pD1JDyZe2M
	XrxI1nuB6h/XDtkohpKdbnVBL6zRArbz61/9l4JGbgDNd2Fng6G7SVTtRs9K+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:51 +0100
Subject: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
In-Reply-To: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Add the PD692x0 I2C Power Sourcing Equipment controller device tree
bindings documentation.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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
---
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 157 +++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
new file mode 100644
index 000000000000..57ba5365157c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -0,0 +1,157 @@
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
+    $ref: "#/$defs/managers"
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
+required:
+  - compatible
+  - reg
+  - pse_pis
+
+$defs:
+  manager:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      reg:
+        maxItems: 1
+
+    patternProperties:
+      '^port@[0-7]$':
+        type: object
+        required:
+          - reg
+
+    required:
+      - reg
+
+  managers:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^manager@0[0-9]|1[0-2]$":
+        $ref: "#/$defs/manager"
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
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
+        pse_pis {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pse_pi0: pse_pi@0 {
+            reg = <0>;
+            #pse-cells = <0>;
+            pairset-names = "alternative-a", "alternative-b";
+            pairsets = <&phys0>, <&phys1>;
+          };
+          pse_pi1: pse_pi@1 {
+            reg = <1>;
+            #pse-cells = <0>;
+            pairset-names = "alternative-a";
+            pairsets = <&phys2>;
+          };
+        };
+      };
+    };

-- 
2.25.1


