Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B281371D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjLNQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjLNQ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:59:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9861114;
        Thu, 14 Dec 2023 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702573168; x=1734109168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Y4Up4+WSMEWmWEyG3tdfvhu/XtNRitIH+sxPEJRAgE=;
  b=A6G7/rOQHMNm4hvkliw598s0EIoIB8TTvGfL83eqWw5QQSvWkGO7VASa
   I3qbEWebUzbGp4YPKLbUaAVKE/Uaj5k2CdsVqQfCWinEYMK+fTvFjo1nr
   u41nxR0NCXEokL7nM0QjXanm3MsXJPLkQuuI6UZt4ZSeeHUhcUkotuWJD
   /j8YM6mU2Icbi6lIkVgTj5h8ecHQtyOdg703BEnI8wV12TSLytZtYKcSn
   muC/w8CCRPO9jmTonhZHALoTq1nOThqW1HSlJJdy6smxR/DnWESiXjkzV
   zPYfae9610kNM23ioDnOTFXhL5q9h99J2Auyyr7MsxFTTSLvK/WPqfF6m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16701429"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="16701429"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892541741"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="892541741"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2023 08:59:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDp1n-000MLq-2S;
        Thu, 14 Dec 2023 16:58:40 +0000
Date:   Fri, 15 Dec 2023 00:51:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bixuan Cui <cuibixuan@vivo.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, cuibixuan@vivo.com, opensource.kernel@vivo.com
Subject: Re: [PATCH -next 2/2] mm: vmscan: add new event to trace shrink lru
Message-ID: <202312150018.EIE4fkeF-lkp@intel.com>
References: <20231212032640.6968-3-cuibixuan@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212032640.6968-3-cuibixuan@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bixuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231211]

