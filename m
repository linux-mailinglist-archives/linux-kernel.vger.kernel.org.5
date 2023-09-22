Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961637AB271
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjIVMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjIVMx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:53:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9031CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695387203; x=1726923203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FpMNmid5vJBRuoipv6sZTZSriJ88OpJcsOk/pEnk+ME=;
  b=GfdUyMTOlEqAF7AmJEs2AFNGV3IYt9MTXW5TjAebIOrz1EgrKjg0u4Wm
   Bd4RpcalR60OQtnTztpqlj8Vm/QTOEImgw0anai2e6lOIyjmqiQsN1ir9
   VCjRwNzpfelO+23pcd1/F0MqWhym44IdexeSIsq+QRNSQJuMGMhjZdDD+
   MDqWoUsan0JgrsR525PfGCyAKUVSvSEyPRwRs92NCIfWun1bczTWdU0x4
   QgQYiy1J9grtVdzR3YI1DDZv/13h5LqmKTxRc4L20qJsVKkMDTd0hz+Ur
   YKjUfUT/yNqHiVa9jtC3c2LGkuHckhYxXhgyXR088mOKAyg2mFqTvPyqx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="444915576"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="444915576"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 05:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="750830048"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="750830048"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2023 05:53:20 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjfeo-0000jF-19;
        Fri, 22 Sep 2023 12:53:18 +0000
Date:   Fri, 22 Sep 2023 20:53:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: {standard input}:992: Error: value -148 out of range
Message-ID: <202309222048.RnSqEIK5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
commit: ef3bcde75d06d65f78ba38a30d5a87fb83a5cdae ASoC: tas2781: Add tas2781 driver
date:   3 months ago
config: m68k-randconfig-r025-20230123 (https://download.01.org/0day-ci/archive/20230922/202309222048.RnSqEIK5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309222048.RnSqEIK5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309222048.RnSqEIK5-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:992: Error: value -148 out of range
   {standard input}:992: Error: value of ffffff6c too large for field of 1 byte at 0000045f

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
