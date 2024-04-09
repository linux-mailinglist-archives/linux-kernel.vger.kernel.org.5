Return-Path: <linux-kernel+bounces-137254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED289DF89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812371C2189E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94D13BC0D;
	Tue,  9 Apr 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="O5rq+CV4"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254A13B7AB;
	Tue,  9 Apr 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677585; cv=none; b=tzUxciFA1/FpqVV6kDO3SCRtHYlZYDsjgu2BiMeA9b+s9IYnNRvlSDOufCOcJNbQzh94L7mYadYLGNMAbVVdo5C4iUoD1C/nzHrPSW1IXt1/sCuevZylKhIsow96lMVJj1vrzUMEFo6EYQoCn7qsWsjTBxAufHSckKtIkKV5q6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677585; c=relaxed/simple;
	bh=lB+OSgFBKTPogjqBh7v/fFKKRZTQIHKNXmdDGgNyk8g=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=JxzvDMMAXK0uLCtF6qQINoYJWNC/72l1MW5ddj45zSTEfr4t+EfSPHG9FGXPP5myxpV4qhyo2//OlK6gbmSUotwz8WifUoY63kganqSadldglXs4Tzo9/F6ga5kRX/ACtKzEFRpIVmTdzXMiVoOfMbN6Z8U6y/MMMYHOH7tRQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=O5rq+CV4; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=tGKtNFefyyWSQPpVNbihtZ2oqv0OxBXwGK/JHuIWq3I=; b=O5rq+CV4kblEFvCwcvq5yv5BIf
	Kq2oduBDGzl2QaCxbD3I2XM/4aomdiFCwVsIe9wQnBCpWsRVKictO2+GeAolLhrUA4RuxBx10zA5/
	3Jd41XvMdrBsQtCQhmZtPG9QSI9J7EI/gjXTiceDE7fKI1cmrKwbMBvtREtSxwRL6KLE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44750 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1ruDfq-0002NM-Tk; Tue, 09 Apr 2024 11:46:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>
Date: Tue,  9 Apr 2024 11:42:50 -0400
Message-Id: <20240409154253.3043822-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409154253.3043822-1-hugo@hugovil.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
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
Subject: [PATCH v4 2/5] serial: sc16is7xx: unconditionally clear line bit in sc16is7xx_remove()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

There is no need to check for previous port registration in
sc16is7xx_remove() because if sc16is7xx_probe() succeeded, we are
guaranteed to have successfully registered both ports. We can thus
unconditionally clear the line allocation bit in sc16is7xx_lines.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 34edc80859d5c..b971fd2a9a77e 100644
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


