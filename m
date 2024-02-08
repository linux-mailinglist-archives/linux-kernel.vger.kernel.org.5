Return-Path: <linux-kernel+bounces-58121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3684E1A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9929B24481
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB176F097;
	Thu,  8 Feb 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CxE8zJnX"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384779921;
	Thu,  8 Feb 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397810; cv=none; b=FFH5UyY9YZ89hNOCP4uhcc05x4m+azY95prYnNs7RTu0sn+DA//qU/0L1f+NfSYix3aUlcn2c69Hzainrw7a7vVVtYnezBO6z7/clwrNTU7gMg9wsEpjZLDbID72+SLU9ZcrhRm8UCmtd/BsT9M1gqd+IsK8Ljm4dQFqNqcelgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397810; c=relaxed/simple;
	bh=t+8GVeREjAhAch7uWEnhrNh1JKLhOtncglwxCrxWkNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/UsC9RL0rBpYj2pO/KIInFV1Auc9m6egnkWD5qISjSdEgDDRX7deEDc9Ti9vw8oYrW32dFmBa0V7REziPfFWgYf+NmKHZyKYMsV9E5zOUXEnOkJn/xSYoF/gPPghTbaYGMihCCi4pHbjhlzFkOvst1OdR/VeVZTqrkugrYQa00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CxE8zJnX; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39C001BF219;
	Thu,  8 Feb 2024 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H2Ec9U+2SamwK2cExtznkCvvslX9Qvet9UIGOsPGrc=;
	b=CxE8zJnXOr0S7LyJ37lz6Eo4bJvHNZkznk5mQ5SoUVL/gAZxBJ2rzkpB8AOH+heUJebJZ/
	ruD4tNRobSu+7GxHZSGS/i9QKwJeTV4aO3pWHVfhhPFHCJ6OWLFon4CA9qb8lbkLhHy2EB
	JR8ULd34DeqTJevf7iETRLdjHjhqnvEUPuX7QqJETA82QH6HRtOqvq/0yv6YWPp51wfNK3
	1joSsyZ+VNpzad2kkUMORMN6mxqhYggRyMkVBhGlYFXoCvqT19pOOqYhddAIX2HvTpEV5q
	5BIQ8kpQp5fbUZ3cFXcLtXdtibCAYUcjfco+a9eNNDqA7TO6Q6qqGfezPH1wnQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:47 +0100
Subject: [PATCH net-next v3 10/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
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

Before hand we set "#pse-cell" to 1 to define a PSE controller with
several PIs (Power Interface). The drawback of this was that we could not
have any information on the PI except its number.
Add support for pse_pis and pse_pi node to be able to have more information
on the PI like the number of pairset used and the pairset pinout.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 .../bindings/net/pse-pd/pse-controller.yaml        | 101 ++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
index 2d382faca0e6..dd5fb53e527a 100644
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
+      controlling several outputs which are not described in the pse_pis
+      subnode. This property is deprecated, please use pse_pis instead.
     enum: [0, 1]
 
-required:
-  - "#pse-cells"
+  pse_pis:
+    $ref: "#/$defs/pse_pis"
+
+$defs:
+  pse_pis:
+    type: object
+    description:
+      Kind of a matrix to identify the concordance between a PSE Power
+      Interface and one or two (PoE4) physical ports.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^pse_pi@[0-9]+$":
+        $ref: "#/$defs/pse_pi"
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+  pse_pi:
+    description:
+      PSE PI device for power delivery via pairsets, compliant with IEEE
+      802.3-2022, Section 145.2.4. Each pairset comprises a positive and a
+      negative VPSE pair, adhering to the pinout configurations detailed in
+      the standard.
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+      "#pse-cells":
+        const: 0
+
+      pairset-names:
+        description:
+          Names of the pairsets as per IEEE 802.3-2022, Section 145.2.4. Valid
+          values are "alternative-a" and "alternative-b". Each name should
+          correspond to a phandle in the 'pairset' property pointing to the
+          power supply for that pairset.
+        $ref: /schemas/types.yaml#/definitions/string-array
+        minItems: 1
+        maxItems: 2
+        items:
+          - enum:
+            - "alternative-a"
+            - "alternative-b"
+
+      pairsets:
+        description:
+          List of phandles, each pointing to the power supply for the
+          corresponding pairset named in 'pairset-names'. This property aligns
+          with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
+          PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145–3)
+          | Conductor | Alternative A (MDI-X) | Alternative A (MDI) | Alternative B(X) | Alternative B(S) |
+          |-----------|-----------------------|---------------------|------------------|------------------|
+          | 1         | Negative VPSE         | Positive VPSE       | —                | —                |
+          | 2         | Negative VPSE         | Positive VPSE       | —                | —                |
+          | 3         | Positive VPSE         | Negative VPSE       | —                | —                |
+          | 4         | —                     | —                   | Negative VPSE    | Positive VPSE    |
+          | 5         | —                     | —                   | Negative VPSE    | Positive VPSE    |
+          | 6         | Positive VPSE         | Negative VPSE       | —                | —                |
+          | 7         | —                     | —                   | Positive VPSE    | Negative VPSE    |
+          | 8         | —                     | —                   | Positive VPSE    | Negative VPSE    |
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        minItems: 1
+        maxItems: 2
+
+    required:
+      - reg
+      - "#pse-cells"
+      - pairset-names
+      - pairsets
+
+allOf:
+  - if:
+      required:
+        - "#pse-cells"
+    then:
+      not:
+        required:
+          - pse-pis
+
+  - if:
+      required:
+        - pse-pis
+    then:
+      not:
+        required:
+          - "#pse-cells"
 
 additionalProperties: true
 

-- 
2.25.1


