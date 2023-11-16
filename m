Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324E37EE6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjKPSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345441AbjKPSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:23:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A0FD4F;
        Thu, 16 Nov 2023 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700159007; x=1731695007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8NGGQ/mtiHg+Lgu3IflKUbsA+rp/7C3d0ZkVHyY0Wvk=;
  b=h/rxVsYAQH9MdyF0ca4pqWTMLYsQ0dSBn6kgsNZAijrANNs8ix+Rfs82
   M3oFikz+b820Ii632QbiwS6FWi3fzTWKqpa4YnABzdnd/bljbtLb7QRwL
   +j8H5EC1eQ+Xcii/SskxRYzE26yqzkazBLRZz03Ieht+i+MRo8gGDE5ly
   tVP/NJKgjy9KBT2loKW/k2+OSSG4GIcsM1fepcBugQ7pvfl7F/7tB8UXi
   nKru8bqgfaSA6T0Cgw9+W41eftlmcWjxz1A2djvX7b+/oE+CiDLWB3P0k
   O3fMeCEzcY2CYwnGedjG6mIG9Y9af643jafi56ePKsuV9h1nZZmaafiV6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4227232"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="4227232"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 10:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="758918252"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="758918252"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2023 10:23:24 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3h1M-0001zb-13;
        Thu, 16 Nov 2023 18:23:20 +0000
Date:   Fri, 17 Nov 2023 02:23:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hiten Chauhan <hiten.chauhan@siliconsignals.io>,
        jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Hiten Chauhan <hiten.chauhan@siliconsignals.io>
