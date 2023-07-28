Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C61D766EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjG1NqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjG1NqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:46:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5651FC9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:46:03 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC7h44y3vzrRh6;
        Fri, 28 Jul 2023 21:26:28 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 21:27:24 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <cw00.choi@samsung.com>, <krzysztof.kozlowski@linaro.org>,
        <lee@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: max77686: Remove unused extern declarations
Date:   Fri, 28 Jul 2023 21:27:09 +0800
Message-ID: <20230728132709.27052-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

max77686_irq_init() and max77686_irq_exit() are not used since
commit 6f1c1e71d933 ("mfd: max77686: Convert to use regmap_irq").
And max77686_irq_resume() never be implemented since introduced in
commit dae8a969d512 ("mfd: Add Maxim 77686 driver").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/mfd/max77686-private.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mfd/max77686-private.h b/include/linux/mfd/max77686-private.h
index 3acceeedbaba..ea635d12a741 100644
--- a/include/linux/mfd/max77686-private.h
+++ b/include/linux/mfd/max77686-private.h
@@ -441,8 +441,4 @@ enum max77686_types {
 	TYPE_MAX77802,
 };
 
-extern int max77686_irq_init(struct max77686_dev *max77686);
-extern void max77686_irq_exit(struct max77686_dev *max77686);
-extern int max77686_irq_resume(struct max77686_dev *max77686);
-
 #endif /*  __LINUX_MFD_MAX77686_PRIV_H */
-- 
2.34.1

