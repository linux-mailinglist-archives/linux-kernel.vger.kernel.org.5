Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E179975BFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGUHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGUHdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:33:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5819A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:33:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMkdQ-0004QZ-Rt; Fri, 21 Jul 2023 09:33:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMkdP-0010y3-Mq; Fri, 21 Jul 2023 09:33:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMkdP-006Z3w-2d; Fri, 21 Jul 2023 09:33:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regulator: max8893: Drop "_new" from probe callback
Date:   Fri, 21 Jul 2023 09:33:03 +0200
Message-Id: <20230721073303.112597-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gNNwWgecuG8lSYDEqAZEIrha6k/75RXWaaE9779yXcs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkujSu+FOkhn8759g0ijWboNQ7cfiIwvX6Mdpd0 l1B8m6RxPSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLo0rgAKCRCPgPtYfRL+ TnD5B/0VxawHr003klht5sQo0bzEZy2Zy7ZqiONEBrOryxXLJo5toRcq9IttIhttJe8sM8XGwgJ Cr7sOCpvkeDsx497R1lFwhH1y1BEcnMgwPXo5eWqdLuz10Uy6Gm0MijW+Ws63kj2dRkDjIIV2hH RrJmWlVWKMhCynuReRGx2CTdT2ivAqhqIm+/xd2Chz5UbQHfDuIr4Ty48qIAm3m5YAT02bU/MD4 cYevcsPUviH6Ki7XoPsnPuW0N2GZb+lIXRCV/OqY3IMJfGHr/fmAboPIJWgQdJjvBVQe1+OmJvp gM5zJI6l7i8OYB88OAxNw6PXnGBnwScX9RcYr+94RpIKBJno
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was introduced when .probe_new was the right probe callback
to use for i2c drivers. Today .probe is the right one (again) and the
driver was already switched in commit 964e186547b2 ("regulator: Switch
i2c drivers back to use .probe()") but the name continued to include
"_new". To prevent code readers wondering about what might be new here,
drop that part of the name.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/regulator/max8893.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max8893.c b/drivers/regulator/max8893.c
index cb0e72948dd4..30592425e193 100644
--- a/drivers/regulator/max8893.c
+++ b/drivers/regulator/max8893.c
@@ -125,7 +125,7 @@ static const struct regmap_config max8893_regmap = {
 	.val_bits = 8,
 };
 
-static int max8893_probe_new(struct i2c_client *i2c)
+static int max8893_probe(struct i2c_client *i2c)
 {
 	int id, ret;
 	struct regulator_config config = {.dev = &i2c->dev};
@@ -168,7 +168,7 @@ static const struct i2c_device_id max8893_ids[] = {
 MODULE_DEVICE_TABLE(i2c, max8893_ids);
 
 static struct i2c_driver max8893_driver = {
-	.probe		= max8893_probe_new,
+	.probe		= max8893_probe,
 	.driver		= {
 		.name	= "max8893",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

base-commit: 964e186547b22b9c3b23fee49eb993391aa73ea8
-- 
2.39.2

