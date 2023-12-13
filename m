Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B579810FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377264AbjLMLXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjLMLXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:23:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE839B2;
        Wed, 13 Dec 2023 03:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702466591; x=1734002591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vG05tOcWt8hNkb/0MfvDKdSwDkxJN+d9TF+RoFO0kI=;
  b=T/ocUh/leKYo2oyLn+Mo20tfV37e76tTsRtvMumf8G22yxVdlQP8AatP
   8NM9IKGt4U6Fu6559IEwHrhTUrM/jvWEQ1NJDS1I9AEjGYLzWYCEvbtew
   PP+xb4/aN5af7wH9fsfmZV0Bpi+i58FhRtBD3Pf19+250Zb+96/5LwM8P
   463IotjCD9jlnX5Hos1J8BE3YYc+pjWPQXj+PYycxAE8vQCTUit0yWy9n
   NL81+M9+Ze79gi4RWCU1Jf2yJtvrcJktjPPrApwwSnclsE8cpPgrQJ8u/
   /hAE4ANv0lOw/nN1zehRDo0AX6mxn7jbx89WKEJNUMu9rBGyZZqWaNdNB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="398793300"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="398793300"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864592315"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="864592315"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2023 03:23:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDNKP-000KTd-1U;
        Wed, 13 Dec 2023 11:23:01 +0000
