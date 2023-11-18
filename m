Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552FB7F0396
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjKRXEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 18:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRXEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 18:04:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F0131
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 15:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700348685; x=1731884685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eviOJfow0gsTEN/AUjGDWE2zLVe3hi/poqG9bc8Bb6M=;
  b=bxU6Un92fGewYVTD6hwQJUEtQspPJmbP2ruD5YXaeOFn3Ow65ea2y441
   cLL8Go4C9PIFW2xWqiWCtf2qg05cuszDAL9qCvPsX7jmbuAIikbiommAC
   HMv5XTaFbhToI3T9vDxomcjQuEOnPj9X8dEhlWKfKy5/U17QH8sgD7kcS
   Na2OjC6X+lbp7h6T2u2R8hirPSwft+E3KhdjSmStlMqdkX6RsPm0P5VxX
   +3vrdJXm7CTRCWblFEzwXtvYjeZj7fxmORMYSSiPOdc9F2Z6dAmJ3Qe7G
   QazgMMTP3NCnLZggvDIbScUBwd+Z/XtAai/NYZKkXDUL3C/s+3o+pNUgX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="10120229"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="10120229"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 15:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="1013248032"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="1013248032"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2023 15:04:42 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4UMi-0004Q5-1A;
        Sat, 18 Nov 2023 23:04:40 +0000
Date:   Sun, 19 Nov 2023 07:04:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adriana Reus <adriana.reus@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: drivers/iio/light/us5182d.c:479:36: warning: 'us5182d_acpi_match'
 defined but not used
Message-ID: <202311190738.gldzuIXo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b8f1fa2419c19c81bc386a6b350879ba54a573e1
commit: c14f8abe5304ba46b898cd381a0857fd61f87200 iio: light: Add support for UPISEMI uS5182d als and proximity sensor
date:   8 years ago
config: x86_64-buildonly-randconfig-003-20230823 (https://download.01.org/0day-ci/archive/20231119/202311190738.gldzuIXo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311190738.gldzuIXo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190738.gldzuIXo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from drivers/iio/light/us5182d.c:19:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:424:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     424 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/iio/light/us5182d.c: At top level:
   drivers/iio/light/us5182d.c:480:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
     480 |         { "USD5182", 0},
         |         ^
   In file included from include/linux/i2c.h:29,
                    from drivers/iio/light/us5182d.c:22:
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
>> drivers/iio/light/us5182d.c:479:36: warning: 'us5182d_acpi_match' defined but not used [-Wunused-const-variable=]
     479 | static const struct acpi_device_id us5182d_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~
   drivers/iio/light/us5182d.c:281: warning: Function parameter or member 'data' not described in 'us5182d_update_dark_th'
   drivers/iio/light/us5182d.c:281: warning: Function parameter or member 'index' not described in 'us5182d_update_dark_th'
   drivers/iio/light/us5182d.c:303: warning: Function parameter or member 'data' not described in 'us5182d_apply_scale'
   drivers/iio/light/us5182d.c:303: warning: Function parameter or member 'index' not described in 'us5182d_apply_scale'


vim +/us5182d_acpi_match +479 drivers/iio/light/us5182d.c

   478	
 > 479	static const struct acpi_device_id us5182d_acpi_match[] = {
   480		{ "USD5182", 0},
   481		{}
   482	};
   483	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
