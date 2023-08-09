Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906AD775FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjHIMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjHIMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:51:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD352712
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585454; x=1723121454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ql8GvqSQc3MnpAxdXzxymy2oKa6nPM5ZIi5KTo5aEM=;
  b=NcMFahvDeq2pHq4IO9pJeljERzE/KWidwC+QfF6DiUx9C6llbnOLZD3Y
   1DPtLY54FW169MbWdgyCbmwnBRDwrHYWiCp+H1ABZm9QAnh8XchWJOgpS
   pW/5qRla6TWH3y/QWaNDs4UcYI6Jw66BAHx7z2B8qIXFs6azn6Rh5HgmN
   tjUQJkBFAgRMPSuYhswKLMWasDPT2gnW9OIk45vLiy36r/FYq16j9kLh9
   Nc37EgZ3K/D9suEDQxZe0QM8dz99J3Y89+VMDzKGHA4GzAs0TU2ZI6Jn3
   MoTwRclHBPLbc7jm5inHrbocviFZsJqeVOtA0YPwIH8ADOt/jLs9EwgFa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821777"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821777"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521902"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521902"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Yanfei Xu <yanfei.xu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] iommu/vt-d: Remove unused extern declaration dmar_parse_dev_scope()
Date:   Wed,  9 Aug 2023 20:48:06 +0800
Message-Id: <20230809124806.45516-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Since commit 2e4552893038 ("iommu/vt-d: Unify the way to process DMAR
device scope array") this is not used anymore, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20230802133934.19712-1-yuehaibing@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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

