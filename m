Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9CC7AFDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjI0IMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjI0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C619A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdD-000892-Gs; Wed, 27 Sep 2023 10:10:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-009I8F-Pf; Wed, 27 Sep 2023 10:10:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-005BRV-GP; Wed, 27 Sep 2023 10:10:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 23/27] platform/x86/siemens: simatic-ipc-batt: Simplify simatic_ipc_batt_remove()
Date:   Wed, 27 Sep 2023 10:10:36 +0200
Message-Id: <20230927081040.2198742-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uUXb4B5hrdHXmnbVK9GlXIsjnQhNbsw+/k4ukKVrWu0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+N4kwnW/Gz1Hb8gOU61vNE7HtCRpVAF86OF/ M/C+6XRZvCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjeAAKCRCPgPtYfRL+ TtseCACj0gQGeWiU0bRMvJ1gQPadWXcVIyxZ4FslwgDU1A1vYNjJrY7VDOKI2mf0WkCbiKzXMbj SRZEgEzPHToBhNmn5N8wVr2myrOHnM3b+dGZOcayR8ivOixBtHJFOdcwDFGyO0jNy1HK3WJ3e4U Zk+4C+9r6OziCcGW8ng5UqLLqvUHX3blw/TmP7o9XLPNrdUpQv+VM6MVRwYLeDCEWfYPG6hgSdD piaO23kG367PShsCxsSOLsz9ajcC29glH3Jm+szb28udEIjW3+ruzGShE9Gt+aw0qoWYvnb/cHi nbm6wBjeqog2eVq5XEkcTNIGZKmGKABbarxe8m5DwNeOd+qA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of unconditionally returning zero, let simatic_ipc_batt_remove()
return no value. This is a preparation to convert the drivers using this
function to struct platform_driver::remove_new().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c | 4 +++-
 .../platform/x86/siemens/simatic-ipc-batt-elkhartlake.c    | 4 +++-
 drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c     | 4 +++-
 drivers/platform/x86/siemens/simatic-ipc-batt.c            | 7 ++++---
 drivers/platform/x86/siemens/simatic-ipc-batt.h            | 4 ++--
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
index 8a67979d8f96..3e22a6bc9118 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
@@ -27,7 +27,9 @@ static struct gpiod_lookup_table simatic_ipc_batt_gpio_table_127e = {
 
 static int simatic_ipc_batt_apollolake_remove(struct platform_device *pdev)
 {
-	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_127e);
+	simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_127e);
+
+	return 0;
 }
 
 static int simatic_ipc_batt_apollolake_probe(struct platform_device *pdev)
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
index 607d033911a2..9e08c659f27d 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
@@ -27,7 +27,9 @@ static struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_21a = {
 
 static int simatic_ipc_batt_elkhartlake_remove(struct platform_device *pdev)
 {
-	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_21a);
+	simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_21a);
+
+	return 0;
 }
 
 static int simatic_ipc_batt_elkhartlake_probe(struct platform_device *pdev)
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
index a66107e0fe1e..19c302a68911 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
@@ -47,7 +47,9 @@ static struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_59a = {
 
 static int simatic_ipc_batt_f7188x_remove(struct platform_device *pdev)
 {
-	return simatic_ipc_batt_remove(pdev, batt_lookup_table);
+	simatic_ipc_batt_remove(pdev, batt_lookup_table);
+
+	return 0;
 }
 
 static int simatic_ipc_batt_f7188x_probe(struct platform_device *pdev)
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
index ef28c806b383..07cd4944de32 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
@@ -146,10 +146,9 @@ static const struct hwmon_chip_info simatic_ipc_batt_chip_info = {
 	.info = simatic_ipc_batt_info,
 };
 
-int simatic_ipc_batt_remove(struct platform_device *pdev, struct gpiod_lookup_table *table)
+void simatic_ipc_batt_remove(struct platform_device *pdev, struct gpiod_lookup_table *table)
 {
 	gpiod_remove_lookup_table(table);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(simatic_ipc_batt_remove);
 
@@ -230,7 +229,9 @@ EXPORT_SYMBOL_GPL(simatic_ipc_batt_probe);
 
 static int simatic_ipc_batt_io_remove(struct platform_device *pdev)
 {
-	return simatic_ipc_batt_remove(pdev, NULL);
+	simatic_ipc_batt_remove(pdev, NULL);
+
+	return 0;
 }
 
 static int simatic_ipc_batt_io_probe(struct platform_device *pdev)
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.h b/drivers/platform/x86/siemens/simatic-ipc-batt.h
index 4545cd3e3026..89891db26a2c 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.h
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.h
@@ -14,7 +14,7 @@
 int simatic_ipc_batt_probe(struct platform_device *pdev,
 			   struct gpiod_lookup_table *table);
 
-int simatic_ipc_batt_remove(struct platform_device *pdev,
-			    struct gpiod_lookup_table *table);
+void simatic_ipc_batt_remove(struct platform_device *pdev,
+			     struct gpiod_lookup_table *table);
 
 #endif /* _SIMATIC_IPC_BATT_H */
-- 
2.40.1

