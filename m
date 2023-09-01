Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C207903E4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjIAXAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbjIAXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:00:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70D1722;
        Fri,  1 Sep 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693602304; x=1725138304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WIVQ4Z7LQCKejOg7pncS5p83NHp79nepmutiHbIxUc=;
  b=ciF8QbS6qimjMkOpNaPiPDhTz+R6O2G2PXgWpMuVI5HIB4cVh1+zY+pG
   hnZKpFmgMCbPWM8RbMZ51tqnFOGtGtPMtjOWGwPeEeWf0GCloA/Dvp1Xi
   V48SGZSCsMBGNWhO3F9r83Q8tP37FgVDWjULgBtDaAaCdvLJcRUzNJoRB
   Bh6xq6ERwEdjtPDk6FNiMRYbVOTLXvoQtCHTeEW5GP0PhiyMgl5xWmb1c
   y3YNAVefF1/hz+H7IIOOwaJwStXLsp0qBIXkxAFsMXsfJBuFF6Xzjm82/
   /ZXVaVMiOBYL4n+cADmMdaYm953T7cx7qJ29uNODMXY7Ewt76/GOEewTV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366538558"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="366538558"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 14:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="810205534"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="810205534"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2023 14:04:54 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcBK0-0001dv-1g;
        Fri, 01 Sep 2023 21:04:52 +0000
Date:   Sat, 2 Sep 2023 05:04:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] regulator (max5970): Add hwmon support
Message-ID: <202309020434.x0wzOQpo-lkp@intel.com>
References: <20230901093449.838414-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901093449.838414-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 35d0d2350d774fecf596cfb2fb050559fe5e1850]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-max5970-Add-hwmon-support/20230901-173611
base:   35d0d2350d774fecf596cfb2fb050559fe5e1850
patch link:    https://lore.kernel.org/r/20230901093449.838414-1-Naresh.Solanki%409elements.com
patch subject: [PATCH v2] regulator (max5970): Add hwmon support
config: x86_64-randconfig-004-20230902 (https://download.01.org/0day-ci/archive/20230902/202309020434.x0wzOQpo-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230902/202309020434.x0wzOQpo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309020434.x0wzOQpo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/max5970-regulator.c:124:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   drivers/regulator/max5970-regulator.c:124:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   1 warning generated.


vim +124 drivers/regulator/max5970-regulator.c

    99	
   100	static umode_t max5970_is_visible(const void *data,
   101					  enum hwmon_sensor_types type,
   102					  u32 attr, int channel)
   103	{
   104		struct max5970_data *ddata = (struct max5970_data *)data;
   105	
   106		if (channel >= ddata->num_switches)
   107			return 0;
   108	
   109		switch (type) {
   110		case hwmon_in:
   111			switch (attr) {
   112			case hwmon_in_input:
   113				return 0444;
   114			default:
   115				break;
   116			}
   117			break;
   118		case hwmon_curr:
   119			switch (attr) {
   120			case hwmon_curr_input:
   121				/* Current measurement requires knowledge of the shunt resistor value. */
   122				if (ddata->shunt_micro_ohms[channel])
   123					return 0444;
 > 124			default:
   125				break;
   126			}
   127			break;
   128		default:
   129			break;
   130		}
   131		return 0;
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
