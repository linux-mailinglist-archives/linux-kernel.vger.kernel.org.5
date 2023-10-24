Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E886A7D5760
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343987AbjJXQHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjJXQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:07:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0377F83
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163640; x=1729699640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SxHTvq6BPePXOTB4pvdjl6aHwNbPEB47pf2wiGfYb1o=;
  b=MssigBuR5UyyazIqFLVNV3KsCNoK7agbkLyKL1Xk/0ZjhB/0bGGLYvn5
   xsHQ/CzWe5TrXaOt75kbplJ5fcMI0/gBDT4FwyFeL0uu85T+XqN9K+ZZU
   Yb8owXvCmbcxKZllOn6aqxgI7ksGubgPkN9rQhjthsxgoxivM2e6AJ3fR
   7Pv1nW3kF8UFYr3JoD0NY4HEDslIa3KSfeTdKAakUFAH/ST7EimCdK320
   vbvqf72gYwHPwA32Z7L+QaOpJmK8aeMBwLRcs/NPoa1unSLkwfhic7s41
   EXRtZOS9jxqhBV6MVumWjhUt3C/L2gwA2Y4IFiDaTIFSZN724fXQUydx7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5722825"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="5722825"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="735076664"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="735076664"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2023 09:06:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE48F195; Tue, 24 Oct 2023 19:06:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Peter Tyser <ptyser@xes-inc.com>
Subject: [PATCH v1 1/1] mfd: lpc_ich: Mark *_gpio_offsets data with const
Date:   Tue, 24 Oct 2023 19:06:50 +0300
Message-Id: <20231024160650.3898959-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why the GPIO resource offsets should not be const.
Mark them accordingly and update a qualifier in struct lpc_ich_gpio_info
definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lpc_ich.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index ea5f01e07daf..73a0e7f9bd31 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -139,7 +139,7 @@ struct lpc_ich_gpio_info {
 	size_t nr_devices;
 	struct resource **resources;
 	size_t nr_resources;
-	resource_size_t *offsets;
+	const resource_size_t *offsets;
 };
 
 #define APL_GPIO_NORTH		0
@@ -151,7 +151,7 @@ struct lpc_ich_gpio_info {
 #define APL_GPIO_NR_RESOURCES	4
 
 /* Offset data for Apollo Lake GPIO controllers */
-static resource_size_t apl_gpio_offsets[APL_GPIO_NR_RESOURCES] = {
+static const resource_size_t apl_gpio_offsets[APL_GPIO_NR_RESOURCES] = {
 	[APL_GPIO_NORTH]	= 0xc50000,
 	[APL_GPIO_NORTHWEST]	= 0xc40000,
 	[APL_GPIO_WEST]		= 0xc70000,
@@ -233,7 +233,7 @@ static const struct lpc_ich_gpio_info apl_gpio_info = {
 #define DNV_GPIO_NR_RESOURCES	2
 
 /* Offset data for Denverton GPIO controllers */
-static resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
+static const resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
 	[DNV_GPIO_NORTH]	= 0xc20000,
 	[DNV_GPIO_SOUTH]	= 0xc50000,
 };
-- 
2.40.0.1.gaa8946217a0b

