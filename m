Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE37B3D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 02:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjI3APR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 20:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3APQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 20:15:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A74AC;
        Fri, 29 Sep 2023 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696032914; x=1727568914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsMZgh2eyIDKptjrwNX6kv3/EuPOIDNld2NVJ0KGEzA=;
  b=WEnjGrpn4Shr1tP0KG1rHHTgjeH0qax3X82CzxPT0KUPffCe5QnPy0Uh
   CYR1JLpnBR4JYfG4P5+17/Ob5lR5q7J3PwNcz3fVR5yDOnK4vjaXhyMIM
   Z0qzI7K1BtTNOTngwHIWjK+KHzvsiboeJUTwkwxyVdUc/+s6g3pw4xq1l
   tiKXOtohCFPlb2GAQpJVBm6G7gc3KZ1J13eFPOrffU2aBXftVg5EabKZv
   EWzrW9VyY48MCvkXI4gFgc+rjIVz/pOGIZ3kkvvLmoW06XagA6kgmtQbg
   JQGnOcxR8Q83xy/rXOE+2az3JubyPhYr5QaZ7IqygD6VmHamp5/MM6bQe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381286465"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381286465"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 17:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743585072"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743585072"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Sep 2023 17:15:09 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmNdT-0003Sh-0R;
        Sat, 30 Sep 2023 00:15:07 +0000
Date:   Sat, 30 Sep 2023 08:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergey Khimich <serghox@gmail.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Add cqhci_set_tran_desc() callback
Message-ID: <202309300806.dcR19kcE-lkp@intel.com>
References: <20230926090242.105020-2-serghox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926090242.105020-2-serghox@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Khimich/mmc-cqhci-Add-cqhci_set_tran_desc-callback/20230926-170331
base:   linus/master
patch link:    https://lore.kernel.org/r/20230926090242.105020-2-serghox%40gmail.com
patch subject: [PATCH v2 1/2] mmc: cqhci: Add cqhci_set_tran_desc() callback
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20230930/202309300806.dcR19kcE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309300806.dcR19kcE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci_am654.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/mmc/host/sdhci_am654.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/mmc/host/sdhci_am654.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/mmc/host/sdhci_am654.c:17:
>> drivers/mmc/host/cqhci.h:296:32: warning: declaration of 'struct mmc_data' will not be visible outside of this function [-Wvisibility]
     296 |         void (*prep_tran_desc)(struct mmc_data *data, struct cqhci_host *cq_host,
         |                                       ^
   7 warnings generated.


vim +296 drivers/mmc/host/cqhci.h

   281	
   282	struct cqhci_host_ops {
   283		void (*dumpregs)(struct mmc_host *mmc);
   284		void (*write_l)(struct cqhci_host *host, u32 val, int reg);
   285		u32 (*read_l)(struct cqhci_host *host, int reg);
   286		void (*enable)(struct mmc_host *mmc);
   287		void (*disable)(struct mmc_host *mmc, bool recovery);
   288		void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
   289					 u64 *data);
   290		void (*pre_enable)(struct mmc_host *mmc);
   291		void (*post_disable)(struct mmc_host *mmc);
   292	#ifdef CONFIG_MMC_CRYPTO
   293		int (*program_key)(struct cqhci_host *cq_host,
   294				   const union cqhci_crypto_cfg_entry *cfg, int slot);
   295	#endif
 > 296		void (*prep_tran_desc)(struct mmc_data *data, struct cqhci_host *cq_host,
   297				       u8 *desc, int sg_count);
   298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
