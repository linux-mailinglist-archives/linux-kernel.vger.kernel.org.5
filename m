Return-Path: <linux-kernel+bounces-83426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC08698EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A068B25135
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F1153BD1;
	Tue, 27 Feb 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BmK2eHwg"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1014F974;
	Tue, 27 Feb 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045010; cv=none; b=WNoudb5KLZFdoFAeXY6e+2vO4aRvq8W2iW/2xKgunNpwm5FZtF/xR+mYnh32f3w5oJtpEB8RYfjVeiRSfTyjheKphOYzTJBBQprlMA/DQkpcGGdRQAvPvkLCpMTK3T0+PkwJ6t69fyTV2ifKeve7VKzhKla8H9EaTN9F5XL7H1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045010; c=relaxed/simple;
	bh=P9ba8VS4YVS2ewe5zfVwvyvT4c4G8yVngF9UH/nnnDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSKNQlkTMi3k/5C20qWxjfpvO/b4mDPzeD5Xd7xsMCxyw6P5g3uYXLi6s0gt91ByO71Ypk5xXpQXzSf5pLrwGlXzsi54y6k9x00GERTEsRKurn6P2+UXAEwHBnCH3q57RRcycoqc00kgWjcryR9jB3cK8y/m2PKsrNPSDhBebRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BmK2eHwg; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03E9820002;
	Tue, 27 Feb 2024 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709045006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSZ/ILuosyRRQ7EsgLHagDHxoowXRN1aOIVGYsWym7U=;
	b=BmK2eHwgwWYSSkQKX5qGjt7xhy8AtHSl2xhI8C70WtUH2rhMxXh2H0tU5YnEVZ6wv7O8vn
	Sv5B+gXPZhONm/1PZzUInWdlQYrIRsODXNiPb26K+V6Cpk8V3krhJeb0c3erBH0ct7Oc1r
	FV89lTZXFzYygxUg1EfQKicOGMqTGJ+fM+8fHfESxeHL4lT1cJv37Z3e8HIN3ef0oJz7IT
	1f4ILbV9VSyW7LKY7n5NJLmRTwJegNftkX2eRRCevt25LEWckmL4bPfqFWIg5KtyCpEkO/
	XDlEhZrJkSG5V47w0LgbnBpOLFZX6u1JOTzPAsXWgJaA6KQhsWM+/g6XW/eedg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:58 +0100
Subject: [PATCH net-next v5 16/17] dt-bindings: net: pse-pd: Add bindings
 for TPS23881 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-feature_poe-v5-16-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
In-Reply-To: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
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

Add the TPS23881 I2C Power Sourcing Equipment controller device tree
bindings documentation.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

---
Change in v3:
- New patch.

Change in v4:
- Rename the file to ti,tps23881 as it support only this version of the PSE
  controller.
---
 .../bindings/net/pse-pd/ti,tps23881.yaml           | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
new file mode 100644
index 000000000000..b8891d109e51
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/ti,tps23881.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS23881 Power Sourcing Equipment controller
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
+      - ti,tps23881
+
+  reg:
+    maxItems: 1
+
+  '#pse-cells':
+    const: 1
+
+  channels:
+    description: each set of 8 ports can be assigned to one physical
+      channels or two for PoE4. This parameter describes the configuration
+      of the ports conversion matrix that establishes relationship between
+      the logical ports and the physical channels.
+    type: object
+
+    patternProperties:
+      '^channel@[0-7]$':
+        type: object
+        required:
+          - reg
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet-pse@20 {
+        compatible = "ti,tps23881";
+        reg = <0x20>;
+
+        channels {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          phys0: channel@0 {
+            reg = <0>;
+          };
+
+          phys1: channel@1 {
+            reg = <1>;
+          };
+
+          phys2: channel@2 {
+            reg = <2>;
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
+
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


