Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27676CEF6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjHBNkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHBNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:40:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4E2698
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:40:02 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGCjM1kGhzVj2S;
        Wed,  2 Aug 2023 21:38:15 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 21:39:59 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <baolu.lu@linux.intel.com>, <peterz@infradead.org>,
        <dwmw2@infradead.org>, <joro@8bytes.org>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
        <robin.murphy@arm.com>, <iommu@lists.linux.dev>
Subject: [PATCH -next] iommu: dmar: Remove unused extern declaration dmar_parse_dev_scope()
Date:   Wed, 2 Aug 2023 21:39:34 +0800
Message-ID: <20230802133934.19712-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

From: YueHaibing <yuehaibing@huawei.com>

Since commit 2e4552893038 ("iommu/vt-d: Unify the way to process DMAR device scope array")
this is not used anymore, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/dmar.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 27dbd4c64860..e34b601b71fd 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -106,8 +106,6 @@ static inline bool dmar_rcu_check(void)
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
 extern void dmar_register_bus_notifier(void);
-extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
-				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
 extern void dmar_free_dev_scope(struct dmar_dev_scope **devices, int *cnt);
 extern int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
-- 
2.34.1

