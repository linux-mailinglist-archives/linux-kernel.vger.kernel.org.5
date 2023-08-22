Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97732783A39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjHVG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHVG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:58:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFACD1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692687492; x=1724223492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RMaS4lwusmnSs26t2W4YnZ3t6eWsj5F0ImCy7RiNZus=;
  b=nsvK9xR5XovubC42cEFt/gObK+f0b/Cr4UCVWbzKREHcHqxVTtT/5Rpf
   9A0az9bid3QGm0XpIxdxT6JnocqSXb5Ty1KGrQ2Ni+AiRBhAGvE4AXnSv
   CmI96P1VG8anXaN/Y+e3oNpOOTY5Ih9AwHFbjrifAjFh6rwb8edOXIjAe
   RYTBEC4wXZcSaBFDLM0cP7j3CXGuptCyNBph0nCrfhsPdY1hAqCwPtriK
   wsXUS2ykU1WWx/KPfr++IK+7BvyoI7RFrX0D3rS+cHtwdFX9mcLlOKNk1
   JCpTAOW+fcOvMB3lpqQ0/iAbYuUnfHJSu/ZXKqAMyZ3gE4N7M5vph2bq1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377551662"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="377551662"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 23:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739191495"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="739191495"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2023 23:58:10 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYLL8-0001U0-03;
        Tue, 22 Aug 2023 06:58:10 +0000
Date:   Tue, 22 Aug 2023 14:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: ../lib/gcc/s390-linux/13.2.0/plugin/include/c-family/c-common.h:173:10:
 fatal error: cp/cp-trait.def: No such file or directory
Message-ID: <202308221428.oHlOPjpr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: 1e860048c53ee77ee9870dcce94847a28544b753 gcc-plugins: simplify GCC plugin-dev capability test
date:   2 years, 9 months ago
config: s390-randconfig-r081-20230822 (https://download.01.org/0day-ci/archive/20230822/202308221428.oHlOPjpr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221428.oHlOPjpr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221428.oHlOPjpr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from /usr/include/c++/12/initializer_list:36,
                    from ../lib/gcc/s390-linux/13.2.0/plugin/include/system.h:242,
                    from ../lib/gcc/s390-linux/13.2.0/plugin/include/gcc-plugin.h:28,
                    from scripts/gcc-plugins/gcc-common.h:7,
                    from scripts/gcc-plugins/randomize_layout_plugin.c:19:
   /usr/include/c++/12/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
      32 | #error This file requires compiler and library support \
         |  ^~~~~
   In file included from scripts/gcc-plugins/gcc-common.h:60:
>> ../lib/gcc/s390-linux/13.2.0/plugin/include/c-family/c-common.h:173:10: fatal error: cp/cp-trait.def: No such file or directory
     173 | #include "cp/cp-trait.def"
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/gcc-plugins/Makefile:47: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:500: scripts/gcc-plugins] Error 2
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1182: scripts] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
