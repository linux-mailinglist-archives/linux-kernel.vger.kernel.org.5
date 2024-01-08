Return-Path: <linux-kernel+bounces-19031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F048266F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC131C21767
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E152A5B;
	Mon,  8 Jan 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2siVal0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBD800
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704674949; x=1736210949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P4R+CacFIR88COxYMDHUCYHoQmSIX897yqls8ZaU+04=;
  b=U2siVal0dn6/KwonKsGHFTDi0pqnCs0WeaKmcbH3ofoOvuY5P9OTNLaw
   pc5BX8GQSWebkRcYnhjNOeO0MhUblEXJBTTr9ZDD5RFkj1yJQbV3FsBUO
   3OFobD1lBP9ehRAEoM6zol6HlbfFdMd/wFOIpTFXjcUIY+3VoJjgf/kLG
   SUzcRYhXYEHO8xFIMXlnmws1S6vrpU5azFk2wXqhD14uxqp9t4MVGafE+
   8h+KTw4iRjnahm/P0vP79pnu3fXZyR5o3gWScDMQi32c50Abw9o6IukAa
   d1dzx34IOhJ+d932w4sC/znaP+ZW/rVut7CLwiBXyzIIzKXuYHfJVfcgS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="19271300"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="19271300"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 16:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028249762"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1028249762"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2024 16:49:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMdpA-0004NQ-1w;
	Mon, 08 Jan 2024 00:49:04 +0000
Date: Mon, 8 Jan 2024 08:48:18 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: drivers/platform/mellanox/mlxreg-hotplug.c:87:54: warning: '%d'
 directive output may be truncated writing 1 byte into a region of size
 between 0 and 31
Message-ID: <202401080811.VjYaZS68-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
commit: 92d020f97966b1724cfcac93e89176d0eb3aca61 platform/mellanox: mlxreg-hotplug: Add environmental data to uevent
date:   3 years, 6 months ago
config: x86_64-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20240108/202401080811.VjYaZS68-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080811.VjYaZS68-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080811.VjYaZS68-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/platform/mellanox/mlxreg-hotplug.c:8:
   drivers/platform/mellanox/mlxreg-hotplug.c: In function 'mlxreg_hotplug_attr_init':
   include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                            ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/platform/mellanox/mlxreg-hotplug.c:214:17: note: in expansion of macro 'GENMASK'
     214 |    item->mask = GENMASK((regval & item->mask) - 1, 0);
         |                 ^~~~~~~
   include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                                        ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/platform/mellanox/mlxreg-hotplug.c:214:17: note: in expansion of macro 'GENMASK'
     214 |    item->mask = GENMASK((regval & item->mask) - 1, 0);
         |                 ^~~~~~~
   drivers/platform/mellanox/mlxreg-hotplug.c: In function 'mlxreg_hotplug_udev_event_send':
>> drivers/platform/mellanox/mlxreg-hotplug.c:87:54: warning: '%d' directive output may be truncated writing 1 byte into a region of size between 0 and 31 [-Wformat-truncation=]
      87 |  snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=%d", label, !!action);
         |                                                      ^~
   drivers/platform/mellanox/mlxreg-hotplug.c:87:50: note: directive argument in the range [0, 1]
      87 |  snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=%d", label, !!action);
         |                                                  ^~~~~~~
   drivers/platform/mellanox/mlxreg-hotplug.c:87:2: note: 'snprintf' output between 3 and 34 bytes into a destination of size 32
      87 |  snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=%d", label, !!action);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +87 drivers/platform/mellanox/mlxreg-hotplug.c

    77	
    78	static int
    79	mlxreg_hotplug_udev_event_send(struct kobject *kobj,
    80				       struct mlxreg_core_data *data, bool action)
    81	{
    82		char event_str[MLXREG_CORE_LABEL_MAX_SIZE + 2];
    83		char label[MLXREG_CORE_LABEL_MAX_SIZE] = { 0 };
    84	
    85		mlxreg_hotplug_udev_envp[0] = event_str;
    86		string_upper(label, data->label);
  > 87		snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=%d", label, !!action);
    88	
    89		return kobject_uevent_env(kobj, KOBJ_CHANGE, mlxreg_hotplug_udev_envp);
    90	}
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

