Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA17DCB72
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjJaLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbjJaLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:09:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A21A6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698750551; x=1730286551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvrwnc35erdZoVBiQV02YhA2bWWfgE0gKFuh2GpCkNs=;
  b=gXx4Wzam0u8HjNFdhOFl8+NYih1FaQv1NEa4gB1Jes64AYeCNI3Hs/+n
   yWXeODU9g+CuGZpUrHt2oj0Cb7QtZFd1A6LB6MRqL+81N5HtNRJEbM+4b
   CmCuWNA70O12owT2TU+hEkw3hSDyt7HWxoCjqvJYHS4TsGNWnDDwQJKXS
   M5BAjHh9twbkWmHw2cyxVHDgDlyYpiwWBdYMkAL/JY9pQCPboaqLR64rs
   8ugOmmRWORuH4xANHDFFoQXT+Kz1g61KDbg9cJG4JPcXijfw7gSXq/R/G
   dHivziOKCvVvaHM+ROkaLmiqJGzMWHbim6wGRHmZ522ElqAsvmQb8B2L4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="373316755"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="373316755"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 04:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="8298958"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2023 04:09:08 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxmcL-00007a-1t;
        Tue, 31 Oct 2023 11:09:05 +0000
Date:   Tue, 31 Oct 2023 19:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baojun Xu <baojun.xu@ti.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     oe-kbuild-all@lists.linux.dev,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kevin-lu@ti.com,
        shenghao-ding@ti.com, baojun.xu@ti.com, peeyush@ti.com,
        navada@ti.com, tiwai@suse.de
Subject: Re: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
Message-ID: <202310311857.BgEnJVnO-lkp@intel.com>
References: <20231028092409.96813-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028092409.96813-1-baojun.xu@ti.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baojun,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baojun-Xu/ASoC-tas2783-Add-source-files-for-tas2783-driver/20231028-172643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20231028092409.96813-1-baojun.xu%40ti.com
patch subject: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20231031/202310311857.BgEnJVnO-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310311857.BgEnJVnO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310311857.BgEnJVnO-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: sound/soc/codecs/tas2783-sdw.o: in function `tas2783_calibration.isra.0':
   tas2783-sdw.c:(.text+0xd48): undefined reference to `efi'
>> nios2-linux-ld: tas2783-sdw.c:(.text+0xd50): undefined reference to `efi'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
