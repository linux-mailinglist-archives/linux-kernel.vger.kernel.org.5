Return-Path: <linux-kernel+bounces-58127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32A84E1B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C1A1F23135
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167131272A9;
	Thu,  8 Feb 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCbJ9/yq"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB582D7E;
	Thu,  8 Feb 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397816; cv=none; b=S1X8FmKzwEMN1r4oKr4CnIXvD/wYkD6C6/5wAxDp18hpAsRA+w2sqJ52kruF0UuqqW3vTYzZgxZKUDC4IPAwu1X/oXD9V2zIHfYw5ErrPN/5bMA1JK7YxN5ggcA2MUf8bl8CaaRETQHlyfBbt0mC4BFamjPpSUZ6dKahBBiQpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397816; c=relaxed/simple;
	bh=kmr1Nd1bmbLLH9eIZCBhG4wGgiHV97Oa9Fg57Loagdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IG1f5LznbY2dsABNGsYzTuRpVVgBSv92Cij2aT0WULADjGcFff3e/u7YtdwclVWRP2i/4DaKJAeyu/vwriDe/HqSsllGznK31+wCssuJWOCbGjulTMM5yrNIaor7mahGhxWUX43mulcOW99NDtqKvSJ8FD1IOOumPv4NbhZ9lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCbJ9/yq; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28A871BF215;
	Thu,  8 Feb 2024 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFwJT19YJDvj0g5CBxFwDiBaTGPiB8UaSvwGPQSBPo=;
	b=fCbJ9/yq7WPMT1Oi6AEyKzJvKCvZ8Y+5ecxgtLRvj7WUAiOr2TYEyV6OvC4p4jN2I8RRh/
	ve3eaTu1r3Iu5iN9TC7tiU4v/9GS/hEShnV+lgEpNTQR0mx4KeN2vJEtiv9sDwSRSLnJIH
	d7BRWa9mnb195luUVu8LF8Z/hdXlJuZAp3VKyxd9b6Yx6IqEBQa9qmnywhLDBPddpbCg2d
	Bd8oHz2Fi3Q/VoeKKVWoYUKyNIghl3/EZo006BJzcgazPWWuLk4Lk5xDNJBqrhnqghDBdT
	0pSWdK7Q+aDS1YT/iahyplDO3DHJq8vfzz21nHhLkR80tWLKXKx9T3KJz/fj6Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:53 +0100
Subject: [PATCH net-next v3 16/17] dt-bindings: net: pse-pd: Add bindings
 for TPS23881 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-feature_poe-v3-16-531d2674469e@bootlin.com>
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

Add the TPS23881 I2C Power Sourcing Equipment controller device tree
bindings documentation.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

---
Change in v3:
- New patch.
---
 .../bindings/net/pse-pd/ti,tps2388x.yaml           | 112 +++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps2388x.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps2388x.yaml
new file mode 100644
index 000000000000..ccd1a80befa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps2388x.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/ti,tps2388x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS2388x Power Sourcing Equipment controller
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
+      - ti,tps23880
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
+        compatible = "ti,tps2388x";
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
+
+          phys3: channel@3 {
+            reg = <3>;
+          };
+
+          phys4: channel@4 {
+            reg = <4>;
+          };
+
+          phys5: channel@5 {
+            reg = <5>;
+          };
+
+          phys6: channel@6 {
+            reg = <6>;
+          };
+
+          phys7: channel@7 {
+            reg = <7>;
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
+
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


