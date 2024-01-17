Return-Path: <linux-kernel+bounces-29506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D8830F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF11F22E18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C162E65C;
	Wed, 17 Jan 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="gR3G3VJ9"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518D22E633;
	Wed, 17 Jan 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531171; cv=none; b=QDD5uWIup1FkGbR7s5VISgGTk1OqyEhiS7vOkIHVJjUcqg4x6SUxU8U8sotccbm6xGxi5SLceBDKEtYkusTI3iWl1d2318u/OqtvPCrLMzRS+RoXbFrjFR7p0inwW6rpI1DTRDlDtlPMdXA/lHt2ziOlL8R+dfMxDYjzObwB14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531171; c=relaxed/simple;
	bh=5aICcOZyaayWIUmbH/6Oxr/IUXVaWYS9/HKo5O+lCto=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=U7c6zxfQVm+PMlEuhvtsQPjw/Zmmg7j3hOzZXKQrvfeWP+qzHO32O6kgM+dAHs4LW3cv27UO2smLKYnZvrXkZsySaQKLW/mOE3rBOAbu48ybKHLXuvVNA71AE5tUQ12zVVDU1UhNb6WOenfArhCffgdwtWvlE6bMU1JPXISt0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=gR3G3VJ9; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Hx3kobHn4ye5X7TpjEYfMsc8kGxalIHKSpKr2v/vlaw=; b=gR3G3VJ9cDrbNI/ERH3kqSQ5rU
	WCnuTyBGqWwRkhOeKGWytM2rU8EBgjXMPtAvZKy2GnTEGPY4Yn7cZLdCwiGnE59erm1me3RHxTiFM
	h0l79A8jFaJ6dZPTXoSHn97YFSd5LgAhGRHG4JY+sApiK+HRttlNiRBPuG2DZMvCoF4A=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZC-000155-ME; Wed, 17 Jan 2024 17:39:27 -0500
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
Date: Wed, 17 Jan 2024 17:38:56 -0500
Message-Id: <20240117223856.2303475-19-hugo@hugovil.com>
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
Subject: [PATCH 18/18] serial: max310x: fix indentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix indentation and add line after do/while() block.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c7849b92abb0..afe882146639 100644
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


