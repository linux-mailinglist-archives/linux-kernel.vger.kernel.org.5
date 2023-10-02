Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D189D7B4D51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjJBIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjJBIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:33:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1E59F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696235629; x=1727771629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DB1LCxP8wJ/yvy6FuVZdYAd4NNE9k4ws3Z5aFq0RIrg=;
  b=C76fnPjl9Kaqft/JeIECEMLwHsdF/XO5kerzzl/CI/y1YQ1BzQNrNEiz
   xDuB9UpENptcjx0xQ0DHxxU1wxVJsdQrTCvGYGy3koF/1BHjgtQX5nYCk
   ZRRNz2TeMSsl21JeTwStgfJvgnyEYDA4mm/zMlxPQAO4Fx39UZGqhleMU
   cEq73jK9IpDdP0KGoqhIf5EdZo/YNtBVSIHHKaB4yUNPk+LDZv60z7Vlj
   M1XrLaos7cSDMpbUGp0THZLmDUwr1tEqX3odncSTypBIJbsVaG5PHKBC/
   Wu91vgHtfoXnKvf1LJxtYA5oH3J03l7EdZ1WP/FJHrwCihf0wb34wBJEj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="446757573"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="446757573"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 01:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081582503"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="1081582503"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.66])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 01:33:46 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
Date:   Mon,  2 Oct 2023 11:33:44 +0300
Message-Id: <20231002083344.75611-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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

Add Intel Lunar Lake-M SoC PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 699f44ffff0e..ae5759200622 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -561,6 +561,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa3e2), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e3), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e6), (kernel_ulong_t)&spt_uart_info },
+	/* LNL-M */
+	{ PCI_VDEVICE(INTEL, 0xa825), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa826), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa827), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa830), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa846), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa850), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa851), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa852), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa878), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa879), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa87a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa87b), (kernel_ulong_t)&ehl_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.40.1

