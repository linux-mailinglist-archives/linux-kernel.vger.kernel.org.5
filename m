Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC63799F17
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjIJRdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 13:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIJRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 13:33:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15266136
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694367197; x=1725903197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FB8MLD92bLqFOc+7aRIg7tBy3DBOx6gOOOldjTh0c04=;
  b=U+Oik7DDJmy3jcWPRjLRqmrhbs+SyDwRleNGLvqroMTcKep/YjkbILFw
   l3HiNYmBmrYTiEiQroL+o84IJm/Edoe/h066F8zJVyegM5QMb9dUnSFDp
   ZUeuOzurzkkMbhpHRohUJGIAhr/uFWmltjlvpnvOinPd1gjNpZxhRGup9
   kxeoZS9micK3zvZHPKtBAmVnTbeh2Kb8sC1Tg+7NHxP29p5vikUZf3FoR
   LlCfitTxdJtiQ7wVbLc95oXSuhmCMwIvhpzmqSUoSivK/eTEiRhEQohgj
   K/1p7Rc6scAjjXeIBJocHFR94T+K14XPOmBIgYZyJY0kJDMg/vkTROXsn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="362957511"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="362957511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 10:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="772323069"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="772323069"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2023 10:33:15 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfOJ5-0005E3-07;
        Sun, 10 Sep 2023 17:33:11 +0000
Date:   Mon, 11 Sep 2023 01:32:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Feiyang Chen <chenfeiyang@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/config/loongarch/loongarch-opts.h:31:10:
 fatal error: loongarch-def.h: No such file or directory
Message-ID: <202309110109.rbZxQdD6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
commit: 2363088eba2ecccfb643725e4864af73c4226a04 LoongArch: Allow building with kcov coverage
date:   4 days ago
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230911/202309110109.rbZxQdD6-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309110109.rbZxQdD6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309110109.rbZxQdD6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/options.h:8,
                    from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/tm.h:46,
                    from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/backend.h:28,
                    from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/gcc-plugin.h:30,
                    from scripts/gcc-plugins/gcc-common.h:7,
                    from scripts/gcc-plugins/randomize_layout_plugin.c:19:
>> ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
      31 | #include "loongarch-def.h"
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   In file included from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/options.h:8,
                    from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/tm.h:46,
                    from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/backend.h:28,
                    from ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/gcc-plugin.h:30,
                    from scripts/gcc-plugins/gcc-common.h:7,
                    from scripts/gcc-plugins/latent_entropy_plugin.c:78:
>> ../lib/gcc/loongarch64-linux/13.2.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
      31 | #include "loongarch-def.h"
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   make[4]: *** [scripts/gcc-plugins/Makefile:54: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1
   make[4]: *** [scripts/gcc-plugins/Makefile:54: scripts/gcc-plugins/latent_entropy_plugin.so] Error 1
   make[4]: Target 'scripts/gcc-plugins/' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:480: scripts/gcc-plugins] Error 2
   make[3]: Target 'scripts/' not remade because of errors.
   make[2]: *** [Makefile:1271: scripts] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
