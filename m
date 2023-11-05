Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFD7E142A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjKEPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKEPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:51:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C3C0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 07:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699199504; x=1730735504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vsDGtTih5R1LxdZ6E1a/SlhkvP4UYilP3ZPq/ENW6C8=;
  b=iSi5b2n7nkJ1YE4A1a84CGEOZLXGhVi3dIxETKX5ujuxIwyaYBcyr1F3
   yQt1vJzPWNOQysTclIcARE22MahAjqke++8+FmYGDXeTyrvDJGfieJslg
   xi+PXks1OcsKkGMdiRiS4ROBmLjM/jGX5tEwhwqYJ532gFW8Jzmhc6JBY
   WHjbWxNV3ZqZta5l/AZJ83gKoexbBVzGdA8fIdnMtc15USQqapeQev9El
   rGXSsNf0DTkuRXf82ToAUapGMc1jEHkhu0W7PnNBawmdqgeu5obfTiP4Y
   C76rN8ZkfCZbuAKhbd4dCkyY5K1Bs12qvYLBu2U60spBzMTycNHAp22M1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10696386"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="10696386"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 07:51:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="827991588"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="827991588"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Nov 2023 07:51:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzfPY-0005Zf-0U;
        Sun, 05 Nov 2023 15:51:40 +0000
Date:   Sun, 5 Nov 2023 23:50:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Shych <michaelsh@mellanox.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: drivers/watchdog/mlx_wdt.c:53: warning: Function parameter or member
 'wdt_type' not described in 'mlxreg_wdt'
Message-ID: <202311052354.IwChUoiA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: c60923dd5feedc337b1450e3f4c6e19ffa305439 watchdog: mlx-wdt: introduce a watchdog driver for Mellanox systems.
date:   4 years, 8 months ago
config: i386-buildonly-randconfig-005-20231101 (https://download.01.org/0day-ci/archive/20231105/202311052354.IwChUoiA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311052354.IwChUoiA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311052354.IwChUoiA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/mlx_wdt.c:53: warning: Function parameter or member 'wdt_type' not described in 'mlxreg_wdt'


vim +53 drivers/watchdog/mlx_wdt.c

    20	
    21	#define MLXREG_WDT_CLOCK_SCALE		1000
    22	#define MLXREG_WDT_MAX_TIMEOUT_TYPE1	32
    23	#define MLXREG_WDT_MAX_TIMEOUT_TYPE2	255
    24	#define MLXREG_WDT_MIN_TIMEOUT		1
    25	#define MLXREG_WDT_OPTIONS_BASE (WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | \
    26					 WDIOF_SETTIMEOUT)
    27	
    28	/**
    29	 * struct mlxreg_wdt - wd private data:
    30	 *
    31	 * @wdd:	watchdog device;
    32	 * @device:	basic device;
    33	 * @pdata:	data received from platform driver;
    34	 * @regmap:	register map of parent device;
    35	 * @timeout:	defined timeout in sec.;
    36	 * @action_idx:	index for direct access to action register;
    37	 * @timeout_idx:index for direct access to TO register;
    38	 * @tleft_idx:	index for direct access to time left register;
    39	 * @ping_idx:	index for direct access to ping register;
    40	 * @reset_idx:	index for direct access to reset cause register;
    41	 * @wd_type:	watchdog HW type;
    42	 */
    43	struct mlxreg_wdt {
    44		struct watchdog_device wdd;
    45		struct mlxreg_core_platform_data *pdata;
    46		void *regmap;
    47		int action_idx;
    48		int timeout_idx;
    49		int tleft_idx;
    50		int ping_idx;
    51		int reset_idx;
    52		enum mlxreg_wdt_type wdt_type;
  > 53	};
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
