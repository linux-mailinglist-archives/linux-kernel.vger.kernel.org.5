Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ACB81360B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjLNQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLNQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:19:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6354810A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702570784; x=1734106784;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fKwpDOHn4ZR+fc+2gCFbbiEyOiHmO+8EI3T1y0kAbFI=;
  b=HGvnJx2oJ6CAWDe/ResegtcSerCEk9RbyfWoDELqlujjAp+dhd+RHC7K
   JCzafMJEOtUcD9L+X6RODOpiXNpiGi9+e+vjQiUhBpruFiGVMcmIbR8Mq
   s88lQbEeuGlBKD72Njg98kY+596Tg1ii9Jka1e7+Ow5Eif+eDCFwL539U
   o8DWkURWulo4EcZyw9HBOSL+kA5p9mfqelDF6ZOQtT8jl5cNqcg0ob0gM
   V2fDb4qf8G+naM2GQhMaNowc+9ZthN032NGw89PQQsjw+WxNkqenfOWVl
   BxXt/t5wjET7G7NYQgvA9QgkVKONUlwvUhueQCvLYyqERD9xxTdDMojfL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380128101"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="380128101"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:19:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="777944259"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="777944259"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2023 08:19:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDoR1-000MID-1W;
        Thu, 14 Dec 2023 16:19:39 +0000
Date:   Fri, 15 Dec 2023 00:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/cpufreq/powernv-cpufreq.c:469:25: sparse: sparse: restricted
 __be64 degrades to integer
Message-ID: <202312150045.vKWdsr3O-lkp@intel.com>
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
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: cb166fa937a2fbc14badcafca86202354c34a213 cpufreq: powernv: Register for OCC related opal_message notification
date:   8 years ago
config: powerpc64-randconfig-r113-20231107 (https://download.01.org/0day-ci/archive/20231215/202312150045.vKWdsr3O-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312150045.vKWdsr3O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150045.vKWdsr3O-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/cpufreq/powernv-cpufreq.c:175:18: sparse: sparse: symbol 'cpufreq_freq_attr_cpuinfo_nominal_freq' was not declared. Should it be static?
   drivers/cpufreq/powernv-cpufreq.c:436:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] type @@     got unsigned long long @@
   drivers/cpufreq/powernv-cpufreq.c:436:19: sparse:     expected restricted __be64 [usertype] type
   drivers/cpufreq/powernv-cpufreq.c:436:19: sparse:     got unsigned long long
   drivers/cpufreq/powernv-cpufreq.c:458:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] chip @@     got unsigned long long @@
   drivers/cpufreq/powernv-cpufreq.c:458:27: sparse:     expected restricted __be64 [usertype] chip
   drivers/cpufreq/powernv-cpufreq.c:458:27: sparse:     got unsigned long long
   drivers/cpufreq/powernv-cpufreq.c:459:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] throttle_status @@     got unsigned long long @@
   drivers/cpufreq/powernv-cpufreq.c:459:38: sparse:     expected restricted __be64 [usertype] throttle_status
   drivers/cpufreq/powernv-cpufreq.c:459:38: sparse:     got unsigned long long
>> drivers/cpufreq/powernv-cpufreq.c:469:25: sparse: sparse: restricted __be64 degrades to integer
   drivers/cpufreq/powernv-cpufreq.c:470:25: sparse: sparse: cast from restricted __be64
   drivers/cpufreq/powernv-cpufreq.c:470:25: sparse: sparse: restricted __be64 degrades to integer
   drivers/cpufreq/powernv-cpufreq.c:474:25: sparse: sparse: cast from restricted __be64
   drivers/cpufreq/powernv-cpufreq.c:474:25: sparse: sparse: restricted __be64 degrades to integer
   drivers/cpufreq/powernv-cpufreq.c:438:21: sparse: sparse: restricted __be64 degrades to integer
   drivers/cpufreq/powernv-cpufreq.c:438:21: sparse: sparse: restricted __be64 degrades to integer
   In file included from include/linux/kernel.h:11,
                    from drivers/cpufreq/powernv-cpufreq.c:22:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   drivers/cpufreq/powernv-cpufreq.c: In function 'powernv_cpufreq_throttle_check':
   drivers/cpufreq/powernv-cpufreq.c:318:33: warning: comparison of integer expressions of different signedness: 'unsigned int' and 'int' [-Wsign-compare]
     318 |                 if (chips[i].id == cpu_to_chip_id(cpu))
         |                                 ^~
   In file included from include/linux/rcupdate.h:40,
                    from include/linux/idr.h:18,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from drivers/cpufreq/powernv-cpufreq.c:23:
   drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
   include/linux/cpumask.h:221:23: warning: comparison of integer expressions of different signedness: 'unsigned int' and 'int' [-Wsign-compare]
     221 |                 (cpu) < nr_cpu_ids;)
         |                       ^
   include/linux/cpumask.h:714:36: note: in expansion of macro 'for_each_cpu'
     714 | #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
         |                                    ^~~~~~~~~~~~
   drivers/cpufreq/powernv-cpufreq.c:511:9: note: in expansion of macro 'for_each_possible_cpu'
     511 |         for_each_possible_cpu(cpu) {
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/powernv-cpufreq.c:524:23: warning: comparison of integer expressions of different signedness: 'unsigned int' and 'int' [-Wsign-compare]
     524 |         for (i = 0; i < nr_chips; i++) {
         |                       ^

vim +469 drivers/cpufreq/powernv-cpufreq.c

   417	
   418	static char throttle_reason[][30] = {
   419						"No throttling",
   420						"Power Cap",
   421						"Processor Over Temperature",
   422						"Power Supply Failure",
   423						"Over Current",
   424						"OCC Reset"
   425					     };
   426	
   427	static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
   428					   unsigned long msg_type, void *_msg)
   429	{
   430		struct opal_msg *msg = _msg;
   431		struct opal_occ_msg omsg;
   432	
   433		if (msg_type != OPAL_MSG_OCC)
   434			return 0;
   435	
 > 436		omsg.type = be64_to_cpu(msg->params[0]);
   437	
   438		switch (omsg.type) {
   439		case OCC_RESET:
   440			occ_reset = true;
   441			/*
   442			 * powernv_cpufreq_throttle_check() is called in
   443			 * target() callback which can detect the throttle state
   444			 * for governors like ondemand.
   445			 * But static governors will not call target() often thus
   446			 * report throttling here.
   447			 */
   448			if (!throttled) {
   449				throttled = true;
   450				pr_crit("CPU Frequency is throttled\n");
   451			}
   452			pr_info("OCC: Reset\n");
   453			break;
   454		case OCC_LOAD:
   455			pr_info("OCC: Loaded\n");
   456			break;
   457		case OCC_THROTTLE:
   458			omsg.chip = be64_to_cpu(msg->params[1]);
   459			omsg.throttle_status = be64_to_cpu(msg->params[2]);
   460	
   461			if (occ_reset) {
   462				occ_reset = false;
   463				throttled = false;
   464				pr_info("OCC: Active\n");
   465				return 0;
   466			}
   467	
   468			if (omsg.throttle_status &&
 > 469			    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS)
   470				pr_info("OCC: Chip %u Pmax reduced due to %s\n",
   471					(unsigned int)omsg.chip,
   472					throttle_reason[omsg.throttle_status]);
   473			else if (!omsg.throttle_status)
   474				pr_info("OCC: Chip %u %s\n", (unsigned int)omsg.chip,
   475					throttle_reason[omsg.throttle_status]);
   476		}
   477		return 0;
   478	}
   479	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
