Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4E79F5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjINACR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjINACQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:02:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F76E6A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694649732; x=1726185732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQ2Wi2ugdo0iZ4W59ms5KJdgxjEiXW9vRfDS42ec8iM=;
  b=TRjSGdrYGLE2SyXfUOkg2n43KK5faduQJYB1Mrjdoz5XU6HdeHy8EyYA
   bcPSrWDXDBfLCoSGQVusGGiZ0QIczmgNXIhoJPkEyo70sIEZyqsmtGoT4
   AUkALo/3kgL9wfG4PU9ms132tsLTmyVtN72yY+xzIYBpDy8nS/jJoKejD
   aX1QHVTkQ1H3YHGJUjYQGIJT3s7L2kDnj+GEHNvcf7+zIuyXorvWfjkca
   GTTDcFgEP+EmUdrfNqDw/BNV5vqNK4gEYe/FuICv6Uhs+XhfEE9Rm5jDa
   DYyLaanGplLaCWi9yZJmNgZCzVJMut1oSjPXGbBPyasdBuBakabEsh9oP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378739456"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="378739456"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 17:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="859483033"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="859483033"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2023 17:02:08 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgZo6-0000qc-1R;
        Thu, 14 Sep 2023 00:02:06 +0000
Date:   Thu, 14 Sep 2023 08:01:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, mingo@redhat.com,
        vincent.guittot@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, sshegde@linux.vnet.ibm.com,
        dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Message-ID: <202309140704.YiAtZ0yy-lkp@intel.com>
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shrikanth,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shrikanth-Hegde/sched-topology-remove-sysctl_sched_energy_aware-depending-on-the-architecture/20230913-195055
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20230913114807.665094-1-sshegde%40linux.vnet.ibm.com
patch subject: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware depending on the architecture
config: x86_64-buildonly-randconfig-003-20230914 (https://download.01.org/0day-ci/archive/20230914/202309140704.YiAtZ0yy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140704.YiAtZ0yy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140704.YiAtZ0yy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:89:
>> kernel/sched/topology.c:212:33: warning: 'sysctl_eas_header' defined but not used [-Wunused-variable]
     212 | static struct ctl_table_header *sysctl_eas_header;
         |                                 ^~~~~~~~~~~~~~~~~


vim +/sysctl_eas_header +212 kernel/sched/topology.c

   208	
   209	#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
   210	DEFINE_STATIC_KEY_FALSE(sched_energy_present);
   211	static unsigned int sysctl_sched_energy_aware;
 > 212	static struct ctl_table_header *sysctl_eas_header;
   213	static DEFINE_MUTEX(sched_energy_mutex);
   214	static bool sched_energy_update;
   215	static bool is_sysctl_eas_changing;
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
