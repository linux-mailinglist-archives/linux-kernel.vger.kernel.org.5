Return-Path: <linux-kernel+bounces-30255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A084831C48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC071C22EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAE28DC0;
	Thu, 18 Jan 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GEi2LicI"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F840219ED;
	Thu, 18 Jan 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591346; cv=none; b=oi8TYK61TnsbpxGeupDufJ4CtINaS38gC5PiIQxbKI9p10jyreDdzKAJI8p0Bu1OcyyFuqqYUQp2otnSnP9QOIHVlGi5i/s0lRl7FH9obi4G40cWZAu2+arNlYZiHbnWXGr1HhFyHnDKkrRRZ2Avuvp4suCYQVCXY/x7LtWSO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591346; c=relaxed/simple;
	bh=Yso4ynPqTMvR2WXt/iV5GKqKElFrxo5tnWRa4Ze8iz4=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=g55yBd9zHU8xR4FUs6pf1QGa8+VUJdjnwyzTiZqA4eDiisj9MBkGGovtP4Slh0GXuHPoEgvPIL5R+eiFYRwiczfQgLIJfsZvBiKddEBJdYDb1Okhp4p3/w5EF5GB/++ojkY0CK1OHX6kTN4B8J+gMGZh9urxMXi1N56FGcpGRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GEi2LicI; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=X+FdXXbcMtL437ShdTsCYRRDgMaXGzVvwjJpf3JQ9QA=; b=GEi2LicIDDfdyFcltmjymZviGq
	OCaagiF4UlgxjRie6+/xr5GDj6kgDOzIOhsgnWxmFNmW8ytsKb2jQfjzUYlZ85Ow89lIwUhbmTxiA
	3IsGtSQqfeXFEUjzraDNmOoVCqeJhvEXSyx5Rr/goy8zrIErohpPwe6VtyCt4+/5fNz0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDk-0002lf-S9; Thu, 18 Jan 2024 10:22:21 -0500
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
Date: Thu, 18 Jan 2024 10:21:59 -0500
Message-Id: <20240118152213.2644269-4-hugo@hugovil.com>
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
Subject: [PATCH v2 03/17] serial: max310x: use i2c_get_match_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use preferred i2c_get_match_data() instead of device_get_match_data()
to get the driver match data.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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


