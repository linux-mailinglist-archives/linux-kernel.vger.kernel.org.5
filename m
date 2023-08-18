Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6304E780C02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359452AbjHRMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359451AbjHRMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:42:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507ED4206
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:42:36 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RS1h51H8kzkXJs;
        Fri, 18 Aug 2023 20:41:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 20:42:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] regulator: db8500-prcmu: Remove unused declaration power_state_active_is_enabled()
Date:   Fri, 18 Aug 2023 20:42:27 +0800
Message-ID: <20230818124227.15084-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 38e968380b27 ("regulators/db8500: split off shared dbx500 code")
removed this but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/regulator/db8500-prcmu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/regulator/db8500-prcmu.h b/include/linux/regulator/db8500-prcmu.h
index f90df9ee703e..d58ff273157e 100644
--- a/include/linux/regulator/db8500-prcmu.h
+++ b/include/linux/regulator/db8500-prcmu.h
@@ -35,10 +35,4 @@ enum db8500_regulator_id {
 	DB8500_NUM_REGULATORS
 };
 
-/*
- * Exported interface for CPUIdle only. This function is called with all
- * interrupts turned off.
- */
-int power_state_active_is_enabled(void);
-
 #endif
-- 
2.34.1

