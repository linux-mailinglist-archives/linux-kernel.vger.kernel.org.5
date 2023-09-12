Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2971C79D15B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjILMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjILMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:45:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6899F;
        Tue, 12 Sep 2023 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694522740; x=1726058740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JORVoShSUssYanYhIK2ak04tDR05aXZaMKTmOofr+wI=;
  b=MAdOONp60NzrnvWf/V1Nj2g1LJHREXPKt4HiVu7cP/vIfsUlF3mBjcpB
   IvFu4/MSyphL8aztnZ1lFPoIhZcHt4YTGWi1WiNKuCb6lZ2mlLzq7sBS3
   no957EIYv/Bu82lMNSZaLIFAXWBSM4HRz8ZT5ngyQyPrggm7u97+uTmaO
   EJmyknjIRurhXgSQu24TbIK1mJzaNLiXeG+7HkbTBn0i00c+i70Zne3uB
   pTaq7Q2xf1ypXTPiWWBPNslDAzirVOG3H7fZ+s3ROTYAI+5ers1/Rs0Z7
   nCcqGvwjARNsWmJJbQGiGgxQkf9O6WLettnrsJJdJ0xEH/e5TH069unBa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378274607"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378274607"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858797210"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858797210"
Received: from lkp-server02.sh.intel.com (HELO 1e56c5165d33) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 05:45:37 -0700
Received: from kbuild by 1e56c5165d33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg2lr-0000Nl-0H;
        Tue, 12 Sep 2023 12:45:35 +0000
Date:   Tue, 12 Sep 2023 20:45:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: Re: [PATCH v2 09/10] hwrng: stm32 - rework power management sequences
Message-ID: <202309122017.GsJspucF-lkp@intel.com>
References: <20230911120203.774632-10-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911120203.774632-10-gatien.chevallier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gatien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on atorgue-stm32/stm32-next]
[also build test WARNING on robh/for-next herbert-crypto-2.6/master herbert-cryptodev-2.6/master linus/master v6.6-rc1 next-20230912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gatien-Chevallier/dt-bindings-rng-introduce-new-compatible-for-STM32MP13x/20230912-051851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20230911120203.774632-10-gatien.chevallier%40foss.st.com
patch subject: [PATCH v2 09/10] hwrng: stm32 - rework power management sequences
config: arm64-randconfig-r003-20230912 (https://download.01.org/0day-ci/archive/20230912/202309122017.GsJspucF-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309122017.GsJspucF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309122017.GsJspucF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/hw_random/stm32-rng.c:472:21: warning: attribute declaration must precede definition [-Wignored-attributes]
     472 | static const struct __maybe_unused dev_pm_ops stm32_rng_pm_ops = {
         |                     ^
   include/linux/compiler_attributes.h:344:56: note: expanded from macro '__maybe_unused'
     344 | #define __maybe_unused                  __attribute__((__unused__))
         |                                                        ^
   include/linux/pm.h:286:8: note: previous definition is here
     286 | struct dev_pm_ops {
         |        ^
   1 warning generated.


vim +472 drivers/char/hw_random/stm32-rng.c

   471	
 > 472	static const struct __maybe_unused dev_pm_ops stm32_rng_pm_ops = {
   473		SET_RUNTIME_PM_OPS(stm32_rng_runtime_suspend,
   474				   stm32_rng_runtime_resume, NULL)
   475		SET_SYSTEM_SLEEP_PM_OPS(stm32_rng_suspend,
   476					stm32_rng_resume)
   477	};
   478	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
