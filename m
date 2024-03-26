Return-Path: <linux-kernel+bounces-119133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078E88C4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA30303717
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371212C7F0;
	Tue, 26 Mar 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SbzQC1Sc"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B112C7EC;
	Tue, 26 Mar 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461911; cv=none; b=JSvhWdtkQWGmvDvLvMDWaOTqJpLpGzPbrIOXc39JJzdk1UVaypZQrPYb3g2q2/8lsx0B6xCLuM3r8gUrvV+nr5rPkZbskvD96xhkF4kEZSBFAucZXOn2ecR95u3zIr/jSE/kAt1gUW+ONmz8wNZOjrMMteDvvGyVOJaezzPuVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461911; c=relaxed/simple;
	bh=4JJfSrHA+h4piy+A3413SMxePP8kR5f+zB3ClRmyRC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DY7mJzoW+dnPQpRcGGUtoc6BU3hajPpslTOcOo7VyJ6HDwNUjOCJ5TvqM/kpsvhmxaSLhBn/L40B8eS7D/9WGQ+pw+I/J0Fq0wy0ZnDcj757ygb4mMdAGnhusJ7nZBOGJMpAe4zTYQET2GdNpbFfn8L+2f/w0QE5djEpw+Z/UoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SbzQC1Sc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77C431C0004;
	Tue, 26 Mar 2024 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/ASpFMpw2FzAH0ULdRz8SPxrRr4gayZF5XpSUrq6cA=;
	b=SbzQC1SclIb8VpyD6B46zlpxoA01kl89WI2JmUZHD/yzzBhHLDsTMxsj6XOEI90YB3Wb1M
	aHl1ObmLi57pHjp8edPmsyAVipTTRCdkwkj+oyTloggzyWffRFX69+fcpsS8kfEGJ8WXea
	XZ/Nmy9Gl62XpQlig7N+vplcvezBNlRAR4tMe9PGw26SlBU0E4jJxIjQ9/IASr6a0sV1Pq
	DqdQJeL7IcAW2IThvsQDLzZpoRsgO2q6UM57o4Q4VJ1KRpXiZ4oN53cXlfWDG7d6c74tIk
	MgWeuOb6H2I7wx5nzGe3Wx+gSqz0jPqYGj2JOd9wSg0Dl3+Le2WtGxpidxKOIw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:53 +0100
Subject: [PATCH net-next v6 16/17] dt-bindings: net: pse-pd: Add bindings
 for TPS23881 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-16-c1011b6ea1cb@bootlin.com>
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

Add the TPS23881 I2C Power Sourcing Equipment controller device tree
bindings documentation.

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


