Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB90378E9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbjHaJqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjHaJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:46:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4D1A1;
        Thu, 31 Aug 2023 02:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693475157; x=1725011157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZAGLbSH8eC0EwEQKiYztBPBDbomugZMJtC2h7cRgP0=;
  b=i8/g9IHeIN/r6pzubobRm/Toh7/EZ05gxQlDkH3uDiU/TXUj5KdCPjVu
   QHBw7GhBoEWNJ7oiIx4SIR2mUXvAIjVmrdU/9OC89a1P0B7NNp6CE++kq
   /n29IU2nOa+4IO9kA5KNF4/bYZx6Otdc/+yW3TH1SwYwIQQ9GgfYpUyoE
   b7Vq9nKwY6dGM7T1URPoNwPvUrtT/01/ZgnZZwm8frZrkBEsUF5ekBbi4
   AfRz1mK56lygUddavO9TV12SM0ZqGK7DzP1Yy21kxgjff6suoQgabqxui
   GK9f8XnuscSty2lsrE3Hu7nEP0tsSBOWPopD+o8BQ4NSPqHE1Q3QXWwII
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356195676"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="356195676"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 02:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="829591088"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="829591088"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Aug 2023 02:45:54 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbeFM-000BCf-2t;
        Thu, 31 Aug 2023 09:45:52 +0000
Date:   Thu, 31 Aug 2023 17:45:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyi Liu <i.pear@outlook.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, Tianyi Liu <i.pear@outlook.com>
Subject: Re: [PATCH] Introduce callchains for guests
Message-ID: <202308311743.uvv4Ras8-lkp@intel.com>
References: <SY4P282MB10848199D3F93AA47A845B8B9DE5A@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY4P282MB10848199D3F93AA47A845B8B9DE5A@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianyi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on acme/perf/core linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianyi-Liu/Introduce-callchains-for-guests/20230831-161333
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/SY4P282MB10848199D3F93AA47A845B8B9DE5A%40SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
patch subject: [PATCH] Introduce callchains for guests
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230831/202308311743.uvv4Ras8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308311743.uvv4Ras8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308311743.uvv4Ras8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/events/callchain.c:48:13: warning: no previous prototype for 'perf_callchain_guest' [-Wmissing-prototypes]
      48 | __weak void perf_callchain_guest(struct perf_callchain_entry_ctx *entry)
         |             ^~~~~~~~~~~~~~~~~~~~


vim +/perf_callchain_guest +48 kernel/events/callchain.c

    47	
  > 48	__weak void perf_callchain_guest(struct perf_callchain_entry_ctx *entry)
    49	{
    50	}
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
