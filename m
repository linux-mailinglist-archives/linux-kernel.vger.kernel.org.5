Return-Path: <linux-kernel+bounces-137173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8089DE0C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83021C22CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD9F13AA4E;
	Tue,  9 Apr 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dugHK1iT"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A413A276;
	Tue,  9 Apr 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675083; cv=none; b=jYQtm7Cb3yz0451T7LIN2IEl0y1XQTE4Tpj7xVDnG1Pe1dUyZpIK5RM84XOjFuxIh2BoCepXgyAa+Afej1TTxsoUYhnChwlEr6ixmNJ8PghLDhNINs15Usi+rU46LhsA78r5OullrI/vIBvENYbkOkgU+t0TlW80emkNxvjNmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675083; c=relaxed/simple;
	bh=ZOgujZJeGStPMm3IlJW187ZYbZDubo00HsvPHLTtRrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EENreHReflWoF8uJWoZTnr/cdU+Uiqja4G3AKn/IpEkXomXmfDkRZ9ox6qy4E5ExGbezWO0dsmfSFiG2VzJYPWJCEuM5v6wvIfvNujWzzx8kgCDxCagQbS8zzjaf1osmjTC2deb66i6AVHL5w12tHimOp+JFFfPGIZGZdm4x/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dugHK1iT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 379D8C0010;
	Tue,  9 Apr 2024 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712675079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9570PIByLTohnxFL2DuYK+rFm412uwcSfs1u3hj/ts=;
	b=dugHK1iTn6cV4PbQLIQVfO1WiMxuDJpwmKsU3ftvB/6gA0N2JE8dU8TKkE9V54E7goY+gL
	J5xpMx9jDvxExYC/C8uB4WNZNAA8kOwhcJ/sd3Gv+VLF2aCZBaOcFbB0FRPXgtbgod3INy
	VfnABas8DNcxYSw3z1/rRg4CjIdAnbrwzujqSwHAirkGcK7ynroLmW+fUla+iNpVXh6At5
	R8d9nSlTY7ss5o77cVHfPYaf3JHD8+WcTvHhpQhMeUIVYaOa9rI78fIxX8jg8gyXUeVB4c
	VwpcZuLnADz1RdAPDuOqiMnHs8K+2ZDm7khNlDSlaDBdm3z6juJTpCSIQ4CkCw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 17:04:06 +0200
Subject: [PATCH net-next v7 16/17] dt-bindings: net: pse-pd: Add bindings
 for TPS23881 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_poe-v7-16-11e38efd4dee@bootlin.com>
References: <20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com>
In-Reply-To: <20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com>
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

Add the TPS23881 I2C Power Sourcing Equipment controller device tree
bindings documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Change in v3:
- New patch.

Change in v4:
- Rename the file to ti,tps23881 as it support only this version of the PSE
  controller.

Change in v7:
- Add vpwr-supply property in the example.
---
 .../bindings/net/pse-pd/ti,tps23881.yaml           | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
new file mode 100644
index 000000000000..4147adb11e10
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -0,0 +1,95 @@
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
+            vpwr-supply = <&vpwr1>;
+          };
+
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


