Return-Path: <linux-kernel+bounces-148699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131A48A865E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361E81C20FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA52145FFF;
	Wed, 17 Apr 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SohySUGZ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE67145B2A;
	Wed, 17 Apr 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364896; cv=none; b=hq3nasUKnYUh1INv0QHqfY5UwRmwK0KRGRRKlHE3S57b9Iy7e8wRNrxdZIh+5vuj0Km31yIMUVsdR2l3KBZH88N7ENY4gZZCdUYMb5gZ4uznBtpGLknLVS6O2KryPhSpfZbaLh8bL4NBCA3FlUqFKcd8qWN4MBGohta6cpVlWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364896; c=relaxed/simple;
	bh=FrzzIw0YtfKARrmwVKjGaGKrYFiA6koxlrMYcoMB5rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWLNKoFxLdZv0R/RdHoqaFjxaYX1Z4OtmBjzcIW5xu7e3SWSdntTMAOKMmV+W2elky+oaN9YJqT6UvCKQ2yQuaChjjCzEDSq4psMZMEe6viR2H5ij7YMl1TNOM4i7kZ8DiQBHd25cbuOWYx1bTv+ZfDbCHAM5p63rQ9mecfysOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SohySUGZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BB381BF21B;
	Wed, 17 Apr 2024 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLcp3+Va9cwx+JRBSgkLkETkMLQZVOvTAFT/4LP/EV8=;
	b=SohySUGZ4S69p3SFVsthv+zH5NFN3QGRsO+MVHSPJmR5tqvDxDiDNDP1e0g19u+G/+brsu
	z1/9bKwGyjCX7iRP+GXy4szDQwgkms+8Jf2G+3p5eJfbUv5J6a0s6Cs86u4vEt6xY79+yL
	XRJzzqa7D1hRtYCzbPcQ8ikLZMLpfhJz1crH0t4c/+ao/fxHXlzEk1H+nRrVXEFmBhdvQQ
	EXcfu+GHem8ECz+gGEI5SGXnQ/OyX9IZPMPx+1Kgnv4vKuCa43oWAdos9dQXmukJgW11Sn
	G2brDpeZaRgNAvjzMdiDYnQ99nsF8PxXvmoI+xzO+WtaWodkKkAVTBOAztmXdA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 17 Apr 2024 16:39:56 +0200
Subject: [PATCH net-next v9 08/14] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-feature_poe-v9-8-242293fd1900@bootlin.com>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
In-Reply-To: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
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


