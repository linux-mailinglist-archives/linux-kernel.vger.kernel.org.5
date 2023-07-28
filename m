Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA23E76630D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjG1EVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjG1EVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:21:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA25213A;
        Thu, 27 Jul 2023 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690518070; x=1722054070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axtCPjMH56LxQvu3RxZjX4SqwclFfCZoVIAceqSd8dQ=;
  b=I4RdTxHcbI8y2NusOsrpPSQ4jvZ1kla5uA1Q/f8lz2ydI5wlaI0eiWML
   OrnmWFXmIrb3lC1EIzk/J/HV4TJH1KH8y1R1ys0ouexwVRQmLu4jFbbBc
   LSFycdOfAQ2DyZvNKqB1LmC48gg3qhqXptiBZ3E3vzjdOiLZ7EPD72xFd
   mvDKzTnDegKFUHpktqqTP5vT69Zk70FSD+hf/UECtQ3HdGhPHnFebcYpZ
   YxSGcDLIjVxNTspbJVXRJxP334WuYBtokwaMgf0PAsx+9qd14JpqjVLs7
   48OgYfCaKhHt7uno9hPqOS6jKicaWSRwxEkF2EwOqyCVnNW79v20FYRsS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454864426"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="454864426"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 21:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="756996065"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="756996065"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 21:21:07 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPEyQ-0002s4-2m;
        Fri, 28 Jul 2023 04:21:06 +0000
Date:   Fri, 28 Jul 2023 12:20:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matus Gajdos <matuszpd@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matus Gajdos <matuszpd@gmail.com>
Subject: Re: [PATCH 3/3] leds: Add Broadchip BCT3024 LED driver
Message-ID: <202307281212.NIwa5Cab-lkp@intel.com>
References: <20230727160525.23312-4-matuszpd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727160525.23312-4-matuszpd@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matus,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on lee-leds/for-leds-next linus/master v6.5-rc3 next-20230727]
[cannot apply to pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matus-Gajdos/dt-bindings-Add-vendor-prefix-for-Broadchip-Technology-Group-Co-Ltd/20230728-001607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230727160525.23312-4-matuszpd%40gmail.com
patch subject: [PATCH 3/3] leds: Add Broadchip BCT3024 LED driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230728/202307281212.NIwa5Cab-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281212.NIwa5Cab-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281212.NIwa5Cab-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:25,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/leds/leds-bct3024.c:8:
>> drivers/leds/leds-bct3024.c:538:28: error: 'bct3024_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
     538 |         SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:337:28: note: in definition of macro 'RUNTIME_PM_OPS'
     337 |         .runtime_suspend = suspend_fn, \
         |                            ^~~~~~~~~~
   drivers/leds/leds-bct3024.c:538:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     538 |         SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/leds/leds-bct3024.c:538:53: error: 'bct3024_runtime_resume' undeclared here (not in a function); did you mean 'pm_runtime_resume'?
     538 |         SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:338:27: note: in definition of macro 'RUNTIME_PM_OPS'
     338 |         .runtime_resume = resume_fn, \
         |                           ^~~~~~~~~
   drivers/leds/leds-bct3024.c:538:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     538 |         SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/leds/leds-bct3024.c:539:28: error: 'bct3024_runtime_idle' undeclared here (not in a function); did you mean 'pm_runtime_idle'?
     539 |                            bct3024_runtime_idle)
         |                            ^~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:339:25: note: in definition of macro 'RUNTIME_PM_OPS'
     339 |         .runtime_idle = idle_fn,
         |                         ^~~~~~~
   drivers/leds/leds-bct3024.c:538:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     538 |         SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
         |         ^~~~~~~~~~~~~~~~~~


vim +538 drivers/leds/leds-bct3024.c

   536	
   537	static const struct dev_pm_ops bct3024_pm_ops = {
 > 538		SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
 > 539				   bct3024_runtime_idle)
   540		SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
   541	};
   542	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
