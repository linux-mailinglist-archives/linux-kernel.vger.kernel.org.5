Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085487745B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHHSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjHHSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:44:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191323D1B5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:41:34 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKtXC2rJ5z1hwFL;
        Tue,  8 Aug 2023 20:58:03 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:00:52 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <lee@kernel.org>, <thor.thayer@linux.intel.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next 3/8] mfd: rsmu_spi: remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 21:00:18 +0800
Message-ID: <20230808130023.202700-4-wangzhu9@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/mfd/rsmu_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index a4a595bb8d0d..ca0a1202c3ce 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -262,7 +262,7 @@ MODULE_DEVICE_TABLE(of, rsmu_spi_of_match);
 static struct spi_driver rsmu_spi_driver = {
 	.driver = {
 		.name = "rsmu-spi",
-		.of_match_table = of_match_ptr(rsmu_spi_of_match),
+		.of_match_table = rsmu_spi_of_match,
 	},
 	.probe = rsmu_spi_probe,
 	.remove	= rsmu_spi_remove,
-- 
2.17.1

