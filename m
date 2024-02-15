Return-Path: <linux-kernel+bounces-67271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0CD8568FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E135B2A108
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69291339B5;
	Thu, 15 Feb 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SsQsjKVE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73375139562;
	Thu, 15 Feb 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013018; cv=none; b=lLjyZeCpXfxTiZQIlBajrrxuIySyNZ0s5Mp/w6X080WG5i76v4+4YgPo7YNJE0tX2CmOHQv8Cy1yU4RZIO6EzxK2EkAIKpkLIJZ/LIxLJp0p7ctrnfhgPYmozYjOIz6Zl2nDPiJlFlFQRpK+LMaAzhAQbPfZMbnaPVUFgz+WNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013018; c=relaxed/simple;
	bh=Ab2KnXVfcpmbURafBy75Eb5uGgnxGzLXyHnmPSFk8vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjzERbiMOnX2YQn+bIw3jSMb07r1B35gD7tXTZC4JdAgHx7k+35OW4Iamq1guQGPsp6+31yNgej6G2FZdlXma6cqnVW9Lez08o08Rmfn/2iJrrJPWb+SxRcaTv7reGjnb6H3dFpFAvF9rg5O1+cJq5oaoGFnVVeJsJW71X3J+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SsQsjKVE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DBCD20013;
	Thu, 15 Feb 2024 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vhOvvcVbX9t7/wFDDEkTAjaM+XPkKa+JVrxhazfaPQ=;
	b=SsQsjKVErsqQAhZBnqQueSWvxaR756laYlQ8M2ImE5PWUQodDpEVOpaOLvNOJhauAhv45a
	SX+284E3h5hl8P2lZbbhoPgOCrVkPpehs96fQqWMAltRokh7QurLH7Hm7kAWyOKf7ljMNn
	QI1TNRv8ukUBTZZ8xLqtBSiPDutFa9blx97RngFV7CBOyJN17LN5OwwCGlOpAChnZ5l7/m
	LomMCpSFPE9gd8pA/QMd1p+bFFL5ZZnpDeb7XxHptSv3XbpDV6OKrPP9hoq8cXUzvYPsSY
	2jOgvvtgUN2NB7qtF+m5Nr9EkL8HJZwdUxWlIBWJO85dwE5ZkeL2XEmUD7AkPQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:52 +0100
Subject: [PATCH net-next v4 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
In-Reply-To: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
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
---
 .../bindings/net/pse-pd/pse-controller.yaml        | 84 +++++++++++++++++++++-
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
index 2d382faca0e6..6f4faec216a5 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
@@ -13,6 +13,7 @@ description: Binding for the Power Sourcing Equipment (PSE) as defined in the
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
+  - Kory Maincent <kory.maincent@bootlin.com>
 
 properties:
   $nodename:
@@ -22,11 +23,88 @@ properties:
     description:
       Used to uniquely identify a PSE instance within an IC. Will be
       0 on PSE nodes with only a single output and at least 1 on nodes
-      controlling several outputs.
+      controlling several outputs which are not described in the pse_pis
+      subnode. This property is deprecated, please use pse_pis instead.
     enum: [0, 1]
 
-required:
-  - "#pse-cells"
+  pse_pis:
+    type: object
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
+      "^pse_pi@[0-9a-f]+$":
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
+                - "alternative-a"
+                - "alternative-b"
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
+        required:
+          - reg
+          - "#pse-cells"
+          - pairset-names
+          - pairsets
+
+oneOf:
+  - required:
+      - "#pse-cells"
+  - required:
+      - pse_pis
 
 additionalProperties: true
 

-- 
2.25.1


