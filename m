Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A069680B65A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjLIUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLIUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:53:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647CE1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702155196; x=1733691196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vsmFGp4tltrRfnwVP7WRUH3KHkFugEu7frCpsnLaLW8=;
  b=Hcgs7Nlul4N13YvufuJGsvGaI63i9lKVd/tINqxPw9BLB0+Io69+I+9t
   ptpZEUyUfRvkXJee/oxdT3xvLMOhOnse/+v5EOqZDb+YS2Ot3PU6ZBiFR
   SO2MSpnOUUnfKd3g7RWZkHir9qifxJfd+p4kw5CDNy+nIvWJaNjo0Zal5
   GgzhpeuursxsZutIUGjCLVyakGgBM2xJZMvUGBqzIkOKFRiz3isRbjr5p
   xSnJvyP+GXO7zPDNi5OH798g9ZMYNNjxNw1IM/4PmK1YcCHBXkCEjQmaC
   X6lGp5MWKcXlHyJMuj6wMxjVEbMcb81t5WLHg+Svukzqlc430A0eOuaP1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="16077340"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="16077340"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 12:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="842993032"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="842993032"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2023 12:53:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC4K0-000Fw4-14;
        Sat, 09 Dec 2023 20:53:12 +0000
Date:   Sun, 10 Dec 2023 04:52:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/corsair-cpro.c:502:79: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202312100455.k6m2eO4N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: 40c3a445422579db8ad96c234dbe6c0ab3f6b936 hwmon: add Corsair Commander Pro driver
date:   3 years, 5 months ago
config: parisc-randconfig-m041-20230821 (https://download.01.org/0day-ci/archive/20231210/202312100455.k6m2eO4N-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312100455.k6m2eO4N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100455.k6m2eO4N-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/corsair-cpro.c:502:79: sparse: sparse: Using plain integer as NULL pointer

vim +502 drivers/hwmon/corsair-cpro.c

   460	
   461	static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
   462	{
   463		struct ccp_device *ccp;
   464		int ret;
   465	
   466		ccp = devm_kzalloc(&hdev->dev, sizeof(*ccp), GFP_KERNEL);
   467		if (!ccp)
   468			return -ENOMEM;
   469	
   470		ccp->buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
   471		if (!ccp->buffer)
   472			return -ENOMEM;
   473	
   474		ret = hid_parse(hdev);
   475		if (ret)
   476			return ret;
   477	
   478		ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
   479		if (ret)
   480			return ret;
   481	
   482		ret = hid_hw_open(hdev);
   483		if (ret)
   484			goto out_hw_stop;
   485	
   486		ccp->hdev = hdev;
   487		hid_set_drvdata(hdev, ccp);
   488		mutex_init(&ccp->mutex);
   489		init_completion(&ccp->wait_input_report);
   490	
   491		hid_device_io_start(hdev);
   492	
   493		/* temp and fan connection status only updates when device is powered on */
   494		ret = get_temp_cnct(ccp);
   495		if (ret)
   496			goto out_hw_close;
   497	
   498		ret = get_fan_cnct(ccp);
   499		if (ret)
   500			goto out_hw_close;
   501		ccp->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsaircpro",
 > 502								 ccp, &ccp_chip_info, 0);
   503		if (IS_ERR(ccp->hwmon_dev)) {
   504			ret = PTR_ERR(ccp->hwmon_dev);
   505			goto out_hw_close;
   506		}
   507	
   508		return 0;
   509	
   510	out_hw_close:
   511		hid_hw_close(hdev);
   512	out_hw_stop:
   513		hid_hw_stop(hdev);
   514		return ret;
   515	}
   516	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
