Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6447B26EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjI1VAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjI1VAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:00:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581019D;
        Thu, 28 Sep 2023 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695934833; x=1727470833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6plKqUY39TQMJV0iebt7XT6W09lt/hQ5+xdiVKqIraw=;
  b=YW3a7rmJ+9jpZ+pW+HKjkD8JvdjD7VDOQphLl2iDjUJejPKh0+B2UZx6
   kPg99BkDNSnbZCNXXN96bN13cxKT3gn0QSy+f3H5h5rubaTMTwo92hI7L
   HbRNSDEBpp1MMu/vLAyuBFERBSKhjO8SFTxYv68WUxCR3O1vcdIGLkctQ
   aLlG0wiW3Sa9kjSyd8r5HGhhAS8HeOySJOUIf6SVpwtwGK1XcR8GdnY5W
   QNR/M4FbfosPLc/Qd3KP8RKCcctCf/LBgRj52KK5yW9eoCX5yQnFejS23
   2PnNrsHKtLHzJNuTn3le+7E9tzhR9cCQyfQ4YF12Cmch5xwtFk/tiaRHt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="386040043"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="386040043"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 14:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="873436155"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="873436155"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2023 14:00:30 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qly7X-0001xJ-3B;
        Thu, 28 Sep 2023 21:00:27 +0000
Date:   Fri, 29 Sep 2023 05:00:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com,
        Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v9 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202309290449.7BfzQ7jq-lkp@intel.com>
References: <20230928104920.113511-13-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928104920.113511-13-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20230928-185229
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230928104920.113511-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v9 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290449.7BfzQ7jq-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290449.7BfzQ7jq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290449.7BfzQ7jq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_open':
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1140:25: warning: 'snprintf' argument 4 may overlap destination object 'dev' [-Wrestrict]
    1140 |                         snprintf(ivec->name, sizeof(ivec->name), "%s_int%i", dev->name, i);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1105:42: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
    1105 | static int rtase_open(struct net_device *dev)
         |                       ~~~~~~~~~~~~~~~~~~~^~~


vim +1140 drivers/net/ethernet/realtek/rtase/rtase_main.c

