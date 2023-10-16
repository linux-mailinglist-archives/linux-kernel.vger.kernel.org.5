Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5A7CA7FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjJPM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:29:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCC9B;
        Mon, 16 Oct 2023 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697459387; x=1728995387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4iLosxWswCCbHcun/ld8yUky/U5sw9Wi6q5ArDk6cI=;
  b=VIoB6LrHdLAW3gCGPLss7zUVMrsMmFyy0BldQAzi6tmGbv5kHK3N7ihI
   eX4aSAyz1R/W83vhdXWuMAzh0Lco9KeK8b+3CdEian2EX95i2LFGRrSVr
   MkEsEoDTm7KEI0/D8P0OzOA31YBFvN1B+XviiZMFx+0lZi9j51Ozz8JSk
   JUwaRH/fdD5gzHbo/9QE0rD73T+XOuc1N47ZRoPZk3Cpz9AOfjYWowPw8
   XW0ZIkd7STyATvsEu2NWORvg8KbIrzQbKkcVJdxJ5QHjG40HLcB7X5KZe
   FEpzK+Y3gTPOQwDgJohwz7zOM1eRgxc0F83DVDtmOi2LvUnwc8Ag0Y9fN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385352625"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385352625"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="785071563"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="785071563"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2023 05:29:44 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsMiu-0008Mp-30;
        Mon, 16 Oct 2023 12:29:33 +0000
Date:   Mon, 16 Oct 2023 20:28:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de,
        linux-edac@vger.kernel.org, tony.luck@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com, william.roche@oracle.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
Message-ID: <202310162015.fuitGuiJ-lkp@intel.com>
References: <20231005173526.42831-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005173526.42831-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yazen,

kernel test robot noticed the following build errors:

[auto build test ERROR on ras/edac-for-next]
[also build test ERROR on linus/master v6.6-rc6 next-20231016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazen-Ghannam/RAS-Introduce-AMD-Address-Translation-Library/20231006-014458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20231005173526.42831-2-yazen.ghannam%40amd.com
patch subject: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
config: i386-buildonly-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20231016/202310162015.fuitGuiJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310162015.fuitGuiJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310162015.fuitGuiJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/ras/amd/atl/denormalize.o: in function `denormalize_address':
>> denormalize.c:(.text+0x84f): undefined reference to `__umoddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
