Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6769480A417
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjLHNBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHNBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:01:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3511D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702040513; x=1733576513;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SijQoE3EVCHrBjlP4jD2ssvR/TbZ5UVCCvvqWaYtK/0=;
  b=ZzdemlhMDsmzSt43aS3wM8t8TeHo1ZjNJVk+/b3fbZW9qI2XiI4sZnht
   W5VlXnZnOK0PQC1JPW5zDaPBfbpqswyoaiUJLjN19IInZrPxLcerkZ9Zx
   ++W/BuQ05SEYbG+EzDtHDiNw/eez3AAAcL48m9z7p62pCUcmeSI8Rv7fT
   Uqyfn0a5t2vulndoB7cHi1nUuEN5WdURRNMd1Fr55PjrvafCXW2CrdDdZ
   RV2rggp3tPIiblUzDW5QLCNmlbPDjqgkPZt2GPKFg4lv2bQ06lbJ78GtH
   jxUv1Gsl3DkglsAMhzKi9i5yWFw/zlfyCAqRi8TLlXIQnkYUmayDMIZoy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397193217"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="397193217"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 05:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806392986"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="806392986"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Dec 2023 05:01:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBaTy-000DkB-3D;
        Fri, 08 Dec 2023 13:01:30 +0000
Date:   Fri, 8 Dec 2023 21:01:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm64/kernel/proton-pack.c:353:1: sparse: sparse: symbol
 '__pcpu_scope_arm64_ssbd_callback_required' was not declared. Should it be
 static?
Message-ID: <202312082046.x8pxb7Ya-lkp@intel.com>
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
head:   5e3f5b81de80c98338bcb47c233aebefee5a4801
commit: 5c8b0cbd9d6bac5f40943b5a7d8eac8cb86cbe7f arm64: Pull in task_stack_page() to Spectre-v4 mitigation code
date:   3 years, 2 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231208/202312082046.x8pxb7Ya-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231208/202312082046.x8pxb7Ya-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312082046.x8pxb7Ya-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/proton-pack.c:353:1: sparse: sparse: symbol '__pcpu_scope_arm64_ssbd_callback_required' was not declared. Should it be static?

vim +/__pcpu_scope_arm64_ssbd_callback_required +353 arch/arm64/kernel/proton-pack.c

c28762070ca651 Will Deacon 2020-09-18  351  
c28762070ca651 Will Deacon 2020-09-18  352  /* This is the per-cpu state tracking whether we need to talk to firmware */
c28762070ca651 Will Deacon 2020-09-18 @353  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
c28762070ca651 Will Deacon 2020-09-18  354  

:::::: The code at line 353 was first introduced by commit
:::::: c28762070ca651fe7a981b8f31d972c9b7d2c386 arm64: Rewrite Spectre-v4 mitigation code

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
