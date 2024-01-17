Return-Path: <linux-kernel+bounces-29495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E11830F59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456821C24713
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AEA2C6A2;
	Wed, 17 Jan 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tpeKgau/"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56B22F16;
	Wed, 17 Jan 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531160; cv=none; b=djnlvPyLRSwIpADD8bRsYdmBDL/i0ZRpfp6XJ78HFSq1DUgyU0d0gOqF/oDFHeS9w9tB9vYm/Pwwd+gyNvw1QMuIi6FElycPUEsrVA/7up6cAbTpA6r7M7cpdPWX6k4incT3yomKR2miiDbZW/FhOKCWYdmjpBXzQ9InXrYD/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531160; c=relaxed/simple;
	bh=6ssH8ZgFTWorVbF7gqdsEz0MZsz0ptGRL0zN8BmmVgw=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=O6vTgMH6QF3iRw0pZ8STcruXleCyQZLd/mYsgdvaIOzaKeI0miWt4TyWbVZw+0eLCuvVV0GftaxDNjrNo1o/WYK+0YOvC1NZx5eoCynV6ng7sJZnWFpQwzbiMTN5QyEIbSqW6APe95yEPka6AkysnG3Zp3rp/XYpVe6XrSlAkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tpeKgau/; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=ly5SLHQWwB0ldPLnZJ5A1OVYT4ftvTvkUmxN4PJGRSA=; b=tpeKgau/uUiLBUWRTx6gEEIdgo
	j6WiLtsAowJVwPDptOeEajLpSfYcifH3+7q0sq8Y5LoKQTtP1HwtfzVq+96UHS8pq2DqL83NXb4xB
	CRdDqEaZlOKAsaYameCFlcPbIxF2epXWPJPuOlIKLDMvwffLTQxAfBhwJSDh2/tDyWhg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYs-000155-I6; Wed, 17 Jan 2024 17:39:07 -0500
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
Date: Wed, 17 Jan 2024 17:38:42 -0500
Message-Id: <20240117223856.2303475-5-hugo@hugovil.com>
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
Subject: [PATCH 04/18] serial: max310x: use spi_get_device_match_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use preferred spi_get_device_match_data() instead of
device_get_match_data() and spi_get_device_id() to get the driver match
data.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a051bc773c4b..2314ec2afd3f 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1514,9 +1514,9 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	devtype = device_get_match_data(&spi->dev);
+	devtype = spi_get_device_match_data(spi);
 	if (!devtype)
-		devtype = (struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
+		return dev_err_probe(&spi->dev, -ENODEV, "Failed to match device\n");
 
 	for (i = 0; i < devtype->nr; i++) {
 		u8 port_mask = i * 0x20;
-- 
2.39.2


