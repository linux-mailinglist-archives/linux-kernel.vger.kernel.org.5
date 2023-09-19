Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279917A5B91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjISHtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjISHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:49:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE0100;
        Tue, 19 Sep 2023 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695109750; x=1726645750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DOwKPK2ZKm9AIg5bJUx80+sSzuoUpgRbbL5MT+RoMqY=;
  b=WY3pkREBIBJIoyxc6lqnIlf8FXS2Z7plwCtvzDb5M08N8ChiTxnYyOig
   7YxRbwz2ue5zhqNiOBmp6HJvs+suhZ2dARxof9SjcK5gMEDQz73zVKg1i
   ecALcJMeGJBytnX6f2eiUzaDxrSQRCRj8vjUsNecrRs+99/WdQC/dEXnp
   opU5x4SfUJwzvh0lFeAg0Oa8Nr4eyXV7Yx+3QWokxHAU7zX4pQK/LfpkR
   phThf7TjEWtTshDJ9Ysn13Ydw/jUxZjta/Tyk/fX3jbGaSFTYseFsAtRJ
   Q0kiJUHPCk4/1Cftx1BbZNqa3DuXv+merh0rYyRt8VChNHG5E7S1+raIS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466207116"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="466207116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 00:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775449486"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="775449486"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2023 00:49:05 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiVTh-00074k-2W;
        Tue, 19 Sep 2023 07:49:01 +0000
Date:   Tue, 19 Sep 2023 15:45:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, peter.chen@kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net
Cc:     oe-kbuild-all@lists.linux.dev, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v1 2/2] usb: chipidea: Add support for NPCM
Message-ID: <202309191545.dZXS2Y2p-lkp@intel.com>
References: <20230918165958.2659-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918165958.2659-3-tmaimon77@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.6-rc2 next-20230918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-binding-usb-ci-hdrc-usb2-document-Nuvoton-NPCM-supprt/20230919-010147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230918165958.2659-3-tmaimon77%40gmail.com
patch subject: [PATCH v1 2/2] usb: chipidea: Add support for NPCM
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230919/202309191545.dZXS2Y2p-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309191545.dZXS2Y2p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309191545.dZXS2Y2p-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/chipidea/ci_hdrc_npcm.c: In function 'npcm_udc_probe':
>> drivers/usb/chipidea/ci_hdrc_npcm.c:68:17: error: 'CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS' undeclared (first use in this function)
      68 |                 CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/chipidea/ci_hdrc_npcm.c:68:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS +68 drivers/usb/chipidea/ci_hdrc_npcm.c

    39	
    40	static int npcm_udc_probe(struct platform_device *pdev)
    41	{
    42		int ret;
    43		unsigned int args[3];
    44		struct regmap *gcr_regmap;
    45		struct npcm_udc_data *ci;
    46		struct platform_device *plat_ci;
    47		struct device *dev = &pdev->dev;
    48		struct device_node *np = dev->of_node;
    49	
    50		ci = devm_kzalloc(&pdev->dev, sizeof(*ci), GFP_KERNEL);
    51		if (!ci)
    52			return -ENOMEM;
    53		platform_set_drvdata(pdev, ci);
    54	
    55		ci->core_clk = devm_clk_get_optional(dev, NULL);
    56		if (IS_ERR(ci->core_clk))
    57			return PTR_ERR(ci->core_clk);
    58	
    59		ret = clk_prepare_enable(ci->core_clk);
    60		if (ret) {
    61			dev_err(dev, "failed to enable the clock: %d\n", ret);
    62			return ret;
    63		}
    64	
    65		ci->pdata.name = dev_name(dev);
    66		ci->pdata.capoffset = DEF_CAPOFFSET;
    67		ci->pdata.flags	= CI_HDRC_REQUIRES_ALIGNED_DMA |
  > 68			CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS;
    69		ci->pdata.phy_mode = USBPHY_INTERFACE_MODE_UTMI;
    70		ci->pdata.notify_event = npcm_udc_notify_event;
    71	
    72		gcr_regmap = syscon_regmap_lookup_by_phandle_args(np, "nuvoton,sysgcr",
    73								  3, args);
    74		if (!IS_ERR(gcr_regmap))
    75			regmap_update_bits(gcr_regmap, args[0], args[1], args[2]);
    76	
    77		plat_ci = ci_hdrc_add_device(dev, pdev->resource, pdev->num_resources,
    78					     &ci->pdata);
    79		if (IS_ERR(plat_ci)) {
    80			ret = PTR_ERR(plat_ci);
    81			dev_err(dev, "failed to register HDRC NPCM device: %d\n", ret);
    82			goto clk_err;
    83		}
    84	
    85		pm_runtime_no_callbacks(dev);
    86		pm_runtime_enable(dev);
    87	
    88		return 0;
    89	
    90	clk_err:
    91		clk_disable_unprepare(ci->core_clk);
    92		return ret;
    93	}
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
