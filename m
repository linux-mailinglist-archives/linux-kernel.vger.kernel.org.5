Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E17DDFF7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjKAK47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjKAK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:56:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA57122;
        Wed,  1 Nov 2023 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698836200; x=1730372200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8XoIBvJBqu2UWQDbjlJ+l/oehOtNlARvyRZhwkORV84=;
  b=joACo38YsW5rDnNlEJ/Xxzw8zZ4RCx2y3xv8BxVCtX3YPx4W9W1nYcfG
   xp88PbhiETi1IQesFchd89jVpW6MEtxi0eKJlTF6RED7jYQvgXNeAVfZk
   1kH0MAqpUePfQu1PUPN43M370FjomDlqFMsQkuhmjQO2BW2yfx8Q6anIG
   uqjj4khol5TpDT2C+lDDe9zPIHOQyQVUmXpZulQqupMFIxyqc2aBi/0NI
   R6dUf9d1YvzDIR6HciZZliI9qGt4bza8O8P0s1C7CZP1++I3+P/TPiOwa
   usJbrb4/Ni4NnOXOkts/Dq3A/jlNIlEa+Z0veAhx29w6vlw8qCFzuFF7Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="454948364"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="454948364"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="8632388"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Nov 2023 03:56:37 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qy8tm-0000lM-1L;
        Wed, 01 Nov 2023 10:56:34 +0000
Date:   Wed, 1 Nov 2023 18:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Ober <dober6023@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, corbet@lwn.net, dober@lenovo.com,
        mpearson-lenovo@squebb.ca, David Ober <dober6023@gmail.com>
Subject: Re: [PATCH v2] hwmon:Add MEC172x Micro Chip driver for Lenovo
 motherboards
Message-ID: <202311011858.M1Ui9wp1-lkp@intel.com>
References: <20231031154930.4908-1-dober6023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031154930.4908-1-dober6023@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.6 next-20231101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ober/hwmon-Add-MEC172x-Micro-Chip-driver-for-Lenovo-motherboards/20231031-235345
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20231031154930.4908-1-dober6023%40gmail.com
patch subject: [PATCH v2] hwmon:Add MEC172x Micro Chip driver for Lenovo motherboards
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231101/202311011858.M1Ui9wp1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311011858.M1Ui9wp1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311011858.M1Ui9wp1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/lenovo-ec-sensors.c: In function 'get_ec_reg':
   drivers/hwmon/lenovo-ec-sensors.c:36:25: error: implicit declaration of function 'inb_p'; did you mean 'int_pow'? [-Werror=implicit-function-declaration]
      36 | #define io_read8(a)     inb_p(a)
         |                         ^~~~~
   drivers/hwmon/lenovo-ec-sensors.c:45:13: note: in expansion of macro 'io_read8'
      45 |         if (io_read8(MCHP_EMI0_APPLICATION_ID) != 0) /* EMI access locked */
         |             ^~~~~~~~
   drivers/hwmon/lenovo-ec-sensors.c:35:25: error: implicit declaration of function 'outb_p' [-Werror=implicit-function-declaration]
      35 | #define io_write8(a, b) outb_p(b, a)
         |                         ^~~~~~
   drivers/hwmon/lenovo-ec-sensors.c:48:9: note: in expansion of macro 'io_write8'
      48 |         io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);
         |         ^~~~~~~~~
   drivers/hwmon/lenovo-ec-sensors.c: In function 'get_platform':
>> drivers/hwmon/lenovo-ec-sensors.c:274:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     274 |         for (idx = 0 ; idx < 6 ; idx++)
         |         ^~~
   drivers/hwmon/lenovo-ec-sensors.c:276:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
     276 |                 system_type[idx] = get_ec_reg(0xC, (0x10 + idx));
         |                 ^~~~~~~~~~~
   In function 'get_platform',
       inlined from 'lenovo_ec_probe' at drivers/hwmon/lenovo-ec-sensors.c:420:26:
>> drivers/hwmon/lenovo-ec-sensors.c:276:34: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
     276 |                 system_type[idx] = get_ec_reg(0xC, (0x10 + idx));
         |                 ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/lenovo-ec-sensors.c: In function 'lenovo_ec_probe':
   drivers/hwmon/lenovo-ec-sensors.c:270:14: note: at offset 6 into destination object 'system_type' of size 6
     270 |         char system_type[6];
         |              ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/for +274 drivers/hwmon/lenovo-ec-sensors.c

   267	
   268	static int get_platform(struct ec_sensors_data *data)
   269	{
   270		char system_type[6];
   271		int ret = -1;
   272		int idx;
   273	
 > 274		for (idx = 0 ; idx < 6 ; idx++)
   275			mutex_lock(&data->mec_mutex);
 > 276			system_type[idx] = get_ec_reg(0xC, (0x10 + idx));
   277			mutex_unlock(&data->mec_mutex);
   278	
   279		for (idx = 0 ; idx < 4 ; idx++) {
   280			if (strcmp(systems[idx], system_type) == 0) {
   281				ret = idx;
   282				break;
   283			}
   284		}
   285		return ret;
   286	}
   287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
