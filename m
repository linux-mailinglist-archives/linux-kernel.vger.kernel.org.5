Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF8779C36
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjHLBMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 21:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjHLBL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 21:11:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20A30FD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691802719; x=1723338719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SrWnoBb+qWIGTiJ28WWqxHgp31YT/f0wKBw59r9UMnc=;
  b=GOSylG23NKAHWJ9alZSRXtpn3hMZDhYzOX82ncDbxjhsPQzb12ZqtEub
   i2JTWOWPWD6LDvJRJCnXgYuQByW4MXwosI6+jU0YGlHJnBl6hC5v66FjM
   VkaBhFXdLqBqU2DR69J68/LrT7RnE2cuaoJ5ga+XfxkBvQQiXvz4DY19F
   IyJoe95/ZjD/kwdmxutEm9eGFsMzIr/MxZrREK5xgG1QvI8RzArol0Y2g
   uBP833c4v+gQwQ+YkNJ/TxXMSNg05HN9Lw3Bzqk0mzloofyatdhdkFeZ8
   EfXrrcalL63h30tq0TpREtFEKGllDFejZ79Qdarh2dXSQ9hqc2sfcvBFE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="356753396"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="356753396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 18:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="798216433"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="798216433"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2023 18:11:56 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUdAZ-0008AF-39;
        Sat, 12 Aug 2023 01:11:55 +0000
Date:   Sat, 12 Aug 2023 09:11:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Cannot find symbol for section 69: .text.arch_max_swapfile_size.
Message-ID: <202308120906.Efohswpa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   190bf7b14b0cf3df19c059061be032bd8994a597
commit: be45a4902c7caa717fee6b2f671e59b396ed395c mm/swap: cache maximum swapfile size when init swap
date:   11 months ago
config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120906.Efohswpa-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120906.Efohswpa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120906.Efohswpa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Cannot find symbol for section 69: .text.arch_max_swapfile_size.
   mm/swapfile.o: failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
