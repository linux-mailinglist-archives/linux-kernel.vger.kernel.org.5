Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F67CCF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbjJQVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjJQVfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:35:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D5198A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697578079; x=1729114079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fqDPYSBmH7aafgeacaq1FNvlyAYmK6SZpADh/QQ04vc=;
  b=lAK1kSjQqqSzou0BUIpWJ9MjdQYyjWXp1Hwu3FTKhElVJx5qJG77OoO9
   d1p9R0oylvAAK4RxSVjs4yrdhx1ejnK+P4MdYunwJOWhxVIKNvQYbB9Xx
   A8oiESH0aOcf/kcHCcriB0nWdDXKs6ynwAXR42lc+yMihyYvgajnr4iTQ
   OCRN3qjxtEI7ZCDn/iCfFH5ejj6XmhKUy2EhQJx0JW0IZQxOppi+jYEcr
   TiGFiXQifnJJINIhhoM4aRBErht+i3iHd8nhihu/GlxWPk4y1bc1T4I7z
   ox+xFLwSXgjdkLCsytJBGTxxR47UDPaxAZOoC29eqkghJsvbV9ban8BfO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385718699"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="385718699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4249454"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2023 14:28:01 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsrbV-000A6O-0m;
        Tue, 17 Oct 2023 21:27:53 +0000
Date:   Wed, 18 Oct 2023 05:27:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or
 member 'stale_en' not described in 'llcc_slice_config'
