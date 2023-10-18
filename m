Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2740A7CDBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjJRMcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJRMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:32:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400BA3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697632369; x=1729168369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=edlUW0k4bBSUPRTq7qVPc2VBSGIswnTNFih/PLx/tSI=;
  b=NHtCPWfP+8JuawuSmOUsMKzMn/lPpnbVFH96X9Snnazsca4M+NaBW0UU
   DvK36Oo5xawq3kjHWHFrEwQqzub2ncLv0niGf6Fxr5Q2yiNlieTK5UiGc
   p1ATD+D/Vle5H1hUItssCZQwQNFrs/IZaMxKHZ6+4ZJnVLTIzkc5L/qoH
   NEdhLVDfGFcPIBfLwb5hQ6jP8N0FL6WUmUyJY7eGIGs00aWWq38eu5lo1
   V4IweImoGJjFQyg4EeFheHverSR9eMtlcsOdXrp6TO6QZoBZSohM1xVPI
   fXe53SxVufg+SD5fuvQVZijGkV0eaOxwTXePYscUXebRi8FIuTKGYcwp7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="366260737"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="366260737"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822424248"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="822424248"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2023 05:32:47 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt5jB-0000M4-1T;
        Wed, 18 Oct 2023 12:32:45 +0000
Date:   Wed, 18 Oct 2023 20:32:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:776:9: warning:
 '.bin' directive output may be truncated writing 4 bytes into a region of
 size between 3 and 11
Message-ID: <202310182014.0kOuH8vx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: b217127e5e4ee0ecfce7c5f84cfe082238123bda mlxsw: core_linecards: Add line card objects and implement provisioning
date:   1 year, 6 months ago
config: riscv-randconfig-r001-20230902 (https://download.01.org/0day-ci/archive/20231018/202310182014.0kOuH8vx-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182014.0kOuH8vx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182014.0kOuH8vx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c: In function 'mlxsw_linecard_types_init.isra':
>> drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:776:9: warning: '.bin' directive output may be truncated writing 4 bytes into a region of size between 3 and 11 [-Wformat-truncation=]
     776 |         "mellanox/lc_ini_bundle_%u_%u.bin"
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:790:24: note: in expansion of macro 'MLXSW_LINECARDS_INI_BUNDLE_FILENAME_FMT'
     790 |                        MLXSW_LINECARDS_INI_BUNDLE_FILENAME_FMT,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:776:38: note: format string is defined here
     776 |         "mellanox/lc_ini_bundle_%u_%u.bin"
         |                                      ^~~~
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:789:15: note: 'snprintf' output between 31 and 39 bytes into a destination of size 37
     789 |         err = snprintf(filename, sizeof(filename),
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     790 |                        MLXSW_LINECARDS_INI_BUNDLE_FILENAME_FMT,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     791 |                        rev->minor, rev->subminor);
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +776 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c

   774	
   775	#define MLXSW_LINECARDS_INI_BUNDLE_FILENAME_FMT \
 > 776		"mellanox/lc_ini_bundle_%u_%u.bin"
   777	#define MLXSW_LINECARDS_INI_BUNDLE_FILENAME_LEN \
   778		(sizeof(MLXSW_LINECARDS_INI_BUNDLE_FILENAME_FMT) + 4)
   779	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
