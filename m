Return-Path: <linux-kernel+bounces-67276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7611856906
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A404B286F84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F371413DBBE;
	Thu, 15 Feb 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FejZTe6+"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC213AA58;
	Thu, 15 Feb 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013025; cv=none; b=AWVV+zpKj5QBJPPYa4cGATWHwJ2taQcmEy3c9xEOhUYpXe9KBK25MPxqxllhZxbWvSR8xuheERrTaQHGKtlSnmt2YtPjDkE2fTRv4dmhwywythUSOyXU8g+mOdzQao0aWj2oQao6PHWq3Zx8xSoUNlMpLIxOYnV2Y+LpCzZvYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013025; c=relaxed/simple;
	bh=/vQHDnMqrmO9wqh9KqTPt1cqkCMJKEhiD8uZ7kWep2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1Vl7kxTwyzPTjH3jFK+sAheVAdCb4E3JSlHJYLQm/qsABYAQVBjWLPPqZ7jo5q7aZMlZLqB0HxJSAmyQSHvnVItHS3hdxZ6Ar5mTYmP/CJJq7Z8icp2YAgpOmiFB0FMI/5NBvh67ywZANV77s2SC/6LHA5peugZYVQcQVo6V4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FejZTe6+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF1B420015;
	Thu, 15 Feb 2024 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjEbkCfdUrSfEQQLH2OAqSn6VlSWrbHjZdLxsoTLIuM=;
	b=FejZTe6+gZZxPBSpSnUPB+Otn4Wd/U7LUzkmaM94s5nYHWw1PPb3vjUHtojpQUREvkKEna
	MQBVJnZfp1k5Ucwtdb0IN7rng1O+frRYKIIxny9XZHkYYtwsmli603I+2/Vsdfm/9IEAEk
	JAttcguZcA8YQ/mHTV7rmGtYidx+IKIH1Z6/Fb4UorJU08N6O1iEdj5NzULPBfp970rneK
	Lfu4IdZF33p3Nlzv0evOGsU0OnfVPadNbPIBQpAJH6bD/NJcLuots+t6tiCkyLU5gI3B7Q
	tfySwSnSNixD39ScoAnJ6aHXmj+kyobXfky8rp4CQVOnXdzlWzQZNPCSjmEyLA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:57 +0100
Subject: [PATCH net-next v4 16/17] dt-bindings: net: pse-pd: Add bindings
 for TPS23881 PSE controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-feature_poe-v4-16-35bb4c23266c@bootlin.com>
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
 .../bindings/net/pse-pd/ti,tps23881.yaml           | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
new file mode 100644
index 000000000000..353418ea3519
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -0,0 +1,111 @@
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


