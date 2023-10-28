Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C17DA6B4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjJ1L00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJ1L0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:26:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66BDE;
        Sat, 28 Oct 2023 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698492383; x=1730028383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EiBmg3WSGnU2/oHflLAqGOz1gDRdCnOP+gRHl/4jjzU=;
  b=ap6/fGfMzPI9VTofXXGIW0nNMeWLZsAsLwwYVXfSV5/AraTU0yzRLxWG
   qBw+/e2o2iBDyW6NQ4DVdDvbx7OmLH08XdUkcQsrixXVSEprCUDvbjXa3
   UN+YtNtS8NJMEtzeBQEaPm+FAWgakO/iU6zVpUY50y19Aa6xO6R5+mZvs
   mlscnRCgZ1nFlHZWtHePhQ2q5B6eoPxnYezJvvqoz+LU+mEPA72tPktIC
   NGFm8jLn3Ax/sqSAD+Fc8+bpspISMjlAh4cu20wZLO3T9pSLX6/acEhlc
   pYCWSpa2pn3rjxvrlzTtiVAyLuNJzXB7+xZfDrwWeiDSBrK5kgdlzX0dk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="386780488"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="386780488"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 04:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="794853609"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="794853609"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Oct 2023 04:26:20 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwhSL-000BgJ-2B;
        Sat, 28 Oct 2023 11:26:17 +0000
Date:   Sat, 28 Oct 2023 19:26:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, suleiman@google.com,
        briannorris@google.com, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: sleep: Expose last succeeded resumed timestamp in
 sysfs
Message-ID: <202310281942.ZwkSMsVB-lkp@intel.com>
References: <169845668624.1319505.1097714089024984847.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169845668624.1319505.1097714089024984847.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc7 next-20231027]
[cannot apply to pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/PM-sleep-Expose-last-succeeded-resumed-timestamp-in-sysfs/20231028-093251
base:   linus/master
patch link:    https://lore.kernel.org/r/169845668624.1319505.1097714089024984847.stgit%40mhiramat.roam.corp.google.com
patch subject: [PATCH v2] PM: sleep: Expose last succeeded resumed timestamp in sysfs
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231028/202310281942.ZwkSMsVB-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281942.ZwkSMsVB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310281942.ZwkSMsVB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/main.c: In function 'last_success_resume_time_show':
>> kernel/power/main.c:427:38: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long int' [-Wformat=]
     427 |         return sprintf(buf, "%llu.%llu\n",
         |                                   ~~~^
         |                                      |
         |                                      long long unsigned int
         |                                   %lu
     428 |                        suspend_stats.last_success_resume_time.tv_sec,
     429 |                        suspend_stats.last_success_resume_time.tv_nsec);
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                              |
         |                                                              long int
   kernel/power/main.c: In function 'suspend_stats_show':
   kernel/power/main.c:528:62: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long int' [-Wformat=]
     528 |         seq_printf(s,   "last_success_resume_time:\t%-llu.%llu\n",
         |                                                           ~~~^
         |                                                              |
         |                                                              long long unsigned int
         |                                                           %lu
     529 |                    suspend_stats.last_success_resume_time.tv_sec,
     530 |                    suspend_stats.last_success_resume_time.tv_nsec);
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                          |
         |                                                          long int


vim +427 kernel/power/main.c

   423	
   424	static ssize_t last_success_resume_time_show(struct kobject *kobj,
   425			struct kobj_attribute *attr, char *buf)
   426	{
 > 427		return sprintf(buf, "%llu.%llu\n",
   428			       suspend_stats.last_success_resume_time.tv_sec,
   429			       suspend_stats.last_success_resume_time.tv_nsec);
   430	}
   431	static struct kobj_attribute last_success_resume_time =
   432				__ATTR_RO(last_success_resume_time);
   433	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
