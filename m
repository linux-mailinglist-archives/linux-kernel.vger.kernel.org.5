Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5177E2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbjHPNgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245366AbjHPNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:36:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610502135;
        Wed, 16 Aug 2023 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692192970; x=1723728970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TE8xFz46eSdiuejrPPY/FLyzDqCT21o+NFLRZALGZD8=;
  b=PCAMOQDGMd/OurCit0MLFTj21Lkget9uCvfJt/eYe35g7LZQbBaZi/sG
   hC/fE+mTedIBS48Q0W0bQ4WkYW6E7pyf/5hgEiYI2pVeBezrLXHsmNn1g
   Z8imgct3TOZf84D4GNA/UPSW3tLai8AYIyXr5ZxetydZMS6hzDdpsdSfJ
   JjPFaNzEhXXRWf9JnyBjESkG4JqMcTiTJHp7Oes1jotXii7DqptLtWX6i
   GFaOLW0ZtU9Fc9Vs7rgrK6Cpf/xJS6PbNPNeXch9KyexT3MsdLZD3R71g
   j+4iX3D94sjfsYHUlSYvJZqYlPT2rrojeOkdTkZWPSASP4rFdP91kzgTo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372537580"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372537580"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 06:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980748915"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980748915"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 06:36:06 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id CE9031209F7;
        Wed, 16 Aug 2023 16:36:03 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1qWGgS-00GC1f-30;
        Wed, 16 Aug 2023 16:35:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 2/2] media: ivsc: Add ACPI dependency
Date:   Wed, 16 Aug 2023 16:35:26 +0300
Message-Id: <20230816133526.3859456-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
References: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IVSC driver only works in ACPI systems so make it depend on ACPI.

Compiling it elsewhere has little if any value.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 29006e196a56 ("media: pci: intel: ivsc: Add CSI submodule")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/pci/intel/ivsc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ivsc/Kconfig b/drivers/media/pci/intel/ivsc/Kconfig
index ec4ade92f583..413053175df7 100644
--- a/drivers/media/pci/intel/ivsc/Kconfig
+++ b/drivers/media/pci/intel/ivsc/Kconfig
@@ -3,7 +3,7 @@
 
 config INTEL_VSC
 	tristate "Intel Visual Sensing Controller"
-	depends on INTEL_MEI
+	depends on INTEL_MEI && ACPI
 	help
 	  This adds support for Intel Visual Sensing Controller (IVSC).
 
-- 
2.39.2

