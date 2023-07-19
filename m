Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB8758BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGSC6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGSC6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:58:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FCE1BE9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689735482; x=1721271482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTS8tic412yj99yRyRdk89J0/bqjF94lmcgbbzGc4a0=;
  b=UczSXLfIcPmIxVLnRJhcoD4UmuFu6wwebJF02N+WATg9H59xAlnr+l4j
   S5h4YNZoCFXU9eNKjH0k6P4Sd8Wn1zmL1qO+HapxC66KJD1VMlkCbBped
   r1ukVGYNL8x1gD0XCcOImvu6cNpua2EdMboUKQBt2wceDmz5iCAzd8pUC
   2mVUuQtsKGAIWQg1rWGuZOpu0PaTnKgK3ocmR/WXBTsR2hbJRPRL+A+Wx
   6E7rQVE3/xXLChgHWAMxgEBqRRz3vm1VsbImXFWGVt+piFHfGe5bJ+wAf
   fr6rsCPpHql3qOpwDTSbBVAbR1iIkxo9jOP3UAa0iaq5R6ehW5s4YWeT9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345948696"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="345948696"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723843232"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723843232"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 19:58:00 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLxO3-00045p-2A;
        Wed, 19 Jul 2023 02:57:59 +0000
Date:   Wed, 19 Jul 2023 10:57:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Ming <machel@vivo.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] reset: hisilicon: Use dev_err_probe instead of dev_err
Message-ID: <202307191040.jWQyBc5s-lkp@intel.com>
References: <20230718030511.16065-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718030511.16065-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

kernel test robot noticed the following build errors:

[auto build test ERROR on pza/reset/next]
[also build test ERROR on linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Ming/reset-hisilicon-Use-dev_err_probe-instead-of-dev_err/20230718-203055
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20230718030511.16065-1-machel%40vivo.com
patch subject: [PATCH v1] reset: hisilicon: Use dev_err_probe instead of dev_err
config: arm-randconfig-r003-20230718 (https://download.01.org/0day-ci/archive/20230719/202307191040.jWQyBc5s-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191040.jWQyBc5s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191040.jWQyBc5s-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/reset/hisilicon/reset-hi3660.c:93:60: error: too few arguments to function call, expected at least 3, have 2
      93 |                 dev_err_probe(dev, "failed to get hisilicon,rst-syscon\n");
         |                 ~~~~~~~~~~~~~                                            ^
   include/linux/device.h:1091:20: note: 'dev_err_probe' declared here
    1091 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                    ^
   1 error generated.


vim +93 drivers/reset/hisilicon/reset-hi3660.c

    75	
    76	static int hi3660_reset_probe(struct platform_device *pdev)
    77	{
    78		struct hi3660_reset_controller *rc;
    79		struct device_node *np = pdev->dev.of_node;
    80		struct device *dev = &pdev->dev;
    81	
    82		rc = devm_kzalloc(dev, sizeof(*rc), GFP_KERNEL);
    83		if (!rc)
    84			return -ENOMEM;
    85	
    86		rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");
    87		if (rc->map == ERR_PTR(-ENODEV)) {
    88			/* fall back to the deprecated compatible */
    89			rc->map = syscon_regmap_lookup_by_phandle(np,
    90								  "hisi,rst-syscon");
    91		}
    92		if (IS_ERR(rc->map)) {
  > 93			dev_err_probe(dev, "failed to get hisilicon,rst-syscon\n");
    94			return PTR_ERR(rc->map);
    95		}
    96	
    97		rc->rst.ops = &hi3660_reset_ops,
    98		rc->rst.of_node = np;
    99		rc->rst.of_reset_n_cells = 2;
   100		rc->rst.of_xlate = hi3660_reset_xlate;
   101	
   102		return reset_controller_register(&rc->rst);
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
