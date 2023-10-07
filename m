Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B07BC42E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjJGC2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJGC2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:28:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDDDBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696645723; x=1728181723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I0fEPOGEGcnYFhc7OhH7/ZGXqdQAjYJoJV0W9uy3BY0=;
  b=CCnzKyvf8UZk3bFT9jq1y206QJQf+njma/+N7ywlOWTRvADysne8vHkA
   3na23nDcgyMgYRlJOXnibI8UM3CZNaHZaqn3JOUk/J0+oKiWXb3cKk9G+
   HwoXsCqg07vGs6KULYX1TCKqmhHQUzYV855mGhD+wYTBQFd0fksDG/6Uj
   BOJG3wxPyW31/O98KXk/NRSEP3KBHMJ4s1Yd8MjTfAZ3EHlG/5MFSP5jQ
   1CSWcuuYOA0LjdAKNDBxhyeqbV8axgjPGTJoMfV5mNubfBG8bk61G1aMK
   riKQ8nTN9V8L2I67sgaJQtk8Eb1KNEDJDyWDgNpSsWhqQdmhMFG70F5ag
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387754397"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387754397"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 19:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="822716198"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="822716198"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2023 19:28:41 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qox3W-0003rf-36;
        Sat, 07 Oct 2023 02:28:38 +0000
Date:   Sat, 7 Oct 2023 10:27:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype
 for 'arch_ftrace_ops_list_func'
Message-ID: <202310071027.0aAVx4iY-lkp@intel.com>
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

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   82714078aee4ccbd6ee7579d5a21f8a72155d0fb
commit: 17b251a290ba84a0c2c5c82df9596cb2e7207ca6 ftrace/sh: Add arch_ftrace_ops_list_func stub to have compressed image still link
date:   1 year, 11 months ago
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20231007/202310071027.0aAVx4iY-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071027.0aAVx4iY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310071027.0aAVx4iY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/sh/boot/compressed/misc.c:109:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
     109 | void __stack_chk_fail(void)
         |      ^~~~~~~~~~~~~~~~
   arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
     115 | void ftrace_stub(void)
         |      ^~~~~~~~~~~
>> arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]
     118 | void arch_ftrace_ops_list_func(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
     128 | void decompress_kernel(void)
         |      ^~~~~~~~~~~~~~~~~


vim +/arch_ftrace_ops_list_func +118 arch/sh/boot/compressed/misc.c

   113	
   114	/* Needed because vmlinux.lds.h references this */
   115	void ftrace_stub(void)
   116	{
   117	}
 > 118	void arch_ftrace_ops_list_func(void)
   119	{
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
