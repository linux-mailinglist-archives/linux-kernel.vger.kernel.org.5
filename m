Return-Path: <linux-kernel+bounces-84898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18C86AD51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956CB28BB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579615AAC7;
	Wed, 28 Feb 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CdVSXOB0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4812F589;
	Wed, 28 Feb 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119710; cv=none; b=ZnOUeXWtBTS1fY4yZgmvCkJwfdGmoYawUFsrUsLpDqm5IDlgYysr/6glFgzaX1+dhsTOYQAdnDgDi3B1dHmLRUfplXrGAzjhuEPw58RvDf0rL8ZiKzjYxmoAMHudA3Ka5Z4tpvgWYydm0vGm/N3avJWpRMLuC1dyYLyYgEoyDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119710; c=relaxed/simple;
	bh=Js76SD3ng4nDx3td8WLSMI1+imxrzbAsm85GMeVDw3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5QZXRSZ9Y9gX8f3CZrQ3GCNQi7jq+O0A8bZAvRYmLVX5gFeLgNgmv82HIz88qAu/2UBonXhdmRShqbsxqoqt255CL4ASiFN9jf79DP1xwch+rp6HgXMs/88kBa05ccCtoj/ZN2GOngTjmY9AN6ZVluJg//PKoM7II55Y0OEkPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CdVSXOB0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA5AC1BF207;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy9sE+g4PcUKd7+KwFjA9JhwfcrofErnd/worNZZEIk=;
	b=CdVSXOB08xW/Zynmk3MSsTrONJHlU6QHlm7VOpZq/fMA9byp9jn+kfHvDEIEdz6lQTWLQG
	nr0RsSaB6oAPBaOE7lRvmlNSjZtGT40Rfnsf+zdeNzofjuwkgbkPe5T+/UiMgBQWYi7tsj
	+RWDg68ahOHauBz4KKUzmFru75NYAynQNZcf7KUIShX7oF+VfL6hIfUNpK42umQHil3tM4
	S3H4HyLnvaHxIoh7OJ+bBvv6t0plmAj2kcI7c2nwpK2Ok9Q2bC5X6QvVIGAd70c+E7vlBz
	jolzwMmG/SST3ejwxnqTuo5DxhfW4l7tkseSFjvkFYuHGIbNxK64PpZDuLUwmg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:19 +0100
Subject: [PATCH v2 21/30] gpio: nomadik: change driver name from gpio to
 gpio-nomadik
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-21-3ba757474006@bootlin.com>
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

This GPIO driver is historically related to the Nomadik platform. It
however can be used by others as it implements the ST STA2X11 IP block.
Pick a less ambiguous name for it.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 3ccbb731cb68..c22a0864ca70 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -649,7 +649,7 @@ static const struct of_device_id nmk_gpio_match[] = {
 
 static struct platform_driver nmk_gpio_driver = {
 	.driver = {
-		.name = "gpio",
+		.name = "nomadik-gpio",
 		.of_match_table = nmk_gpio_match,
 	},
 	.probe = nmk_gpio_probe,

-- 
2.44.0


