Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336867B28D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjI1XaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:30:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF4139;
        Thu, 28 Sep 2023 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695943815; x=1727479815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v2ds4YulUEFwf7eurxc1fXVnPOhX2AoXRA7TsEihdLU=;
  b=VUbWUMU5Jkr64DBYPmUAIchk6mH3b4Z34RL65KORIa6wevx3FcsFwpI6
   1rACF2JNY64R5zXtHLw3F5Blezpy24H8sgKUgTgkdC8x0i3WcjIQNkFcs
   cSV0Dy43Jk/QC/2QbY6NdveEtYBt1u71yOUVAKMUnAysNv2My2sRtYfXq
   AfD/XaLhokWcZCCVcZxOVX2wiuWNAByhnIcz2ESeSdzV94T5fQkMnEDh+
   Rm9NCZ8IM34nQQM1obMIPkFFeG5L56TIlyzAouQ0l8W+nBJwGgMaHV60s
   U3ZeyvaD6cT3orCnvGPmiy74GO3J7CpI/uV4ayUkBYwzsWCEMxeSeA5iQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="382098096"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="382098096"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 16:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="726418460"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="726418460"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Sep 2023 16:29:54 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qm0S8-000297-2A;
        Thu, 28 Sep 2023 23:29:52 +0000
Date:   Fri, 29 Sep 2023 07:29:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <202309290756.MgmIdaDl-lkp@intel.com>
References: <20230928125443.615006-2-mitrutzceclan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928125443.615006-2-mitrutzceclan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dumitru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dumitru-Ceclan/iio-adc-ad7173-add-AD7173-driver/20230928-205802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230928125443.615006-2-mitrutzceclan%40gmail.com
patch subject: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290756.MgmIdaDl-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290756.MgmIdaDl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290756.MgmIdaDl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7173.c:829:23: warning: initialization of 'long unsigned int' from 'const struct ad7173_device_info *' makes integer from pointer without a cast [-Wint-conversion]
     829 |         { "ad7172-2", &ad7173_device_info[ID_AD7172_2], },
         |                       ^
   drivers/iio/adc/ad7173.c:829:23: note: (near initialization for 'ad7173_id_table[0].driver_data')
   drivers/iio/adc/ad7173.c:830:23: warning: initialization of 'long unsigned int' from 'const struct ad7173_device_info *' makes integer from pointer without a cast [-Wint-conversion]
     830 |         { "ad7173-8", &ad7173_device_info[ID_AD7173_8], },
         |                       ^
   drivers/iio/adc/ad7173.c:830:23: note: (near initialization for 'ad7173_id_table[1].driver_data')
   drivers/iio/adc/ad7173.c:831:23: warning: initialization of 'long unsigned int' from 'const struct ad7173_device_info *' makes integer from pointer without a cast [-Wint-conversion]
     831 |         { "ad7175-2", &ad7173_device_info[ID_AD7175_2], },
         |                       ^
   drivers/iio/adc/ad7173.c:831:23: note: (near initialization for 'ad7173_id_table[2].driver_data')
   drivers/iio/adc/ad7173.c:832:23: warning: initialization of 'long unsigned int' from 'const struct ad7173_device_info *' makes integer from pointer without a cast [-Wint-conversion]
     832 |         { "ad7176-2", &ad7173_device_info[ID_AD7176_2], },
         |                       ^
   drivers/iio/adc/ad7173.c:832:23: note: (near initialization for 'ad7173_id_table[3].driver_data')


vim +829 drivers/iio/adc/ad7173.c

   827	
   828	static const struct spi_device_id ad7173_id_table[] = {
 > 829		{ "ad7172-2", &ad7173_device_info[ID_AD7172_2], },
   830		{ "ad7173-8", &ad7173_device_info[ID_AD7173_8], },
   831		{ "ad7175-2", &ad7173_device_info[ID_AD7175_2], },
   832		{ "ad7176-2", &ad7173_device_info[ID_AD7176_2], },
   833		{ },
   834	};
   835	MODULE_DEVICE_TABLE(spi, ad7173_id_table);
   836	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
