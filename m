Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E02813A25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573104AbjLNSkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444201AbjLNSkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:40:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAF10F;
        Thu, 14 Dec 2023 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702579259; x=1734115259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N7rGglN+w0R8A5Lt7lXnmbQND5j6xiAnpyeA7uoua60=;
  b=SkBHWIfftkJTGCc4AcWnBcZuTX4Ix/Gkm2KUdNTlBr7JN8c00w4cGEic
   0EFs7o6AFlo5pcGHKWqSzbX1K9/sG9G72vME+Gcv4Go0R/l3hx+KRWfCk
   lnMqGlYQBNPnp+AvTf+RRQ6v8wCeI4ACti3vVHveNXEj8K8BOKXM8esys
   vMH4jk/UiO0tOfOM+PhZp/P/xpfHd6z1TacEkqqyEIvGvRKxmO3oy/ltA
   CS98hQbo7N3G8HRLXfs/kHNIsV5QnlE+Wky51zRvhsCF2k9NOC1MsSHDL
   8878W16Ih91T1Hqxj5bxggEFl6TMYUrccKXGj1YL4NmburgVBCTN3goB8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385582270"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="385582270"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840374566"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="840374566"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2023 10:40:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0B42918E; Thu, 14 Dec 2023 20:40:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 0/4] leds: max5970: Allow to use on non-OF platforms
Date:   Thu, 14 Dec 2023 20:40:07 +0200
Message-ID: <20231214184050.1272848-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to use driver on non-OF platforms and other cleanups.

Andy Shevchenko (4):
  leds: max5970: Remove unused variable
  leds: max5970: Make use of device properties
  leds: max5970: Make use of dev_err_probe()
  leds: max5970: Add missing headers

 drivers/leds/leds-max5970.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

