Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375BF7973FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjIGPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbjIGPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C705199
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100622; x=1725636622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8VOqPVSIgxAt6a/8mX2/g8iwKlyB7CfkDhVuX9gcRA=;
  b=DxiZoaipHj2tXS5f9ssmR4yaTy0MEdSm9SE6VRJeTXBCsVkbZ8nSPkXK
   ldekQF5Ek7h95lKewIRWrF68Lke8XFbGq4IeUAXl0eUstToyjtLL0dagH
   6BTwAU7RYq1VH4aAUj+cnNIWWWfj37IEYKbceH6FihTld7lJwKJNkPDtv
   md+fHe8RUjzwtiDrzScsMWwg63ZQlh0TXfpXN7VzuUyHuN9Dornax3AP1
   xJKot+u+UwAFzOXKfgxM0hFH4jwCnY9Mkn8xVQJDecJRGKaOUF1+Bk/sN
   FossnL/0ppMuvNrvmv/o0jMr348oPSTmwDyaE6D+msz0v8kSON8P4PRUs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="381122701"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="381122701"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691767265"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="691767265"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2023 05:22:04 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeE1J-0001D5-0X;
        Thu, 07 Sep 2023 12:22:01 +0000
Date:   Thu, 7 Sep 2023 20:21:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     advantech.susiteam@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, wenkai.chung@advantech.com.tw,
        Susi.Driver@advantech.com, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: eiois200: Add EIO-IS200 Series EC Core Driver
Message-ID: <202309071936.oPUjyLt5-lkp@intel.com>
References: <20230907031320.6814-5-advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907031320.6814-5-advantech.susiteam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on linus/master next-20230907]
[cannot apply to lee-mfd/for-mfd-fixes v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/advantech-susiteam-gmail-com/mfd-eiois200-Insert-EIO-IS200-core-driver-to-Kconfig/20230907-111628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230907031320.6814-5-advantech.susiteam%40gmail.com
patch subject: [PATCH 4/4] mfd: eiois200: Add EIO-IS200 Series EC Core Driver
config: x86_64-randconfig-121-20230907 (https://download.01.org/0day-ci/archive/20230907/202309071936.oPUjyLt5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309071936.oPUjyLt5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309071936.oPUjyLt5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mfd/eiois200_core.c:58:21: sparse: sparse: symbol 'is200_range' was not declared. Should it be static?
>> drivers/mfd/eiois200_core.c:438:5: sparse: sparse: symbol 'eiois200_probe' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