35c3134a765bbcb Justin Lai 2023-09-28  1104  
1f431ee317f33f8 Justin Lai 2023-09-28  1105  static int rtase_open(struct net_device *dev)
1f431ee317f33f8 Justin Lai 2023-09-28  1106  {
1f431ee317f33f8 Justin Lai 2023-09-28  1107  	struct rtase_private *tp = netdev_priv(dev);
1f431ee317f33f8 Justin Lai 2023-09-28  1108  	struct rtase_int_vector *ivec = &tp->int_vector[0];
1f431ee317f33f8 Justin Lai 2023-09-28  1109  	const struct pci_dev *pdev = tp->pdev;
1f431ee317f33f8 Justin Lai 2023-09-28  1110  	int ret;
1f431ee317f33f8 Justin Lai 2023-09-28  1111  	u16 i;
1f431ee317f33f8 Justin Lai 2023-09-28  1112  
1f431ee317f33f8 Justin Lai 2023-09-28  1113  	rtase_set_rxbufsize(tp, dev);
1f431ee317f33f8 Justin Lai 2023-09-28  1114  
1f431ee317f33f8 Justin Lai 2023-09-28  1115  	ret = rtase_alloc_desc(tp);
1f431ee317f33f8 Justin Lai 2023-09-28  1116  	if (ret)
1f431ee317f33f8 Justin Lai 2023-09-28  1117  		goto err_free_all_allocated_mem;
1f431ee317f33f8 Justin Lai 2023-09-28  1118  
1f431ee317f33f8 Justin Lai 2023-09-28  1119  	ret = rtase_init_ring(dev);
1f431ee317f33f8 Justin Lai 2023-09-28  1120  	if (ret)
1f431ee317f33f8 Justin Lai 2023-09-28  1121  		goto err_free_all_allocated_mem;
1f431ee317f33f8 Justin Lai 2023-09-28  1122  
1f431ee317f33f8 Justin Lai 2023-09-28  1123  	INIT_DELAYED_WORK(&tp->task, NULL);
1f431ee317f33f8 Justin Lai 2023-09-28  1124  
1f431ee317f33f8 Justin Lai 2023-09-28  1125  	rtase_hw_config(dev);
1f431ee317f33f8 Justin Lai 2023-09-28  1126  
1f431ee317f33f8 Justin Lai 2023-09-28  1127  	if (tp->sw_flag & SWF_MSIX_ENABLED) {
1f431ee317f33f8 Justin Lai 2023-09-28  1128  		ret = request_irq(ivec->irq, rtase_interrupt, 0,
1f431ee317f33f8 Justin Lai 2023-09-28  1129  				  dev->name, ivec);
1f431ee317f33f8 Justin Lai 2023-09-28  1130  
1f431ee317f33f8 Justin Lai 2023-09-28  1131  		/* request other interrupts to handle multiqueue */
1f431ee317f33f8 Justin Lai 2023-09-28  1132  		for (i = 1; i < tp->int_nums; i++) {
1f431ee317f33f8 Justin Lai 2023-09-28  1133  			if (ret)
1f431ee317f33f8 Justin Lai 2023-09-28  1134  				continue;
1f431ee317f33f8 Justin Lai 2023-09-28  1135  
1f431ee317f33f8 Justin Lai 2023-09-28  1136  			ivec = &tp->int_vector[i];
1f431ee317f33f8 Justin Lai 2023-09-28  1137  			if (ivec->status != 1)
1f431ee317f33f8 Justin Lai 2023-09-28  1138  				continue;
1f431ee317f33f8 Justin Lai 2023-09-28  1139  
1f431ee317f33f8 Justin Lai 2023-09-28 @1140  			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i", dev->name, i);
1f431ee317f33f8 Justin Lai 2023-09-28  1141  			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
1f431ee317f33f8 Justin Lai 2023-09-28  1142  					  ivec->name, ivec);
1f431ee317f33f8 Justin Lai 2023-09-28  1143  		}
1f431ee317f33f8 Justin Lai 2023-09-28  1144  	} else if (tp->sw_flag & SWF_MSI_ENABLED) {
1f431ee317f33f8 Justin Lai 2023-09-28  1145  		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
1f431ee317f33f8 Justin Lai 2023-09-28  1146  				  ivec);
1f431ee317f33f8 Justin Lai 2023-09-28  1147  	} else {
1f431ee317f33f8 Justin Lai 2023-09-28  1148  		ret = request_irq(pdev->irq, rtase_interrupt, IRQF_SHARED,
1f431ee317f33f8 Justin Lai 2023-09-28  1149  				  dev->name, ivec);
1f431ee317f33f8 Justin Lai 2023-09-28  1150  	}
1f431ee317f33f8 Justin Lai 2023-09-28  1151  
1f431ee317f33f8 Justin Lai 2023-09-28  1152  	if (ret != 0) {
1f431ee317f33f8 Justin Lai 2023-09-28  1153  		netdev_err(dev, "can't request MSIX interrupt. Error: %d", ret);
1f431ee317f33f8 Justin Lai 2023-09-28  1154  		goto err_free_all_allocated_mem;
1f431ee317f33f8 Justin Lai 2023-09-28  1155  	}
1f431ee317f33f8 Justin Lai 2023-09-28  1156  
1f431ee317f33f8 Justin Lai 2023-09-28  1157  	rtase_hw_start(dev);
1f431ee317f33f8 Justin Lai 2023-09-28  1158  
1f431ee317f33f8 Justin Lai 2023-09-28  1159  	netif_carrier_on(dev);
1f431ee317f33f8 Justin Lai 2023-09-28  1160  	netif_wake_queue(dev);
1f431ee317f33f8 Justin Lai 2023-09-28  1161  	netdev_info(dev, "link up\n");
1f431ee317f33f8 Justin Lai 2023-09-28  1162  
1f431ee317f33f8 Justin Lai 2023-09-28  1163  	goto out;
1f431ee317f33f8 Justin Lai 2023-09-28  1164  
1f431ee317f33f8 Justin Lai 2023-09-28  1165  err_free_all_allocated_mem:
1f431ee317f33f8 Justin Lai 2023-09-28  1166  	rtase_free_desc(tp);
1f431ee317f33f8 Justin Lai 2023-09-28  1167  
1f431ee317f33f8 Justin Lai 2023-09-28  1168  out:
1f431ee317f33f8 Justin Lai 2023-09-28  1169  	return ret;
1f431ee317f33f8 Justin Lai 2023-09-28  1170  }
1f431ee317f33f8 Justin Lai 2023-09-28  1171  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
