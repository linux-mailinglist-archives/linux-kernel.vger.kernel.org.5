Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFA76B573
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjHANGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHANGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:06:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5AFE6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:06:37 -0700 (PDT)
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFb1H3RxWzVjsC;
        Tue,  1 Aug 2023 21:04:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 21:06:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 21:06:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <okan.sahin@analog.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] regulator: max77857: change some variables to static
Date:   Tue, 1 Aug 2023 21:03:54 +0800
Message-ID: <20230801130354.552243-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max77857_regmap_config and max77857_driver are only used
in max77857-regulator.c now, change them to static.

Fixes: af71cccadeced ("regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/regulator/max77857-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index 58f825d8d2b0..f2141b5be780 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -67,7 +67,7 @@ static bool max77857_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-struct regmap_config max77857_regmap_config = {
+static struct regmap_config max77857_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_MAPLE,
@@ -443,7 +443,7 @@ static const struct of_device_id max77857_of_id[] = {
 };
 MODULE_DEVICE_TABLE(of, max77857_of_id);
 
-struct i2c_driver max77857_driver = {
+static struct i2c_driver max77857_driver = {
 	.driver = {
 		.name = "max77857",
 		.of_match_table = max77857_of_id,
-- 
2.25.1

