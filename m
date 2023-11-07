Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F167E3476
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjKGESK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGESH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:18:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC94ED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 20:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699330684; x=1730866684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2y3uporpF2COlT0IGH1V69g5DypnAAlqd6KpQjDUrJg=;
  b=P/XVu29+2McDOrT0V/LEyVGBXFQkvGFUSRnjWaaKVrG5ODAcg18aTQ/a
   nOdzy0C7Z6BlVangn70YRk8F3NyUumRDSgVl6ZSdgpsz3NG1xbv5MFN0O
   h8JTe4NK+0oxIx/pdJLhUlD0HS+tfdw6KEFNP65eoMh5HHG+o+qR36iv/
   kQCEUg9e1rdY/XdnolX5XLIAou6RVhJ3lixQ+CrCmSuYYekYb+Gsv8yRi
   e8LtC/d7dOQp5S7c2O5eG+DHTdXCPr2axp4FH384UGJQ8dI3S+kptVHhx
   bg9m1eHzX/a8O0z+st6VIJVfQnEDb/GT1y5wOLzIpktja75Dqq/mOqU4G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475667103"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475667103"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="797522432"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="797522432"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2023 20:18:02 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0DXL-0006va-2n;
        Tue, 07 Nov 2023 04:17:59 +0000
Date:   Tue, 7 Nov 2023 12:16:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: lib/test_objpool.c:323:3: sparse: sparse: symbol 'g_ot_sync_ops' was
 not declared. Should it be static?
