Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4A7CC892
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJQQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJQQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:17:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D40695
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559465; x=1729095465;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OI4Y4FBCI42HaWrWaiGZFz0VSa9d1nn0gHE9Kz7xFOY=;
  b=mVJLV2rbUdpMw0YUnioPKE3w8uMqUT/caf1F3O0dQgS8+RdMk6BIQbpu
   UXUlIEZaxRIzlED/dXu673rc7xExs0aN948NRszwKDTep12XgzQdv3HeC
   1yw1lFEsvYzJc2yQhzLQgkwc8P7UGciVCvxdGa3i4fQcuUbdArlpMM44+
   SZnAIGl5a7q//3A1C9K156UUJHP5zyHuRVdaeW2h1pzKkoYV+grruHqO1
   Eq6MPiCeMAp7XQAA6NXEgN/+zX0nobLx351bvWGTtlFbkgPQP3M9N809r
   WToMmFd0tSao3ZqjHVo/iRSjgqOR34up94czRRKwU4f7RCv+wFw/kb/mZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472043943"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="472043943"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="756180676"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="756180676"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2023 09:17:42 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsmlI-0009nZ-1d;
        Tue, 17 Oct 2023 16:17:40 +0000
Date:   Wed, 18 Oct 2023 00:16:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/thermal/max77620_thermal.c:48: warning: Function parameter
 or member 'tz' not described in 'max77620_thermal_read_temp'
Message-ID: <202310180055.CFOZ3gLO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: ae11d6a87c3e742418baa591be1e719a95788059 thermal/drivers/maxim: Switch to new of API
date:   1 year, 2 months ago
config: x86_64-randconfig-003-20231014 (https://download.01.org/0day-ci/archive/20231018/202310180055.CFOZ3gLO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310180055.CFOZ3gLO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180055.CFOZ3gLO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/max77620_thermal.c:48: warning: Function parameter or member 'tz' not described in 'max77620_thermal_read_temp'
>> drivers/thermal/max77620_thermal.c:48: warning: Excess function parameter 'data' description in 'max77620_thermal_read_temp'


vim +48 drivers/thermal/max77620_thermal.c

ec4664b3fd6d56 Laxman Dewangan 2016-08-23  32  
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  33  /**
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  34   * max77620_thermal_read_temp: Read PMIC die temperatue.
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  35   * @data:	Device specific data.
0f43e646dddd60 Amit Kucheria   2019-11-20  36   * @temp:	Temperature in millidegrees Celsius
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  37   *
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  38   * The actual temperature of PMIC die is not available from PMIC.
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  39   * PMIC only tells the status if it has crossed or not the threshold level
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  40   * of 120degC or 140degC.
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  41   * If threshold has not been crossed then assume die temperature as 100degC
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  42   * else 120degC or 140deG based on the PMIC die temp threshold status.
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  43   *
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  44   * Return 0 on success otherwise error number to show reason of failure.
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  45   */
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  46  
ae11d6a87c3e74 Daniel Lezcano  2022-08-05  47  static int max77620_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
ec4664b3fd6d56 Laxman Dewangan 2016-08-23 @48  {
ae11d6a87c3e74 Daniel Lezcano  2022-08-05  49  	struct max77620_therm_info *mtherm = tz->devdata;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  50  	unsigned int val;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  51  	int ret;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  52  
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  53  	ret = regmap_read(mtherm->rmap, MAX77620_REG_STATLBT, &val);
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  54  	if (ret < 0) {
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  55  		dev_err(mtherm->dev, "Failed to read STATLBT: %d\n", ret);
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  56  		return ret;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  57  	}
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  58  
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  59  	if (val & MAX77620_IRQ_TJALRM2_MASK)
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  60  		*temp = MAX77620_TJALARM2_TEMP;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  61  	else if (val & MAX77620_IRQ_TJALRM1_MASK)
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  62  		*temp = MAX77620_TJALARM1_TEMP;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  63  	else
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  64  		*temp = MAX77620_NORMAL_OPERATING_TEMP;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  65  
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  66  	return 0;
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  67  }
ec4664b3fd6d56 Laxman Dewangan 2016-08-23  68  

:::::: The code at line 48 was first introduced by commit
:::::: ec4664b3fd6d565a79eb562e4339528f74eb1cca thermal: max77620: Add thermal driver for reporting junction temp

:::::: TO: Laxman Dewangan <ldewangan@nvidia.com>
:::::: CC: Zhang Rui <rui.zhang@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
