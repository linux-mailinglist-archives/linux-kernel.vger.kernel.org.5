Return-Path: <linux-kernel+bounces-144202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9008A4313
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454B91F213B9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152E69949;
	Sun, 14 Apr 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="edREDuwp"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91745A0E1;
	Sun, 14 Apr 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104633; cv=none; b=XedAWvQUekUcIE02IHGFeurt/o1Q53x0pSidqnqzfHPubId6Kt4nUAvIRCDKzlPs49jq4KqFVFivotjxE+u4wPsBfox6JTlkUlCIiI3gGmcZuWYJ3OVAipBrp9Y2bkVZ0foPUDncDV+7ZmygngjkH1mWgc+Eg2fXglSLvtna6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104633; c=relaxed/simple;
	bh=FrzzIw0YtfKARrmwVKjGaGKrYFiA6koxlrMYcoMB5rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlY9eG3IN5ZVqeURATWL4c+HVPF3hHzasKB1tbEsT3LSADIs4XhXI4I6+TksusbKbZj7871TCdj7ngAgRwg+zKG8ADRa/xnWM0MXwDLBkHtq0kRwwz2Fp7d8ja0BGGLu1hvSfmfWfCp/26Df0VO6TwsAW8ClXwK6CR3VZFzQLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=edREDuwp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 807ADC0004;
	Sun, 14 Apr 2024 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLcp3+Va9cwx+JRBSgkLkETkMLQZVOvTAFT/4LP/EV8=;
	b=edREDuwpmfKOarwYzwy24nE2nG9zMrEKGbokcE9ngAZGZEll9H/lbPVhq0h1sIR5kXWOZg
	FvzFSFVYixdt4ie+iI2EcZDDV7ERVpkF4SOitGJHEUJzRS+d8NywIH6eWwkqskgGF9rnVx
	mYKgO4OnFwI7VE3dL607I/p5mvzE/Y/eUWTFkyJMeQAH3/ZGGwHbe5y26IbFIsphyhWDSO
	+HiPCy12OksGwNe9pLVuEc2QbM4c3WLcBunK5sHGdQ3owbSIsAIZLEAuXz9++iPl06yeOx
	bwLiihmB719KrUj8wWHTAUGJ2PiLBY4hxUNtkgpBv4DxI/9kwXrBG9Qskhdsqw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:22:00 +0200
Subject: [PATCH net-next v8 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-feature_poe-v8-11-e4bf1e860da5@bootlin.com>
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

Changes in v7:
- Fix weird characters issue.
- Fix documentation nit.
---
 .../bindings/net/pse-pd/pse-controller.yaml        | 101 ++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
index 2d382faca0e6..f5c37e05731d 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
@@ -13,6 +13,7 @@ description: Binding for the Power Sourcing Equipment (PSE) as defined in the
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
+  - Kory Maincent <kory.maincent@bootlin.com>
 
 properties:
   $nodename:
@@ -22,11 +23,105 @@ properties:
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
+              Each name should correspond to a phandle in the 'pairset'
+              property pointing to the power supply for that pairset.
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
+              | 1         | Negative VPSE | Positive VPSE | -             | -             |
+              | 2         | Negative VPSE | Positive VPSE | -             | -             |
+              | 3         | Positive VPSE | Negative VPSE | -             | -             |
+              | 4         | -             | -             | Negative VPSE | Positive VPSE |
+              | 5         | -             | -             | Negative VPSE | Positive VPSE |
+              | 6         | Positive VPSE | Negative VPSE | -             | -             |
+              | 7         | -             | -             | Positive VPSE | Negative VPSE |
+              | 8         | -             | -             | Positive VPSE | Negative VPSE |
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
2.34.1


