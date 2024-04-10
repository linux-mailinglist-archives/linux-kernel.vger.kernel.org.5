Return-Path: <linux-kernel+bounces-139055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2089FDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566791C20AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957C1802C2;
	Wed, 10 Apr 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m8nsTqX4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DEF17BB31;
	Wed, 10 Apr 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769160; cv=none; b=Qc3QTIFCSl4hum9oxdf77Z5nlW15l4F1V24Xj/9M6Ft8PvStHDHzkpShe6/7th5ynAIlQAFiNXOfrv1riPuNlsgZIdJLh50n9ky4UTIODOEXZY/e4+JlcHSJz6UNjhckZgqtSmtn5KF64+m0CwRXq9BBnJodS3SfCVZdsfQJybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769160; c=relaxed/simple;
	bh=n8+PgA6bKd1Vx6o5AWLgi+oPwHeHl2ofK6gyj4tm/3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQJAPO/MizySk0bElc5OtaIbb7OgPn7r8A7Vd4BK6vp6sXuiFATlhlGr44op2ppFRW5rDgiQeoGK7dZW0ieAXr4rjZ1HezVMkYjz5CBpIsaoKHQWTmH8OwYM3LhiGd7c7FCWrbxaeEsYqyrXY0JXd+d11n4Q7Prhs5n888S2CV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m8nsTqX4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E0011C0006;
	Wed, 10 Apr 2024 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712769155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLiIWhcHooUzKzHOFOzpwEPH4xnOlgJV8b8vLeV+y90=;
	b=m8nsTqX4kErAAO5ExQcAzioUdq/G1DgrE410JGDs/3UB2RpKjOoEGXmVRrzyxtXXZBZt//
	ecs8RUJ0ehmL8Z0pVSY1DWY3D8k0M0WY+1CsLOlpLQaK6a78WlOz/UpCs+i+DePjGu0mrJ
	tddwEfwh32X3U63K4HCrLH2Vh5LiwspE5sdXhZEFu7+jacbXqF8Y7SFfRLi9Dhg5ke7o6w
	ev4O8OAmS9O6KK8I/Xm3LebUZdzxow7wCMUyNd5W13s37E077pwzP6/wbP2tfNQJGVy9o9
	E9f7ac3fdwClONnI5T3xsNmjXV6XAM7xgRBKmP0OcDFmfcvGK+xU2VJdNZucRw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 19:12:32 +0200
Subject: [PATCH 03/11] dt-bindings: reset: mobileye,eyeq5-reset: add EyeQ6L
 and EyeQ6H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-mbly-olb-v1-3-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
In-Reply-To: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add bindings for EyeQ6L and EyeQ6H reset controllers.

Some controllers host a single domain, meaning a single cell is enough.
We do not enforce reg-names for such nodes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 88 ++++++++++++++++++----
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
index 062b4518347b..799bcf15bed9 100644
--- a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
@@ -4,11 +4,13 @@
 $id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mobileye EyeQ5 reset controller
+title: Mobileye EyeQ reset controller
 
 description:
-  The EyeQ5 reset driver handles three reset domains. Its registers live in a
-  shared region called OLB.
+  EyeQ reset controller handles one or more reset domains. They live in shared
+  regions called OLB. EyeQ5 and EyeQ6L host one OLB each, each with one reset
+  instance. EyeQ6H hosts 7 OLB regions; three of those (west, east,
+  accelerator) host reset controllers. West and east are duplicates.
 
 maintainers:
   - Grégory Clement <gregory.clement@bootlin.com>
@@ -17,27 +19,83 @@ maintainers:
 
 properties:
   compatible:
-    const: mobileye,eyeq5-reset
+    enum:
+      - mobileye,eyeq5-reset
+      - mobileye,eyeq6l-reset
+      - mobileye,eyeq6h-we-reset
+      - mobileye,eyeq6h-acc-reset
 
-  reg:
-    maxItems: 3
+  reg: true
 
-  reg-names:
-    items:
-      - const: d0
-      - const: d1
-      - const: d2
+  reg-names: true
 
   "#reset-cells":
-    const: 2
     description:
-      The first cell is the domain (0 to 2 inclusive) and the second one is the
-      reset index inside that domain.
+      First cell is domain, second is reset index inside that domain. If
+      controller has a single domain, first cell is implicitly zero.
+    enum: [ 1, 2 ]
 
 required:
   - compatible
   - reg
-  - reg-names
   - "#reset-cells"
 
+allOf:
+  # EyeQ5 and EyeQ6L have multiple domains, other compatibles have one.
+  # Multiple domains means named resources and two reset cells.
+  # Single domain means a single unnamed resource and one reset cell.
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mobileye,eyeq5-reset
+            - mobileye,eyeq6l-reset
+    then:
+      properties:
+        "#reset-cells":
+          const: 2
+      required:
+        - reg-names
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names: false
+        "#reset-cells":
+          const: 1
+
+  # EyeQ5 has three domains.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-reset
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+        reg-names:
+          minItems: 3
+          maxItems: 3
+          items:
+            enum: [ d0, d1, d2 ]
+
+  # EyeQ6L has two domains.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq6l-reset
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          minItems: 2
+          maxItems: 2
+          items:
+            enum: [ d0, d1 ]
+
 additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index f5a488331b38..42553da10be9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14927,6 +14927,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig

-- 
2.44.0


