Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E997D81D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbjJZLc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjJZLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:32:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7E1BE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698319941; x=1729855941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h5ApP6E4jqcaA/SORBcECnrNuDYb/izJkywcCwQJGys=;
  b=R8XXdTUIDXnilpDCwfepGCGU2KHDNrWro+O+XMC0hpAKtaO5M3OByUiu
   WNcIeKti4/1efu7bRZqq2tgGyuoXZEavWJnHaFp4ys7GDSOS35TyJZapT
   HgFvDcc1T25Zhe9x/WwDBz6H+K3Sn68mKtD0nhTenytQW0j817WsqNzwe
   rGTD7wcpolZ4ZtBIXYvhVWU86NS24/sW2Xcc8wHgtpPZSVg7U4lI5gecP
   CRLreUyOwSq92ooDf7VNTA6qdKYXpbiCsMBwgI4BP4AqdEZLiWUyYIQLU
   u/H+efE3t1Z6EKL4johBYNRUfaW5g0Lj6OrOKoOLHx1MCnCwsw/WQEKBy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="332030"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="332030"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 04:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="7244087"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Oct 2023 04:32:08 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvyb2-0009kA-0q;
        Thu, 26 Oct 2023 11:32:16 +0000
Date:   Thu, 26 Oct 2023 19:31:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH V2] nvmem: brcm_nvram: store a copy of NVRAM content
Message-ID: <202310261904.cWDKcVh8-lkp@intel.com>
References: <20231026073440.6724-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231026073440.6724-1-zajec5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafa-Mi-ecki/nvmem-brcm_nvram-store-a-copy-of-NVRAM-content/20231026-153630
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231026073440.6724-1-zajec5%40gmail.com
patch subject: [PATCH V2] nvmem: brcm_nvram: store a copy of NVRAM content
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231026/202310261904.cWDKcVh8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310261904.cWDKcVh8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310261904.cWDKcVh8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvmem/brcm_nvram.c:36: warning: Function parameter or member 'dev' not described in 'brcm_nvram'
>> drivers/nvmem/brcm_nvram.c:36: warning: Function parameter or member 'cells' not described in 'brcm_nvram'
>> drivers/nvmem/brcm_nvram.c:36: warning: Function parameter or member 'ncells' not described in 'brcm_nvram'


vim +36 drivers/nvmem/brcm_nvram.c

3fef9ed0627af3 Rafał Miłecki 2021-03-30  19  
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  20  /**
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  21   * struct brcm_nvram - driver state internal struct
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  22   *
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  23   * @nvmem_size:		Size of the whole space available for NVRAM
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  24   * @data:		NVRAM data copy stored to avoid poking underlaying flash controller
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  25   * @data_len:		NVRAM data size
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  26   * @padding_byte:	Padding value used to fill remaining space
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  27   */
3fef9ed0627af3 Rafał Miłecki 2021-03-30  28  struct brcm_nvram {
3fef9ed0627af3 Rafał Miłecki 2021-03-30  29  	struct device *dev;
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  30  	size_t nvmem_size;
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  31  	uint8_t *data;
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  32  	size_t data_len;
6bb6c90c7bc5bb Rafał Miłecki 2023-10-26  33  	uint8_t padding_byte;
6e977eaa8280e9 Rafał Miłecki 2022-02-25  34  	struct nvmem_cell_info *cells;
6e977eaa8280e9 Rafał Miłecki 2022-02-25  35  	int ncells;
6e977eaa8280e9 Rafał Miłecki 2022-02-25 @36  };
6e977eaa8280e9 Rafał Miłecki 2022-02-25  37  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
