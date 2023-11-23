Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00C67F5637
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbjKWBzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjKWBzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:55:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658A410CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700704518; x=1732240518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lSkx3y0J9n5U+7y7kgBjxoaHDhGYZgqDu/5TrNRxgSM=;
  b=QatzWfok3k+pYwo3Iy7bg58E8ZDcNLZtfNFf0LIjFkSHxZnbKGYctDDk
   ZCO6P5AjMJT1MjlVptD3pw7at3OfVcDddqSZlh/sCp8NHv3wDPc+PJvoW
   ly+GrVXNz6d//bXG7KVguLPyq7SVofSyDNEuz7UHpoSA8ykzqpl+/LhjF
   NuZUkC0pvGn6L0PnQ7T3n2XJT5Wu+uSn4viUqGEhsKSuCJf1uY4wJQO5h
   iXJWmfUs0cPaZZ5XiOQq0btasDZQNtxNA/LwfVAE2rUsa1N8qlhkx79Ak
   Ldj6dhOAurg55whQOTiFVt1df3O9DyDugWYVsypHCqZTTqY/CqLVBk9BB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13737194"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13737194"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:55:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="801909599"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="801909599"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2023 17:55:14 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5yvv-00016S-2p;
        Thu, 23 Nov 2023 01:55:11 +0000
Date:   Thu, 23 Nov 2023 09:54:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 1/3] riscv: Add support for kernel-mode FPU
Message-ID: <202311230628.TkL31MjJ-lkp@intel.com>
References: <20231122030621.3759313-2-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122030621.3759313-2-samuel.holland@sifive.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/riscv-Add-support-for-kernel-mode-FPU/20231122-111015
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231122030621.3759313-2-samuel.holland%40sifive.com
patch subject: [PATCH 1/3] riscv: Add support for kernel-mode FPU
config: riscv-randconfig-r111-20231123 (https://download.01.org/0day-ci/archive/20231123/202311230628.TkL31MjJ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231123/202311230628.TkL31MjJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230628.TkL31MjJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/riscv/kernel/process.c:10:
>> arch/riscv/kernel/process.c:229:19: error: '__fstate_save' undeclared here (not in a function); did you mean 'fstate_save'?
     229 | EXPORT_SYMBOL_GPL(__fstate_save);
         |                   ^~~~~~~~~~~~~
   include/linux/export.h:74:23: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                       ^~~
   include/linux/export.h:87:41: note: in expansion of macro '_EXPORT_SYMBOL'
      87 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   arch/riscv/kernel/process.c:229:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     229 | EXPORT_SYMBOL_GPL(__fstate_save);
         | ^~~~~~~~~~~~~~~~~
>> arch/riscv/kernel/process.c:230:19: error: '__fstate_restore' undeclared here (not in a function); did you mean 'fstate_restore'?
     230 | EXPORT_SYMBOL_GPL(__fstate_restore);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:74:23: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                       ^~~
   include/linux/export.h:87:41: note: in expansion of macro '_EXPORT_SYMBOL'
      87 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   arch/riscv/kernel/process.c:230:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     230 | EXPORT_SYMBOL_GPL(__fstate_restore);
         | ^~~~~~~~~~~~~~~~~


vim +229 arch/riscv/kernel/process.c

   228	
 > 229	EXPORT_SYMBOL_GPL(__fstate_save);
 > 230	EXPORT_SYMBOL_GPL(__fstate_restore);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
