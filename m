Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04C77E2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbjHPNgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbjHPNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:36:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC51123;
        Wed, 16 Aug 2023 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692192968; x=1723728968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X/n3jAC4OpdWfbT27/3ZLDkC3kaHfVSwAJpqmX0EKVk=;
  b=FeFjXIAm860aeMxif6eEiHD6IcQwYSgxdI9TPAA6S1hY6ww4MyFwh1qx
   TbccLKgDCg3HICqDj4VL5LofBJUtf8dTKuc1eMy+QanzFdKkGPYOeyeAg
   qymGhP+QuY+oaQKt38ZNV9s/UlivfZPK7k2VQ162JzXgwm708VcwGNK5K
   AAO1x1fGpqyavLmOWeIc0T95zunQbwRpBnYoTVENIaBf/JyNXYto7lz+2
   JmXtY36qpZXMQVdmRV2pZJXZ6VztAag9miIYnOUA+BcaqyMpBjCoHUz5l
   hWqC8V6Mf0+kcGlVanbRGQsNlWfTW7p/4YXeEnS1hTHRDbySSo3nw/HSA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372537572"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372537572"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 06:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980748911"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980748911"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 06:36:06 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id CA53F1209A1;
        Wed, 16 Aug 2023 16:36:03 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1qWGgS-00GC1Y-2n;
        Wed, 16 Aug 2023 16:35:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 0/2] Media Kconfig fixes
Date:   Wed, 16 Aug 2023 16:35:24 +0300
Message-Id: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

Hi Randy, others,

These should address the Kconfig-derived build issues you found yesterday.

Sakari Ailus (2):
  media: v4l: usb: Use correct dependency for camera sensor drivers
  media: ivsc: Add ACPI dependency

 drivers/media/pci/intel/ivsc/Kconfig | 2 +-
 drivers/media/usb/em28xx/Kconfig     | 4 ++--
 drivers/media/usb/go7007/Kconfig     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.2

