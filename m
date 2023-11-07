Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C67E4136
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjKGNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjKGNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:52:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D719BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699365087; x=1730901087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tXkEkdouSGqjpSmp69dGBr2atkMtY9MAl6fJ0kw7+M8=;
  b=gTZWjEwIQzJjQs/IbATH5rFo56Ow1xlDr++QFDQGAJA86giksrUVCnU5
   8LRtqRlEnpLd4piZFX922GuPQmBnbY1E2yKWL3u5jqHHuTE2RDNKdDZ8y
   GvNzOyrTtHNz0MGd4Kks5aWd/05CfchxUlcOQsc8bbS3VqfavKWA23du2
   ttQQXilMzO5vkbutdXd2LK6jh5tQUH6ERRB3TbBCsc9yr2MDGS9W6NgPR
   o5b0X5SPf9iPcEHPf9P+0hW4tXJ4lNoPCUOAbRGSSnIFV5cWXtZ9Akmjl
   k0aRZAKtxQLMk3oH9JKAIVnxNa5uOVQPINNvh0MLlVddoRNDaYdY8n0sT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420618972"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="420618972"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 05:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762705092"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="762705092"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 05:51:24 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Revert "mei/hdcp: Also enable for XE"
Date:   Tue,  7 Nov 2023 15:46:02 +0200
Message-Id: <20231107134606.316651-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107134606.316651-1-alexander.usyskin@intel.com>
References: <20231107134606.316651-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 62db7d00efe48c614b006086f306d5addedf8f83.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hdcp/Kconfig    | 2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
index 2ac9148988d4..54e1c9526909 100644
--- a/drivers/misc/mei/hdcp/Kconfig
+++ b/drivers/misc/mei/hdcp/Kconfig
@@ -4,7 +4,7 @@
 config INTEL_MEI_HDCP
 	tristate "Intel HDCP2.2 services of ME Interface"
 	select INTEL_MEI_ME
-	depends on DRM_I915 || DRM_XE
+	depends on DRM_I915
 	help
 	  MEI Support for HDCP2.2 Services on Intel platforms.
 
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index 94beb5667faa..51359cc5ece9 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -782,8 +782,7 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
 {
 	struct device *base = data;
 
-	if (!dev->driver ||
-	    (strcmp(dev->driver->name, "i915") && strcmp(dev->driver->name, "xe")) ||
+	if (!dev->driver || strcmp(dev->driver->name, "i915") ||
 	    subcomponent != I915_COMPONENT_HDCP)
 		return 0;
 
-- 
2.34.1

