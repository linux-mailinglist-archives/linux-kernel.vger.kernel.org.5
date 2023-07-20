Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E418E75B159
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjGTOhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGTOhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:37:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB973C6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:37:14 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6FcW1PFkzrRmZ;
        Thu, 20 Jul 2023 22:36:27 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 22:37:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <myungjoo.ham@samsung.com>, <cw00.choi@samsung.com>,
        <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] extcon: Remove unused inline functions
Date:   Thu, 20 Jul 2023 22:37:12 +0800
Message-ID: <20230720143712.24812-1-yuehaibing@huawei.com>
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

commit 830ae442202e ("extcon: Remove the deprecated extcon functions")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/extcon.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 3c45c3846fe9..e596a0abcb27 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -328,16 +328,4 @@ struct extcon_specific_cable_nb {
        struct extcon_dev *edev;
        unsigned long previous_value;
 };
-
-static inline int extcon_register_interest(struct extcon_specific_cable_nb *obj,
-				const char *extcon_name, const char *cable_name,
-				struct notifier_block *nb)
-{
-	return -EINVAL;
-}
-
-static inline int extcon_unregister_interest(struct extcon_specific_cable_nb *obj)
-{
-	return -EINVAL;
-}
 #endif /* __LINUX_EXTCON_H__ */
-- 
2.34.1

