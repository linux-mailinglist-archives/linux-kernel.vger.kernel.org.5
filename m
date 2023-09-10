Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF56799DA0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 12:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345058AbjIJKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjIJKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 06:18:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686BCCC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694341126; x=1725877126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OhgAhVlkb6RjiqlbvQ3YtHQ46UG3jqrwznfxCv68j14=;
  b=AKGW4JCobLDagKjWobHUzGgX+2h54A5ukrn8VWrwuDv6O8YMSzwjPT2K
   onsLrRHBGGXe1Te5249WEAbJ6GA/p5wkfw75pMiUTvFtP/ebwxi/jIR0A
   8pYBW3msL2J2GmXG+GRSlR6EprPQuCU9+XtAr0p/db4LTJU4zHHl1Araa
   zWTZ4WHeoGS5ew2BM3xfuZCxQriO91/1K6c7sFFQn7iH3QoyBVz9RUpgk
   C4cIaqAcMQKv1vVyGDKJfqUfP0cfYGTCqjQlcW8FGPwl7i8a/EzChJcTX
   q55i1aH3hxAwQSCOs8LyIaNy17F5tEhmjJkeBgJgxdUi1pLc0/rwb3SYi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376795355"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="376795355"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 03:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="772247097"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="772247097"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2023 03:18:44 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfHWc-0004mo-1t;
        Sun, 10 Sep 2023 10:18:42 +0000
Date:   Sun, 10 Sep 2023 18:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: kernel/bpf/memalloc.c:139:48: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202309101831.gKPgP4iA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
commit: 4ab67149f3c6e97c5c506a726f0ebdec38241679 bpf: Add percpu allocation support to bpf_mem_alloc.
date:   1 year ago
config: i386-randconfig-063-20230910 (https://download.01.org/0day-ci/archive/20230910/202309101831.gKPgP4iA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309101831.gKPgP4iA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309101831.gKPgP4iA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/memalloc.c:139:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *pptr @@     got void [noderef] __percpu * @@
   kernel/bpf/memalloc.c:139:48: sparse:     expected void *pptr
   kernel/bpf/memalloc.c:139:48: sparse:     got void [noderef] __percpu *
>> kernel/bpf/memalloc.c:142:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void *pptr @@
   kernel/bpf/memalloc.c:142:37: sparse:     expected void [noderef] __percpu *__pdata
   kernel/bpf/memalloc.c:142:37: sparse:     got void *pptr
>> kernel/bpf/memalloc.c:211:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void * @@
   kernel/bpf/memalloc.c:211:43: sparse:     expected void [noderef] __percpu *__pdata
   kernel/bpf/memalloc.c:211:43: sparse:     got void *

vim +139 kernel/bpf/memalloc.c

   127	
   128	static void *__alloc(struct bpf_mem_cache *c, int node)
   129	{
   130		/* Allocate, but don't deplete atomic reserves that typical
   131		 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
   132		 * will allocate from the current numa node which is what we
   133		 * want here.
   134		 */
   135		gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
   136	
   137		if (c->percpu) {
   138			void **obj = kmem_cache_alloc_node(c->kmem_cache, flags, node);
 > 139			void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
   140	
   141			if (!obj || !pptr) {
 > 142				free_percpu(pptr);
   143				kfree(obj);
   144				return NULL;
   145			}
   146			obj[1] = pptr;
   147			return obj;
   148		}
   149	
   150		if (c->kmem_cache)
   151			return kmem_cache_alloc_node(c->kmem_cache, flags, node);
   152	
   153		return kmalloc_node(c->unit_size, flags, node);
   154	}
   155	
   156	static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
   157	{
   158	#ifdef CONFIG_MEMCG_KMEM
   159		if (c->objcg)
   160			return get_mem_cgroup_from_objcg(c->objcg);
   161	#endif
   162	
   163	#ifdef CONFIG_MEMCG
   164		return root_mem_cgroup;
   165	#else
   166		return NULL;
   167	#endif
   168	}
   169	
   170	/* Mostly runs from irq_work except __init phase. */
   171	static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
   172	{
   173		struct mem_cgroup *memcg = NULL, *old_memcg;
   174		unsigned long flags;
   175		void *obj;
   176		int i;
   177	
   178		memcg = get_memcg(c);
   179		old_memcg = set_active_memcg(memcg);
   180		for (i = 0; i < cnt; i++) {
   181			obj = __alloc(c, node);
   182			if (!obj)
   183				break;
   184			if (IS_ENABLED(CONFIG_PREEMPT_RT))
   185				/* In RT irq_work runs in per-cpu kthread, so disable
   186				 * interrupts to avoid preemption and interrupts and
   187				 * reduce the chance of bpf prog executing on this cpu
   188				 * when active counter is busy.
   189				 */
   190				local_irq_save(flags);
   191			/* alloc_bulk runs from irq_work which will not preempt a bpf
   192			 * program that does unit_alloc/unit_free since IRQs are
   193			 * disabled there. There is no race to increment 'active'
   194			 * counter. It protects free_llist from corruption in case NMI
   195			 * bpf prog preempted this loop.
   196			 */
   197			WARN_ON_ONCE(local_inc_return(&c->active) != 1);
   198			__llist_add(obj, &c->free_llist);
   199			c->free_cnt++;
   200			local_dec(&c->active);
   201			if (IS_ENABLED(CONFIG_PREEMPT_RT))
   202				local_irq_restore(flags);
   203		}
   204		set_active_memcg(old_memcg);
   205		mem_cgroup_put(memcg);
   206	}
   207	
   208	static void free_one(struct bpf_mem_cache *c, void *obj)
   209	{
   210		if (c->percpu) {
 > 211			free_percpu(((void **)obj)[1]);
   212			kmem_cache_free(c->kmem_cache, obj);
   213			return;
   214		}
   215	
   216		if (c->kmem_cache)
   217			kmem_cache_free(c->kmem_cache, obj);
   218		else
   219			kfree(obj);
   220	}
   221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
