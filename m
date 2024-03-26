Return-Path: <linux-kernel+bounces-119127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B388C48C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26628301C91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8912BE8E;
	Tue, 26 Mar 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="llMM3thR"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4207127B74;
	Tue, 26 Mar 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461905; cv=none; b=BtN2AclSxvQKZLC6P2t+SqKT0tKbwkMwXwcDY8w9tXdPplKH4OBgbWlloFhzSbCHt/wyCxDBc7KbKVqIjFgYJQOMVE838jZy62LreuchtRYoxfzdTvN57LpmPGGPr9kSP3kp/n5946vVHgdIrdgIsDCYLm8yJqYe7YywyISGcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461905; c=relaxed/simple;
	bh=mPO1jp7KDzL8F7lXItP9wPqKAQSWfaizL58oC1Z6e/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtY7nOP15Xgqcvp9wFTHW6zUaOAm0VWy6fIHxlIUg3+DEEyzDpeAuhyo18k1ydUGSiQiRYv1HlZJrr75TN7U8EsN/GriSyjdRzjfKLdBi39rXVLcVITP6fibRrnhBnFrLGr8jdbFH3a6rWdAH1GfMd5vyXIPg3rIX7A6Wz29aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=llMM3thR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 339291C0004;
	Tue, 26 Mar 2024 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SQitOyCBH8wPtwseaDfK9i9RhZlx9iW982a7XaITzs=;
	b=llMM3thRUwhNszenhipigSWEu5EXOdRXpGca+pmJTIk5XUMzGKepxRuOj3JmSBmg7/J8tS
	4FOoMWT+imJUaM4OPMSSTvO/3SFXIFTIejaVFNWB4wdyJx5nCnIi8/CTXqK+zelvR53sr8
	Abb5w8TxmgZspKnM1J0LWD+dXBz1BD+9l07xdQ256Hup9aGSv3Om1COrRbvffGFZXOzF8A
	d0mrUpU0I6mkuYs3fdDZArh7ezwRTQB/HsNN2X1QPUfDMs663eoC7iPC1+VFoPqHCMN7Mb
	hT1T11kS8RhX82ZkCnc47NOpeWXlg04Pd370vjLRJYVExN6rL68ED3OqJtFQwQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:48 +0100
Subject: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
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

PSE PI setup may encompass multiple PSE controllers or auxiliary circuits
that collectively manage power delivery to one Ethernet port.
Such configurations might support a range of PoE standards and require
the capability to dynamically configure power delivery based on the
operational mode (e.g., PoE2 versus PoE4) or specific requirements of
connected devices. In these instances, a dedicated PSE PI node becomes
essential for accurately documenting the system architecture. This node
would serve to detail the interactions between different PSE controllers,
the support for various PoE modes, and any additional logic required to
coordinate power delivery across the network infrastructure.

The old usage of "#pse-cells" is unsuficient as it carries only the PSE PI
index information.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch

Changes in v4:
- Remove $def
- Fix pairset-names item list
- Upgrade few properties description
- Update the commit message

Changes in v5:
- Fix yamllint error.
- Replace underscore by dash in properties names.
- Add polarity-supported property.

Changes in v6:
- Reorder the pairset pinout table documentation to shrink the lines size.
- Remove pairset and polarity as required fields.
- Add vpwr-supply regulator supply.
---
 .../bindings/net/pse-pd/pse-controller.yaml        | 102 ++++++++++++++++++++-
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
index 2d382faca0e6..03f7f215c162 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
@@ -13,6 +13,7 @@ description: Binding for the Power Sourcing Equipment (PSE) as defined in the
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
+  - Kory Maincent <kory.maincent@bootlin.com>
 
 properties:
   $nodename:
@@ -22,11 +23,106 @@ properties:
     description:
       Used to uniquely identify a PSE instance within an IC. Will be
       0 on PSE nodes with only a single output and at least 1 on nodes
-      controlling several outputs.
+      controlling several outputs which are not described in the pse-pis
+      subnode. This property is deprecated, please use pse-pis instead.
     enum: [0, 1]
 
-required:
-  - "#pse-cells"
+  pse-pis:
+    type: object
+    description:
+      Overview of the PSE PIs provided by the controller.
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
+      "^pse-pi@[0-9a-f]+$":
+        type: object
+        description:
+          PSE PI for power delivery via pairsets, compliant with IEEE
+          802.3-2022, Section 145.2.4. Each pairset comprises a positive and
+          a negative VPSE pair, adhering to the pinout configurations
+          detailed in the standard.
+          See Documentation/networking/pse-pd/pse-pi.rst for details.
+
+        properties:
+          reg:
+            description:
+              Address describing the PSE PI index.
+            maxItems: 1
+
+          "#pse-cells":
+            const: 0
+
+          pairset-names:
+            $ref: /schemas/types.yaml#/definitions/string-array
+            description:
+              Names of the pairsets as per IEEE 802.3-2022, Section 145.2.4.
+              Valid values are "alternative-a" and "alternative-b". Each name
+              should correspond to a phandle in the 'pairset' property
+              pointing to the power supply for that pairset.
+            minItems: 1
+            maxItems: 2
+            items:
+              enum:
+                - alternative-a
+                - alternative-b
+
+          pairsets:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              List of phandles, each pointing to the power supply for the
+              corresponding pairset named in 'pairset-names'. This property
+              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
+              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145\u20133)
+              |-----------|---------------|---------------|---------------|---------------|
+              | Conductor | Alternative A | Alternative A | Alternative B | Alternative B |
+              |           |    (MDI-X)    |     (MDI)     |      (X)      |      (S)      |
+              |-----------|---------------|---------------|---------------|---------------|
+              | 1         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
+              | 2         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
+              | 3         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
+              | 4         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
+              | 5         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
+              | 6         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
+              | 7         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
+              | 8         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
+            minItems: 1
+            maxItems: 2
+
+          polarity-supported:
+            $ref: /schemas/types.yaml#/definitions/string-array
+            description:
+              Polarity configuration supported by the PSE PI pairsets.
+            minItems: 1
+            maxItems: 4
+            items:
+              enum:
+                - MDI-X
+                - MDI
+                - X
+                - S
+
+          vpwr-supply:
+            description: Regulator power supply for the PSE PI.
+
+        required:
+          - reg
+          - "#pse-cells"
+
+oneOf:
+  - required:
+      - "#pse-cells"
+  - required:
+      - pse-pis
 
 additionalProperties: true
 

-- 
2.25.1


