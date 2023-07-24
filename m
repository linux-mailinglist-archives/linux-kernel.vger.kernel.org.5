Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC38775EBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGXGhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGXGhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:37:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E231713
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690180641; x=1721716641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLXxeOJhmgMtiKhZdKzMeA29Pw6z5lzHICvjZqSFmm0=;
  b=UY2fK9DWoxigBgMpk/nPtzIjgtkALbgksBzheDh9EVdetxH+b0sgiP+P
   h/rzl/zBVGG/I7qJt/xH4JWZ2mibUdi9m+FMORtcxp/NQwwjL2F7pnrhJ
   nLQcBwO34lYcenEc0suzgPucHS45FNFwPbUoXSwWlF4zYyAJAiUgAX7Ii
   Bunsh7F74Y5LojhanYf+utwKe1ypkcWZky5p4Q3MXvxKoNEMYG8z8z81a
   A0mOf2Kq6rGa8zWJhWKQjlr7Utra1Pr2W76ipccaYrc679LhkeEVgw979
   oQeUgSan98pPkmxJ10vMRBLLE+RucndUbdcLRHycFj1hB26JiPXIvru3W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="453738286"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="453738286"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 23:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="728798987"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="728798987"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2023 23:34:53 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNp9a-0009Xs-2M;
        Mon, 24 Jul 2023 06:34:50 +0000
Date:   Mon, 24 Jul 2023 14:34:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 6/8] firmware: imx: scu-irq: export
 imx_scu_irq_get_status
Message-ID: <202307241442.nX6M25Pa-lkp@intel.com>
References: <20230724014711.2048958-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724014711.2048958-7-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on linus/master v6.5-rc3 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/firmware-imx-scu-change-init-level-to-subsys_initcall_sync/20230724-101304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230724014711.2048958-7-peng.fan%40oss.nxp.com
patch subject: [PATCH V3 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230724/202307241442.nX6M25Pa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241442.nX6M25Pa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307241442.nX6M25Pa-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/net/ethernet/freescale/fec_ptp.o: in function `imx_scu_irq_get_status':
>> fec_ptp.c:(.text+0xc2c): multiple definition of `imx_scu_irq_get_status'; drivers/net/ethernet/freescale/fec_main.o:fec_main.c:(.text+0x6894): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
