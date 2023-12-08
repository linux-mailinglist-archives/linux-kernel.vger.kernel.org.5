Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554780A83E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjLHQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjLHQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:09:08 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF88173F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:09:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPc-00007x-Rv; Fri, 08 Dec 2023 17:09:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPc-00ES0I-Cn; Fri, 08 Dec 2023 17:09:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPc-00GUaG-3a; Fri, 08 Dec 2023 17:09:12 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/7] pcmcia: db1xxx_ss: Convert to platform remove callback returning void
Date:   Fri,  8 Dec 2023 17:08:07 +0100
Message-ID:  <3d4c108421f2b1175d3a75ee6854e7772f8a0f82.1702051073.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=hoOY5rB1wBTrm118MtH1tMoeiGlvJRV6JaXbOehuwJI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcz9s7low3YagEVqKvVCP8KpeDw29gpuTL57GW 8gR3BuoyWSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXM/bAAKCRCPgPtYfRL+ TquFB/9ngk35j3HsFMuqUz7AHsV1DL1owZ3//hwU4IDZar2fh9KXu8S6NdL69qrH3ONbRq6r2I9 D5fi/U+YlDS1j03udvaDYEBdXi36THcMqLUaSPJb16vyTF+cWGzugfXK9ybwHv49KGM1Wfg5yq7 FfzoKCDwZ7V54bl0racUEOYQhcXA5ltYrIOpVSdpDI/4mpAQQB7OwW73SDBrdCvl6ggyz7PgYsL DRnCw7RCSWzVRAnILInxCiBXFLgssOittjh7ScwUpv9SNc4J5y1vvFVQleJ7fyUbdzWxErYRwD6 0aH3XGiDkjf8cCPTBfSis2uyJ6d4yxKcBEUvZxlcrbXJE2bS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/pcmcia/db1xxx_ss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 87a33ecc2cf1..509713b9a502 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -577,7 +577,7 @@ static int db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int db1x_pcmcia_socket_remove(struct platform_device *pdev)
+static void db1x_pcmcia_socket_remove(struct platform_device *pdev)
 {
 	struct db1x_pcmcia_sock *sock = platform_get_drvdata(pdev);
 
@@ -585,8 +585,6 @@ static int db1x_pcmcia_socket_remove(struct platform_device *pdev)
 	pcmcia_unregister_socket(&sock->socket);
 	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
 	kfree(sock);
-
-	return 0;
 }
 
 static struct platform_driver db1x_pcmcia_socket_driver = {
@@ -594,7 +592,7 @@ static struct platform_driver db1x_pcmcia_socket_driver = {
 		.name	= "db1xxx_pcmcia",
 	},
 	.probe		= db1x_pcmcia_socket_probe,
-	.remove		= db1x_pcmcia_socket_remove,
+	.remove_new	= db1x_pcmcia_socket_remove,
 };
 
 module_platform_driver(db1x_pcmcia_socket_driver);
-- 
2.42.0