Subject: Re: [PATCH v2 1/1] Added tilt interrupt support in inv_icm42600
Message-ID: <202311170235.HaVJnmWa-lkp@intel.com>
References: <20231116134528.21467-1-hiten.chauhan@siliconsignals.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116134528.21467-1-hiten.chauhan@siliconsignals.io>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hiten,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.7-rc1 next-20231116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hiten-Chauhan/Added-tilt-interrupt-support-in-inv_icm42600/20231116-214808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231116134528.21467-1-hiten.chauhan%40siliconsignals.io
patch subject: [PATCH v2 1/1] Added tilt interrupt support in inv_icm42600
config: arm-randconfig-001-20231117 (https://download.01.org/0day-ci/archive/20231117/202311170235.HaVJnmWa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311170235.HaVJnmWa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311170235.HaVJnmWa-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:117:61: error: macro "DEVICE_ATTR_RW" passed 4 arguments, but takes just 1
     117 |                    tilt_interrupt_show, tilt_interrupt_store);
         |                                                             ^
   In file included from drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:7:
   include/linux/device.h:179: note: macro "DEVICE_ATTR_RW" defined here
     179 | #define DEVICE_ATTR_RW(_name) \
         | 
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:116:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RW' [-Werror=implicit-int]
     116 | static DEVICE_ATTR_RW(tilt_interrupt, 0644,
         |        ^~~~~~~~~~~~~~
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:120:10: error: 'dev_attr_tilt_interrupt' undeclared here (not in a function)
     120 |         &dev_attr_tilt_interrupt.attr,
         |          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:116:8: warning: 'DEVICE_ATTR_RW' defined but not used [-Wunused-variable]
     116 | static DEVICE_ATTR_RW(tilt_interrupt, 0644,
         |        ^~~~~~~~~~~~~~
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:82:16: warning: 'tilt_interrupt_store' defined but not used [-Wunused-function]
      82 | static ssize_t tilt_interrupt_store(struct device *dev,
         |                ^~~~~~~~~~~~~~~~~~~~
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:65:16: warning: 'tilt_interrupt_show' defined but not used [-Wunused-function]
      65 | static ssize_t tilt_interrupt_show(struct device *dev,
         |                ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/DEVICE_ATTR_RW +117 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c

   > 7	#include <linux/device.h>
     8	#include <linux/mutex.h>
     9	#include <linux/pm_runtime.h>
    10	#include <linux/regmap.h>
    11	#include <linux/delay.h>
    12	#include <linux/math64.h>
    13	
    14	#include <linux/iio/buffer.h>
    15	#include <linux/iio/common/inv_sensors_timestamp.h>
    16	#include <linux/iio/iio.h>
    17	#include <linux/iio/kfifo_buf.h>
    18	
    19	#include "inv_icm42600.h"
    20	#include "inv_icm42600_temp.h"
    21	#include "inv_icm42600_buffer.h"
    22	
    23	#define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
    24		{								\
    25			.type = IIO_ACCEL,					\
    26			.modified = 1,						\
    27			.channel2 = _modifier,					\
    28			.info_mask_separate =					\
    29				BIT(IIO_CHAN_INFO_RAW) |			\
    30				BIT(IIO_CHAN_INFO_CALIBBIAS),			\
    31			.info_mask_shared_by_type =				\
    32				BIT(IIO_CHAN_INFO_SCALE),			\
    33			.info_mask_shared_by_type_available =			\
    34				BIT(IIO_CHAN_INFO_SCALE) |			\
    35				BIT(IIO_CHAN_INFO_CALIBBIAS),			\
    36			.info_mask_shared_by_all =				\
    37				BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
    38			.info_mask_shared_by_all_available =			\
    39				BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
    40			.scan_index = _index,					\
    41			.scan_type = {						\
    42				.sign = 's',					\
    43				.realbits = 16,					\
    44				.storagebits = 16,				\
    45				.endianness = IIO_BE,				\
    46			},							\
    47			.ext_info = _ext_info,					\
    48		}
    49	
    50	uint8_t inv_icm42605_int_reg;
    51	
    52	enum inv_icm42600_accel_scan {
    53		INV_ICM42600_ACCEL_SCAN_X,
    54		INV_ICM42600_ACCEL_SCAN_Y,
    55		INV_ICM42600_ACCEL_SCAN_Z,
    56		INV_ICM42600_ACCEL_SCAN_TEMP,
    57		INV_ICM42600_ACCEL_SCAN_TIMESTAMP,
    58	};
    59	
    60	static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
    61		IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
    62		{},
    63	};
    64	
  > 65	static ssize_t tilt_interrupt_show(struct device *dev,
    66				       struct device_attribute *attr, char *buf)
    67	{
    68		struct inv_icm42600_state *st = dev_get_drvdata(dev);
    69		unsigned int val;
    70		int ret;
    71	
    72		ret = regmap_read(st->map, inv_icm42605_int_reg, &val);
    73	
    74		if (ret != 0)
    75			return ret;
    76	
    77		snprintf(buf, PAGE_SIZE, "Read reg %x value %x\n", inv_icm42605_int_reg, val);
    78	
    79		return strlen(buf);
    80	}
    81	
  > 82	static ssize_t tilt_interrupt_store(struct device *dev,
    83			struct device_attribute *attr, const char *buf,
    84			size_t count)
    85	{
    86		struct inv_icm42600_state *st = dev_get_drvdata(dev);
    87		int ret;
    88		int value;
    89	
    90		if (!st)
    91			return -EINVAL;
    92	
    93		if (kstrtoint(buf, 10, &value))
    94			return -EINVAL;
    95	
    96		inv_icm42605_int_reg = INV_ICM42605_REG_INT_STATUS3;
    97	
    98		switch (value) {
    99		case 1:
   100			ret = inv_icm42605_generate_tilt_interrupt(st);
   101			if (ret != 0)
   102				return -EIO;
   103			break;
   104		case 0:
   105			ret = inv_icm42605_disable_tilt_interrupt(st);
   106			if (ret != 0)
   107				return -EIO;
   108			break;
   109		default:
   110			return -EINVAL;
   111		}
   112	
   113		return count;
   114	}
   115	
 > 116	static DEVICE_ATTR_RW(tilt_interrupt, 0644,
 > 117			   tilt_interrupt_show, tilt_interrupt_store);
   118	
   119	static struct attribute *icm42605_attrs[] = {
 > 120		&dev_attr_tilt_interrupt.attr,
   121		NULL,
   122	};
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
