Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5844878F9BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjIAIOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIAIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:14:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7701716;
        Fri,  1 Sep 2023 01:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693556010; x=1725092010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YJ39tTp+W0OBBT/IzTeRIk/6zYS/Rax4UcI4jk27fqY=;
  b=aAPg6U1z6ug+konT2TnGYs3sYwPelbWlPjnCAbx/PdmpPRirNFKtCs1J
   9GA2gEx4r+6/aWlbT8/j8Ujjw+H3tTXzu0R0CwhJRitsI88nKIp5RldYj
   FW4S69ELyNHv7ecOWynKUpy9X7Sd6t2hRguKLx1grUclN78IlUVXAr/iF
   EL3sCg6yehKnUbTq2566XIaVFtqPOIsmVRLZhGjHwrr0lkTMvuj7ALgUO
   fUdko3p6no34DKRRF8qRFZFtthlRBw4m4z1P+4K7RDoRr62iSO1w4LmX1
   cIQZH4CV8V1qOoG54wTvvezS706/kNn/hFIdv1Ok7PzquB30MSIcedeQi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375068234"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="375068234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883102204"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="883102204"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2023 01:12:34 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbzGX-00015r-0X;
        Fri, 01 Sep 2023 08:12:29 +0000
Date:   Fri, 1 Sep 2023 16:11:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        zev@bewilderbeest.net,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] regulator (max5970): Add hwmon support
Message-ID: <202309011524.JIWSmpfT-lkp@intel.com>
References: <20230830111319.3882281-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830111319.3882281-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 35d0d2350d774fecf596cfb2fb050559fe5e1850]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-max5970-Add-hwmon-support/20230831-035843
base:   35d0d2350d774fecf596cfb2fb050559fe5e1850
patch link:    https://lore.kernel.org/r/20230830111319.3882281-1-Naresh.Solanki%409elements.com
patch subject: [PATCH] regulator (max5970): Add hwmon support
config: x86_64-buildonly-randconfig-001-20230901 (https://download.01.org/0day-ci/archive/20230901/202309011524.JIWSmpfT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309011524.JIWSmpfT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309011524.JIWSmpfT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_hwmon_device_register_with_info
   >>> referenced by max5970-regulator.c
   >>>               drivers/regulator/max5970-regulator.o:(max597x_regulator_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
