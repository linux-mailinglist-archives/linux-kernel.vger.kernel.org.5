Return-Path: <linux-kernel+bounces-119131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3756688C49B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A792C1F807BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F912CD93;
	Tue, 26 Mar 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HZ5AvwwN"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4012BE8A;
	Tue, 26 Mar 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461909; cv=none; b=tActutQOTIl/uTM3GNYkroDsJAUGmCX+Em+bag1AcipZtCpMIQQ5PDNckhCCtPHl9rr5KVJxtOAybP4g3mWpmAsdRFg6ogp6atAw/6ZdDhdO1jcn0sdsrz9/RW74LxY6OWq+rNVYrf2NbIRAbr9qu5t73MJ5UEjrxD13cZnCz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461909; c=relaxed/simple;
	bh=tbhF5MJSgFtPpg7xlLxRK6ppUN1f53aYNaEvctfI+As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/DH7K1kcFSo7pCN6/+E39tu1ou7GoEdKRqoxQqDQ3QWTpOPs2gihFdX+JNunFoBysYHzJ1hXaWcOWW6c4+oEkILyqH6do5ZKPQsrcKbrbkrE9VeL6V0fBw2WNdc5cHmIjWpXCYx+EFcOoxVa2zmDXznlAyCL/41bSt3N5wg4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HZ5AvwwN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D92251C000A;
	Tue, 26 Mar 2024 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLeZSfa1oadxgzZdMz17QIBeCZtH39eC4E0W8mr1/dY=;
	b=HZ5AvwwN0nU4Bu8ILarA1Bg0aWTU1W16/qfm3Pa+b7jFkMJoGf8MaOndH2xPxNpNpKzvoG
	qP/ni3KG2bnhJA4LOb36NMm2JaQTk9DU/8M+WGIyrzulvj88Dh8IVFZrX1iG7iP1/z75qJ
	ix8+QKIThL98a/gwBJkhEY9FORADamPCvzD5SzsRbOOpXiI0XQ9IE62a+t/dgkX+XrnrzF
	csnocQ3feO5R1MXH9D2ySUEcO23hdlzaX2hh5/ev/dd7iUPMw2KiZ9QHhZjGZzOGDfL16U
	ressTQDu8J7IHte97WyvuJJMNa1UgeTxLkSu3PZxm7orijho93UkmXhI36j8xQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:51 +0100
Subject: [PATCH net-next v6 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-14-c1011b6ea1cb@bootlin.com>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
In-Reply-To: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
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
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add the PD692x0 I2C Power Sourcing Equipment controller device tree
bindings documentation.

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

Changes in v5:
- Remove defs used only once.
- Replace underscore by dash.
- Add description.
---
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 158 +++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
new file mode 100644
index 000000000000..62ea4363cba3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -0,0 +1,158 @@
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
+      "^manager@0[0-9]|1[0-2]$":
+        $ref: /schemas/graph.yaml#/properties/ports
+        description:
+          PD69208T4/PD69204T4/PD69208M PSE manager exposing 4 or 8 physical
+          ports.
+
+        properties:
+          reg:
+            description:
+              Incremental index of the PSE manager starting from 0, ranging
+              from lowest to highest chip select, up to 12.
+            maxItems: 1
+
+        patternProperties:
+          '^port@[0-7]$':
+            type: object
+            required:
+              - reg
+
+        required:
+          - reg
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
+          };
+          pse_pi1: pse-pi@1 {
+            reg = <1>;
+            #pse-cells = <0>;
+            pairset-names = "alternative-a";
+            pairsets = <&phys2>;
+            polarity-supported = "MDI";
+          };
+        };
+      };
+    };

-- 
2.25.1


