Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92087DA0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbjJ0SjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjJ0SjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:39:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD1812A;
        Fri, 27 Oct 2023 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698431938; x=1729967938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/rfTV7fW5gKjZQKtJuxH2JY/OrmY4+1jcnMI1v2wl1A=;
  b=bBaMWZp1YEZkITkLDEAuod+7S9HBKmaeoD6QGcM98tsKgFaoYW+dwysq
   ht1Mpc9Ln+noQ8oGpebtzuzkDy7jaOCyLL49u7t3Heg4w8UFDea5eGwYB
   A179VN4GPIV8my+RhWgxvV2KeLrRCSR1+/AN/cp5TiyeEu6KM+alswiDV
   s2+ydUDBCGYs9eB5ps12T5kUmH/e/dKuGdyw/dAUskcv4/hdtqqrQRC7a
   1dwdbksaU+SPktiP412cW3yff3oE0H3toJiyL7pDvX/+qNBDou6O/4CAf
   HGykLSbn9E/iwQ0TEm/1zveD7zNsbm2/jjBYcUx5HI35MRDVGv7d/URMY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="387644126"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="387644126"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 11:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="867292"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2023 11:38:19 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwRjQ-000B83-0V;
        Fri, 27 Oct 2023 18:38:52 +0000
Date:   Sat, 28 Oct 2023 02:38:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, suleiman@google.com,
        briannorris@google.com, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: sleep: Expose last succeeded resumed timestamp in
 sysfs
Message-ID: <202310280256.JJlmxwDy-lkp@intel.com>
References: <169841470363.1307628.18049455026067747896.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169841470363.1307628.18049455026067747896.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/PM-sleep-Expose-last-succeeded-resumed-timestamp-in-sysfs/20231027-215311
base:   linus/master
patch link:    https://lore.kernel.org/r/169841470363.1307628.18049455026067747896.stgit%40mhiramat.roam.corp.google.com
patch subject: [PATCH] PM: sleep: Expose last succeeded resumed timestamp in sysfs
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231028/202310280256.JJlmxwDy-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310280256.JJlmxwDy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310280256.JJlmxwDy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/main.c: In function 'last_success_resume_time_show':
>> kernel/power/main.c:427:32: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'time64_t' {aka 'long long int'} [-Wformat=]
     427 |         return sprintf(buf, "%lu.%lu\n",
         |                              ~~^
         |                                |
         |                                long unsigned int
         |                              %llu
     428 |                        suspend_stats.last_success_resume_time.tv_sec,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                              |
         |                                                              time64_t {aka long long int}
   kernel/power/main.c: In function 'suspend_stats_show':
   kernel/power/main.c:528:58: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'time64_t' {aka 'long long int'} [-Wformat=]
     528 |         seq_printf(s,   "  last_success_resume_time:\t%-lu.%lu\n",
         |                                                       ~~~^
         |                                                          |
         |                                                          long unsigned int
         |                                                       %-llu
     529 |                    suspend_stats.last_success_resume_time.tv_sec,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                          |
         |                                                          time64_t {aka long long int}


vim +427 kernel/power/main.c

   423	
   424	static ssize_t last_success_resume_time_show(struct kobject *kobj,
   425			struct kobj_attribute *attr, char *buf)
   426	{
 > 427		return sprintf(buf, "%lu.%lu\n",
   428			       suspend_stats.last_success_resume_time.tv_sec,
   429			       suspend_stats.last_success_resume_time.tv_nsec);
   430	}
   431	static struct kobj_attribute last_success_resume_time =
   432				__ATTR_RO(last_success_resume_time);
   433	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
