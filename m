Return-Path: <linux-kernel+bounces-84881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7886AD09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADD0B2293A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4413B2B1;
	Wed, 28 Feb 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SteUhdZk"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C912F362;
	Wed, 28 Feb 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119702; cv=none; b=a3GPovyI3eriGG58NBtwzWEbg2ve7+WNSjtiCOktPMzDdMjCxq23EX6e8KF8qq2LTcjJbiK9VqR7J1T3Cj7ycUJqMsCEbdr34xlGlOf/C3je2mMzs9huqI/5nbx/1FN5WKfFG5uWHyN0zKhL7gzgDfRQiTx1a5NVODk5c17D0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119702; c=relaxed/simple;
	bh=PhCHo+nZepUT5U4u3onobcw9AuCrMUmtfoajPO5Nvcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvRp9zuxG3g977CSL9mYqG53wMKTrhfSYAZQUfMsLerV5e22eZzpH/pPAY2oRvmmp9zX8FLyeJkHRnFK2sQTjbnYVj3K7/0NBggznF/rr3fetYCIB1VFwrphfmydbfelebtMMfC0cFlM8PmWLoxbKQ8bCPyafQRstuJ0wL6wcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SteUhdZk; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91A091BF215;
	Wed, 28 Feb 2024 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C31sOfsx4Qwt0tMTnh/5231c3KsGYLZuGcmz5uUT5No=;
	b=SteUhdZkvycZYAZExE9BH3zi8vEQwIAffFlFzp1N4nYCsQbrpIY591yQugm8kp8Ov+zQ4M
	CfIzZUkDWA05RBenCNXJyOoBXtyNegUbIeUnNA/HODedN7VrVANfM7UnekuWruJXUe0Qif
	H8CIzQit6IEb1wQEQ1SVLG1bfb0S9gKfRnFybd31i4ti1fqqqt/rMrYUPwOP4iKGw7M5pH
	HulxRYA1P6c5T/iz2QNsfJyjvwBdA9CiJtAO79wuCsSkLBIqlRPFFwOQW3Plbg+DTv3Tmo
	Le5DjBQJmT0rhvgvejyVuzi9kp7eRHxSKZ405Xnr7dKXckf24pFb7/9SjZRLCw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:00 +0100
Subject: [PATCH v2 02/30] dt-bindings: gpio: nomadik: add optional ngpios
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-2-3ba757474006@bootlin.com>
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

This GPIO controller can support a lesser number of GPIOs than 32.
Express that in devicetree using an optional, generic property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
index 69774f36e03f..4080e94702d5 100644
--- a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
@@ -51,6 +51,10 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  ngpios:
+    minimum: 0
+    maximum: 32
+
 required:
   - compatible
   - reg

-- 
2.44.0


