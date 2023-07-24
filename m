Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3674F75FACD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGXPbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGXPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:31:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713551B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690212675; x=1721748675;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cLWYEIOLUkMR+23sbC2x2DkVkXQMCKymOp7tgMJ7YL0=;
  b=M+AdrrXaCGkE/nQZGZjfAODT68kw3OwSvD0IrR3d7mHOwNA00H4Yz5sj
   WmC5McCqhDivn1btW9AH2g9wEIhw75Ivz9gRmUjZq3Zb4dfi5J3IbPIdo
   SgSyV7fT//A+0RnUewzNSijcfpTlU1nDfEXl+4qtXo9q9lnpCINenz8VN
   PY8CG+qgpo0Dih7bgTJ3B9Hw25fK5ld8TOmqS9vjVFgAQ+xY42vjSpKvT
   BtX5t0srMgd66HmIn8AlRMF2IH+xCKJZM3h23gIXNEKtw6HDnOq2pWAth
   rCHJzMOuJa6b6Uwd41nChpU1lVWIJj99h+uVDpb08XGIk2oS3Ojiyg3OZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="453848029"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="453848029"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 08:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="675861684"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="675861684"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2023 08:31:13 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNxWi-0009ok-16;
        Mon, 24 Jul 2023 15:31:12 +0000
Date:   Mon, 24 Jul 2023 23:31:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: drivers/remoteproc/stm32_rproc.c:662:34: warning: unused variable
 'stm32_rproc_match'
Message-ID: <202307242300.ia82qBTp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
commit: 03bd158e1535e68bcd2b1e095b0ebcad7c84bd20 remoteproc: stm32: use correct format strings on 64-bit
date:   5 weeks ago
config: x86_64-buildonly-randconfig-r001-20230723 (https://download.01.org/0day-ci/archive/20230724/202307242300.ia82qBTp-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307242300.ia82qBTp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307242300.ia82qBTp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/stm32_rproc.c:662:34: warning: unused variable 'stm32_rproc_match' [-Wunused-const-variable]
   static const struct of_device_id stm32_rproc_match[] = {
                                    ^
   1 warning generated.


vim +/stm32_rproc_match +662 drivers/remoteproc/stm32_rproc.c

13140de09cc2dd Fabien Dessenne 2019-05-14  661  
13140de09cc2dd Fabien Dessenne 2019-05-14 @662  static const struct of_device_id stm32_rproc_match[] = {
13140de09cc2dd Fabien Dessenne 2019-05-14  663  	{ .compatible = "st,stm32mp1-m4" },
13140de09cc2dd Fabien Dessenne 2019-05-14  664  	{},
13140de09cc2dd Fabien Dessenne 2019-05-14  665  };
13140de09cc2dd Fabien Dessenne 2019-05-14  666  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
13140de09cc2dd Fabien Dessenne 2019-05-14  667  

:::::: The code at line 662 was first introduced by commit
:::::: 13140de09cc2dd5e5166ad42292bb82af4e23cef remoteproc: stm32: add an ST stm32_rproc driver

:::::: TO: Fabien Dessenne <fabien.dessenne@st.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
