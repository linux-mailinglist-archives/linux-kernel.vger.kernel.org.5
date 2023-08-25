Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819CF788F54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjHYTrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHYTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:47:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B562684;
        Fri, 25 Aug 2023 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692992826; x=1724528826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NnTF+jRylX6pqFhPQQzonaRAuTlvz5MKVdA6jmYJrOw=;
  b=DBIrmIeAzdD3Rv2YhYLC/7XPLiCoZpfxfbG9mUiNEI0r6xYglOJPlAgp
   oEUPon+8vF6nB/gtOv6pOOzIlv91F4hK6xwnUhl98m9rVROj6x70/lAqa
   XvwYCp4zXsol9WFgvimi3KraN+H3uNGpHD3zc7lTCi90Nc1q6ox1VGflt
   cPyTVurAPBSLokmblxpiQxPdc2R3pQgV3cHMLSahBITv4baDzAs0YyZDq
   NhmQ9wguOVS6LKprnAHD1W5iPej6CBhDLE6xl6AE25GVY4d2RNEDDk3UW
   rhbAmnGCJhHjfmZWcbJcSJXnSJCFvfP5s3YcdTHTr0Pbf+2kNWYtHU/LT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461153550"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="461153550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 12:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807637391"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="807637391"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2023 12:47:02 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZclq-0003xd-0U;
        Fri, 25 Aug 2023 19:47:02 +0000
Date:   Sat, 26 Aug 2023 03:46:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add ltc2309 support
Message-ID: <202308260324.RYZ1IVWw-lkp@intel.com>
References: <20230825-ltc2309-v2-2-6d75f2b3fb50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-ltc2309-v2-2-6d75f2b3fb50@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a5e505a99ca748583dbe558b691be1b26f05d678]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-Beguin/dt-bindings-iio-adc-add-lltc-ltc2309-bindings/20230826-022412
base:   a5e505a99ca748583dbe558b691be1b26f05d678
patch link:    https://lore.kernel.org/r/20230825-ltc2309-v2-2-6d75f2b3fb50%40gmail.com
patch subject: [PATCH v2 2/2] iio: adc: add ltc2309 support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230826/202308260324.RYZ1IVWw-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260324.RYZ1IVWw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260324.RYZ1IVWw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ltc2309.c:163:6: warning: no previous prototype for 'ltc2309_regulator_disable' [-Wmissing-prototypes]
     163 | void ltc2309_regulator_disable(void *regulator)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ltc2309_regulator_disable +163 drivers/iio/adc/ltc2309.c

   162	
 > 163	void ltc2309_regulator_disable(void *regulator)
   164	{
   165		struct regulator *r = (struct regulator *)regulator;
   166	
   167		regulator_disable(r);
   168	}
   169	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
