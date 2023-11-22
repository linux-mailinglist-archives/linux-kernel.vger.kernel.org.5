Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F17F3AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjKVAVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKVAVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:21:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031751AA;
        Tue, 21 Nov 2023 16:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700612508; x=1732148508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=35MXMAtl1zEwDSQjGXH277ubRGImPWuHHmupLDmIkU8=;
  b=d87s0G+LO8r2CFjf4My1rAnhASOJUELiODD+gofq3z25PgTk0cCwpJ3K
   3h2CD2/BTP8xIQ7C7Jhyrm6xnQf8SdKAQnAmuLR9JpCrH92s54QMFGwcM
   bBeyv2BnHDMV6GP3NFrxlN/ZW51H4oQaMwKZ1GvapEYgipxSvHiIa87kP
   ljJS420D6c/q/+ejPgu2MRI66MebJkF7DypR2aRqIJoEbkrDGc/Z1OfPz
   LtNBveTkS9110JULuYLB13+CgwnIMVaELPqWw//Uhx2IA6pr53mJKr6mI
   L5qs9fZv2QhtyzWOKxvcLCW4rCZmdwvq5MZeiqI8akmHUl0FWsL2z8N5q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13501187"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="13501187"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 16:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716666195"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="716666195"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2023 16:21:42 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5azs-0008RK-0l;
        Wed, 22 Nov 2023 00:21:40 +0000
Date:   Wed, 22 Nov 2023 08:20:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com, jyanchou@realtek.com
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Message-ID: <202311220804.qUNiZLTb-lkp@intel.com>
References: <20231121091101.5540-3-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121091101.5540-3-jyanchou@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/mmc-Add-Synopsys-DesignWare-mmc-cmdq-host-driver/20231121-171551
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121091101.5540-3-jyanchou%40realtek.com
patch subject: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
config: mips-randconfig-r133-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220804.qUNiZLTb-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220804.qUNiZLTb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220804.qUNiZLTb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/dw_mmc_cqe.c:39:
>> drivers/mmc/host/dw_mmc_cqe.h:324:9: warning: 'END' macro redefined [-Wmacro-redefined]
     324 | #define END(x)                          (((x) & 1) << 1)
         |         ^
   arch/mips/include/asm/asm.h:69:9: note: previous definition is here
      69 | #define END(function)                                   \
         |         ^
   drivers/mmc/host/dw_mmc_cqe.c:174:3: error: field designator 'setup_tran_desc' does not refer to any field in type 'const struct cqhci_host_ops'
     174 |         .setup_tran_desc = dw_mci_cqe_setup_tran_desc,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/END +324 drivers/mmc/host/dw_mmc_cqe.h

   322	
   323	#define VALID(x)			(((x) & 1) << 0)
 > 324	#define END(x)				(((x) & 1) << 1)
   325	#define INT(x)				(((x) & 1) << 2)
   326	#define ACT(x)				(((x) & 0x7) << 3)
   327	#define DAT_LENGTH(x)			(((x) & 0xFFFF) << 16)
   328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
