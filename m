Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138B57EF591
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjKQPqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:46:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E6B4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700235967; x=1731771967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=beS8CQjN+RMW4uf2S3KSVTOPzk5zVCkE++M7qxr3eVU=;
  b=ht4ljcZD1J21Wtyvs4NjY8j4QAwe2b9gqwGHF4d/gZ3l3Oe242o3cLot
   d1RsAnwjbokdKRGccT0xvGNEXIs/uBmipoSW4VDlnEfkSJ6VDesxbUL8p
   uhZehksKZs80cA5e5AuATZKStgR1SgVQPAopGojIj/+hSJiD2rluGjMdh
   W6o+rrU19nsXcD1ylTT5YaSkiVScyEoVIAyBVKMwpxY8CI427Pmh835mU
   t7Ducb0nNLVtgOt09PtLBvOVQNJugA2cJ4PctiET+7oyypLyJmv7w1I5+
   q5t7gGbDl/5pmzZKtuuD60UcWJ57S5liKq2hI08F/Of3otn1RNybP+XPd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="395244902"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="395244902"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 07:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="759212657"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="759212657"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2023 07:46:03 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r412e-0002tr-2f;
        Fri, 17 Nov 2023 15:46:00 +0000
Date:   Fri, 17 Nov 2023 23:45:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: drivers/rtc/rtc-ds3232.c:482:32: warning: 'ds3232_pm_ops' defined
 but not used
Message-ID: <202311172325.33tTniaJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akinobu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc40e44f1ddef16a787f3501b97f1fff909177c
commit: 080481f54ef621211d6c75a03dc652fb6ed04222 rtc: merge ds3232 and ds3234
date:   8 years ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231117/202311172325.33tTniaJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311172325.33tTniaJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311172325.33tTniaJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:434:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     434 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/rtc/rtc-ds3232.c: In function 'ds3232_check_rtc_status':
   drivers/rtc/rtc-ds3232.c:72:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
      72 |         ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
         |                                                          ^~~~~
         |                                                          |
         |                                                          int *
   In file included from drivers/rtc/rtc-ds3232.c:25:
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c:92:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
      92 |         ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
         |                                                          ^~~~~~~~
         |                                                          |
         |                                                          int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c: In function 'ds3232_read_alarm':
   drivers/rtc/rtc-ds3232.c:195:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
     195 |         ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
         |                                                          ^~~~~
         |                                                          |
         |                                                          int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c:198:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
     198 |         ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
         |                                                          ^~~~~~~~
         |                                                          |
         |                                                          int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c: In function 'ds3232_set_alarm':
   drivers/rtc/rtc-ds3232.c:247:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
     247 |         ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
         |                                                          ^~~~~~~~
         |                                                          |
         |                                                          int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c:256:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
     256 |         ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
         |                                                          ^~~~~
         |                                                          |
         |                                                          int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c: In function 'ds3232_update_alarm':
   drivers/rtc/rtc-ds3232.c:288:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
     288 |         buf[0] = bcd2bin(buf[0]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
         |                                  ^
   drivers/rtc/rtc-ds3232.c:290:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
     290 |         buf[1] = bcd2bin(buf[1]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
         |                                  ^
   drivers/rtc/rtc-ds3232.c:292:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
     292 |         buf[2] = bcd2bin(buf[2]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
         |                                  ^
   drivers/rtc/rtc-ds3232.c:294:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
     294 |         buf[3] = bcd2bin(buf[3]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
         |                                  ^
   drivers/rtc/rtc-ds3232.c:301:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
     301 |         ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
         |                                                          ^~~~~~~~
         |                                                          |
         |                                                          int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c: In function 'ds3232_work':
   drivers/rtc/rtc-ds3232.c:359:58: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
     359 |         ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
         |                                                          ^~~~~
         |                                                          |
         |                                                          int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c:364:66: warning: pointer targets in passing argument 3 of 'regmap_read' differ in signedness [-Wpointer-sign]
     364 |                 ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
         |                                                                  ^~~~~~~~
         |                                                                  |
         |                                                                  int *
   include/linux/regmap.h:689:69: note: expected 'unsigned int *' but argument is of type 'int *'
     689 | int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
         |                                                       ~~~~~~~~~~~~~~^~~
   drivers/rtc/rtc-ds3232.c: At top level:
>> drivers/rtc/rtc-ds3232.c:482:32: warning: 'ds3232_pm_ops' defined but not used [-Wunused-const-variable=]
     482 | static const struct dev_pm_ops ds3232_pm_ops = {
         |                                ^~~~~~~~~~~~~


vim +/ds3232_pm_ops +482 drivers/rtc/rtc-ds3232.c

c93a3ae2d213ff Wang Dongsheng 2014-04-03  481  
c93a3ae2d213ff Wang Dongsheng 2014-04-03 @482  static const struct dev_pm_ops ds3232_pm_ops = {
c93a3ae2d213ff Wang Dongsheng 2014-04-03  483  	SET_SYSTEM_SLEEP_PM_OPS(ds3232_suspend, ds3232_resume)
c93a3ae2d213ff Wang Dongsheng 2014-04-03  484  };
c93a3ae2d213ff Wang Dongsheng 2014-04-03  485  

:::::: The code at line 482 was first introduced by commit
:::::: c93a3ae2d213ff75a279fe6e28d8f41ca7f01483 drivers/rtc/rtc-ds3232.c: enable ds3232 to work as wakeup source

:::::: TO: Wang Dongsheng <dongsheng.wang@freescale.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
