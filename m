Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3729575C6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGUMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGUMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:12:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55B19B6;
        Fri, 21 Jul 2023 05:12:20 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R6pJq3nVvzHqXN;
        Fri, 21 Jul 2023 20:09:47 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 20:12:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rafael@kernel.org>, <paul@crapouillou.net>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PM-runtime: Remove unsued extern declaration pm_runtime_update_max_time_suspended()
Date:   Fri, 21 Jul 2023 20:12:16 +0800
Message-ID: <20230721121216.21816-1-yuehaibing@huawei.com>
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

commit 76e267d822f2 ("PM / Runtime: Remove device fields related to suspend time, v2")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/pm_runtime.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 9a8151a2bdea..7c9b35448563 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -85,8 +85,6 @@ extern void pm_runtime_irq_safe(struct device *dev);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
 extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
 extern u64 pm_runtime_autosuspend_expiration(struct device *dev);
-extern void pm_runtime_update_max_time_suspended(struct device *dev,
-						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
 extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
-- 
2.34.1

