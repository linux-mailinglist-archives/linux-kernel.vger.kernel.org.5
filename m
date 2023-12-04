Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE73803D43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbjLDSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjLDSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:38:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9668119
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701715111; x=1733251111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YD7jjznpFYykNPu6Fnvrj/OGUC3B76wKwc3EJWm0pU4=;
  b=MpEEWbDWSn8Osar1CtWMoSMM6LlT88m6YqnhFJEsT0IAvHcg/SUIKxO6
   CzM/TZmBfMRnaRBJrJUabuTGJ70BsX7Yf9DCa+JB7WpcVbsBpDLOIoggd
   mwnzuOup+Rto1of3o9DwOll142ukEkWMeX8XU5tVHoX+stWG13Y5hVdPU
   KjDz5WesGVzzgYGA5KfahxnA6JL7/5mAHTf6cenGAyorzG6QuyWHnGjyx
   BT95pICIXKQc9alTTVkrcvSupD60A4iBb+fdTJ27cVPadXpTIC3U2mtP5
   tJyZuTBGGvC+iZ0vSgMP8Z0Ig4tsoOjS3CquDX90AlheH7V02+dHfV0Bw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="675192"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="675192"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 10:38:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841155753"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="841155753"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2023 10:38:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rADpV-00080J-3D;
        Mon, 04 Dec 2023 18:38:05 +0000
Date:   Tue, 5 Dec 2023 02:37:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/thermal/max77620_thermal.c:48: warning: Function parameter
 or member 'tz' not described in 'max77620_thermal_read_temp'
Message-ID: <202312050207.rYry02Bh-lkp@intel.com>
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

Hi Daniel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: ae11d6a87c3e742418baa591be1e719a95788059 thermal/drivers/maxim: Switch to new of API
date:   1 year, 4 months ago
config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.org/0day-ci/archive/20231205/202312050207.rYry02Bh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050207.rYry02Bh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050207.rYry02Bh-lkp@intel.com/

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
