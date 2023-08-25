Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876BD787D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjHYBkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjHYBjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:39:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10D213C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692927551; x=1724463551;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vc6TkaWfp3nBmpyCAq/GphRhzUTE2siTllpHUm74Wco=;
  b=UiDdRfb4DFx0AdFXHfie+SaYb3sNlpG7mr44uGak+Bsx2Rz8sXUsIpiL
   te4M/5EUdp7dDkYQPMZMit/SEGskFkQvl3myYpv09l/C3kchJlWGaBlAG
   KHgvpDF1YFfZSVm7pgB32XjzYTD2sRc/Qo5X1SKoKgQKXR0Ww0Ex1879r
   gBPlyq9P68N3hbkW6MRqCbEYb4W6kcOoUdybIYULbU9QZDuquv138tHKr
   /hx0XIGr/rwOSjvMhZHB88GVcjV33MredW26o/DOA1hKKxPsFFbMQe60y
   sTlqgOrR2W4NYqbSsPloKFYFiqyNObrInWxRX1D30wBWzijhGSgeAte59
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="438548797"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438548797"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 18:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827406098"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827406098"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 18:38:19 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZLmB-00037A-36;
        Fri, 25 Aug 2023 01:38:17 +0000
Date:   Fri, 25 Aug 2023 09:37:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.22a 61/69]
 kernel/locking/locktorture.c:279:13: warning: no previous prototype for
 'spinlock_dump'
Message-ID: <202308250944.F8nVkKh9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
head:   354957ec11dc80eac68c4b1e10c237d69adc1833
commit: bdd8d60bd4047aa4a7dc207789dc4ad0dfd5f07e [61/69] EXP qspinlock: Dump lock state, add call from locktorture
config: arm-randconfig-r031-20230825 (https://download.01.org/0day-ci/archive/20230825/202308250944.F8nVkKh9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308250944.F8nVkKh9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308250944.F8nVkKh9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/locktorture.c:279:13: warning: no previous prototype for 'spinlock_dump' [-Wmissing-prototypes]
     279 | void __weak spinlock_dump(spinlock_t *sp, bool full)
         |             ^~~~~~~~~~~~~


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
