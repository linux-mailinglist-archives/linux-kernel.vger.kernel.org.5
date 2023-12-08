Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCDF80A4B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573834AbjLHNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573854AbjLHNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:48:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244319A5;
        Fri,  8 Dec 2023 05:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702043341; x=1733579341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XNlRwVlmc+8hzsq40kB9DkDfrP9F0EEFpnBMErhT0CY=;
  b=jjII/BUZbzjZSeBHP/Wlg1pkrkOfnZvwwJQ8C5SrLVi0bIV7uKEjYH6W
   k4LlbJw37vSGrGKYTwU1pEjoTwU00/feQ8R5yI899srZ8Xp/i7bmsKNAL
   nT+uIZa9PjlpSMlTb1/yM3ng7adN3Z7WffwYIRXqNajWMVQsIW7XNTc0c
   bWzzeoYdoStkD/Xq2TduIvPV5RmYn40EhdqqMCxUEksBEXPBAJ/Iu8gBF
   B0cMHU3MbK4B/jh18zQrElMpFxS2piUnCaTL4XCVScCouTxbhX/JXmeah
   VBDlpGdjW3x9EJnzEC83f1k7WmCJkrEC2Plt0VaO6JV+D4D0pBoIakASc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7732128"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="7732128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 05:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="17460342"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 05:48:58 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] platform/x86: ips: Remove unused debug code
Date:   Fri,  8 Dec 2023 15:48:45 +0200
Message-Id: <20231208134845.3900-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
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

Remove unused debug code inside #if 0 ... #endif.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel_ips.c | 33 --------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 4dfdbfca6841..e26e7e14c44c 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1105,39 +1105,6 @@ static int ips_monitor(void *data)
 	return 0;
 }
 
-#if 0
-#define THM_DUMPW(reg) \
-	{ \
-	u16 val = thm_readw(reg); \
-	dev_dbg(ips->dev, #reg ": 0x%04x\n", val); \
-	}
-#define THM_DUMPL(reg) \
-	{ \
-	u32 val = thm_readl(reg); \
-	dev_dbg(ips->dev, #reg ": 0x%08x\n", val); \
-	}
-#define THM_DUMPQ(reg) \
-	{ \
-	u64 val = thm_readq(reg); \
-	dev_dbg(ips->dev, #reg ": 0x%016x\n", val); \
-	}
-
-static void dump_thermal_info(struct ips_driver *ips)
-{
-	u16 ptl;
-
-	ptl = thm_readw(THM_PTL);
-	dev_dbg(ips->dev, "Processor temp limit: %d\n", ptl);
-
-	THM_DUMPW(THM_CTA);
-	THM_DUMPW(THM_TRC);
-	THM_DUMPW(THM_CTV1);
-	THM_DUMPL(THM_STS);
-	THM_DUMPW(THM_PTV);
-	THM_DUMPQ(THM_MGTV);
-}
-#endif
-
 /**
  * ips_irq_handler - handle temperature triggers and other IPS events
  * @irq: irq number
-- 
2.30.2

