Return-Path: <linux-kernel+bounces-29497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25478830F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B349A1F2667F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B92C844;
	Wed, 17 Jan 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Hut+bIpC"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD9922EFE;
	Wed, 17 Jan 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531161; cv=none; b=skcd+4eupfGyyCTi5jyr6jJh7nEnjomcTNyQjXXRhDTtyoQP2ruaeTL7/L6ccAZjhCQ2wt3QxcysUtmSrN6t8USeHqvHULbDXEWAUMyLX4J/0n4e3t6vmbB6j3xsSGyYUPGX3+UnyE1zqQ4qLLRbbRaqkbFLnlP+NgfNLDaccho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531161; c=relaxed/simple;
	bh=zOz87ekn11voWe2vvkMiDYBtjoffO8WY8MRZLqRxl1c=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=gaeIbuLE46hg2z5lN7fo8vAlUQ5sIfM9GPvv0Q9qcDgGbRu7DQAgUtEdy3Cel4520vv7PBUP9UW/ljpt91Ojnu1IwvI0KX6Z9YLWv2RKHKjutXafCH896V79CvT6Qm5cjNQPFayYaR4uPLmRvqxZGMnEarM8h9OcIx3hGSvapo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Hut+bIpC; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=uG2198nRNchO7L8hgr1xVnRfA3eYsRffeVfo+uRbP6c=; b=Hut+bIpCzJK1OcwI8INWcxwv2s
	LDOvThwh7qoj/MSY6TBxWOFjIu32NP7myRIlcrPkwajD6FqsbL16iauCbe6Sc5lnIadu/PzIgJoQE
	+M5gwBjrEnrQMxHCZgZ+bzvnKg/89ZccdfeZUvwq6bQU86tsgk96rjEuXjj9HS/zicbw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYt-000155-QR; Wed, 17 Jan 2024 17:39:08 -0500
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
Date: Wed, 17 Jan 2024 17:38:43 -0500
Message-Id: <20240117223856.2303475-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
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
Subject: [PATCH 05/18] serial: max310x: fix syntax error in IRQ error message
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Replace g with q.

Helpful when grepping thru source code or logs for
"request" keyword.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2314ec2afd3f..27c8ec956691 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1428,7 +1428,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.39.2


