Return-Path: <linux-kernel+bounces-29505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C82830F69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA2B283A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136C2E407;
	Wed, 17 Jan 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="iwbfvzlz"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8062D7B6;
	Wed, 17 Jan 2024 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531168; cv=none; b=mR5FmsJnQugVmhx/O7lNq7jFVr1HsdC1OB7kYmvpfy3c6udRqal4snGF+nTywFF0fmim7d/8DXtUYkUiPqib56bNBs6NnnxCRETF2TM706qmEXbn8muENhgk4ftjWjYcnfwWSLl3hgTA07H1MonePI2QXQmEIS1+Ouu3Ht3LRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531168; c=relaxed/simple;
	bh=YinMs0mbEq/BiNcGuPpXlWAWeAAYQENW0RAjkeEDlFk=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=aEsLCC0X/KPUYZfVui2Wa25Alaj8qBJMFQwRSphSeprX3af33D3It9QwcWd26HGMBlNP2wBgJkYxdEXLSihrd7vsP0RpRP1IP6VHAMQmtmRbgpz5MupWCHc4Jj8ePSGuC35xlqrBWXyq3qfDZD6HLdnaxsExtxcQgow0k9Q2WzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=iwbfvzlz; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=mdDbEI8DctxlwS3aGllFeZCwDUnwFaZM0Yr08OcRO0Q=; b=iwbfvzlzLtybfDYatSeqeN4cqH
	s1ZNY6Py6+tAlWlFnp1CictUt2SbCDeAmC5oOm2iX7kiPbdCFzY7tVYox/3gj3tB5EG7IpejFJ8kY
	oNqZhilD/e9nATLgta+10GxpNSzcs64eiBwSwNEK+yQDNDNzjRPwvndMkSg6SXOLPzD4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZ9-000155-G3; Wed, 17 Jan 2024 17:39:24 -0500
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
Date: Wed, 17 Jan 2024 17:38:54 -0500
Message-Id: <20240117223856.2303475-17-hugo@hugovil.com>
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
Subject: [PATCH 16/18] serial: max310x: replace bare use of 'unsigned' with 'unsigned int' (checkpatch)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fixes the following checkpatch warnings:

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

With this change, the affected functions now match the prototypes in
struct gpio_chip.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 12219b22b880..6ef0155074dd 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1156,7 +1156,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 
 #ifdef CONFIG_GPIOLIB
-static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int val;
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1167,7 +1167,7 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1176,7 +1176,7 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			    value ? 1 << (offset % 4) : 0);
 }
 
-static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1187,7 +1187,7 @@ static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int max310x_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
-- 
2.39.2


