Return-Path: <linux-kernel+bounces-30263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142AC831C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC94B24F49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C772D619;
	Thu, 18 Jan 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Lt+7Tna7"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EC2D051;
	Thu, 18 Jan 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591357; cv=none; b=X9u8Wdb8O2epDrBBA/ZKslkdPxNWs5c/dOLdN1wMoSjwV0z+dG1GEfhokvfqhHTBKFMeJGUAVjIjab7stCBtS19ouTYYx4m9El4erIqPD7GFlw5bBpNdez3rWMGvagnh/tDMJmTIYA8BLg9Y044o6R2loCp61mzREeLTp5jqztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591357; c=relaxed/simple;
	bh=AJbKiGbhlYvL/tN8tJfeh+g5WLzSn/phgYJzA3aKlGg=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=XOVt6YqQvHJvbYq3x+vBvR492gbRnpiZwjDI9pJtzhwklSu6PYeAvvgid1I6Zslrs2YcWwtONDgM4+pP1OkrI2afkMG3jAqFTzt+cMi5hlnk4RYHi46uk+KoFLwztJHqlQqnY6hfYnNTCSNVa0lfcP9S6tK4nhcVI38vacqpafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Lt+7Tna7; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=IeYffNFDggAZM4sGTQzrHihF3MF4kPDWmmeLJRl+9S4=; b=Lt+7Tna7/f9fglgZRQ86Tjx7Hd
	E+WHaUTLYIO/OKyg6RNhce9zKR7VRNcEBnGGV6wtqSGIAWQzQpTNlLecKfzcY/AthiphdzHJj0LgZ
	ZkuC/2S5oS/zTWM5yCloPs5Wx5bzXGjaVnjfSE0L9L3vSH0NRhvYuisraS7lbnDaODBM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDw-0002lf-3T; Thu, 18 Jan 2024 10:22:32 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 18 Jan 2024 10:22:07 -0500
Message-Id: <20240118152213.2644269-12-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118152213.2644269-1-hugo@hugovil.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 11/17] serial: max310x: use dev_err_probe() instead of dev_err()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Replace dev_err() with dev_err_probe().

This helps in simplifing code and standardizing the error output.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 048ae432ba48..701bf54e4084 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1275,10 +1275,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
-	if (!s) {
-		dev_err(dev, "Error allocating port structure\n");
-		return -ENOMEM;
-	}
+	if (!s)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Error allocating port structure\n");
 
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
@@ -1299,8 +1298,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (freq == 0)
 		freq = uartclk;
 	if (freq == 0) {
-		dev_err(dev, "Cannot get clock rate\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "Cannot get clock rate\n");
 		goto out_clk;
 	}
 
-- 
2.39.2


