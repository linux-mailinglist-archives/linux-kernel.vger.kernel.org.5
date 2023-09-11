Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7B79BEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjIKWpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379227AbjIKWmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 18:42:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17999F93
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694471919; x=1726007919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sbBYYsdoPGkIHJDg/4C9D1Tu8IxxjO9vE0yn8Xe8Gg4=;
  b=NrlTYg1xu9w9FW/jbCHOEnLjQ51FfnkwslHjH7vqxtrrZqEKZpL9QfHf
   ZqAwbEsD0nldtqe1seG8gMPvu/GpLGgEp+08g3T0uqZxaW7ipcbKsDeFj
   mSlV9BLepR1iR/7nlsnlr1Rkg+ecSBjiG33BflkaP5ssI+CHfWfnE4Hqu
   ljOurb8Bjk9Wh/ujdBfMT7s1/4+GATaxTKqNNYzGz3XaM1TgUVwnnNCo6
   Nv7JgYm0EDAQIhkwNsgcjWc/P/yUxr6GJKDBLmsLxKCnGJXltd1rY0zB5
   BibloFaqGZFvIsFYYFPbwt2C3hqrAEi28hmAQ+AjO9dp5Nt6mseJ/66gs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368476009"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="368476009"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 15:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="886712292"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="886712292"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2023 15:29:31 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfpPh-0006oT-1f;
        Mon, 11 Sep 2023 22:29:49 +0000
Date:   Tue, 12 Sep 2023 06:29:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: cs42l43.c:undefined reference to `devm_regmap_add_irq_chip'
Message-ID: <202309120614.y7xm6iqp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: ace6d14481386ec6c1b63cc2b24c71433a583dc2 mfd: cs42l43: Add support for cs42l43 core driver
date:   4 weeks ago
config: nios2-randconfig-r013-20230912 (https://download.01.org/0day-ci/archive/20230912/202309120614.y7xm6iqp-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120614.y7xm6iqp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120614.y7xm6iqp-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/mfd/cs42l43.o: in function `cs42l43_boot_work':
>> cs42l43.c:(.text+0x614): undefined reference to `devm_regmap_add_irq_chip'
   cs42l43.c:(.text+0x614): relocation truncated to fit: R_NIOS2_CALL26 against `devm_regmap_add_irq_chip'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
