Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B635779CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbjHLC4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjHLC4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:56:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202230E8;
        Fri, 11 Aug 2023 19:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691808967; x=1723344967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZcg5DzVy7DTPks00m1sJvK4eyEoGR4O5ky9f70yIOo=;
  b=b/tTYG4ZGrbcbEqE2TIdNnB7OoWF496mGsXdOHEwaAXPPyC8NrDjuZSm
   uTOd1KCIs9YGainfXFfXaNUU+LbNOrM9U8u418MSr/xInPlveTW+Rw+Rw
   Q0sKHiHoUgU7sWJoKnrUYXfVLw4L7Qd43ZHawup2+Lw3uYehxSjq+RIvb
   xiy9gkySbVuamda24PSGmxV4sN6Wuez1MuKSgCRuiefYQpSQXeLP9KVav
   /RTngPc8EJ95jm1sW8jGcmsw80IQO/djjs3lctmV+HonrWJc7qfncPyti
   dYsSWV/dAbwB8giHflmMt9k6bOeZMtW1SA86cUKF7be/ALviKvWDMJ7lF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="370699513"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="370699513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 19:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="767857919"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="767857919"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2023 19:56:01 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUenI-0008DE-0S;
        Sat, 12 Aug 2023 02:56:00 +0000
Date:   Sat, 12 Aug 2023 10:55:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <202308121020.23DejpAv-lkp@intel.com>
References: <20230731174613.4133167-3-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731174613.4133167-3-davidai@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on robh/for-next linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Dai/dt-bindings-cpufreq-add-bindings-for-virtual-cpufreq/20230801-014946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230731174613.4133167-3-davidai%40google.com
patch subject: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
config: arm-randconfig-r061-20230812 (https://download.01.org/0day-ci/archive/20230812/202308121020.23DejpAv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121020.23DejpAv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121020.23DejpAv-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/cpufreq/virtual-cpufreq.o: in function `virt_cpufreq_cpu_exit':
>> virtual-cpufreq.c:(.text+0xf8): undefined reference to `topology_clear_scale_freq_source'
   arm-linux-gnueabi-ld: drivers/cpufreq/virtual-cpufreq.o: in function `virt_cpufreq_cpu_init':
>> virtual-cpufreq.c:(.text+0x1c8): undefined reference to `topology_set_scale_freq_source'
   arm-linux-gnueabi-ld: drivers/cpufreq/virtual-cpufreq.o: in function `virt_scale_freq_tick':
>> virtual-cpufreq.c:(.text+0x330): undefined reference to `arch_freq_scale'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
