Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0BB7BD6CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjJIJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbjJIJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A00106
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-0006sX-Q7; Mon, 09 Oct 2023 11:22:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-000NWQ-Cy; Mon, 09 Oct 2023 11:22:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-00C4ot-3k; Mon, 09 Oct 2023 11:22:34 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] pinctrl: single: Drop if block with always false condition
Date:   Mon,  9 Oct 2023 10:38:38 +0200
Message-Id: <20231009083856.222030-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YKE8P7L9V9D6eghladkosJamRCKd+b5UoH3TDoc6yRM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wBrRbKaWaukJeLRndrn6pB3LKccfQJKwli0 16nUYkI9b6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8AQAKCRCPgPtYfRL+ TtW7B/44yeQT6igw9tEP+D9fYA4PIKhJQgpUdOWoUs5fL0toneQALi3dmosp2c8vp33KXbG5Qgy 32gKGzf+3CTTwDt4cl8xQcZ70/Ohz/PcYkTUd7Gme7xu1aGLLK6+pkvaM3M52rKR34eRxypSYuy Ggkb4fFk0wsixK9fBpS3NiGHaMdNNUayaaHIBZJq86t8k95H9pAAQQwMds9td8bpVGZGGQuib89 TQUfrhk0wiNBGU4To6RwoELEpyMcGS5Pfa3TTeFMKp772k/RPGsfnCAUXWrc69WdEsJo+uASphm tAHS1lcCvheZbsA4qNTYqdhYXVk9XyCBDHT/GhiyL/tEioH4
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

pcs_remove() is only called after pcs_probe() completed successfully. In
this case platform_set_drvdata() was called with a non-NULL argument and
so platform_get_drvdata() won't return NULL.

Simplify by removing the if block with the always false condition.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/pinctrl-single.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 461a7c02d4a3..f6c02c8b934d 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1929,9 +1929,6 @@ static int pcs_remove(struct platform_device *pdev)
 {
 	struct pcs_device *pcs = platform_get_drvdata(pdev);
 
-	if (!pcs)
-		return 0;
-
 	pcs_free_resources(pcs);
 
 	return 0;
-- 
2.40.1

