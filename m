Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B768124DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjLNB5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjLNB5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:57:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398A6D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702519043; x=1734055043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NnbzYOWGZweEC3nk9Kynd9O6zWSw1MnE6hKaXG8RDBg=;
  b=Rnw0BZ7Y+PpZV8+wUUqlKlQxKFtLYt8liIWM3JjdGCx27uDlcCCxHZ19
   ULj8LdPOKk3ldlCMjy+ZD7ePuvWEUWORoGZXF1mPf5j7FKHRanLinQKaT
   MYN7BGon0nFRPL153rkkZE0z+mKog3F0pnjV0HDjOQymGICOwUMiUNowt
   UDyZQO+ZaOC6ic/zL0fECoPe0UK+UwC2B34s25Tx4tzwDRhTBelL0pJLT
   v+wphNwZFrFHoosTD/sShE+vhFbD/ly4/n6D68j2NOgnKib/iNug3Ud4m
   u2XCPcGQOXDuQnGqUNRV0APVHVBLaR75Ys+VCbZ8/gCKlRrw3bDaaZLfH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8450345"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="8450345"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844534199"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="844534199"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2023 17:57:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDayV-000LPP-26;
        Thu, 14 Dec 2023 01:57:19 +0000
Date:   Thu, 14 Dec 2023 09:56:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/edac/cpc925_edac.c:314:40: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202312140910.pdMaZpsA-lkp@intel.com>
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
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: e3c4ff6d8c949fa9a9ea1bd005bf1967efe09d5d EDAC: Remove EDAC_MM_EDAC
date:   7 years ago
config: powerpc64-randconfig-r113-20231118 (https://download.01.org/0day-ci/archive/20231214/202312140910.pdMaZpsA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312140910.pdMaZpsA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140910.pdMaZpsA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/edac/cpc925_edac.c:314:40: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const *[assigned] reg @@
   drivers/edac/cpc925_edac.c:314:40: sparse:     expected restricted __be32 const [usertype] *cell
   drivers/edac/cpc925_edac.c:314:40: sparse:     got unsigned int const *[assigned] reg
   drivers/edac/cpc925_edac.c:316:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const *[assigned] reg @@
   drivers/edac/cpc925_edac.c:316:39: sparse:     expected restricted __be32 const [usertype] *cell
   drivers/edac/cpc925_edac.c:316:39: sparse:     got unsigned int const *[assigned] reg
   In file included from drivers/edac/cpc925_edac.c:22:
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'cpc925_edac_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   drivers/edac/cpc925_edac.c:1091:1: note: in expansion of macro 'module_init'
    1091 | module_init(cpc925_edac_init);
         | ^~~~~~~~~~~
   drivers/edac/cpc925_edac.c:1067:19: note: 'init_module' target declared here
    1067 | static int __init cpc925_edac_init(void)
         |                   ^~~~~~~~~~~~~~~~
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'cpc925_edac_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   drivers/edac/cpc925_edac.c:1092:1: note: in expansion of macro 'module_exit'
    1092 | module_exit(cpc925_edac_exit);
         | ^~~~~~~~~~~
   drivers/edac/cpc925_edac.c:1086:20: note: 'cleanup_module' target declared here
    1086 | static void __exit cpc925_edac_exit(void)
         |                    ^~~~~~~~~~~~~~~~

vim +314 drivers/edac/cpc925_edac.c

2a9036afffb3a17 Harry Ciao  2009-06-17  294  
2a9036afffb3a17 Harry Ciao  2009-06-17  295  /* Get total memory size from Open Firmware DTB */
2a9036afffb3a17 Harry Ciao  2009-06-17  296  static void get_total_mem(struct cpc925_mc_pdata *pdata)
2a9036afffb3a17 Harry Ciao  2009-06-17  297  {
2a9036afffb3a17 Harry Ciao  2009-06-17  298  	struct device_node *np = NULL;
2a9036afffb3a17 Harry Ciao  2009-06-17  299  	const unsigned int *reg, *reg_end;
2a9036afffb3a17 Harry Ciao  2009-06-17  300  	int len, sw, aw;
2a9036afffb3a17 Harry Ciao  2009-06-17  301  	unsigned long start, size;
2a9036afffb3a17 Harry Ciao  2009-06-17  302  
2a9036afffb3a17 Harry Ciao  2009-06-17  303  	np = of_find_node_by_type(NULL, "memory");
2a9036afffb3a17 Harry Ciao  2009-06-17  304  	if (!np)
2a9036afffb3a17 Harry Ciao  2009-06-17  305  		return;
2a9036afffb3a17 Harry Ciao  2009-06-17  306  
2a9036afffb3a17 Harry Ciao  2009-06-17  307  	aw = of_n_addr_cells(np);
2a9036afffb3a17 Harry Ciao  2009-06-17  308  	sw = of_n_size_cells(np);
2a9036afffb3a17 Harry Ciao  2009-06-17  309  	reg = (const unsigned int *)of_get_property(np, "reg", &len);
2a9036afffb3a17 Harry Ciao  2009-06-17  310  	reg_end = reg + len/4;
2a9036afffb3a17 Harry Ciao  2009-06-17  311  
2a9036afffb3a17 Harry Ciao  2009-06-17  312  	pdata->total_mem = 0;
2a9036afffb3a17 Harry Ciao  2009-06-17  313  	do {
2a9036afffb3a17 Harry Ciao  2009-06-17 @314  		start = of_read_number(reg, aw);
2a9036afffb3a17 Harry Ciao  2009-06-17  315  		reg += aw;
2a9036afffb3a17 Harry Ciao  2009-06-17  316  		size = of_read_number(reg, sw);
2a9036afffb3a17 Harry Ciao  2009-06-17  317  		reg += sw;
956b9ba156dbfdb Joe Perches 2012-04-29  318  		edac_dbg(1, "start 0x%lx, size 0x%lx\n", start, size);
2a9036afffb3a17 Harry Ciao  2009-06-17  319  		pdata->total_mem += size;
2a9036afffb3a17 Harry Ciao  2009-06-17  320  	} while (reg < reg_end);
2a9036afffb3a17 Harry Ciao  2009-06-17  321  
2a9036afffb3a17 Harry Ciao  2009-06-17  322  	of_node_put(np);
956b9ba156dbfdb Joe Perches 2012-04-29  323  	edac_dbg(0, "total_mem 0x%lx\n", pdata->total_mem);
2a9036afffb3a17 Harry Ciao  2009-06-17  324  }
2a9036afffb3a17 Harry Ciao  2009-06-17  325  

:::::: The code at line 314 was first introduced by commit
:::::: 2a9036afffb3a174e980f90eb507c5aea6b540f6 edac: add CPC925 Memory Controller driver

:::::: TO: Harry Ciao <qingtao.cao@windriver.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
