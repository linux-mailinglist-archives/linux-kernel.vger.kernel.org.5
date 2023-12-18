Return-Path: <linux-kernel+bounces-4388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B62817C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6392A1F21311
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F974E14;
	Mon, 18 Dec 2023 21:05:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E073465
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnr-0002lQ-0x; Mon, 18 Dec 2023 22:05:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnq-00GmX0-KU; Mon, 18 Dec 2023 22:05:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnq-005Y6F-BZ; Mon, 18 Dec 2023 22:05:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] parport: amiga: Convert to platform remove callback returning void
Date: Mon, 18 Dec 2023 22:05:18 +0100
Message-ID:  <75b3b8f498d6079c974bd47c763c589b9d2c00f6.1702933181.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Gq/nWyE6d9ZldFyO+uVIZpTO25j9ER5SvPErnqrRnYI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgLQN+lLmr5Slm5czjFdtTKrQMInsOAKAzUXc+ vZvRZZc6cqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYC0DQAKCRCPgPtYfRL+ TuCwB/0fpNXLrtKUtEaW1otT3V+Fw0O22vWNi78kkuucllgj9JCtEFoNNl0jPQVsFus3LUnHQrF W9NhbqdSjHBgDfJnWSun4ygXr1g4vvLhn+cwKqKRrHEP3wHlogtrM5+smoI5E/KFHVs10U3oXf7 6vB0EZXYq4wGw5I7Idnj21lJLmhuXECiFOut8HzPc3FZgB8BZJuHWAtVdZb/54r1JLQTZuE7xTA FSL9Nyo13sZA/yVq9rNqyiFCstdAQEOfOwTjwlZ2ZuJcfNApARu2f7h6tWsrROkUoqmHTz7gYI3 wvUneS4QrGph7Ovz9vYMIwJreM0sslARcVznLoO+E8NEk3AD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/parport/parport_amiga.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index 84d5701d606c..e6dc857aac3f 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -219,7 +219,7 @@ static int __init amiga_parallel_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __exit amiga_parallel_remove(struct platform_device *pdev)
+static void __exit amiga_parallel_remove(struct platform_device *pdev)
 {
 	struct parport *port = platform_get_drvdata(pdev);
 
@@ -227,11 +227,10 @@ static int __exit amiga_parallel_remove(struct platform_device *pdev)
 	if (port->irq != PARPORT_IRQ_NONE)
 		free_irq(IRQ_AMIGA_CIAA_FLG, port);
 	parport_put_port(port);
-	return 0;
 }
 
 static struct platform_driver amiga_parallel_driver = {
-	.remove = __exit_p(amiga_parallel_remove),
+	.remove_new = __exit_p(amiga_parallel_remove),
 	.driver   = {
 		.name	= "amiga-parallel",
 	},
-- 
2.42.0


