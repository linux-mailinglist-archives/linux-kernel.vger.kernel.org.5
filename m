Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92B75B8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGTUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:53:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5601999;
        Thu, 20 Jul 2023 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689886400; x=1721422400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=35E7nThDIGSSNIXeazD6pctFWmLk+DF+1Ydtbzc5GvA=;
  b=BTcniBwbGk+jjLLlSVRo4ZYeAuCFHEnjhGOJXgr3MTEzJwjLQj1cKNYi
   7CGU1RDgCtqA3uiGxoAvT+gQ6GAPclDb+nrMxnTQA/eE/ztKf3/4QYa8b
   hd/9Crmt+47KQAnoPVCKIA/jNowiJnANlpinfCpOADVqdAnbp83ob2aF7
   dslrq/C0EZmBq+yvNb8k+AoVB/FfvaM/JNRM9yOiZsmGb94eRLR35hxYC
   xFp4gk2n5zW+1GQ5D/cXsTNYTrk5jWhE0AzPOqhuIVxVDpUM7ME0QWk/9
   QPEfdQ2W4CwpB47UHmJX9MZO3cEGgdA3koCApzHM3E97djg1blRBlbhgY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370459736"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="370459736"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971169129"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="971169129"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2023 13:53:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EEB98204; Thu, 20 Jul 2023 23:53:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/8] iio: core: A few code cleanups and documentation fixes
Date:   Thu, 20 Jul 2023 23:53:16 +0300
Message-Id: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Just set of almost unrelated to each other cleanups against IIO
core implementation.

The positive LoCs diffstat due to first patch that adds a lot of
documentation for the new added macro.

Andy Shevchenko (8):
  iio: core: Add opaque_struct_size() helper and use it
  iio: core: Use sysfs_match_string() helper
  iio: core: Switch to krealloc_array()
  iio: core: Use min() instead of min_t() to make code more robust
  iio: core: Get rid of redundant 'else'
  iio: core: Fix issues and style of the comments
  iio: core: Move initcalls closer to the respective calls
  iio: core: Improve indentation in a few places

 drivers/iio/industrialio-core.c | 226 ++++++++++++++++----------------
 1 file changed, 115 insertions(+), 111 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