url:    https://github.com/intel-lab-lkp/linux/commits/Bixuan-Cui/mm-shrinker-add-new-event-to-trace-shrink-count/20231212-112824
base:   next-20231211
patch link:    https://lore.kernel.org/r/20231212032640.6968-3-cuibixuan%40vivo.com
patch subject: [PATCH -next 2/2] mm: vmscan: add new event to trace shrink lru
config: i386-randconfig-014-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150018.EIE4fkeF-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150018.EIE4fkeF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150018.EIE4fkeF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:4533:2: error: call to undeclared function 'trace_mm_vmscan_lru_shrink_inactive'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
           ^
   mm/vmscan.c:4533:2: note: did you mean 'trace_mm_vmscan_lru_shrink_inactive_end'?
   include/trace/events/vmscan.h:415:1: note: 'trace_mm_vmscan_lru_shrink_inactive_end' declared here
   TRACE_EVENT(mm_vmscan_lru_shrink_inactive_end,
   ^
   include/linux/tracepoint.h:566:2: note: expanded from macro 'TRACE_EVENT'
           DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
           ^
   include/linux/tracepoint.h:432:2: note: expanded from macro 'DECLARE_TRACE'
           __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
           ^
   include/linux/tracepoint.h:255:21: note: expanded from macro '__DECLARE_TRACE'
           static inline void trace_##name(proto)                          \
                              ^
   <scratch space>:60:1: note: expanded from here
   trace_mm_vmscan_lru_shrink_inactive_end
   ^
   1 error generated.


vim +/trace_mm_vmscan_lru_shrink_inactive +4533 mm/vmscan.c

ac35a490237446 Yu Zhao                 2022-09-18  4500  
a579086c99ed70 Yu Zhao                 2022-12-21  4501  static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
ac35a490237446 Yu Zhao                 2022-09-18  4502  {
ac35a490237446 Yu Zhao                 2022-09-18  4503  	int type;
ac35a490237446 Yu Zhao                 2022-09-18  4504  	int scanned;
ac35a490237446 Yu Zhao                 2022-09-18  4505  	int reclaimed;
ac35a490237446 Yu Zhao                 2022-09-18  4506  	LIST_HEAD(list);
359a5e1416caaf Yu Zhao                 2022-11-15  4507  	LIST_HEAD(clean);
ac35a490237446 Yu Zhao                 2022-09-18  4508  	struct folio *folio;
359a5e1416caaf Yu Zhao                 2022-11-15  4509  	struct folio *next;
ac35a490237446 Yu Zhao                 2022-09-18  4510  	enum vm_event_item item;
ac35a490237446 Yu Zhao                 2022-09-18  4511  	struct reclaim_stat stat;
bd74fdaea14602 Yu Zhao                 2022-09-18  4512  	struct lru_gen_mm_walk *walk;
359a5e1416caaf Yu Zhao                 2022-11-15  4513  	bool skip_retry = false;
ac35a490237446 Yu Zhao                 2022-09-18  4514  	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
ac35a490237446 Yu Zhao                 2022-09-18  4515  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
ac35a490237446 Yu Zhao                 2022-09-18  4516  
ac35a490237446 Yu Zhao                 2022-09-18  4517  	spin_lock_irq(&lruvec->lru_lock);
ac35a490237446 Yu Zhao                 2022-09-18  4518  
ac35a490237446 Yu Zhao                 2022-09-18  4519  	scanned = isolate_folios(lruvec, sc, swappiness, &type, &list);
ac35a490237446 Yu Zhao                 2022-09-18  4520  
ac35a490237446 Yu Zhao                 2022-09-18  4521  	scanned += try_to_inc_min_seq(lruvec, swappiness);
ac35a490237446 Yu Zhao                 2022-09-18  4522  
ac35a490237446 Yu Zhao                 2022-09-18  4523  	if (get_nr_gens(lruvec, !swappiness) == MIN_NR_GENS)
ac35a490237446 Yu Zhao                 2022-09-18  4524  		scanned = 0;
ac35a490237446 Yu Zhao                 2022-09-18  4525  
ac35a490237446 Yu Zhao                 2022-09-18  4526  	spin_unlock_irq(&lruvec->lru_lock);
ac35a490237446 Yu Zhao                 2022-09-18  4527  
ac35a490237446 Yu Zhao                 2022-09-18  4528  	if (list_empty(&list))
ac35a490237446 Yu Zhao                 2022-09-18  4529  		return scanned;
359a5e1416caaf Yu Zhao                 2022-11-15  4530  retry:
49fd9b6df54e61 Matthew Wilcox (Oracle  2022-09-02  4531) 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
359a5e1416caaf Yu Zhao                 2022-11-15  4532  	sc->nr_reclaimed += reclaimed;
8c2214fc9a470a Jaewon Kim              2023-10-03 @4533  	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
8c2214fc9a470a Jaewon Kim              2023-10-03  4534  			scanned, reclaimed, &stat, sc->priority,
8c2214fc9a470a Jaewon Kim              2023-10-03  4535  			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
359a5e1416caaf Yu Zhao                 2022-11-15  4536  
359a5e1416caaf Yu Zhao                 2022-11-15  4537  	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
359a5e1416caaf Yu Zhao                 2022-11-15  4538  		if (!folio_evictable(folio)) {
359a5e1416caaf Yu Zhao                 2022-11-15  4539  			list_del(&folio->lru);
359a5e1416caaf Yu Zhao                 2022-11-15  4540  			folio_putback_lru(folio);
359a5e1416caaf Yu Zhao                 2022-11-15  4541  			continue;
359a5e1416caaf Yu Zhao                 2022-11-15  4542  		}
ac35a490237446 Yu Zhao                 2022-09-18  4543  
359a5e1416caaf Yu Zhao                 2022-11-15  4544  		if (folio_test_reclaim(folio) &&
359a5e1416caaf Yu Zhao                 2022-11-15  4545  		    (folio_test_dirty(folio) || folio_test_writeback(folio))) {
ac35a490237446 Yu Zhao                 2022-09-18  4546  			/* restore LRU_REFS_FLAGS cleared by isolate_folio() */
ac35a490237446 Yu Zhao                 2022-09-18  4547  			if (folio_test_workingset(folio))
ac35a490237446 Yu Zhao                 2022-09-18  4548  				folio_set_referenced(folio);
359a5e1416caaf Yu Zhao                 2022-11-15  4549  			continue;
359a5e1416caaf Yu Zhao                 2022-11-15  4550  		}
ac35a490237446 Yu Zhao                 2022-09-18  4551  
359a5e1416caaf Yu Zhao                 2022-11-15  4552  		if (skip_retry || folio_test_active(folio) || folio_test_referenced(folio) ||
359a5e1416caaf Yu Zhao                 2022-11-15  4553  		    folio_mapped(folio) || folio_test_locked(folio) ||
359a5e1416caaf Yu Zhao                 2022-11-15  4554  		    folio_test_dirty(folio) || folio_test_writeback(folio)) {
359a5e1416caaf Yu Zhao                 2022-11-15  4555  			/* don't add rejected folios to the oldest generation */
359a5e1416caaf Yu Zhao                 2022-11-15  4556  			set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS,
359a5e1416caaf Yu Zhao                 2022-11-15  4557  				      BIT(PG_active));
359a5e1416caaf Yu Zhao                 2022-11-15  4558  			continue;
359a5e1416caaf Yu Zhao                 2022-11-15  4559  		}
359a5e1416caaf Yu Zhao                 2022-11-15  4560  
359a5e1416caaf Yu Zhao                 2022-11-15  4561  		/* retry folios that may have missed folio_rotate_reclaimable() */
359a5e1416caaf Yu Zhao                 2022-11-15  4562  		list_move(&folio->lru, &clean);
359a5e1416caaf Yu Zhao                 2022-11-15  4563  		sc->nr_scanned -= folio_nr_pages(folio);
ac35a490237446 Yu Zhao                 2022-09-18  4564  	}
ac35a490237446 Yu Zhao                 2022-09-18  4565  
ac35a490237446 Yu Zhao                 2022-09-18  4566  	spin_lock_irq(&lruvec->lru_lock);
ac35a490237446 Yu Zhao                 2022-09-18  4567  
49fd9b6df54e61 Matthew Wilcox (Oracle  2022-09-02  4568) 	move_folios_to_lru(lruvec, &list);
ac35a490237446 Yu Zhao                 2022-09-18  4569  
bd74fdaea14602 Yu Zhao                 2022-09-18  4570  	walk = current->reclaim_state->mm_walk;
bd74fdaea14602 Yu Zhao                 2022-09-18  4571  	if (walk && walk->batched)
bd74fdaea14602 Yu Zhao                 2022-09-18  4572  		reset_batch_size(lruvec, walk);
bd74fdaea14602 Yu Zhao                 2022-09-18  4573  
57e9cc50f4dd92 Johannes Weiner         2022-10-26  4574  	item = PGSTEAL_KSWAPD + reclaimer_offset();
ac35a490237446 Yu Zhao                 2022-09-18  4575  	if (!cgroup_reclaim(sc))
ac35a490237446 Yu Zhao                 2022-09-18  4576  		__count_vm_events(item, reclaimed);
ac35a490237446 Yu Zhao                 2022-09-18  4577  	__count_memcg_events(memcg, item, reclaimed);
ac35a490237446 Yu Zhao                 2022-09-18  4578  	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
ac35a490237446 Yu Zhao                 2022-09-18  4579  
ac35a490237446 Yu Zhao                 2022-09-18  4580  	spin_unlock_irq(&lruvec->lru_lock);
ac35a490237446 Yu Zhao                 2022-09-18  4581  
ac35a490237446 Yu Zhao                 2022-09-18  4582  	mem_cgroup_uncharge_list(&list);
ac35a490237446 Yu Zhao                 2022-09-18  4583  	free_unref_page_list(&list);
ac35a490237446 Yu Zhao                 2022-09-18  4584  
359a5e1416caaf Yu Zhao                 2022-11-15  4585  	INIT_LIST_HEAD(&list);
359a5e1416caaf Yu Zhao                 2022-11-15  4586  	list_splice_init(&clean, &list);
359a5e1416caaf Yu Zhao                 2022-11-15  4587  
359a5e1416caaf Yu Zhao                 2022-11-15  4588  	if (!list_empty(&list)) {
359a5e1416caaf Yu Zhao                 2022-11-15  4589  		skip_retry = true;
359a5e1416caaf Yu Zhao                 2022-11-15  4590  		goto retry;
359a5e1416caaf Yu Zhao                 2022-11-15  4591  	}
ac35a490237446 Yu Zhao                 2022-09-18  4592  
ac35a490237446 Yu Zhao                 2022-09-18  4593  	return scanned;
ac35a490237446 Yu Zhao                 2022-09-18  4594  }
ac35a490237446 Yu Zhao                 2022-09-18  4595  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
