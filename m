Return-Path: <linux-kernel+bounces-83421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDAA8698D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE981C20DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875814DFF0;
	Tue, 27 Feb 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o81A2Gob"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB41EEE6;
	Tue, 27 Feb 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045004; cv=none; b=WBKU+NuQMC0uI5yhgqqPprvBLtrEuJpDNvjqrFn2ghyRFliCHPsE5pKeWnJp0bsQV/SkFQpidqZgFAdpgA8V/O839FkZ5csmA9sVKJLyhawQOyRTGnSxs4LLBmtLM8CHIY+hx2ghVK3sg0BFPuleSHOpwGELTpCZghSJzkCeIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045004; c=relaxed/simple;
	bh=uVNVKDE+Q8uouBYHgxRgACVal1G/pzzf4sCuaoUxbRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLzHjt+7v4S/FV5mmD7csY3AhzlQgbMYemjy+8Sk9GngT8y2YlkA89gTRn4vbxwjRg1xE6o/4mO6Zo8MKj5Ji0snr4tVz/YH3ClvTcZydEM3C31inNBx6kZZmZNrnGNH7sOPRmuZ0w0QM8pIeZYz7+jRCsdbYc8HKDmb+gdYPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o81A2Gob; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E0852000D;
	Tue, 27 Feb 2024 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709044999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2fkJXH11MYpToi/ZucTTv0HJIKz1iH1FGurjdxLDR0=;
	b=o81A2GobnRl2aZEalcNlc6wLUK25/Q7djlugJ3Iik8WNvvCeCOadruHbKYFfimy+QYes3N
	+PSkPkGdWXnd0wAfGNLT+JIVqrqG0opSzoEGP0A844Fbt59GBQqGdZX1M/I8MNToyyQ/LX
	Mydc/qYBvu4X3txzUnkA1WEkn1abeRTgnOeIqingg0yY4ieJ6pYW9BEgOsGI772C1NOzY7
	VgBf/JpmaMTxWJepYWmeJ6XMm7BY7JtNpTIsdMabnY9I0g3lHAY09z2Mmf/SJMQsolX++b
	NOnDnkGEz3vFddnik3POHh+dwDNOP346tJPHNTOTbTbaJMWjV2TrSOo/jtLjkg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:53 +0100
Subject: [PATCH net-next v5 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240227-feature_poe-v5-11-28f0aa48246d@bootlin.com>
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

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

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
---
 .../bindings/net/pse-pd/pse-controller.yaml        | 100 ++++++++++++++++++++-
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
index 2d382faca0e6..76a301463b48 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
@@ -13,6 +13,7 @@ description: Binding for the Power Sourcing Equipment (PSE) as defined in the
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
+  - Kory Maincent <kory.maincent@bootlin.com>
 
 properties:
   $nodename:
@@ -22,11 +23,104 @@ properties:
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
+              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145–3)
+              | Conductor | Alternative A (MDI-X) | Alternative A (MDI) | Alternative B(X) | Alternative B(S) |
+              |-----------|-----------------------|---------------------|------------------|------------------|
+              | 1         | Negative VPSE         | Positive VPSE       | —                | —                |
+              | 2         | Negative VPSE         | Positive VPSE       | —                | —                |
+              | 3         | Positive VPSE         | Negative VPSE       | —                | —                |
+              | 4         | —                     | —                   | Negative VPSE    | Positive VPSE    |
+              | 5         | —                     | —                   | Negative VPSE    | Positive VPSE    |
+              | 6         | Positive VPSE         | Negative VPSE       | —                | —                |
+              | 7         | —                     | —                   | Positive VPSE    | Negative VPSE    |
+              | 8         | —                     | —                   | Positive VPSE    | Negative VPSE    |
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
+        required:
+          - reg
+          - "#pse-cells"
+          - pairset-names
+          - pairsets
+          - polarity-supported
+
+oneOf:
+  - required:
+      - "#pse-cells"
+  - required:
+      - pse-pis
 
 additionalProperties: true
 

-- 
2.25.1


