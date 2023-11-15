Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A27EC613
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbjKOOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344404AbjKOOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:43:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1891BDF;
        Wed, 15 Nov 2023 06:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700059329; x=1731595329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOd8brVgrcyzV87kIfZ0CKvFJZubqUN4ZgVoBmKvJPk=;
  b=R5glUNBvdEVGKO6XEoFmrF6BYv5LHGG+Z9iKFiUblP6P7LAjnpEyZZe4
   X9dT4f8wXNJOyVKE8L8rUmtTPhQxWkFW0M7wrj3nj1D1tq53V9mOBTIRs
   EgDyLg6fzUfNE+oETTUxGmAdHJfvuaZW/rvEIuTIS0HviY6gMHCsIqJpe
   ZDJwrKQeK0AV1CgYapAtPIk9EFtXdG+HmYTmN4EypjevmE0p/WuDwqWWE
   cSPvLXv06Ze3Az897XPsD0LNFk8h97etjN+hmOo5FKcIQCjTZDjgeWZUI
   UAsHD9Ol9EPsWUMHnxWThiuvqlAjvrZ3tptjkk3994AXYW6G/1/FmbVE+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371073850"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="371073850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 06:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="908797967"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="908797967"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2023 06:38:55 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3H2b-0000PU-1p;
        Wed, 15 Nov 2023 14:38:53 +0000
Date:   Wed, 15 Nov 2023 22:37:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] thermal: Add support for device tree thermal zones
 consumers
Message-ID: <202311152230.nzJVHaeG-lkp@intel.com>
References: <20231114131514.89031-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114131514.89031-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/thermal-Add-support-for-device-tree-thermal-zones-consumers/20231114-211656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231114131514.89031-1-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH] thermal: Add support for device tree thermal zones consumers
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20231115/202311152230.nzJVHaeG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311152230.nzJVHaeG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311152230.nzJVHaeG-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/acpi/cppc.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: arch/x86/kernel/acpi/cppc.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: arch/x86/kernel/acpi/cstate.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: arch/x86/kernel/acpi/cstate.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/idle/intel_idle.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/idle/intel_idle.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/acpi_processor.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/acpi_processor.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/processor_core.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/processor_core.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/processor_pdc.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/processor_pdc.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/fan_core.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/fan_core.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/processor_driver.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/processor_driver.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/processor_thermal.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/processor_thermal.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/processor_idle.o: in function `thermal_of_get_zone_by_index':
>> include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/processor_idle.o: in function `thermal_of_get_zone':
>> include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/processor_throttling.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/processor_throttling.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/processor_perflib.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/processor_perflib.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/thermal.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/thermal.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/acpi/cppc_acpi.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/acpi/cppc_acpi.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/power/supply/power_supply_core.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/power/supply/power_supply_core.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/hwmon/hwmon.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/hwmon/hwmon.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/thermal_core.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/thermal_core.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/thermal_sysfs.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/thermal_sysfs.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/thermal_trip.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/thermal_trip.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/thermal_helpers.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/thermal_helpers.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/thermal_hwmon.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/thermal_hwmon.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/thermal_acpi.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/thermal_acpi.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/gov_fair_share.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/gov_fair_share.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/gov_bang_bang.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/gov_bang_bang.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/gov_step_wise.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/gov_step_wise.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/thermal/gov_user_space.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/thermal/gov_user_space.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/cpufreq/cpufreq.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/cpufreq/cpufreq.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here
   ld: drivers/cpufreq/intel_pstate.o: in function `thermal_of_get_zone_by_index':
   include/linux/thermal.h:282: multiple definition of `thermal_of_get_zone_by_index'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:282: first defined here
   ld: drivers/cpufreq/intel_pstate.o: in function `thermal_of_get_zone':
   include/linux/thermal.h:287: multiple definition of `thermal_of_get_zone'; arch/x86/kernel/acpi/boot.o:include/linux/thermal.h:287: first defined here


vim +282 include/linux/thermal.h

   280	
   281	struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
 > 282	{
   283		return ERR_PTR(-EOPNOTSUPP);
   284	}
   285	
   286	struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
 > 287	{
   288		return ERR_PTR(-EOPNOTSUPP);
   289	}
   290	#endif
   291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
