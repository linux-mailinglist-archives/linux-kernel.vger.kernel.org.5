Return-Path: <linux-kernel+bounces-65537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED26854E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19B828D5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34360DE1;
	Wed, 14 Feb 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QQW1lvnc"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0060269;
	Wed, 14 Feb 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928079; cv=none; b=YalD04PVjr4L9NnczCE9iEmGlleWD35gvgYrttcjM1HKdHrMNzSwoG+/vQcutUxkWq2iVhEdky3D3QoraTwvpj5QALerz8WVvWHDhNCvU/QFHfQoxq9Yb8luHftRFeEQHRrkQck+fko1L9oHfG5ta1EPY3AnkgVA6LF2cRAr5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928079; c=relaxed/simple;
	bh=tOmbsgpawIXduW2TWwieuZdQlagYgoHrmvJPU8bK318=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pB+AX95gg2YT0oSjt0yx1hqKN9IIOfwKAj8FtiRl9OkYSJaObsdK7vAP84wNI1b3kDLaZAypW29eisGqOJDibLWI6D9bNYniKLKWbtCRzwQGvuJQQnvdTaftFGL9zb8/deXx5ld4Ot4f3oa4NxlcgAVcYu5evRE7kl576RZXJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QQW1lvnc; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 14C8AC386D;
	Wed, 14 Feb 2024 16:24:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 327E16000A;
	Wed, 14 Feb 2024 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CFEvn1JhSX3ZuVhzX02CCphHBNtzeocyxguNU6h7H4=;
	b=QQW1lvnc2VCJEDYpAwqitK++pYm9ED0eRCTv7HnbOjP/XQ2QcqHBSnCBuItW9b8/QAs70F
	xsmNgRDq2rtisOKO1VOYqBbY1BCAXFBTwCrVpr91NctL/Csp+rgHS1iica5Yu3r3un3fxw
	ia8s/7NVImO1CBTbZVicI/PMGn4fySFdaxbzp6qAV0YzcS6PdfWFKDisZ+T0BS1AFhnZ/8
	QDG6ob+aEP+nGt4nJcm6ciZV7gQpd8uxiUSfwHK0HSwkYLESGCgi7Z2yH2/O4e929PcDFr
	7XZjPz4j47ScAVmsBij6ORJJ0iGlzQGmLSw4YR4zQIiRZ3Wr5UIbMU/dYk4kgw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:23:56 +0100
Subject: [PATCH 03/23] dt-bindings: gpio: nomadik: add mobileye,eyeq5-gpio
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-3-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

This GPIO controller is used on the Mobileye EyeQ5 SoC. Add its
compatible to the dt-bindings. One difference is that the block as
integrated on EyeQ5 does not support sleep-mode.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../devicetree/bindings/gpio/st,nomadik-gpio.yaml        | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
index bbd23daed229..e44cf292bc6d 100644
--- a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
@@ -19,7 +19,9 @@ properties:
     pattern: "^gpio@[0-9a-f]+$"
 
   compatible:
-    const: st,nomadik-gpio
+    enum:
+      - st,nomadik-gpio
+      - mobileye,eyeq5-gpio
 
   reg:
     maxItems: 1
@@ -65,6 +67,18 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,nomadik-gpio
+    then:
+      properties:
+        st,supports-sleepmode:
+          description: Whether the controller can sleep or not.
+          $ref: /schemas/types.yaml#/definitions/flag
+
 examples:
   - |
     gpio1: gpio@8012e080 {

-- 
2.43.1


