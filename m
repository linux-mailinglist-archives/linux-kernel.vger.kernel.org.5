Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A957ACE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjIYCgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjIYCgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:36:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE790C2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609385; x=1727145385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Eie4tDSxJtzvtbLiXBv6OWMk2WPjKygPOluleJmGUc=;
  b=EBldWZ0UN7yLgN2YX6MDQt7uhb/yEFzGoTQ19B9jV6952chO5AJp9T4Y
   tgcbQPIAW/oPfvwISRlykXqjVbp4pbDL6nOyYpPQmrNdTC7sZKEyYDRyl
   jejxrKZ2XOVAc8inKzIF4LNq6sDc49O6t9Gyul9TyxdNRoF06xAy8ebKa
   +UTI4AeP38iVqHlz/bD+k9t8PhTyPY6ynQnT5axADqC77DrsblHF91IVO
   mXhTkgQdSkhzaah99KGEHl/UWt8+R/7oHo6++WEK3gMdWruLgHwDKCcmO
   im3hhE7rROpr1CWPHp1srqhjb7am8A06aSWY+MFrWMOZyX2XZSQCcyqRU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445253835"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445253835"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="697832549"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="697832549"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2023 19:36:22 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkbSO-0000uc-04;
        Mon, 25 Sep 2023 02:36:20 +0000
Date:   Mon, 25 Sep 2023 10:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        wens@csie.org
Cc:     oe-kbuild-all@lists.linux.dev, airlied@gmail.com, daniel@ffwll.ch,
        samuel@sholland.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 5/7] drm/sun4i: dw-hdmi: Split driver registration
Message-ID: <202309251030.rZTXXyFE-lkp@intel.com>
References: <20230924192604.3262187-6-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924192604.3262187-6-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc3 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jernej-Skrabec/drm-sun4i-dw-hdmi-Deinit-PHY-in-fail-path/20230925-032818
base:   linus/master
patch link:    https://lore.kernel.org/r/20230924192604.3262187-6-jernej.skrabec%40gmail.com
patch subject: [PATCH 5/7] drm/sun4i: dw-hdmi: Split driver registration
config: parisc-randconfig-002-20230925 (https://download.01.org/0day-ci/archive/20230925/202309251030.rZTXXyFE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309251030.rZTXXyFE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309251030.rZTXXyFE-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/gpu/drm/sun4i/sun8i_hdmi_phy.o: in function `sun8i_hdmi_phy_driver_init':
>> (.init.text+0x0): multiple definition of `init_module'; drivers/gpu/drm/sun4i/sun8i_dw_hdmi.o:(.init.text+0x0): first defined here
   hppa-linux-ld: drivers/gpu/drm/sun4i/sun8i_hdmi_phy.o: in function `sun8i_hdmi_phy_driver_exit':
>> (.exit.text+0x0): multiple definition of `cleanup_module'; drivers/gpu/drm/sun4i/sun8i_dw_hdmi.o:(.exit.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
