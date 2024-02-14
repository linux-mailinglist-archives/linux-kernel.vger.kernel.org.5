Return-Path: <linux-kernel+bounces-65541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E761854E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B028AACF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D246025C;
	Wed, 14 Feb 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KI7iE/Sk"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A67604BC;
	Wed, 14 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928083; cv=none; b=a5Oyhje3XtehOx1p/p37rCyX4HvdG2CiUOB24l1ifbDJWgbVPVzwzTbX7CD0mBL4/pfj/y/k6s199FUfO/gjmBm3BqYrDBU0grD9H0N1io3Bbr+7jCD1aFL61kUYTG8UikTPgQ3wsR8dQJo4MJkGlriinDmZox2qyvnUnpN6QZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928083; c=relaxed/simple;
	bh=ir+eoc0jbuEuWJ3O29+dK3BjLCTAqr8YcnzADMODJcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWkLjJoFbphSdOEBrYh5e3y1MZcYtI4JI6ouzIY9MReewE1kUFyW4NbuEtnlsBEizI9yeOtdvBs+7OKz+FO0KFBIunCNol5S05Iq6TJ5bmqgKMs7F5dYurFrjJMtdl3XpA2WD5m9NQW5mAxKl4CVQRKBfxLzg/Pdc+88U45XJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KI7iE/Sk; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 05D03C38FD;
	Wed, 14 Feb 2024 16:24:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E04EB60014;
	Wed, 14 Feb 2024 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q45CdQpZMMWLXlGQtbNYrLylgczhG+3dk48jcixC08c=;
	b=KI7iE/Sk/bqMYxn7EUN0qk4cL6VwJwblLS67NPBoGIakEjVJ7vSxtt89veU3xpb51CVvgx
	Mc/5+mlubAE/dIO7zpP+U2FEVliOJEfpkvfX0UH0arPM2L+rfwAq5vOHC0fzPjlXgfE8Ot
	hr2PZxFrFL5o3UKW/3eHsPoLzJDqYgIRebkN8QIJTlXXbkEAKtjWOMh63Ga5FBde2uvvo2
	zDHwsseJlPUKigljUTRWsrr5+ojpJ667REagGlQQ1o0g3JX2ZP/+RDVZHr/CHSS5z/9VnV
	Wq7fr7NNZU7VYEPVMlKxMzLm8FJot6HPRdxi9uCziucClnjLV+mZyutTVCbb4Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:01 +0100
Subject: [PATCH 08/23] pinctrl: nomadik: minimise indentation in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-8-f88c0ccf372b@bootlin.com>
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

nmk_pinctrl_probe() iterates over each GPIO block. Use an early
conditional continue to skip to the next iteration rather than indent
all the loop code block.

Do not change code logic. The block is changed from:

	for (i = 0; i < NMK_MAX_BANKS; i++) {
		x = of_parse_phandle(...);
		if (x) {
			... do work ...
		}
	}

To:

	for (i = 0; i < NMK_MAX_BANKS; i++) {
		x = of_parse_phandle(...);
		if (!x)
			continue;

		... do work ...
	}

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 60443de439fd..c1cb3a363692 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1201,17 +1201,16 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 		struct nmk_gpio_chip *nmk_chip;
 
 		gpio_np = of_parse_phandle(np, "nomadik-gpio-chips", i);
-		if (gpio_np) {
-			dev_info(&pdev->dev,
-				 "populate NMK GPIO %d \"%pOFn\"\n",
-				 i, gpio_np);
-			nmk_chip = nmk_gpio_populate_chip(gpio_np, pdev);
-			if (IS_ERR(nmk_chip))
-				dev_err(&pdev->dev,
-					"could not populate nmk chip struct "
-					"- continue anyway\n");
-			of_node_put(gpio_np);
-		}
+		if (!gpio_np)
+			continue;
+
+		dev_info(&pdev->dev, "populate NMK GPIO %d \"%pOFn\"\n",
+			 i, gpio_np);
+		nmk_chip = nmk_gpio_populate_chip(gpio_np, pdev);
+		if (IS_ERR(nmk_chip))
+			dev_err(&pdev->dev,
+				"could not populate nmk chip struct - continue anyway\n");
+		of_node_put(gpio_np);
 	}
 
 	prcm_np = of_parse_phandle(np, "prcm", 0);

-- 
2.43.1


