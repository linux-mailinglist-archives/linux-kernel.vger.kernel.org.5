Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7F804125
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjLDVwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:52:23 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389CC3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:52:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAGrU-0008G2-Am; Mon, 04 Dec 2023 22:52:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAGrS-00DbUc-P8; Mon, 04 Dec 2023 22:52:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAGrS-00ELqH-Fk; Mon, 04 Dec 2023 22:52:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jonathan Singer <jes965@nyu.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        SungHwan Jung <onenowy@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] platform/x86: hp-wmi: Convert to platform remove callback returning void
Date:   Mon,  4 Dec 2023 22:52:12 +0100
Message-ID:  <a6b074b7ee37f3682da4b3f39ea40af97add64c2.1701726190.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701726190.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701726190.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6eVY8z/A3k8fCdRzyiRfKam1KZi6FiUt4SL/1W+RYfE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQ8L54FRRnJjzdwfLuv90P4yt36Z5ev7oqZPO38yvKHp a29FkGGnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBM5IcLB0NrRdP84FjmFfP9 3dwkC7ce0yyu2D7dMObw01tr/LK/RXQsNjHkYZg14fr1d/0fyw7vya5baBW+4cjKqgaLPUv5ghg 8Qz5ODDj09sK8wq857LXBi1b8mMU2LSug68M+B+sO+Ynek4RUrmdw3/207f2aSxtvZu6T5dmpd6 tBk8c2/WvoTy/7b2slexefNg/cXlPmvip2smafxtHrX3bo5wXXclRFnXFj1tn6XX6WvYpI7rJsr tf7lKL1VBkywn9qi7EXrtN68nxTE39N5BkLY7Ufbc6pbBGyUzpi7N5pui1zSHgsYuKozK6jky05 ofZZ2u5DV/3/pGY1iAkzJAWd+8+7OZfJe3PjVGvLl53HAQ==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/platform/x86/hp/hp-wmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8ebb7be52ee7..e536604225c5 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1478,7 +1478,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	return 0;
 }
 
-static int __exit hp_wmi_bios_remove(struct platform_device *device)
+static void __exit hp_wmi_bios_remove(struct platform_device *device)
 {
 	int i;
 
@@ -1502,8 +1502,6 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
 
 	if (platform_profile_support)
 		platform_profile_remove();
-
-	return 0;
 }
 
 static int hp_wmi_resume_handler(struct device *device)
@@ -1560,7 +1558,7 @@ static struct platform_driver hp_wmi_driver __refdata = {
 		.pm = &hp_wmi_pm_ops,
 		.dev_groups = hp_wmi_groups,
 	},
-	.remove = __exit_p(hp_wmi_bios_remove),
+	.remove_new = __exit_p(hp_wmi_bios_remove),
 };
 
 static umode_t hp_wmi_hwmon_is_visible(const void *data,
-- 
2.42.0

