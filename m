Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64497C9DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJPDcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjJPDcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:32:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CECD9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697427131; x=1728963131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7iMKDRCvqp9vX9k3vsWvlopQYAJfIXTN0uAtyli9Xik=;
  b=JhawLF0SP9+PKOKUSLP3xoFATIesC9VDB7eqYc6GqKsJVrYROPLIz7BE
   5Wredt/EtmZcWkkjvN4y+BoGOed9iFxKNfCCA+MW+36XQ22a+lqWK2NUp
   rxK6/2DMLm7RImYgVicaHQ/OD74+CupbW6kkQczgNhHtlSVTsZ6UmGsrE
   Fga+jSBwaNEsvrDuyJrwGbo/KLi1BCEhSX84gNj12F7UVoF0cVpl8ooBC
   OzJDIrMGSkuGvSMOPxMT+3A0GMLoWPdYrhJg/p003iYshgDj6O1ZdkyAo
   rid02wj9xeLFVcIJYszViB94EDbeu9qQz7/ewjAjid3Rf5nGM227f39Lp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365701124"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365701124"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705444251"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="705444251"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2023 20:32:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jingqi Liu <Jingqi.liu@intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/vt-d: Remove unused function
Date:   Mon, 16 Oct 2023 11:28:27 +0800
Message-Id: <20231016032830.101321-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016032830.101321-1-baolu.lu@linux.intel.com>
References: <20231016032830.101321-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The function are defined in the pasid.c file, but not called
elsewhere, so delete the unused function.

drivers/iommu/intel/pasid.c:342:20: warning: unused function 'pasid_set_wpe'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6185
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230818091603.64800-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 8f92b92f3d2a..06ddb3c927f5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,15 +335,6 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
-/*
- * Setup the WPE(Write Protect Enable) field (Bit 132) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_wpe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
-}
-
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
-- 
2.34.1

