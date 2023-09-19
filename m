Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410CA7A6BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjISTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:50:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E9C9C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695153052; x=1726689052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ypp/1Yy4wVk9ciRNPy90YR5pm63YZxulHQvF7iar87A=;
  b=YKkDvn5J5VAH/Taabh3xITq0c55XP5asMbRjb0AlFbMWzN18rH5tLSPX
   0MGrMB5bKr7dnReQyP62eC4lxLCfAroNNEUL/kJyJkLd2M5vqVLv1laX2
   nw2hEIHAHX5TRLsYPyxdtJZrx8rpicEpNSDvQOdgreZH2FzJ/BsqI2KF+
   fVXkzoirEA7tMyXcFmXLNwxrvyn3OU14PDocNJyXthP3pQ2me8EM6zvti
   YopI62bQbZEy87C5YhsdTekwevjsvQnWo1EdadVdhGfadrEVzrv9TtSrm
   r1HtCl9M3fnG4zpw/zeefFCM+NC46O5nrleTgObgKCN8iYqUXUUFNk1Bo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="377344580"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="377344580"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="993286149"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="993286149"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2023 12:50:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3471D45B; Tue, 19 Sep 2023 22:50:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: Add missing parameter description to __fwnode_link_add()
Date:   Tue, 19 Sep 2023 22:50:48 +0300
Message-Id: <20230919195048.3197551-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel documentation validator is not happy with:

  drivers/base/core.c:67: warning: Function parameter or member 'flags' not described in '__fwnode_link_add'

Add missing parameter description.

Fixes: 6a6dfdf8b3ff ("driver core: fw_devlink: Allow marking a fwnode link as being part of a cycle")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..67ba592afc77 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -49,6 +49,7 @@ static bool fw_devlink_best_effort;
  * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
  * @sup: Supplier end of the link.
+ * @flags: Link flags.
  *
  * Create a fwnode link between fwnode handles @con and @sup. The fwnode link
  * represents the detail that the firmware lists @sup fwnode as supplying a
-- 
2.40.0.1.gaa8946217a0b

