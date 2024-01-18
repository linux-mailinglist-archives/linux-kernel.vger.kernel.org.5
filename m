Return-Path: <linux-kernel+bounces-30256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D665E831C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF4F1F22B72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA102C1A9;
	Thu, 18 Jan 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="oa2Btqmq"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4519828DC8;
	Thu, 18 Jan 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591348; cv=none; b=hUMMwcOFdDk9FDtSwqqhT6TYJ1I2CzheCIapxYcU9vYJPbmPT1EuIvHoE70mm5h2iT2/GavAD4VsjftkKV93Ah9sVikpMZmMdDMQvfB8xM3CHtgjzpnX1wmVXRLQvhbtOe1yZvfRVdpgwTD5yRQs0k6hYYHW/twfPvNrkb8+4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591348; c=relaxed/simple;
	bh=Pk0CIty3RczqfYCPCO4tNxq9L3sxlcgvPhOLvvMhAZI=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=Xw3WWj169F22MF7h/u//pQEsgsjqJ52A/BTwPALQZB6fH/Ed1RkoJmX7EdHFi/lB9xchYPTOajzg0/VgIEmrs7JlncmKNAwB22MzE5EB9aM/6fewkUMyIcJvl4ieZ+T98Xn7E/rZFhi2WnBDmP6g7IeYSe1a5BSztlStNIx5diU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=oa2Btqmq; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=p2O7FbsP6HxhL8j3ppi8L7vF8oAUxKT1YWmChYx0QBs=; b=oa2Btqmqq58xcV6othceB0CsTY
	aWXPiULqzUQP6mwR4fdZzVedOjS4QhMr7xCi2U2Vv8VANz+qR7r+vrr5zsjYIxvLsw5hGNFLwIe3t
	nUX4g9jioVmbrR5jEwkYGHKnl3bJiSS6vFgyqdCJ7gQuguzlCn0yHbQ9loqe0c0ErN1E=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDm-0002lf-0L; Thu, 18 Jan 2024 10:22:22 -0500
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
Date: Thu, 18 Jan 2024 10:22:00 -0500
Message-Id: <20240118152213.2644269-5-hugo@hugovil.com>
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
Subject: [PATCH v2 04/17] serial: max310x: use spi_get_device_match_data()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use preferred spi_get_device_match_data() instead of
device_get_match_data() and spi_get_device_id() to get the driver match
data.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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