Date:   Wed, 13 Dec 2023 19:22:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/15] tracing: Introduce names for ring buffers
Message-ID: <202312131922.5dJORQu4-lkp@intel.com>
References: <20231213000452.88295-9-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-9-graf@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on arm64/for-next/core akpm-mm/mm-everything linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20231213-080941
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231213000452.88295-9-graf%40amazon.com
patch subject: [PATCH 08/15] tracing: Introduce names for ring buffers
config: i386-buildonly-randconfig-003-20231213 (https://download.01.org/0day-ci/archive/20231213/202312131922.5dJORQu4-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131922.5dJORQu4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131922.5dJORQu4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/ring_buffer_benchmark.c:435:53: error: too few arguments provided to function-like macro invocation
           buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
                                                              ^
   include/linux/ring_buffer.h:96:9: note: macro 'ring_buffer_alloc' defined here
   #define ring_buffer_alloc(name, size, flags)                    \
           ^
>> kernel/trace/ring_buffer_benchmark.c:435:11: error: use of undeclared identifier 'ring_buffer_alloc'; did you mean '__ring_buffer_alloc'?
           buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
                    ^~~~~~~~~~~~~~~~~
                    __ring_buffer_alloc
   include/linux/ring_buffer.h:88:1: note: '__ring_buffer_alloc' declared here
   __ring_buffer_alloc(const char *name, unsigned long size, unsigned flags,
   ^
   2 errors generated.
--
>> kernel/trace/ring_buffer.c:6096:65: error: too few arguments provided to function-like macro invocation
           buffer = ring_buffer_alloc(RB_TEST_BUFFER_SIZE, RB_FL_OVERWRITE);
                                                                          ^
   include/linux/ring_buffer.h:96:9: note: macro 'ring_buffer_alloc' defined here
   #define ring_buffer_alloc(name, size, flags)                    \
           ^
>> kernel/trace/ring_buffer.c:6096:11: error: use of undeclared identifier 'ring_buffer_alloc'; did you mean '__ring_buffer_alloc'?
           buffer = ring_buffer_alloc(RB_TEST_BUFFER_SIZE, RB_FL_OVERWRITE);
                    ^~~~~~~~~~~~~~~~~
                    __ring_buffer_alloc
   kernel/trace/ring_buffer.c:1873:19: note: '__ring_buffer_alloc' declared here
   EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
                     ^
   2 errors generated.


vim +435 kernel/trace/ring_buffer_benchmark.c

5092dbc96f3acd Steven Rostedt 2009-05-05  429  
5092dbc96f3acd Steven Rostedt 2009-05-05  430  static int __init ring_buffer_benchmark_init(void)
5092dbc96f3acd Steven Rostedt 2009-05-05  431  {
5092dbc96f3acd Steven Rostedt 2009-05-05  432  	int ret;
5092dbc96f3acd Steven Rostedt 2009-05-05  433  
5092dbc96f3acd Steven Rostedt 2009-05-05  434  	/* make a one meg buffer in overwite mode */
5092dbc96f3acd Steven Rostedt 2009-05-05 @435  	buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
5092dbc96f3acd Steven Rostedt 2009-05-05  436  	if (!buffer)
5092dbc96f3acd Steven Rostedt 2009-05-05  437  		return -ENOMEM;
5092dbc96f3acd Steven Rostedt 2009-05-05  438  
5092dbc96f3acd Steven Rostedt 2009-05-05  439  	if (!disable_reader) {
5092dbc96f3acd Steven Rostedt 2009-05-05  440  		consumer = kthread_create(ring_buffer_consumer_thread,
5092dbc96f3acd Steven Rostedt 2009-05-05  441  					  NULL, "rb_consumer");
5092dbc96f3acd Steven Rostedt 2009-05-05  442  		ret = PTR_ERR(consumer);
5092dbc96f3acd Steven Rostedt 2009-05-05  443  		if (IS_ERR(consumer))
5092dbc96f3acd Steven Rostedt 2009-05-05  444  			goto out_fail;
5092dbc96f3acd Steven Rostedt 2009-05-05  445  	}
5092dbc96f3acd Steven Rostedt 2009-05-05  446  
5092dbc96f3acd Steven Rostedt 2009-05-05  447  	producer = kthread_run(ring_buffer_producer_thread,
5092dbc96f3acd Steven Rostedt 2009-05-05  448  			       NULL, "rb_producer");
5092dbc96f3acd Steven Rostedt 2009-05-05  449  	ret = PTR_ERR(producer);
5092dbc96f3acd Steven Rostedt 2009-05-05  450  
5092dbc96f3acd Steven Rostedt 2009-05-05  451  	if (IS_ERR(producer))
5092dbc96f3acd Steven Rostedt 2009-05-05  452  		goto out_kill;
5092dbc96f3acd Steven Rostedt 2009-05-05  453  
98e4833ba3c314 Ingo Molnar    2009-11-23  454  	/*
98e4833ba3c314 Ingo Molnar    2009-11-23  455  	 * Run them as low-prio background tasks by default:
98e4833ba3c314 Ingo Molnar    2009-11-23  456  	 */
7ac07434048001 Steven Rostedt 2009-11-25  457  	if (!disable_reader) {
4fd5750af02ab7 Peter Zijlstra 2020-07-20  458  		if (consumer_fifo >= 2)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  459  			sched_set_fifo(consumer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  460  		else if (consumer_fifo == 1)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  461  			sched_set_fifo_low(consumer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  462  		else
7ac07434048001 Steven Rostedt 2009-11-25  463  			set_user_nice(consumer, consumer_nice);
7ac07434048001 Steven Rostedt 2009-11-25  464  	}
7ac07434048001 Steven Rostedt 2009-11-25  465  
4fd5750af02ab7 Peter Zijlstra 2020-07-20  466  	if (producer_fifo >= 2)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  467  		sched_set_fifo(producer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  468  	else if (producer_fifo == 1)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  469  		sched_set_fifo_low(producer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  470  	else
7ac07434048001 Steven Rostedt 2009-11-25  471  		set_user_nice(producer, producer_nice);
98e4833ba3c314 Ingo Molnar    2009-11-23  472  
5092dbc96f3acd Steven Rostedt 2009-05-05  473  	return 0;
5092dbc96f3acd Steven Rostedt 2009-05-05  474  
5092dbc96f3acd Steven Rostedt 2009-05-05  475   out_kill:
5092dbc96f3acd Steven Rostedt 2009-05-05  476  	if (consumer)
5092dbc96f3acd Steven Rostedt 2009-05-05  477  		kthread_stop(consumer);
5092dbc96f3acd Steven Rostedt 2009-05-05  478  
5092dbc96f3acd Steven Rostedt 2009-05-05  479   out_fail:
5092dbc96f3acd Steven Rostedt 2009-05-05  480  	ring_buffer_free(buffer);
5092dbc96f3acd Steven Rostedt 2009-05-05  481  	return ret;
5092dbc96f3acd Steven Rostedt 2009-05-05  482  }
5092dbc96f3acd Steven Rostedt 2009-05-05  483  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
