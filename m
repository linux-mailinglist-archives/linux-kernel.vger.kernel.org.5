Return-Path: <linux-kernel+bounces-30261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0D831C56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0440283736
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9B2D022;
	Thu, 18 Jan 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Ty/CH0HO"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF02C872;
	Thu, 18 Jan 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591354; cv=none; b=ad5bwLK1GZQWCnVlknqtyu1zKKX54qoAQHTIucG/1nE+bJJAN5ktcKC6G1vuH3pDopGgx1A9eHCFJnUCzMLFXCw6p3jru0597gueZqTTRmusYFtP40tSmZEBF8PCJdt5FLEwt7hlWJM+WuZP0DPakF4xRLeiRzZQ4AvZLBhyRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591354; c=relaxed/simple;
	bh=s4Mysqfst2QRa0IZKXW/CO703dzYrTXzrhZlsCa8/k8=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=tvB4Ko/EXv/9L44Arp84U9AWf6/ymX89j5kIvzveIicayxOrZ8v6mYdYmffN4fWR3HkESqyCO+t9Th+zUu45uJQcINsDfka8QqEOUoXuDI796RgsROrnoYOG8DPXk8+852BvBlPjC/FJP1h+/a0fbzX2BdajGMRy/KLouEbQJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Ty/CH0HO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=lvwXBazv5hN0bEQBpZM6qEByYxipLu4qujdJoNRv5fw=; b=Ty/CH0HOnew9IFzcyDF5QHGN4B
	3e+/1e2uW2vuXzEFyWIHz5vh4xNwP4A60jE/LODIvsAq2kuLp6Rv6FuiTBB2SQryi/jZ3pBOU4lVT
	QnYdyDQy6jZDtZJ7FLhz2n5Bbo4JXqpUUlIIBtrt0wZBB034J1DGshY6aqBWBMumsz+A=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDt-0002lf-Df; Thu, 18 Jan 2024 10:22:30 -0500
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
Date: Thu, 18 Jan 2024 10:22:05 -0500
Message-Id: <20240118152213.2644269-10-hugo@hugovil.com>
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
Subject: [PATCH v2 09/17] serial: max310x: simplify probe() and remove() error handling
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify error handling and only call uart_remove_one_port() if line bit
is set, instead of having to manually set s->p[i].port.dev to NULL.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index d6219077d23c..9ef146f09d5b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1395,10 +1395,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
-		if (ret) {
-			s->p[i].port.dev = NULL;
+		if (ret)
 			goto out_uart;
-		}
+
 		set_bit(line, max310x_lines);
 
 		/* Go to suspend mode */
@@ -1433,10 +1432,8 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-		if (s->p[i].port.dev) {
+		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
 			uart_remove_one_port(&max310x_uart, &s->p[i].port);
-			clear_bit(s->p[i].port.line, max310x_lines);
-		}
 	}
 
 out_clk:
@@ -1454,8 +1451,10 @@ static void max310x_remove(struct device *dev)
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
 		cancel_work_sync(&s->p[i].rs_work);
-		uart_remove_one_port(&max310x_uart, &s->p[i].port);
-		clear_bit(s->p[i].port.line, max310x_lines);
+
+		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
+			uart_remove_one_port(&max310x_uart, &s->p[i].port);
+
 		s->devtype->power(&s->p[i].port, 0);
 	}
 
-- 
2.39.2


