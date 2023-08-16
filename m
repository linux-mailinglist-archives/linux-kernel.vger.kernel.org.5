Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78F77E68B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344647AbjHPQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbjHPQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:36:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A752D4A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692203767; x=1723739767;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rIt8zenoWw2QEeA0kG1EPfPfC0annkeZhTqZv3yJynw=;
  b=SJ6WGlIQW+tDfse6dlaHC+bulYbrntHBQLhfKy37dHZR/XAqtVCOXwlF
   HtABqxpExR/ci4DKlOs9l/c+OUz8ewni3kvj1v8tMPQ8LNc6ub8o/b2xl
   4ztjx+mostoYKWXP37ZlAm/AE8+PlieG2TBGflSIGyo1G7vjg7OlBTSup
   PU2at2JZbXMz1/8Sz/7vTNJWq4RDPNQfo6isL4PUN+MgmKF2toNJ435eZ
   gWxYY/8No7T+xfwwq5vNgQ+KIkt1weXGJJnQSWD355iKz9IvMyH3VADY6
   RQj1W+2MWudSvyVvHCkFbGJi2JANtX3SFYSClhOXNO1DPmEaXWz3Zkyxm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436480203"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="436480203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 09:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799678272"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="799678272"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2023 09:36:04 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWJV5-0000RN-35;
        Wed, 16 Aug 2023 16:36:03 +0000
Date:   Thu, 17 Aug 2023 00:35:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/cpumask.c:143:17: warning: no previous declaration for
 'bpf_cpumask_first_and'
Message-ID: <202308170002.DfQzgaVh-lkp@intel.com>
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
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 5ba3a7a851e3ebffc4cb8f052a4581c4d8af3ae3 bpf: Add bpf_cpumask_first_and() kfunc
date:   9 weeks ago
config: x86_64-randconfig-x076-20230816 (https://download.01.org/0day-ci/archive/20230817/202308170002.DfQzgaVh-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170002.DfQzgaVh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170002.DfQzgaVh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/cpumask.c:53:33: warning: no previous declaration for 'bpf_cpumask_create' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
                                    ^~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:79:33: warning: no previous declaration for 'bpf_cpumask_acquire' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
                                    ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:103:18: warning: no previous declaration for 'bpf_cpumask_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:116:17: warning: no previous declaration for 'bpf_cpumask_first' [-Wmissing-declarations]
    __bpf_kfunc u32 bpf_cpumask_first(const struct cpumask *cpumask)
                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:129:17: warning: no previous declaration for 'bpf_cpumask_first_zero' [-Wmissing-declarations]
    __bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
                    ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:143:17: warning: no previous declaration for 'bpf_cpumask_first_and' [-Wmissing-declarations]
    __bpf_kfunc u32 bpf_cpumask_first_and(const struct cpumask *src1,
                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:154:18: warning: no previous declaration for 'bpf_cpumask_set_cpu' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:167:18: warning: no previous declaration for 'bpf_cpumask_clear_cpu' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:184:18: warning: no previous declaration for 'bpf_cpumask_test_cpu' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:201:18: warning: no previous declaration for 'bpf_cpumask_test_and_set_cpu' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:219:18: warning: no previous declaration for 'bpf_cpumask_test_and_clear_cpu' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:231:18: warning: no previous declaration for 'bpf_cpumask_setall' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:240:18: warning: no previous declaration for 'bpf_cpumask_clear' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:257:18: warning: no previous declaration for 'bpf_cpumask_and' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_and(struct bpf_cpumask *dst,
                     ^~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:272:18: warning: no previous declaration for 'bpf_cpumask_or' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_or(struct bpf_cpumask *dst,
                     ^~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:287:18: warning: no previous declaration for 'bpf_cpumask_xor' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_xor(struct bpf_cpumask *dst,
                     ^~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:305:18: warning: no previous declaration for 'bpf_cpumask_equal' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:321:18: warning: no previous declaration for 'bpf_cpumask_intersects' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
                     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:337:18: warning: no previous declaration for 'bpf_cpumask_subset' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:352:18: warning: no previous declaration for 'bpf_cpumask_empty' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_empty(const struct cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:367:18: warning: no previous declaration for 'bpf_cpumask_full' [-Wmissing-declarations]
    __bpf_kfunc bool bpf_cpumask_full(const struct cpumask *cpumask)
                     ^~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:379:18: warning: no previous declaration for 'bpf_cpumask_copy' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
                     ^~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:394:17: warning: no previous declaration for 'bpf_cpumask_any' [-Wmissing-declarations]
    __bpf_kfunc u32 bpf_cpumask_any(const struct cpumask *cpumask)
                    ^~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:411:17: warning: no previous declaration for 'bpf_cpumask_any_and' [-Wmissing-declarations]
    __bpf_kfunc u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
                    ^~~~~~~~~~~~~~~~~~~


vim +/bpf_cpumask_first_and +143 kernel/bpf/cpumask.c

    94	
    95	/**
    96	 * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
    97	 * @cpumask: The cpumask being released.
    98	 *
    99	 * Releases a previously acquired reference to a BPF cpumask. When the final
   100	 * reference of the BPF cpumask has been released, it is subsequently freed in
   101	 * an RCU callback in the BPF memory allocator.
   102	 */
 > 103	__bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
   104	{
   105		if (refcount_dec_and_test(&cpumask->usage))
   106			call_rcu(&cpumask->rcu, cpumask_free_cb);
   107	}
   108	
   109	/**
   110	 * bpf_cpumask_first() - Get the index of the first nonzero bit in the cpumask.
   111	 * @cpumask: The cpumask being queried.
   112	 *
   113	 * Find the index of the first nonzero bit of the cpumask. A struct bpf_cpumask
   114	 * pointer may be safely passed to this function.
   115	 */
   116	__bpf_kfunc u32 bpf_cpumask_first(const struct cpumask *cpumask)
   117	{
   118		return cpumask_first(cpumask);
   119	}
   120	
   121	/**
   122	 * bpf_cpumask_first_zero() - Get the index of the first unset bit in the
   123	 *			      cpumask.
   124	 * @cpumask: The cpumask being queried.
   125	 *
   126	 * Find the index of the first unset bit of the cpumask. A struct bpf_cpumask
   127	 * pointer may be safely passed to this function.
   128	 */
   129	__bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
   130	{
   131		return cpumask_first_zero(cpumask);
   132	}
   133	
   134	/**
   135	 * bpf_cpumask_first_and() - Return the index of the first nonzero bit from the
   136	 *			     AND of two cpumasks.
   137	 * @src1: The first cpumask.
   138	 * @src2: The second cpumask.
   139	 *
   140	 * Find the index of the first nonzero bit of the AND of two cpumasks.
   141	 * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
   142	 */
 > 143	__bpf_kfunc u32 bpf_cpumask_first_and(const struct cpumask *src1,
   144					      const struct cpumask *src2)
   145	{
   146		return cpumask_first_and(src1, src2);
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
