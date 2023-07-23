Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7264375E1DE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGWMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGWMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:31:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF27C93
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690115469; x=1721651469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+oOh1J57UQz1BOXNeX2lAwy2AUIjuzoh/kgpBEzf9MI=;
  b=gQhEe41AuJMGIGw0PwZWtpKTsRCrB3h4gjFb8ADD0SoGqIX+z47RMgor
   GKy/6OAl6FiVuyjlBzfUp6HyF6Quc7GU13GE1iBPmZa5YEJDGgCRQ96DQ
   HZlViuXapiSGQmrmFVkOvYvk0tJj4Y9pf3RrAcDvNyV4Yod+ZaIhMN/+G
   z4RwGpIUAuwRF9cJWi8jsALhQNdAOETHT0se7W45z1fh8vHZFvTDtuuYV
   45e9xbqLV+DN9z6IkXSIyHP7UfdLPJViC0a8kt3Y0ycHw4z3Q4eYk9cv9
   vw/56JGBPGefHxPomm1rilPKKchKxd3kIh1I/Ld20uAMMQOxMjz/GUsIN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="352169971"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="352169971"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 05:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868769239"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2023 05:31:09 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNYEt-0008zt-0X;
        Sun, 23 Jul 2023 12:31:07 +0000
Date:   Sun, 23 Jul 2023 20:30:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: lib/zstd/compress/zstd_opt.c:1324:15: warning: stack frame size
 (2384) exceeds limit (2048) in 'ZSTD_compressBlock_opt0'
Message-ID: <202307232022.GrGHbMYi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2782531397f5cb19ca3f8f9c17727f1cdf5bee8
commit: 2aa14b1ab2c41a4fe41efae80d58bb77da91f19f zstd: import usptream v1.5.2
date:   9 months ago
config: riscv-randconfig-r032-20230723 (https://download.01.org/0day-ci/archive/20230723/202307232022.GrGHbMYi-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230723/202307232022.GrGHbMYi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307232022.GrGHbMYi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/zstd/compress/zstd_opt.c:1324:15: warning: stack frame size (2384) exceeds limit (2048) in 'ZSTD_compressBlock_opt0' [-Wframe-larger-than]
   static size_t ZSTD_compressBlock_opt0(
                 ^
>> lib/zstd/compress/zstd_opt.c:1331:15: warning: stack frame size (2320) exceeds limit (2048) in 'ZSTD_compressBlock_opt2' [-Wframe-larger-than]
   static size_t ZSTD_compressBlock_opt2(
                 ^
   2 warnings generated.


vim +/ZSTD_compressBlock_opt0 +1324 lib/zstd/compress/zstd_opt.c

  1323	
> 1324	static size_t ZSTD_compressBlock_opt0(
  1325	        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
  1326	        const void* src, size_t srcSize, const ZSTD_dictMode_e dictMode)
  1327	{
  1328	    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 0 /* optLevel */, dictMode);
  1329	}
  1330	
> 1331	static size_t ZSTD_compressBlock_opt2(
  1332	        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
  1333	        const void* src, size_t srcSize, const ZSTD_dictMode_e dictMode)
  1334	{
  1335	    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 2 /* optLevel */, dictMode);
  1336	}
  1337	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
