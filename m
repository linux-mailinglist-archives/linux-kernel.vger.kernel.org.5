Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C398799AD0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbjIIUSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbjIIUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:18:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC2E1725
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694290669; x=1725826669;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=McbniZy+9jhoTTvcKnvSc4orX1A7o30dvUCmobJNkvI=;
  b=mqk9AgJM0B90qkXf0vMKnlnyR0Utb0CxvTz/0Vu8lasjXehm6aXJ8oRl
   8agPJGRWNNHZpJNYbAn+W5T+FKUDHPn70mh06Ga5l4jiiWXYaa7qoxRHY
   wtEDyRAqb3ddBkjIABQ71D8tdEBKQxA6/+gt+WeGe9C4WTSBuP8S/07cH
   ru+RBravV6dfABYB7dh3aMIgpvmJ/A8/hhAf4KD9pCYFcRpqR+2VlrzwU
   OnHE1pw6L2FKOwHcCurg83Y0eoOiUnLWNv69bXlaCckC8qu6VZd9/P5UO
   bMsUWJEgIPgOfFIrfgBfuu9W4P8kLwXbnnSp8Wd/0V/RWMgP0DbuxDZM0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="368108510"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="368108510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 13:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="833026074"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="833026074"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Sep 2023 13:17:46 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qf4Om-0003sd-22;
        Sat, 09 Sep 2023 20:17:44 +0000
Date:   Sun, 10 Sep 2023 04:16:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/events/intel/pt.c:674: warning: Function parameter or
 member 'cpu' not described in 'topa_insert_pages'
Message-ID: <202309100419.uLqvM7jh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a5a4326e58339a26cd1510259e7310b8c0980ff
commit: 90583af61d0c0d2826f42a297a03645b35c49085 perf/x86/intel/pt: Clean up ToPA allocation path
date:   4 years ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230910/202309100419.uLqvM7jh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309100419.uLqvM7jh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309100419.uLqvM7jh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/events/intel/pt.c:674: warning: Function parameter or member 'cpu' not described in 'topa_insert_pages'
>> arch/x86/events/intel/pt.c:1066: warning: Function parameter or member 'cpu' not described in 'pt_buffer_init_topa'
   arch/x86/events/intel/pt.c:1066: warning: Function parameter or member 'nr_pages' not described in 'pt_buffer_init_topa'
   arch/x86/events/intel/pt.c:1066: warning: Excess function parameter 'size' description in 'pt_buffer_init_topa'
   arch/x86/events/intel/pt.c:1111: warning: Function parameter or member 'event' not described in 'pt_buffer_setup_aux'
   arch/x86/events/intel/pt.c:1111: warning: Excess function parameter 'cpu' description in 'pt_buffer_setup_aux'


vim +674 arch/x86/events/intel/pt.c

52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  662  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  663  /**
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  664   * topa_insert_pages() - create a list of ToPA tables
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  665   * @buf:	PT buffer being initialized.
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  666   * @gfp:	Allocation flags.
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  667   *
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  668   * This initializes a list of ToPA tables with entries from
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  669   * the data_pages provided by rb_alloc_aux().
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  670   *
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  671   * Return:	0 on success or error code.
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  672   */
90583af61d0c0d arch/x86/events/intel/pt.c                Alexander Shishkin 2019-08-21  673  static int topa_insert_pages(struct pt_buffer *buf, int cpu, gfp_t gfp)
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30 @674  {
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  675  	struct topa *topa = buf->last;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  676  	int order = 0;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  677  	struct page *p;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  678  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  679  	p = virt_to_page(buf->data_pages[buf->nr_pages]);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  680  	if (PagePrivate(p))
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  681  		order = page_private(p);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  682  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  683  	if (topa_table_full(topa)) {
90583af61d0c0d arch/x86/events/intel/pt.c                Alexander Shishkin 2019-08-21  684  		topa = topa_alloc(cpu, gfp);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  685  		if (!topa)
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  686  			return -ENOMEM;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  687  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  688  		topa_insert_table(buf, topa);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  689  	}
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  690  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  691  	TOPA_ENTRY(topa, -1)->base = page_to_phys(p) >> TOPA_SHIFT;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  692  	TOPA_ENTRY(topa, -1)->size = order;
f6d079ce867d67 arch/x86/events/intel/pt.c                Chao Peng          2018-10-24  693  	if (!buf->snapshot &&
f6d079ce867d67 arch/x86/events/intel/pt.c                Chao Peng          2018-10-24  694  	    !intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  695  		TOPA_ENTRY(topa, -1)->intr = 1;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  696  		TOPA_ENTRY(topa, -1)->stop = 1;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  697  	}
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  698  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  699  	topa->last++;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  700  	topa->size += sizes(order);
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  701  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  702  	buf->nr_pages += 1ul << order;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  703  
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  704  	return 0;
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  705  }
52ca9ced3f7077 arch/x86/kernel/cpu/perf_event_intel_pt.c Alexander Shishkin 2015-01-30  706  

:::::: The code at line 674 was first introduced by commit
:::::: 52ca9ced3f70779589e6ecc329baffe69d8f5f7a perf/x86/intel/pt: Add Intel PT PMU driver

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
