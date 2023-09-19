Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7897A6088
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjISLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjISLDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:03:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4C134
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:03:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiYVs-0006bq-Nl; Tue, 19 Sep 2023 13:03:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiYVr-007RME-5E; Tue, 19 Sep 2023 13:03:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiYVq-002yMW-S6; Tue, 19 Sep 2023 13:03:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH for-v6.6] mfd: cs42l43: Use correct macro for new-style PM runtime ops
Date:   Tue, 19 Sep 2023 13:03:20 +0200
Message-Id: <20230919110320.1388527-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nd+RxmV5D3okRiBan5re5Oiby0dizIaVKqCwQ5aAluE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCX/3NgN0LDYR5jZJxUqK08mr8KEwpkzLVaBYZ W7z0jGscOSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQl/9wAKCRCPgPtYfRL+ TklZCACJkIaBWazOGHlc+cYQqSBdT/zMuXotSbHtmFRYPvE/h3Lg+NtypPFhpod1m52Yg3tFdon 9ZNk9cF+NvRJRo5GzFI37bW4EyCg5FtRTnr61ghN1aKUZc2ZubJGDmwDdM2Z8iOOjYJ+BJqOuaU qUdjXlu7yWHmF70GOg2U3FMbZLlaDn1K0d8+S2AiCzSOybEF7RfGieGoj6mXobON1MijCvZI3oQ el/D71QIg6YWSqKnsZoYZG/jukrqaJ11DdC+fRxWqXhNdnlyi8vkKpepWOdkbZuJJ/EsX1I3+2/ XXINRli1S6WBSdx8jdpxFi1l7t/UaCCLHknf8CbRhvE95JYA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

The code was accidentally mixing new and old style macros, update the
macros used to remove an unused function warning whilst building with
no PM enabled in the config.

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com/
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello Linus,

this patch was submitted on August 22 already, but -rc2 is still
unfixed. This makes allmodconfig builds on (at least) s390 and m68k
fail.

Lee who should normally send this fix to you seems to be swamped in
other work and asked: "If anyone wants to submit this directly to Linus
before -rc1, please, be my guest."

Voilà, I'm Lee's guest now :-)

Thanks for considering to take this patch this way,
Uwe

 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 37b23e9bae82..7b6d07cbe6fc 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
-	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
+	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
 };
 
 MODULE_DESCRIPTION("CS42L43 Core Driver");

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

