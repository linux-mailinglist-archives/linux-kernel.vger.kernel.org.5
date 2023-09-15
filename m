Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D16B7A2392
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjIOQ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjIOQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:28:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEDEE69;
        Fri, 15 Sep 2023 09:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694795283; x=1726331283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jWPmuh3AP2eau1bdvZPWN1uwQnHbBAhrFZvD7Bt9Gs8=;
  b=NcSsyBvKHYj6tJjybY7Z89of1VCdKIhYwSXSKNd6pmollbKdZFpF8Rfa
   fdKp2ycoHpR2NHhVfanKnbtbNAYmTi86+9yyRRW6ObHPbJhxllYMksCb9
   j7JKc3R9W8G94UW7rKkGnN8PxjnSfsS8JuTcssnBUdxLxEnqPJEXw+KzT
   2cuKgDawkGM+6FicsKES0VS09sjjvVBnhHFkkvdtD/vUue4rJyj7NCV6C
   m9WYYZf9n49czlktcPjev/p8zxTlqhq+SkG+pDwTAdW95OUeYn8RF9XX8
   AHV+RN4E5KzKZ9WQephLQEaCwkWl9b4aDJMx91ehD91NtBoeqWs3m/Czv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="358708033"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="358708033"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="918704671"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="918704671"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Sep 2023 09:27:59 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhBfh-0003BQ-25;
        Fri, 15 Sep 2023 16:27:57 +0000
Date:   Sat, 16 Sep 2023 00:27:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: Re: [PATCH] net: sched: hfsc: dont intepret cls results when asked
 to drop
Message-ID: <202309160007.7615P5Df-lkp@intel.com>
References: <20230915134408.3410595-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915134408.3410595-1-make_ruc2021@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/net-sched-hfsc-dont-intepret-cls-results-when-asked-to-drop/20230915-214635
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230915134408.3410595-1-make_ruc2021%40163.com
patch subject: [PATCH] net: sched: hfsc: dont intepret cls results when asked to drop
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230916/202309160007.7615P5Df-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309160007.7615P5Df-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309160007.7615P5Df-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:80,
                    from <command-line>:
   net/sched/sch_hfsc.c: In function 'hfsc_classify':
>> include/linux/compiler_attributes.h:227:41: warning: attribute 'fallthrough' not preceding a case label or default label
     227 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                         ^~~~~~~~~~~~~
   net/sched/sch_hfsc.c:1146:25: note: in expansion of macro 'fallthrough'
    1146 |                         fallthrough;
         |                         ^~~~~~~~~~~


vim +/fallthrough +227 include/linux/compiler_attributes.h

294f69e662d157 Joe Perches   2019-10-05  214  
294f69e662d157 Joe Perches   2019-10-05  215  /*
294f69e662d157 Joe Perches   2019-10-05  216   * Add the pseudo keyword 'fallthrough' so case statement blocks
294f69e662d157 Joe Perches   2019-10-05  217   * must end with any of these keywords:
294f69e662d157 Joe Perches   2019-10-05  218   *   break;
294f69e662d157 Joe Perches   2019-10-05  219   *   fallthrough;
ca0760e7d79e2b Wei Ming Chen 2021-05-06  220   *   continue;
294f69e662d157 Joe Perches   2019-10-05  221   *   goto <label>;
294f69e662d157 Joe Perches   2019-10-05  222   *   return [expression];
294f69e662d157 Joe Perches   2019-10-05  223   *
294f69e662d157 Joe Perches   2019-10-05  224   *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
294f69e662d157 Joe Perches   2019-10-05  225   */
294f69e662d157 Joe Perches   2019-10-05  226  #if __has_attribute(__fallthrough__)
294f69e662d157 Joe Perches   2019-10-05 @227  # define fallthrough                    __attribute__((__fallthrough__))
294f69e662d157 Joe Perches   2019-10-05  228  #else
294f69e662d157 Joe Perches   2019-10-05  229  # define fallthrough                    do {} while (0)  /* fallthrough */
a3f8a30f3f0079 Miguel Ojeda  2018-08-30  230  #endif
a3f8a30f3f0079 Miguel Ojeda  2018-08-30  231  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
