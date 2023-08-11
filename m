Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895B67798F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbjHKUwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbjHKUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:52:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F52D55;
        Fri, 11 Aug 2023 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691787143; x=1723323143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YmwTEx/14K2EfY2Gzld03y4nSHx0jZNbM9JgZQcBj7A=;
  b=mCPmeWBFCdnX9MVSwZShRXvheDxOESlQ7GAOVG9mrrzAr5F2cAxlusIr
   /8kRVgt5uyrS7AVwlqvmU2ryYYl4W9fACQSE0o0hlSv8spQLIu0R9GqRx
   x2gZ4ivL8hKr5uTpeXb2dsSEsFXk3vZg+CvqcrPCvHthHMVyvPairg4If
   lFwuYE+Q4g1593mQ8OZlvXj/BgV1ZuUVCKRDZ2YgJatkwTFFwzdpW1+Gg
   bJHj4OVxlhkP9Kp7fSbbZ/gutZJq80dJgZBtXvXvbdszru1z/JJJpI6SI
   iaq8QCzsyzrZTM/q74KbYkm8aCQ9J1OtgSx1tvKnID5c911tWQFGtpkAZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375473043"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="375473043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 13:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="762322058"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="762322058"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.223])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2023 13:52:11 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        pmalani@chromium.org, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 2/4] platform/chrome: cros_ec: Add Displayport Alternatemode 2.1 feature flag
Date:   Fri, 11 Aug 2023 14:07:33 -0700
Message-Id: <20230811210735.159529-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update EC command header to include feature flag for Displayport
Alternatemode 2.1 support.

This change also brings in corresponding EC header updates from the EC code
base [1].
Link: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h [1]

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 include/linux/platform_data/cros_ec_commands.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ab721cf13a98..f2b095107555 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1312,6 +1312,11 @@ enum ec_feature_code {
 	 * The EC supports the AP composing VDMs for us to send.
 	 */
 	EC_FEATURE_TYPEC_AP_VDM_SEND = 46,
+	/*
+	 * The EC supports DP2.1 capability.
+	 */
+	EC_FEATURE_TYPEC_DP2_1 = 50,
+
 };
 
 #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
-- 
2.25.1

