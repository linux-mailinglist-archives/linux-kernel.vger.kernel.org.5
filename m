Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88884766E17
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjG1NZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjG1NZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:25:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7C83AB7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:25:15 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RC7dY3c88z1GDCV;
        Fri, 28 Jul 2023 21:24:17 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 21:25:12 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <lee@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: ab8500: Remove unused extern declarations
Date:   Fri, 28 Jul 2023 21:24:39 +0800
Message-ID: <20230728132439.31568-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d28f1db8187d ("mfd: Remove confusing ab8500-i2c file and merge into ab8500-core")
left behind this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/mfd/abx500/ab8500.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 302a330c5c84..09fb3c56e7d7 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -382,10 +382,6 @@ struct ab8500_platform_data {
 	struct ab8500_sysctrl_platform_data *sysctrl;
 };
 
-extern int ab8500_init(struct ab8500 *ab8500,
-				 enum ab8500_version version);
-extern int ab8500_exit(struct ab8500 *ab8500);
-
 extern int ab8500_suspend(struct ab8500 *ab8500);
 
 static inline int is_ab8500(struct ab8500 *ab)
-- 
2.34.1

