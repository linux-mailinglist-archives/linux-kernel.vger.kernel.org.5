Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3677ED28A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjKOTZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjKOTZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:25:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13C130;
        Wed, 15 Nov 2023 11:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700076329; x=1731612329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=McKOscbZvZRsoTCCO+6I+3OL4SrPfiFuJ0fDjAUvUJk=;
  b=VRbCJ7KzxwC89S2jriUS+RHbikJXtmrptri8YN6LJyE3oU9H6yQ026PU
   H0e48evWNDdI6SXnXwDMQIoNvF8VQgIbJOS4TrekGR3zAQLHB5ccJ8XUA
   PXYjuguIcOjJOlnK8tU8yyDxLbgC8HfS3IBam9xPtt+dyTZ8XezG0ViY4
   fntXuGwdlHA/GN1AglTux3sJ/N1H3yBAwxNCjgtFfX0NrJcvB2rSOOwpX
   jISqzNw+jUqlODCbgtZ/+sJYWikjXXsXcJJnslLF+rEH9ezztgq+r3+Bw
   zocMGXj8vxGfR4kTSBT7OYgW3dB2Uk2B069PdsopQLI37W42x8StwrvVD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457434772"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="457434772"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831028204"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831028204"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2023 11:24:53 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3LVK-0000kk-2d;
        Wed, 15 Nov 2023 19:24:50 +0000
Date:   Thu, 16 Nov 2023 03:23:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v1 2/3] EDAC, pnd2: Apply bit macros and helpers where it
 makes sense
Message-ID: <202311160352.PfYDQfkU-lkp@intel.com>
References: <20231115154940.664664-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115154940.664664-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/EDAC-pnd2-Apply-bit-macros-and-helpers-where-it-makes-sense/20231115-235225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20231115154940.664664-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 2/3] EDAC, pnd2: Apply bit macros and helpers where it makes sense
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231116/202311160352.PfYDQfkU-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160352.PfYDQfkU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160352.PfYDQfkU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/edac/pnd2_edac.c:1069:3: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   ret += check_channel(i);
                   ^~~
   drivers/edac/pnd2_edac.c:1065:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +/ret +1069 drivers/edac/pnd2_edac.c

5c71ad17f97e84d Tony Luck       2017-03-09  1061  
5c71ad17f97e84d Tony Luck       2017-03-09  1062  static int apl_check_ecc_active(void)
5c71ad17f97e84d Tony Luck       2017-03-09  1063  {
f29c26c5b4c5b02 Andy Shevchenko 2023-11-15  1064  	unsigned int i;
f29c26c5b4c5b02 Andy Shevchenko 2023-11-15  1065  	int ret;
5c71ad17f97e84d Tony Luck       2017-03-09  1066  
5c71ad17f97e84d Tony Luck       2017-03-09  1067  	/* Check dramtype and ECC mode for each present DIMM */
f29c26c5b4c5b02 Andy Shevchenko 2023-11-15  1068  	for_each_set_bit(i, &chan_mask, APL_NUM_CHANNELS)
5c71ad17f97e84d Tony Luck       2017-03-09 @1069  		ret += check_channel(i);
f29c26c5b4c5b02 Andy Shevchenko 2023-11-15  1070  
5c71ad17f97e84d Tony Luck       2017-03-09  1071  	return ret ? -EINVAL : 0;
5c71ad17f97e84d Tony Luck       2017-03-09  1072  }
5c71ad17f97e84d Tony Luck       2017-03-09  1073  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
