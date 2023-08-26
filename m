Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF4789944
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjHZVpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjHZVos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:44:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D35CC4;
        Sat, 26 Aug 2023 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693086284; x=1724622284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LA68/YEgXZrAzt9woUUD7igKvQPU44gdit0ruhpq4+4=;
  b=BNAwTaLWn/ChUP2M5FJuXBXUE8y+bc/Olu/py6sEZLwotuBPEnSGNmzn
   2nkOqNtfPsZzx/ovzdxup6G99evYb1lD11TOmZjh/gq0zeiUW2euKpsnG
   NMPxDz8evXRthwp2CEEoo6hE0BF/V/DEUpPOZi7XkE252KHVY2rtweo6V
   mPXJOe/Mu3nyzdk+OzTWpOoMmr/y1YMRWiSVbaM1u7HoMqJkIQY8P22NB
   mlwL75QbwTLW6PQDslERDdTySPB96JhbdY7zcD4qd6EKXMTB2gOgM+ZPS
   Ws+m8FSfR0ph389dQunEkqn+OtIniq99yFz03OyaKsJfMeOEw2VU+vSXo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="355232470"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="355232470"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 14:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="772851383"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="772851383"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Aug 2023 14:44:39 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qa14n-000575-2j;
        Sat, 26 Aug 2023 21:44:24 +0000
Date:   Sun, 27 Aug 2023 05:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        rrameshbabu@nvidia.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
Message-ID: <202308270516.Ch4MucBs-lkp@intel.com>
References: <4c9a8c7f6b4eb879dd7ef4d44bb6a80b3f126d25.1693070958.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9a8c7f6b4eb879dd7ef4d44bb6a80b3f126d25.1693070958.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linux-next/master]
[cannot apply to linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/HID-nvidia-shield-Fix-a-missing-led_classdev_unregister-in-the-probe-error-handling-path/20230827-014602
base:   linux-next/master
patch link:    https://lore.kernel.org/r/4c9a8c7f6b4eb879dd7ef4d44bb6a80b3f126d25.1693070958.git.christophe.jaillet%40wanadoo.fr
patch subject: [PATCH 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
config: i386-buildonly-randconfig-003-20230827 (https://download.01.org/0day-ci/archive/20230827/202308270516.Ch4MucBs-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230827/202308270516.Ch4MucBs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308270516.Ch4MucBs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-nvidia-shield.c:1046:24: warning: variable 'ts' set but not used [-Wunused-but-set-variable]
           struct thunderstrike *ts;
                                 ^
   1 warning generated.


vim +/ts +1046 drivers/hid/hid-nvidia-shield.c

09308562d4afb1 Rahul Rameshbabu   2023-06-08  1042  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1043  static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1044  {
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1045  	struct shield_device *shield_dev = NULL;
09308562d4afb1 Rahul Rameshbabu   2023-06-08 @1046  	struct thunderstrike *ts;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1047  	int ret;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1048  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1049  	ret = hid_parse(hdev);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1050  	if (ret) {
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1051  		hid_err(hdev, "Parse failed\n");
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1052  		return ret;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1053  	}
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1054  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1055  	switch (id->product) {
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1056  	case USB_DEVICE_ID_NVIDIA_THUNDERSTRIKE_CONTROLLER:
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1057  		shield_dev = thunderstrike_create(hdev);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1058  		break;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1059  	}
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1060  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1061  	if (unlikely(!shield_dev)) {
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1062  		hid_err(hdev, "Failed to identify SHIELD device\n");
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1063  		return -ENODEV;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1064  	}
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1065  	if (IS_ERR(shield_dev)) {
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1066  		hid_err(hdev, "Failed to create SHIELD device\n");
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1067  		return PTR_ERR(shield_dev);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1068  	}
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1069  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1070  	ts = container_of(shield_dev, struct thunderstrike, base);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1071  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1072  	ret = hid_hw_start(hdev, HID_CONNECT_HIDINPUT);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1073  	if (ret) {
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1074  		hid_err(hdev, "Failed to start HID device\n");
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1075  		goto err_haptics;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1076  	}
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1077  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1078  	ret = hid_hw_open(hdev);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1079  	if (ret) {
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1080  		hid_err(hdev, "Failed to open HID device\n");
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1081  		goto err_stop;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1082  	}
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1083  
3ab196f882377e Rahul Rameshbabu   2023-08-07  1084  	thunderstrike_device_init_info(shield_dev);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1085  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1086  	return ret;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1087  
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1088  err_stop:
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1089  	hid_hw_stop(hdev);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1090  err_haptics:
2cc4637842495c Christophe JAILLET 2023-08-26  1091  	thunderstrike_destroy(hdev);
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1092  	return ret;
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1093  }
09308562d4afb1 Rahul Rameshbabu   2023-06-08  1094  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
