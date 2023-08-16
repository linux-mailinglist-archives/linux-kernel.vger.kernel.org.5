Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4C77E343
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjHPOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343553AbjHPOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:09:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908FA272E;
        Wed, 16 Aug 2023 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692194949; x=1723730949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rXIvn7ntMx76r7mOiVD3Xshd7gBZ900TQnREESXho9w=;
  b=lCg7fsL+hTlG4AQZXfMH9/iAMcXea9bN8wl3C7sO/4Oo41Zy0dT7UINQ
   gPyAeVNGQElY90aCmZLRA83xi/t9NtO1BRaQbQx2wGbvzo00XcqmSCNZG
   IFgAfk4A1ZiNcOGwo+z8UkEVvziBH8wJH2N1IjYv8EELKkEieDL0Gatce
   6cNMJhAn8Exx74xjEXnQ1mRyGFPOZe3G/wh0VILxZ6TMGtdRTSlsTGnLK
   GuN9DtBhHAeQcDFlk8US38goF3f1FLHHiTHS8AzzTalFUYZuWPnRcz0dl
   x2GMQN0YjPSzj3NP96dXvvfu6q1Y/NEgiJc2uXt9Ljc2QNkiX1LAeKAg5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375312516"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="375312516"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980752908"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980752908"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 07:07:58 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWHBm-0000MT-0F;
        Wed, 16 Aug 2023 14:07:58 +0000
Date:   Wed, 16 Aug 2023 22:07:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mingjin Yang <mingjin.yang@unisoc.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, mingjin.yang@unisoc.com,
        magicyangmingjin@gmail.com, Ling_Ling.Xu@unisoc.com,
        Jinfeng.Lin1@unisoc.com, Yangbin.Li@unisoc.com,
        Jiansheng.Wu@unisoc.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V0 2/2] iio: adc: sprd_pmic_adc: Add support for UMP
 serise pmic adc
Message-ID: <202308162143.UjXhwiRf-lkp@intel.com>
References: <20230816080225.21482-3-mingjin.yang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816080225.21482-3-mingjin.yang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingjin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.5-rc6 next-20230816]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mingjin-Yang/dt-bindings-iio-adc-Add-support-for-ump518-pmic-adc/20230816-160754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230816080225.21482-3-mingjin.yang%40unisoc.com
patch subject: [PATCH V0 2/2] iio: adc: sprd_pmic_adc: Add support for UMP serise pmic adc
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230816/202308162143.UjXhwiRf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308162143.UjXhwiRf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308162143.UjXhwiRf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/sprd_pmic_adc.c: In function 'ump9620_ch_data_init':
>> drivers/iio/adc/sprd_pmic_adc.c:530:1: warning: the frame size of 1320 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     530 | }
         | ^


vim +530 drivers/iio/adc/sprd_pmic_adc.c

   506	
   507	static void ump9620_ch_data_init(struct sprd_adc_data *data)
   508	{
   509		struct sprd_adc_channel_data ch_data_def = CH_DATA_INIT(SCALE_00, 0, 0, RATIO_DEF);
   510		struct sprd_adc_channel_data ch_data[SPRD_ADC_CHANNEL_MAX] = {
   511			[0] = CH_DATA_INIT(SCALE_01, 0, 0, RATIO_DEF),
   512			[5] = CH_DATA_INIT(SCALE_00, 0x1, 0x9, RATIO_DEF),
   513			[6] = CH_DATA_INIT(SCALE_00, 0x1, 0x9, RATIO_DEF),
   514			[7] = CH_DATA_INIT(SCALE_10, 0, 0, RATIO_DEF),
   515			[9] = CH_DATA_INIT(SCALE_10, 0, 0, RATIO_DEF),
   516			[10] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
   517			[11] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO_DEF),
   518			[13] = CH_DATA_INIT(SCALE_01, 0, 0, RATIO_DEF),
   519			[14] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(68, 900)),
   520			[15] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(1, 3)),
   521			[19] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
   522			[21] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
   523			[22] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
   524			[23] = CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
   525			[30] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
   526			[31] = CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
   527		};
   528	
   529		sprd_adc_ch_data_merge(data, ch_data, &ch_data_def);
 > 530	}
   531	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
