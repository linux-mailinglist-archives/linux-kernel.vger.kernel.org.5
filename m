Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88ED75D034
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjGURAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGURAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C62D56;
        Fri, 21 Jul 2023 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958818; x=1721494818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A6Q5/fuyZHuH0R3Z44L/nyNITqllFqxNyEwfzvH60Kc=;
  b=hAjfEHxR8j5aHcvrBBlZV7i90r218uLm+vPeAF2vwYqXD8dgiZhZzNj1
   W+O5asAe5I+j6aWV+7M7xdpQLja1g26rG6M8D4IW5/QGkcfhSWBdrJDal
   VDw7UJF/H9m+kggT1oJJpxGLLsAcW5XKCap0uaRQzo7o2tDC6ZnfR1nqm
   bxnYYfEOqEH08JuiNh0Ru0O/Lz2L/4o6nZI85w16steT/6bTY/ZGaCq/F
   L7egz0F28sUoqj+r8VGvWKjOP3MArxHncH/lqbKRkMIvhLH8MBAEAL57q
   sJHwIhrHMLuBJvB7a67I5hLaoMmSPScC6HGI/FE4jlen2vZgfOFPXzcp1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453443900"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="453443900"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675106515"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="675106515"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2023 10:00:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20983204; Fri, 21 Jul 2023 20:00:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/8] iio: core: A few code cleanups and documentation fixes
Date:   Fri, 21 Jul 2023 20:00:14 +0300
Message-Id: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just set of almost unrelated to each other cleanups against IIO
core implementation.

The positive LoCs diffstat due to first patch that adds a lot of
documentation for the new added macro.

v2:
- sprintf() --> sysfs_emit() (Nuno)
- added tag (Nuno)

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

