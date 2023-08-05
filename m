Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43C77100C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjHEOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:02:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B6113
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691244156; x=1722780156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=os3qsMhMS5h3IELSLLEkYnXpa00SVVtZaZivAJC23zU=;
  b=d/5GfxXQ5PATwv9fORfCjY159vVd9W3c+J2witk2fWZ7Cxzu4A8AT3dt
   6hDpyEYo8jdSWreoNLTfAk0TLgo7h/t3y86vMhX5UJtBYqkqz5n9zG+op
   OGg3CQCZ6Km3Y3tg+g+/u9H4amzmTHa1fDuCqNEWnHOh1TYpT22PqYPO9
   ZIVCU2ZJqhGxMdzvqfYYoMcAN8lBDBV+N5wkWDRAZRF4kWUc06aGbuGJD
   2f7S1z3rq5PgG0inOx+FrPW6YEYGeXAzVfR8VvqrLVf12fxsGOeSSaZd1
   K3nahlM6EBbPr4V+BRmFKctA7sWyEVkPLBeH9wnn20I5CcaFflvDVJWWT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="355246064"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="355246064"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 07:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="759942161"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="759942161"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Aug 2023 07:02:32 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSHrT-0003Xt-2l;
        Sat, 05 Aug 2023 14:02:31 +0000
Date:   Sat, 5 Aug 2023 22:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] coresight: trbe: Enable ACPI based TRBE devices
Message-ID: <202308052123.uqR35d19-lkp@intel.com>
References: <20230728112733.359620-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728112733.359620-4-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next soc/for-next linus/master arm/fixes v6.5-rc4 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm_pmu-acpi-Add-a-representative-platform-device-for-TRBE/20230728-192939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230728112733.359620-4-anshuman.khandual%40arm.com
patch subject: [PATCH 3/3] coresight: trbe: Enable ACPI based TRBE devices
config: arm64-randconfig-r021-20230731 (https://download.01.org/0day-ci/archive/20230805/202308052123.uqR35d19-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308052123.uqR35d19-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308052123.uqR35d19-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-trbe.c:1549:14: error: use of undeclared identifier 'arm_trbe_acpi_match'; did you mean 'arm_trbe_of_match'?
           .id_table = arm_trbe_acpi_match,
                       ^~~~~~~~~~~~~~~~~~~
                       arm_trbe_of_match
   drivers/hwtracing/coresight/coresight-trbe.c:1534:34: note: 'arm_trbe_of_match' declared here
   static const struct of_device_id arm_trbe_of_match[] = {
                                    ^
>> drivers/hwtracing/coresight/coresight-trbe.c:1549:14: error: incompatible pointer types initializing 'const struct platform_device_id *' with an expression of type 'const struct of_device_id[2]' [-Werror,-Wincompatible-pointer-types]
           .id_table = arm_trbe_acpi_match,
                       ^~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +1549 drivers/hwtracing/coresight/coresight-trbe.c

  1547	
  1548	static struct platform_driver arm_trbe_driver = {
> 1549		.id_table = arm_trbe_acpi_match,
  1550		.driver	= {
  1551			.name = DRVNAME,
  1552			.of_match_table = of_match_ptr(arm_trbe_of_match),
  1553			.suppress_bind_attrs = true,
  1554		},
  1555		.probe	= arm_trbe_device_probe,
  1556		.remove	= arm_trbe_device_remove,
  1557	};
  1558	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
