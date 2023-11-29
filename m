Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5587FE409
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbjK2XKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjK2XKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:10:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D283D5E;
        Wed, 29 Nov 2023 15:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701299425; x=1732835425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wAisHvcC6UE6L2dy6Apps3oV2ZTlJuG1aYg+w33NB3A=;
  b=CUcl0Ii/hvAiy49F0G13FKYGcwTNG3jT7HrcUGyWU+sOr0lXElahAY6k
   14Zg/K9FUVZNNjeTPcpXH30O3spm6Qu7jyUcQTjYkSh0CZbT+sa5iAJO8
   D15zFReOXr6oktMpnBmmmncyvKreQ/0jOg128Qf9HSDn9r2dwT5yzm0mE
   qN38QBSF2eQ0jrJPixP8NPHhciodug9U4b8fv8CgYIWsuhj90aCVSgg5r
   gZGU4g2iMLBUHjF5lPbpFJthwL/mVYgOHzXBQ4tsNkBs9UAdSqA6t7Xy2
   ILsWJCwsfPe+azBv6j0Gf5HrBWtZFcIV4rRCEz7HiEwyWIj3HmzQojQjR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="383637558"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="383637558"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892609109"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="892609109"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2023 15:10:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8ThB-00013u-33;
        Wed, 29 Nov 2023 23:10:17 +0000
Date:   Thu, 30 Nov 2023 07:09:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] i2c: stm32f7: add support for stm32mp25 soc
Message-ID: <202311300357.qiYAoEvz-lkp@intel.com>
References: <20231129125920.1702497-5-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129125920.1702497-5-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on atorgue-stm32/stm32-next robh/for-next linus/master v6.7-rc3 next-20231129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alain-Volmat/i2c-stm32f7-perform-most-of-irq-job-in-threaded-handler/20231129-210806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
patch link:    https://lore.kernel.org/r/20231129125920.1702497-5-alain.volmat%40foss.st.com
patch subject: [PATCH 4/7] i2c: stm32f7: add support for stm32mp25 soc
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231130/202311300357.qiYAoEvz-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300357.qiYAoEvz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300357.qiYAoEvz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-stm32f7.c:2029:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (i2c_dev->setup.fmp_cr1_bit) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-stm32f7.c:2044:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/i2c/busses/i2c-stm32f7.c:2029:2: note: remove the 'if' if its condition is always false
           if (i2c_dev->setup.fmp_cr1_bit) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-stm32f7.c:2022:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +2029 drivers/i2c/busses/i2c-stm32f7.c

  2018	
  2019	static int stm32f7_i2c_write_fm_plus_bits(struct stm32f7_i2c_dev *i2c_dev,
  2020						  bool enable)
  2021	{
  2022		int ret;
  2023	
  2024		if (i2c_dev->bus_rate <= I2C_MAX_FAST_MODE_FREQ ||
  2025		    (!i2c_dev->setup.fmp_cr1_bit && IS_ERR_OR_NULL(i2c_dev->regmap)))
  2026			/* Optional */
  2027			return 0;
  2028	
> 2029		if (i2c_dev->setup.fmp_cr1_bit) {
  2030			if (enable)
  2031				stm32f7_i2c_set_bits(i2c_dev->base + STM32F7_I2C_CR1, STM32_I2C_CR1_FMP);
  2032			else
  2033				stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1, STM32_I2C_CR1_FMP);
  2034		} else {
  2035			if (i2c_dev->fmp_sreg == i2c_dev->fmp_creg)
  2036				ret = regmap_update_bits(i2c_dev->regmap, i2c_dev->fmp_sreg,
  2037							 i2c_dev->fmp_mask, enable ? i2c_dev->fmp_mask : 0);
  2038			else
  2039				ret = regmap_write(i2c_dev->regmap,
  2040						   enable ? i2c_dev->fmp_sreg : i2c_dev->fmp_creg,
  2041						   i2c_dev->fmp_mask);
  2042		}
  2043	
  2044		return ret;
  2045	}
  2046	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
