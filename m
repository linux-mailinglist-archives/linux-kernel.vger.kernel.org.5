Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0362780A846
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573969AbjLHQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjLHQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:09:16 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543AD1996
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:09:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPe-00007y-EO; Fri, 08 Dec 2023 17:09:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPc-00ES0L-Ja; Fri, 08 Dec 2023 17:09:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBdPc-00GUaK-AC; Fri, 08 Dec 2023 17:09:12 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/7] pcmcia: electra_cf: Convert to platform remove callback returning void
Date:   Fri,  8 Dec 2023 17:08:08 +0100
Message-ID:  <7b07c8624ab53ec90554b7a665bef7662bd94295.1702051073.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=n+hlrlFsRjhTMFN/VhJfgAOKKI1JiL5o8AuQJaDTRE8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcz9t4grYDDRNZRyGpl8l+mzx2yGASB8M17muz Vz022OdPTSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXM/bQAKCRCPgPtYfRL+ TpWNB/485Cj9cA18CE30IsaMcPnXRbCFsk534FXaxYYJXEMycoz4bZpvGAJ8jLOXWgDgnK70lsO +pkBkxwNVpvix2AxSiF1GJKuRYbtq3ddnTRfcBepESP3rormcBQnV2b1uxXh1cTgzlNprF13JfT tnqRFcuKsW7T5Y5yCk0hfyZ2G5f2Hw/myzn+GW33HwdfyvZhAlShhuiPiGb/VAxTMkL2qkobj67 mCJjMz9qfoQ1ai/FBtGTw0jkvOHNZnauPOGw83L0B0sjSgVSI3dvvrkOSizpLpMQ5C2rHABZwLh mKheugxZLvGkY1Z/cp+whv808yrozTDnjguLm2OgWGiqzRLr
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
 drivers/pcmcia/electra_cf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index efc27bc15152..5ae826e54811 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -307,7 +307,7 @@ static int electra_cf_probe(struct platform_device *ofdev)
 
 }
 
-static int electra_cf_remove(struct platform_device *ofdev)
+static void electra_cf_remove(struct platform_device *ofdev)
 {
 	struct device *device = &ofdev->dev;
 	struct electra_cf_socket *cf;
@@ -326,8 +326,6 @@ static int electra_cf_remove(struct platform_device *ofdev)
 	release_region(cf->io_base, cf->io_size);
 
 	kfree(cf);
-
-	return 0;
 }
 
 static const struct of_device_id electra_cf_match[] = {
@@ -344,7 +342,7 @@ static struct platform_driver electra_cf_driver = {
 		.of_match_table = electra_cf_match,
 	},
 	.probe	  = electra_cf_probe,
-	.remove   = electra_cf_remove,
+	.remove_new = electra_cf_remove,
 };
 
 module_platform_driver(electra_cf_driver);
-- 
2.42.0

