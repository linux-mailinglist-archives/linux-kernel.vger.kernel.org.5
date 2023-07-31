Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44BA76972F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjGaNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjGaNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:07:48 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641AF1FD7;
        Mon, 31 Jul 2023 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690808833; x=1722344833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dxI4YScDLo8YpeDgT4DDfRErG18F4mdrsXlfYWF5Ri0=;
  b=m1Da1eb93WmmvLXy4/VJkk9UZwtyc7I/r2gbOjanrxiLy4akDvqVF0Vv
   ld6r398oRxDrxKrU2r+pZQwekQMbzKAlEs8bro0/Wa5WFO6mckzS5km5G
   sCejbvOnT5PnqPblLA5m3BgYpxmFWiMKjNkmXbiRr6aKwJeoSgGLsIPAQ
   km7gHUl7U2knEVDuk5oIByVqi/Ss9uGzkeXEN/hp0DSZ6gRIJgS5Pfcqq
   VPNTo7xE5Q0/XsDNUxZr/QhUMms+KkqdaVE+cBzaI6D+A5HU51sts1+LU
   d+t5L1co+hsHBh2m0G7ltBEnSTGjtzdptupGA/6dWUNwnM0Rey9zE8XAM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366495603"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="366495603"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678334713"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678334713"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 06:06:44 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQSbS-00057z-1S;
        Mon, 31 Jul 2023 13:06:29 +0000
Date:   Mon, 31 Jul 2023 21:06:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
        herbert@gondor.apana.org.au, jiajie.ho@starfivetech.com,
        conor.dooley@microchip.com, martin@kaiser.cx, mmyangfl@gmail.com,
        jenny.zhang@starfivetech.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, leoliu@zhaoxin.com,
        CobeChen@zhaoxin.com, YunShen@zhaoxin.com, TonyWWang@zhaoxin.com,
        leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: Re: [PATCH v2 2/2] hwrng: add Zhaoxin HW RNG driver
Message-ID: <202307312040.d5kTGcBX-lkp@intel.com>
References: <20230731084515.2057375-3-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731084515.2057375-3-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.5-rc4 next-20230731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-via-rng-convert-to-x86_cpu_id-probing/20230731-164950
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230731084515.2057375-3-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v2 2/2] hwrng: add Zhaoxin HW RNG driver
config: openrisc-randconfig-r003-20230731 (https://download.01.org/0day-ci/archive/20230731/202307312040.d5kTGcBX-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307312040.d5kTGcBX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307312040.d5kTGcBX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/hw_random/zhaoxin-rng.c:16:10: fatal error: asm/cpu_device_id.h: No such file or directory
      16 | #include <asm/cpu_device_id.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +16 drivers/char/hw_random/zhaoxin-rng.c

  > 16	#include <asm/cpu_device_id.h>
    17	#include <asm/fpu/api.h>
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
