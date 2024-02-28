Return-Path: <linux-kernel+bounces-84882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C386AD19
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0E01C2263F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651351493BB;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZE6bK4sj"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876212F38F;
	Wed, 28 Feb 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119703; cv=none; b=nYXF+kQeENJvxgi2SUsdOq51/kQPgJkYPMfT9pFBYTqZEaABZb0pFEUoKo3tdQksTY8JeWPQoBWFm9JzpR9a8EBcBvG9AjpgvXdHzKTiWuSXR1Kg50jcB+fom7fZi4ZbKntjenPdhuegqp5ijA1T464C8e5N3dhPI6pEJ1uO+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119703; c=relaxed/simple;
	bh=5/D2H8iA6Ufzd19sWQrvOhKy6ggsMPXM93NQPtmqEFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dI1HaRmha7bKOJ2hdIQX9cXp32wo0d6bQV0wk61iUoVl/9QCw6bDuFHuWvOSO3pGEczg6RjCy8s8amdx13AV0Zf4VR/0UhWiBuVCGuusFK/uyd0IIdVNGKiR7vdR85ItNfFDSur82/nM1bUEuARZbsnRhpjk8Sb66LTEA4xPX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZE6bK4sj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A7E11BF205;
	Wed, 28 Feb 2024 11:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnc2fMbNDrMwlNP05nuoqg0x6uxvqA1VAcuazwBJ2Z4=;
	b=ZE6bK4sj1PDrbNqpeHte/TwxmSIvNGIUOpi1iQ419L/ddj9l2qejh+6gfw0it6BXMc/GxO
	OvsA22huB7hpbqPfn7QCWKUwbmGUomvZGIDFivvmiM30+fR+CsARDtWS4J0MB9KuTqj8Ho
	NvsBgLE4R9JOp8i9MW7GWQOG5GMAUff2+00b/SQPm83aQ9LEWW4y65TlP4n/apqn0vFh4L
	TFkWLBZWZmKmKN8aN1ay9sy7xvlnvkjF7pJcn8Z+8l/RmQvw5sYN2sKaHC3Y7X3lw3g3Yi
	BRckKp0BrZDMBBgDmx0f2CQER3ZK+it4IFTIrPMsQWPOgdi/Fd+I592NDuQuWA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:01 +0100
Subject: [PATCH v2 03/30] dt-bindings: gpio: nomadik: add
 mobileye,eyeq5-gpio compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-3-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
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
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

This GPIO controller is used on the Mobileye EyeQ5 SoC. Add its
compatible to the dt-bindings. One difference is that the block as
integrated on EyeQ5 does not support sleep-mode.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../devicetree/bindings/gpio/st,nomadik-gpio.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
index 4080e94702d5..8e7f21988e9e 100644
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
@@ -66,6 +68,16 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-gpio
+    then:
+      properties:
+        st,supports-sleepmode: false
+
 examples:
   - |
     gpio1: gpio@8012e080 {

-- 
2.44.0


