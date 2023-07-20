Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C575B15B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjGTOhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGTOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:37:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB5C6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:37:44 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6Fd26XJNzrRp9;
        Thu, 20 Jul 2023 22:36:54 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 22:37:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lee@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: db8500-prcmu: Remove unused inline functions
Date:   Thu, 20 Jul 2023 22:37:38 +0800
Message-ID: <20230720143738.13996-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b0e846248de5 ("mfd: db8500-prcmu: Remove dead code for a non-existing config")
these inline helpers also no need any more.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/mfd/dbx500-prcmu.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index e7a7e70fdb38..dd0fc891b228 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -556,16 +556,6 @@ static inline void prcmu_clear(unsigned int reg, u32 bits)
 #define PRCMU_QOS_ARM_OPP 3
 #define PRCMU_QOS_DEFAULT_VALUE -1
 
-static inline unsigned long prcmu_qos_get_cpufreq_opp_delay(void)
-{
-	return 0;
-}
-
-static inline int prcmu_qos_requirement(int prcmu_qos_class)
-{
-	return 0;
-}
-
 static inline int prcmu_qos_add_requirement(int prcmu_qos_class,
 					    char *name, s32 value)
 {
@@ -582,15 +572,4 @@ static inline void prcmu_qos_remove_requirement(int prcmu_qos_class, char *name)
 {
 }
 
-static inline int prcmu_qos_add_notifier(int prcmu_qos_class,
-					 struct notifier_block *notifier)
-{
-	return 0;
-}
-static inline int prcmu_qos_remove_notifier(int prcmu_qos_class,
-					    struct notifier_block *notifier)
-{
-	return 0;
-}
-
 #endif /* __MACH_PRCMU_H */
-- 
2.34.1

