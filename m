Return-Path: <linux-kernel+bounces-84889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217E86AD30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16191F23AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7114F979;
	Wed, 28 Feb 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kz1AlJBZ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478881419A6;
	Wed, 28 Feb 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119705; cv=none; b=IGqSxfc//hcu6mlZTBbBK3PFJM0huiSH3XIFcrCismgj0M/E1uTDHp6UYVv1PbDtZm/idaaqvnaEkx/TNhiK/GfmWDjGxu2oXhK7SC1AdxwT1Gspe90cG2d4qNPQYD9zRZM2fq8aMFgPgPP/vPwCTR6ZAsis0mTc5mHVsHZtB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119705; c=relaxed/simple;
	bh=rpU2mac2irE8TMlXehcfuH8cGZ1986y095YKnEFa/T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iqq4C+RUoz54daenOPLT7xfWQhOEjP8loUJC8vYeL5zOWer/kz6bBauGWJxK8K+fRWsAE3TmV4uXiL3Jz0tSqM0lze1VJv2m3614jE3g8Oyx5i/s7vguglZ7fEzN/ehPv8n4khBNYlzfoaqrvN9eCxBIvSBRQYzQgZpOh910gLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kz1AlJBZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79FF51BF210;
	Wed, 28 Feb 2024 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50+FJ3NPM2/AbO8CJ0JOfR4sYG+GQHETXFvJ1d0zanU=;
	b=kz1AlJBZQXcB+NRWabtw2qzi9zWbsWFn28abqgBuUlOKjv2qqwQp163RNLWOsZUaPdOWwJ
	s5HfVYtPz7exGyca3lm7q5lF4vAbJOHkkstt3Z5kbIYIrD/lTuLPsezXXnNiR138oNXpN4
	6CZ0GPqjJNWZ+wvRotArvrhdZYbB5cqkUuKVX3+n+ymRux8fMls0I361Bjhsr8s9OXCH5P
	3BAsYJ0OvEuR5u5cmJ9r0MIaFaYQwXeT40BZdzrGAmmmyHz774fFxWu8MuCP3gT6Gui4N/
	f00fRawx7DQuDU2Yk8ebjydo/+kswp3ZaNmiyNehFGf4+r1HUpvi7KPqu2ypkQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:05 +0100
Subject: [PATCH v2 07/30] pinctrl: nomadik: Kconfig: allow building with
 COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-7-3ba757474006@bootlin.com>
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

PINCTRL_NOMADIK, PINCTRL_STN8815 and PINCTRL_DB8500 depend on ARCH_U8500
or ARCH_NOMADIK. Add COMPILE_TEST as an option to allow test building
the driver.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/Kconfig b/drivers/pinctrl/nomadik/Kconfig
index f47f0755a835..59d0d885651c 100644
--- a/drivers/pinctrl/nomadik/Kconfig
+++ b/drivers/pinctrl/nomadik/Kconfig
@@ -18,7 +18,7 @@ config PINCTRL_AB8505
 
 endif
 
-if (ARCH_U8500 || ARCH_NOMADIK)
+if (ARCH_U8500 || ARCH_NOMADIK || COMPILE_TEST)
 
 config PINCTRL_NOMADIK
 	bool "Nomadik pin controller driver"

-- 
2.44.0


