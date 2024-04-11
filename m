Return-Path: <linux-kernel+bounces-140427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8708A144B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48C81F21DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9845149E10;
	Thu, 11 Apr 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NpcVn+Uk"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD31E895;
	Thu, 11 Apr 2024 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837969; cv=none; b=XKNvNXN8C6kuP4ldl8l2j2daaMNISXr1ygfv3cvkzTrleJTUEtagBGk9QrTLf4O6LFt7/2wD1f4/QhXHbRHghlIPQq6KU4neidlIS2HJA7KBbfBYlZJ9sYvGRa3Wo0qnOl6lHzvnL9EWcp4EBdvu06BN7LZvzGnKdmx3u41M38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837969; c=relaxed/simple;
	bh=7Pt8dFqdmkgDseOZCZN9SU6TS2/8bhh/tjBmk3dgvvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szPrJBk1lNdIwK3ruwqUX9FfUdH8sEzZXq0Y6ZbJ8RTUbUFNurU/duuHKVTKoPrqVuvCROOFo+nCc/DGQupoFMEFurLfftRcS430J9wteg2aP1hHf+UIwT4Myubgh/WqnTmNEDLfwu3WgEGc7kf2ZpMTbRPAcXCgoxwFd0vJCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NpcVn+Uk; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OFC6vlIC5xxsnahqWRPLFMKUZuRchmHsyERBhw8Wza4=; b=NpcVn+UkzjSX1PEDCokLVzcxOV
	XhnWnn92ymmTRo5nOAHuE4bKrRVaUO1I3Mvu4LB7wqHqGBU0e1N3wuicwaF+bFH6lU78axLwM6qm/
	FcethsKWnB5ZptoJcQ9HXRCRk+NMgrN3vKGqXlnd6CXR9r0U5F/Xr5I87eYZbSre0JxR4FXjCD4Y2
	XmdX+wzONc+afTpCvyP+PGfNrE5YHbkbqFar0CMmW1X/qEUxy7vNe+usp1wvyiYkdJBqq3njj79hm
	tNoU/BPXCl5GUtD6KUmBNk3SeAW7K71DcpdF4l1sKo96I9tejNsX80SG4hsb+ZlqyAm03w9z9bpQq
	flUYqHsg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rutOm-000O2e-Ey; Thu, 11 Apr 2024 14:19:24 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rutOl-000CbL-2B;
	Thu, 11 Apr 2024 14:19:23 +0200
From: Esben Haabendal <esben@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sergey Organov <sorganov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Thu, 11 Apr 2024 14:19:23 +0200
Message-ID: <919647898c337a46604edcabaf13d42d80c0915d.1712837613.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>
References: <cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27242/Thu Apr 11 10:25:12 2024)

By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
deadlock.

In case of the timeout, there is not much we can do, so we simply ignore
the transmitter state and optimistically try to continue.

Signed-off-by: Esben Haabendal <esben@geanix.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

v2:
- Fixed commit message typo
- Remove reference to patch series it originated from. This is a
  stand-alone patch

v3:
- Moved this version information into the correct patch section

 drivers/tty/serial/imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e14813250616..09c1678ddfd4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
@@ -2010,7 +2011,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned long flags;
-	unsigned int ucr1;
+	unsigned int ucr1, usr2;
 	int locked = 1;
 
 	if (sport->port.sysrq)
@@ -2041,8 +2042,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore UCR1/2/3
 	 */
-	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC));
-
+	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
+				 0, USEC_PER_SEC, false, sport, USR2);
 	imx_uart_ucrs_restore(sport, &old_ucr);
 
 	if (locked)
-- 
2.44.0


