Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85D7DEE49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjKBIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKBIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:43:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F9128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698914610; x=1730450610;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4PVnbSTg3W8h3V0KXuI/SfFgYtZr+OoRAkzmePRTco8=;
  b=QshUR6NOqjiFKpjPwTPXd3Z72pEJYE93DyJgDdAVzXCGm3EZjenkJKF3
   EMzMH9lFS8DZnYDkZWzN37L7tRhkMWj7eRcdsrFAC9+wSoIboRdqeLPHd
   B3ZLdydvfEo5bKsuDQD5Gou7uBiTVT8zNi1jXx4FLQZjknd8jVB2eq2Y0
   TKiDkieY/+cTkpUQev67X/FsB1aQJE9ljNCQPazu6NldGqvHJgf3rfYTU
   wZ8Zkuvx5wAJIPHiDsSWbXFj9rIU+3lctmKtQllsCbOqMiaQQdM/705Xt
   XSYrd5NrqdkCZCGYIeenXG8SG+BQOU3y2tUZpfEwvceztOCyhI57rTQdg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="373707178"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="373707178"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 01:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="851850895"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="851850895"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2023 01:43:28 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyTIU-0001HU-1C;
        Thu, 02 Nov 2023 08:43:26 +0000
Date:   Thu, 2 Nov 2023 16:42:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: arch/sh/boards/mach-hp6xx/hp6xx_apm.c:32:22: warning: variable
 'backup' set but not used
Message-ID: <202311021607.1gLwwwRL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 706afcea16cd83fecb7c2229ccc31bb237ffdbef sh: Fix -Wmissing-include-dirs warnings for various platforms
date:   4 months ago
config: sh-hp6xx_defconfig (https://download.01.org/0day-ci/archive/20231102/202311021607.1gLwwwRL-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021607.1gLwwwRL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021607.1gLwwwRL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/sh/boards/mach-hp6xx/hp6xx_apm.c: In function 'hp6x0_apm_get_power_status':
>> arch/sh/boards/mach-hp6xx/hp6xx_apm.c:32:22: warning: variable 'backup' set but not used [-Wunused-but-set-variable]
      32 |         int battery, backup, charging, percentage;
         |                      ^~~~~~


vim +/backup +32 arch/sh/boards/mach-hp6xx/hp6xx_apm.c

dd4f99b42dcce8 arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2008-03-06  29  
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  30  static void hp6x0_apm_get_power_status(struct apm_power_info *info)
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  31  {
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24 @32  	int battery, backup, charging, percentage;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  33  	u8 pgdr;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  34  
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  35  	battery		= adc_single(ADC_CHANNEL_BATTERY);
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  36  	backup		= adc_single(ADC_CHANNEL_BACKUP);
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  37  	charging	= adc_single(ADC_CHANNEL_CHARGE);
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  38  
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  39  	percentage = 100 * (battery - HP680_BATTERY_MIN) /
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  40  			   (HP680_BATTERY_MAX - HP680_BATTERY_MIN);
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  41  
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  42  	/* % of full battery */
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  43  	info->battery_life = percentage;
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  44  
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  45  	/* We want our estimates in minutes */
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  46  	info->units = 0;
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  47  
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  48  	/* Extremely(!!) rough estimate, we will replace this with a datalist later on */
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  49  	info->time = (2 * battery);
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  50  
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  51  	info->ac_line_status = (battery > HP680_BATTERY_AC_ON) ?
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  52  			 APM_AC_ONLINE : APM_AC_OFFLINE;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  53  
9d56dd3b083a3b arch/sh/boards/mach-hp6xx/hp6xx_apm.c Paul Mundt         2010-01-26  54  	pgdr = __raw_readb(PGDR);
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  55  	if (pgdr & PGDR_MAIN_BATTERY_OUT) {
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  56  		info->battery_status	= APM_BATTERY_STATUS_NOT_PRESENT;
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  57  		info->battery_flag	= 0x80;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  58  	} else if (charging < 8) {
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  59  		info->battery_status	= APM_BATTERY_STATUS_CHARGING;
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  60  		info->battery_flag	= 0x08;
8b03c040e4efaa arch/sh/boards/hp6xx/hp6xx_apm.c      Kristoffer Ericson 2008-03-04  61  		info->ac_line_status	= 0x01;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  62  	} else if (percentage <= APM_CRITICAL) {
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  63  		info->battery_status	= APM_BATTERY_STATUS_CRITICAL;
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  64  		info->battery_flag	= 0x04;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  65  	} else if (percentage <= APM_LOW) {
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  66  		info->battery_status	= APM_BATTERY_STATUS_LOW;
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  67  		info->battery_flag	= 0x02;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  68  	} else {
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  69  		info->battery_status	= APM_BATTERY_STATUS_HIGH;
0a9b0db19262db arch/sh/boards/hp6xx/hp6xx_apm.c      Paul Mundt         2007-01-24  70  		info->battery_flag	= 0x01;
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  71  	}
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  72  }
3aa770e7972723 arch/sh/boards/hp6xx/hp6xx_apm.c      Andriy Skulysh     2006-09-27  73  

:::::: The code at line 32 was first introduced by commit
:::::: 0a9b0db19262dbb09f3a34195e68cafd5dc3fa10 [APM] SH: Convert to use shared APM emulation.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
