Return-Path: <linux-kernel+bounces-29493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D38830F51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEF41C21AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE628DBC;
	Wed, 17 Jan 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="E866bWcU"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76861E880;
	Wed, 17 Jan 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531159; cv=none; b=uMuCOHxVZNKYmyg6fKxVZ0UDICOaALUQTi/Nl3NEpaQf7qpYpn4WatrLPMW+2/rub8lCfJOSFZyra0mxvdFMJvbyr+q5cMZ4f7b2GLdox723ebVqSQ0RPUiwgiljXeGQrSFC5NGduoBJ4XTGpKmKCoQXRBB8sQmOvUw+qchMDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531159; c=relaxed/simple;
	bh=JxAIwi/qUhrUaUWQ8/K5Ko3ejpPbufELSYtxhSEZq1Y=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=iNmauPcGrXjfZ3s/tmtMRFZjTuOp+YR2Aw6b6qYn6CjY4Xv5QxVLrD/akyHbzOiktCGFBEPp8ib3yEehqBJEygmEkjm7tVT+EXHVkeK/9Eri93UCpP/roqXh/5vrqhgRjEa8uqCMnr/e+LFZLOK7CSASzCH9wx+7N+yxESUDhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=E866bWcU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=49BSI7LohOlv3IEqF6g8pkyxrAbWkBIJ6p9Fo9vDxts=; b=E866bWcUKh642Ke/DV2E+CeFzC
	FSjp0Ztxi7BAJ+zDxUZkWurMXH71g6FLRJq8n9FG4Zyhst31ZnOGXJjdZ21nnNVIua++hcIHiYClW
	8cMiEnccXftRXKuhzjihvKPQYIjqxTwO9Aax1q3g98yrcI0CaJnufswg7XPapyiE0nO8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYp-000155-3B; Wed, 17 Jan 2024 17:39:03 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org
Date: Wed, 17 Jan 2024 17:38:39 -0500
Message-Id: <20240117223856.2303475-2-hugo@hugovil.com>
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
Subject: [PATCH 01/18] serial: max310x: fix NULL pointer dereference in I2C instantiation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

When trying to instantiate a max14830 device from userspace:

    echo max14830 0x60 > /sys/bus/i2c/devices/i2c-2/new_device

we get the following error:

    Unable to handle kernel NULL pointer dereference at virtual address...
    ...
    Call trace:
        max310x_i2c_probe+0x48/0x170 [max310x]
        i2c_device_probe+0x150/0x2a0
    ...

Add check for validity of devtype to prevent the error, and abort probe
with a meaningful error message.

Fixes: 2e1f2d9a9bdb ("serial: max310x: implement I2C support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f3a99daebdaa..4a33fd950ed2 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1602,13 +1602,16 @@ static unsigned short max310x_i2c_slave_addr(unsigned short addr,
 
 static int max310x_i2c_probe(struct i2c_client *client)
 {
-	const struct max310x_devtype *devtype =
-			device_get_match_data(&client->dev);
+	const struct max310x_devtype *devtype;
 	struct i2c_client *port_client;
 	struct regmap *regmaps[4];
 	unsigned int i;
 	u8 port_addr;
 
+	devtype = device_get_match_data(&client->dev);
+	if (!devtype)
+		return dev_err_probe(&client->dev, -ENODEV, "Failed to match device\n");
+
 	if (client->addr < devtype->slave_addr.min ||
 		client->addr > devtype->slave_addr.max)
 		return dev_err_probe(&client->dev, -EINVAL,
-- 
2.39.2


