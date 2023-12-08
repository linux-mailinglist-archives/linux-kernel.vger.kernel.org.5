Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410E80A83F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjLHQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjLHQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:09:09 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96371198C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:09:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPd-00008J-Pz; Fri, 08 Dec 2023 17:09:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPd-00ES0Y-DP; Fri, 08 Dec 2023 17:09:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPd-00GUaa-4I; Fri, 08 Dec 2023 17:09:13 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 7/7] pcmcia: xxs1500_ss: Convert to platform remove callback returning void
Date:   Fri,  8 Dec 2023 17:08:12 +0100
Message-ID:  <09a89926787cb9f64caa73c510f04d9f04a5136f.1702051073.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1a3XrsIBjUzDTZoYZo4bHiJM6guDdpuYJ7uENxq/LbU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcz97w6if+bX06ito1EaAC/uUsJes2JGyWHnGh dgvlVq86nCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXM/ewAKCRCPgPtYfRL+ Ts89B/oCRgIz6tkNDFCrphlrv06SguKi+HPpSGGGY7TgCExVUV2jfIhyf6ZdBHryu2siN/p4VPj ZhfzTTulkKtT2wo2fzHOMk8aGeD9c9FUnA9sBwKZYKPoR2bwm+vaAl4b/uGNlOkSSbhZi8kZAz9 bR3nQ8lOwrHWwk8Zf8jamhyJ8cOPKMKxIcF7ramO5mSYBCiToS438PLO9FIkTCyuZcimw7RM5Wq r/XCKtnQgtN6gMceOLF4GwnYLZkoUMr+o7zn2Zo1/wOdABOkIfft10kEecl3ghUdrJ6SXC6/tAK m1nK+HFlsB3WJ6Pe0gm8elfqNIzhFIOKC90kmr+mmkxIiPeX
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
 drivers/pcmcia/xxs1500_ss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/xxs1500_ss.c b/drivers/pcmcia/xxs1500_ss.c
index b11c7abb1dc0..2a93fbbd128d 100644
--- a/drivers/pcmcia/xxs1500_ss.c
+++ b/drivers/pcmcia/xxs1500_ss.c
@@ -301,7 +301,7 @@ static int xxs1500_pcmcia_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xxs1500_pcmcia_remove(struct platform_device *pdev)
+static void xxs1500_pcmcia_remove(struct platform_device *pdev)
 {
 	struct xxs1500_pcmcia_sock *sock = platform_get_drvdata(pdev);
 
@@ -309,8 +309,6 @@ static int xxs1500_pcmcia_remove(struct platform_device *pdev)
 	free_irq(gpio_to_irq(GPIO_CDA), sock);
 	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
 	kfree(sock);
-
-	return 0;
 }
 
 static struct platform_driver xxs1500_pcmcia_socket_driver = {
@@ -318,7 +316,7 @@ static struct platform_driver xxs1500_pcmcia_socket_driver = {
 		.name	= "xxs1500_pcmcia",
 	},
 	.probe		= xxs1500_pcmcia_probe,
-	.remove		= xxs1500_pcmcia_remove,
+	.remove_new	= xxs1500_pcmcia_remove,
 };
 
 module_platform_driver(xxs1500_pcmcia_socket_driver);
-- 
2.42.0

