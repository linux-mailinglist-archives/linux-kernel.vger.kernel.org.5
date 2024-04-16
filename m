Return-Path: <linux-kernel+bounces-146799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A768A6B21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBE81F2114B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D141C76;
	Tue, 16 Apr 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FhhpJA0y"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977C12BE89
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270956; cv=none; b=lJRprB5Rormdzg5dExgUba0jjG9OKhsnZ81ECWktFuPVZwYgDHzg/+zOWbGimemTOJ81N/HnpsftD7HUj1pke2RrnFR1QnEBv6YWdEljkBR8YuUK8N0PPtREE733ghp0eRvNXye1AbxmtyIwEG6xitvF3kzbq4/bxFCHUYnJx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270956; c=relaxed/simple;
	bh=Y0tLSlgC1RFiT3mPqR8mah4c1H2bj6CTLAIREfC/r58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9kG5n/rtvqqBj5OsuhQmcC3AYiEtZyov0xVgzUGT37I4iT5gNThZZZhWyNB3v6QT8RJcFk55t6HiV2VK/8xPiQ3GCQkRExJVTN1CaVSbLO48/7yFTkGxtSb18PyY3S5NMWXb601aMTJx2M1nrmy5wzhRPfEs1v8UN7YZ3eF1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FhhpJA0y; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Lp5vlYVFCcetgnIn4HW8dGgnYXxUPUENhUOs0STSU6g=; b=FhhpJA
	0ylNFUBo2tliReQZEop/eRBFqhFIeJRPi2jN++Eh6xStzIsu9mE6VwK7N8eR3+i6
	0xPx0LwD2RwD3EgYxPCgfszwXfrkJe30YTaRWrjiaZ+wcA3K6Pwh0NwWLaE5ZGIw
	o3aFRT1sqMZxVbjexi593g5JwDPb2YgqREqjtELJQgIxl174jr/Z3YGZc5+oyN3I
	lMsj4DBQoSjcNChpF/5cTkmwTcKZK+ycWT+ETw8ka2rM94PFFLbd4GVF8ZC8AwWi
	mELKb+r5Y2HH5y5RIMaeA+0wsrpzKshNwFoEl8OyeIeHXyyIRZ7QruL6ehNoXjr+
	A4todJ6ukmmTb1Tg==
Received: (qmail 2408475 invoked from network); 16 Apr 2024 14:35:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Apr 2024 14:35:52 +0200
X-UD-Smtp-Session: l3s3148p1@zQCB+jUW6psgAwDPXxiyACzheF6dGXh7
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 1/2] serial: sh-sci: start hrtimer after setting up DMA
Date: Tue, 16 Apr 2024 14:35:47 +0200
Message-ID: <20240416123545.7098-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
References: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the RX DMA completion handler, the hrtimer was restarted before DMA
was set up. If DMA failed, for some reason, it would clean up and the
hrtimer would run into a NULL-pointer. Restart the timer after DMA was
successfully set up.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Closes: https://lore.kernel.org/r/ee6c9e16-9f29-450e-81da-4a8dceaa8fc7@de.bosch.com
Fixes: 67f462b069e9 ("serial: sh-sci: Get rid of the workqueue to handle receive DMA requests")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e512eaa57ed5..1e3c26c11c49 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1325,8 +1325,6 @@ static void sci_dma_rx_complete(void *arg)
 	if (active >= 0)
 		count = sci_dma_rx_push(s, s->rx_buf[active], s->buf_len_rx);
 
-	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
-
 	if (count)
 		tty_flip_buffer_push(&port->state->port);
 
@@ -1346,6 +1344,8 @@ static void sci_dma_rx_complete(void *arg)
 
 	dma_async_issue_pending(chan);
 
+	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
+
 	uart_port_unlock_irqrestore(port, flags);
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[active], active, s->active_rx);
-- 
2.43.0


