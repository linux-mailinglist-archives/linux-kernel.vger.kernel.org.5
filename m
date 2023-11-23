Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32D7F6487
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjKWQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345185AbjKWQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:57:01 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C30D5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0f-000572-6L; Thu, 23 Nov 2023 17:57:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0e-00B559-OK; Thu, 23 Nov 2023 17:57:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0e-006ozk-FA; Thu, 23 Nov 2023 17:57:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 11/18] mfd: omap-usb-tll: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:39 +0100
Message-ID: <20231123165627.492259-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6grJxx2LHRITrZAbOAlfmI+2kXgEuMJigw1AAr3yPog=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RIFwziiGXsZn1On1/MovUspXu733lLnlJFD RweOUzkJcaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+ESAAKCRCPgPtYfRL+ TvoiB/420e3zD2ZZI9dSb9u1sLR6OEJ63GxYAc51glsm6MAZhyys0dNzjVte35LL+w8oHPQKf79 4WA6Ugt2sTgD9fOcRoPM0wv35ApqXwf6dYwBdISkQVFIUcMsql5XWbJ6zlSSEIooEl9Q+lgjvsQ zRuiAm0/psL39x8zoXNCYJzoif+fi8lZp5xUlsrnXbLYqV7qlhM2cRwIdYWGM3q96tuWxtrTl2w IvN+uykum8DzDcXeG0WNKJQAQL2jCkl35Kafzzs9WauOkBpu1/6FaDAdzrv1p+3PD0Ci2mYLFK0 uSpw69ugywtV/QdI/BEKquIyLcjVxfKTRoGUDf6YR4D4LK8S
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/mfd/omap-usb-tll.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 906353735c78..b6303ddb013b 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -270,7 +270,7 @@ static int usbtll_omap_probe(struct platform_device *pdev)
  *
  * Reverses the effect of usbtll_omap_probe().
  */
-static int usbtll_omap_remove(struct platform_device *pdev)
+static void usbtll_omap_remove(struct platform_device *pdev)
 {
 	struct usbtll_omap *tll = platform_get_drvdata(pdev);
 	int i;
@@ -287,7 +287,6 @@ static int usbtll_omap_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static const struct of_device_id usbtll_omap_dt_ids[] = {
@@ -303,7 +302,7 @@ static struct platform_driver usbtll_omap_driver = {
 		.of_match_table = usbtll_omap_dt_ids,
 	},
 	.probe		= usbtll_omap_probe,
-	.remove		= usbtll_omap_remove,
+	.remove_new	= usbtll_omap_remove,
 };
 
 int omap_tll_init(struct usbhs_omap_platform_data *pdata)
-- 
2.42.0

