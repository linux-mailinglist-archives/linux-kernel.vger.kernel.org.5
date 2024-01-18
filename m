Return-Path: <linux-kernel+bounces-30260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FEE831C53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F6A1F279C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0342C87D;
	Thu, 18 Jan 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="u535Kp5c"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A72C865;
	Thu, 18 Jan 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591353; cv=none; b=M1Ptp8JFzWctmRK5jowjSpSF9FNs4DtC4Y87M5toxrD0fUwPvhdz3F5Kch3uA9LZMBmkN7eYJUgDD+u9l6+syTrOCxV3/wPA9Mr1jCbC/x13xC+IoUxm74lvN/yTxF2az2+U+bDIxPqyHybA1Zc2TOoUlWHFJ/nAXJAlD59XM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591353; c=relaxed/simple;
	bh=3JrcSVp7RKn4lyZ3QbM4NjqKlgUOKTr8TF9u4wGWVlE=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Report:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned; b=H6rN7RIbroE8LXgpqQVnJKcYLKVlpTJPbY21GzVDY6ucpYOWXSWtYIj/8vO0UlRdh+RPX8R3NX51lbO251Pfk1JWnydlaUw/P1NMXvTUOCTxvxGp6anN+h6hkptaX029czsH7jeqaYy5ZLTpcbV9eo0D3hGBouU9zn5hzZ1SAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=u535Kp5c; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=KQBsa25kln8XupyVFsGT6mJS+LOwwrgBrkCwuFAgShk=; b=u535Kp5cKdfG45k/fotDqXouFe
	uUNuF3iVUztCHwebplOY16EFSrpCyMXturye7MlNBxk2LACFG3HEWGZYJVc5NxcJkoZ9CkjiayPIa
	TY3q9DnV3fIeSP367help4LhcBzlOnIcRI8c/uAeFIwLSgNjsSWdGwtxUd4pNz3JxFNY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDr-0002lf-I3; Thu, 18 Jan 2024 10:22:28 -0500
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
	=?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Date: Thu, 18 Jan 2024 10:22:04 -0500
Message-Id: <20240118152213.2644269-9-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118152213.2644269-1-hugo@hugovil.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 08/17] serial: max310x: use separate regmap name for each port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use a separate regmap name for each port so they can each have their own
debugfs entry, allowing to access each port registers independently.

For example, a four channels/ports device like the MAX14830 will have four
entries in its regmap debugfs:

$ find /sys/kernel/debug/regmap -type d | grep spi0.0
/sys/kernel/debug/regmap/spi0.0-port0
/sys/kernel/debug/regmap/spi0.0-port1
/sys/kernel/debug/regmap/spi0.0-port2
/sys/kernel/debug/regmap/spi0.0-port3

Cc: Jan Kundrát <jan.kundrat@cesnet.cz>
Link: https://lore.kernel.org/all/77f101f1-897d-4e6d-a8fd-27b818caf768@cesnet.cz/
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

---

I didn't put again Jan Kundrát's Reviewed-by and Tested-by tags since this
version has modifications compared to the original one.
---
 drivers/tty/serial/max310x.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 6549eee4f6a6..d6219077d23c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1486,6 +1486,19 @@ static struct regmap_config regcfg = {
 	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
+static const char *max310x_regmap_name(u8 port_id)
+{
+	switch (port_id) {
+	case 0:	return "port0";
+	case 1:	return "port1";
+	case 2:	return "port2";
+	case 3:	return "port3";
+	default:
+		WARN_ON(true);
+		return NULL;
+	}
+}
+
 #ifdef CONFIG_SPI_MASTER
 static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
 {
@@ -1521,6 +1534,8 @@ static int max310x_spi_probe(struct spi_device *spi)
 
 	for (i = 0; i < devtype->nr; i++) {
 		u8 port_mask = i * 0x20;
+
+		regcfg.name = max310x_regmap_name(i);
 		regcfg.read_flag_mask = port_mask;
 		regcfg.write_flag_mask = port_mask | MAX310X_WRITE_BIT;
 		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
@@ -1620,6 +1635,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 				     client->addr, devtype->slave_addr.min,
 				     devtype->slave_addr.max);
 
+	regcfg_i2c.name = max310x_regmap_name(0);
 	regmaps[0] = devm_regmap_init_i2c(client, &regcfg_i2c);
 
 	for (i = 1; i < devtype->nr; i++) {
@@ -1628,6 +1644,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 							client->adapter,
 							port_addr);
 
+		regcfg_i2c.name = max310x_regmap_name(i);
 		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
 	}
 
-- 
2.39.2


