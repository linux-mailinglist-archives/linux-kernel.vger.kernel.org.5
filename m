Return-Path: <linux-kernel+bounces-16809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0F824436
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE39B1F24694
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409F2375D;
	Thu,  4 Jan 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYTezPHE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E122375C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704380103; x=1735916103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sQdXiblKbLhQtwIgo5bne0wGbDg93OesfVhpvV65emE=;
  b=hYTezPHEbBUmDhO3ENu88P+nz2h+ByEtgs6Yyw6NUBqtMJTkANtCLDsU
   sxucRYadwCeLs8TXJWxlsN+cHRBhphXf2ztshDrO07hEb6j3yrgQBWPl5
   QaxKPjpV/eXDCghAC+I643C+VZHxLNVJGrYOgVP/BaU5dJdIPeVMN97M+
   LbwrXAlkxJt7gYKW4PqPKDLStyqKxH19XwFt/QaSZ3q1AzVtw2CHhfoD5
   YNnjzDz9NltgQmcRE3YTfy+Ke2GUhcufI9VRtXkjbreND4q7Opt8/S587
   1fuVRBew8z/Y9G6WvmRChDpqifml4oorwYFA2vlRlTV1GBPCT5EXWWgyt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4623682"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4623682"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 06:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="28813347"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Jan 2024 06:54:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLP7W-000NPw-07;
	Thu, 04 Jan 2024 14:54:54 +0000
Date: Thu, 4 Jan 2024 22:54:30 +0800
From: kernel test robot <lkp@intel.com>
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 1/2] sched/topology: Annotate RCU pointers properly
Message-ID: <202401042241.EQntOcPK-lkp@intel.com>
References: <20240103125648.194516-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103125648.194516-2-pierre.gondois@arm.com>

