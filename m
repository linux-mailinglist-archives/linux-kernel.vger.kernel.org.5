Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7225F7FE2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjK2WVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2WVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:21:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE181B2;
        Wed, 29 Nov 2023 14:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701296497; x=1732832497;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cJyfY54HPBudYrh68xzafpqw9C8nqcKlO72JEQ0kcdQ=;
  b=c+1kLW1Q9nQ2+9S8LBddcdKvHkMpOHLz8I3T2NdGi1SGFij3Co0DvqDT
   h5HMpZKRaFpGdxAOLXdybmjybizZDj1hvZPcCqSdxXC64DVvOTz3pXy2k
   CV2RVqiiuSQMMH4IxKHotbXCHAzsLHwDrcShN9tKxbEIm181+6yrg8+VY
   msDuA0n/soiO4xvKHcly2klKZHGsf31tv3hgnJM4dUtS3v9uP7aYpqnlN
   qrVIHJfguXDayCZvqfYdPo+RWW4fTvGq4xcbcQk6OE0bU4SGH6UKBLfOW
   Z8J44vpm0b7+D6+jrGqTQyOek01uWE2+wGlS90bVrtghtFleOiKf+v4vQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11936986"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11936986"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798070411"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798070411"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:33 -0800
Received: from debox1-desk4.lan (unknown [10.209.108.167])
        by linux.intel.com (Postfix) with ESMTP id E0A485807E2;
        Wed, 29 Nov 2023 14:21:32 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V6 02/20] platform/x86/intel/vsec: Remove unnecessary return
Date:   Wed, 29 Nov 2023 14:21:14 -0800
Message-Id: <20231129222132.2331261-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129222132.2331261-1-david.e.box@linux.intel.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In intel_vsec_add_aux(), just return from the last call to
devm_add_action_or_reset() instead of checking its return value.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V6 - New patch

 drivers/platform/x86/intel/vsec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 2d568466b4e2..340562ae2041 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -174,12 +174,8 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(parent, intel_vsec_remove_aux,
+	return devm_add_action_or_reset(parent, intel_vsec_remove_aux,
 				       auxdev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
 
-- 
2.34.1

