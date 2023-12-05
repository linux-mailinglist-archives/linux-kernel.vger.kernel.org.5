Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64336805C54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbjLERXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbjLERXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:23:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044CC0;
        Tue,  5 Dec 2023 09:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701796989; x=1733332989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4KATpD+IWkKiXOQWcr8Vf/0pe8fyQooE//hbKmJ/mB8=;
  b=mLQvYNMVm4JIFAjVUeDH3/AA1eLir0mzUigO8/3c01yK78/WHrRp+Zo8
   hvv0hPue1V58jWIhdkPVXsghwe6/Pm0M1Y96q7xfLVlU7TeNzHX6rWE4n
   RhCCu40VMR0e/HQ9DjcOhCsFb9OOjH3nYQUZach/oi1Ms5nkxAhi1m8UK
   eWgkLVHSAbN3FMYBPXCv9iEGXIY/zufa0jMawCMJ3EiDzZ1hhVLpps/1+
   cq2LEy57tlEN8Fkm5U9jCk0YECMqWemWMmJxqBAs1PepyP5BllynvePk4
   sqzClCKDwdcyCIf3XgDBM0R0RJ44+7ACu+7EKrRi+ehzc/heIpnZfQWq5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12645326"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12645326"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="720779256"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="720779256"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2023 09:23:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAZ8S-0009RM-0p;
        Tue, 05 Dec 2023 17:23:04 +0000
Date:   Wed, 6 Dec 2023 01:22:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        rppt@kernel.org, linux-security-module@vger.kernel.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: Re: [PATCH] mm: init_mlocked_on_free
Message-ID: <202312060005.VsdhiMtz-lkp@intel.com>
References: <20231202134218.151074-1-yjnworkstation@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202134218.151074-1-yjnworkstation@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi York,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4e87148f80d198ba5febcbcc969c6b9471099a09]

url:    https://github.com/intel-lab-lkp/linux/commits/York-Jasper-Niebuhr/mm-init_mlocked_on_free/20231202-214431
base:   4e87148f80d198ba5febcbcc969c6b9471099a09
patch link:    https://lore.kernel.org/r/20231202134218.151074-1-yjnworkstation%40gmail.com
patch subject: [PATCH] mm: init_mlocked_on_free
config: i386-randconfig-141-20231203 (https://download.01.org/0day-ci/archive/20231206/202312060005.VsdhiMtz-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060005.VsdhiMtz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060005.VsdhiMtz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/mlock.c:301: warning: Function parameter or member 'cofinit' not described in 'munlock_folio'


vim +301 mm/mlock.c

7225522bb429a2f Vlastimil Babka     2013-09-11  295  
2fbb0c10d1e8222 Hugh Dickins        2022-02-14  296  /**
96f97c438f61ddb Lorenzo Stoakes     2023-01-12  297   * munlock_folio - munlock a folio
96f97c438f61ddb Lorenzo Stoakes     2023-01-12  298   * @folio: folio to be munlocked, either normal or a THP head.
5b40998ae35cf64 Vlastimil Babka     2013-09-11  299   */
9cdd4fc5d036cbe York Jasper Niebuhr 2023-12-02  300  void munlock_folio(struct folio *folio, int cofinit)
2fbb0c10d1e8222 Hugh Dickins        2022-02-14 @301  {
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  302  	struct folio_batch *fbatch;
56afe477df3cbbc Vlastimil Babka     2013-09-11  303  
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  304  	local_lock(&mlock_fbatch.lock);
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  305  	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
5b40998ae35cf64 Vlastimil Babka     2013-09-11  306  	/*
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  307  	 * folio_test_clear_mlocked(folio) must be left to __munlock_folio(),
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  308  	 * which will check whether the folio is multiply mlocked.
5b40998ae35cf64 Vlastimil Babka     2013-09-11  309  	 */
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  310  	folio_get(folio);
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  311  	if (!folio_batch_add(fbatch, folio) ||
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  312  	    folio_test_large(folio) || lru_cache_disabled())
9cdd4fc5d036cbe York Jasper Niebuhr 2023-12-02  313  		mlock_folio_batch(fbatch, cofinit);
90d07210ab55e45 Lorenzo Stoakes     2023-01-12  314  	local_unlock(&mlock_fbatch.lock);
7a8010cd36273ff Vlastimil Babka     2013-09-11  315  }
56afe477df3cbbc Vlastimil Babka     2013-09-11  316  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
