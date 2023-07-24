Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499B75F427
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjGXLC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjGXLCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:02:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ADC10D;
        Mon, 24 Jul 2023 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196531; x=1721732531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kkODxllV7uZBSVmeDteRdj8Ujh49N2E27/GxuPVwAgQ=;
  b=ddzj5AxV2aqbjPxc8SgElu+y3MtLml5iy3h3/fsSLnl72smpFm3foOeK
   WT7kFMpPqDr5l2xR8a3R/TBGIjzo8+/g2tD9Pbl/eMxqkPcfoP7NrL+2f
   gDHGyvYDtqg1WIxk48uB75x6FBHR6i5dLey3gHsFSmwANBkYC5fcd2DYy
   2rn523r0lnRZjMcSHtipP8xDHft/8nr5IxKs+Hp3O5JV4Og1bhQS/Tp8u
   7F5b55WivmKPIkIk2wp8ovZxf6cebctJIdqdWq6H0wVWEMRrseqL8CQmr
   N4Ps3K428y+ceDWG1Vvc6X+MV0BRiL9JAY8PrmACcZdPj72FoXaIGXIlu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="371009918"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="371009918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869036287"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2023 04:01:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B183C1A6; Mon, 24 Jul 2023 14:02:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 0/4] iio: core: A few code cleanups and documentation fixes
Date:   Mon, 24 Jul 2023 14:02:00 +0300
Message-Id: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just set of almost unrelated to each other cleanups against IIO
core implementation.

The positive LoCs diffstat due to first patch that adds a lot of
documentation for the newly added macro and existing kernel doc.

v3:
- dropped applied patches
- use switch-case for the supported clocks (Jonathan)
- redone opaque_struct_size() to be simpler (Uwe)
- dropped wrong hunk for krealloc_array() conversion (Jonathan)
- dropped initcall move (Jonathan)

v2:
- sprintf() --> sysfs_emit() (Nuno)
- added tag (Nuno)

Andy Shevchenko (4):
  iio: core: Use sysfs_match_string() helper
  iio: core: Add opaque_struct_size() helper and use it
  iio: core: Switch to krealloc_array()
  iio: core: Fix issues and style of the comments

 drivers/iio/industrialio-core.c | 158 ++++++++++++++++++--------------
 1 file changed, 90 insertions(+), 68 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

