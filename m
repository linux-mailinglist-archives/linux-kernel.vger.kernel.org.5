Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E380A845
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573909AbjLHQJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjLHQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:09:16 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B171994
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:09:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPe-00007w-ET; Fri, 08 Dec 2023 17:09:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPc-00ES0F-5z; Fri, 08 Dec 2023 17:09:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPb-00GUaC-Su; Fri, 08 Dec 2023 17:09:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/7] pcmcia: bcm63xx: Convert to platform remove callback returning void
Date:   Fri,  8 Dec 2023 17:08:06 +0100
Message-ID:  <33611a4245b4dabc609a75cf0e0db5e06e9a6fc8.1702051073.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rK09bKbPy9IbxRyCb0eChVFpuUmGGmru+y/jU63xJqA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcz9qf3TyhbKQ0U4p75u1hl/4Mrffgxd57x3kV GXFT44SdOaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXM/agAKCRCPgPtYfRL+ TijcB/wOCUrzq/j4P2FtkyFicRvWJMrTqnRvDntTRY+jRqWW8O9B9u/G9kdrd4QkYgIXnEGIk03 lhfIIUesDJOtV4xZUtbpdMcmm7mddVSP3iRV5YjnCNiQp7Y4rq3bkmH5frSgnVq5tEn9syzl12W p83Rx2OUCTw4RSxDrdqxSvkbDSR4anVM7uQN4xs0P8pwUtSbJnjOKtnUy88iF4Kq9LlDFy0UtfW wtj/psLY47/K9fM3MEHJfisa+aULQ0ILBTACcVFuGG8tdQUn/+xWP9HFmEy2MR3ycAd2AziQFlu Pt9Xa4e/kgBi2QTe4s6yfHO9anTFAySqvgQupJp6X4sR3muf
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
 drivers/pcmcia/bcm63xx_pcmcia.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index dd3c26099048..a5414441834a 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -437,7 +437,7 @@ static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
+static void bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
 {
 	struct bcm63xx_pcmcia_socket *skt;
 	struct resource *res;
@@ -449,12 +449,11 @@ static int bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
 	res = skt->reg_res;
 	release_mem_region(res->start, resource_size(res));
 	kfree(skt);
-	return 0;
 }
 
 struct platform_driver bcm63xx_pcmcia_driver = {
 	.probe	= bcm63xx_drv_pcmcia_probe,
-	.remove	= bcm63xx_drv_pcmcia_remove,
+	.remove_new = bcm63xx_drv_pcmcia_remove,
 	.driver	= {
 		.name	= "bcm63xx_pcmcia",
 		.owner  = THIS_MODULE,
-- 
2.42.0

