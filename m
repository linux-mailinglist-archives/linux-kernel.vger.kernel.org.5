Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DE756DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGQTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGQTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:54:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94951B4;
        Mon, 17 Jul 2023 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689623694; x=1721159694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bitjTo9+F/HSX0khDRogF+m02NyxMlqy5VpP4PrepmE=;
  b=C0Eh7MVN3/Ea0o+/j/bvYzSJYY7gJFTWRee9I90BXPoaekJ9LEiU2JtH
   VeqKjVWrzPdE7GSnzohX2ZqjwIS9sLB3UP4epBmJhQdYfIOia1oPDr99f
   9yN0YIOy0GsrK4YCH6yloyBYZOUgP60RxQczV6o1JqGEaPmAv9371BF6Y
   8cFHv/yOYJn8y0m8qpbe+7jD1fyNgB9V7ob+7ygtYZJciIdEuvaIxxgg9
   k7V3w4mItnq8aTXCpkP7u/thG0U/JI+jvCa80Mkf+yaZDImedP8LstP4P
   ZEQ5JoQNFXxj+z8tiYkSzPcuzVC9UBPOoSKo3OOCXXb19886p5kLZSM98
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366064605"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366064605"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 12:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788770753"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788770753"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 12:54:52 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/7] thermal/drivers/int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for Meteor Lake
Date:   Mon, 17 Jul 2023 12:54:02 -0700
Message-Id: <20230717195405.730869-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
References: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
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

Meteor Lake processor supports firmware hints for predicting workload
type. So, remove support for passing workload hints to the firmware.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
v2:
No change

 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 2be9b7f660d1..1061d1d8f38d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -364,8 +364,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WLT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WLT_REQ |
-	  PROC_THERMAL_FEATURE_DLVR) },
+	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WLT_REQ) },
 	{ },
-- 
2.38.1

