Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A570777F84F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351630AbjHQOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351756AbjHQOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:04:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26819E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692281080; x=1723817080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q2oPBcPCOcbDb80I+Q8C7q8UEzQrIeUnHlIFkRLbMJE=;
  b=DwFrRD3IriinLmW4iqsdnbXEiCSlFwBeki2jnwN44pGcLv3ouxZnT1xa
   JsO/JI65lf1WuP/2F7S73yCfbBfv9YUA/ALawmSKZ3tEA3QEUpJsDVASu
   p7+CJElx/NfEsrL/aJliOg0/jEr/Y3b7y7wSYb6LYl7HVaE+vqH7KQFJe
   iVoWvJr7mf6Rg1vPzBfdAT2CTLscSbcYHqp3KhdyavohLlACoCGTbpN1o
   IhA9yzqY5lMG39/KnkYxaNFIx6Db/xN6S5qyQc1ckYZHV4/kEnGRDfQCt
   T9rj/Zfo61rOzw2fwsLWe9hisnShd9jTZCHiHIymnf8SYKDLZJnv7NZ7o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439185922"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="439185922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 06:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824633291"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="824633291"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 06:28:58 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWd3T-0001AH-3A;
        Thu, 17 Aug 2023 13:28:53 +0000
Date:   Thu, 17 Aug 2023 21:28:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function
 parameter or member 'memory_type' not described in
 'efi_allocate_pages_aligned'
Message-ID: <202308172116.yPoBelLU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1 efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
date:   9 months ago
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230817/202308172116.yPoBelLU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172116.yPoBelLU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172116.yPoBelLU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function parameter or member 'memory_type' not described in 'efi_allocate_pages_aligned'


vim +27 drivers/firmware/efi/libstub/alignedmem.c

43b1df0e013c25 Ard Biesheuvel 2020-03-27   7  
43b1df0e013c25 Ard Biesheuvel 2020-03-27   8  /**
43b1df0e013c25 Ard Biesheuvel 2020-03-27   9   * efi_allocate_pages_aligned() - Allocate memory pages
43b1df0e013c25 Ard Biesheuvel 2020-03-27  10   * @size:	minimum number of bytes to allocate
43b1df0e013c25 Ard Biesheuvel 2020-03-27  11   * @addr:	On return the address of the first allocated page. The first
43b1df0e013c25 Ard Biesheuvel 2020-03-27  12   *		allocated page has alignment EFI_ALLOC_ALIGN which is an
43b1df0e013c25 Ard Biesheuvel 2020-03-27  13   *		architecture dependent multiple of the page size.
43b1df0e013c25 Ard Biesheuvel 2020-03-27  14   * @max:	the address that the last allocated memory page shall not
43b1df0e013c25 Ard Biesheuvel 2020-03-27  15   *		exceed
43b1df0e013c25 Ard Biesheuvel 2020-03-27  16   * @align:	minimum alignment of the base of the allocation
43b1df0e013c25 Ard Biesheuvel 2020-03-27  17   *
43b1df0e013c25 Ard Biesheuvel 2020-03-27  18   * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
43b1df0e013c25 Ard Biesheuvel 2020-03-27  19   * to @align, which should be >= EFI_ALLOC_ALIGN. The last allocated page will
43b1df0e013c25 Ard Biesheuvel 2020-03-27  20   * not exceed the address given by @max.
43b1df0e013c25 Ard Biesheuvel 2020-03-27  21   *
43b1df0e013c25 Ard Biesheuvel 2020-03-27  22   * Return:	status code
43b1df0e013c25 Ard Biesheuvel 2020-03-27  23   */
43b1df0e013c25 Ard Biesheuvel 2020-03-27  24  efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
9cf42bca30e98a Ard Biesheuvel 2022-08-02  25  					unsigned long max, unsigned long align,
9cf42bca30e98a Ard Biesheuvel 2022-08-02  26  					int memory_type)
43b1df0e013c25 Ard Biesheuvel 2020-03-27 @27  {

:::::: The code at line 27 was first introduced by commit
:::::: 43b1df0e013c25abb536699f46d0e9f291b586a0 efi/libstub: Add API function to allocate aligned memory

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
