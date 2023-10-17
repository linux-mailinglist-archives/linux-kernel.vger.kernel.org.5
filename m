Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536F67CCF82
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjJQVun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQVul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:50:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16482C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697579440; x=1729115440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hUOW2jdFFCD231zLnFnj1kgtb5ru8K9Mpcdi+Gs/Tzs=;
  b=do79ADritdICEsE/zrsj3/SJz+7ghQe/oKVJ1zlW9K614iB7fcK6dU9E
   1v6tKMecoPAVBoQlyiB3RtOCMcFPff0OYlaZ3+aL+nYFaYhWFq5z88OIe
   J8wDs5Z9aGfKVyyemp1LdOPpsxYiWuTXZmFzF1uOjDPwFyL0mf5tMO+uK
   c2m1OHS7ox2ZUKvIbvWvOa6ZgUFgIDXHqBVoc3cR8ieQwIgDHehTVmteB
   cL61F8pVFc3lARj9kDOmA3NnKX2GjpArwLrzCcA3whlEwEj8L3Z2L+ayv
   5noeuBghlJi/XWN+gLiOjIXBtB79I3hQdniHpSN3mjTWOm69T6WPX8eLM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="416985499"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="416985499"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="872757749"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="872757749"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2023 14:50:35 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsrxQ-000A7r-2K;
        Tue, 17 Oct 2023 21:50:32 +0000
Date:   Wed, 18 Oct 2023 05:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     dregan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 4/4] mtd: rawnand: brcmnand: exec_op implementation
Message-ID: <202310180553.Zfa2ryoa-lkp@intel.com>
References: <20231017201417.129872-4-dregan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017201417.129872-4-dregan@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dregan-broadcom-com/mtd-rawnand-NAND-controller-write-protect/20231018-042758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20231017201417.129872-4-dregan%40broadcom.com
patch subject: [PATCH v3 4/4] mtd: rawnand: brcmnand: exec_op implementation
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310180553.Zfa2ryoa-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310180553.Zfa2ryoa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180553.Zfa2ryoa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:2393:5: warning: no previous prototype for 'brcmnand_exec_op_is_status' [-Wmissing-prototypes]
    2393 | int brcmnand_exec_op_is_status(const struct nand_operation *op)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:2404:5: warning: no previous prototype for 'brcmnand_exec_op_is_reset' [-Wmissing-prototypes]
    2404 | int brcmnand_exec_op_is_reset(const struct nand_operation *op)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/brcmnand_exec_op_is_status +2393 drivers/mtd/nand/raw/brcmnand/brcmnand.c

  2392	
> 2393	int brcmnand_exec_op_is_status(const struct nand_operation *op)
  2394	{
  2395		if ((op->ninstrs == 2) &&
  2396			(op->instrs[0].type == NAND_OP_CMD_INSTR) &&
  2397			(op->instrs[0].ctx.cmd.opcode == NAND_CMD_STATUS) &&
  2398			(op->instrs[1].type == NAND_OP_DATA_IN_INSTR))
  2399			return 1;
  2400	
  2401		return 0;
  2402	}
  2403	
> 2404	int brcmnand_exec_op_is_reset(const struct nand_operation *op)
  2405	{
  2406		if ((op->ninstrs == 1) &&
  2407			(op->instrs[0].type == NAND_OP_CMD_INSTR) &&
  2408			(op->instrs[0].ctx.cmd.opcode == NAND_CMD_RESET))
  2409			return 1;
  2410	
  2411		return 0;
  2412	}
  2413	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
