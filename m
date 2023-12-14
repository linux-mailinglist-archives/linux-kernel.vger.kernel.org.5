Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D35813318
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573461AbjLNO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjLNO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:29:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC123A7;
        Thu, 14 Dec 2023 06:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702564176; x=1734100176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3yjRwJvTwe+dd+AJdN7EHilGx+zyRX1/RseVtZQirY=;
  b=fW7/P2lIhW08gUCNfKuccFfHhmW56YrDWBrzqHNuYxfFY0d5zPIBjFif
   9DkyJUvRuLSpylmBTNFozc1kn4nDKpx78CIdHKVjmg9Fo/I475B87xG1q
   jwC37u7FvLZ44tfGHH8egm3FRlH2wmSjSi4jEjmMyoifFJ3xJzsJgFtGa
   DVO+C9rtu/+kQnPUYAvogO4ltkLdEzJb51x/fhwlhGI1UcInkkDQGYvkE
   69rvXhb8uVJewSHiauh6RHFB1OB3D1Djv55LEpdpgtspbEedOQ7Q/z8L3
   Tw/MDCWBopiskm+2L3RDdYQHTByIR+OKERuZbqSRfyLRrtmJzSO9AMF/k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375281546"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="375281546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:29:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803299973"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="803299973"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2023 06:29:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDmiR-000MAi-0O;
        Thu, 14 Dec 2023 14:29:31 +0000
Date:   Thu, 14 Dec 2023 22:29:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bixuan Cui <cuibixuan@vivo.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        cuibixuan@vivo.com, opensource.kernel@vivo.com
Subject: Re: [PATCH -next 2/2] mm: vmscan: add new event to trace shrink lru
Message-ID: <202312142212.vbSe7CMs-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20231214 (https://download.01.org/0day-ci/archive/20231214/202312142212.vbSe7CMs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312142212.vbSe7CMs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312142212.vbSe7CMs-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'evict_folios':
>> mm/vmscan.c:4533:9: error: implicit declaration of function 'trace_mm_vmscan_lru_shrink_inactive'; did you mean 'trace_mm_vmscan_lru_shrink_inactive_end'? [-Werror=implicit-function-declaration]
    4533 |         trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         trace_mm_vmscan_lru_shrink_inactive_end
   cc1: some warnings being treated as errors


vim +4533 mm/vmscan.c

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
