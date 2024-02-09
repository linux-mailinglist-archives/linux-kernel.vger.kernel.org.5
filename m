Return-Path: <linux-kernel+bounces-59464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9284F770
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CADCB281EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35E71B5B;
	Fri,  9 Feb 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n1hv+ujd"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860A6BB4A;
	Fri,  9 Feb 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489116; cv=none; b=aLZ58UMLOrEZZ5752QUZeCUEhn8HTwr9lBaTqUwwX+C8uBo7r3nn+jYMOrjq/ldxmeWI/HlW1cv/21fND/3AWm3/kau7MXKxdVajZ4X3b8Rf647sghBhDLOq2fYMokhz1L3A2F6CfByF3INSSenhFuZmqBWc2TsK0UFEQPe+iro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489116; c=relaxed/simple;
	bh=ySdXO7qJDu8NddCCIJjeoFz7LwJL+/JR8tSoCu/gypM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrxLk4cRFAH0M+92FNy4q6toABQnyVhA6l7zCLiT3iwOirkNmXdjgBSIaPuE2dscVxsUz8JpaGd1vE7OZq67j6yA4I+ayYmh0YVt39ngSZfh+Aj5MnsQWYb4Wv2DQf/E6QCgVtLPg06dBnmQ3rXEkVzzKjvq5SgrTaESMM00V4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n1hv+ujd; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 689B6240007;
	Fri,  9 Feb 2024 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Egf1GTz1Kl7AFDSJpN9DptDS3+BbXaB9PORtxyRGoO8=;
	b=n1hv+ujdwVVsIQ00jXGqXgrNYRzQ+DVhFs2j7gKOAZj5wgF+ukV0b57/F3yoAFoXFwzWzl
	nBx4DWA08i8v/l+HC3Gl8YIIc8XbVvMy65Rxt8JU25qsTovZQJ/34RbCJxwhG9Fpih/9Ze
	TjL4rhY5PKVaM+HE+QwXAq2YqTz8mu6IK34mf8G+Rv7e4NWfqRyDO43d9ihj56TILmVwKN
	nDchWoqErSua9u67hgd7JZbplz1AjsPa+Umj9aHW/kmfD//I1eALaMFgvCMaIN2Vg3qx6p
	KHFwT9PkBgbyjovAOXBkRQ1EdOSdZIf4QqQcJZKnfpANzinm79/C/I1IufyKow==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 15:31:40 +0100
Subject: [PATCH v5 04/13] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-mbly-clk-v5-4-f094ee5e918a@bootlin.com>
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
In-Reply-To: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add DT-Schema bindings for the EyeQ5 reset controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 44 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
new file mode 100644
index 000000000000..6b412f867d0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 reset controller
+
+description:
+  The EyeQ5 reset driver handles three reset domains. Its registers live in a
+  shared region called OLB.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+properties:
+  compatible:
+    const: mobileye,eyeq5-reset
+
+  reg:
+    minItems: 3
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: d0
+      - const: d1
+      - const: d2
+
+  "#reset-cells":
+    const: 2
+    description:
+      The first cell is the domain (0 to 2 inclusive) and the second one is the
+      reset index inside that domain.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#reset-cells"
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 2143f64e9e15..d5348fbbace6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14791,6 +14791,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S

-- 
2.43.0


