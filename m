Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5847EE5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjKPRWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKPRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:22:01 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C31A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:21:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3g3w-0004am-KM
        for linux-kernel@vger.kernel.org; Thu, 16 Nov 2023 18:21:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3g3w-009V4F-7j
        for linux-kernel@vger.kernel.org; Thu, 16 Nov 2023 18:21:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3g3v-002jzQ-TP
        for linux-kernel@vger.kernel.org; Thu, 16 Nov 2023 18:21:55 +0100
Date:   Tue,  7 Nov 2023 21:28:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] intel_th: Convert to platform remove callback returning void
Message-ID: <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id;
 bh=H3WlFhNwTWEIC3GKjb4EEIvAB33g9aMn3hNOG1gVFO0=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVk+Immp0fcXGkgz4XIC1bc8xl04RuvFfVrfN4
 3VjNhMor+uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVZPiAAKCRCPgPtYfRL+
 Trg2B/4t3h2WeL07p0K6OfERb2hQw7Q/JGYAAlWPopXxn6AST1jwv15PHKjTCbAzNEZ5xs9iEc6
 x5+vJfgs+7coJKkWjr3QRDlIidgKsW2HBALi5A46JJ2Yjno5hILFFdHjGKE26StID/OppEQH2yG
 7CSeICkmNwcXW3bWE63a8pSnVWpIhS6ZjhyWgC0wywPCk16/rc61cjwvC4d7Vjoz2n/VqeP7jOm
 3J7M2MZkgDLMiisAn0ekoAwlJw4sTC2ajganQsVQ9AUv7kGtAU7pFtAatXvH4XuqMAGByIkgKa+
 oVOhIOue2fVab1eOJQ1WM97uoRkVW1eJCTUdiZAUD18p9tnV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/hwtracing/intel_th/acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/acpi.c b/drivers/hwtracing/intel_th/acpi.c
index 87f9024e4bbb..503620e9fd10 100644
--- a/drivers/hwtracing/intel_th/acpi.c
+++ b/drivers/hwtracing/intel_th/acpi.c
@@ -60,18 +60,16 @@ static int intel_th_acpi_probe(struct platform_device *pdev)
        return 0;
 }

-static int intel_th_acpi_remove(struct platform_device *pdev)
+static void intel_th_acpi_remove(struct platform_device *pdev)
 {
        struct intel_th *th = platform_get_drvdata(pdev);

        intel_th_free(th);
-
-       return 0;
 }

 static struct platform_driver intel_th_acpi_driver = {
        .probe          = intel_th_acpi_probe,
-       .remove         = intel_th_acpi_remove,
+       .remove_new     = intel_th_acpi_remove,
        .driver         = {
                .name                   = DRIVER_NAME,
                .acpi_match_table       = intel_th_acpi_ids,
--
2.42.0
