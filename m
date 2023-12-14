Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3E813871
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444010AbjLNRZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjLNRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:25:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B5CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702574736; x=1734110736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kaTx+fRMupKRmevcYCJqh+ctdAUEy0xXqaGq6nQr1so=;
  b=CudZn5wG+jFG0ssYdGAgU/hud6srFo1t9aknaxIaa1fT/S0ZDsd3gGQP
   3vJvbtA5hk4XRlqiPwlEZmq0XVYlxl7pbyukUCzj73oJjTMUCWXvHvBOD
   aYXyNyOFQnvwyfhgzUK8/BklqxDC28pkDv6hzf7t1ZOLg+rmAlxJIBajr
   eYUFwRH2h8P7bNgdA758xOfrsekuP/crlohlN3yxg5Bb2tycT3QuEX6lW
   1NTiuyj5wNJezHq3EcDwrGQDkwslLgv5D/WMbWL4Q87AfKWHTEc2HChgH
   j8VXd5szekj1jDKlfEJcZZ2gCElKjvWH3RSttV15sOVvPgUhOUztJCegX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="374662128"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="374662128"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 09:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="777963111"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="777963111"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2023 09:25:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDpSm-000MOD-0w;
        Thu, 14 Dec 2023 17:25:32 +0000
Date:   Fri, 15 Dec 2023 01:23:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/platform/chrome/wilco_ec/event.c:99: warning: Excess struct
 member 'entries' description in 'ec_event_queue'
Message-ID: <202312150101.lovwMZzT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 1aa8df90f4569acd36d2c94a9cfe1eee561575d6 platform/chrome: wilco_ec: Annotate struct ec_event_queue with __counted_by
date:   3 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231215/202312150101.lovwMZzT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150101.lovwMZzT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150101.lovwMZzT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/wilco_ec/event.c:99: warning: Excess struct member 'entries' description in 'ec_event_queue'


vim +99 drivers/platform/chrome/wilco_ec/event.c

1d333ef3d59902 Nick Crews 2019-06-24   86  
1d333ef3d59902 Nick Crews 2019-06-24   87  /**
1d333ef3d59902 Nick Crews 2019-06-24   88   * struct ec_event_queue - Circular queue for events.
1d333ef3d59902 Nick Crews 2019-06-24   89   * @capacity: Number of elements the queue can hold.
1d333ef3d59902 Nick Crews 2019-06-24   90   * @head: Next index to write to.
1d333ef3d59902 Nick Crews 2019-06-24   91   * @tail: Next index to read from.
1d333ef3d59902 Nick Crews 2019-06-24   92   * @entries: Array of events.
1d333ef3d59902 Nick Crews 2019-06-24   93   */
1d333ef3d59902 Nick Crews 2019-06-24   94  struct ec_event_queue {
1d333ef3d59902 Nick Crews 2019-06-24   95  	int capacity;
1d333ef3d59902 Nick Crews 2019-06-24   96  	int head;
1d333ef3d59902 Nick Crews 2019-06-24   97  	int tail;
1aa8df90f4569a Kees Cook  2023-09-22   98  	struct ec_event *entries[] __counted_by(capacity);
1d333ef3d59902 Nick Crews 2019-06-24  @99  };
1d333ef3d59902 Nick Crews 2019-06-24  100  

:::::: The code at line 99 was first introduced by commit
:::::: 1d333ef3d599026897fb11b4f89f9f8f30838139 platform/chrome: wilco_ec: Add circular buffer as event queue

:::::: TO: Nick Crews <ncrews@chromium.org>
:::::: CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
