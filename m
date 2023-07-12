Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520917513D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGLW7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGLW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:59:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2CF19B;
        Wed, 12 Jul 2023 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202793; x=1720738793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QLyzwLLJT2VmUqd0W3y5LiYxPBIhNu1P+fiJzOi88LA=;
  b=itJ/yPjPRXsNtzIvfHc4Y4j3rcYfL97LTdTv8NIzLzP4k8Zj/Fx13FZ7
   wVg251HpwDbXCQC6soFKOhoDBSlMBTxgG4qBmJfZAaPUUN8Cnc2tdy+IV
   LmoPm2dy845PX9l+s+oh9fJYkXZH4tibtRtZN/hBTxKjrCNtH5GJAuLXr
   +rwAqHB/wAyPvnnj/OvncG7kzQRrqDO9kDoSxaJaKeAZ27+XwRPeH6mRY
   P52ANjBhTn3VqAh3ECyWiJNjK9X9gZmL2UZhP++u4vMKzFVB4b+35fRjw
   yp0OiVc/Sb5hIxDLXr1w1VuMafCkQGEHsnF2MmTbGlD3tnQHRJNOC9SWu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431172815"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431172815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 15:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866316691"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="866316691"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 15:59:52 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/3] TPMI control and debugfs support
Date:   Wed, 12 Jul 2023 15:59:47 -0700
Message-Id: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch provides interface to read feature status. This is
generic patch to be used by other feature drivers.

The second patch add support for debugfs. Debugfs also display
feature status using the first patch

Srinivas Pandruvada (3):
  platform/x86/intel/tpmi: Read feature control status
  platform/x86/intel/tpmi: Add debugfs interface
  doc: TPMI: Add debugfs documentation

 Documentation/ABI/testing/debugfs-tpmi |  31 ++
 MAINTAINERS                            |   1 +
 drivers/platform/x86/intel/tpmi.c      | 399 ++++++++++++++++++++++++-
 include/linux/intel_tpmi.h             |   2 +
 4 files changed, 426 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-tpmi

-- 
2.40.1

