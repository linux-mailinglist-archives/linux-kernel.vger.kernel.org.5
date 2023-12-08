Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F62A8099F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjLHC6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjLHC6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:58:21 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17230D7;
        Thu,  7 Dec 2023 18:57:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vy1bwvd_1702004222;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vy1bwvd_1702004222)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 10:57:04 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: [PATCH v12 2/5] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
Date:   Fri,  8 Dec 2023 10:56:49 +0800
Message-Id: <20231208025652.87192-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma")
and will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the
Vendor ID to linux/pci_ids.h so that it can shared by several drivers
later.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h | 2 --
 include/linux/pci_ids.h                | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 9d316fdc6f9a..a155519a862f 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -11,8 +11,6 @@
 #include <linux/types.h>
 
 /* PCIe device related definition. */
-#define PCI_VENDOR_ID_ALIBABA 0x1ded
-
 #define ERDMA_PCI_WIDTH 64
 #define ERDMA_FUNC_BAR 0
 #define ERDMA_MISX_BAR 2
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..d8760daf9e5a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2601,6 +2601,8 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
+#define PCI_VENDOR_ID_ALIBABA		0x1ded
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.39.3

