Return-Path: <linux-kernel+bounces-102656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C207987B569
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEEE2822FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6605EE8A;
	Wed, 13 Mar 2024 23:54:37 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7B5D73B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374076; cv=none; b=pVO0LNHBo8jH2tqxNSS0vgSyZ9ka8BzFNaNehrlTLNCz1ouXIdz8cVWz3TddJbN08VHkEOC/Cn6nE82sknO1R3r8RLI4fxmgIvF168lFChCzfAox6DgqzXcZS3egwNqq+ZAWJOx2dIDBPL5U1Dn87ymMaoYQ2sZBfW1yezkDJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374076; c=relaxed/simple;
	bh=uEE6BWybd871+/CXBV9iWvsh4Tn0g6Ge38RppUuETfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpBrhAu3XgRVzE/v0lvi1R/EXaGMA8eiFPm8LRZWSrv5TrpTtVQy53JxsN+8cmkGQBk/jmMdd7rL7V58vGSIerDObtwf6b/mUJ2MOG9JksZulgO3Q7CzVmRqP/tYiktGFkvA8xuY6HYHwNRcNLcw7QvptjN3ak+Ei70RElHuIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 0883fa43-e195-11ee-b3cf-005056bd6ce9;
	Thu, 14 Mar 2024 01:54:30 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/11] pinctrl: aw9523: Remove unused irqchip field in struct aw9523_irq
Date: Thu, 14 Mar 2024 01:52:10 +0200
Message-ID: <20240313235422.180075-8-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313235422.180075-1-andy.shevchenko@gmail.com>
References: <20240313235422.180075-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irqchip field is allocated, assigned but never used. Remove it.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 9e8e658f81404..44b798c39e26b 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -57,12 +57,10 @@
 /*
  * struct aw9523_irq - Interrupt controller structure
  * @lock: mutex locking for the irq bus
- * @irqchip: structure holding irqchip params
  * @cached_gpio: stores the previous gpio status for bit comparison
  */
 struct aw9523_irq {
 	struct mutex lock;
-	struct irq_chip *irqchip;
 	u16 cached_gpio;
 };
 
@@ -805,21 +803,15 @@ static int aw9523_init_irq(struct aw9523 *awi, int irq)
 {
 	struct device *dev = awi->dev;
 	struct gpio_irq_chip *girq;
-	struct irq_chip *irqchip;
 	int ret;
 
 	if (!device_property_read_bool(dev, "interrupt-controller"))
 		return 0;
 
-	irqchip = devm_kzalloc(dev, sizeof(*irqchip), GFP_KERNEL);
-	if (!irqchip)
-		return -ENOMEM;
-
 	awi->irq = devm_kzalloc(dev, sizeof(*awi->irq), GFP_KERNEL);
 	if (!awi->irq)
 		return -ENOMEM;
 
-	awi->irq->irqchip = irqchip;
 	mutex_init(&awi->irq->lock);
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, aw9523_irq_thread_func,
-- 
2.44.0


