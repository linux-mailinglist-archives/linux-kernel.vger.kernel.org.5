Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF079DBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjILWcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjILWcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:32:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AA10C8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694557970; x=1726093970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ce0zvqS5Nt3pmPhIWEU5X1Z9/IeQB64+TM/3MKq/3sc=;
  b=UUbvLJ9O4h7jh9HU9sQIN9uB1MNT/zKOGr6p5OaMRe2NSvWPYf1AxYkS
   DhdA0aHF2BDkFSUhG2to9qxmSXHLMfhWRjYfZs0pHUkbW4mcJlxJEDzgJ
   T1TA9tgE/2m5zWNHhRcFSrIVhe9BauVvdJHwQv2DhBki2ld4l1Bg/DXt7
   f/brZXyNbQzvNtqtQhtt8+ro5YU41F9J3aqTIe9S19fLXWug1582SXQQD
   58Y19XhUtc2fVsGc3wptHzemHQ77ifoqg/9UXzFp9GrOyDOc/aSCaxVXQ
   yQ29ut145VhIVb+y/mcVKw7wTfHFXolFhsrPbSZQBlmfncBO2jO5wJxEW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363542924"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="363542924"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720582582"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="720582582"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2023 15:32:48 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgBw5-0000MT-2l;
        Tue, 12 Sep 2023 22:32:45 +0000
Date:   Wed, 13 Sep 2023 06:32:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [tip:x86/tdx 8/12] arch/x86/coco/tdx/tdx.c:733:27: error: implicit
 declaration of function '__tdx_hypercall_ret'; did you mean
 '__tdx_hypercall'?
Message-ID: <202309130622.Ba60ODDl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
head:   d6cb0f01644c5cd2bc51b88df933e07849cfaa76
commit: f9ea69e6406abf2145aba7987e7b81ea1b4ea356 [8/12] x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309130622.Ba60ODDl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130622.Ba60ODDl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130622.Ba60ODDl-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/coco/tdx/tdx.c: In function 'tdx_map_gpa':
>> arch/x86/coco/tdx/tdx.c:733:27: error: implicit declaration of function '__tdx_hypercall_ret'; did you mean '__tdx_hypercall'? [-Werror=implicit-function-declaration]
     733 |                 u64 ret = __tdx_hypercall_ret(&args);
         |                           ^~~~~~~~~~~~~~~~~~~
         |                           __tdx_hypercall
   cc1: some warnings being treated as errors


vim +733 arch/x86/coco/tdx/tdx.c

