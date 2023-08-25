Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239D787D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjHYB1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjHYB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:27:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4647C19B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692926819; x=1724462819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rgO7oXXWf20WhU95EfNEyYx5r2vtRSNXmvEZ04PFR24=;
  b=KJRKv1mB09ZzdUCdjSbCn6w3TKPPRlvBTovE4l6my+eVZv/FaxhPLNNd
   RFg19VLWNCcQxFD21cDKEKyRp05nKnIYjVA4QaPdUQt51FPWKRjGc2MgW
   Vb07jixCiv4nmWfho1CK8fA6AvJ8AeBVneCxve+AfC4VZUADsSSpBwB2S
   cqiMrheUoqKCuf9PadclAIYEaXZ17ARtf4jkF/A/D+QvvsIetBMYzFvUW
   5QiTebW0OSAVHl3cMGK6B/wgBxhnJyGp9odSbnc28ettsJSMJkJJzrjFB
   18+1u/JC8mTcqphHpKa5hrOJf4szQf63Q7NZsfZQPE/e2W7SsO5R8pvO3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359600422"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359600422"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 18:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="1068053764"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1068053764"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 18:26:56 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZLbE-000365-0b;
        Fri, 25 Aug 2023 01:26:56 +0000
Date:   Fri, 25 Aug 2023 09:26:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.22a 61/69]
 kernel/locking/locktorture.c:279:13: warning: no previous prototype for
 function 'spinlock_dump'
Message-ID: <202308250940.ak8AUxEz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
head:   354957ec11dc80eac68c4b1e10c237d69adc1833
commit: bdd8d60bd4047aa4a7dc207789dc4ad0dfd5f07e [61/69] EXP qspinlock: Dump lock state, add call from locktorture
config: mips-randconfig-r025-20230825 (https://download.01.org/0day-ci/archive/20230825/202308250940.ak8AUxEz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308250940.ak8AUxEz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308250940.ak8AUxEz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/locktorture.c:279:13: warning: no previous prototype for function 'spinlock_dump' [-Wmissing-prototypes]
     279 | void __weak spinlock_dump(spinlock_t *sp, bool full)
         |             ^
   kernel/locking/locktorture.c:279:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     279 | void __weak spinlock_dump(spinlock_t *sp, bool full)
         | ^
         | static 
   1 warning generated.


vim +/spinlock_dump +279 kernel/locking/locktorture.c

   278	
 > 279	void __weak spinlock_dump(spinlock_t *sp, bool full)
   280	{
   281		pr_alert("%s __weak stub invoked.\n", __func__);
   282	}
   283	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
