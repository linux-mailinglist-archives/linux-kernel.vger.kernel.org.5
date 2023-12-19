Return-Path: <linux-kernel+bounces-5677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B5818DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC481C20E06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199C38F86;
	Tue, 19 Dec 2023 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BeZkUDmS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980221364;
	Tue, 19 Dec 2023 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=KcYNp1sWTrGWiUqu1nyxva4KTAsY45l/5TWJVZ84DbE=; b=BeZkUDmS0Qlg0Xyvi2r+RDaD9N
	GfZJ7MuTv4qhQJwQpz+ywqURzyObSUnrDTmKZzJwjjkoASxaFny29IIrF2XrHRXAV3PQmHJ66TLtD
	7HqLnLjfVu0bxFD/5k4ax4Ot23PNzrdHRMLj1IapmfMJafO+wlXEk2Jju+fbPhPQVmos=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkb-0007Ao-Qt; Tue, 19 Dec 2023 12:19:26 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 19 Dec 2023 12:19:02 -0500
Message-Id: <20231219171903.3530985-19-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
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
Subject: [PATCH 18/18] serial: sc16is7xx: fix whitespace in sc16is7xx_startup() comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add missing space at end of comments.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ab68ee346ec6..a8a78d8f7fcf 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1139,7 +1139,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 
 	sc16is7xx_power(port, 1);
 
-	/* Reset FIFOs*/
+	/* Reset FIFOs */
 	val = SC16IS7XX_FCR_RXRESET_BIT | SC16IS7XX_FCR_TXRESET_BIT;
 	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG, val);
 	udelay(5);
-- 
2.39.2


