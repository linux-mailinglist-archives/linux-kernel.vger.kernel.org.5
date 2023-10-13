Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04607C82EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjJMKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMKYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:24:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4321AD;
        Fri, 13 Oct 2023 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697192692; x=1728728692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVTI+KtH248Y6N2mDkGmVGWxc0Mtj1GwtiXmRY/C2Xo=;
  b=OpUuNDVP9osR3+c0YcPI+FBEOrQCk41nAT8iiQ5EEPO1LfOL3bKGJUxC
   3y02emDi5G+s+XWwqPsApR1t0yDutofWH6CBHXhlgoTeGH09fbWZEuw46
   /6BMB0w4/m7fKyNcm3NcG0XPQ+wjzQr0F50uIPPfXlsD6QunJQzxUpLcU
   /KIqBu2iopOpTUB6lKwMAdYjo0Mw0Lt6o++s5x2nq79isiUDIHSrCjYE/
   QuVV6852D+UqsIQqVcASj0hjGmYukBiFaYNduM/udqS5v6JfIkwtNdT6R
   t2NkT8ffFcuWybNUH4oJUzV2hfRfdJTsVPbfv/WD0cFYqmzbfuZFL7oGK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375499626"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="375499626"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731318523"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="731318523"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 03:24:48 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrFLa-0004cw-29;
        Fri, 13 Oct 2023 10:24:46 +0000
Date:   Fri, 13 Oct 2023 18:23:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhengping Jiang <jiangzp@google.com>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev,
        chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [kernel PATCH v2] Bluetooth: btmtksdio: enable bluetooth wakeup
 in system suspend
Message-ID: <202310131817.oEUPvya8-lkp@intel.com>
References: <20231011153928.kernel.v2.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011153928.kernel.v2.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhengping,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhengping-Jiang/Bluetooth-btmtksdio-enable-bluetooth-wakeup-in-system-suspend/20231012-064116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20231011153928.kernel.v2.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc%40changeid
patch subject: [kernel PATCH v2] Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231013/202310131817.oEUPvya8-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310131817.oEUPvya8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310131817.oEUPvya8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btmtksdio.c:1501:12: warning: 'btmtksdio_system_resume' defined but not used [-Wunused-function]
    1501 | static int btmtksdio_system_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btmtksdio.c:1464:12: warning: 'btmtksdio_system_suspend' defined but not used [-Wunused-function]
    1464 | static int btmtksdio_system_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/btmtksdio_system_resume +1501 drivers/bluetooth/btmtksdio.c

  1463	
> 1464	static int btmtksdio_system_suspend(struct device *dev)
  1465	{
  1466		struct sdio_func *func = dev_to_sdio_func(dev);
  1467		struct btmtksdio_dev *bdev;
  1468	
  1469		bdev = sdio_get_drvdata(func);
  1470		if (!bdev)
  1471			return 0;
  1472	
  1473		if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
  1474			return 0;
  1475	
  1476		set_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
  1477	
  1478		return btmtksdio_runtime_suspend(dev);
  1479	}
  1480	
  1481	static int btmtksdio_runtime_resume(struct device *dev)
  1482	{
  1483		struct sdio_func *func = dev_to_sdio_func(dev);
  1484		struct btmtksdio_dev *bdev;
  1485		int err;
  1486	
  1487		bdev = sdio_get_drvdata(func);
  1488		if (!bdev)
  1489			return 0;
  1490	
  1491		if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
  1492			return 0;
  1493	
  1494		err = btmtksdio_drv_pmctrl(bdev);
  1495	
  1496		bt_dev_dbg(bdev->hdev, "status (%d) get ownership from device", err);
  1497	
  1498		return err;
  1499	}
  1500	
> 1501	static int btmtksdio_system_resume(struct device *dev)
  1502	{
  1503		return btmtksdio_runtime_resume(dev);
  1504	}
  1505	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
