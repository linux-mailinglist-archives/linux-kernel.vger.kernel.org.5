Return-Path: <linux-kernel+bounces-138064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CAF89EBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74DE1C2161B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC913C9C8;
	Wed, 10 Apr 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Mfe6GFIX"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731113C9A3;
	Wed, 10 Apr 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733525; cv=none; b=ecvj76cFpGvbFD/bc/DcFyTMDiXgEfoyjZ0EdzMz8H67M1JMVFQJaaGlxIO6wej2FnpaI3LfCEbpq6m1V1bCKGlKeEfzpp3xW4G1pZRPnqYL/JSxTAt/6Vmo4yFX/FGQmHpdTAFJkWzBuIdyLhB949THmSx9EeKzdFv51/3K74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733525; c=relaxed/simple;
	bh=mb72YYT+idBkL9g+019hQy3CySE8fVeNuISrDyKeXis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4prRllmB7nHY8WkLSlD+yszQnGk9WnwWtKNfpZSSg1DsOAJJVzbzNbd/MxjhFXWnpwoiMUKOs2SIAFC43rdg0S2jNPKxmqAtvvAjnupI0FfnhnYb7dL0Sl5Enlb5EaryY+mXUyLlvnfI5OGkNQ6Vu8To9U6EN/PtpPRMyD+92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Mfe6GFIX; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=b9HwsGx8UBYMPhvje+pNsQ88H4qwhSzndrcngWNjVww=; b=Mfe6GFIXKP2zIgXBGNMo3SbDxL
	zOi6QHfMFYmag9ttqt614Hp9lOQ9EH65k3w8EHBVBlfoSvaaa8tsPtnJzPcZR+E4AV76hUAzMDoTn
	SpdgyYgnFX1gYaZDtzZCTGzsEj5JQfRGG87J9XS7dcmV+1rAKdRhuKE2L2dHgfNzr7s8C7/1PspMu
	Zb1xR1uAhnR8EkMYBofp+Z/ZM/K285fQaExP7fhj5+fWyRg/Cd8hDIiUpDmUpqqOpEXBD+vo5Y0Hu
	sVArq21qGUq4tp4+wpUnXzk51J2PLwvavGGzV8n5FB5r1vxonLWBEe6VAnK/zOdJTLegmicGo16s0
	wLOxcY6w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1ruSE4-000BJC-Tg; Wed, 10 Apr 2024 09:18:32 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1ruSE4-009Fmd-0I;
	Wed, 10 Apr 2024 09:18:32 +0200
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
Subject: [PATCH v2] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed, 10 Apr 2024 09:18:32 +0200
Message-ID: <cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27240/Tue Apr  9 10:26:56 2024)

By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
deadlock.

In case of the timeout, there is not much we can do, so we simply ignore
the transmitter state and optimistically try to continue.

v2:
- Fixed commit message typo
- Remove reference to patch series it originated from. This is a
  stand-alone patch

Signed-off-by: Esben Haabendal <esben@geanix.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
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


