Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE27CEF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjJSFe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJSFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:34:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2925AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697693695; x=1729229695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j/QOEn48eWnyDqQXpzhGrBqLpy61zi9uI3SGgy9JUGE=;
  b=n2vkBgrxlSgEoDKaUaUrcZ02iZhUlOYa+BoVX1BmoRJxjaoe5sqB4g6M
   MwPD0pTmGF30bhL9LZfio1RT6kRClZEoD2RBcIkWlJ4oMVyf3p5gGbEA3
   UCSgNuBveoZ/KE8KFcs3SK118FQog4DePoXNLbNbWw1YsKxlvogt71yaM
   rdvHn5SwUrzmI3681833ZaY4Xac0bmgblanXTV1Ci0V+BOmweeOnXA8kD
   VA51QtnLdz6JRz86Dzvi689ZIcFVhEx/BSaMKQMk0Snk2BpfHOiOs5kIn
   yUoFe0zNhZHwyd+1RDTfuTRVF6o5HABw3xRjmhVMvySlaoZ9lEkZuGeyx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371241452"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="371241452"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 22:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="880512820"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="880512820"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Oct 2023 22:34:52 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtLgI-0001gu-11;
        Thu, 19 Oct 2023 05:34:50 +0000
Date:   Thu, 19 Oct 2023 13:34:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shai Malin <smalin@marvell.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: drivers/net/ethernet/qlogic/qede/qede_ethtool.c:631:37: warning:
 'snprintf' output may be truncated before the last format character
Message-ID: <202310191331.IGbTQDtZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: 88ea96f8c14e39f7ee397b815de622ea5e1481ab qede: Remove the qede module version
date:   2 years, 3 months ago
config: sparc64-allyesconfig (https://download.01.org/0day-ci/archive/20231019/202310191331.IGbTQDtZ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191331.IGbTQDtZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191331.IGbTQDtZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/qlogic/qede/qede_ethtool.c: In function 'qede_get_drvinfo':
>> drivers/net/ethernet/qlogic/qede/qede_ethtool.c:631:37: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     631 |                          "[storm %s]", storm);
         |                                     ^
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:630:17: note: 'snprintf' output between 9 and 33 bytes into a destination of size 32
     630 |                 snprintf(info->version, sizeof(info->version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     631 |                          "[storm %s]", storm);
         |                          ~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:648:31: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 28 [-Wformat-truncation=]
     648 |                          "mfw %s", mfw);
         |                               ^~   ~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:647:17: note: 'snprintf' output between 5 and 36 bytes into a destination of size 32
     647 |                 snprintf(info->fw_version, sizeof(info->fw_version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     648 |                          "mfw %s", mfw);
         |                          ~~~~~~~~~~~~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:645:31: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 28 [-Wformat-truncation=]
     645 |                          "mbi %s [mfw %s]", mbi, mfw);
         |                               ^~            ~~~
   drivers/net/ethernet/qlogic/qede/qede_ethtool.c:644:17: note: 'snprintf' output between 12 and 74 bytes into a destination of size 32
     644 |                 snprintf(info->fw_version, sizeof(info->fw_version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     645 |                          "mbi %s [mfw %s]", mbi, mfw);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +631 drivers/net/ethernet/qlogic/qede/qede_ethtool.c

   606	
   607	static void qede_get_drvinfo(struct net_device *ndev,
   608				     struct ethtool_drvinfo *info)
   609	{
   610		char mfw[ETHTOOL_FWVERS_LEN], storm[ETHTOOL_FWVERS_LEN];
   611		struct qede_dev *edev = netdev_priv(ndev);
   612		char mbi[ETHTOOL_FWVERS_LEN];
   613	
   614		strlcpy(info->driver, "qede", sizeof(info->driver));
   615	
   616		snprintf(storm, ETHTOOL_FWVERS_LEN, "%d.%d.%d.%d",
   617			 edev->dev_info.common.fw_major,
   618			 edev->dev_info.common.fw_minor,
   619			 edev->dev_info.common.fw_rev,
   620			 edev->dev_info.common.fw_eng);
   621	
   622		snprintf(mfw, ETHTOOL_FWVERS_LEN, "%d.%d.%d.%d",
   623			 (edev->dev_info.common.mfw_rev >> 24) & 0xFF,
   624			 (edev->dev_info.common.mfw_rev >> 16) & 0xFF,
   625			 (edev->dev_info.common.mfw_rev >> 8) & 0xFF,
   626			 edev->dev_info.common.mfw_rev & 0xFF);
   627	
   628		if ((strlen(storm) + strlen("[storm]")) <
   629		    sizeof(info->version))
   630			snprintf(info->version, sizeof(info->version),
 > 631				 "[storm %s]", storm);
   632		else
   633			snprintf(info->version, sizeof(info->version),
   634				 "%s", storm);
   635	
   636		if (edev->dev_info.common.mbi_version) {
   637			snprintf(mbi, ETHTOOL_FWVERS_LEN, "%d.%d.%d",
   638				 (edev->dev_info.common.mbi_version &
   639				  QED_MBI_VERSION_2_MASK) >> QED_MBI_VERSION_2_OFFSET,
   640				 (edev->dev_info.common.mbi_version &
   641				  QED_MBI_VERSION_1_MASK) >> QED_MBI_VERSION_1_OFFSET,
   642				 (edev->dev_info.common.mbi_version &
   643				  QED_MBI_VERSION_0_MASK) >> QED_MBI_VERSION_0_OFFSET);
   644			snprintf(info->fw_version, sizeof(info->fw_version),
   645				 "mbi %s [mfw %s]", mbi, mfw);
   646		} else {
   647			snprintf(info->fw_version, sizeof(info->fw_version),
   648				 "mfw %s", mfw);
   649		}
   650	
   651		strlcpy(info->bus_info, pci_name(edev->pdev), sizeof(info->bus_info));
   652	}
   653	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
