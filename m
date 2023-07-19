Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E242758CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGSFFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSFFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:05:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A51BFD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689743105; x=1721279105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pOXYwV97mgxYIXwJnjIqWa8OytFh4DeSpkMg2iBSERc=;
  b=gwtYSMiwgSlapJUiyy3e0L7fsTaNvU+n3VjtpxUzjrpH+qFBBVVl+7iN
   FSgJpRXTS1KuFVHH0t4Plz+PiyyJLbT3bhU0EAihePiLcfhdhohGjcjwv
   SOljO+TVlRHzPkZqE8UGW+wNBygQD4sdvEFHR1j8gx2akaAsfWfyUKw+U
   5sigTFyB5Ruu3y4WgE6n+1miD11+zSVG9kZsZOmp0PiPzxIL8bxPJwte3
   2AllnaYsCsTubrxyXMWkZY8u0+OVCik4sgfTEa4p7RQhxVjOrwdAb/9EL
   CCSeeCqO+rhDFXvWHv1GyW0QQQMaUQ8BKb02s9GEI5sBjzSgVpOZAaC5M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="351243186"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="351243186"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847927211"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="847927211"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 22:05:02 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLzN0-0004AM-0G;
        Wed, 19 Jul 2023 05:05:02 +0000
Date:   Wed, 19 Jul 2023 13:04:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Ming <machel@vivo.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] reset: hisilicon: Use dev_err_probe instead of dev_err
Message-ID: <202307191252.hZvUCt7Q-lkp@intel.com>
References: <20230718030511.16065-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718030511.16065-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

kernel test robot noticed the following build errors:

[auto build test ERROR on pza/reset/next]
[also build test ERROR on pza/imx-drm/next linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Ming/reset-hisilicon-Use-dev_err_probe-instead-of-dev_err/20230718-203055
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20230718030511.16065-1-machel%40vivo.com
patch subject: [PATCH v1] reset: hisilicon: Use dev_err_probe instead of dev_err
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230719/202307191252.hZvUCt7Q-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191252.hZvUCt7Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191252.hZvUCt7Q-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/reset/hisilicon/reset-hi3660.c: In function 'hi3660_reset_probe':
   drivers/reset/hisilicon/reset-hi3660.c:93:36: warning: passing argument 2 of 'dev_err_probe' makes integer from pointer without a cast [-Wint-conversion]
      93 |                 dev_err_probe(dev, "failed to get hisilicon,rst-syscon\n");
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                    |
         |                                    char *
   In file included from include/linux/platform_device.h:13,
                    from include/linux/of_device.h:5,
                    from drivers/reset/hisilicon/reset-hi3660.c:9:
   include/linux/device.h:1091:64: note: expected 'int' but argument is of type 'char *'
    1091 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                            ~~~~^~~
>> drivers/reset/hisilicon/reset-hi3660.c:93:17: error: too few arguments to function 'dev_err_probe'
      93 |                 dev_err_probe(dev, "failed to get hisilicon,rst-syscon\n");
         |                 ^~~~~~~~~~~~~
   include/linux/device.h:1091:20: note: declared here
    1091 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                    ^~~~~~~~~~~~~


vim +/dev_err_probe +93 drivers/reset/hisilicon/reset-hi3660.c

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
