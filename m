Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E27E162F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKEUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKEUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:06:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE7DD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699214810; x=1730750810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L6kf2H7SMLX8WkeM/SiV7kYAoVks+IUcy3FqwlIhpx4=;
  b=JUnDU2HY7U25wyXwpeUEKadL071P88raukqP0+ikLJBjGXlOjKg8p2y7
   8xPl01TdEFxcIgIU0m0TiQV4dg7Lsq4Z391W1yDVQOPWhBUC5qU5+IPTU
   6g7+hPZKNHxDgqDc+3X5h8tQLyflLpFLUv0yHMRz+I+cmGpAG6H6S4kkn
   bljx4GfY06ovfO8566XJHfHNhBCXZM0aaPRzwOzV14C3uWzY439bRodeT
   BAM5I7IUXybGOpjxpSh6RIBAiBp+Pc1kAJPbwDLWU8tHxFbwdsVJ3CkwV
   3Zf+1rwvi05s9ebqKQyloGW3o2LAzqOvyQVsKUr5U0mA+GQzSMbSBuyB/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10710203"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="10710203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 12:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="905862698"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="905862698"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2023 12:06:48 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzjOO-0005l2-0A;
        Sun, 05 Nov 2023 20:06:46 +0000
Date:   Mon, 6 Nov 2023 04:06:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/memory/emif.c:70: warning: Function parameter or member
 'lpmode' not described in 'emif_data'
Message-ID: <202311060334.FTxzcZED-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: ea0c0ad6b6eb36726088991d97a55b99cae456d0 memory: Enable compile testing for most of the drivers
date:   3 years, 3 months ago
config: i386-buildonly-randconfig-001-20231101 (https://download.01.org/0day-ci/archive/20231106/202311060334.FTxzcZED-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060334.FTxzcZED-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060334.FTxzcZED-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/memory/emif.c:70: warning: Function parameter or member 'lpmode' not described in 'emif_data'
>> drivers/memory/emif.c:70: warning: Function parameter or member 'irq_state' not described in 'emif_data'
   drivers/memory/emif.c:70: warning: Function parameter or member 'addressing' not described in 'emif_data'


vim +70 drivers/memory/emif.c

7ec944538dde3d Aneesh V 2012-04-27  30  
7ec944538dde3d Aneesh V 2012-04-27  31  /**
7ec944538dde3d Aneesh V 2012-04-27  32   * struct emif_data - Per device static data for driver's use
7ec944538dde3d Aneesh V 2012-04-27  33   * @duplicate:			Whether the DDR devices attached to this EMIF
7ec944538dde3d Aneesh V 2012-04-27  34   *				instance are exactly same as that on EMIF1. In
7ec944538dde3d Aneesh V 2012-04-27  35   *				this case we can save some memory and processing
7ec944538dde3d Aneesh V 2012-04-27  36   * @temperature_level:		Maximum temperature of LPDDR2 devices attached
7ec944538dde3d Aneesh V 2012-04-27  37   *				to this EMIF - read from MR4 register. If there
7ec944538dde3d Aneesh V 2012-04-27  38   *				are two devices attached to this EMIF, this
7ec944538dde3d Aneesh V 2012-04-27  39   *				value is the maximum of the two temperature
7ec944538dde3d Aneesh V 2012-04-27  40   *				levels.
7ec944538dde3d Aneesh V 2012-04-27  41   * @node:			node in the device list
7ec944538dde3d Aneesh V 2012-04-27  42   * @base:			base address of memory-mapped IO registers.
7ec944538dde3d Aneesh V 2012-04-27  43   * @dev:			device pointer.
a93de288aad3b0 Aneesh V 2012-04-27  44   * @addressing			table with addressing information from the spec
a93de288aad3b0 Aneesh V 2012-04-27  45   * @regs_cache:			An array of 'struct emif_regs' that stores
a93de288aad3b0 Aneesh V 2012-04-27  46   *				calculated register values for different
a93de288aad3b0 Aneesh V 2012-04-27  47   *				frequencies, to avoid re-calculating them on
a93de288aad3b0 Aneesh V 2012-04-27  48   *				each DVFS transition.
a93de288aad3b0 Aneesh V 2012-04-27  49   * @curr_regs:			The set of register values used in the last
a93de288aad3b0 Aneesh V 2012-04-27  50   *				frequency change (i.e. corresponding to the
a93de288aad3b0 Aneesh V 2012-04-27  51   *				frequency in effect at the moment)
7ec944538dde3d Aneesh V 2012-04-27  52   * @plat_data:			Pointer to saved platform data.
aac10aaa8cc65a Aneesh V 2012-04-27  53   * @debugfs_root:		dentry to the root folder for EMIF in debugfs
e6b42eb6a66c18 Aneesh V 2012-08-17  54   * @np_ddr:			Pointer to ddr device tree node
7ec944538dde3d Aneesh V 2012-04-27  55   */
7ec944538dde3d Aneesh V 2012-04-27  56  struct emif_data {
7ec944538dde3d Aneesh V 2012-04-27  57  	u8				duplicate;
7ec944538dde3d Aneesh V 2012-04-27  58  	u8				temperature_level;
a93de288aad3b0 Aneesh V 2012-04-27  59  	u8				lpmode;
7ec944538dde3d Aneesh V 2012-04-27  60  	struct list_head		node;
a93de288aad3b0 Aneesh V 2012-04-27  61  	unsigned long			irq_state;
7ec944538dde3d Aneesh V 2012-04-27  62  	void __iomem			*base;
7ec944538dde3d Aneesh V 2012-04-27  63  	struct device			*dev;
a93de288aad3b0 Aneesh V 2012-04-27  64  	const struct lpddr2_addressing	*addressing;
a93de288aad3b0 Aneesh V 2012-04-27  65  	struct emif_regs		*regs_cache[EMIF_MAX_NUM_FREQUENCIES];
a93de288aad3b0 Aneesh V 2012-04-27  66  	struct emif_regs		*curr_regs;
7ec944538dde3d Aneesh V 2012-04-27  67  	struct emif_platform_data	*plat_data;
aac10aaa8cc65a Aneesh V 2012-04-27  68  	struct dentry			*debugfs_root;
e6b42eb6a66c18 Aneesh V 2012-08-17  69  	struct device_node		*np_ddr;
7ec944538dde3d Aneesh V 2012-04-27 @70  };
7ec944538dde3d Aneesh V 2012-04-27  71  

:::::: The code at line 70 was first introduced by commit
:::::: 7ec944538dde3d7f490bd4d2619051789db5c3c3 memory: emif: add basic infrastructure for EMIF driver

:::::: TO: Aneesh V <aneesh@ti.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
