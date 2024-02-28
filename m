Return-Path: <linux-kernel+bounces-84903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110086AD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7FB1F2990D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70615D5B9;
	Wed, 28 Feb 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FPs4A+FS"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3215B100;
	Wed, 28 Feb 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119714; cv=none; b=QjY2t4z/+VFfCHPzFNZcucB7BPGtDA46gH2aMOT8B2tJ0Nc4I4D1M3BWR1pAaS4J9uRuYDY3rIALtQLtGiBu/LcnJ7hSm1kkhw4QmwQ888gv7gv71NXR1VYHFtck9qFDaVWcWUM4Lyo0lAG9IuNi4HGKc7IU9UQJGk4Avqta1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119714; c=relaxed/simple;
	bh=CuQIZkGPYKfwIxHjL83ks3D5WIvU+cFZKGpyf39cIfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETMMRDvFqotPBiK1YgXGcIp7qjlhHFQf0VG0T4H/ij15rn1rf1ycNydbl+Bg9k5ZJQ48AjCSfdyaKsLHyCehQQEJwi9aAe9w+AkjQ7eJ/fCafcQYxszaU7uczXZ6cKLUZDskrD2qgNq3MtR92KfTWwk2h9Xv/tGT8iLOX0L94ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FPs4A+FS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DEAD1BF216;
	Wed, 28 Feb 2024 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNoO6vmJ9el3v5aN6NX8aYKdgPlN5duDCePRMfT5iF0=;
	b=FPs4A+FSUsI1jbmC5iRp/YjJ5AetOfXSFRU/BbEMB8tPtEzk8ghIPZvPVYoEE9QrzAALr7
	PYLOp+tdssftRzOGsKPmKwsiDsp8lJbtqsjXyQRE1xx48ZBJfuNngfeqKmp0cxN7LeFbJ6
	9SPUDb2BYKToI3Mic91+gTQOtqA8ZbBa4SC/wC1pyK51coWhuwH5sohz/QtA2m2R133V03
	/NUUU8qlZtHa4bC76oGxJ5cK/0FezljCo7PWfIJPBG2EgrdfMk/ND049CjHnTa0u8Xi/t0
	TgiE4MWdX0mBJ98RYVzABKHdHhzWKQhaSFiWAsXLSGMoMtzmq9uvFHGazvYWKA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:24 +0100
Subject: [PATCH v2 26/30] Documentation: gpio: mention
 generic_handle_irq_safe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-26-3ba757474006@bootlin.com>
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
 Stephen Warren <swarren@wwwdotorg.org>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

generic_handle_irq() must be called from a no-IRQ context. Documentation
advices on using a fake raw lock to call generic_handle_irq() from any
context.

Since 509853f9e1e7 ("genirq: Provide generic_handle_irq_safe()"), a
better alternative is available.

To: Stephen Warren <swarren@wwwdotorg.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/driver-api/gpio/driver.rst | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index bf6319cc531b..550d167a82ed 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -339,15 +339,8 @@ Cascaded GPIO irqchips usually fall in one of three categories:
 
   The generic_handle_irq() is expected to be called with IRQ disabled,
   so the IRQ core will complain if it is called from an IRQ handler which is
-  forced to a thread. The "fake?" raw lock can be used to work around this
-  problem::
-
-    raw_spinlock_t wa_lock;
-    static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
-        unsigned long wa_lock_flags;
-        raw_spin_lock_irqsave(&bank->wa_lock, wa_lock_flags);
-        generic_handle_irq(irq_find_mapping(bank->chip.irq.domain, bit));
-        raw_spin_unlock_irqrestore(&bank->wa_lock, wa_lock_flags);
+  forced to a thread. generic_handle_irq_safe() can be used to work around
+  this problem; it can safely be called from any context.
 
 - GENERIC CHAINED GPIO IRQCHIPS: these are the same as "CHAINED GPIO irqchips",
   but chained IRQ handlers are not used. Instead GPIO IRQs dispatching is

-- 
2.44.0


