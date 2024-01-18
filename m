Return-Path: <linux-kernel+bounces-30269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF5A831C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E354287DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FC2E638;
	Thu, 18 Jan 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xmzc505J"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194562E410;
	Thu, 18 Jan 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591368; cv=none; b=D17Xigyon6ZxP1yrtBvJ6XSctlhs5B7AcXFzD8M+YC7akPgxOOOGxQhoXx2S5R0XpneIJqzAONVvbPYdx+mxYmY6sw+QS0sUvObKXpIG7SnFur/QS4gNz0R2dJODJRBclqhq8uSZBTnV+nlRiqMb/NnyxM8MZaY0D+Xo+o3oXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591368; c=relaxed/simple;
	bh=ffLIDqfiF1OqTD3jFeAZVJJYlnytSHiFNrRegB+CILY=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=awbRxomDew74PPwdh/u0UrAYkUUcTne9EJxS47KWoPEQuvNEewqLhqunge/ndK9ukDRo8H4KPyuhEtm+RbkAYmI99Oxj5eXfqJ8gt271j98LqA969pWM4rnBZl/lSqQWw5tlQJaOmSUruy2StDeylzWdGBzJIhHXD4+FonsK0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=xmzc505J; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=naXtpcEx7bWSe8pFskBmslDXDYtPqr1Q3MOGH0N+PwU=; b=xmzc505Jnu8hyg1rfucUNdpPbX
	sVKHhX0+8Ebe9HkGyRApnd73vc2fjiTwGxvRpI4KtBi2XWRF3Tp+jNYCJtLwp6fXhb1I7X4LQpxm6
	qThv6AKF9kSDdX50dWqdvA+tbRDNrqlF969lYSYIPQ5mKmm4DaVpYf19NgaYQtvq0Qjc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUE7-0002lf-7k; Thu, 18 Jan 2024 10:22:43 -0500
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
Date: Thu, 18 Jan 2024 10:22:13 -0500
Message-Id: <20240118152213.2644269-18-hugo@hugovil.com>
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
Subject: [PATCH v2 17/17] serial: max310x: fix indentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix indentation and add line after do/while() block.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 37007b25fbee..0065e17572be 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -802,6 +802,7 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
 			max310x_start_tx(port);
 	} while (1);
+
 	return res;
 }
 
@@ -1598,7 +1599,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, -ENODEV, "Failed to match device\n");
 
 	if (client->addr < devtype->slave_addr.min ||
-		client->addr > devtype->slave_addr.max)
+	    client->addr > devtype->slave_addr.max)
 		return dev_err_probe(&client->dev, -EINVAL,
 				     "Slave addr 0x%x outside of range [0x%x, 0x%x]\n",
 				     client->addr, devtype->slave_addr.min,
-- 
2.39.2


