Return-Path: <linux-kernel+bounces-84885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D170186AD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB4B1C217A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949D14A085;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZOhb12jB"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A713A893;
	Wed, 28 Feb 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119704; cv=none; b=P+aGN6dPN4n4l6Ff2jIamBRZLBabMPzR7aD2mltdMPXTnZsDxVRjmQBLRyC3LF23qnFywWlCneadaTF8JrAWwx4WGDeHFqNkOsChz6hqvc3JHtagcUKA1QFBrOLJGmY0YisMz5G/OIaDzz/dWv3i5apKu18G4FrDJ/ubjt/ILnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119704; c=relaxed/simple;
	bh=Vvxtqfff227CvQ+NRjPqUWZTrj6Z7C7Vz1QGG5vik8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4hmrg7ZxpkvGzLwPwdOcRigMSqCIyp6qK/RNkEEXa8ZWGAMsdFYNd+Dn4aZ5iuBvTXbMKiX+Oa//fY1AzWFJltA4cgh1t/3imvOoMbonkTcCQvD7uUidzqhr1Ael15aF0nxddRhuJovJD+27eAjx6292UmBzcLdkgPIf5iFjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZOhb12jB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BDDD1BF219;
	Wed, 28 Feb 2024 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1seadG+CBBUxb4Y3ZLyFvvvNaIdZJZ6KheSJBHoIsiI=;
	b=ZOhb12jBzER1DD03jga9FIQRWU9oi87FiAFZy5Qqa0kq+mLmvvJq3PcAdOmHT4UdcUwmUX
	A8PYWegGZO+ozd9Co81YImFsFT3xGnyTGG7hfu5UW3DxnJzwqSYymQ4r2f737PQz2lk5Xe
	GlQZU9EFlqZ54mMlKmNr2hsQk1xSqmj+XIwvL4DrMIk0JTB6DIkEszA4rFdOmgafWVz1bZ
	B/c37Wv9VfLXucMS2ddj4qwkVg0pgHm45ctTiao9SSLbPBvC+eMvHzIwZyxLed/MMrapZ1
	TZzq4lwFeJzGcf2PdZquUNK3hGX+RVp7Qpho9+vv51uZ6p0CZVK1r/9Bkvsibw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:08 +0100
Subject: [PATCH v2 10/30] pinctrl: nomadik: minimise indentation in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-10-3ba757474006@bootlin.com>
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
index c8d2699be985..69b421bea1f4 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1203,17 +1203,16 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
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
2.44.0


