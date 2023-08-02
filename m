Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1476CECA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHBNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjHBNcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:32:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AC30C7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:32:33 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGCWb56XDzLnvv;
        Wed,  2 Aug 2023 21:29:47 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 21:32:30 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <yuehaibing@huawei.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] iommu/amd: Remove unsued extern declaration amd_iommu_init_hardware()
Date:   Wed, 2 Aug 2023 21:32:01 +0800
Message-ID: <20230802133201.17512-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Commit 2c0ae1720c09 ("iommu/amd: Convert iommu initialization to state machine")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/amd-iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 953e6f12fa1c..99a5201d9e62 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -32,7 +32,6 @@ struct task_struct;
 struct pci_dev;
 
 extern int amd_iommu_detect(void);
-extern int amd_iommu_init_hardware(void);
 
 /**
  * amd_iommu_init_device() - Init device for use with IOMMUv2 driver
-- 
2.34.1