Message-ID: <202310180505.S4iSIgx9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: c72ca343f911c3ba1b10163399f891ddb86ad109 soc: qcom: llcc: Add v4.1 HW version support
date:   11 months ago
config: x86_64-buildonly-randconfig-r001-20230530 (https://download.01.org/0day-ci/archive/20231018/202310180505.S4iSIgx9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310180505.S4iSIgx9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180505.S4iSIgx9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'stale_en' not described in 'llcc_slice_config'
>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'stale_cap_en' not described in 'llcc_slice_config'
>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'mru_uncap_en' not described in 'llcc_slice_config'
>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'mru_rollover' not described in 'llcc_slice_config'
>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'alloc_oneway_en' not described in 'llcc_slice_config'
>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'ovcap_en' not described in 'llcc_slice_config'
>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'ovcap_prio' not described in 'llcc_slice_config'
>> drivers/soc/qcom/llcc-qcom.c:121: warning: Function parameter or member 'vict_prio' not described in 'llcc_slice_config'


vim +121 drivers/soc/qcom/llcc-qcom.c

8008e7902f28eb Sai Prakash Ranjan    2022-01-28   70  
99356b03b431f9 Vivek Gautam          2019-07-18   71  /**
171c03171a4cdf Lee Jones             2020-11-03   72   * struct llcc_slice_config - Data associated with the llcc slice
99356b03b431f9 Vivek Gautam          2019-07-18   73   * @usecase_id: Unique id for the client's use case
99356b03b431f9 Vivek Gautam          2019-07-18   74   * @slice_id: llcc slice id for each client
99356b03b431f9 Vivek Gautam          2019-07-18   75   * @max_cap: The maximum capacity of the cache slice provided in KB
99356b03b431f9 Vivek Gautam          2019-07-18   76   * @priority: Priority of the client used to select victim line for replacement
99356b03b431f9 Vivek Gautam          2019-07-18   77   * @fixed_size: Boolean indicating if the slice has a fixed capacity
99356b03b431f9 Vivek Gautam          2019-07-18   78   * @bonus_ways: Bonus ways are additional ways to be used for any slice,
99356b03b431f9 Vivek Gautam          2019-07-18   79   *		if client ends up using more than reserved cache ways. Bonus
99356b03b431f9 Vivek Gautam          2019-07-18   80   *		ways are allocated only if they are not reserved for some
99356b03b431f9 Vivek Gautam          2019-07-18   81   *		other client.
99356b03b431f9 Vivek Gautam          2019-07-18   82   * @res_ways: Reserved ways for the cache slice, the reserved ways cannot
99356b03b431f9 Vivek Gautam          2019-07-18   83   *		be used by any other client than the one its assigned to.
99356b03b431f9 Vivek Gautam          2019-07-18   84   * @cache_mode: Each slice operates as a cache, this controls the mode of the
99356b03b431f9 Vivek Gautam          2019-07-18   85   *             slice: normal or TCM(Tightly Coupled Memory)
99356b03b431f9 Vivek Gautam          2019-07-18   86   * @probe_target_ways: Determines what ways to probe for access hit. When
99356b03b431f9 Vivek Gautam          2019-07-18   87   *                    configured to 1 only bonus and reserved ways are probed.
99356b03b431f9 Vivek Gautam          2019-07-18   88   *                    When configured to 0 all ways in llcc are probed.
99356b03b431f9 Vivek Gautam          2019-07-18   89   * @dis_cap_alloc: Disable capacity based allocation for a client
99356b03b431f9 Vivek Gautam          2019-07-18   90   * @retain_on_pc: If this bit is set and client has maintained active vote
99356b03b431f9 Vivek Gautam          2019-07-18   91   *               then the ways assigned to this client are not flushed on power
99356b03b431f9 Vivek Gautam          2019-07-18   92   *               collapse.
99356b03b431f9 Vivek Gautam          2019-07-18   93   * @activate_on_init: Activate the slice immediately after it is programmed
c4df37fe186de4 Manivannan Sadhasivam 2020-11-30   94   * @write_scid_en: Bit enables write cache support for a given scid.
2b8175a1f10836 Sai Prakash Ranjan    2022-01-28   95   * @write_scid_cacheable_en: Enables write cache cacheable support for a
2b8175a1f10836 Sai Prakash Ranjan    2022-01-28   96   *			     given scid (not supported on v2 or older hardware).
99356b03b431f9 Vivek Gautam          2019-07-18   97   */
99356b03b431f9 Vivek Gautam          2019-07-18   98  struct llcc_slice_config {
99356b03b431f9 Vivek Gautam          2019-07-18   99  	u32 usecase_id;
99356b03b431f9 Vivek Gautam          2019-07-18  100  	u32 slice_id;
99356b03b431f9 Vivek Gautam          2019-07-18  101  	u32 max_cap;
99356b03b431f9 Vivek Gautam          2019-07-18  102  	u32 priority;
99356b03b431f9 Vivek Gautam          2019-07-18  103  	bool fixed_size;
99356b03b431f9 Vivek Gautam          2019-07-18  104  	u32 bonus_ways;
99356b03b431f9 Vivek Gautam          2019-07-18  105  	u32 res_ways;
99356b03b431f9 Vivek Gautam          2019-07-18  106  	u32 cache_mode;
99356b03b431f9 Vivek Gautam          2019-07-18  107  	u32 probe_target_ways;
99356b03b431f9 Vivek Gautam          2019-07-18  108  	bool dis_cap_alloc;
99356b03b431f9 Vivek Gautam          2019-07-18  109  	bool retain_on_pc;
99356b03b431f9 Vivek Gautam          2019-07-18  110  	bool activate_on_init;
c4df37fe186de4 Manivannan Sadhasivam 2020-11-30  111  	bool write_scid_en;
2b8175a1f10836 Sai Prakash Ranjan    2022-01-28  112  	bool write_scid_cacheable_en;
c72ca343f911c3 Abel Vesa             2022-11-16  113  	bool stale_en;
c72ca343f911c3 Abel Vesa             2022-11-16  114  	bool stale_cap_en;
c72ca343f911c3 Abel Vesa             2022-11-16  115  	bool mru_uncap_en;
c72ca343f911c3 Abel Vesa             2022-11-16  116  	bool mru_rollover;
c72ca343f911c3 Abel Vesa             2022-11-16  117  	bool alloc_oneway_en;
c72ca343f911c3 Abel Vesa             2022-11-16  118  	bool ovcap_en;
c72ca343f911c3 Abel Vesa             2022-11-16  119  	bool ovcap_prio;
c72ca343f911c3 Abel Vesa             2022-11-16  120  	bool vict_prio;
99356b03b431f9 Vivek Gautam          2019-07-18 @121  };
99356b03b431f9 Vivek Gautam          2019-07-18  122  

:::::: The code at line 121 was first introduced by commit
:::::: 99356b03b431f9589bbaec2bc5bacceccb3dd99a soc: qcom: Make llcc-qcom a generic driver

:::::: TO: Vivek Gautam <vivek.gautam@codeaurora.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
