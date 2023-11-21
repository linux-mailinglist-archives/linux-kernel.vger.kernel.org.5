Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062437F27D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjKUIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjKUIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:47:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DEAF9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700556417; x=1732092417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kml+T/2sj8uGVc60bEYWnm/igYw9snPTddalEQ7hbZ8=;
  b=K+Lrl0njz7IV7mt5M98gUevmDFnGVSyyWT9cyM9KcGpPOPlBnkjL8L3q
   4lxLfTzHpBup94j/gut/mnX1Iv6yNzCoSrhcO06f6H77MqMtFaI9aALvD
   MpGIDRPQiaPW/am05P9FNaDqJkKx5zqHm0ylk7tEmUKpQmGE4W3bnMff9
   SiT1vSEm6j677rqZffcP8K0vOAA81R2nmi75UYhxUzUdEU2nEy6gcPzDf
   k68r0ZiVh33XF/9ywDmRKFX7UOiQxDX3NkD+AnXAoRUehfgex/nXAIHVt
   v7JQpdsH9pvC7xUbiUr94aq27c8xvwnc4T+fCPo8lSY/zitUwBIOu+Yqc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382189971"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="382189971"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857273680"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="857273680"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2023 00:46:52 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5MP5-0007aH-2P;
        Tue, 21 Nov 2023 08:46:46 +0000
Date:   Tue, 21 Nov 2023 16:45:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: kernel/scs.c:86:21: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202311211604.nMVAanJQ-lkp@intel.com>
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
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: d1584d791a297aa8ed93503382a682a6ecfc4218 riscv: Implement Shadow Call Stack
date:   3 weeks ago
config: riscv-randconfig-r132-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211604.nMVAanJQ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311211604.nMVAanJQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211604.nMVAanJQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> kernel/scs.c:86:21: sparse: sparse: Using plain integer as NULL pointer
>> kernel/scs.c:86:21: sparse: sparse: Using plain integer as NULL pointer
>> kernel/scs.c:86:21: sparse: sparse: Using plain integer as NULL pointer
>> kernel/scs.c:86:21: sparse: sparse: Using plain integer as NULL pointer

vim +86 kernel/scs.c

d08b9f0ca6605e Sami Tolvanen    2020-04-27  72  
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  73  void scs_free(void *s)
d08b9f0ca6605e Sami Tolvanen    2020-04-27  74  {
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  75  	int i;
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  76  
bee348fab099b0 Will Deacon      2020-05-15  77  	__scs_account(s, -1);
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  78  
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  79  	/*
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  80  	 * We cannot sleep as this can be called in interrupt context,
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  81  	 * so use this_cpu_cmpxchg to update the cache, and vfree_atomic
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  82  	 * to free the stack.
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  83  	 */
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  84  
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  85  	for (i = 0; i < NR_CACHED_SCS; i++)
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30 @86  		if (this_cpu_cmpxchg(scs_cache[i], 0, s) == NULL)
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  87  			return;
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  88  
f6e39794f4b6da Andrey Konovalov 2022-03-24  89  	kasan_unpoison_vmalloc(s, SCS_SIZE, KASAN_VMALLOC_PROT_NORMAL);
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  90  	vfree_atomic(s);
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  91  }
a2abe7cbd8fe2d Sami Tolvanen    2020-11-30  92  

:::::: The code at line 86 was first introduced by commit
:::::: a2abe7cbd8fe2db5ff386c968e2273d9dc6c468d scs: switch to vmapped shadow stacks

:::::: TO: Sami Tolvanen <samitolvanen@google.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
