Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66027EC69A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbjKOPCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbjKOPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:02:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32348121;
        Wed, 15 Nov 2023 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700060562; x=1731596562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1HqVu++Or5MPt2IsrGXLkZwksVda8ElGJ+dTFliEGaA=;
  b=eBQ9QIVNTUxKSzyuAOTkphku7Kd7j1/jqTk+rPsT3U5wU4h3B57QpduV
   6C8Ao7dizPlpE6a7kSNDnGINBWTVR9q8OeQ8j5DchDJpEi7mH25ktLx2H
   ApAitKQU2I1k01xlQdtW0M/vKWTzatntXyjrBhCvdnCI/ykzXMSrjNFhG
   y1kWJKLEFPe8WdYl2oTtpVSXbGGBFRmziguQAlc5zCdGhNPLSKQgXW01z
   rcpR3tUXQRzHEeLwkkWk8Q7aM+/NTU0qct1+Kc45TOVhNeiBmjqjFfSO8
   3/IyY7sFCY9NmNXUxSoQJSzgOfjk8UKT02MQ+CY+VvBG07ut22dJ2kPVv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="3970782"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="3970782"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:02:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="6195334"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Nov 2023 07:02:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3HPG-0000Qo-38;
        Wed, 15 Nov 2023 15:02:19 +0000
Date:   Wed, 15 Nov 2023 23:01:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, rafael@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] thermal: Add support for device tree thermal zones
 consumers
Message-ID: <202311152242.dch1tAh5-lkp@intel.com>
References: <20231114131514.89031-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114131514.89031-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/thermal-Add-support-for-device-tree-thermal-zones-consumers/20231114-211656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231114131514.89031-1-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH] thermal: Add support for device tree thermal zones consumers
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231115/202311152242.dch1tAh5-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311152242.dch1tAh5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311152242.dch1tAh5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/cpufreq.c:19:
   In file included from include/linux/cpu_cooling.h:17:
>> include/linux/thermal.h:281:29: warning: no previous prototype for function 'thermal_of_get_zone_by_index' [-Wmissing-prototypes]
   struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
                               ^
   include/linux/thermal.h:281:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
   ^
   static 
>> include/linux/thermal.h:286:29: warning: no previous prototype for function 'thermal_of_get_zone' [-Wmissing-prototypes]
   struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
                               ^
   include/linux/thermal.h:286:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
   ^
   static 
   2 warnings generated.


vim +/thermal_of_get_zone_by_index +281 include/linux/thermal.h

   280	
 > 281	struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
   282	{
   283		return ERR_PTR(-EOPNOTSUPP);
   284	}
   285	
 > 286	struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
   287	{
   288		return ERR_PTR(-EOPNOTSUPP);
   289	}
   290	#endif
   291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
