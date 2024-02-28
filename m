Return-Path: <linux-kernel+bounces-84883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14AE86AD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1F61C22812
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67980149DE1;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z2DQtAtQ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921A135A6A;
	Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119703; cv=none; b=Hl0kN15KHz4fteDfFXQGSz0rlwCNjk2IF5lwNZIUvmtS9SxmLCs28UfMyYKiHNbtYccAqligXPnLucgnqU+JkAMl/zgY33BFnd8x41PA/FREkFXxeFkjEXlozjMZOJkpfCO7Gb0Wpel6/IzemALWelZJ1QO4JsZjOaFUjMiHPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119703; c=relaxed/simple;
	bh=fPuVHwU5jX5nD+1h/6YNzAbeSmVDgb8M6NG+eaZfqUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgP+0ITPEk8XOiFnn2mvKFm6KWKleigzWS8Ly4zhxNfu/GWBDf/x/wy3vFpH7j15tUPNDOx9qOEx2iCOINOqZ12dMSRIF9obZCKLSbbh3Thk3vA7hAKwpAwWKc/4Jc2F7e1FwQizQNlKB/SZCk8jkTIZ99emDj8Nb9UuxPcV5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z2DQtAtQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EDA51BF212;
	Wed, 28 Feb 2024 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6E8DyiuB0JvDBPML9y1oxUYBvvH5OXltksY0VNJeeX0=;
	b=Z2DQtAtQ/Z4UKund46HCYaEDp8axA0eOhy8BCqhZJhdHckIabRJZYpreOlUqr4SS5II31Z
	Q+6fZO7OBa0Ea5fsbpiQzpBBVFf2WdgAOOkYpWWqH/wglnvoJmhF7Vc7jFrk+JefHT2gwg
	GeFDjuc8jljVv7gXk1Y6+pdEcQaSuorOHGHhBo5yLmbDqJI6d1cU+NJtrZZxirZr5SqKQe
	idMlXm5t0/8SjjEImSuUdTjYiOJ0FhlKanexvuRkaodJdZqtM73ctQybmfhgMAc7Vz/ha8
	g0BV1Ntm2HGvF4FrZv1S/prMUJG7ljZwa9RTUySxAVWXpOmIyzvCNEjeeReo6Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:02 +0100
Subject: [PATCH v2 04/30] dt-bindings: gpio: nomadik: add optional reset
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-4-3ba757474006@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add optional reset device-tree property to the Nomadik GPIO controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
index 8e7f21988e9e..c624e20c3ed3 100644
--- a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
@@ -57,6 +57,9 @@ properties:
     minimum: 0
     maximum: 32
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.44.0


