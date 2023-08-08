Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02007744BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbjHHS2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjHHS1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:27:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664FA9E93
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:46:21 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKtWR2nJmzNn1r;
        Tue,  8 Aug 2023 20:57:23 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:00:51 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <lee@kernel.org>, <thor.thayer@linux.intel.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next 2/8] mfd: altera-a10sr: remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 21:00:17 +0800
Message-ID: <20230808130023.202700-3-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808130023.202700-1-wangzhu9@huawei.com>
References: <20230808130023.202700-1-wangzhu9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/mfd/altera-a10sr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index 34ef526f4aee..d53e433ab5c1 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -163,7 +163,7 @@ static struct spi_driver altr_a10sr_spi_driver = {
 	.probe = altr_a10sr_spi_probe,
 	.driver = {
 		.name = "altr_a10sr",
-		.of_match_table = of_match_ptr(altr_a10sr_spi_of_match),
+		.of_match_table = altr_a10sr_spi_of_match,
 	},
 	.id_table = altr_a10sr_spi_ids,
 };
-- 
2.17.1

