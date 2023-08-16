Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A582877E996
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345795AbjHPTXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345804AbjHPTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:22:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E39B2712
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692213772; x=1723749772;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Iv6QZBIbhxj44UQ62C/0AXoYZJkHk30v8xyUSzkx2uM=;
  b=bvhWd74tu6X2ASBQQTTlEli2K8RE0lK9DW9T9lyd6gA87RPa+ehrh98K
   CCkSMn5UuI3er3RS7uy9sqIJ86MBp2lXcoOMwCDCI6skDLpqzbljvjvPv
   1EJts65gvSgwy7jcAR8vWxrRq7j9BLNF9Bvi/1BS7Cp4MN8WAbbilNf+J
   j95aV351TB6s5UEoopTjTiSrWa+COXSy4GIfZoJormbRXcFQRy1fyB4wq
   Ds5D8/YPtdGjOYK2/uwLTUIwxDfDdoTgxU70wFW7CT2W8AWlYBVyJo0UU
   pK2krEdQhO5OuvHUQ0XpXB9ZSpYTM/c2MPt59HK4KzuoF0ABsWROVOc0/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372621203"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372621203"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 12:22:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980839667"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980839667"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 12:22:50 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWM6T-0000Vf-1b;
        Wed, 16 Aug 2023 19:22:49 +0000
Date:   Thu, 17 Aug 2023 03:21:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/cpumask.c:394:17: warning: no previous declaration for
 'bpf_cpumask_any_distribute'
Message-ID: <202308170344.p09ggdhY-lkp@intel.com>
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
commit: f983be917332ea5e03f689e12c6668be48cb4cfe bpf: Replace bpf_cpumask_any* with bpf_cpumask_any_distribute*
date:   9 weeks ago
config: x86_64-randconfig-x076-20230816 (https://download.01.org/0day-ci/archive/20230817/202308170344.p09ggdhY-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170344.p09ggdhY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170344.p09ggdhY-lkp@intel.com/

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
   kernel/bpf/cpumask.c:143:17: warning: no previous declaration for 'bpf_cpumask_first_and' [-Wmissing-declarations]
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
>> kernel/bpf/cpumask.c:394:17: warning: no previous declaration for 'bpf_cpumask_any_distribute' [-Wmissing-declarations]
    __bpf_kfunc u32 bpf_cpumask_any_distribute(const struct cpumask *cpumask)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:412:17: warning: no previous declaration for 'bpf_cpumask_any_and_distribute' [-Wmissing-declarations]
    __bpf_kfunc u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_cpumask_any_distribute +394 kernel/bpf/cpumask.c

   383	
   384	/**
   385	 * bpf_cpumask_any_distribute() - Return a random set CPU from a cpumask.
   386	 * @cpumask: The cpumask being queried.
   387	 *
   388	 * Return:
   389	 * * A random set bit within [0, num_cpus) if at least one bit is set.
   390	 * * >= num_cpus if no bit is set.
   391	 *
   392	 * A struct bpf_cpumask pointer may be safely passed to @src.
   393	 */
 > 394	__bpf_kfunc u32 bpf_cpumask_any_distribute(const struct cpumask *cpumask)
   395	{
   396		return cpumask_any_distribute(cpumask);
   397	}
   398	
   399	/**
   400	 * bpf_cpumask_any_and_distribute() - Return a random set CPU from the AND of
   401	 *				      two cpumasks.
   402	 * @src1: The first cpumask.
   403	 * @src2: The second cpumask.
   404	 *
   405	 * Return:
   406	 * * A random set bit within [0, num_cpus) from the AND of two cpumasks, if at
   407	 *   least one bit is set.
   408	 * * >= num_cpus if no bit is set.
   409	 *
   410	 * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
   411	 */
 > 412	__bpf_kfunc u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
   413						       const struct cpumask *src2)
   414	{
   415		return cpumask_any_and_distribute(src1, src2);
   416	}
   417	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
