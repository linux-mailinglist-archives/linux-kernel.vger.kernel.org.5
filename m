Return-Path: <linux-kernel+bounces-29489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA817830F48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97329283D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77361E891;
	Wed, 17 Jan 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="0R/koWjz"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8451E87E;
	Wed, 17 Jan 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531158; cv=none; b=rJdo8l+1S1vfNIPI+dop1QWXUWDP0TdTl4gicDGwAIfcxdCNTPHpJ5ecXI/T8jbo3TPv/SFiEEj4DKPs06JOeF/2jx6acotWIxo66HM46fKJ+8x2pULQr8DNr/rWAw7Dsx8EkoWAjqVxFrvEGY2G3DqCPVURbrDAy8K40s7r0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531158; c=relaxed/simple;
	bh=vy0wdEBit3su56RQHlgDgVvvo7neIJRXuqdIwFymyJ4=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=TI/2NjlC/C+uNOyihI/Tssh5KUL+wTBFlWqkhRYEnLoMFB74RiWarIcVUuSGA5lFmqRAuiMPr1V6e/HQmw5X3bO0tKfLhAWZKa9ju1v+uT4+jHACy80WZkRLsO5Z4+Q9Yn0QN+XhmyiiFasPH9jPas/8dCoK3eEFYhTlXFM4EZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=0R/koWjz; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=GFJehYhk/fDFBrjMMskC+wY+GYyn4Kg3SNttyfUxJbM=; b=0R/koWjzs2mNCLnvzoCc12asu7
	U31h0qkVj2Ai0tPIJ4Ss0WD+H+hozbju9+8EUwdP/ZdTavxMOtN+rumw+XIz6IZUC7pKfsNVsXu5R
	FcKI0mYDvElrbVTNaQzsTU5/B0vezxwJAKuXwq0sggjyBZQVcsm9M8RQBo+zO9j8Sanc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYr-000155-Dt; Wed, 17 Jan 2024 17:39:05 -0500
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
Date: Wed, 17 Jan 2024 17:38:41 -0500
Message-Id: <20240117223856.2303475-4-hugo@hugovil.com>
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
Subject: [PATCH 03/18] serial: max310x: use i2c_get_match_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use preferred i2c_get_match_data() instead of device_get_match_data()
to get the driver match data.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 053cf2458264..a051bc773c4b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1608,7 +1608,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 	unsigned int i;
 	u8 port_addr;
 
-	devtype = device_get_match_data(&client->dev);
+	devtype = i2c_get_match_data(client);
 	if (!devtype)
 		return dev_err_probe(&client->dev, -ENODEV, "Failed to match device\n");
 
-- 
2.39.2


