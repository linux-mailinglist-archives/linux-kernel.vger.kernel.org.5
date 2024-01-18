Return-Path: <linux-kernel+bounces-30259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A2831C52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0917C1F273E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC72C87B;
	Thu, 18 Jan 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="A90jpAoR"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFD2C864;
	Thu, 18 Jan 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591353; cv=none; b=kjJwdvRXWQRcUYQbCfCSNA5smtBoRro2EuwoU3ZFNlMMNxI1roe09NoXU43blnSuOeU+qWJ1ZNCXZdFsWxFMf1ZaBzwZ7aBlZqbKQaFXJuCC5ZsAFQRi60+OWiuIOBAKJPDdptsrlz7Cy3TzUl/IHEweO3aJlGg/j+WA/eUlXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591353; c=relaxed/simple;
	bh=yzcAS27fypeYF2xSvuB6sRiOfb2C9qOYS1MIp8jc1x4=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Report:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned; b=kfQxeX0Ju7QDupNq8b9xwGrQP+B6ZWZ0obpL6uP26fRkUB9ztVfGv3pZqJQpxdBePJXMhAsPAMqeXeE452QFjlYmHHqMmb4/1QW3negESigpRqaWqoSyAFSF/BKpCWfSV6MIZyYiP8x2QS7vp+dOKQAIKp3khnOhcUUq9McbaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=A90jpAoR; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=zC3bqoaLG/JWHahgf64dXD3E0eIjCOYXIjC2TGYWHbo=; b=A90jpAoRC2GFIZ9y4BC4Ym4Waw
	9VmocsMr+nliRBiHqxbHg4PfScjBQGoLQKvVnCGbTy6jrC8EyiqVIkcMEb/kkNz/fUqfo+4WMaIKw
	NP8YS2CoYYLRQICswyMJ+P3QSAb4axlwEOie9J/WgoY3rhjyxbensyOd+3tcVsyT4OtA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDp-0002lf-OZ; Thu, 18 Jan 2024 10:22:27 -0500
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
Date: Thu, 18 Jan 2024 10:22:03 -0500
Message-Id: <20240118152213.2644269-8-hugo@hugovil.com>
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
Subject: [PATCH v2 07/17] serial: max310x: add macro for max number of ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add macro to hold the maximum number of UART ports per IC/device.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Tested-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Link: https://lore.kernel.org/all/ddbc67dd-f8a3-4a6a-954a-bee49260ecab@cesnet.cz/
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 21f2fa3a91e5..6549eee4f6a6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -30,6 +30,7 @@
 #define MAX310X_MAJOR			204
 #define MAX310X_MINOR			209
 #define MAX310X_UART_NRMAX		16
+#define MAX310X_MAX_PORTS		4 /* Maximum number of UART ports per IC. */
 
 /* MAX310X register definitions */
 #define MAX310X_RHR_REG			(0x00) /* RX FIFO */
@@ -1502,7 +1503,7 @@ static const struct max310x_if_cfg __maybe_unused max310x_spi_if_cfg = {
 static int max310x_spi_probe(struct spi_device *spi)
 {
 	const struct max310x_devtype *devtype;
-	struct regmap *regmaps[4];
+	struct regmap *regmaps[MAX310X_MAX_PORTS];
 	unsigned int i;
 	int ret;
 
@@ -1604,7 +1605,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 {
 	const struct max310x_devtype *devtype;
 	struct i2c_client *port_client;
-	struct regmap *regmaps[4];
+	struct regmap *regmaps[MAX310X_MAX_PORTS];
 	unsigned int i;
 	u8 port_addr;
 
-- 
2.39.2


