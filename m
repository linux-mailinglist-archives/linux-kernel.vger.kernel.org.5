Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B34C7748AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjHHTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbjHHTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:36:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F235C46
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691521321; x=1723057321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iLFd+7cxyeMLAlDRRNPoe+P4AiJgeuTOnpdI54muwbQ=;
  b=jPJuFJTh4PHiScjxQEjlrDnEPRCF2xdkG0sZu/PdnRg+1We35zP5vU3J
   dNYvWWy8F32TqCgzywdT9rVJ+sUDOPMcCcSqkqhkixHQr4iflxyVL80gs
   ypyugdeJFVi5Gg7O6aWg25Rme0rMuJeFayKLj4EPixpnsnTbdeKGyuPoD
   mzKsAcTbGxMisNlcQS0beUcoAfmz0VSBJpRFNQfqAIJU0VcPu0Jpp8998
   5jzGhFZLZPi9xpIW0EgljtYLDV6djzEj+2wv4r8L5OfLnjDvX/ZC710t/
   iGiWjIuwqEkgdMLng2W5C0DjJ+Nj/PTFhOxpK0INRTpQFzrLTgnNU1Bxz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374634225"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="374634225"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 11:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681370078"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="681370078"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 11:45:08 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTRhb-0005Xk-1U;
        Tue, 08 Aug 2023 18:45:07 +0000
Date:   Wed, 9 Aug 2023 02:44:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: error: A dwo section may not contain relocations
Message-ID: <202308090204.9yZffBWo-lkp@intel.com>
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
head:   02aee814d37c563e24b73bcd0f9cb608fbd403d4
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   1 year, 5 months ago
config: riscv-randconfig-r001-20230808 (https://download.01.org/0day-ci/archive/20230809/202308090204.9yZffBWo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230809/202308090204.9yZffBWo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308090204.9yZffBWo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:288: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1 shuffle=3686795728
   make[2]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[1]: *** [arch/riscv/Makefile:120: vdso_prepare] Error 2 shuffle=3686795728
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2 shuffle=3686795728
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
