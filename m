Return-Path: <linux-kernel+bounces-128447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6297895AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91218281F88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF415AABD;
	Tue,  2 Apr 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="LGZPGp0s"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7845EE78;
	Tue,  2 Apr 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079906; cv=none; b=h6xe/a4Mzqzf1VQ3cEmeiNLRuOdqa32lY9QixBd5/fM1TivNWl2PDKgaJZMkNoyfy44laGkP1n+67Ri4bzso8p1RZbbJCxH4cidGIZrjhB/jQH51Is4TCZQbaURGt3J5x0dk20tzrITHEbyuztg7kfM6XNs7sRQFx6pHQmd1Dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079906; c=relaxed/simple;
	bh=m9+96oagLQ30ESL2YYZeapo9L0snt63O3ucrZgIsfz0=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=WW/Jso4WeKcicomtml+QYjSXj7CkNJYK5R1WZmgmrqmnPtXo1oz6qKnrQwqr2/Yn+3pDxyFASRoix/pDkKS6XWfgZBQLh2uLM5SS6oFeh41HCWJQSwuHRG/i+BX3SMBVacRJz9R/DALD5mCBSE4BjU56PSCNBLMJcRy+L9/C3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=LGZPGp0s; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=ad0gcdFGze3oGsd4w0exnPgF1rQ7pt35UpkWIgdhFkE=; b=LGZPGp0sKZMPlcSZglj+esh7iw
	ikvO5nE5UEhyO2qadCol94pf31j2/LSX7bsrghW80mbMBROuahyYV0F+T3JeptNiFYfFt0fBk+36S
	flTzZYXrlEhT1RJwwZL+WsFJgqUBbsVdxzv6RLpZvdjtEMzO68X8hVSTIEc5FD7NktVw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56268 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rriBy-0008FF-VI; Tue, 02 Apr 2024 13:45:03 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  2 Apr 2024 13:43:49 -0400
Message-Id: <20240402174353.256627-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402174353.256627-1-hugo@hugovil.com>
References: <20240402174353.256627-1-hugo@hugovil.com>
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
Subject: [PATCH v3 1/5] serial: sc16is7xx: unconditionally clear line bit in sc16is7xx_remove()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

There is no need to check for previous port registration in
sc16is7xx_remove() because if sc16is7xx_probe() succeeded, we are
guaranteed to have successfully registered both ports. We can thus
unconditionally clear the line allocation bit in sc16is7xx_lines.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 929206a9a6e11..eec6fa8b0da79 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1670,8 +1670,8 @@ static void sc16is7xx_remove(struct device *dev)
 
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


