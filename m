Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580417FE3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjK2XJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2XJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:09:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8264D5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701299357; x=1732835357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V3ZHtAuBMJXcumuJYLR+WlNL21Y7FcB5LJcbySuNdRU=;
  b=GRxSntLfiAiV4erUqeMkE2RfpvMN49BtZSOzr3wjXNbrBeWtYsmQb3An
   fxoGzyG8lFJuqiZLEevoVxZzAMSMl8qxUB4vC9tJIaHSGjvkZfoObSLjt
   BYmdmHAX6Qpp1ANxo4GhGM1nyKdPHn3jXHIFPQt1Pg4fJXgUCHdHB22WC
   a2S5WhfYIeyqIMdQKQ2/eA0wrwzqbPcC2bFJXpckksjTaTH+jcevzX34m
   8yd+b1rN9zrWBg+EZsiJHWBhPznEH+mz84EoShyJ5iUTTbLhvLoXoT0Zg
   NkoJMS3IPW9i7I/te4TZwyzZER3txHL5Pw66eqwF6zPA7nrUXxEmOT74U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="378266056"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="378266056"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="718897392"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="718897392"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2023 15:09:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Tg9-00013l-1q;
        Wed, 29 Nov 2023 23:09:13 +0000
Date:   Thu, 30 Nov 2023 07:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>
Subject: arch/loongarch/kernel/relocate.c:166:38: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202311300328.yckncyn0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: e5f02b51fa0cb785e352e77271a65e96051b789b LoongArch: Add support for kernel address space layout randomization (KASLR)
date:   9 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20231130/202311300328.yckncyn0-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231130/202311300328.yckncyn0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300328.yckncyn0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/relocate.c:166:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *cmdline @@     got void [noderef] __iomem * @@
   arch/loongarch/kernel/relocate.c:166:38: sparse:     expected char *cmdline
   arch/loongarch/kernel/relocate.c:166:38: sparse:     got void [noderef] __iomem *

vim +166 arch/loongarch/kernel/relocate.c

   159	
   160	void * __init relocate_kernel(void)
   161	{
   162		unsigned long kernel_length;
   163		unsigned long random_offset = 0;
   164		void *location_new = _text; /* Default to original kernel start */
   165		void *kernel_entry = start_kernel; /* Default to original kernel entry point */
 > 166		char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
   167	
   168		strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
   169	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