7dbde763162989 Kirill A. Shutemov 2022-04-06  707  
7dbde763162989 Kirill A. Shutemov 2022-04-06  708  /*
019b383d1132e4 Dexuan Cui         2023-08-10  709   * Notify the VMM about page mapping conversion. More info about ABI
019b383d1132e4 Dexuan Cui         2023-08-10  710   * can be found in TDX Guest-Host-Communication Interface (GHCI),
019b383d1132e4 Dexuan Cui         2023-08-10  711   * section "TDG.VP.VMCALL<MapGPA>".
7dbde763162989 Kirill A. Shutemov 2022-04-06  712   */
019b383d1132e4 Dexuan Cui         2023-08-10  713  static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
7dbde763162989 Kirill A. Shutemov 2022-04-06  714  {
019b383d1132e4 Dexuan Cui         2023-08-10  715  	/* Retrying the hypercall a second time should succeed; use 3 just in case */
019b383d1132e4 Dexuan Cui         2023-08-10  716  	const int max_retries_per_page = 3;
019b383d1132e4 Dexuan Cui         2023-08-10  717  	int retry_count = 0;
7dbde763162989 Kirill A. Shutemov 2022-04-06  718  
7dbde763162989 Kirill A. Shutemov 2022-04-06  719  	if (!enc) {
7dbde763162989 Kirill A. Shutemov 2022-04-06  720  		/* Set the shared (decrypted) bits: */
7dbde763162989 Kirill A. Shutemov 2022-04-06  721  		start |= cc_mkdec(0);
7dbde763162989 Kirill A. Shutemov 2022-04-06  722  		end   |= cc_mkdec(0);
7dbde763162989 Kirill A. Shutemov 2022-04-06  723  	}
7dbde763162989 Kirill A. Shutemov 2022-04-06  724  
019b383d1132e4 Dexuan Cui         2023-08-10  725  	while (retry_count < max_retries_per_page) {
019b383d1132e4 Dexuan Cui         2023-08-10  726  		struct tdx_hypercall_args args = {
019b383d1132e4 Dexuan Cui         2023-08-10  727  			.r10 = TDX_HYPERCALL_STANDARD,
019b383d1132e4 Dexuan Cui         2023-08-10  728  			.r11 = TDVMCALL_MAP_GPA,
019b383d1132e4 Dexuan Cui         2023-08-10  729  			.r12 = start,
019b383d1132e4 Dexuan Cui         2023-08-10  730  			.r13 = end - start };
019b383d1132e4 Dexuan Cui         2023-08-10  731  
019b383d1132e4 Dexuan Cui         2023-08-10  732  		u64 map_fail_paddr;
019b383d1132e4 Dexuan Cui         2023-08-10 @733  		u64 ret = __tdx_hypercall_ret(&args);
019b383d1132e4 Dexuan Cui         2023-08-10  734  
019b383d1132e4 Dexuan Cui         2023-08-10  735  		if (ret != TDVMCALL_STATUS_RETRY)
019b383d1132e4 Dexuan Cui         2023-08-10  736  			return !ret;
7dbde763162989 Kirill A. Shutemov 2022-04-06  737  		/*
019b383d1132e4 Dexuan Cui         2023-08-10  738  		 * The guest must retry the operation for the pages in the
019b383d1132e4 Dexuan Cui         2023-08-10  739  		 * region starting at the GPA specified in R11. R11 comes
019b383d1132e4 Dexuan Cui         2023-08-10  740  		 * from the untrusted VMM. Sanity check it.
7dbde763162989 Kirill A. Shutemov 2022-04-06  741  		 */
019b383d1132e4 Dexuan Cui         2023-08-10  742  		map_fail_paddr = args.r11;
019b383d1132e4 Dexuan Cui         2023-08-10  743  		if (map_fail_paddr < start || map_fail_paddr >= end)
019b383d1132e4 Dexuan Cui         2023-08-10  744  			return false;
019b383d1132e4 Dexuan Cui         2023-08-10  745  
019b383d1132e4 Dexuan Cui         2023-08-10  746  		/* "Consume" a retry without forward progress */
019b383d1132e4 Dexuan Cui         2023-08-10  747  		if (map_fail_paddr == start) {
019b383d1132e4 Dexuan Cui         2023-08-10  748  			retry_count++;
019b383d1132e4 Dexuan Cui         2023-08-10  749  			continue;
019b383d1132e4 Dexuan Cui         2023-08-10  750  		}
019b383d1132e4 Dexuan Cui         2023-08-10  751  
019b383d1132e4 Dexuan Cui         2023-08-10  752  		start = map_fail_paddr;
019b383d1132e4 Dexuan Cui         2023-08-10  753  		retry_count = 0;
019b383d1132e4 Dexuan Cui         2023-08-10  754  	}
019b383d1132e4 Dexuan Cui         2023-08-10  755  
019b383d1132e4 Dexuan Cui         2023-08-10  756  	return false;
019b383d1132e4 Dexuan Cui         2023-08-10  757  }
019b383d1132e4 Dexuan Cui         2023-08-10  758  

:::::: The code at line 733 was first introduced by commit
:::::: 019b383d1132e4051de0d2e43254454b86538cf4 x86/tdx: Retry partially-completed page conversion hypercalls

:::::: TO: Dexuan Cui <decui@microsoft.com>
:::::: CC: Dave Hansen <dave.hansen@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
