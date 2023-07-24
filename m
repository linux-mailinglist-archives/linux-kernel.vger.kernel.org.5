Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45C75EA43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGXDtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGXDtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:49:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF883
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690170571; x=1721706571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YMpA4l7y+ePdnJdeAAV9jQFDyhu3sQCKQd1wgr3p9dU=;
  b=Z9+jqsEVq7Q+hePV8354tB4+IopKCNGLTjMi3b9ndkuVtDmU5ZAGsk2I
   HskMJjBSNSayPhagoiLrQu4Rl5+eEIIR/qeUzd2Xy3A4Pfs0f0Kn3TfUN
   ouxHMqVqMO7zs2BkWFywgizPqL1Kgoz+FMRBEo1ynMRgiouPB9QI7hBzc
   cqrcL9ME2CWNNFDC7gnmWE12DHgYDPqdxPtTRd4eiQqWey8M2NxY9x8zG
   Ogh/xv+OSyJwQ3H6c3oH34mFY4cklswocAqmK3sUDofL61Y6xjYUz/+cp
   lX8e13320ON+gsRXsMC9ZcUgonfaNcLREMZrm7cBAIad7QlP+T7/v3hpl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364799102"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364799102"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 20:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760629386"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760629386"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2023 20:49:27 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNmZb-0009T5-0p;
        Mon, 24 Jul 2023 03:49:27 +0000
Date:   Mon, 24 Jul 2023 11:48:23 +0800
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
Message-ID: <202307241130.Ay2R8Hnf-lkp@intel.com>
References: <20230724014711.2048958-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724014711.2048958-7-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v6.5-rc3 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/firmware-imx-scu-change-init-level-to-subsys_initcall_sync/20230724-101304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230724014711.2048958-7-peng.fan%40oss.nxp.com
patch subject: [PATCH V3 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
config: csky-randconfig-r011-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241130.Ay2R8Hnf-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241130.Ay2R8Hnf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307241130.Ay2R8Hnf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/can/flexcan/flexcan-core.c:19:
>> include/linux/firmware/imx/sci.h:52:5: warning: no previous prototype for 'imx_scu_irq_get_status' [-Wmissing-prototypes]
      52 | int imx_scu_irq_get_status(u8 group, u32 *irq_status)
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/imx_scu_irq_get_status +52 include/linux/firmware/imx/sci.h

    51	
  > 52	int imx_scu_irq_get_status(u8 group, u32 *irq_status)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
