Return-Path: <linux-kernel+bounces-29499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FD830F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6B6B25C94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1E2C858;
	Wed, 17 Jan 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="vyO0ZbdH"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901928E08;
	Wed, 17 Jan 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531161; cv=none; b=V285b+eoTy0DSjTUMEKAWC2re8M+PU2RjQ0BMst7Ca4LvvI1QX9iALMe0b1uPexaC9rNOlBoDbpJ4JJoCxNUEhjp7VK36zAYNCwE207okl7SmL/8ombqo8qfC0Zp+0MEMENJ3BukYfjjEGXFEWvjAikyDhKK2uJbOc7OJz1WYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531161; c=relaxed/simple;
	bh=nd6v9ymESTz+pPY5dO6Su9kUiKnyUwRPab1CNAWZxH0=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Report:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned; b=Cpy57ZSxVzw+DVpdAbsYEloMqAh11vqFzb55c/VWUNHDAboE11F65Vk2KA8gtqrVESmu/w7GnOXxmUYkmnPaEsUFV9jvrCSTFueifFXyRfz0NznFC/8lGcBGq6j57lnDgEgJq6DVLSKbpWssvIDgHKFMi/YhmtpG3c5ro2o/3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=vyO0ZbdH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=a9f/Dsr9bsIr037f2wYcnLfCqwzTzik3k5wVA/R7lVk=; b=vyO0ZbdHpqyl/uEmPNUV9/b8RL
	v+qCgIQRNXgx7O9PoTMjA279we11ayYj5cwD+Ecw5Xg4Svq1T0OOodzCR3HASIixitSjwVG0NLKmF
	S98hROSXUWAkPKM91fGMalg3EQaRcmsn2L8XwLmbtDAt6dCPJj+811OavLTkwfEwrHa0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYw-000155-3y; Wed, 17 Jan 2024 17:39:11 -0500
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
Date: Wed, 17 Jan 2024 17:38:45 -0500
Message-Id: <20240117223856.2303475-8-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
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
Subject: [PATCH 07/18] serial: max310x: add macro for max number of ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add macro to hold the maximum number of UART ports per IC/device.

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


