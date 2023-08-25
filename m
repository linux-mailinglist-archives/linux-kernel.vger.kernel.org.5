Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AB788EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjHYSZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjHYSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:25:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6C2E67;
        Fri, 25 Aug 2023 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692987898; x=1724523898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RBjmbcP/48Z/9RDJfjhXfkwKSBxaNq5tG2haEM+tDS4=;
  b=ZphS5aoEvOqP5br8I+4pfvXbNvGWVafl4O3/Y0jSM2fdsiRFyYqIT7+f
   ZMkOZLxgNiH2LXTfvKxcjkGIPiKHxzJlJwhw9Up1O7jRQ8vEdD51vaWsz
   LwalMQcfK1YDLvRy1ueEBsQrLCUuPy0yzDhom8dlG9xpFPNL6FcGcxEz4
   6mJNJwJQTCki6vutLEWRu0QopNUyM70+0fb+MBtqcd4q9EUuRSYdpKx/9
   4/MliritZ3lCf4KLPjQlwFGIC4yAhE+kOBF7pKOykechcTI6/mJTS9qwK
   415VfSgTuU0owwecAM0ABfpUQvxeQ1Oj5XoMnV1f9gpWp+TUKnx5dbF/F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="377513189"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="377513189"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 11:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772569384"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="772569384"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2023 11:24:49 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZbUG-0003tL-0Y;
        Fri, 25 Aug 2023 18:24:48 +0000
Date:   Sat, 26 Aug 2023 02:24:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     oe-kbuild-all@lists.linux.dev, azkali <a.ffcc7@gmail.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Adam Jiang <chaoj@nvidia.com>, CTCaer <ctcaer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Message-ID: <202308260240.OBZU72Ht-lkp@intel.com>
References: <20230824153059.212244-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824153059.212244-3-linkmauve@linkmauve.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emmanuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus robh/for-next linus/master v6.5-rc7 next-20230825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Emmanuel-Gil-Peyrot/dt-bindings-misc-rohm-bm92txx-Add-BM92Txx-support/20230824-233354
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230824153059.212244-3-linkmauve%40linkmauve.fr
patch subject: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
config: csky-randconfig-r036-20230826 (https://download.01.org/0day-ci/archive/20230826/202308260240.OBZU72Ht-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260240.OBZU72Ht-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260240.OBZU72Ht-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/bm92txx.c: In function 'bm92t_remove':
>> drivers/misc/bm92txx.c:1800:28: warning: unused variable 'info' [-Wunused-variable]
    1800 |         struct bm92t_info *info = i2c_get_clientdata(client);
         |                            ^~~~
   drivers/misc/bm92txx.c: At top level:
>> drivers/misc/bm92txx.c:1179:13: warning: 'bm92t_usbhub_dp_sleep' defined but not used [-Wunused-function]
    1179 | static void bm92t_usbhub_dp_sleep(struct bm92t_info *info, bool sleep)
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/info +1800 drivers/misc/bm92txx.c

  1797	
  1798	static void bm92t_remove(struct i2c_client *client)
  1799	{
> 1800		struct bm92t_info *info = i2c_get_clientdata(client);
  1801	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