Message-ID: <202311071229.WGrWUjM1-lkp@intel.com>
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
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: 92f90d3b0d5e384f218c8068138ed1b3afa025af lib: objpool test module added
date:   3 weeks ago
config: i386-randconfig-062-20231107 (https://download.01.org/0day-ci/archive/20231107/202311071229.WGrWUjM1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311071229.WGrWUjM1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311071229.WGrWUjM1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/test_objpool.c:323:3: sparse: sparse: symbol 'g_ot_sync_ops' was not declared. Should it be static?
>> lib/test_objpool.c:487:3: sparse: sparse: symbol 'g_ot_async_ops' was not declared. Should it be static?
>> lib/test_objpool.c:641:16: sparse: sparse: symbol 'g_testcases' was not declared. Should it be static?

vim +/g_ot_sync_ops +323 lib/test_objpool.c

   319	
   320	struct {
   321		struct ot_context * (*init)(struct ot_test *oc);
   322		void (*fini)(struct ot_context *sop);
 > 323	} g_ot_sync_ops[] = {
   324		{.init = ot_init_sync_m0, .fini = ot_fini_sync},
   325	};
   326	
   327	/*
   328	 * synchronous test cases: performance mode
   329	 */
   330	
   331	static void ot_bulk_sync(struct ot_item *item, int irq)
   332	{
   333		struct ot_node *nods[OT_NR_MAX_BULK];
   334		int i;
   335	
   336		for (i = 0; i < item->bulk[irq]; i++)
   337			nods[i] = objpool_pop(item->pool);
   338	
   339		if (!irq && (item->delay || !(++(item->niters) & 0x7FFF)))
   340			msleep(item->delay);
   341	
   342		while (i-- > 0) {
   343			struct ot_node *on = nods[i];
   344			if (on) {
   345				on->refs++;
   346				objpool_push(on, item->pool);
   347				item->stat[irq].nhits++;
   348			} else {
   349				item->stat[irq].nmiss++;
   350			}
   351		}
   352	}
   353	
   354	static int ot_start_sync(struct ot_test *test)
   355	{
   356		struct ot_context *sop;
   357		ktime_t start;
   358		u64 duration;
   359		unsigned long timeout;
   360		int cpu;
   361	
   362		/* initialize objpool for syncrhonous testcase */
   363		sop = g_ot_sync_ops[test->mode].init(test);
   364		if (!sop)
   365			return -ENOMEM;
   366	
   367		/* grab rwsem to block testing threads */
   368		down_write(&test->data.start);
   369	
   370		for_each_possible_cpu(cpu) {
   371			struct ot_item *item = per_cpu_ptr(&ot_pcup_items, cpu);
   372			struct task_struct *work;
   373	
   374			ot_init_cpu_item(item, test, &sop->pool, ot_bulk_sync);
   375	
   376			/* skip offline cpus */
   377			if (!cpu_online(cpu))
   378				continue;
   379	
   380			work = kthread_create_on_node(ot_thread_worker, item,
   381					cpu_to_node(cpu), "ot_worker_%d", cpu);
   382			if (IS_ERR(work)) {
   383				pr_err("failed to create thread for cpu %d\n", cpu);
   384			} else {
   385				kthread_bind(work, cpu);
   386				wake_up_process(work);
   387			}
   388		}
   389	
   390		/* wait a while to make sure all threads waiting at start line */
   391		msleep(20);
   392	
   393		/* in case no threads were created: memory insufficient ? */
   394		if (atomic_dec_and_test(&test->data.nthreads))
   395			complete(&test->data.wait);
   396	
   397		// sched_set_fifo_low(current);
   398	
   399		/* start objpool testing threads */
   400		start = ktime_get();
   401		up_write(&test->data.start);
   402	
   403		/* yeild cpu to worker threads for duration ms */
   404		timeout = msecs_to_jiffies(test->duration);
   405		schedule_timeout_interruptible(timeout);
   406	
   407		/* tell workers threads to quit */
   408		atomic_set_release(&test->data.stop, 1);
   409	
   410		/* wait all workers threads finish and quit */
   411		wait_for_completion(&test->data.wait);
   412		duration = (u64) ktime_us_delta(ktime_get(), start);
   413	
   414		/* cleanup objpool */
   415		g_ot_sync_ops[test->mode].fini(sop);
   416	
   417		/* report testing summary and performance results */
   418		ot_perf_report(test, duration);
   419	
   420		/* report memory allocation summary */
   421		ot_mem_report(test);
   422	
   423		return 0;
   424	}
   425	
   426	/*
   427	 * asynchronous test cases: pool lifecycle controlled by refcount
   428	 */
   429	
   430	static void ot_fini_async_rcu(struct rcu_head *rcu)
   431	{
   432		struct ot_context *sop = container_of(rcu, struct ot_context, rcu);
   433		struct ot_test *test = sop->test;
   434	
   435		/* here all cpus are aware of the stop event: test->data.stop = 1 */
   436		WARN_ON(!atomic_read_acquire(&test->data.stop));
   437	
   438		objpool_fini(&sop->pool);
   439		complete(&test->data.rcu);
   440	}
   441	
   442	static void ot_fini_async(struct ot_context *sop)
   443	{
   444		/* make sure the stop event is acknowledged by all cores */
   445		call_rcu(&sop->rcu, ot_fini_async_rcu);
   446	}
   447	
   448	static int ot_objpool_release(struct objpool_head *head, void *context)
   449	{
   450		struct ot_context *sop = context;
   451	
   452		WARN_ON(!head || !sop || head != &sop->pool);
   453	
   454		/* do context cleaning if needed */
   455		if (sop)
   456			ot_kfree(sop->test, sop, sizeof(*sop));
   457	
   458		return 0;
   459	}
   460	
   461	static struct ot_context *ot_init_async_m0(struct ot_test *test)
   462	{
   463		struct ot_context *sop = NULL;
   464		int max = num_possible_cpus() << 3;
   465		gfp_t gfp = GFP_KERNEL;
   466	
   467		sop = (struct ot_context *)ot_kzalloc(test, sizeof(*sop));
   468		if (!sop)
   469			return NULL;
   470		sop->test = test;
   471		if (test->objsz < 512)
   472			gfp = GFP_ATOMIC;
   473	
   474		if (objpool_init(&sop->pool, max, test->objsz, gfp, sop,
   475				 ot_init_node, ot_objpool_release)) {
   476			ot_kfree(test, sop, sizeof(*sop));
   477			return NULL;
   478		}
   479		WARN_ON(max != sop->pool.nr_objs);
   480	
   481		return sop;
   482	}
   483	
   484	struct {
   485		struct ot_context * (*init)(struct ot_test *oc);
   486		void (*fini)(struct ot_context *sop);
 > 487	} g_ot_async_ops[] = {
   488		{.init = ot_init_async_m0, .fini = ot_fini_async},
   489	};
   490	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
