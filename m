Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF247E0EF8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjKDLMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjKDLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:12:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26E1BD;
        Sat,  4 Nov 2023 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699096337; x=1730632337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37iR+q4rFUtdWkl1r9jTLauEbNqeLqTA/K8vFTBhKJ0=;
  b=SA7uyX3O7zaJafuYyY3I235vhdXOXKYoSYaJNluaTsVop+YDuKWxrK98
   jNV13dyD5kxNjXwfuK+/ijJlAWnGSfHtP4CBGLL8q8c6i9noMxOYL6/ZL
   MNTtmguILJEka67JxUOj9rSPOf38MrGlwrpjHc5dpjXnJY7I4HOInWvzs
   OcQmrOodV9afgsknh7Vqmn8GdlfgECB/0ppzSa4gUbKBbjYD/+T0AsthK
   y3rgFZmHrP5J//ozpuuvMx/s/qqrMZ65fWQQxDbLkAC/W9fGZVhFBGcgD
   B3zHTxux+RbF7BPIZH4TM2vnhgmdgyUZ4JabkFrRmHyuYTZA23oG2aAs6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="420194824"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="420194824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="738352993"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="738352993"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2023 04:12:13 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzEZX-0003x9-15;
        Sat, 04 Nov 2023 11:12:11 +0000
Date:   Sat, 4 Nov 2023 19:10:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>,
        zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 -next 2/5] spi: mockup: Add writeable tracepoint for
 spi transfer
Message-ID: <202311041825.n8iCJiNe-lkp@intel.com>
References: <20231104064650.972687-3-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104064650.972687-3-zhangxiaoxu@huaweicloud.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231103]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Xiaoxu/spi-mockup-Add-SPI-controller-testing-driver/20231104-144859
base:   next-20231103
patch link:    https://lore.kernel.org/r/20231104064650.972687-3-zhangxiaoxu%40huaweicloud.com
patch subject: [PATCH v3 -next 2/5] spi: mockup: Add writeable tracepoint for spi transfer
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311041825.n8iCJiNe-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041825.n8iCJiNe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041825.n8iCJiNe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:27,
                    from include/trace/define_trace.h:102,
                    from include/trace/events/spi_mockup.h:31,
                    from drivers/spi/spi-mockup.c:17:
>> include/trace/stages/init.h:2:23: warning: 'str__spi_mockup__trace_system_name' defined but not used [-Wunused-const-variable=]
       2 | #define __app__(x, y) str__##x##y
         |                       ^~~~~
   include/trace/stages/init.h:3:21: note: in expansion of macro '__app__'
       3 | #define __app(x, y) __app__(x, y)
         |                     ^~~~~~~
   include/trace/stages/init.h:5:29: note: in expansion of macro '__app'
       5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
         |                             ^~~~~
   include/trace/stages/init.h:8:27: note: in expansion of macro 'TRACE_SYSTEM_STRING'
       8 |         static const char TRACE_SYSTEM_STRING[] =       \
         |                           ^~~~~~~~~~~~~~~~~~~
   include/trace/stages/init.h:11:1: note: in expansion of macro 'TRACE_MAKE_SYSTEM_STR'
      11 | TRACE_MAKE_SYSTEM_STR();
         | ^~~~~~~~~~~~~~~~~~~~~


vim +/str__spi_mockup__trace_system_name +2 include/trace/stages/init.h

af6b9668e85ffd Steven Rostedt (Google  2022-03-03 @2) #define __app__(x, y) str__##x##y
af6b9668e85ffd Steven Rostedt (Google  2022-03-03  3) #define __app(x, y) __app__(x, y)
af6b9668e85ffd Steven Rostedt (Google  2022-03-03  4) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
