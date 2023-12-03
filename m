Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC55F802134
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjLCGHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjLCGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:07:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C9C107
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701583668; x=1733119668;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hAnifYstPsZ4fTMFdYWigXDFIFhd02KTYYDx3BLUEN4=;
  b=LSFJQf1KidoE9L2r7mtX7VJ8pDhozu6G4cyqy1hwhREXJ7VPoXVpOXNH
   /txiZMYf5o2UMk9zgVcQEM5TL9N6XEcQwizHnCcrXDnrudX+3bKvJ+zy1
   SLN1DD42oIbIHktkJpi7YdON45CGf/eucHADNRtGTbZWVg1wKHk8IXbEt
   GzoLZsyo2weuMt4QY72Ib4lkvl8lkKEpzCE66qA/Zkm4K2yLODRv5VdXg
   Yg5iJWYeCoxi79dDsrPN31dylFaWzr/1FAfRsEcB6Zq3V79hGCLgtKJk0
   KXNs7ahzdKsGIEMlmxpc1q9/Ssp3JOM9f2422TobwK2AQaQ45RTOwIN+z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="373049290"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="373049290"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770187876"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770187876"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:07:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9fdk-0006I4-2o;
        Sun, 03 Dec 2023 06:07:40 +0000
Date:   Sun, 3 Dec 2023 14:07:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszormenyi@sicom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/touchscreen/egalax_ts_serial.c:116:21: warning:
 '/input0' directive output may be truncated writing 7 bytes into a region of
 size between 1 and 32
Message-ID: <202312021646.cwwvptuB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Böszörményi,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 6b0f8f9c52efe24d6dac06ab963b7bd91c723751 Input: add eGalaxTouch serial touchscreen driver
date:   8 years ago
config: x86_64-randconfig-r032-20230515 (https://download.01.org/0day-ci/archive/20231202/202312021646.cwwvptuB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231202/202312021646.cwwvptuB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312021646.cwwvptuB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from drivers/input/touchscreen/egalax_ts_serial.c:19:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/input/touchscreen/egalax_ts_serial.c: In function 'egalax_connect':
>> drivers/input/touchscreen/egalax_ts_serial.c:116:21: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
     116 |                  "%s/input0", serio->phys);
         |                     ^~~~~~~
   drivers/input/touchscreen/egalax_ts_serial.c:115:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
     115 |         snprintf(egalax->phys, sizeof(egalax->phys),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                  "%s/input0", serio->phys);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~


vim +116 drivers/input/touchscreen/egalax_ts_serial.c

    94	
    95	/*
    96	 * egalax_connect() is the routine that is called when someone adds a
    97	 * new serio device that supports egalax protocol and registers it as
    98	 * an input device. This is usually accomplished using inputattach.
    99	 */
   100	static int egalax_connect(struct serio *serio, struct serio_driver *drv)
   101	{
   102		struct egalax *egalax;
   103		struct input_dev *input_dev;
   104		int error;
   105	
   106		egalax = kzalloc(sizeof(struct egalax), GFP_KERNEL);
   107		input_dev = input_allocate_device();
   108		if (!egalax) {
   109			error = -ENOMEM;
   110			goto err_free_mem;
   111		}
   112	
   113		egalax->serio = serio;
   114		egalax->input = input_dev;
   115		snprintf(egalax->phys, sizeof(egalax->phys),
 > 116			 "%s/input0", serio->phys);
   117	
   118		input_dev->name = "EETI eGalaxTouch Serial TouchScreen";
   119		input_dev->phys = egalax->phys;
   120		input_dev->id.bustype = BUS_RS232;
   121		input_dev->id.vendor = SERIO_EGALAX;
   122		input_dev->id.product = 0;
   123		input_dev->id.version = 0x0001;
   124		input_dev->dev.parent = &serio->dev;
   125	
   126		input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
   127		input_set_abs_params(input_dev, ABS_X,
   128				     EGALAX_MIN_XC, EGALAX_MAX_XC, 0, 0);
   129		input_set_abs_params(input_dev, ABS_Y,
   130				     EGALAX_MIN_YC, EGALAX_MAX_YC, 0, 0);
   131	
   132		serio_set_drvdata(serio, egalax);
   133	
   134		error = serio_open(serio, drv);
   135		if (error)
   136			goto err_reset_drvdata;
   137	
   138		error = input_register_device(input_dev);
   139		if (error)
   140			goto err_close_serio;
   141	
   142		return 0;
   143	
   144	err_close_serio:
   145		serio_close(serio);
   146	err_reset_drvdata:
   147		serio_set_drvdata(serio, NULL);
   148	err_free_mem:
   149		input_free_device(input_dev);
   150		kfree(egalax);
   151		return error;
   152	}
   153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
