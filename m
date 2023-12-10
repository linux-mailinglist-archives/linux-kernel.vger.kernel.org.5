Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5293B80B855
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 02:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjLJBmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 20:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 20:42:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C511F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 17:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702172537; x=1733708537;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SMEZ4HuQuME2VWmNwxyLBdE71XJ/nCF16hw7yXXy2Fo=;
  b=O2o0qZr6yxOC+eACaPL7VcBm0aoUwy3zFmkz1I+KZiLKS2arc859cPWw
   3PvHKfUmekcXegMobfx/NMreUtcNrsWLeje4o/O/ngWCPzPY++U+VRvUh
   c0jV2+B5v7/Pfi3FGr5bYlH7qObD6xlnpn5ibpGxWL12c43TcdFJaVSzx
   MvO4nzrVCjarAP5EGjZwTJCRcsVwY7SUyBhhSs8kwS7H+zd5z7T9Q3hlJ
   JDLDuKaFqXEzh07SswiG0xn/mrLUJmLdtX+WoD2TE3VXBagwo6ChOABBt
   wYvM1q/k1jiiINjz8AW3kwSq/sYL4iQeUQI9AFItqgw916dhlOfhypaGl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="379533376"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="379533376"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 17:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="843030579"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="843030579"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2023 17:42:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC8pg-000GFR-1p;
        Sun, 10 Dec 2023 01:42:12 +0000
Date:   Sun, 10 Dec 2023 09:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:38: warning:
 '%d' directive output may be truncated writing between 1 and 11 bytes into a
 region of size between 5 and 20
Message-ID: <202312100937.ZPZCARhB-lkp@intel.com>
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
head:   21b73ffcc62ab772bc06e3e90bd87eff5e9e8ed4
commit: d0a3ac549f389c1511a4df0d7638536305205d20 ubsan: enable for all*config builds
date:   3 years ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231210/202312100937.ZPZCARhB-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100937.ZPZCARhB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100937.ZPZCARhB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c: In function 'cxgb_up':
>> drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
     394 |                                  "%s-%d", d->name, pi->first_qset + i);
         |                                      ^~
   In function 'name_msix_vecs',
       inlined from 'cxgb_up' at drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:1264:3:
   drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:34: note: directive argument in the range [-2147483641, 509]
     394 |                                  "%s-%d", d->name, pi->first_qset + i);
         |                                  ^~~~~~~
   drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:393:25: note: 'snprintf' output between 3 and 28 bytes into a destination of size 21
     393 |                         snprintf(adap->msix_info[msi_idx].desc, n,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     394 |                                  "%s-%d", d->name, pi->first_qset + i);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/amd/xgbe/xgbe-drv.c: In function 'xgbe_alloc_channels':
>> drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:73: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 8 [-Wformat-truncation=]
     211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
         |                                                                         ^~
   drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:64: note: directive argument in the range [0, 4294967294]
     211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
         |                                                                ^~~~~~~~~~~~
   drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:17: note: 'snprintf' output between 10 and 19 bytes into a destination of size 16
     211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +394 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c

4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  377  
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  378  /*
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  379   * Name the MSI-X interrupts.
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  380   */
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  381  static void name_msix_vecs(struct adapter *adap)
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  382  {
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  383  	int i, j, msi_idx = 1, n = sizeof(adap->msix_info[0].desc) - 1;
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  384  
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  385  	snprintf(adap->msix_info[0].desc, n, "%s", adap->name);
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  386  	adap->msix_info[0].desc[n] = 0;
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  387  
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  388  	for_each_port(adap, j) {
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  389  		struct net_device *d = adap->port[j];
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  390  		const struct port_info *pi = netdev_priv(d);
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  391  
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  392  		for (i = 0; i < pi->nqsets; i++, msi_idx++) {
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  393  			snprintf(adap->msix_info[msi_idx].desc, n,
8c26376112fb4b drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2008-10-08 @394  				 "%s-%d", d->name, pi->first_qset + i);
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  395  			adap->msix_info[msi_idx].desc[n] = 0;
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  396  		}
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  397  	}
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  398  }
4d22de3e6cc4a0 drivers/net/cxgb3/cxgb3_main.c Divy Le Ray 2007-01-18  399  

:::::: The code at line 394 was first introduced by commit
:::::: 8c26376112fb4b8dfea42069b602c03d53366052 cxgb3: Allocate multiqueues at init time

:::::: TO: Divy Le Ray <divy@chelsio.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
