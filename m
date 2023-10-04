Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739527B971C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjJDWDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJDWDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:03:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8FBD;
        Wed,  4 Oct 2023 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696457019; x=1727993019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9cBg1srJbGdmQ36/Me/28e8gGP+MspxyR+FDEJ6Nxl0=;
  b=aGA2Ju/deTtMVZ4h8b3F4TRnCyhxv2kwcOL0AJ3zzpxNSgcAiYj5S9zX
   p0UW31kDhaoze+b41Rmp6yf+pbneL0cEnrkVCYb6VqftdUEy9PlKN0oII
   4usv6h5Vcjnrm98oD4g4DK+LK0XAgjEra404f1TSMzOxWyf4ld0Dxz6a2
   3kLWOeygnDitT26qKtzORGdKjcjE6PYy+glJ5dAO9JLTHAsEcLZp7qEUX
   nPj9HSv9lPXHgrNL92X8xovqa6Qz3Wgd5/7V5NNjE6Pg2/gwvHtfg9lHj
   OPXSxaV+4aaZ1qtIQr5zbXRhgyJOtsGf+qIn+FTPyb7cuxbnVxk/m2JPN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="368380951"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="368380951"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="817302103"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="817302103"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2023 15:03:33 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qo9xr-000Kex-1d;
        Wed, 04 Oct 2023 22:03:31 +0000
Date:   Thu, 5 Oct 2023 06:02:51 +0800
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
Message-ID: <202310050520.VEIzHNiM-lkp@intel.com>
References: <20230928125443.615006-2-mitrutzceclan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928125443.615006-2-mitrutzceclan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dumitru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.6-rc4 next-20231004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dumitru-Ceclan/iio-adc-ad7173-add-AD7173-driver/20230928-205802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230928125443.615006-2-mitrutzceclan%40gmail.com
patch subject: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
config: i386-randconfig-063-20231005 (https://download.01.org/0day-ci/archive/20231005/202310050520.VEIzHNiM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050520.VEIzHNiM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050520.VEIzHNiM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad7173.c:829:42: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] driver_data @@     got struct ad7173_device_info const * @@
   drivers/iio/adc/ad7173.c:829:42: sparse:     expected unsigned long [usertype] driver_data
   drivers/iio/adc/ad7173.c:829:42: sparse:     got struct ad7173_device_info const *
   drivers/iio/adc/ad7173.c:830:42: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] driver_data @@     got struct ad7173_device_info const * @@
   drivers/iio/adc/ad7173.c:830:42: sparse:     expected unsigned long [usertype] driver_data
   drivers/iio/adc/ad7173.c:830:42: sparse:     got struct ad7173_device_info const *
   drivers/iio/adc/ad7173.c:831:42: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] driver_data @@     got struct ad7173_device_info const * @@
   drivers/iio/adc/ad7173.c:831:42: sparse:     expected unsigned long [usertype] driver_data
   drivers/iio/adc/ad7173.c:831:42: sparse:     got struct ad7173_device_info const *
   drivers/iio/adc/ad7173.c:832:42: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] driver_data @@     got struct ad7173_device_info const * @@
   drivers/iio/adc/ad7173.c:832:42: sparse:     expected unsigned long [usertype] driver_data
   drivers/iio/adc/ad7173.c:832:42: sparse:     got struct ad7173_device_info const *

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
