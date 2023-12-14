Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61281339B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573560AbjLNOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573555AbjLNOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:52:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CB5126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702565556; x=1734101556;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lTRioS0QEgs7rSgwCd56I3ckeoahvMBtAz3of/pygCU=;
  b=VK5N/bcVPf0CjYilW9+tg4r2WBlYI/BFZVmwAY9+1Q6DVqOZadzFcPX5
   BxLrj/SbAoiWzuAd1QLtIuZrbcqg+klWoXWYOIZ0z30e74MRmMebbXyTu
   P6gxyHCkqIyjAcvwo0ChoSj+hHhSng+E8xR7F/lGYeK4Jf1aHgxLwb/uI
   0jOfu+vyDR+ySc4VzruMoW4miGnHAX32BB/XyMLz7RQe7OeC+Q4M+ekzy
   i2zsfmOTJqxdqBWJkcU0ygltMrVw7A635Pth87Nt8LaiEPm9MP3DpA04H
   FkNS9u+kVBWt+dobHs4JikeYARLpPbWhsIJ76FNfeS8ISL660AOZpJpOa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392303417"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="392303417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:52:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892491875"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="892491875"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2023 06:52:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDn4i-000MBm-1j;
        Thu, 14 Dec 2023 14:52:32 +0000
Date:   Thu, 14 Dec 2023 22:51:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geoff Levand <geoff@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>
Subject: drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202312142250.7GMllD1E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: bebe933d35a63d4f042fbf4dce4f22e689ba0fcd net/ps3_gelic_net: Use dma_mapping_error
date:   9 months ago
config: powerpc64-randconfig-r122-20231213 (https://download.01.org/0day-ci/archive/20231214/202312142250.7GMllD1E-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312142250.7GMllD1E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312142250.7GMllD1E-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] bus_addr @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse:     expected unsigned long long [usertype] bus_addr
   drivers/net/ethernet/toshiba/ps3_gelic_net.c:330:33: sparse:     got restricted __be32 [usertype]

vim +330 drivers/net/ethernet/toshiba/ps3_gelic_net.c

   295	
   296	/**
   297	 * gelic_card_init_chain - links descriptor chain
   298	 * @card: card structure
   299	 * @chain: address of chain
   300	 * @start_descr: address of descriptor array
   301	 * @no: number of descriptors
   302	 *
   303	 * we manage a circular list that mirrors the hardware structure,
   304	 * except that the hardware uses bus addresses.
   305	 *
   306	 * returns 0 on success, <0 on failure
   307	 */
   308	static int gelic_card_init_chain(struct gelic_card *card,
   309					 struct gelic_descr_chain *chain,
   310					 struct gelic_descr *start_descr, int no)
   311	{
   312		int i;
   313		struct gelic_descr *descr;
   314	
   315		descr = start_descr;
   316		memset(descr, 0, sizeof(*descr) * no);
   317	
   318		/* set up the hardware pointers in each descriptor */
   319		for (i = 0; i < no; i++, descr++) {
   320			dma_addr_t cpu_addr;
   321	
   322			gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
   323	
   324			cpu_addr = dma_map_single(ctodev(card), descr,
   325						  GELIC_DESCR_SIZE, DMA_BIDIRECTIONAL);
   326	
   327			if (dma_mapping_error(ctodev(card), cpu_addr))
   328				goto iommu_error;
   329	
 > 330			descr->bus_addr = cpu_to_be32(cpu_addr);
   331			descr->next = descr + 1;
   332			descr->prev = descr - 1;
   333		}
   334		/* make them as ring */
   335		(descr - 1)->next = start_descr;
   336		start_descr->prev = (descr - 1);
   337	
   338		/* chain bus addr of hw descriptor */
   339		descr = start_descr;
   340		for (i = 0; i < no; i++, descr++) {
   341			descr->next_descr_addr = cpu_to_be32(descr->next->bus_addr);
   342		}
   343	
   344		chain->head = start_descr;
   345		chain->tail = start_descr;
   346	
   347		/* do not chain last hw descriptor */
   348		(descr - 1)->next_descr_addr = 0;
   349	
   350		return 0;
   351	
   352	iommu_error:
   353		for (i--, descr--; 0 <= i; i--, descr--)
   354			if (descr->bus_addr)
   355				dma_unmap_single(ctodev(card), descr->bus_addr,
   356						 GELIC_DESCR_SIZE,
   357						 DMA_BIDIRECTIONAL);
   358		return -ENOMEM;
   359	}
   360	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
