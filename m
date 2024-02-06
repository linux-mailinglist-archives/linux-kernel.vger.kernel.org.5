Return-Path: <linux-kernel+bounces-55641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEBC84BF5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F101F21DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5721BC30;
	Tue,  6 Feb 2024 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="fwsW/SiH"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511F1BF27;
	Tue,  6 Feb 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255742; cv=none; b=BEsRG1aM7jT2oMPq891dESPJQIKEwKwqhZVapBqtg4KGyb8m1Zt9MOaqHErFmgZBtmBm7HJlm0iZovo9B+ASdNu4hXOdsyyuql9Hg0DqGMkBFK7MsA7QUsHJIyRu22GTwgxZVRhoQ84tgCTN1PgCn/rXKhC3CTnd8b4g1QBDWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255742; c=relaxed/simple;
	bh=q9fwZBAXTcQtKBv6I5CxylABhvION6OPfRGnEWczYgM=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=hAFDS2Zz1yS/pF95W+XQltKCpr6ym7ca1/zqap9Zs91zURURqRCE1l0dbi2VHAP0zd8ox9b7VvQLmTEYLF/T9cWkywxi6UojRcjHkOV/4du3EI9uPC6FbMB6LBsgl4DkOZml/Bw8U9UcIKS7xATthNbUJtQlfL2aTn0QbCrC9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=fwsW/SiH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=fRQcONYVjPAuJ2IXtLvfbv954R7Ufy3J7dtvn6r3BZs=; b=fwsW/SiHMdayWibIXMwqX98qqb
	/ZOySCo2eS5wf4JshM66p90SZT4ETeTQZEGXn7ueG6RaWUL/+jGMyeHsEeKcCslATc3N4nZ3KwVAr
	cWS25rpAKvnh7QB16RPHhvx3ZgUiTkNQrsIKEANHKFPS59DWgmpLQrPZ+qvKMc5EMNOQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41434 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rXTCs-0006XX-8A; Tue, 06 Feb 2024 16:42:19 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  6 Feb 2024 16:42:07 -0500
Message-Id: <20240206214208.2141067-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206214208.2141067-1-hugo@hugovil.com>
References: <20240206214208.2141067-1-hugo@hugovil.com>
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
Subject: [PATCH 3/4] serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Before, sc16is7xx_lines was checked for a free (zero) bit first, and then
later it was set only if UART port registration succeeded.

Now that sc16is7xx_lines is shared for the I2C and SPI drivers, make sure
it is reserved and modified atomically, and use a new variable to hold the
status of UART port regisration.

Remove need to check for previous port registration in sc16is7xx_remove(),
because if sc16is7xx_probe() succeeded, we are guaranteed to have
successfully registered both ports.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 5b53c88b7133..5073ebfc45bf 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1468,6 +1468,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	u32 uartclk = 0;
 	int i, ret;
 	struct sc16is7xx_port *s;
+	bool port_registered[SC16IS7XX_MAX_PORTS];
 
 	for (i = 0; i < devtype->nr_uart; i++)
 		if (IS_ERR(regmaps[i]))
@@ -1533,8 +1534,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		s->p[i].port.line = find_first_zero_bit(sc16is7xx_lines,
-							SC16IS7XX_MAX_DEVS);
+		port_registered[i] = false;
+
+		s->p[i].port.line = find_and_set_bit(sc16is7xx_lines,
+						     SC16IS7XX_MAX_DEVS);
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
 			ret = -ERANGE;
 			goto out_ports;
@@ -1584,7 +1587,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		if (ret)
 			goto out_ports;
 
-		set_bit(s->p[i].port.line, sc16is7xx_lines);
+		port_registered[i] = true;
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
@@ -1642,9 +1645,11 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 #endif
 
 out_ports:
-	for (i = 0; i < devtype->nr_uart; i++)
-		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
+	for (i = 0; i < devtype->nr_uart; i++) {
+		clear_bit(s->p[i].port.line, sc16is7xx_lines);
+		if (port_registered[i])
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
+	}
 
 	kthread_stop(s->kworker_task);
 
@@ -1667,8 +1672,8 @@ void sc16is7xx_remove(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr_uart; i++) {
 		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
-		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
-			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
+		clear_bit(s->p[i].port.line, sc16is7xx_lines);
+		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
 
-- 
2.39.2


