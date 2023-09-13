Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63679F071
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjIMRfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjIMRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:35:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F8A8;
        Wed, 13 Sep 2023 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694626536; x=1726162536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3/kfAqbdJ1Jw40JpAhtowZlrzIpwtchpP4+yODy4jDQ=;
  b=SWQvjKzSG3eVvW4+1ddUcmc2w8Vq2dF1+Kr3B0Qi15zQbWNNEwYCTZWo
   c5xxe0A5aG3xoBe4xue7SJbaRpglef+H0JcY+xqhsuoL6r27B5SuJtNVf
   doHvxqx+ffW3QE24TqUgF1t3Sfp9mGxDy7ehjiAl36bycBWOYhb2XV6/+
   L/UoH2aohvL7y/zcO1tH+A2RCwXkI0G/M752xKc7bQe8GIGb9pjjQ9aTW
   NBFcRHtdNCbdGJwGBlmq3sQYsC7L45ULkYIlc8R9kRJtxuVijW0tV6Odp
   G1d/zQX6zmq/I0WOxxWdWviX+w0k7tj7pA7+4J0hCE+aTsEll2JKG39Ts
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="445168516"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="445168516"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 10:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="737603953"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737603953"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2023 10:35:36 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: Add ArrowLake-S PCI ID
Date:   Wed, 13 Sep 2023 10:35:10 -0700
Message-Id: <20230913173510.3963561-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ArrowLake-S PCI ID for processor thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.h    | 1 +
 .../intel/int340x_thermal/processor_thermal_device_pci.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index b974583c5c11..dd025c8c2bac 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -10,6 +10,7 @@
 #include <linux/intel_rapl.h>
 
 #define PCI_DEVICE_ID_INTEL_ADL_THERMAL	0x461d
+#define PCI_DEVICE_ID_INTEL_ARL_S_THERMAL 0xAD03
 #define PCI_DEVICE_ID_INTEL_BDW_THERMAL	0x1603
 #define PCI_DEVICE_ID_INTEL_BSW_THERMAL	0x22DC
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 7253277e476a..44b179ce9bc9 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -390,6 +390,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT) },
+	{ PCI_DEVICE_DATA(INTEL, ARL_S_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_WT_HINT) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ },
-- 
2.40.1

