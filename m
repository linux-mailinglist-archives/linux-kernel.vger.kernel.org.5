Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9875B255
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGTPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGTPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:20:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E313E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689866412; x=1721402412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcBoW3id5q3UkNlTPjSxSmIt/VF8C+QBefJ79dtJL/8=;
  b=bcUtwVaqfyVpvT5gENWmQmGareqPEKvlGVNg/lU4T+YNMIRXH2HimK8M
   IFIJIQKbgywgn+PH7gDmsV1eX/O+gdvi5nVlVoQs0lBWrmA8ORwYIapqO
   CChUBbGq4y987oMH4N8KAuAoksdjUYJE5VkxZYik7CfqxTRc7rX0kk+Od
   APv25yuYqe0/oqn4y36iXhI9cRKfnpbLWXCl1OJhY2eb3Lbz667sJCO8I
   oiyFeU/P7OKe7X1dtnO01icEKfzmhrpkBwQjuRWC+qEIfJ1YZH1b0neyH
   NV20fI9ifLAYVxXb4Adqt118wAHGjzKBIcRFcGP6IvhVpqQr2oSiUOMPO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370361987"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="370361987"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 08:20:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814574849"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="814574849"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2023 08:20:08 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMVRo-0006Be-10;
        Thu, 20 Jul 2023 15:20:08 +0000
Date:   Thu, 20 Jul 2023 23:19:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
Message-ID: <202307202344.hFyQjqgq-lkp@intel.com>
References: <20230720094128.536388-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720094128.536388-7-peng.fan@oss.nxp.com>
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
[also build test ERROR on linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/firmware-imx-scu-change-init-level-to-subsys_initcall_sync/20230720-174508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230720094128.536388-7-peng.fan%40oss.nxp.com
patch subject: [PATCH 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
config: loongarch-randconfig-r033-20230720 (https://download.01.org/0day-ci/archive/20230720/202307202344.hFyQjqgq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307202344.hFyQjqgq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307202344.hFyQjqgq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/can/flexcan/flexcan-core.c:19:
>> include/linux/firmware/imx/sci.h:53:1: error: expected identifier or '(' before '{' token
      53 | {
         | ^


vim +53 include/linux/firmware/imx/sci.h

    51	
    52	int imx_scu_irq_get_status(u8 group, u32 *irq_status);
  > 53	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
