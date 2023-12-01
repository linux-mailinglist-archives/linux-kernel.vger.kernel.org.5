Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D3D8014E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjLAVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLAVBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:01:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4A10F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701464466; x=1733000466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZozaDRt68zXNnZN9a/btRfD4BevuIgf3falrmZsis1E=;
  b=QIqaXKfBONqFYXiJyosLyK8QEd+GawgAlcGfNYu6PgInPRArudEFuhn1
   A3ir5QsXFTIDmiBWqeBKwWsZTRfpUThwyQmPPw0BaXN3Yvnq44Xh8Nj9G
   ATI2FY6CbEyPAyqUhAF+KeWT/L88uMrFLjWGtrVVtr4mPA13ulZygRogs
   7PmX77Bx3giW/HPfiHd3macebIwAw+ewisMe4nsrcMvhfmDpTLMz3LnF0
   SBGt//23T63dZJPXhG2W4J4XFb30BQkGy7ypLgXzrn7USFmFroxZLsc6L
   2Gz8VEoaQaByv/DWRZHbglHaoNuHeFeu/nP1H764PLdEeCmg17JZ4EX5W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="424710587"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="424710587"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 13:01:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="17892899"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Dec 2023 13:01:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9AdA-0004Ho-0i;
        Fri, 01 Dec 2023 21:01:00 +0000
Date:   Sat, 2 Dec 2023 05:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: lib/overflow_kunit.c:728:38: sparse: sparse: undefined preprocessor
 identifier '__clang_major__'
Message-ID: <202312020406.V5RUTSeC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: 0e5b9f25b27a7a92880f88f5dba3edf726ec5f61 overflow: disable failing tests for older clang versions
date:   1 year, 1 month ago
config: hexagon-randconfig-r121-20231119 (https://download.01.org/0day-ci/archive/20231202/202312020406.V5RUTSeC-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312020406.V5RUTSeC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312020406.V5RUTSeC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/overflow_kunit.c:728:38: sparse: sparse: undefined preprocessor identifier '__clang_major__'
   lib/overflow_kunit.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:248:46: sparse: sparse: self-comparison always evaluates to false
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:270:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:271:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:272:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:273:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:274:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:275:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:286:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:292:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:299:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:306:1: sparse: sparse: self-comparison always evaluates to true

vim +/__clang_major__ +728 lib/overflow_kunit.c

   711	
   712	static struct kunit_case overflow_test_cases[] = {
   713		KUNIT_CASE(u8_u8__u8_overflow_test),
   714		KUNIT_CASE(s8_s8__s8_overflow_test),
   715		KUNIT_CASE(u16_u16__u16_overflow_test),
   716		KUNIT_CASE(s16_s16__s16_overflow_test),
   717		KUNIT_CASE(u32_u32__u32_overflow_test),
   718		KUNIT_CASE(s32_s32__s32_overflow_test),
   719	/* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
   720	#if BITS_PER_LONG == 64
   721		KUNIT_CASE(u64_u64__u64_overflow_test),
   722		KUNIT_CASE(s64_s64__s64_overflow_test),
   723	#endif
   724	/*
   725	 * Clang 11 and earlier generate unwanted libcalls for signed output, unsigned
   726	 * input.
   727	 */
 > 728	#if !(defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 11)
   729		KUNIT_CASE(u32_u32__int_overflow_test),
   730	#endif
   731		KUNIT_CASE(u32_u32__u8_overflow_test),
   732		KUNIT_CASE(u8_u8__int_overflow_test),
   733		KUNIT_CASE(int_int__u8_overflow_test),
   734		KUNIT_CASE(shift_sane_test),
   735		KUNIT_CASE(shift_overflow_test),
   736		KUNIT_CASE(shift_truncate_test),
   737		KUNIT_CASE(shift_nonsense_test),
   738		KUNIT_CASE(overflow_allocation_test),
   739		KUNIT_CASE(overflow_size_helpers_test),
   740		{}
   741	};
   742	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
