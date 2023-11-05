Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8B7E132C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjKELh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 06:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjKELh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 06:37:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A494AF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699184275; x=1730720275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+9p3RZ+xspAXiRQaP6EEsFuNw3siqXsA3w4cBYt/4KY=;
  b=ec7ecb+XLtE+YXwPH8Xm1gZP02ytC00ci00bKE1ZedjagtIRHVbgGkry
   BtfdmWjqBJ9KmteZv8UhxJnGvg8hFwp8QYUuw2Q5WADf8K/qiOMUKsBSl
   EG+Rwa/cpOvVdt3y24v1fDSgj/laCI52wsBKgyY3GzUXIEHc95Whe3eWt
   yoncOKXAuXuDPG4IdWvQ7/zxHLnEV2PE+RqPWsTzvlTwNBOSDoP5Un8Pj
   x6pOQtXfCdrPb3DD0bEmTUQ0RiRmoFEKvnEjqlOrP8QiW1c4g6+KaVjNB
   XGSED9gM6c1uGn22yhJv/UYKspHBJJJuPkvX2Oa4GT7rcvMuGiO/czNOH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="10679295"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="10679295"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 03:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="765698583"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="765698583"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Nov 2023 03:37:53 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzbRv-0005Mt-10;
        Sun, 05 Nov 2023 11:37:51 +0000
Date:   Sun, 5 Nov 2023 19:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: drivers/firmware/smccc/smccc.c:20:21: sparse: sparse: symbol
 'smccc_soc_id_version' was not declared. Should it be static?
Message-ID: <202311051931.ytw4Vqta-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 35727af2b15d98a2dd2811d631d3a3886111312e irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
date:   7 months ago
config: arm64-randconfig-r122-20231102 (https://download.01.org/0day-ci/archive/20231105/202311051931.ytw4Vqta-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231105/202311051931.ytw4Vqta-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051931.ytw4Vqta-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/smccc/smccc.c:20:21: sparse: sparse: symbol 'smccc_soc_id_version' was not declared. Should it be static?
>> drivers/firmware/smccc/smccc.c:21:21: sparse: sparse: symbol 'smccc_soc_id_revision' was not declared. Should it be static?

vim +/smccc_soc_id_version +20 drivers/firmware/smccc/smccc.c

    17	
    18	bool __ro_after_init smccc_trng_available = false;
    19	u64 __ro_after_init smccc_has_sve_hint = false;
  > 20	s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
  > 21	s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
