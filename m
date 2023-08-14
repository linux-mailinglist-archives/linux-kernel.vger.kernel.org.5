Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD477BAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjHNNzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjHNNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:55:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA04E6D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:55:11 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPbTp626WzrRxB;
        Mon, 14 Aug 2023 21:53:50 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 21:55:09 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH -next] iommu/amd: Remove unused declarations
Date:   Mon, 14 Aug 2023 21:55:02 +0800
Message-ID: <20230814135502.4808-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
removed the implementations but left declarations in place. Remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/iommu/amd/amd_iommu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f23ad6043f04..e2857109e966 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -20,9 +20,6 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
-int amd_iommu_init_devices(void);
-void amd_iommu_uninit_devices(void);
-void amd_iommu_init_notifier(void);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
-- 
2.34.1