Hi Pierre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/master peterz-queue/sched/core tip/auto-latest linus/master v6.7-rc8 next-20240104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pierre-Gondois/sched-topology-Annotate-RCU-pointers-properly/20240103-210154
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240103125648.194516-2-pierre.gondois%40arm.com
patch subject: [PATCH 1/2] sched/topology: Annotate RCU pointers properly
config: arm64-randconfig-r111-20240104 (https://download.01.org/0day-ci/archive/20240104/202401042241.EQntOcPK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240104/202401042241.EQntOcPK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401042241.EQntOcPK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:485:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct perf_domain *pd @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:485:19: sparse:     expected struct perf_domain *pd
   kernel/sched/topology.c:485:19: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:647:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:647:49: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:647:49: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:732:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:732:50: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:732:50: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:740:55: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child @@     got struct sched_domain *[assigned] tmp @@
   kernel/sched/topology.c:740:55: sparse:     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child
   kernel/sched/topology.c:740:55: sparse:     got struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:753:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:753:29: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:753:29: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:758:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:758:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:758:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:779:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *sd @@
   kernel/sched/topology.c:779:13: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:779:13: sparse:     got struct sched_domain [noderef] __rcu *sd
   kernel/sched/topology.c:941:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:941:70: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:941:70: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:970:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:970:59: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:970:59: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1016:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1016:57: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1016:57: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1018:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1018:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:1018:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1026:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1026:55: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1026:55: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1028:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1028:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:1028:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1098:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1098:62: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1098:62: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1202:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1202:40: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:1202:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1622:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain [noderef] __rcu *child @@     got struct sched_domain *child @@
   kernel/sched/topology.c:1622:43: sparse:     expected struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1622:43: sparse:     got struct sched_domain *child
>> kernel/sched/topology.c:1998:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int *distances @@     got int [noderef] __rcu *static [addressable] [assigned] [toplevel] sched_domains_numa_distance @@
   kernel/sched/topology.c:1998:19: sparse:     expected int *distances
   kernel/sched/topology.c:1998:19: sparse:     got int [noderef] __rcu *static [addressable] [assigned] [toplevel] sched_domains_numa_distance
>> kernel/sched/topology.c:2000:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpumask ***masks @@     got struct cpumask **[noderef] __rcu *static [addressable] [assigned] [toplevel] sched_domains_numa_masks @@
   kernel/sched/topology.c:2000:15: sparse:     expected struct cpumask ***masks
   kernel/sched/topology.c:2000:15: sparse:     got struct cpumask **[noderef] __rcu *static [addressable] [assigned] [toplevel] sched_domains_numa_masks
   kernel/sched/topology.c:2321:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *parent @@     got struct sched_domain *sd @@
   kernel/sched/topology.c:2321:31: sparse:     expected struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2321:31: sparse:     got struct sched_domain *sd
   kernel/sched/topology.c:2425:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2425:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2425:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2446:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:2446:56: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:2446:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:2445:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2445:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2445:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2500:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2500:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2500:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file (through include/linux/smp.h, include/linux/sched/clock.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:1846:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1846:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1846:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1867:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1867:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1867:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1867:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1867:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1867:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1846:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1846:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1846:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1867:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1867:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1867:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:741:39: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:971:31: sparse: sparse: dereference of noderef expression
   kernel/sched/build_utility.c: note: in included file (through include/linux/smp.h, include/linux/sched/clock.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:1643:19: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1658:48: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1723:40: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1934:86: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1983:9: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2053:82: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2054:78: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2054:78: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2065:53: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2066:80: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2066:80: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2483:51: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2484:49: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2486:52: sparse: sparse: dereference of noderef expression
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:1867:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1867:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1867:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/core_sched.c:94:23: sparse: sparse: context imbalance in 'sched_core_update_cookie' - wrong count at exit

vim +1998 kernel/sched/topology.c

0083242c93759d Valentin Schneider 2021-08-18  1987  
0083242c93759d Valentin Schneider 2021-08-18  1988  
0fb3978b0aac3a Huang Ying         2022-02-14  1989  static void sched_reset_numa(void)
0fb3978b0aac3a Huang Ying         2022-02-14  1990  {
0fb3978b0aac3a Huang Ying         2022-02-14  1991  	int nr_levels, *distances;
0fb3978b0aac3a Huang Ying         2022-02-14  1992  	struct cpumask ***masks;
0083242c93759d Valentin Schneider 2021-08-18  1993  
0fb3978b0aac3a Huang Ying         2022-02-14  1994  	nr_levels = sched_domains_numa_levels;
0fb3978b0aac3a Huang Ying         2022-02-14  1995  	sched_domains_numa_levels = 0;
0fb3978b0aac3a Huang Ying         2022-02-14  1996  	sched_max_numa_distance = 0;
0fb3978b0aac3a Huang Ying         2022-02-14  1997  	sched_numa_topology_type = NUMA_DIRECT;
0fb3978b0aac3a Huang Ying         2022-02-14 @1998  	distances = sched_domains_numa_distance;
0fb3978b0aac3a Huang Ying         2022-02-14  1999  	rcu_assign_pointer(sched_domains_numa_distance, NULL);
0fb3978b0aac3a Huang Ying         2022-02-14 @2000  	masks = sched_domains_numa_masks;
0fb3978b0aac3a Huang Ying         2022-02-14  2001  	rcu_assign_pointer(sched_domains_numa_masks, NULL);
0fb3978b0aac3a Huang Ying         2022-02-14  2002  	if (distances || masks) {
0fb3978b0aac3a Huang Ying         2022-02-14  2003  		int i, j;
0083242c93759d Valentin Schneider 2021-08-18  2004  
0fb3978b0aac3a Huang Ying         2022-02-14  2005  		synchronize_rcu();
0fb3978b0aac3a Huang Ying         2022-02-14  2006  		kfree(distances);
0fb3978b0aac3a Huang Ying         2022-02-14  2007  		for (i = 0; i < nr_levels && masks; i++) {
0fb3978b0aac3a Huang Ying         2022-02-14  2008  			if (!masks[i])
0083242c93759d Valentin Schneider 2021-08-18  2009  				continue;
0fb3978b0aac3a Huang Ying         2022-02-14  2010  			for_each_node(j)
0fb3978b0aac3a Huang Ying         2022-02-14  2011  				kfree(masks[i][j]);
0fb3978b0aac3a Huang Ying         2022-02-14  2012  			kfree(masks[i]);
0fb3978b0aac3a Huang Ying         2022-02-14  2013  		}
0fb3978b0aac3a Huang Ying         2022-02-14  2014  		kfree(masks);
0fb3978b0aac3a Huang Ying         2022-02-14  2015  	}
0fb3978b0aac3a Huang Ying         2022-02-14  2016  	if (sched_domain_topology_saved) {
0fb3978b0aac3a Huang Ying         2022-02-14  2017  		kfree(sched_domain_topology);
0fb3978b0aac3a Huang Ying         2022-02-14  2018  		sched_domain_topology = sched_domain_topology_saved;
0fb3978b0aac3a Huang Ying         2022-02-14  2019  		sched_domain_topology_saved = NULL;
0083242c93759d Valentin Schneider 2021-08-18  2020  	}
0083242c93759d Valentin Schneider 2021-08-18  2021  }
0083242c93759d Valentin Schneider 2021-08-18  2022  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

