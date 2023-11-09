Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476397E7051
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbjKIRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKIRbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:31:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410861991
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551094; x=1731087094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0O197kK4A+k+7fNW3ewE6V7xrfZeNaL2neDGXPiZc4M=;
  b=Si9mNfj9PX6i1HBFsb2CcqdvfME5+vjY/dI3lK22ZoUSApHQz9n4IWDB
   4ZcS06K/fju5JluBo+EgFbbsTrirCYNXEY08mDByAh+fDJ6k6zly7xcGJ
   rkjZvZtTh97HbN0j74iR1Or74cVJJ3hkxu84dGVfGh9fkUHYUe8/b/5bs
   eoEmY8nMA4XG0R7zQCIfv/kl3OaBNw6KwwpPvIBj4Qg6z1IWcpBLttN28
   DPIsMijPj+VPF56JvqPwdNrIxoyPOlogQ4qT1iNlKgAN0I0XXCSktBMH5
   feTGxEXbcofs16/fi9tR68xC1k8Qtvzdps6eS3lJ6ozH5x7VdeTn8YqEO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454337079"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="454337079"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4786901"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Nov 2023 09:31:32 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r18sL-0008yw-2J;
        Thu, 09 Nov 2023 17:31:29 +0000
Date:   Fri, 10 Nov 2023 01:27:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/power/supply/pmu_battery.c:171:50: warning: '%d' directive
 writing between 1 and 11 bytes into a region of size 4
Message-ID: <202311100157.2Kn3gHLg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 2edb16efc899f9c232e2d880930b855e4cf55df4 powerpc/32: Add KASAN support
date:   4 years, 6 months ago
config: powerpc-randconfig-r031-20211015 (https://download.01.org/0day-ci/archive/20231110/202311100157.2Kn3gHLg-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100157.2Kn3gHLg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100157.2Kn3gHLg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/power/supply/pmu_battery.c: In function 'pmu_bat_init':
>> drivers/power/supply/pmu_battery.c:171:50: warning: '%d' directive writing between 1 and 11 bytes into a region of size 4 [-Wformat-overflow=]
     171 |                 sprintf(pbat->name, "PMU_battery_%d", i);
         |                                                  ^~
   drivers/power/supply/pmu_battery.c:171:37: note: directive argument in the range [-2147483643, 2147483646]
     171 |                 sprintf(pbat->name, "PMU_battery_%d", i);
         |                                     ^~~~~~~~~~~~~~~~
   drivers/power/supply/pmu_battery.c:171:17: note: 'sprintf' output between 14 and 24 bytes into a destination of size 16
     171 |                 sprintf(pbat->name, "PMU_battery_%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +171 drivers/power/supply/pmu_battery.c

efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  145  
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  146  static int __init pmu_bat_init(void)
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  147  {
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  148  	int ret = 0;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  149  	int i;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  150  
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  151  	bat_pdev = platform_device_register_simple("pmu-battery",
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  152  						   0, NULL, 0);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  153  	if (IS_ERR(bat_pdev)) {
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  154  		ret = PTR_ERR(bat_pdev);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  155  		goto pdev_register_failed;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  156  	}
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  157  
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  158  	pmu_ac = power_supply_register(&bat_pdev->dev, &pmu_ac_desc, NULL);
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  159  	if (IS_ERR(pmu_ac)) {
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  160  		ret = PTR_ERR(pmu_ac);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  161  		goto ac_register_failed;
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  162  	}
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  163  
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  164  	for (i = 0; i < pmu_battery_count; i++) {
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  165  		struct power_supply_config psy_cfg = {};
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  166  		struct pmu_battery_dev *pbat = kzalloc(sizeof(*pbat),
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  167  						       GFP_KERNEL);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  168  		if (!pbat)
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  169  			break;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  170  
35bf559145b633 drivers/power/pmu_battery.c Christian Kujau     2008-05-02 @171  		sprintf(pbat->name, "PMU_battery_%d", i);
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  172  		pbat->bat_desc.name = pbat->name;
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  173  		pbat->bat_desc.properties = pmu_bat_props;
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  174  		pbat->bat_desc.num_properties = ARRAY_SIZE(pmu_bat_props);
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  175  		pbat->bat_desc.get_property = pmu_bat_get_property;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  176  		pbat->pbi = &pmu_batteries[i];
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  177  		psy_cfg.drv_data = pbat;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  178  
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  179  		pbat->bat = power_supply_register(&bat_pdev->dev,
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  180  						  &pbat->bat_desc,
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  181  						  &psy_cfg);
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  182  		if (IS_ERR(pbat->bat)) {
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  183  			ret = PTR_ERR(pbat->bat);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  184  			kfree(pbat);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  185  			goto battery_register_failed;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  186  		}
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  187  		pbats[i] = pbat;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  188  	}
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  189  
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  190  	goto success;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  191  
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  192  battery_register_failed:
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  193  	while (i--) {
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  194  		if (!pbats[i])
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  195  			continue;
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  196  		power_supply_unregister(pbats[i]->bat);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  197  		kfree(pbats[i]);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  198  	}
297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  199  	power_supply_unregister(pmu_ac);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  200  ac_register_failed:
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  201  	platform_device_unregister(bat_pdev);
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  202  pdev_register_failed:
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  203  success:
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  204  	return ret;
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  205  }
efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  206  

:::::: The code at line 171 was first introduced by commit
:::::: 35bf559145b6332f5465c15a4e5cd7a363985382 PMU battery: filenames in sysfs with spaces

:::::: TO: Christian Kujau <lists@nerdbynature.de>
:::::: CC: Anton Vorontsov <cbouatmailru@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
